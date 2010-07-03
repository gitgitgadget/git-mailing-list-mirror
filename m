From: Johan Herland <johan@herland.net>
Subject: Re: how do I exclude a commit from set of commits to be pushed.
Date: Sat, 03 Jul 2010 22:39:44 +0200
Message-ID: <201007032239.44639.johan@herland.net>
References: <AANLkTiko8joz_a94QwHwdDwlsjXslu8LdWAnJuvShFFI@mail.gmail.com>
 <201007031804.33350.johan@herland.net>
 <AANLkTimmCdCn1dkbogdVqzPBMeGQDNEesM8zdarFL_wv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 22:40:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OV9Vy-0001Ip-OH
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 22:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab0GCUjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 16:39:47 -0400
Received: from smtp.getmail.no ([84.208.15.66]:44309 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754303Ab0GCUjq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 16:39:46 -0400
Received: from get-mta-scan03.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5000KY61E9QG60@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 03 Jul 2010 22:39:45 +0200 (MEST)
Received: from get-mta-scan03.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 85ADC1EEF427_C2FA011B	for <git@vger.kernel.org>; Sat,
 03 Jul 2010 20:39:45 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan03.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 1C9321EEC897_C2FA011F	for <git@vger.kernel.org>; Sat,
 03 Jul 2010 20:39:45 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5000FW61E88430@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 03 Jul 2010 22:39:45 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-ARCH; KDE/4.4.5; x86_64; ; )
In-reply-to: <AANLkTimmCdCn1dkbogdVqzPBMeGQDNEesM8zdarFL_wv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150201>

On Saturday 03 July 2010, Mahesh Vaidya wrote:
> Thank for the pointer; Do you think following scriptlet is good for
> modifying specific commit ? and do edit.
> 
> cat ./modify_specific.sh
> git rebase -i $1 && git commit --amend && git rebase --continue

You would need to do "$1^" instead of $1, since 'rebase' works on all 
commits _since_ the given commit (i.e. not including the given commit). You 
will also have to change the first line of the rebase "script" that is 
opened in your editor (from "pick <sha1> to "edit <sha1>").


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
