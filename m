Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B389335568
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272122; cv=none; b=CRHuaeWB8txIokoe2g8Ov9tJg47YBfWIYlDGvE+I7b3ep3zPMPEPVGYCdyWk0b0GqbIwlW5n2fOXoXELSblw/yG70PUwpCCywG0DWKIgDc5SiM+Qu967j34lz5anDO+fl/GKbp3la4DXzD64+oCj3jdACzKjpnYG1am+nFj7rd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272122; c=relaxed/simple;
	bh=oGPB7wZJYvjOfl+rROVvfmIfjJxnaXCVKf460ug8c88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+/E2HFB5BW6+rgOIgf8XyMrWad2v4D1SDNmVn2MZeFvcH6pJjRejcka5nyUxbdYXGCUosMrI0YnwyhzuHNBe+H3GdW0naAJMATFcLxJzkPfqZ2wNYgxKAN8V+ngPv5Sgv4v8RlmZh27isIES7qsczztqZed+KNS6nm5SWhiuj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzEb63XL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzEb63XL"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so10493115e9.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781272117; x=1781876917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7uo5WJY7aNgnmxE9BWqwy3jq2/Z65g0xXT02gH5pPA=;
        b=FzEb63XLzdh85a0898p94KqHxLfOOk0vzjrjw4gYFtKaayoGP3RUmk8xRKwd9XMrr+
         UWMsNnJ3e8N/kb5CPIXeOtuLfLwJpy+oaVEYnAsBImOop4w8mrQ6GyW7UVCFeTB1ja9J
         noFKoV++F0DO18I1azwLPok6GPmQGqdE+Jn2ciDi5N+iDFo4YYWyXX7rBnEWDj82IriL
         M2VpMPHRNmqZ9Yl8AguNnqOx99stk9CDvm/wQdr/nAcgW1v5kC3lg5CchB4lg4X8DDV2
         iniEyQG+svQFr45gkzUI0M4kaJoSbA0ytQ5ZUksULZcraXoxyexADONHLSr9fZ0xLBYj
         vPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781272117; x=1781876917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7uo5WJY7aNgnmxE9BWqwy3jq2/Z65g0xXT02gH5pPA=;
        b=ddFUY/bgJiTqT4LnFD2jxqCQ++s3UJfTumCjKaIzoBhEyD5rrPykmJNAk4qyKC7uuq
         NgprP9nGJIyN5TMi8xx2tPtpco51BQQSXipdQu7TJ3cWakuChwLgBRgfjrr3w4udaEnv
         mGfy+0+8c9xtXHYpsHR4YwRIOgERKgYHeZpXcGzon+ZPhZDkLsHckzomQ1Sxfq1Cvi1h
         qKgeezPqWRlxnROB/CdnlO3JIdu61lD/yAbayWYAZoB9WAsdwJigouRQdGlDkVdJtafy
         /5q4bFsJXXQ07Jw4paMpmg9Ug4BmwhHaX6zXpuvcQDpKR6XwcJRqy9nYH9gEHKEw6XE2
         VBlw==
X-Gm-Message-State: AOJu0YwOYCew6jKTaVytD/wmgbWNJf2DOWFKFgOlZOvIdHa3LCF+XWXl
	eAY12qd9pTzkvIfRl2UtNce3lGMe7xbOjpSGemM9D0aj29vc6na5tvuhT8AFaIcE
X-Gm-Gg: Acq92OHyPF6nslYXZQXRo+r0yjHMH80pUzKpqeTBcOkLw7IzPaunkPjQ4MSo9+Jfaaj
	4s5tLaH1c4A0gSz37uBDSRu0mvU5kXFP+lMLPtP2LSOUL7uBCpWXEtnjP6jEb0hSEP8yNlXAN0N
	KOuLxLAvHjPSUhGaI9w2syXPEDSn8kpkvH2vHM2whCsZJE6OtFhKS3d6TSEpLTWO5SRT3WmVyA5
	UKaic4efcFosBzKneO2yAB14McBst1iIqQnkPO+gzRNWvaMgXVCOQYmjNmhLjd6Q5yQrGGnUzXS
	Mtc7nRZxoXEO/LckMwrciRk4o7hLIogSoKXg0kMvxGONa0ee+7NpE8rApgJkYZLBbzmg8IiZvQe
	a9tZHuEii0jCcvf/tfRSZ5wFxWsQgGAIRmdw2fnnmd/DucbUP7N7x8GVoWfuczzpAcwhWPkw1dp
	PAn2pfuWNyvlnGVfHqpVgx9VvL59eE4vDH11iYxpEeGbRG3a7Ar+DwIJhfUc3ymjoFPgMYCO8Jo
	zM+110gPQBrhln5sQAaY3gFuGJYXUuIMPx1H8VQE3iDY1VaTYs23RLA5CUbUPePfWG/F0MuMIUE
	lfpUzrEAx2gU9mMGZdSlUUsEeEClsfEYkzGgFSftM6B8lMIQliQd5paBhA==
X-Received: by 2002:a05:600c:820c:b0:490:9d1b:f06a with SMTP id 5b1f17b1804b1-490ec4dc3a3mr35065435e9.10.1781272116920;
        Fri, 12 Jun 2026 06:48:36 -0700 (PDT)
Received: from localhost.localdomain ([155.54.213.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea7c0960sm61223305e9.3.2026.06.12.06.48.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 06:48:36 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH v4 1/2] lib-log-graph: move check_graph function
Date: Fri, 12 Jun 2026 15:48:30 +0200
Message-ID: <20260612-ps-pre-commit-indent-v4-1-e8492037ebae@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
References: <20260427102838.44867-1-pabloosabaterr@gmail.com>
 <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

check_graph is a function shared in the test files t4215 and t6016 used
to format the output graph, but instead of being in a file called by
both test, the function code is repeated in each file.

Move check_graph to lib-log-graph.sh file which both tests already
import graph functions from, renaming it to lib_test_check_graph.

This function is needed for the following commit which includes graph
tests in a new file and requires check_graph.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/lib-log-graph.sh                         |  5 +++++
 t/t4215-log-skewed-merges.sh               | 33 +++++++++++++-----------------
 t/t6016-rev-list-graph-simplify-history.sh | 25 +++++++++-------------
 3 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/t/lib-log-graph.sh b/t/lib-log-graph.sh
index bf952ef920..1eae8f60c2 100644
--- a/t/lib-log-graph.sh
+++ b/t/lib-log-graph.sh
@@ -26,3 +26,8 @@ lib_test_cmp_colored_graph () {
 	test_decode_color <output.colors.raw | sed "s/ *\$//" >output.colors &&
 	test_cmp expect.colors output.colors
 }
+
+lib_test_check_graph () {
+	cat >expect &&
+	lib_test_cmp_graph --format=%s "$@"
+}
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 1612f05f1b..eebab71039 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -5,11 +5,6 @@ test_description='git log --graph of skewed merges'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
 
-check_graph () {
-	cat >expect &&
-	lib_test_cmp_graph --format=%s "$@"
-}
-
 test_expect_success 'log --graph with merge fusing with its left and right neighbors' '
 	git checkout --orphan _p &&
 	test_commit A &&
@@ -21,7 +16,7 @@ test_expect_success 'log --graph with merge fusing with its left and right neigh
 	git checkout _p && git merge --no-ff _r -m G &&
 	git checkout @^^ && git merge --no-ff _p -m H &&
 
-	check_graph <<-\EOF
+	lib_test_check_graph <<-\EOF
 	*   H
 	|\
 	| *   G
@@ -49,7 +44,7 @@ test_expect_success 'log --graph with left-skewed merge' '
 	git checkout 0_p && git merge --no-ff 0_s -m 0_G &&
 	git checkout @^ && git merge --no-ff 0_q 0_r 0_t 0_p -m 0_H &&
 
-	check_graph <<-\EOF
+	lib_test_check_graph <<-\EOF
 	*-----.   0_H
 	|\ \ \ \
 	| | | | * 0_G
@@ -83,7 +78,7 @@ test_expect_success 'log --graph with nested left-skewed merge' '
 	git checkout 1_p && git merge --no-ff 1_r -m 1_G &&
 	git checkout @^^ && git merge --no-ff 1_p -m 1_H &&
 
-	check_graph <<-\EOF
+	lib_test_check_graph <<-\EOF
 	*   1_H
 	|\
 	| *   1_G
@@ -115,7 +110,7 @@ test_expect_success 'log --graph with nested left-skewed merge following normal
 	git checkout -b 2_s @^^ && git merge --no-ff 2_q -m 2_J &&
 	git checkout 2_p && git merge --no-ff 2_s -m 2_K &&
 
-	check_graph <<-\EOF
+	lib_test_check_graph <<-\EOF
 	*   2_K
 	|\
 	| *   2_J
@@ -151,7 +146,7 @@ test_expect_success 'log --graph with nested right-skewed merge following left-s
 	git checkout 3_p && git merge --no-ff 3_r -m 3_H &&
 	git checkout @^^ && git merge --no-ff 3_p -m 3_J &&
 
-	check_graph <<-\EOF
+	lib_test_check_graph <<-\EOF
 	*   3_J
 	|\
 	| *   3_H
@@ -182,7 +177,7 @@ test_expect_success 'log --graph with right-skewed merge following a left-skewed
 	git merge --no-ff 4_p -m 4_G &&
 	git checkout @^^ && git merge --no-ff 4_s -m 4_H &&
 
-	check_graph --date-order <<-\EOF
+	lib_test_check_graph --date-order <<-\EOF
 	*   4_H
 	|\
 	| *   4_G
@@ -218,7 +213,7 @@ test_expect_success 'log --graph with octopus merge with column joining its penu
 	git checkout 5_r &&
 	git merge --no-ff 5_s -m 5_H &&
 
-	check_graph <<-\EOF
+	lib_test_check_graph <<-\EOF
 	*   5_H
 	|\
 	| *-.   5_G
@@ -257,7 +252,7 @@ test_expect_success 'log --graph with multiple tips' '
 	git checkout 6_1 &&
 	git merge --no-ff 6_2 -m 6_I &&
 
-	check_graph 6_1 6_3 6_5 <<-\EOF
+	lib_test_check_graph 6_1 6_3 6_5 <<-\EOF
 	*   6_I
 	|\
 	| | *   6_H
@@ -334,7 +329,7 @@ test_expect_success 'log --graph with multiple tips' '
 	git checkout -b M_7 7_1 &&
 	git merge --no-ff 7_2 7_3 -m 7_M4 &&
 
-	check_graph M_1 M_3 M_5 M_7 <<-\EOF
+	lib_test_check_graph M_1 M_3 M_5 M_7 <<-\EOF
 	*   7_M1
 	|\
 	| | *   7_M2
@@ -371,7 +366,7 @@ test_expect_success 'log --graph with multiple tips' '
 '
 
 test_expect_success 'log --graph --graph-lane-limit=2 limited to two lanes' '
-	check_graph --graph-lane-limit=2 M_7 <<-\EOF
+	lib_test_check_graph --graph-lane-limit=2 M_7 <<-\EOF
 	*-.   7_M4
 	|\ \
 	| | * 7_G
@@ -388,7 +383,7 @@ test_expect_success 'log --graph --graph-lane-limit=2 limited to two lanes' '
 '
 
 test_expect_success 'log --graph --graph-lane-limit=1 truncate mid octopus merge' '
-	check_graph --graph-lane-limit=1 M_7 <<-\EOF
+	lib_test_check_graph --graph-lane-limit=1 M_7 <<-\EOF
 	*-~  7_M4
 	|\~
 	| ~ 7_G
@@ -405,7 +400,7 @@ test_expect_success 'log --graph --graph-lane-limit=1 truncate mid octopus merge
 '
 
 test_expect_success 'log --graph --graph-lane-limit=3 limited to three lanes' '
-	check_graph --graph-lane-limit=3 M_1 M_3 M_5 M_7 <<-\EOF
+	lib_test_check_graph --graph-lane-limit=3 M_1 M_3 M_5 M_7 <<-\EOF
 	*   7_M1
 	|\
 	| | *   7_M2
@@ -441,7 +436,7 @@ test_expect_success 'log --graph --graph-lane-limit=3 limited to three lanes' '
 '
 
 test_expect_success 'log --graph --graph-lane-limit=6 check if it only shows first of 3 parent merge' '
-	check_graph --graph-lane-limit=6 M_1 M_3 M_5 M_7 <<-\EOF
+	lib_test_check_graph --graph-lane-limit=6 M_1 M_3 M_5 M_7 <<-\EOF
 	*   7_M1
 	|\
 	| | *   7_M2
@@ -478,7 +473,7 @@ test_expect_success 'log --graph --graph-lane-limit=6 check if it only shows fir
 '
 
 test_expect_success 'log --graph --graph-lane-limit=7 check if it shows all 3 parent merge' '
-	check_graph --graph-lane-limit=7 M_1 M_3 M_5 M_7 <<-\EOF
+	lib_test_check_graph --graph-lane-limit=7 M_1 M_3 M_5 M_7 <<-\EOF
 	*   7_M1
 	|\
 	| | *   7_M2
diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index 54b0a6f5f8..e0d9c3c1ac 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -13,11 +13,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
 
-check_graph () {
-	cat >expect &&
-	lib_test_cmp_graph --format=%s "$@"
-}
-
 test_expect_success 'set up rev-list --graph test' '
 	# 3 commits on branch A
 	test_commit A1 foo.txt &&
@@ -54,7 +49,7 @@ test_expect_success 'set up rev-list --graph test' '
 '
 
 test_expect_success '--graph --all' '
-	check_graph --all <<-\EOF
+	lib_test_check_graph --all <<-\EOF
 	* A7
 	*   A6
 	|\
@@ -82,7 +77,7 @@ test_expect_success '--graph --all' '
 # that undecorated merges are interesting, even with --simplify-by-decoration
 test_expect_success '--graph --simplify-by-decoration' '
 	git tag -d A4 &&
-	check_graph --all --simplify-by-decoration <<-\EOF
+	lib_test_check_graph --all --simplify-by-decoration <<-\EOF
 	* A7
 	*   A6
 	|\
@@ -114,7 +109,7 @@ test_expect_success 'setup: get rid of decorations on B' '
 
 # Graph with branch B simplified away
 test_expect_success '--graph --simplify-by-decoration prune branch B' '
-	check_graph --simplify-by-decoration --all <<-\EOF
+	lib_test_check_graph --simplify-by-decoration --all <<-\EOF
 	* A7
 	*   A6
 	|\
@@ -133,7 +128,7 @@ test_expect_success '--graph --simplify-by-decoration prune branch B' '
 '
 
 test_expect_success '--graph --full-history -- bar.txt' '
-	check_graph --full-history --all -- bar.txt <<-\EOF
+	lib_test_check_graph --full-history --all -- bar.txt <<-\EOF
 	* A7
 	*   A6
 	|\
@@ -148,7 +143,7 @@ test_expect_success '--graph --full-history -- bar.txt' '
 '
 
 test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
-	check_graph --full-history --simplify-merges --all -- bar.txt <<-\EOF
+	lib_test_check_graph --full-history --simplify-merges --all -- bar.txt <<-\EOF
 	* A7
 	*   A6
 	|\
@@ -161,7 +156,7 @@ test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
 '
 
 test_expect_success '--graph -- bar.txt' '
-	check_graph --all -- bar.txt <<-\EOF
+	lib_test_check_graph --all -- bar.txt <<-\EOF
 	* A7
 	* A5
 	* A3
@@ -172,7 +167,7 @@ test_expect_success '--graph -- bar.txt' '
 '
 
 test_expect_success '--graph --sparse -- bar.txt' '
-	check_graph --sparse --all -- bar.txt <<-\EOF
+	lib_test_check_graph --sparse --all -- bar.txt <<-\EOF
 	* A7
 	* A6
 	* A5
@@ -189,7 +184,7 @@ test_expect_success '--graph --sparse -- bar.txt' '
 '
 
 test_expect_success '--graph ^C4' '
-	check_graph --all ^C4 <<-\EOF
+	lib_test_check_graph --all ^C4 <<-\EOF
 	* A7
 	* A6
 	* A5
@@ -202,7 +197,7 @@ test_expect_success '--graph ^C4' '
 '
 
 test_expect_success '--graph ^C3' '
-	check_graph --all ^C3 <<-\EOF
+	lib_test_check_graph --all ^C3 <<-\EOF
 	* A7
 	*   A6
 	|\
@@ -220,7 +215,7 @@ test_expect_success '--graph ^C3' '
 # that important, but this test depends on it.  If the ordering ever changes
 # in the code, we'll need to update this test.
 test_expect_success '--graph --boundary ^C3' '
-	check_graph --boundary --all ^C3 <<-\EOF
+	lib_test_check_graph --boundary --all ^C3 <<-\EOF
 	* A7
 	*   A6
 	|\

-- 
2.54.0
