Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EEF34C83C
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776297490; cv=none; b=DrNSyYZ/oUzO4+BmZjwfQfbgfSec+m/pfLAVNavRQwnE4Kf+uH2/ck4pLoXy+HdGsxKLFjp+0juIQmT7SchVGAT0Ofvv2NBXUln5B+3Pv48Q9Y+MLn9eLzzo0nEA8TF/frC03PnqbQzEiubkWspGbqQxV3y69QozCsDyRX6VbWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776297490; c=relaxed/simple;
	bh=d5mT4tP+kEY0gHiWzRFqkNAEOyDnpeAr9d8czLcJFvA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=adwFEb81qqUAYSughsb34Z9S2ZWxc/pJ6l/avt61D64i9H0APgkMW6M3U2vvYVvwBt0ogtLIRNpgLBkY27mM7IjC4nYepEhCk82uB9bBjfiU0bF0/DJ8ko3i2QNceQu+9jjXCkvZ8ms2o0MSxRi2j3EdgxZao/Zt5d/i9vapIos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTT3h6VF; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTT3h6VF"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506a6cf8242so56790721cf.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 16:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776297487; x=1776902287; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VF8VCHx5La2i1juZF3RO3+CxUPz7XPHBRGUo90VW6I=;
        b=UTT3h6VFNcjSvg2EvnlYONQ0Y2VSugNTF6vKwW2Ef7Ze3MLFIjirBdGBRsoc6nbyYC
         6p0+YfXrsZEcVESL1KBFeVylTf5638tZNuwuIv9RMXu0V/o98vyhHmvONsZVjrnps3KN
         cpqxYdKYYrhmdZ7KvkELCmR72fkR5moZ2I9Lbij3ge8kOv6+y5ftJG/mAkg9eQG3A7OA
         ViVUePBAkNDJDNBRFwIBYPL4oLd+EagnB4FPns47SizErT/XDt1T8uPAbmjys+81X2+x
         2/7iijfFJRoHPSlXF2SWWj5jAS95XF6LBgCz9CgXIglsckh/Pdm89jWMmGyb4D/5xhNn
         jCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776297487; x=1776902287;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3VF8VCHx5La2i1juZF3RO3+CxUPz7XPHBRGUo90VW6I=;
        b=Zq86X2KO8KFY7LX5J6bSa8x1RgDBPnGm3vl5V+binH+wljFasuUrd4SSHCSrjiHO4x
         e6qqDgI5nQaGL4Z17oIlyPq35ewHrWfdo25lke+CsPzTZPzHnAlXTa0Oye3LU0w/kCRQ
         nd+qXFsviD1TQY+JB73Arm8m4CpGA5OW6R71WOB2FLrMEJHmQzjyftiNthtPksVcYI9R
         yObfimirqvimS9TdgWwUXpds4IIVxrdrbOqZY5C79ru0Z5aG5iZMZD4dQDg43Sb0IO4W
         mT8UMqS/IBgE1z0Ex0ihSpPD+8barFQKe2xI25tEdsxlD2xRqeiFCDzeH8T/0lmH/4VI
         nZmw==
X-Gm-Message-State: AOJu0Yw3CNv54b1YMS/jySMJukP+Qo9ua6UASLkpsvQnB+d1Pz+MvcCr
	qKk+JAUFyH+CMhWh7e/f+hVjwaKDkeSXkSFfVOxEm80x9Q9Zw04l/dXGzG5JDA==
X-Gm-Gg: AeBDietHUtkYs4vclQQzDSsV2jlvq0Spl3seexLSag5dXNsPd2c5JrmnjFukO6RS/1i
	Rzbed16eBzjLr4+TPoeUDNTh8oRf5u8jsPiHrJrwlVv64luHJJQCUHSh1RkjgEZpZRzrD3lcb8Q
	oAzdhskmM39q4JJ6pJSJrpTwVPe4WyfMJpTHAEY/l2ZRujGCOlJKp886sp6JMSg+QjVfzcZ/xu+
	8U4Wg0pS5Amnh48W4t6G3u1EEaxwBqkCMW1lR6kPulnDiUGFjDA4bt/yZva9miHJhZBbIxgBgGi
	NUSh95ibYwC0UYXND1/qhIXMPcu2CqfUbWx/JwNmtsezZFXOSalwgbLE5XWfbGR33c0X84kIe0h
	NSczlp2pWv5kiefRLCbWkBEEkYFl8us+87qP/T6XSnh+hOg+Vuf+ZMkzhW6o0f5LZVYg23lgtP5
	+14ElnwTcdx7ikWo5LH/pDUQZApxo=
X-Received: by 2002:a05:622a:134c:b0:50d:82ca:7c9c with SMTP id d75a77b69052e-50dd5adaf18mr367676941cf.14.1776297487244;
        Wed, 15 Apr 2026 16:58:07 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1ad9663bsm29892611cf.4.2026.04.15.16.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 16:58:06 -0700 (PDT)
Message-Id: <607ed38e2a8ae94266b4a3d51610e604cca8df4f.1776297482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2088.git.1776297482.gitgitgadget@gmail.com>
References: <pull.2088.git.1776297482.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 23:58:02 +0000
Subject: [PATCH 3/3] backfill: default to grabbing edge blobs too
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Commit 302aff09223f (backfill: accept revision arguments, 2026-03-26) added
support for accepting revision arguments to backfill.  This allows users
to do things like

   git backfill --remotes ^v2.3.0

and then run many commands without triggering on-demand downloads of
blobs.  However, if they have topics based on v2.3.0, they will likely
still trigger on-demand downloads.  Consider, for example, the command

   git log -p v2.3.0..topic

This would still trigger on-demand blob loadings after the backfill
command above, because the commit(s) with A as a parent will need to
diff against the blobs in A.  In fact, multiple commands need blobs from
the lower boundary of the revision range:

   * git log -p A..B                # After backfill A..B
   * git replay --onto TARGET A..B  # After backfill TARGET^! A..B
   * git checkout A && git merge B  # After backfill A...B

Add an extra --[no-]include-edges flag to allow grabbing blobs from
edge commits.  Since the point of backfill is to prevent on-demand blob
loading and these are common commands, default to --include-edges.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-backfill.adoc |   9 ++-
 builtin/backfill.c              |   8 ++-
 t/t5620-backfill.sh             | 110 ++++++++++++++++++++++++++++++--
 3 files changed, 119 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-backfill.adoc b/Documentation/git-backfill.adoc
index bf26d7694f..c0a3b80615 100644
--- a/Documentation/git-backfill.adoc
+++ b/Documentation/git-backfill.adoc
@@ -9,7 +9,7 @@ git-backfill - Download missing objects in a partial clone
 SYNOPSIS
 --------
 [synopsis]
-git backfill [--min-batch-size=<n>] [--[no-]sparse] [<revision-range>]
+git backfill [--min-batch-size=<n>] [--[no-]sparse] [--[no-]include-edges] [<revision-range>]
 
 DESCRIPTION
 -----------
@@ -63,6 +63,13 @@ OPTIONS
 	current sparse-checkout. If the sparse-checkout feature is enabled,
 	then `--sparse` is assumed and can be disabled with `--no-sparse`.
 
+`--include-edges`::
+`--no-include-edges`::
+	Include blobs from boundary commits in the backfill.  Useful in
+	preparation for commands like `git log -p A..B` or `git replay
+	--onto TARGET A..B`, where A..B normally excludes A but you need
+	the blobs from A as well.  `--include-edges` is the default.
+
 `<revision-range>`::
 	Backfill only blobs reachable from commits in the specified
 	revision range.  When no _<revision-range>_ is specified, it
diff --git a/builtin/backfill.c b/builtin/backfill.c
index e934d360fd..7ffab2ea74 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -26,7 +26,7 @@
 #include "path-walk.h"
 
 static const char * const builtin_backfill_usage[] = {
-	N_("git backfill [--min-batch-size=<n>] [--[no-]sparse] [<revision-range>]"),
+	N_("git backfill [--min-batch-size=<n>] [--[no-]sparse] [--[no-]include-edges] [<revision-range>]"),
 	NULL
 };
 
@@ -35,6 +35,7 @@ struct backfill_context {
 	struct oid_array current_batch;
 	size_t min_batch_size;
 	int sparse;
+	int include_edges;
 	struct rev_info revs;
 };
 
@@ -116,6 +117,8 @@ static int do_backfill(struct backfill_context *ctx)
 	/* Walk from HEAD if otherwise unspecified. */
 	if (!ctx->revs.pending.nr)
 		add_head_to_pending(&ctx->revs);
+	if (ctx->include_edges)
+		ctx->revs.edge_hint = 1;
 
 	info.blobs = 1;
 	info.tags = info.commits = info.trees = 0;
@@ -143,12 +146,15 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 		.min_batch_size = 50000,
 		.sparse = -1,
 		.revs = REV_INFO_INIT,
+		.include_edges = 1,
 	};
 	struct option options[] = {
 		OPT_UNSIGNED(0, "min-batch-size", &ctx.min_batch_size,
 			     N_("Minimum number of objects to request at a time")),
 		OPT_BOOL(0, "sparse", &ctx.sparse,
 			 N_("Restrict the missing objects to the current sparse-checkout")),
+		OPT_BOOL(0, "include-edges", &ctx.include_edges,
+			 N_("Include blobs from boundary commits in the backfill")),
 		OPT_END(),
 	};
 	struct repo_config_values *cfg = repo_config_values(the_repository);
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index f3b5e39493..94f35ce190 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -257,11 +257,12 @@ test_expect_success 'backfill with revision range' '
 	git -C backfill-revs rev-list --quiet --objects --missing=print HEAD >missing &&
 	test_line_count = 48 missing &&
 
-	git -C backfill-revs backfill HEAD~2..HEAD &&
+	GIT_TRACE2_EVENT="$(pwd)/backfill-trace" git -C backfill-revs backfill HEAD~2..HEAD &&
 
-	# 30 objects downloaded.
+	# 36 objects downloaded, 12 still missing
+	test_trace2_data promisor fetch_count 36 <backfill-trace &&
 	git -C backfill-revs rev-list --quiet --objects --missing=print HEAD >missing &&
-	test_line_count = 18 missing
+	test_line_count = 12 missing
 '
 
 test_expect_success 'backfill with revisions over stdin' '
@@ -279,11 +280,12 @@ test_expect_success 'backfill with revisions over stdin' '
 	^HEAD~2
 	EOF
 
-	git -C backfill-revs backfill --stdin <in &&
+	GIT_TRACE2_EVENT="$(pwd)/backfill-trace" git -C backfill-revs backfill --stdin <in &&
 
-	# 30 objects downloaded.
+	# 36 objects downloaded, 12 still missing
+	test_trace2_data promisor fetch_count 36 <backfill-trace &&
 	git -C backfill-revs rev-list --quiet --objects --missing=print HEAD >missing &&
-	test_line_count = 18 missing
+	test_line_count = 12 missing
 '
 
 test_expect_success 'backfill with prefix pathspec' '
@@ -398,6 +400,102 @@ test_expect_success 'backfill with --since' '
 	test_line_count = 6 missing
 '
 
+test_expect_success 'backfill range with include-edges enables fetch-free git-log' '
+	git clone --no-checkout --filter=blob:none	\
+		--single-branch --branch=main		\
+		"file://$(pwd)/srv.bare" backfill-log &&
+
+	# Backfill the range with default include edges.
+	git -C backfill-log backfill HEAD~2..HEAD &&
+
+	# git log -p needs edge blobs for the "before" side of
+	# diffs.  With edge inclusion, all needed blobs are local.
+	GIT_TRACE2_EVENT="$(pwd)/log-trace" git \
+		-C backfill-log log -p HEAD~2..HEAD >log-output &&
+
+	# No promisor fetches should have been needed.
+	! grep "fetch_count" log-trace
+'
+
+test_expect_success 'backfill range without include edges causes on-demand fetches in git-log' '
+	git clone --no-checkout --filter=blob:none	\
+		--single-branch --branch=main		\
+		"file://$(pwd)/srv.bare" backfill-log-no-bdy &&
+
+	# Backfill WITHOUT include edges -- file.3 v1 blobs are missing.
+	git -C backfill-log-no-bdy backfill --no-include-edges HEAD~2..HEAD &&
+
+	# git log -p HEAD~2..HEAD computes diff of commit 7 against
+	# commit 6.  It needs file.3 v1 (the "before" side), which was
+	# not backfilled.  This triggers on-demand promisor fetches.
+	GIT_TRACE2_EVENT="$(pwd)/log-no-bdy-trace" git \
+		-C backfill-log-no-bdy log -p HEAD~2..HEAD >log-output &&
+
+	grep "fetch_count" log-no-bdy-trace
+'
+
+test_expect_success 'backfill range enables fetch-free replay' '
+	# Create a repo with a branch to replay.
+	git init replay-src &&
+	(
+		cd replay-src &&
+		git config uploadpack.allowfilter 1 &&
+		git config uploadpack.allowanysha1inwant 1 &&
+		test_commit base &&
+		git checkout -b topic &&
+		test_commit topic-change &&
+		git checkout main &&
+		test_commit main-change
+	) &&
+	git clone --bare --filter=blob:none \
+		"file://$(pwd)/replay-src" replay-dest.git &&
+
+	# Backfill the replay range: --onto main, replaying topic~1..topic.
+	# For replay, we need TARGET^! plus the range.
+	main_oid=$(git -C replay-dest.git rev-parse main) &&
+	topic_oid=$(git -C replay-dest.git rev-parse topic) &&
+	base_oid=$(git -C replay-dest.git rev-parse topic~1) &&
+	git -C replay-dest.git backfill \
+		"$main_oid^!" "$base_oid..$topic_oid" &&
+
+	# Now replay should complete without any promisor fetches.
+	GIT_TRACE2_EVENT="$(pwd)/replay-trace" git -C replay-dest.git \
+		replay --onto main topic~1..topic >replay-out &&
+
+	! grep "fetch_count" replay-trace
+'
+
+test_expect_success 'backfill enables fetch-free merge' '
+	# Create a repo with two branches to merge.
+	git init merge-src &&
+	(
+		cd merge-src &&
+		git config uploadpack.allowfilter 1 &&
+		git config uploadpack.allowanysha1inwant 1 &&
+		test_commit merge-base &&
+		git checkout -b side &&
+		test_commit side-change &&
+		git checkout main &&
+		test_commit main-side-change
+	) &&
+	git clone --filter=blob:none \
+		"file://$(pwd)/merge-src" merge-dest &&
+
+	# The clone checked out main, fetching its blobs.
+	# Backfill the three endpoint commits needed for merge.
+	main_oid=$(git -C merge-dest rev-parse origin/main) &&
+	side_oid=$(git -C merge-dest rev-parse origin/side) &&
+	mbase=$(git -C merge-dest merge-base origin/main origin/side) &&
+	git -C merge-dest backfill --no-include-edges \
+		"$main_oid^!" "$side_oid^!" "$mbase^!" &&
+
+	# Merge should complete without promisor fetches.
+	GIT_TRACE2_EVENT="$(pwd)/merge-trace" git -C merge-dest \
+		merge origin/side -m "test merge" &&
+
+	! grep "fetch_count" merge-trace
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
gitgitgadget
