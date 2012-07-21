From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 3/7] i18n: Rewrite gettext messages start with dash
Date: Sat, 21 Jul 2012 23:50:52 +0800
Message-ID: <77cbbce0450735a66ef1d9101af0bc82e3fc545c.1342884459.git.worldhello.net@gmail.com>
References: <cover.1342884458.git.worldhello.net@gmail.com>
 <a7d2248051ddc62e38e67d9efbb41c01498c7a4c.1342884459.git.worldhello.net@gmail.com>
 <0fd901035a418562d3d9282553a96124814a298a.1342884459.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 17:52:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ssbyy-0005VS-OC
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 17:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792Ab2GUPwa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Jul 2012 11:52:30 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55391 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab2GUPwG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 11:52:06 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so8041000pbb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=rHnyLaB2j3qo1FPoGM9H+BPOQHSnK0PttqOIzHSYFo0=;
        b=WsiHXcwqEOmshFh0+RqiihwaXcEyYRsej5ZhWervKX25hL5mPhU/0iVzpdbyDLaQTR
         J6tzmxBHTR7eWYQbxzACf04o+CJwsq3iR5nYGzwFdQUZY3mWSD9jiclagmwy8wD0IeS1
         7K8EcmjGESWeeXAWofkAaCJg7J4+mW5LqC8L18553pehoEGzRHLuUi1oEM/q8i7BTKWG
         wICE4eTnJGkZe8xCReKiQ0/WYAhAPMnjeibSwPSsNtxaPg+Spq6s5rqAl4YA/7FwYevl
         kgja5G34woGi6jztcL56yNYW+oOxAs7qoYEyq26erLi5UbLcUzRDw9YzZk0Hl7AFBc1/
         mB2g==
Received: by 10.68.116.203 with SMTP id jy11mr22338051pbb.129.1342885926202;
        Sat, 21 Jul 2012 08:52:06 -0700 (PDT)
Received: from localhost.localdomain ([123.116.228.123])
        by mx.google.com with ESMTPS id nj4sm6241849pbc.5.2012.07.21.08.52.00
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 08:52:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.259.g37fc0e1
In-Reply-To: <0fd901035a418562d3d9282553a96124814a298a.1342884459.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1342884458.git.worldhello.net@gmail.com>
References: <cover.1342884458.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201814>

Gettext message in a shell script should not start with '-', one
workaround is adding '--' between gettext and the message, like:

    gettext -- "--exec option ..."

But due to a bug in the xgettext extraction, xgettext can not
extract the actual message for this case. Rewrite the message
is a simpler and better solution.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-rebase.sh                 | 2 +-
 git-submodule.sh              | 2 +-
 t/t3404-rebase-interactive.sh | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index df5998..640af 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -317,7 +317,7 @@ test $# -gt 2 && usage
 if test -n "$cmd" &&
    test "$interactive_rebase" !=3D explicit
 then
-	die "$(gettext -- "--exec option must be used with --interactive opti=
on")"
+	die "$(gettext "The --exec option must be used with the --interactive=
 option")"
 fi
=20
 if test -n "$action"
diff --git a/git-submodule.sh b/git-submodule.sh
index 5629d..57f98 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -746,7 +746,7 @@ cmd_summary() {
 	if [ -n "$files" ]
 	then
 		test -n "$cached" &&
-		die "$(gettext -- "--cached cannot be used with --files")"
+		die "$(gettext "The --cached option cannot be used with the --files =
option")"
 		diff_cmd=3Ddiff-files
 		head=3D
 	fi
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 8078..f206a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -858,7 +858,7 @@ test_expect_success 'rebase -ix with --autosquash' =
'
 test_expect_success 'rebase --exec without -i shows error message' '
 	git reset --hard execute &&
 	test_must_fail git rebase --exec "git show HEAD" HEAD~2 2>actual &&
-	echo "--exec option must be used with --interactive option" >expected=
 &&
+	echo "The --exec option must be used with the --interactive option" >=
expected &&
 	test_i18ncmp expected actual
 '
=20
--=20
1.7.11.2.259.g37fc0e1
