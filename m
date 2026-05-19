Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04AD438FF5
	for <git@vger.kernel.org>; Tue, 19 May 2026 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194610; cv=none; b=emrycMxb4a2RSDe7UoXdBok54/nr9IvlNRcABnTg1kx/wYcC+vd4fdR+0EbuRF2+20yEGw5IB/EhAIdE+Wg28bFCWrSWTaUzumsvgE/ziqcY+IHHpNtxFJEb0HALvl0MaYJfmXq+b28X+qG8xQQoq3kajEBePWJA/NibU+SAq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194610; c=relaxed/simple;
	bh=mjoyNUhDooKF2tSlYtdvGyl7i3WjQD/DTvDF8/g1L+A=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=SHys/YDY10+x9DzZ3jGe4z0EqL+lgoWHLKzz5yz3xHR3GW+TFppPY60dzODS3I4/LkYWmpMHmuryGDG6qsFuzNNm7cS3Y3Duen+XA0Bs/PVdvNCHQjkL2hKhGyqMAG7O1hwGLsS8rgATdGv7sozFzQdNIj9f95uDUtLGQd+vsEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9x0aFW7; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9x0aFW7"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-132c338a537so2750663c88.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779194608; x=1779799408; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xl5Qn1pdLaE4te2O2dhGdhAVREDUikneIu8cWYJIPEg=;
        b=W9x0aFW7QTg4hM4Zrcq8Gpsqy/+uFlqv/reu4kQ/q45Q8Ff1GeCj/sp3F4Id8AufHB
         YJxhrfdZY1JcUGQIHyII9cX/druKK9jWITq3gNQWNWWkvfExvKWUfT6qN6PFbVW7RypX
         wX4+z59tGuq7rYI2f5DSFgWBQteIhdFaHc7dFjFnsas9GEU8a3btq1SYHqxW2FWabKxZ
         QVqYAWurIXCAmyU99d3hV62M9lS0zZ+YWHzKUKTf0ooknxvKFfe/k0YiE/aLpTsm+8t9
         ofOgLfOBn14S92DNj9UvQ3LLhjCSMHX9PyShc1FIHiEkTjw4dLXmSYL6XEKXgSlO4p2m
         dRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779194608; x=1779799408;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xl5Qn1pdLaE4te2O2dhGdhAVREDUikneIu8cWYJIPEg=;
        b=fOGqhk8X8FawYOu/MuObIdq2vFSFG/7XjBUVvXHgkfZbZR1ajRRdm/Q+j0LUcfOvO3
         wO/IFVsIwOUJpEvtC8BnUFmh+e8tuEjZ8CqL3P9Uvz9ra3JMtvvqQTSJvP0ju+nTRR5G
         Q0W9kOtW5UGrgf532GjN1+OvGgM6/QxXT2dCazO4XyJf8MQ37ipRaEbmuI6kU4aBfE/G
         8JWbQ1PKE7zQvVVgoq1I73puc/7A2C1x2QtCYabdZqJFlnzmD2D3DDY0+5nmwHEKaoaX
         1Jvy7Drug083oqAJ15NDcs3O5lZPhyLxcNRnynFUPHjMKdP7cUemkmLnWO52Ai/ndefR
         iCEQ==
X-Gm-Message-State: AOJu0YxcguRQKSuSGqN9Nac1fe+LcrtpDgjQVcBMQRofQenC5WMc/qzz
	DppTYcrPKyoV2hhDckYG6GHNpxQzep1Ae5eHOsGYzJy+VnEWUQDaeb5JM0EI9w==
X-Gm-Gg: Acq92OHdoblvbemIHQZ4Tp1xEhlZ+w4aG+0MJLlxCltZErj4BwXW/eymsUDvVq2tB0v
	3t4mnIaIfR37Oa6w/Q/43T+4Lv2vzKPs8uBfjAPVqrscXcj1p8rO2YoQ4FBWRAJlB+4pUPuuo+8
	r6x+hqLiHVLDnWfqJAsFiHuZZStORAN1Cvejcw25nvj/TA/5myYquPxkrJvmKhwS7TgUlUk96PI
	lFx8HQqjVAXT4gxkn+9OU4+P7PA6vguQxBENUrOSVSISAfXWJBjfu1dajEbGjEnwm22kpessSPy
	KcN91IWOVBR3VAvpiRWmkMiDZtdxULR4pS9AzQT1EZjEXeYF4cdmHWpFUjol7sjxdPa4fkEkImH
	Z805/09BlLfJT3GekY2HPd7P+Zm/QDZGE6F4rN+mLDw0b25BVlY+y6EANWPnpJUI7uc3TXoJIBZ
	IQGnqDKjy9e+fwLhLbS3+i+g83WJFj
X-Received: by 2002:a05:7022:238f:b0:135:60db:3412 with SMTP id a92af1059eb24-13560db354bmr4389226c88.10.1779194607386;
        Tue, 19 May 2026 05:43:27 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2352f2sm22899340c88.10.2026.05.19.05.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 05:43:26 -0700 (PDT)
Message-Id: <pull.2306.git.git.1779194605735.gitgitgadget@gmail.com>
From: "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 May 2026 12:43:25 +0000
Subject: [PATCH] stash: reuse cached index entries in --patch temporary index
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
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Victoria Dye <vdye@github.com>,
    Adam Johnson <me@adamj.eu>,
    Adam Johnson <me@adamj.eu>

From: Adam Johnson <me@adamj.eu>

`git stash -p` prepares the interactive selection by creating a
temporary index at HEAD, switching `GIT_INDEX_FILE` to it, and then
running the `add -p` machinery.

That temporary index was created by running `git read-tree HEAD`.  The
resulting index had no useful cached stat data or fsmonitor-valid bits
from the real index.  When `run_add_p()` refreshed that temporary index
before showing the first prompt, it could end up lstat(2)-ing every
tracked file, even in a repository where `git diff` and `git restore -p`
can use fsmonitor to avoid that work.

Create the temporary index in-process instead.  Use `unpack_trees()` to
reset the real index contents to HEAD while writing the result to the
temporary index path.  For paths whose index entries already match HEAD,
`oneway_merge()` reuses the existing cache entries, preserving their
cached stat data and `CE_FSMONITOR_VALID` state.

This makes the refresh performed by `run_add_p()` behave like the one
used by `git restore -p`: unchanged paths can be skipped via fsmonitor
instead of being scanned again.

In a 206k file repository with `core.fsmonitor` enabled and a one-line
change in one file, time to first prompt dropped from 34.774 seconds to
0.659 seconds.

Signed-off-by: Adam Johnson <me@adamj.eu>
---
    stash: reuse cached index entries in --patch temporary index

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2306%2Fadamchainz%2Faj%2Foptimize-stash-patch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2306/adamchainz/aj/optimize-stash-patch-v1
Pull-Request: https://github.com/git/git/pull/2306

 builtin/stash.c        | 71 ++++++++++++++++++++++++++++++++++++++----
 t/t3904-stash-patch.sh | 18 +++++++++++
 2 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 32dbc97b47..48189cb9f7 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -372,6 +372,57 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	return 0;
 }
 
+static int create_index_from_tree(const struct object_id *tree_id,
+				  const char *index_path)
+{
+	int nr_trees = 1;
+	int ret = 0;
+	struct unpack_trees_options opts;
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct tree *tree;
+	struct index_state dst_istate = INDEX_STATE_INIT(the_repository);
+	struct lock_file lock_file = LOCK_INIT;
+
+	repo_read_index_preload(the_repository, NULL, 0);
+	if (refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL))
+		return -1;
+
+	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
+
+	memset(&opts, 0, sizeof(opts));
+
+	tree = repo_parse_tree_indirect(the_repository, tree_id);
+	if (!tree || repo_parse_tree(the_repository, tree)) {
+		ret = -1;
+		goto done;
+	}
+
+	init_tree_desc(t, &tree->object.oid, tree->buffer, tree->size);
+
+	opts.head_idx = 1;
+	opts.src_index = the_repository->index;
+	opts.dst_index = &dst_istate;
+	opts.merge = 1;
+	opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
+	opts.fn = oneway_merge;
+
+	if (unpack_trees(nr_trees, t, &opts)) {
+		ret = -1;
+		goto done;
+	}
+
+	if (write_locked_index(&dst_istate, &lock_file, COMMIT_LOCK)) {
+		ret = error(_("unable to write new index file"));
+		goto done;
+	}
+
+done:
+	release_index(&dst_istate);
+	if (ret)
+		rollback_lock_file(&lock_file);
+	return ret;
+}
+
 static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1321,18 +1372,26 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 		       struct interactive_options *interactive_opts)
 {
 	int ret = 0;
-	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
 	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
+	struct commit *head_commit;
+	const struct object_id *head_tree;
 	struct index_state istate = INDEX_STATE_INIT(the_repository);
 	char *old_index_env = NULL, *old_repo_index_file;
 
 	remove_path(stash_index_path.buf);
 
-	cp_read_tree.git_cmd = 1;
-	strvec_pushl(&cp_read_tree.args, "read-tree", "HEAD", NULL);
-	strvec_pushf(&cp_read_tree.env, "GIT_INDEX_FILE=%s",
-		     stash_index_path.buf);
-	if (run_command(&cp_read_tree)) {
+	head_commit = lookup_commit(the_repository, &info->b_commit);
+	if (!head_commit || repo_parse_commit(the_repository, head_commit)) {
+		ret = -1;
+		goto done;
+	}
+	head_tree = get_commit_tree_oid(head_commit);
+	if (!head_tree) {
+		ret = -1;
+		goto done;
+	}
+
+	if (create_index_from_tree(head_tree, stash_index_path.buf)) {
 		ret = -1;
 		goto done;
 	}
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index 90a4ff2c10..4b3241c8cd 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -84,6 +84,24 @@ test_expect_success 'none of this moved HEAD' '
 	verify_saved_head
 '
 
+test_expect_success 'stash -p with unmodified tracked files present' '
+	git reset --hard &&
+	echo line1 >alpha &&
+	echo line1 >beta &&
+	git add alpha beta &&
+	git commit -m "add alpha and beta" &&
+	echo line2 >>alpha &&
+	echo y | git stash -p &&
+	echo line1 >expect &&
+	test_cmp expect alpha &&
+	test_cmp expect beta &&
+	git stash pop &&
+	printf "line1\nline2\n" >expect &&
+	test_cmp expect alpha &&
+	echo line1 >expect &&
+	test_cmp expect beta
+'
+
 test_expect_success 'stash -p with split hunk' '
 	git reset --hard &&
 	cat >test <<-\EOF &&

base-commit: 7bcaabddcf68bd0702697da5904c3b68c52f94cf
-- 
gitgitgadget
