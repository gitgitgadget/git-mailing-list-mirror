From: Johan Herland <johan@herland.net>
Subject: Re: how do I exclude a commit from set of commits to be pushed.
Date: Sat, 03 Jul 2010 18:04:32 +0200
Message-ID: <201007031804.33350.johan@herland.net>
References: <AANLkTiko8joz_a94QwHwdDwlsjXslu8LdWAnJuvShFFI@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 18:05:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OV5Df-0000m7-Jl
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 18:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867Ab0GCQEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 12:04:39 -0400
Received: from smtp.getmail.no ([84.208.15.66]:41728 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755742Ab0GCQEh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 12:04:37 -0400
Received: from get-mta-scan03.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4Z00EIBONN1040@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 03 Jul 2010 18:04:35 +0200 (MEST)
Received: from get-mta-scan03.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id F26EA1EEF38E_C2F5F92B	for <git@vger.kernel.org>; Sat,
 03 Jul 2010 16:04:34 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan03.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 8A6951EEC840_C2F5F92F	for <git@vger.kernel.org>; Sat,
 03 Jul 2010 16:04:34 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4Z00BI8ONMCI30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 03 Jul 2010 18:04:34 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-ARCH; KDE/4.4.5; x86_64; ; )
In-reply-to: <AANLkTiko8joz_a94QwHwdDwlsjXslu8LdWAnJuvShFFI@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150193>

On Saturday 03 July 2010, Mahesh Vaidya wrote:
> In the series of commits C1..C8 how do I exclude a commit to be pushed.
> 
> use case -
> I have commits say C1..C8 to be pushed. Due to my pre-receive hook
> commit C4 is complying with commit standard. I have amended C4 to C5 ;
> still C4 shows up in commits to be pushed list.
> 
> git reflog delete --rewrite and git gc --prune did not help
> 
> Thx/ Mahesh

You probably want to squash C5 into C4. Look up 'git rebase --interactive', 
and the 'squash' instruction. A good intro can be found at either 
http://book.git-scm.com/4_interactive_rebasing.html or 
http://progit.org/book/ch6-4.html

In general, it seems you have misunderstood the purpose of the reflog. The 
reflog only keeps track of where your HEAD has pointed previously, and what 
operations you have done. Rewriting the reflog does NOT change the actual 
commit, nor does it rewrite your commit history in any way. In other words, 
there is nothing you can do to the reflog that will affect what you push.

You may want to read the entire Pro Git book ( http://progit.org/book/ ) to 
get a firm grip on the Git object model.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
