From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 28/48] i18n: git-submodule "blob" and "submodule" messages
Date: Sat, 21 May 2011 18:44:09 +0000
Message-ID: <1306003469-22939-29-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:45:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrBR-0000TI-S3
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981Ab1EUSpj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:39 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47760 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab1EUSp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:29 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1451135ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=ahOg+0Krq2XNh2VwQE6xi9CP3/e8hYFfp33IUYAt5Wk=;
        b=FZUdvJxJXj/9WuqwPemBm15n/atnWLMvdOg6SekqNIUcBcLwyBWK2VgeGLwWbvpjn6
         EpDmlzstEZSlRv1vayrZXpcVWkLjXJq3xHLkPcozbRGLaXPuHzkXsaEauNSHFd77gvJL
         w6ECUYr6o7WhwxxqJRxh4+9QzjSEGIzM42wQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OpVsi5BzyPWCdUUzGHbW5iPWuDsqGVqkqolUeq3/t7KFY47jV757bedI/q+xcrb1bB
         E5hLP0gdjkph+T2/sOpVnHM5+kQDONFekaUnn+cmIUlW3JzlZX0ik+v96+kJrgiJ04ex
         dYNaNjzvv7sj8wlBpLh9J+XQ1sP5oLYilSCYI=
Received: by 10.213.103.82 with SMTP id j18mr592330ebo.0.1306003528404;
        Sat, 21 May 2011 11:45:28 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.27
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174129>

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
index 654a8cb..c1d3a5e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -712,11 +712,13 @@ cmd_summary() {
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
1.7.5.1
