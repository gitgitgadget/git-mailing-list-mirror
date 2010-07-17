From: Johan Herland <johan@herland.net>
Subject: Re: Git Fetch / updating HEAD
Date: Sat, 17 Jul 2010 18:11:13 +0200
Message-ID: <201007171811.13624.johan@herland.net>
References: <AANLkTinuK4gx9SG1VKo_NbkP_QWMCmtsfJgUgfoL_KGo@mail.gmail.com>
 <AANLkTilp5lZn99QZPWSkCHStnRdkGx6mMU2IQBvllaU4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 17 18:11:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oa9z8-0006lh-SL
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 18:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756232Ab0GQQLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jul 2010 12:11:17 -0400
Received: from smtp.getmail.no ([84.208.15.66]:48800 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756199Ab0GQQLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 12:11:16 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5P00606MAQMC70@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 17 Jul 2010 18:11:14 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 4EF781EA583B_C41D622B	for <git@vger.kernel.org>; Sat,
 17 Jul 2010 16:11:14 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 363F01EA3CEB_C41D622F	for <git@vger.kernel.org>; Sat,
 17 Jul 2010 16:11:14 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5P00NY4MAQ1W10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 17 Jul 2010 18:11:14 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-ARCH; KDE/4.4.5; x86_64; ; )
In-reply-to: <AANLkTilp5lZn99QZPWSkCHStnRdkGx6mMU2IQBvllaU4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151190>

On Saturday 17 July 2010, Mahesh Vaidya wrote:
> BTW - I have tried this
> git  update-ref HEAD  FETCH_HEAD; is this ok ??
> 
> On Sat, Jul 17, 2010 at 9:02 PM, Mahesh Vaidya <forvaidya@gmail.com> 
wrote:
> > Hi,
> > 
> > git fetch --all --append updates FETCH_HEAD. I'd like this command to
> > update HEAD as well; is there any flag ?
> > 
> > I have a reason to do it; trying to implement multisite
> > 
> > A (master) -> B (readonly mirror) -> C (workspace)
> > 
> > if sitting in B; git fetch does't update HEAD

You need to set up special refspecs in your B repo, so that git fetch 
updates refs/heads/* instead of refs/remotes/origin/*. When that is done, a 
simple 'git fetch' will update your branches (and HEAD as a result).

In short, you should create the B repo using 'git clone --mirror' (which 
will set up the correct refspecs for you)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
