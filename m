From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v10 1/5] t4041, t4205, t6006, t7102: use iso8859-1 rather than iso-8859-1
Date: Fri,  5 Jul 2013 16:01:46 +0400
Message-ID: <78abea3f2a63d42d1b3d89cd7a955da6de10242a.1373024281.git.Alex.Crezoff@gmail.com>
References: <cover.1373024281.git.Alex.Crezoff@gmail.com>
Cc: John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 05 14:02:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv4iN-0004Iy-41
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 14:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757298Ab3GEMCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 08:02:06 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35076 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757250Ab3GEMCE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 08:02:04 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so1951226lbd.29
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 05:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=x4T5NDkWU/6S5h6JD/6OhNL1tdN3t0LFvcTaKKk5vO4=;
        b=g6LXNTjDS/6co4OGCJCHF7T+IZM6FqR76rkLyXlEAe8y0/R6xLl4QGnFqw1nKUnVF8
         q0CdOckVKSlIFUvbCCRmsnw1KBU5d4y3jxmBHRjLpDg5lsKbBWeRZYRjnuyMJSCHN6+P
         F1pvfX1jvFKgXHi4uj+znsBM3x32RDRwOiOxYtXAc16n6tgV+cxsr192s64cf9l5aIx8
         JjbRxNqI4BPeaPIbTbcgHOIFO7osd/tkrLUEkCzD3Q0Rx1NC03KpFRA26VvCKYgJYgxY
         S03Kzzf3yBnaq2nkkpkiUJfnHRO+j6SnrosGXpvzHmo4lLtAH6zUskeS2lrUP2UsuTME
         yHZw==
X-Received: by 10.112.55.207 with SMTP id u15mr5406113lbp.58.1373025721158;
        Fri, 05 Jul 2013 05:02:01 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id b8sm2775388lah.0.2013.07.05.05.01.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 05:02:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.16.gb1f0d63
In-Reply-To: <cover.1373024281.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1373024281.git.Alex.Crezoff@gmail.com>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com> <cover.1373024281.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229652>

Both "iso8859-1" and "iso-8859-1" are understood as latin-1
by modern platforms, but the latter is not understood by
older platforms; update tests to use the former.

This is in line with 3994e8a9 (t4201: use ISO8859-1 rather
than ISO-8859-1, 2009-12-03), which did the same.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
Suggested-by: Johannes Sixt <j.sixt@viscovery.net>
---
 t/t4041-diff-submodule-option.sh |  4 ++--
 t/t4205-log-pretty-formats.sh    |  8 ++++----
 t/t6006-rev-list-format.sh       | 14 +++++++-------
 t/t7102-reset.sh                 | 10 +++++-----
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 0a4f496..1751c83 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -23,8 +23,8 @@ add_file () {
 			echo "$name" >"$name" &&
 			git add "$name" &&
 			test_tick &&
-			msg_added_iso88591=$(echo "Add $name ($added $name)" | iconv -f utf-8 -t iso-8859-1) &&
-			git -c 'i18n.commitEncoding=iso-8859-1' commit -m "$msg_added_iso88591"
+			msg_added_iso88591=$(echo "Add $name ($added $name)" | iconv -f utf-8 -t iso8859-1) &&
+			git -c 'i18n.commitEncoding=iso8859-1' commit -m "$msg_added_iso88591"
 		done >/dev/null &&
 		git rev-parse --short --verify HEAD
 	)
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 3cfb744..c283842 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -32,8 +32,8 @@ test_expect_success 'set up basic repos' '
 	>bar &&
 	git add foo &&
 	test_tick &&
-	git config i18n.commitEncoding iso-8859-1 &&
-	git commit -m "$(commit_msg iso-8859-1)" &&
+	git config i18n.commitEncoding iso8859-1 &&
+	git commit -m "$(commit_msg iso8859-1)" &&
 	git add bar &&
 	test_tick &&
 	git commit -m "add bar" &&
@@ -61,8 +61,8 @@ test_expect_success 'alias user-defined format' '
 	test_cmp expected actual
 '
 
-test_expect_success 'alias user-defined tformat with %s (iso-8859-1 encoding)' '
-	git config i18n.logOutputEncoding iso-8859-1 &&
+test_expect_success 'alias user-defined tformat with %s (iso8859-1 encoding)' '
+	git config i18n.logOutputEncoding iso8859-1 &&
 	git log --oneline >expected-s &&
 	git log --pretty="tformat:%h %s" >actual-s &&
 	git config --unset i18n.logOutputEncoding &&
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 380c85b..4751d22 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -12,15 +12,15 @@ test_tick
 # String "added" in German (translated with Google Translate), encoded in UTF-8,
 # used as a commit log message below.
 added=$(printf "added (hinzugef\303\274gt) foo")
-added_iso88591=$(echo "$added" | iconv -f utf-8 -t iso-8859-1)
+added_iso88591=$(echo "$added" | iconv -f utf-8 -t iso8859-1)
 # same but "changed"
 changed=$(printf "changed (ge\303\244ndert) foo")
-changed_iso88591=$(echo "$changed" | iconv -f utf-8 -t iso-8859-1)
+changed_iso88591=$(echo "$changed" | iconv -f utf-8 -t iso8859-1)
 
 test_expect_success 'setup' '
 	: >foo &&
 	git add foo &&
-	git config i18n.commitEncoding iso-8859-1 &&
+	git config i18n.commitEncoding iso8859-1 &&
 	git commit -m "$added_iso88591" &&
 	head1=$(git rev-parse --verify HEAD) &&
 	head1_short=$(git rev-parse --verify --short $head1) &&
@@ -136,9 +136,9 @@ EOF
 
 test_format encoding %e <<EOF
 commit $head2
-iso-8859-1
+iso8859-1
 commit $head1
-iso-8859-1
+iso8859-1
 EOF
 
 test_format subject %s <<EOF
@@ -242,9 +242,9 @@ test_format complex-encoding %e <<EOF
 commit $head3
 iso8859-1
 commit $head2
-iso-8859-1
+iso8859-1
 commit $head1
-iso-8859-1
+iso8859-1
 EOF
 
 test_format complex-subject %s <<EOF
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 9132dd9..2ef96e9 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -39,7 +39,7 @@ test_expect_success 'creating initial files and commits' '
 
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
-	git -c "i18n.commitEncoding=iso-8859-1" commit -a -m "$(commit_msg iso-8859-1)" &&
+	git -c "i18n.commitEncoding=iso8859-1" commit -a -m "$(commit_msg iso8859-1)" &&
 	head5=$(git rev-parse --verify HEAD)
 '
 # git log --pretty=oneline # to see those SHA1 involved
@@ -62,10 +62,10 @@ test_expect_success 'reset --hard message' '
 	test_cmp .expected .actual
 '
 
-test_expect_success 'reset --hard message (iso-8859-1 logoutencoding)' '
+test_expect_success 'reset --hard message (iso8859-1 logoutputencoding)' '
 	hex=$(git log -1 --format="%h") &&
-	git -c "i18n.logOutputEncoding=iso-8859-1" reset --hard > .actual &&
-	echo HEAD is now at $hex $(commit_msg iso-8859-1) > .expected &&
+	git -c "i18n.logOutputEncoding=iso8859-1" reset --hard > .actual &&
+	echo HEAD is now at $hex $(commit_msg iso8859-1) > .expected &&
 	test_cmp .expected .actual
 '
 
@@ -329,7 +329,7 @@ test_expect_success 'redoing the last two commits should succeed' '
 
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
-	git -c "i18n.commitEncoding=iso-8859-1" commit -a -m "$(commit_msg iso-8859-1)" &&
+	git -c "i18n.commitEncoding=iso8859-1" commit -a -m "$(commit_msg iso8859-1)" &&
 	check_changes $head5
 '
 
-- 
1.8.3.2.16.gb1f0d63
