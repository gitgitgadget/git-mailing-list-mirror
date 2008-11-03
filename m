From: Alejandro Riveira <ariveira@gmail.com>
Subject: Re: git bisect v2.6.27 v2.6.26 problem/bug
Date: Mon, 3 Nov 2008 18:23:10 +0000 (UTC)
Message-ID: <genfie$vbs$1@ger.gmane.org>
References: <20081103173911.GA12363@xs4all.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 19:24:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx46N-00043J-Ii
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 19:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbYKCSXW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 13:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbYKCSXW
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 13:23:22 -0500
Received: from main.gmane.org ([80.91.229.2]:39683 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565AbYKCSXV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 13:23:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kx45A-0005Pa-8v
	for git@vger.kernel.org; Mon, 03 Nov 2008 18:23:20 +0000
Received: from 68.red-83-43-193.dynamicip.rima-tde.net ([83.43.193.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 18:23:20 +0000
Received: from ariveira by 68.red-83-43-193.dynamicip.rima-tde.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 18:23:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68.red-83-43-193.dynamicip.rima-tde.net
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99970>

El Mon, 03 Nov 2008 18:39:15 +0100, Miquel van Smoorenburg escribi=C3=B3=
:

> I'm trying to nail down a disk statistics issue that was introduced i=
n
> 2.6.27, while 2.6.26 was working OK. So I decided to use git bisect.
>=20
> However, sometimes I end up with a version before 2.6.26:
>=20
> $ cat .git/BISECT_LOG
> git-bisect start
> # good: [bce7f793daec3e65ec5c5705d2457b81fe7b5725] Linux 2.6.26
> git-bisect good bce7f793daec3e65ec5c5705d2457b81fe7b5725 # bad:
> [3fa8749e584b55f1180411ab1b51117190bac1e5] Linux 2.6.27 git-bisect ba=
d
> 3fa8749e584b55f1180411ab1b51117190bac1e5 # bad:
> [dd9ca5d9be7eba99d685d733e23d5be7110e9556] USB: usb-serial: fix a spa=
rse
> warning about different signedness git-bisect bad
> dd9ca5d9be7eba99d685d733e23d5be7110e9556 # good:
> [84c3d4aaec3338201b449034beac41635866bddf] Merge commit 'origin/maste=
r'
> git-bisect good 84c3d4aaec3338201b449034beac41635866bddf
>=20
> $ head -4 Makefile
> VERSION =3D 2
> PATCHLEVEL =3D 6
> SUBLEVEL =3D 26
> EXTRAVERSION =3D -rc8
>=20
> If at this point I do a 'git bisect good' I end up in a 2.6.26 branch=
,
> which is good, but after a few bisects I end up at a version before
> v2.6.26 (2.6.26-rc5) again, which should be impossible right ?

 Afaik it is not imposible with git you do not get a linear history


>=20
> Anyway - at the end I end up with a 'good' version that is
> 2.6.26-rc<something> which is kind of useless. I know that version up=
 to
> 2.6.26 are good ...
>=20
> What am I doing wrong ?
>=20
> (git version 1.5.6.5 from debian/lenny)
>=20
> Mike.
