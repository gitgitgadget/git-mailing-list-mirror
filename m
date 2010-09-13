From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 12/12] gettextize: git-submodule "blob" and "submodule" messages
Date: Mon, 13 Sep 2010 22:09:18 +0000
Message-ID: <1284415758-20931-13-git-send-email-avarab@gmail.com>
References: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 00:10:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvHEf-00079c-7b
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 00:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136Ab0IMWKc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 18:10:32 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44144 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865Ab0IMWK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 18:10:26 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so6742715wyf.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 15:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Tk10J/8ZHZh3FJZZigc0ThDvAXCtf6KbmUld5N2aDC8=;
        b=V+unCcCLcth5PPgLk0dSSkslgch1n//ArDd6nzna6Wr3gouSKze5KmzJUWv/I9Bh70
         lUfaik1qlSh1cjMLuQkMotkoNcPWwDKIt3L2UZUijGFV/uyvxdIOREwEoYcw/Zrnj8Va
         armSPDWTnZqLb021Av0zqecTcgiLFcTJ6Hxzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Iw+fv2+li8YJV8i9IfW9B5EzT0whllrB/nI4QnvNvKOZEBewTRtmgyI7crKHQKEw01
         9sftmnOil4kTuZNFxHruJJV0crPIuCGum7c4l6YBixyxGXCpElhcleUgnPsUWY69lTL4
         GqjsYeo8s06LTJKqa6XFjVqA/bmy0d5htmURQ=
Received: by 10.227.148.20 with SMTP id n20mr2629455wbv.94.1284415825451;
        Mon, 13 Sep 2010 15:10:25 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm4296416weq.9.2010.09.13.15.10.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 15:10:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.220.gb4d42
In-Reply-To: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156143>

Gettextize the words "blob" and "submodule", which will be
interpolated in a message emitted by git-submodule. This is
explicitly tested for so we need to skip some tests with
NO_GETTEXT_POISON.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh             |    6 ++++--
 t/t7401-submodule-summary.sh |    8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index edf8774..3de519a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -674,11 +674,13 @@ cmd_summary() {
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
index 09ef760..a56787a 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -120,7 +120,7 @@ git add sm1 &&
 rm -f sm1 &&
 mv sm1-bak sm1
=20
-test_expect_success 'typechanged submodule(submodule->blob), --cached'=
 "
+test_expect_success NO_GETTEXT_POISON 'typechanged submodule(submodule=
->blob), --cached' "
     git submodule summary --cached >actual &&
     cat >expected <<-EOF &&
 * sm1 $head4(submodule)->$head5(blob) (3):
@@ -130,7 +130,7 @@ EOF
     test_cmp actual expected
 "
=20
-test_expect_success 'typechanged submodule(submodule->blob), --files' =
"
+test_expect_success NO_GETTEXT_POISON 'typechanged submodule(submodule=
->blob), --files' "
     git submodule summary --files >actual &&
     cat >expected <<-EOF &&
 * sm1 $head5(blob)->$head4(submodule) (3):
@@ -142,7 +142,7 @@ EOF
=20
 rm -rf sm1 &&
 git checkout-index sm1
-test_expect_success 'typechanged submodule(submodule->blob)' "
+test_expect_success NO_GETTEXT_POISON 'typechanged submodule(submodule=
->blob)' "
     git submodule summary >actual &&
     cat >expected <<-EOF &&
 * sm1 $head4(submodule)->$head5(blob):
@@ -165,7 +165,7 @@ EOF
 "
=20
 commit_file
-test_expect_success 'typechanged submodule(blob->submodule)' "
+test_expect_success NO_GETTEXT_POISON 'typechanged submodule(blob->sub=
module)' "
     git submodule summary >actual &&
     cat >expected <<-EOF &&
 * sm1 $head5(blob)->$head6(submodule) (2):
--=20
1.7.3.rc1.220.gb4d42
