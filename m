From: Christoph Miebach <christoph.miebach@web.de>
Subject: bug (?) in send email
Date: Sat, 28 Jul 2012 23:33:04 +0200
Message-ID: <50145A90.1090904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 23:34:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvEe4-0000pe-AF
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 23:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132Ab2G1VdP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jul 2012 17:33:15 -0400
Received: from mout.web.de ([212.227.17.12]:62784 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065Ab2G1VdO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 17:33:14 -0400
Received: from [192.168.168.63] ([89.0.65.68]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MMVpO-1SsSfu13PC-007nk8 for <git@vger.kernel.org>; Sat,
 28 Jul 2012 23:33:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-Provags-ID: V02:K0:AMouBim3iAhWDHHNkAxVkACeeiEo9EAQl/iKTmW6G98
 uyOiAAGBzGxwjZ5DecB9WmNG14Qmj7MuJhkq1K2ql1gz/6H9VV
 kq7wmBDAbVrWqIJJFj6OfIob1CtdIlUpoLO6SyBTuhBZ1IKeIs
 j1qKqcb2IYAHdHvIYHIz1gSWON0TdtZnv3ELB22JH7TFX405ay
 XA7TPmpjx1V7ErYUMq2yvppNLOI+s2P5lvzF/Kh888=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202464>

Hello!

send-email (tested versions 1.7.9.2 and 1.7.10.4) breaks email addresse=
s.

Steps to reproduce:


Modify file.

git commit --author=3D"Micha=C5=82 Tz <name_1911@some.com>" modified.fi=
le -m "Test"

git format-patch -o patches origin

Now, the patch seems to have the address right, see [1]

git send-email  --to MYOWN.ADDRESS@mail.com --suppress-cc=3Dauthor=20
patches/0001-Test.patch

But checking my inbox now shows an email starting with:
=46rom: Micha=C5=82 Tz <name 1911@some.com>

So the address is splitted at the underscore.

=46urthermore, if I don't use --suppress-cc=3Dauthor, the CC field show=
s the=20
right address.

Regards

Christoph

[1]
less patches/0001-Test.patch
=46rom: =3D?UTF-8?q?Micha=3DC5=3D82=3D20Tz?=3D <name_1911@some.com>

git show
Author: Micha=C5=82 Tz <name_1911@some.com>
