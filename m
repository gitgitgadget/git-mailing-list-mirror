From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH 2/3] Use File::Find rather than find and xargs in git-archimport
Date: Fri, 10 Feb 2006 16:17:00 -0800
Message-ID: <1939.1139617020@lotus.CS.Berkeley.EDU>
References: <86k6c2ojx6.fsf@blue.stonehenge.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 01:17:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7iRp-0006Ub-Kc
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 01:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWBKARE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 19:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWBKARE
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 19:17:04 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:26787 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932266AbWBKARD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 19:17:03 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k1B0H1xZ001941;
	Fri, 10 Feb 2006 16:17:01 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k1B0H1Kn001940;
	Fri, 10 Feb 2006 16:17:01 -0800 (PST)
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-reply-to: <86k6c2ojx6.fsf@blue.stonehenge.com> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15907>

And Randal L. Schwartz writes:
 - Jason> +	if (-f && !-z && /^.*\.patch$/ && !/{arch}/) {
 - 
 - If that works, it's only accidentally.

Thanks!  Not only is the regex wrong, it's applied to the 
wrong quantity.  Should be on $File::Find::dir.  Looks like 
the repos I tested against didn't have any Arch state 
patches.

I'll fix this, test it on a nastier set of repos, and re-
send.  It'll be an hour or so, at least.

Jason
