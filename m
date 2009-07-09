From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Too many 'stat' calls by git-status on Windows
Date: Wed, 8 Jul 2009 19:35:51 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 04:36:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOjUd-0003aQ-4q
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 04:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758134AbZGICgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 22:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758100AbZGICgG
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 22:36:06 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38238 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757806AbZGICgF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2009 22:36:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n692ZpsZ023901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 8 Jul 2009 19:35:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n692ZpSg032225;
	Wed, 8 Jul 2009 19:35:51 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.466 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122930>



On Wed, 8 Jul 2009, Linus Torvalds wrote:
> 
> Hmm. Sure. Something like this?

Ok, so having done some testing on it, it seems to work.

And we might as well clean up some of dir.c at the same time. I'll reply 
to this email with a series of three patches: two cleanup ones, and then a 
new version of this one (I hated how it looked to have those duplicated 
"baselen+len" things in read_directory_recursive()).

		Linus
