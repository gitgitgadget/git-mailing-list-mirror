From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 'setup_work_tree()' considered harmful
Date: Wed, 18 Jun 2008 09:26:18 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806180924170.2907@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806161723081.2949@woody.linux-foundation.org> <20080618090527.GA24254@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jun 18 18:29:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K90Ww-0007EG-KW
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 18:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbYFRQ2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 12:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbYFRQ2K
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 12:28:10 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51803 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751873AbYFRQ2J (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 12:28:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5IGQKBb023916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jun 2008 09:26:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5IGQIAh010177;
	Wed, 18 Jun 2008 09:26:19 -0700
In-Reply-To: <20080618090527.GA24254@glandium.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.353 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85389>



On Wed, 18 Jun 2008, Mike Hommey wrote:
> 
> Maybe using openat, fstatat, etc. when they are available, could be a
> good thing, already, though it wouldn't help for other platforms.

I agree that openat() and friends would be nice for this (use a file 
descriptor instead of a string to point to object directories etc), but 
it's unportable enough that the pain of having to have two totally 
different access routines is just not worth it. It could be done, but it 
would need some really nifty abstraction layer.

We do already have _part_ of that abstraction layer with things like 
"git_path()" etc, but it would have to be extended upon quite a bit. 

		Linus
