From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 31/51] i18n: git-submodule "blob" and "submodule" messages
Date: Sun,  3 Apr 2011 16:45:55 +0000
Message-ID: <1301849175-1697-32-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:47:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QSL-00055g-Ry
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054Ab1DCQrE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:04 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47128 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023Ab1DCQrB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:01 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502908eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=MFc/29k+Dy/2gt7KuisbkxOxwZqTDr0USsgJFEbH9Mo=;
        b=wwyhdFfUAINammQUPafT8rm4AvfMqU9XhkQjeuYo4Ki7IjfIuK6ZhddYIHWusqzxoT
         CZ1pQ6kyTd6wobFhMN/Agc2fo7t5jjfZiTARX7wyCru7m2mhc8wmp/TDc1M863ohwmqc
         0QOuzRsDlEuDknPtPQa23NRXmSPTwc38juycg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=o5icXk9ZLeY8Niz4YsPrXgnTlYTWFRdPGBU5xBXQpZjuPqW9ocyszHYGwgcnnVCgt8
         FaHhaJpiPJEvLpCYyC1+Sdw4p+Jy0ag+HgQ0/x6yfaeyXMWItfHihxONegkzJvnRAcQy
         gANPpTZAFY1/JIS9uYiRn+GvRrNd4PNWLO2ac=
Received: by 10.213.104.99 with SMTP id n35mr1148458ebo.32.1301849220302;
        Sun, 03 Apr 2011 09:47:00 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.59
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170723>

Gettextize the words "blob" and "submodule", which will be
interpolated in a message emitted by git-submodule. This is
explicitly tested for so we need to skip some tests with
C_LOCALE_OUTPUT.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh             |    6 ++++--
 t/t7401-submodule-summary.sh |    8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bc24b2f..aced079 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -677,11 +677,13 @@ cmd_summary() {
 		sha1_abbr_dst=3D$(echo $sha1_dst | cut -c1-7)
 		if test $status =3D T
 		then
+			blob=3D"$(gettext "blob")"
+			submodule=3D"$(gettext "submodule")"
 			if test $mod_dst =3D 160000
 			then
-				echo "* $name $sha1_abbr_src(blob)->$sha1_abbr_dst(submodule)$tota=
l_commits:"
+				echo "* $name $sha1_abbr_src($blob)->$sha1_abbr_dst($submodule)$to=
tal_commits:"
 			else
-				echo "* $name $sha1_abbr_src(submodule)->$sha1_abbr_dst(blob)$tota=
l_commits:"
+				echo "* $name $sha1_abbr_src($submodule)->$sha1_abbr_dst($blob)$to=
tal_commits:"
 			fi
 		else
 			echo "* $name $sha1_abbr_src...$sha1_abbr_dst$total_commits:"
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.s=
h
index 1b703fb..548473b 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -121,7 +121,7 @@ git add sm1 &&
 rm -f sm1 &&
 mv sm1-bak sm1
=20
-test_expect_success 'typechanged submodule(submodule->blob), --cached'=
 "
+test_expect_success C_LOCALE_OUTPUT 'typechanged submodule(submodule->=
blob), --cached' "
     git submodule summary --cached >actual &&
     cat >expected <<-EOF &&
 * sm1 $head4(submodule)->$head5(blob) (3):
@@ -131,7 +131,7 @@ EOF
 	test_cmp actual expected
 "
=20
-test_expect_success 'typechanged submodule(submodule->blob), --files' =
"
+test_expect_success C_LOCALE_OUTPUT 'typechanged submodule(submodule->=
blob), --files' "
     git submodule summary --files >actual &&
     cat >expected <<-EOF &&
 * sm1 $head5(blob)->$head4(submodule) (3):
@@ -143,7 +143,7 @@ EOF
=20
 rm -rf sm1 &&
 git checkout-index sm1
-test_expect_success 'typechanged submodule(submodule->blob)' "
+test_expect_success C_LOCALE_OUTPUT 'typechanged submodule(submodule->=
blob)' "
     git submodule summary >actual &&
     cat >expected <<-EOF &&
 * sm1 $head4(submodule)->$head5(blob):
@@ -166,7 +166,7 @@ EOF
 "
=20
 commit_file
-test_expect_success 'typechanged submodule(blob->submodule)' "
+test_expect_success C_LOCALE_OUTPUT 'typechanged submodule(blob->submo=
dule)' "
     git submodule summary >actual &&
     cat >expected <<-EOF &&
 * sm1 $head5(blob)->$head6(submodule) (2):
--=20
1.7.4.1
