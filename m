From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 5/5] tests: Say "pass" rather than "ok" on empty lines for TAP
Date: Thu, 24 Jun 2010 17:44:49 +0000
Message-ID: <1277401489-27885-6-git-send-email-avarab@gmail.com>
References: <1277401489-27885-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 19:45:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORqUu-0005T5-HR
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 19:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316Ab0FXRpu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 13:45:50 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42245 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755285Ab0FXRpr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 13:45:47 -0400
Received: by mail-wy0-f174.google.com with SMTP id 11so1893480wyi.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JUNbfJpjAu7i+xZspyNcmc+J4Feh37LUNZgZbrZcxgs=;
        b=pSFK2dK3XSn1iIOI90gORuqy2TqSTpTJzx5rH2YyFxNHsAXXXu1DYkWb50lwhEF5ei
         DraI9TCBmlRT5hUt6eLzliUssunKR9VFf0wGVSDMb6ywV3bgYf3WZTsxEX3N3Z2eeJbZ
         DcSTIK4IQMhTn7ej8itgTHrkPlsyFprRy4zYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uffR2ZWX77cdpwCv7NGApGy1+mzT4qIuLnTgjNEw65MdJSsu7P8bqt5ioBs0cKfKeS
         FaCSA9REC6DN56LQPELMwjOnjz9eG/wmWNs4/luORm6QD31sqMMJtypjd+kDwBztAT/J
         xWWDtKPYLlQPhFDbZSQBov4lGQspSWWsGH3sg=
Received: by 10.216.172.134 with SMTP id t6mr7682798wel.23.1277401547025;
        Thu, 24 Jun 2010 10:45:47 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id h1sm1043062wee.31.2010.06.24.10.45.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 10:45:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1277401489-27885-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149612>

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
