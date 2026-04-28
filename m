Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD4113D53C
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 04:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777349134; cv=none; b=fhxFozZBnyoxxB/AwaRmfzwyjiYMTDV/4QFcblXUaqG2zskfcjkXIHmMdtBIhrcT77bSdzATaxCLDTkZAcAMtNHANWzl1pJYDDetjrtjaLxOEfKX8MJL8Gs3jhTJsjVSHDnYkLZ9mIlJugpRpo+/eirsdo6KXWwnHiLsRd0PpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777349134; c=relaxed/simple;
	bh=TDlzTTGeZd6sfLMipe3gbeyHN77NSXdKPxn5FtLicoI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DwTfXk1geLys1zFMYbunC8vCoObTTgEo7kl6R0HSDgg9dbV2mendQCRNa+B6KIXycO/XppLq/uQqHTYe+NVK/yj4RuwX+a9ECbBEc5B6rY9BhwlsEycvTysryb/RTg3UujjJkDly5EGBymMVmtba8kaG3aCh7nU0r+RGnNxSAcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPJ48f8r; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPJ48f8r"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2d9916deb14so19335570eec.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 21:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777349131; x=1777953931; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1mRmqxQmP6x6aWx3IhS4XEsrdnud9FpiNtbF8IBzOI=;
        b=iPJ48f8rCgVIa1wzD7aFOFzeKujboDSwg+1qa4KfagY6xWHa+deFssEDjNm4cDzZ1A
         4JCvO+Vd9Fq4t58Qdc66Z8MHV67lgg8k51/Yc/IqvSaILz4ixJU9EWJos+Iqf9sZVrNN
         ZyhhPg5PonAr6Ua0h3LfvatLcBfNSz1IHjWkuPkk1ipfrV5Us4EA0vK4v7yaAsfr9TOP
         BHGZMYLctud05K41HsYCZF3dKEJUBnUGNmV0dXY7MFYbUGg6YvP+gykdwjPI9nRhm2ZG
         mi1EELlVQWFbxAt8saeqL88AdeQyxNu2XLndqSsPBkWbk4zaEmgS6LRpL195siqzg3Nb
         UOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777349131; x=1777953931;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v1mRmqxQmP6x6aWx3IhS4XEsrdnud9FpiNtbF8IBzOI=;
        b=n1MKBn6DJiF9z3nbtoz7XZLY/Jra/WgTw7oX0SC2Fb0dF0URwEgvoMkLkEQgSCDNvL
         SbO0S3CSTg96+NVbdzfN7RbRV9cewoTgAyCy12GsPM+TlSJwP2a2MGUo70TU34S+dwCA
         fBfMiYvtcI5LTpgmIrf+21L++Qu5OZR2/ZEYyXDaj4RTWaaD1oWg0TsJrB+MghXZhE+F
         B48t09dwgmcCwaZdIidsEKnJyAgGhjXv6O17IT/+gZWHSd+VlCKvRd//1/1faaOVtz5c
         7k0LhPlpglKWJJZCYkH1vbG4BW406rTzwrCW6Y4hJxgO29V2NQjEbX55kIrLye1Bg6zo
         B5TA==
X-Gm-Message-State: AOJu0YwjpordwKDz11ZbQ7M+IQy/DHNZigz8eMM/StqwGvfRZq0Hg75o
	VDE3z76VFqX4EMkPa7ff6ttJPcQavOP8fpDrr33PC6ripuvSfU7oH1ptdszmjQ==
X-Gm-Gg: AeBDievWnE6CnAN9MrjtWQxx89toLATE8TpTAPLy8XAPr3wMDzLw1d+3tyU5LKDJWh3
	DzkoSQfEXCmCNoFvMiFw94FLxVNCOCUAf6UV0rtA0lfVWgUboRwC5dUPEF7EZFlZOFxwyeQcjVa
	luYr4lRjMzM1sb55J7orQ+o44VQUfG+JfgjrubOO3vtq8enljufaiZ+Ufg7ShUjgSqMN4krEMdT
	Xh70tOrIFhZSjHYC2t3hW5UvwQiACVSe06TftPiH37n+PAByvbZrnMYmcpOWOQSdGNjIDnr9WFT
	oyMuFFqTTu8m7mf3XE73uSuskcorcUjFxVd08VfTdmwMGis4fv3JOduxB1syHUfmRsJZfKE9hMv
	8Ka6rwV/kJWHdZuOuzZiVK1wAZyCQ7MPSXYrz3E4D1mVYHbTmRGGeBEMrXbRLr3HhnBS0k4B8qF
	wrQ36wWHMZSl1KaFZflnJaC9VfgZjBxtpKK/o1qu0HwO0jGEg=
X-Received: by 2002:a05:7300:fd08:b0:2ed:e17:d50b with SMTP id 5a478bee46e88-2ed0e17d6eemr260188eec.30.1777349130904;
        Mon, 27 Apr 2026 21:05:30 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.167.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a106524sm1337721eec.23.2026.04.27.21.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 21:05:30 -0700 (PDT)
Message-Id: <2d9e0ca0153b118c6dbe2b4d186e90a882e31597.1777349126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
References: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 04:05:25 +0000
Subject: [PATCH 2/3] line-log: integrate -L output with the standard log-tree
 pipeline
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

`git log -L` has bypassed log_tree_diff() and log_tree_diff_flush()
since the feature was introduced, short-circuiting from
log_tree_commit() directly into line_log_print().  This skips the
no_free save/restore (noted in a NEEDSWORK comment added by
f8781bfda3), the always_show_header fallback, show_diff_of_diff(),
and diff_free() cleanup.

Restructure so that -L flows through log_tree_diff() ->
log_tree_diff_flush(), the same path used by the normal
single-parent and merge diff codepaths:

 - Rename line_log_print() to line_log_queue_pairs() and strip it
   down to just queuing pre-computed filepairs.  The show_log(),
   separator, diffcore_std(), and diff_flush() calls are removed
   since log_tree_diff_flush() handles all of those.

 - In log_tree_diff(), call line_log_queue_pairs() then
   log_tree_diff_flush(), mirroring the diff_tree_oid() + flush
   pattern used by the single-parent and merge codepaths.

 - Remove the early return in log_tree_commit() that bypassed
   no_free save/restore, always_show_header, and diff_free().

Because show_log() is now deferred until after diffcore_std() inside
log_tree_diff_flush(), pickaxe (-S, -G, --find-object) and
--diff-filter now properly suppress commits when all pairs are
filtered out.

The blank-line separator between commit header and diff changes
slightly: the old code printed one unconditionally, while
log_tree_diff_flush() only emits one for verbose headers.  This
matches the rest of log output.

Also reject --full-diff, which is meaningless with -L: the filepairs
are pre-computed during the history walk and scoped to tracked paths,
so there is no tree diff to widen.

Update tests accordingly.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 line-log.c                                    | 30 ++++-------
 line-log.h                                    |  2 +-
 log-tree.c                                    |  9 ++--
 revision.c                                    |  2 +
 t/t4211-line-log.sh                           | 52 ++++++++++++++-----
 t/t4211/sha1/expect.parallel-change-f-to-main |  1 -
 .../sha256/expect.parallel-change-f-to-main   |  1 -
 7 files changed, 56 insertions(+), 41 deletions(-)

diff --git a/line-log.c b/line-log.c
index 858a899cd2..7ee55b05cc 100644
--- a/line-log.c
+++ b/line-log.c
@@ -13,7 +13,6 @@
 #include "revision.h"
 #include "xdiff-interface.h"
 #include "strbuf.h"
-#include "log-tree.h"
 #include "line-log.h"
 #include "setup.h"
 #include "strvec.h"
@@ -1004,29 +1003,18 @@ static int process_all_files(struct line_log_data **range_out,
 	return changed;
 }
 
-int line_log_print(struct rev_info *rev, struct commit *commit)
+void line_log_queue_pairs(struct rev_info *rev, struct commit *commit)
 {
-	show_log(rev);
-	if (!(rev->diffopt.output_format & DIFF_FORMAT_NO_OUTPUT)) {
-		struct line_log_data *range = lookup_line_range(rev, commit);
-		struct line_log_data *r;
-		const char *prefix = diff_line_prefix(&rev->diffopt);
-
-		fprintf(rev->diffopt.file, "%s\n", prefix);
-
-		for (r = range; r; r = r->next) {
-			if (r->pair) {
-				struct diff_filepair *p =
-					diff_filepair_dup(r->pair);
-				p->line_ranges = &r->ranges;
-				diff_q(&diff_queued_diff, p);
-			}
-		}
+	struct line_log_data *range = lookup_line_range(rev, commit);
+	struct line_log_data *r;
 
-		diffcore_std(&rev->diffopt);
-		diff_flush(&rev->diffopt);
+	for (r = range; r; r = r->next) {
+		if (r->pair) {
+			struct diff_filepair *p = diff_filepair_dup(r->pair);
+			p->line_ranges = &r->ranges;
+			diff_q(&diff_queued_diff, p);
+		}
 	}
-	return 1;
 }
 
 static int bloom_filter_check(struct rev_info *rev,
diff --git a/line-log.h b/line-log.h
index 04a6ea64d3..99e1755ce3 100644
--- a/line-log.h
+++ b/line-log.h
@@ -46,7 +46,7 @@ int line_log_filter(struct rev_info *rev);
 int line_log_process_ranges_arbitrary_commit(struct rev_info *rev,
 						    struct commit *commit);
 
-int line_log_print(struct rev_info *rev, struct commit *commit);
+void line_log_queue_pairs(struct rev_info *rev, struct commit *commit);
 
 void line_log_free(struct rev_info *rev);
 
diff --git a/log-tree.c b/log-tree.c
index 7e048701d0..1ead481891 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1105,6 +1105,11 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	if (!all_need_diff && !opt->merges_need_diff)
 		return 0;
 
+	if (opt->line_level_traverse) {
+		line_log_queue_pairs(opt, commit);
+		return log_tree_diff_flush(opt);
+	}
+
 	parse_commit_or_die(commit);
 	oid = get_commit_tree_oid(commit);
 
@@ -1179,10 +1184,6 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 	opt->loginfo = &log;
 	opt->diffopt.no_free = 1;
 
-	/* NEEDSWORK: no restoring of no_free?  Why? */
-	if (opt->line_level_traverse)
-		return line_log_print(opt, commit);
-
 	if (opt->track_linear && !opt->linear && !opt->reverse_output_stage)
 		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
 	shown = log_tree_diff(opt, commit, &log);
diff --git a/revision.c b/revision.c
index 4a8e24bc38..a1c795de96 100644
--- a/revision.c
+++ b/revision.c
@@ -3181,6 +3181,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->line_level_traverse &&
 	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
 		die(_("-L does not yet support diff formats besides -p and -s"));
+	if (revs->line_level_traverse && revs->full_diff)
+		die(_("-L is not compatible with --full-diff"));
 
 	if (revs->expand_tabs_in_log < 0)
 		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index aaf197d2ed..1d566ea9bd 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -368,7 +368,6 @@ test_expect_success '-L diff output includes index and new file mode' '
 
 test_expect_success '-L with --word-diff' '
 	cat >expect <<-\EOF &&
-
 	diff --git a/file.c b/file.c
 	--- a/file.c
 	+++ b/file.c
@@ -377,7 +376,6 @@ test_expect_success '-L with --word-diff' '
 	{
 	    return [-F2;-]{+F2 + 2;+}
 	}
-
 	diff --git a/file.c b/file.c
 	new file mode 100644
 	--- /dev/null
@@ -433,7 +431,6 @@ test_expect_success 'show line-log with graph' '
 	null_blob=$(test_oid zero | cut -c1-7) &&
 	qz_to_tab_space >expect <<-EOF &&
 	* $head_oid Modify func2() in file.c
-	|Z
 	| diff --git a/file.c b/file.c
 	| index $head_blob_old..$head_blob_new 100644
 	| --- a/file.c
@@ -445,7 +442,6 @@ test_expect_success 'show line-log with graph' '
 	| +    return F2 + 2;
 	|  }
 	* $root_oid Add func1() and func2() in file.c
-	ZZ
 	  diff --git a/file.c b/file.c
 	  new file mode 100644
 	  index $null_blob..$root_blob
@@ -494,23 +490,17 @@ test_expect_success '-L --find-object does not crash with merge and rename' '
 		--find-object=$(git rev-parse HEAD:file) >actual
 '
 
-# Commit-level filtering with pickaxe does not yet work for -L.
-# show_log() prints the commit header before diffcore_std() runs
-# pickaxe, so commits cannot be suppressed even when no diff pairs
-# survive filtering.  Fixing this would require deferring show_log()
-# until after diffcore_std(), which is a larger restructuring of the
-# log-tree output pipeline.
-test_expect_failure '-L -G should filter commits by pattern' '
+test_expect_success '-L -G should filter commits by pattern' '
 	git log --format="%s" --no-patch -L 1,1:file -G "nomatch" >actual &&
 	test_must_be_empty actual
 '
 
-test_expect_failure '-L -S should filter commits by pattern' '
+test_expect_success '-L -S should filter commits by pattern' '
 	git log --format="%s" --no-patch -L 1,1:file -S "nomatch" >actual &&
 	test_must_be_empty actual
 '
 
-test_expect_failure '-L --find-object should filter commits by object' '
+test_expect_success '-L --find-object should filter commits by object' '
 	git log --format="%s" --no-patch -L 1,1:file \
 		--find-object=$ZERO_OID >actual &&
 	test_must_be_empty actual
@@ -711,4 +701,40 @@ test_expect_success '-L with -G filters to diff-text matches' '
 	grep "F2 + 2" actual
 '
 
+test_expect_success '-L with --diff-filter=M excludes root commit' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c --diff-filter=M --format=%s --no-patch >actual &&
+	# Root commit is an Add (A), not a Modify (M), so it should
+	# be excluded; only the modification commit remains.
+	echo "Modify func2() in file.c" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '-L with --diff-filter=A shows only root commit' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c --diff-filter=A --format=%s --no-patch >actual &&
+	echo "Add func1() and func2() in file.c" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '-L with -S suppresses non-matching commits' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c -S "F2 + 2" --format=%s --no-patch >actual &&
+	# Only the commit that changes the count of "F2 + 2" should appear.
+	echo "Modify func2() in file.c" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--full-diff is not supported with -L' '
+	test_must_fail git log -L1,24:b.c --full-diff 2>err &&
+	test_grep "not compatible with --full-diff" err
+'
+
+test_expect_success '-L --oneline has no extra blank line before diff' '
+	git checkout parent-oids &&
+	git log --oneline -L:func2:file.c -1 >actual &&
+	# Oneline header on line 1, diff starts immediately on line 2
+	sed -n 2p actual | grep "^diff --git"
+'
+
 test_done
diff --git a/t/t4211/sha1/expect.parallel-change-f-to-main b/t/t4211/sha1/expect.parallel-change-f-to-main
index 65a8cc673a..6d7a201036 100644
--- a/t/t4211/sha1/expect.parallel-change-f-to-main
+++ b/t/t4211/sha1/expect.parallel-change-f-to-main
@@ -5,7 +5,6 @@ Date:   Fri Apr 12 16:16:24 2013 +0200
 
     Merge across the rename
 
-
 commit 6ce3c4ff690136099bb17e1a8766b75764726ea7
 Author: Thomas Rast <trast@student.ethz.ch>
 Date:   Thu Feb 28 10:49:50 2013 +0100
diff --git a/t/t4211/sha256/expect.parallel-change-f-to-main b/t/t4211/sha256/expect.parallel-change-f-to-main
index 3178989253..c93e03bef4 100644
--- a/t/t4211/sha256/expect.parallel-change-f-to-main
+++ b/t/t4211/sha256/expect.parallel-change-f-to-main
@@ -5,7 +5,6 @@ Date:   Fri Apr 12 16:16:24 2013 +0200
 
     Merge across the rename
 
-
 commit 4f7a58195a92c400e28a2354328587f1ff14fb77f5cf894536f17ccbc72931b9
 Author: Thomas Rast <trast@student.ethz.ch>
 Date:   Thu Feb 28 10:49:50 2013 +0100
-- 
gitgitgadget

