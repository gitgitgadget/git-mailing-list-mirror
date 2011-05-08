From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 28/48] i18n: git-submodule "blob" and "submodule" messages
Date: Sun,  8 May 2011 12:21:00 +0000
Message-ID: <1304857280-14773-29-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:22:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30A-0003rg-KD
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001Ab1EHMWS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:18 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35010 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab1EHMWA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:00 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327054ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=PClQCJmmSyVzMcAflmP433jMnJNhliTwzI5Ktgsk8r8=;
        b=adkMqyo4Jy0h01J07dgbo6YpL46tnNYYY6aX8Tgo84wXKDEEo+3vQifjVuPhi6wxyF
         R4DaO1cJXtbtOX/dcZQnuzZOVx5vFMf/o+MLE3Guf1lEyo3JXHO3N2Fa58z8shy3hCv/
         NT7STHTi8JgrHNA5Vxz/CjC4Awrq2ho85SK88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=m06pdkPI3IWu1XqQks50SAzpnD6XVlGG669ftReJawsShQfgeaeif2DpEGRYqE+cSo
         h8resG1gS8M9XYbVJ42Y6D+sdRK1b8CBw5h5MIACVp94FjJq4W9P8WlrcYtByqI0bEc5
         U9JwMzGlSpoc6o7tFMXmlj+y2IRly5W4UXTC0=
Received: by 10.213.10.2 with SMTP id n2mr1967438ebn.112.1304857319254;
        Sun, 08 May 2011 05:21:59 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.58
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173123>

Gettextize the words "blob" and "submodule", which will be
interpolated in a message emitted by git-submodule. This is
explicitly tested for so we need to skip a portion of a test with
test_i18ncmp.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh             |    6 ++++--
 t/t7401-submodule-summary.sh |    8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b1df660..d720fa3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -706,11 +706,13 @@ cmd_summary() {
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
index cfa6632..30b429e 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -128,7 +128,7 @@ test_expect_success 'typechanged submodule(submodul=
e->blob), --cached' "
   < Add foo5
=20
 EOF
-	test_cmp actual expected
+	test_i18ncmp actual expected
 "
=20
 test_expect_success 'typechanged submodule(submodule->blob), --files' =
"
@@ -138,7 +138,7 @@ test_expect_success 'typechanged submodule(submodul=
e->blob), --files' "
   > Add foo5
=20
 EOF
-    test_cmp actual expected
+    test_i18ncmp actual expected
 "
=20
 rm -rf sm1 &&
@@ -149,7 +149,7 @@ test_expect_success 'typechanged submodule(submodul=
e->blob)' "
 * sm1 $head4(submodule)->$head5(blob):
=20
 EOF
-    test_cmp actual expected
+    test_i18ncmp actual expected
 "
=20
 rm -f sm1 &&
@@ -173,7 +173,7 @@ test_expect_success 'typechanged submodule(blob->su=
bmodule)' "
   > Add foo7
=20
 EOF
-    test_cmp expected actual
+    test_i18ncmp expected actual
 "
=20
 commit_file sm1 &&
--=20
1.7.4.4
