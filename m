From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [BUG] bisecting miscounts revisions left to test
Date: Fri, 16 Mar 2007 17:14:21 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070316161421.GA24584@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 17:14:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSF4Y-00054s-KP
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 17:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965427AbXCPQO0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 16 Mar 2007 12:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965440AbXCPQO0
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 12:14:26 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:44910 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965427AbXCPQOZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Mar 2007 12:14:25 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HSF4R-0001as-TX
	for git@vger.kernel.org; Fri, 16 Mar 2007 17:14:24 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2GGELCK019255
	for <git@vger.kernel.org>; Fri, 16 Mar 2007 17:14:21 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2GGELDq019254
	for git@vger.kernel.org; Fri, 16 Mar 2007 17:14:21 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42370>

Hello,

I'm just bisecting in the kernel, the last commands + output are:

zeisberg@cassiopeia:~/gsrc/linux-2.6$ git bisect good
Bisecting: 2 revisions left to test after this
[e7b0d26a86943370c04d6833c6edba2a72a6e240] sysfs: reinstate exclusion b=
etween method calls and attribute unregistration

zeisberg@cassiopeia:~/gsrc/linux-2.6$ git bisect good
Bisecting: 2 revisions left to test after this
[b810cdfcf91d76f603fd48023aede48ced8e6bed] Merge branch 'upstream-linus=
' of master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6

So after having 2 revisions left to test and an addional test I still
have to test 2 revisions.

=46or reproducibility:

zeisberg@cassiopeia:~/gsrc/linux-2.6$ git bisect log
git-bisect start
# good: [08e15e81a40e3241ce93b4a43886f3abda184aa6] Linux 2.6.21-rc3
git-bisect good 08e15e81a40e3241ce93b4a43886f3abda184aa6
# bad: [bac6eefe96204d0ad67d144f2511a6fc487aa594] Linux 2.6.21-rc4
git-bisect bad bac6eefe96204d0ad67d144f2511a6fc487aa594
# good: [bdf3aaf9519ddd8a026b5e04e713d2fa673532e5] Pull bugzilla-8066 i=
nto release branch
git-bisect good bdf3aaf9519ddd8a026b5e04e713d2fa673532e5
# good: [2cb8a57b9851805883dfe92cf5d88a726134a384] Fix vmi time header =
bug
git-bisect good 2cb8a57b9851805883dfe92cf5d88a726134a384
# good: [a7c999114ecd0c69bd3970272b64d8842b765b21] BLK_DEV_IDE_CELLEB d=
ependency fix
git-bisect good a7c999114ecd0c69bd3970272b64d8842b765b21
# good: [0bdd0f385a44344f83409b9e00797bfe2596faf8] Merge master.kernel.=
org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog
git-bisect good 0bdd0f385a44344f83409b9e00797bfe2596faf8
# good: [6ab27c6bf38d5ff71dafeca77b79e7c284804b75] Merge branch 'for-li=
nus' of master.kernel.org:/pub/scm/linux/kernel/git/jikos/hid
git-bisect good 6ab27c6bf38d5ff71dafeca77b79e7c284804b75
# good: [069f8256362b7a17da532f0631cee73b4cfee65b] natsemi: Fix NAPI fo=
r interrupt sharing
git-bisect good 069f8256362b7a17da532f0631cee73b4cfee65b
# good: [e7b0d26a86943370c04d6833c6edba2a72a6e240] sysfs: reinstate exc=
lusion between method calls and attribute unregistration
git-bisect good e7b0d26a86943370c04d6833c6edba2a72a6e240

zeisberg@cassiopeia:~/gsrc/linux-2.6$ git version
git version 1.5.0.3

This is git from the Debian package.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

cal 9 1752 | grep 10
