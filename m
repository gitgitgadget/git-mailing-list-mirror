From: Stephen Bash <bash@genarts.com>
Subject: Effectively navigating branch history (was: Re: [PATCH] config.c:
 Remove unused git_config_global() function)
Date: Tue, 31 May 2011 14:21:24 -0400 (EDT)
Message-ID: <18203023.45200.1306866084905.JavaMail.root@mail.hq.genarts.com>
References: <7vy61miws5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 31 20:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRTZT-0003as-38
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 20:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213Ab1EaSVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 14:21:33 -0400
Received: from hq.genarts.com ([173.9.65.1]:44286 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932108Ab1EaSVc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 14:21:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 6C192EA2306;
	Tue, 31 May 2011 14:21:31 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4KlalFxTsFCx; Tue, 31 May 2011 14:21:25 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 122CEEA2302;
	Tue, 31 May 2011 14:21:25 -0400 (EDT)
In-Reply-To: <7vy61miws5.fsf@alter.siamese.dyndns.org>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174818>

----- Original Message -----
> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Tuesday, May 31, 2011 1:51:06 PM
> Subject: Re: [PATCH] config.c: Remove unused git_config_global() function
> 
> > Commit 8f323c00 (drop support for GIT_CONFIG_NOGLOBAL, 15-03-2011)
> > removed the git_config_global() function, among other things, since
> > it is no longer required. Unfortunately, this function has since
> > been unintentionally restored; I suspect by merge commit 25b86e45
> > (Merge branch 'jk/maint-config-alias-fix' into next, 25-05-2011).
> 
> Yeah, I think it was 1f9a980636 which was a merge between fb674d7 and
> 73546c0. I just compared the output between these two:
> 
> $ git diff fb674d7...73546c0 -- config.c ;# what the topic did
> $ git diff fb674d7 1f9a980 -- config.c ;# what was merged

Junio - I'd like to take a chance to learn from a master here if you don't mind.  I often find myself wanting to do the "what the topic did" operation but once the branch is merged and deleted, I have difficulty finding useful SHAs to diff.

So in an attempt to educate myself, I tried to track down fb674d7 and 1f9a980 (and failed miserably).  I can easily find 8f323c00 using 'git log -S git_config_global', but conceptually I want to trace children of 8f323c00 to see where it merged, and that seems ... complicated.  Do you mind walking through your thought process on this problem?

Thanks!
Stephen
