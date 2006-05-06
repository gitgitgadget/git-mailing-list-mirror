From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fmt-patch: understand old <his> notation
Date: Sat, 6 May 2006 15:30:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605061527030.16343@g5.osdl.org>
References: <Pine.LNX.4.63.0605062252530.4155@wbgn013.biozentrum.uni-wuerzburg.de>
 <7viroirfur.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 00:30:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcVIW-0001zQ-Mz
	for gcvg-git@gmane.org; Sun, 07 May 2006 00:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWEFWaq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 18:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWEFWaq
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 18:30:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:897 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932090AbWEFWap (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 18:30:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k46MUdtH031361
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 6 May 2006 15:30:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k46MUcNS007779;
	Sat, 6 May 2006 15:30:39 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7viroirfur.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19678>



On Sat, 6 May 2006, Junio C Hamano wrote:
> 
> While this would be easier on _my_ fingers as well, I have a
> suspicion that it might make more sense to make this "single
> ref" case to mean "HEAD~5^..HEAD~5" (if we _were_ designing a
> new command that is called format-patch today, that would be
> more natural).

Careful, that "X^..X" thing does entirely the wrong thing for merges. Not 
what you want at all, I think.

> But probably it is too late to break it by now.

Maybe not. I've actually cursed the fact that I made "git diff X" mean 
"diff from X to current working tree", because it almost never makes any 
sense at all when X is anything but "HEAD".

I probably _should_ have made "git diff X" mean basically "git show X", 
and not what it means now.

Oh, well.

			Linus
