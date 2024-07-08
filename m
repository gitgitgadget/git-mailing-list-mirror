Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908823F9F9
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431294; cv=none; b=e85PNRvcc6ExpPNq5KMXfKm7cflDgAmENWpmI7nf49fElibCxT9S7anLHC+LwrfGncdby0lsIa6wNFL325o9FSjUfYJu0DG68+LJSrJQ/Lm/j1hYq/8h/06w9qsydts7RW7qF7saq584ZMPjs96VCH4Kb0ONR1NfE36g5axILLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431294; c=relaxed/simple;
	bh=K95yzm2a/C+iZKKx7sVplqrPSZ7ZhQxwr1GKWjxORS0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ZO15yNwlY85uBn6kAf2v5EaIJdsIIVCNYZlFfXT2k5g5Cwhl9ETeFVTIcbY+WzBd8cu66lrO+YqGZsPbxjJ5LaI0znoRwetBquxPU/1tDuMCW7+aMeyTKZBcKMjHuazfy5p8vU4wvSb6RevsbpoDC44GK9LmAaHWuue5Qqnlxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ab31LQAz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab31LQAz"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367a9ab4d81so1612396f8f.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 02:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720431290; x=1721036090; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p01aN8X+DEXXwHtgFZYD+1ZPNzNQlsvKMddTJesP6pE=;
        b=ab31LQAz69LljM2OHKKyxbQDg/Z7Soz3nE9aHehR+sGK1uIuwesovSNyeASgdsdk2l
         gHjQkm1h/YJVe66Z0ZmqP6/8IFFVTz1TS1Xzqr2SxINUUMqikS2yZ5qpjel+gzjStJxt
         NnqXxGhBnWe4/0IP2kdrSPbpE1et1oYVSD40DoQ+S4UZBScRY032PFAyDPkEYZkTNVt+
         z6WnsGS20iC69q3mulWDbpQfPHYXf9Rw2o8vD/OtjM+YdAcvELCGQV1ai7ufy4JVMOG7
         0dURPtLONkQNIy7lRAn6DROEPy2cepIjIecJ1uRNqBm1FQKARF4dIirq4Pji9dmbd/HF
         DF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720431290; x=1721036090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p01aN8X+DEXXwHtgFZYD+1ZPNzNQlsvKMddTJesP6pE=;
        b=BViyqM+nwp17sv/gIY0yJUMlAp0w1BTQn4Czb8MWM3N4domPDne5GBGYZPouDxPfIW
         kmIgwTf/YNdmacR8y1d0fh7epVbdkVg14+mlnmU3ld2ULIItRbqdWjQE/MKaB41RJEGX
         LMWRgfqg7ftl0CcSkHYfZre59B0VjSavNoGNSsZ1bFgqgjBxdrGZHYg3QBHLkfVknLOg
         cMx/CstcivvzMvU1utGd3sut6fTHBwmo+MeVyA7lCQKupj0pAKBJvW3iVoZ95V4BLS6T
         jvlfCsQdvuKsOsiV8nHZg6gn4J4UFYi92YoGLU8Z1UGxlClMT877nVFXhUZlRJojuGI/
         1XLw==
X-Gm-Message-State: AOJu0YzpfULIUVgqvzXedXaDnyouvYRFF6FU8Rk/QwEmBlzhgHOoNuUS
	1G9xIWw3u5ovtlrhW630LeGQImRVTdxEZlqTmsdnaoUGTisepDtJ8fP9kA==
X-Google-Smtp-Source: AGHT+IEfLzdbfxNvE1sSgHV0kTnSVQdTadB2IMVmTixUk20HJAYNgkYnusQBOI6wZpduRAC4tpfuUA==
X-Received: by 2002:adf:fccf:0:b0:367:9854:791d with SMTP id ffacd0b85a97d-3679dd723d2mr8012698f8f.43.1720431289863;
        Mon, 08 Jul 2024 02:34:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679224d11dsm13221782f8f.12.2024.07.08.02.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:34:49 -0700 (PDT)
Message-Id: <pull.1743.git.git.1720431288496.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Jul 2024 09:34:48 +0000
Subject: [PATCH] merge-recursive: honor diff.algorithm
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
Cc: Antonin Delpeuch <antonin@delpeuch.eu>,
    Antonin Delpeuch <antonin@delpeuch.eu>

From: Antonin Delpeuch <antonin@delpeuch.eu>

The documentation claims that "recursive defaults to the diff.algorithm
config setting", but this is currently not the case. This fixes it,
ensuring that diff.algorithm is used when -Xdiff-algorithm is not
supplied. This affects the following porcelain commands: "merge",
"rebase", "cherry-pick", "pull", "stash", "log", "am" and "checkout".
It also affects the "merge-tree" ancillary interrogator.

This change also affects the "replay" and "merge-recursive" plumbing
commands, which happen to call 'merge_recursive_config' and therefore
are also affected by other configuration variables read in this
function. For instance theay read "diff.renames", classified in diff.c
as a diff "UI" config variable. Removing the reliance of those
commands on this set of configuration variables feels like a bigger
change and introducing an argument to 'merge_recursive_config' to
prevent only the newly added diff.algorithm to be read by plumbing
commands feels like muddying the architecture, as this function
should likely not be called at all by plumbing commands.

Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
---
    merge-recursive: honor diff.algorithm

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1743%2Fwetneb%2Frecursive_respects_diff.algorithm-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1743/wetneb/recursive_respects_diff.algorithm-v1
Pull-Request: https://github.com/git/git/pull/1743

 builtin/merge-recursive.c   |  4 ++++
 builtin/replay.c            |  4 ++++
 merge-recursive.c           |  7 ++++++
 t/t3515-cherry-pick-diff.sh | 41 +++++++++++++++++++++++++++++++++++
 t/t3515/base.c              | 17 +++++++++++++++
 t/t3515/ours.c              | 17 +++++++++++++++
 t/t3515/theirs.c            | 17 +++++++++++++++
 t/t7615-merge-diff.sh       | 43 +++++++++++++++++++++++++++++++++++++
 8 files changed, 150 insertions(+)
 create mode 100755 t/t3515-cherry-pick-diff.sh
 create mode 100644 t/t3515/base.c
 create mode 100644 t/t3515/ours.c
 create mode 100644 t/t3515/theirs.c
 create mode 100755 t/t7615-merge-diff.sh

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index c2ce044a201..c14158fd1db 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -31,6 +31,10 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix UNUSED)
 	char *better1, *better2;
 	struct commit *result;
 
+	/*
+	 * FIXME: This reads various config variables,
+	 * which 'merge-recursive' should ignore as a plumbing command
+	 */
 	init_merge_options(&o, the_repository);
 	if (argv[0] && ends_with(argv[0], "-subtree"))
 		o.subtree_shift = "";
diff --git a/builtin/replay.c b/builtin/replay.c
index 6bf0691f15d..98feb6f6320 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -373,6 +373,10 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 
+	/*
+	 * FIXME: This reads various config variables,
+	 * which 'replay' should ignore as a plumbing command
+	 */
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
 	merge_opt.show_rename_progress = 0;
diff --git a/merge-recursive.c b/merge-recursive.c
index 46ee364af73..205fb8aa72d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3930,6 +3930,13 @@ static void merge_recursive_config(struct merge_options *opt)
 		} /* avoid erroring on values from future versions of git */
 		free(value);
 	}
+	if (!git_config_get_string("diff.algorithm", &value)) {
+		long diff_algorithm = parse_algorithm_value(value);
+		if (diff_algorithm < 0)
+			die(_("unknown value for config '%s': %s"), "diff.algorithm", value);
+		opt->xdl_opts = (opt->xdl_opts & ~XDF_DIFF_ALGORITHM_MASK) | diff_algorithm;
+		free(value);
+	}
 	git_config(git_xmerge_config, NULL);
 }
 
diff --git a/t/t3515-cherry-pick-diff.sh b/t/t3515-cherry-pick-diff.sh
new file mode 100755
index 00000000000..caeaa01c590
--- /dev/null
+++ b/t/t3515-cherry-pick-diff.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='git cherry-pick
+
+Testing the influence of the diff algorithm on the merge output.'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	cp "$TEST_DIRECTORY"/t3515/base.c file.c &&
+	git add file.c &&
+	git commit -m c0 &&
+	git tag c0 &&
+	cp "$TEST_DIRECTORY"/t3515/ours.c file.c &&
+	git add file.c &&
+	git commit -m c1 &&
+	git tag c1 &&
+	git reset --hard c0 &&
+	cp "$TEST_DIRECTORY"/t3515/theirs.c file.c &&
+	git add file.c &&
+	git commit -m c2 &&
+	git tag c2
+'
+
+test_expect_success 'cherry-pick c2 to c1 with recursive merge strategy fails with the current default myers diff algorithm' '
+	git reset --hard c1 &&
+	test_must_fail git cherry-pick -s recursive c2
+'
+
+test_expect_success 'cherry-pick c2 to c1 with recursive merge strategy succeeds with -Xdiff-algorithm=histogram' '
+	git reset --hard c1 &&
+	git cherry-pick --strategy recursive -Xdiff-algorithm=histogram c2
+'
+
+test_expect_success 'cherry-pick c2 to c1 with recursive merge strategy succeeds with diff.algorithm = histogram' '
+	git reset --hard c1 &&
+	git config diff.algorithm histogram &&
+	git cherry-pick --strategy recursive c2
+'
+test_done
diff --git a/t/t3515/base.c b/t/t3515/base.c
new file mode 100644
index 00000000000..c64abc59366
--- /dev/null
+++ b/t/t3515/base.c
@@ -0,0 +1,17 @@
+int f(int x, int y)
+{
+        if (x == 0)
+        {
+                return y;
+        }
+        return x;
+}
+
+int g(size_t u)
+{
+        while (u < 30)
+        {
+                u++;
+        }
+        return u;
+}
diff --git a/t/t3515/ours.c b/t/t3515/ours.c
new file mode 100644
index 00000000000..44d82513970
--- /dev/null
+++ b/t/t3515/ours.c
@@ -0,0 +1,17 @@
+int g(size_t u)
+{
+        while (u < 30)
+        {
+                u++;
+        }
+        return u;
+}
+
+int h(int x, int y, int z)
+{
+        if (z == 0)
+        {
+                return x;
+        }
+        return y;
+}
diff --git a/t/t3515/theirs.c b/t/t3515/theirs.c
new file mode 100644
index 00000000000..85f02146fee
--- /dev/null
+++ b/t/t3515/theirs.c
@@ -0,0 +1,17 @@
+int f(int x, int y)
+{
+        if (x == 0)
+        {
+                return y;
+        }
+        return x;
+}
+
+int g(size_t u)
+{
+        while (u > 34)
+        {
+                u--;
+        }
+        return u;
+}
diff --git a/t/t7615-merge-diff.sh b/t/t7615-merge-diff.sh
new file mode 100755
index 00000000000..be335c7c3d1
--- /dev/null
+++ b/t/t7615-merge-diff.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='git merge
+
+Testing the influence of the diff algorithm on the merge output.'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	cp "$TEST_DIRECTORY"/t3515/base.c file.c &&
+	git add file.c &&
+	git commit -m c0 &&
+	git tag c0 &&
+	cp "$TEST_DIRECTORY"/t3515/ours.c file.c &&
+	git add file.c &&
+	git commit -m c1 &&
+	git tag c1 &&
+	git reset --hard c0 &&
+	cp "$TEST_DIRECTORY"/t3515/theirs.c file.c &&
+	git add file.c &&
+	git commit -m c2 &&
+	git tag c2
+'
+
+GIT_TEST_MERGE_ALGORITHM=recursive
+
+test_expect_success 'merge c2 to c1 with recursive merge strategy fails with the current default myers diff algorithm' '
+	git reset --hard c1 &&
+	test_must_fail git merge -s recursive c2
+'
+
+test_expect_success 'merge c2 to c1 with recursive merge strategy succeeds with -Xdiff-algorithm=histogram' '
+	git reset --hard c1 &&
+	git merge --strategy recursive -Xdiff-algorithm=histogram c2
+'
+
+test_expect_success 'merge c2 to c1 with recursive merge strategy succeeds with diff.algorithm = histogram' '
+	git reset --hard c1 &&
+	git config diff.algorithm histogram &&
+	git merge --strategy recursive c2
+'
+test_done

base-commit: 06e570c0dfb2a2deb64d217db78e2ec21672f558
-- 
gitgitgadget
