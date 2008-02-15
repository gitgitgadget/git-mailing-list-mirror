From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: another git rebase -i problem
Date: Fri, 15 Feb 2008 10:21:35 +0100
Message-ID: <20080215092135.GB12091@digi.com>
References: <20080214093730.GA20408@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 10:22:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPwlw-0006Uy-IP
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 10:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593AbYBOJVp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Feb 2008 04:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754469AbYBOJVn
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 04:21:43 -0500
Received: from mail164.messagelabs.com ([216.82.253.131]:59903 "HELO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751725AbYBOJVk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 04:21:40 -0500
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-8.tower-164.messagelabs.com!1203067298!9148014!1
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.21]
Received: (qmail 8997 invoked from network); 15 Feb 2008 09:21:38 -0000
Received: from unknown (HELO owa.digi.com) (66.77.174.21)
  by server-8.tower-164.messagelabs.com with SMTP; 15 Feb 2008 09:21:38 -0000
Received: from mtk-sms-mail01.digi.com ([10.10.8.120]) by owa.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 15 Feb 2008 03:21:38 -0600
Received: from dor-sms-mail1.digi.com ([10.49.1.105]) by mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 15 Feb 2008 03:21:37 -0600
Received: from zentaur.digi.com ([10.100.10.144]) by dor-sms-mail1.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 15 Feb 2008 10:21:35 +0100
Received: by zentaur.digi.com (Postfix, from userid 1080)
	id 7119E1B27B; Fri, 15 Feb 2008 10:21:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080214093730.GA20408@digi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 15 Feb 2008 09:21:35.0663 (UTC) FILETIME=[293BA3F0:01C86FB4]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.000.1023-15730.003
X-TM-AS-Result: No--9.901300-8.000000-2
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73945>

Hello (Dscho),

> And moreover I have a more complicated history here with git rebase
> failing but I think this here is not my problem :-(
I currently have no time to have a deeper look into that either, but
here comes the more complicated case, just for the record:

	ukleinek@zentaur:~/gsrc/linux-2.6$ git rev-parse HEAD
	57db5b05c27d8c6d66264251ee1124c762aee659

	ukleinek@zentaur:~/gsrc/linux-2.6$ git rev-parse linus/master
	4ee29f6a52158cea526b16a44ae38643946103ec

	ukleinek@zentaur:~/gsrc/linux-2.6$ git status
	# On branch master
	nothing to commit (working directory clean)

	ukleinek@zentaur:~/gsrc/linux-2.6$ git rebase -i -p linus/master
	...
	(squash 57db5b0 onto d528ae7)
	...
	(write commit log for d528ae7+57db5b0)
	...
	Successfully rebased and updated refs/heads/master.

	ukleinek@zentaur:~/gsrc/linux-2.6$ git status
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#       modified:   Documentation/00-INDEX
	#       new file:   Documentation/cpuidle/core.txt
	#       new file:   Documentation/cpuidle/driver.txt
	#       new file:   Documentation/cpuidle/governor.txt
	#       new file:   Documentation/cpuidle/sysfs.txt
	#       modified:   MAINTAINERS
	#       modified:   arch/alpha/kernel/osf_sys.c
	#       modified:   arch/arm/mach-ns9xxx/Kconfig
	#       modified:   arch/arm/mach-ns9xxx/Makefile
	#       deleted:    arch/arm/mach-ns9xxx/plat-leds-gpio.c
	#       modified:   arch/blackfin/kernel/traps.c
	#       modified:   arch/cris/arch-v10/lib/memset.c
	#       modified:   arch/cris/arch-v32/lib/memset.c
	#       modified:   arch/m68knommu/platform/5206/Makefile
	#       modified:   arch/m68knommu/platform/5206e/Makefile
	#       modified:   arch/m68knommu/platform/520x/Makefile
	#       modified:   arch/m68knommu/platform/523x/Makefile
	#       modified:   arch/m68knommu/platform/5249/Makefile
	#       modified:   arch/m68knommu/platform/5272/Makefile
	#       modified:   arch/m68knommu/platform/527x/Makefile
	#       modified:   arch/m68knommu/platform/528x/Makefile
	#       modified:   arch/m68knommu/platform/5307/Makefile
	#       modified:   arch/m68knommu/platform/532x/Makefile
	#       modified:   arch/m68knommu/platform/5407/Makefile
	#       modified:   arch/m68knommu/platform/coldfire/Makefile
	#       modified:   arch/m68knommu/platform/coldfire/entry.S
	#       modified:   arch/m68knommu/platform/coldfire/timers.c
	...

	ukleinek@zentaur:~/gsrc/linux-2.6$ git show
	commit 57db5b05c27d8c6d66264251ee1124c762aee659
	...

I tracked the problem down to NEWHEAD being wrong.  The update-ref
before warn "Successfully rebased and updated $HEADNAME." has
NEWHEAD=3DOLDHEAD because
=2Egit/.dotest-merge/rewritten/57db5b05c27d8c6d66264251ee1124c762aee659
contains 57db5b05c27d8c6d66264251ee1124c762aee659 itself.

If you want to experiment with that, you can get
57db5b05c27d8c6d66264251ee1124c762aee659 from the bundle at

	http://www.modarm9.com/~ukleinek/57db5b05c2

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisa=
ch, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 1=
3962
