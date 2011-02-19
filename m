From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 10/72] gettextize: git-add "Use -f if you really want" message
Date: Sat, 19 Feb 2011 19:23:53 +0000
Message-ID: <1298143495-3681-11-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:27:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsSj-0002hp-3b
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630Ab1BST1U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:27:20 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40522 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503Ab1BST1T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:19 -0500
Received: by eye27 with SMTP id 27so2347071eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=6hw0IztktfvV5CIIj/heH6B9iVHyxAeZkvvvpdWffp0=;
        b=IujSojyJpfAhNQbAjtu6J4GYQRfzhp1i3JT4Vm/CxcP5SaLoWiwYEm0dUeB37zpiQU
         ka1FlF/s2SN06wWNE5HKy4T6DTa8OBy+bWJp7Fue+U0DmfxUH+he/R0Huusw9fX81lja
         LVtpC7WXyxGaEzgTWWwJ9rqNBQWpp03lmMlNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kzpfo5AynuoYmNy6c1zHoY1YiA6Ov1W6Tm7dVWvnMzQiHcaM8So1ipya8cZCKJTT6n
         71B6fe9g+G9sa2UMdqBwPzxj08rdcSwa8ygRqTWmQHQEfZ8hYcW8x6ZeG/RTz9YaiPMC
         Bw+fswL7OP1rVDvCs4zs9EY6Cr4LBayGRvuqA=
Received: by 10.213.30.20 with SMTP id s20mr2573121ebc.15.1298143638558;
        Sat, 19 Feb 2011 11:27:18 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.17
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:17 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167318>

Gettextize the "Use -f if you really want to add them.\n"
message. Tests in t2204-add-ignored.sh and t3700-add.sh explicitly
checked for this message. Split the tests that did so up and skip
portion that calls grep on this message under
GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/add.c          |    2 +-
 t/t2204-add-ignored.sh |   37 +++++++++++++++++++++++++------------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index df56429..fe4ac49 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -347,7 +347,7 @@ static int add_files(struct dir_struct *dir, int fl=
ags)
 		fprintf(stderr, ignore_error);
 		for (i =3D 0; i < dir->ignored_nr; i++)
 			fprintf(stderr, "%s\n", dir->ignored[i]->name);
-		fprintf(stderr, "Use -f if you really want to add them.\n");
+		fprintf(stderr, _("Use -f if you really want to add them.\n"));
 		die(_("no files added"));
 	}
=20
diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
index 24afdab..be66e2d 100755
--- a/t/t2204-add-ignored.sh
+++ b/t/t2204-add-ignored.sh
@@ -31,18 +31,21 @@ do
 		rm -f .git/index &&
 		test_must_fail git add "$i" 2>err &&
 		git ls-files "$i" >out &&
-		! test -s out &&
-		grep -e "Use -f if" err &&
-		cat err
+		! test -s out
+	'
+
+	test_expect_success NO_GETTEXT_POISON "complaints for ignored $i outp=
ut" '
+		grep -e "Use -f if" err
 	'
=20
 	test_expect_success "complaints for ignored $i with unignored file" '
 		rm -f .git/index &&
 		test_must_fail git add "$i" file 2>err &&
 		git ls-files "$i" >out &&
-		! test -s out &&
-		grep -e "Use -f if" err &&
-		cat err
+		! test -s out
+	'
+	test_expect_success NO_GETTEXT_POISON "complaints for ignored $i with=
 unignored file output" '
+		grep -e "Use -f if" err
 	'
 done
=20
@@ -54,9 +57,14 @@ do
 			cd dir &&
 			test_must_fail git add "$i" 2>err &&
 			git ls-files "$i" >out &&
-			! test -s out &&
-			grep -e "Use -f if" err &&
-			cat err
+			! test -s out
+		)
+	'
+
+	test_expect_success NO_GETTEXT_POISON "complaints for ignored $i in d=
ir output" '
+		(
+			cd dir &&
+			grep -e "Use -f if" err
 		)
 	'
 done
@@ -69,9 +77,14 @@ do
 			cd sub &&
 			test_must_fail git add "$i" 2>err &&
 			git ls-files "$i" >out &&
-			! test -s out &&
-			grep -e "Use -f if" err &&
-			cat err
+			! test -s out
+		)
+	'
+
+	test_expect_success NO_GETTEXT_POISON "complaints for ignored $i in s=
ub output" '
+		(
+			cd sub &&
+			grep -e "Use -f if" err
 		)
 	'
 done
--=20
1.7.2.3
