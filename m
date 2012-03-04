From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: t0204-gettext-reencode-sanity.sh broken on Mac OS
Date: Sun, 04 Mar 2012 20:32:23 +0100
Message-ID: <4F53C347.6050405@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tb <tboegi@web.de>
To: Git Mailing List <git@vger.kernel.org>, avarab@gmail.com
X-From: git-owner@vger.kernel.org Sun Mar 04 20:39:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4HH8-0003p8-4q
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 20:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805Ab2CDTjR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 14:39:17 -0500
Received: from fmmailgate06.web.de ([217.72.192.247]:50676 "EHLO
	fmmailgate06.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797Ab2CDTjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 14:39:16 -0500
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Mar 2012 14:39:16 EST
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate06.web.de (Postfix) with ESMTP id 5AF9EDB6DF5
	for <git@vger.kernel.org>; Sun,  4 Mar 2012 20:32:32 +0100 (CET)
Received: from wanderer.site ([194.22.188.61]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0LcPhu-1Smis506Io-00jgT4; Sun, 04 Mar 2012 20:32:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120208 Thunderbird/10.0.1
X-Provags-ID: V02:K0:IM4aHc0U11R2Nf/xpBHmEooxxMvwb0xjYA64koJf70m
 2itHiljHlqpGbwiHSJapkw+A/hlNYaR9YPt89OOEMX2QJL2WTT
 ucrGZTsxywq571qa3nVHh+Ued+IHNQlUnzxxwKWBAg7GDtZv8Z
 yR/86jTSG/u/gI9HYlos46hg9yw+SQgUgwXYS/CCPNs7mUsVrE
 KR6ZBaHxsc3tpgCY6CZGg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192172>

t0204-gettext-reencode-sanity.sh broken on Mac OS, Git 1.7.9.2


Please see the sniplet when I run it under Mac OS  10.8:

/Torsten




expecting success:
     LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: Old Engl=
ish=20
Runes" >runes &&

         if grep "^TEST: Old English Runes$" runes
         then
                 say "Your system can not handle this complexity and=20
returns the string as-is"
         else
                 # Both Solaris and GNU libintl will return this stream=
 of
                 # question marks, so it is s probably portable enough
                 printf "TILRAUN: ?? ???? ??? ?? ???? ?? ??? ?????=20
??????????? ??? ?? ????" >runes-expect &&
                 test_cmp runes-expect runes
         fi

--- runes-expect        2012-03-04 19:03:26.000000000 +0000
+++ runes       2012-03-04 19:03:26.000000000 +0000
@@ -1 +1 @@
-TILRAUN: ?? ???? ??? ?? ???? ?? ??? ????? ??????????? ??? ?? ????
\ No newline at end of file
+TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=9A=A6 =E1=9A=
=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=E1=9B=9E=E1=
=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=9A=E1=9A=AA=
=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=A6=E1=9A=B9=
=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=B9=E1=9B=81=
=E1=9A=A6 =E1=9A=A6=E1=9A=AA =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=9A=AB
\ No newline at end of file
not ok - 4 gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Run=
es
#
