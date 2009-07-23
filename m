From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Wed, 22 Jul 2009 17:55:51 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907221753290.3352@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <alpine.LFD.2.01.0907221742010.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 02:56:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTmbc-0008Nc-Df
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 02:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbZGWA4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 20:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbZGWA4N
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 20:56:13 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32814 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751018AbZGWA4M (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 20:56:12 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N0tpWT024178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Jul 2009 17:55:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N0tpOS001509;
	Wed, 22 Jul 2009 17:55:51 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907221742010.3352@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.461 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123817>



On Wed, 22 Jul 2009, Linus Torvalds wrote:
> 
> If you have ext3, you'd do something like
> 
> 	tune2fs -O dir_index /dev/<node-of-your-filesystem-goes-here>

One last email note on this subject. Really. Promise.

If you do that "tune2fs -O dir_index" thing, it will only take effect for 
_newly_ created directories. So you'll still need to do that whole 
"mv+cp+rm" dance, just to make sure that the refs directories are all new.

I think you can also force all directories to be indexed by using fsck, 
but I forget the details. I'm sure man-pages will have it. Or google.

		Linus
