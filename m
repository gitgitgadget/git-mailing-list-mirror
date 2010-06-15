From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 4/5] TAP: Say "pass" rather than "ok" on an empty line
Date: Tue, 15 Jun 2010 22:32:57 +0000
Message-ID: <1276641178-32420-5-git-send-email-avarab@gmail.com>
References: <AANLkTimxE0mqmitRzlXjSAO6v7IOEg4guUnRlzJUyIF1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 16 00:34:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOeiD-0006Bf-CN
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 00:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955Ab0FOWeV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 18:34:21 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:60370 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297Ab0FOWeU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 18:34:20 -0400
Received: by mail-ww0-f46.google.com with SMTP id 18so5216483wwb.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JUNbfJpjAu7i+xZspyNcmc+J4Feh37LUNZgZbrZcxgs=;
        b=AaOlBjTc9Rlimt8xTZBspgM5Cf3feHsqtMKBJyeuzMfvjeyVwjGpMpLMW2bsKpuy2e
         zs3C1bZyMeYx6j9ejRNQcOCrQVYjAI0+4WCMvMm3SEIxlYoFRkfPMcGu1gl40hz8PP5K
         VOLY8jl0J66EYO+fumQSAe6/ri9K//hdt/CaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=N+7d/kMHK6SSE/1lh3JOnEP8CEn0fKLTuFw0he+KyS+jbDeVR880R3V5DFGQ72ts90
         JeAWBIU/unFykfiBwdZvpMbc85HN/f1gMXQ2vWpa1f6g+dxCQQxLOZdXfsaCbNddDgqu
         HSJuoS7MSw2/kJxAHKGVTzOAMqCAr0GwwuAXE=
Received: by 10.227.127.68 with SMTP id f4mr7870898wbs.44.1276641259511;
        Tue, 15 Jun 2010 15:34:19 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id u36sm49368610wbv.6.2010.06.15.15.34.17
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Jun 2010 15:34:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <AANLkTimxE0mqmitRzlXjSAO6v7IOEg4guUnRlzJUyIF1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149235>

Lines that begin with "ok" confuse the TAP harness because it can't
distinguish them from a test counter. Work around the issue by saying
"pass" instead, which isn't a reserved TAP word.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t1020-subdirectory.sh          |   12 ++++++------
 t/t2102-update-index-symlinks.sh |    2 +-
 t/t3700-add.sh                   |   12 ++++++------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 210e594..5687499 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -24,18 +24,18 @@ test_expect_success 'update-index and ls-files' '
 	cd "$HERE" &&
 	git update-index --add one &&
 	case "`git ls-files`" in
-	one) echo ok one ;;
+	one) echo pass one ;;
 	*) echo bad one; exit 1 ;;
 	esac &&
 	cd dir &&
 	git update-index --add two &&
 	case "`git ls-files`" in
-	two) echo ok two ;;
+	two) echo pass two ;;
 	*) echo bad two; exit 1 ;;
 	esac &&
 	cd .. &&
 	case "`git ls-files`" in
-	dir/two"$LF"one) echo ok both ;;
+	dir/two"$LF"one) echo pass both ;;
 	*) echo bad; exit 1 ;;
 	esac
 '
@@ -58,17 +58,17 @@ test_expect_success 'diff-files' '
 	echo a >>one &&
 	echo d >>dir/two &&
 	case "`git diff-files --name-only`" in
-	dir/two"$LF"one) echo ok top ;;
+	dir/two"$LF"one) echo pass top ;;
 	*) echo bad top; exit 1 ;;
 	esac &&
 	# diff should not omit leading paths
 	cd dir &&
 	case "`git diff-files --name-only`" in
-	dir/two"$LF"one) echo ok subdir ;;
+	dir/two"$LF"one) echo pass subdir ;;
 	*) echo bad subdir; exit 1 ;;
 	esac &&
 	case "`git diff-files --name-only .`" in
-	dir/two) echo ok subdir limited ;;
+	dir/two) echo pass subdir limited ;;
 	*) echo bad subdir limited; exit 1 ;;
 	esac
 '
diff --git a/t/t2102-update-index-symlinks.sh b/t/t2102-update-index-sy=
mlinks.sh
index 1ed44ee..4d0d0a3 100755
--- a/t/t2102-update-index-symlinks.sh
+++ b/t/t2102-update-index-symlinks.sh
@@ -24,7 +24,7 @@ git update-index symlink'
 test_expect_success \
 'the index entry must still be a symbolic link' '
 case "`git ls-files --stage --cached symlink`" in
-120000" "*symlink) echo ok;;
+120000" "*symlink) echo pass;;
 *) echo fail; git ls-files --stage --cached symlink; (exit 1);;
 esac'
=20
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 525c9a8..6f031af 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -26,7 +26,7 @@ test_expect_success \
 	 chmod 755 xfoo1 &&
 	 git add xfoo1 &&
 	 case "`git ls-files --stage xfoo1`" in
-	 100644" "*xfoo1) echo ok;;
+	 100644" "*xfoo1) echo pass;;
 	 *) echo fail; git ls-files --stage xfoo1; (exit 1);;
 	 esac'
=20
@@ -35,7 +35,7 @@ test_expect_success SYMLINKS 'git add: filemode=3D0 s=
hould not get confused by sym
 	ln -s foo xfoo1 &&
 	git add xfoo1 &&
 	case "`git ls-files --stage xfoo1`" in
-	120000" "*xfoo1) echo ok;;
+	120000" "*xfoo1) echo pass;;
 	*) echo fail; git ls-files --stage xfoo1; (exit 1);;
 	esac
 '
@@ -47,7 +47,7 @@ test_expect_success \
 	 chmod 755 xfoo2 &&
 	 git update-index --add xfoo2 &&
 	 case "`git ls-files --stage xfoo2`" in
-	 100644" "*xfoo2) echo ok;;
+	 100644" "*xfoo2) echo pass;;
 	 *) echo fail; git ls-files --stage xfoo2; (exit 1);;
 	 esac'
=20
@@ -56,7 +56,7 @@ test_expect_success SYMLINKS 'git add: filemode=3D0 s=
hould not get confused by sym
 	ln -s foo xfoo2 &&
 	git update-index --add xfoo2 &&
 	case "`git ls-files --stage xfoo2`" in
-	120000" "*xfoo2) echo ok;;
+	120000" "*xfoo2) echo pass;;
 	*) echo fail; git ls-files --stage xfoo2; (exit 1);;
 	esac
 '
@@ -67,7 +67,7 @@ test_expect_success SYMLINKS \
 	 ln -s xfoo2 xfoo3 &&
 	 git update-index --add xfoo3 &&
 	 case "`git ls-files --stage xfoo3`" in
-	 120000" "*xfoo3) echo ok;;
+	 120000" "*xfoo3) echo pass;;
 	 *) echo fail; git ls-files --stage xfoo3; (exit 1);;
 	 esac'
=20
@@ -172,7 +172,7 @@ test_expect_success 'git add --refresh' '
 	test -z "`git diff-index HEAD -- foo`" &&
 	git read-tree HEAD &&
 	case "`git diff-index HEAD -- foo`" in
-	:100644" "*"M	foo") echo ok;;
+	:100644" "*"M	foo") echo pass;;
 	*) echo fail; (exit 1);;
 	esac &&
 	git add --refresh -- foo &&
--=20
1.7.1.251.g92a7
