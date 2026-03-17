Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D921D599
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 02:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773714101; cv=none; b=OKu/Sv/FzDhW0bxPYtjLhviK9vVGeE3Z+O/6Clk0mRMAWOWCs4D3KnH90AMh1cJvAyAW2MzTQLmh3jvHPXrtG5IvvTUK4T9KUOo4IVQ/R/zWIHSgBCzn+W4dNT5hOvkkSNQYyty4dRwWCKXVxWm5YaGu+pR+PdsooWRxBSKxnaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773714101; c=relaxed/simple;
	bh=PFZXFsTTsT9Q7ktTDVgvwQ661AY1Ab+U+F+VbYv1/Lo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DPdPjp9exVkrgwXT/nksemSQ7o0a6qqFBucJR9CKfJ5JnkXuK1TIttoWAscVCWJa7TYXDdeWntILmFCGiF48+dk445mLrawnGyOq+M5YNxNZ7qDUJG3cv8RvMitQG+YI5yMxFIf8JHtITDrtYgW08Wz15ZUsVnwoEaxmmBQzmKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgKb2Tpu; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgKb2Tpu"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-128e4d0cc48so6035128c88.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 19:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773714099; x=1774318899; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCdjXqtlce1oTkN7unTIij/CFHA0dQtbvG2YPoDHk3Y=;
        b=GgKb2Tpu9qP5FNrD3Ek8ULR4HROQ69QQv1uN/KlEguRCswxE/oZgYcn6KnYY7XZgxo
         bPa8Ja63C+d6RMxtE8iRlG3TMdtg3DGyBko1KWhwP/YCUfL76CC1y6U1xoLmRFndn4S6
         5PwCFpbVCH5CSJbHjX6Tdveci5VbMLWEwiIRhn2UhEwO3d3BCYkn/cxKHHt/UsCWUk0Q
         9gFRIr+ZqljKlizbQWq/9QQzQy5ymiSJ7TiakW7XEsHKhzvJkWpjFxbNplYpD9uBLVKo
         ffBl8CZS0ahcuo525ALkJxO/VvFMMgcjJJLzLASPpLY3ML802rg6/uN28DOfLGWhe2L1
         NGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773714099; x=1774318899;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kCdjXqtlce1oTkN7unTIij/CFHA0dQtbvG2YPoDHk3Y=;
        b=YTZHP3F/DMNLBnLMJfbQO+oVCsD1duaIgsv1cDZrJQ+BrCqx+bVO7wFBVpsdAcKRX+
         ONiQDybGMgAme7UzeWuUx96qRV1bHWIDdBNAwmZM7sHelwQiIWK2hGvsupyJ6fYDeEmP
         Wb3+MsKu1rahFetVCIpQitxceSOoiBcdQgj8XjpzxnGQ5y6wPmUGV4P4g5P+srNiKLb7
         u+WtNSgYd/R1z+MAaKLwr1yn4xcl8UXVL5onZO9Xl2ecF+/Dd6O8qZwmoyCCIVWj0LKd
         TywxhPmeu0huHK6XZVieXnqvlJf868//JAc+Bm+2/9EYaYgx3kz1jE5i1HVlL7oPdUwN
         U8fg==
X-Gm-Message-State: AOJu0YwN1H03cZ3EiDBQ9z3g6yK24RSrghPz4K3P1qHPsqEbpgHcwjqF
	24qE8P5ifYAQBC/sCYfIvZeelKbV9OJ5o/MnlaM5nfcPZmGeLqlefppIIYAQtvqe
X-Gm-Gg: ATEYQzwLaEOiOsxf0C1qxXzez0X3v4sSBM+o1cmkMqdj5mt5WGGsP3p6bNkCQjIpvrG
	3PVSEneRITG1+tANqTiq6FYsunK+DfIdzhmo/Qr4pya/BQRC4gCpYi2aqMxBpp2EgEgtZ+iLvxE
	SdZ4Ei0RqkxETgdCl9LkR82MYsZJtIbV6G840bT6XIr75ZOAdBKWcfK1ecKWL1m5fwgiyHXxTNg
	tK4kf6THUab53dTBYiumwmPcf8vLK8+6fj3usx2zKkOLh+aNc5GP6YG7o6ibkZMy9N21YCjBc5H
	rawBgia8fXnPI7At0XnfCF/Jmk95f1vIzObB9HZ+qlNgmifNaTSyC3BXQg/+unYc2npR4MoCUYr
	zkS6Qt4eCZi/eRfWuNF5y1JJrHsMBm0Lb1twkqYyNlrNMM7gH2bNn7v9AUvzSrmXDCeWs5mKgC3
	RZXch/FO+exkeOCdPEnKRkVFieL6TmiN20Vw==
X-Received: by 2002:a05:7301:2c89:b0:2ba:9835:112d with SMTP id 5a478bee46e88-2bea539a85fmr6789593eec.3.1773714098492;
        Mon, 16 Mar 2026 19:21:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.50.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0b3f02ee3sm11277661eec.16.2026.03.16.19.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 19:21:37 -0700 (PDT)
Message-Id: <ccfc1b03fff18771e0a63205ef44d343606b3c90.1773714095.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2065.v2.git.1773714095.gitgitgadget@gmail.com>
References: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
	<pull.2065.v2.git.1773714095.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 02:21:32 +0000
Subject: [PATCH v2 1/4] line-log: fix crash when combined with pickaxe options
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

queue_diffs() passes the caller's diff_options, which may carry
user-specified pickaxe state, to diff_tree_oid() and diffcore_std()
when detecting renames for line-level history tracking.  When pickaxe
options are present on the command line (-G and -S to filter by text
pattern, --find-object to filter by object identity), diffcore_std()
also runs diffcore_pickaxe(), which may discard diff pairs that are
relevant for rename detection.  Losing those pairs breaks rename
following.

Before a2bb801f6a (line-log: avoid unnecessary full tree diffs,
2019-08-21), this silently truncated history at rename boundaries.
That commit moved filter_diffs_for_paths() inside the rename-
detection block, so it only runs when diff_might_be_rename() returns
true.  When pickaxe discards a rename pair, the rename goes
undetected, and a deletion pair at a subsequent commit passes
through uncleaned, reaching process_diff_filepair() with an invalid
filespec and triggering an assertion failure.

Fix this by building a private diff_options for the rename-detection
path inside queue_diffs(), following the same pattern used by blame's
find_rename().  This isolates the rename machinery from unrelated
user-specified options.

Reported-by: Matthew Hughes <matthewhughes934@gmail.com>
Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 line-log.c          | 22 ++++++++++++++----
 t/t4211-line-log.sh | 55 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/line-log.c b/line-log.c
index eeaf68454e..9d12ece181 100644
--- a/line-log.c
+++ b/line-log.c
@@ -858,15 +858,29 @@ static void queue_diffs(struct line_log_data *range,
 	diff_queue_clear(&diff_queued_diff);
 	diff_tree_oid(parent_tree_oid, tree_oid, "", opt);
 	if (opt->detect_rename && diff_might_be_rename()) {
+		struct diff_options rename_opts;
+
+		/*
+		 * Build a private diff_options for rename detection so
+		 * that any user-specified options on the original opts
+		 * (e.g. pickaxe) cannot discard diff pairs needed for
+		 * rename tracking.  Similar to blame's find_rename().
+		 */
+		repo_diff_setup(opt->repo, &rename_opts);
+		rename_opts.flags.recursive = 1;
+		rename_opts.detect_rename = opt->detect_rename;
+		rename_opts.rename_score = opt->rename_score;
+		rename_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+		diff_setup_done(&rename_opts);
+
 		/* must look at the full tree diff to detect renames */
-		clear_pathspec(&opt->pathspec);
 		diff_queue_clear(&diff_queued_diff);
-
-		diff_tree_oid(parent_tree_oid, tree_oid, "", opt);
+		diff_tree_oid(parent_tree_oid, tree_oid, "", &rename_opts);
 
 		filter_diffs_for_paths(range, 1);
-		diffcore_std(opt);
+		diffcore_std(&rename_opts);
 		filter_diffs_for_paths(range, 0);
+		diff_free(&rename_opts);
 	}
 	move_diff_queue(queue, &diff_queued_diff);
 }
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 0a7c3ca42f..659a943aa1 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -367,4 +367,59 @@ test_expect_success 'show line-log with graph' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup for -L with -G/-S/--find-object and a merge with rename' '
+	git checkout --orphan pickaxe-rename &&
+	git reset --hard &&
+
+	echo content >file &&
+	git add file &&
+	git commit -m "add file" &&
+
+	git checkout -b pickaxe-rename-side &&
+	git mv file renamed-file &&
+	git commit -m "rename file" &&
+
+	git checkout pickaxe-rename &&
+	git commit --allow-empty -m "diverge" &&
+	git merge --no-edit pickaxe-rename-side &&
+
+	git mv renamed-file file &&
+	git commit -m "rename back"
+'
+
+test_expect_success '-L -G does not crash with merge and rename' '
+	git log --format="%s" --no-patch -L 1,1:file -G "." >actual
+'
+
+test_expect_success '-L -S does not crash with merge and rename' '
+	git log --format="%s" --no-patch -L 1,1:file -S content >actual
+'
+
+test_expect_success '-L --find-object does not crash with merge and rename' '
+	git log --format="%s" --no-patch -L 1,1:file \
+		--find-object=$(git rev-parse HEAD:file) >actual
+'
+
+# Commit-level filtering with pickaxe does not yet work for -L.
+# show_log() prints the commit header before diffcore_std() runs
+# pickaxe, so commits cannot be suppressed even when no diff pairs
+# survive filtering.  Fixing this would require deferring show_log()
+# until after diffcore_std(), which is a larger restructuring of the
+# log-tree output pipeline.
+test_expect_failure '-L -G should filter commits by pattern' '
+	git log --format="%s" --no-patch -L 1,1:file -G "nomatch" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_failure '-L -S should filter commits by pattern' '
+	git log --format="%s" --no-patch -L 1,1:file -S "nomatch" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_failure '-L --find-object should filter commits by object' '
+	git log --format="%s" --no-patch -L 1,1:file \
+		--find-object=$ZERO_OID >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
gitgitgadget

