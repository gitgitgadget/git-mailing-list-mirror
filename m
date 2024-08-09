Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C7179203
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188298; cv=none; b=huXuXE3/Mq7L9ci0GEDiy/jg1hdsTxeoBeC4uY/gbHtmdWGNHPX/M1sWecwN3mjVE/5FIzydLJ89uG3WCwDNcC6NkRG7dz/Y9niQAXOr15/5QjVkxVob9YD6D7fJ0J7CmZnl6VMT+C2a4tfaESbu3drFcjQi1bb0hSqGY+TXQsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188298; c=relaxed/simple;
	bh=fNXK61M9UXorvfJV3vl/CDVcLlzlPaGSNPIvrjb93Uw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LAhR9RNnfrcxZm/i+BBAYmFERdmNRYmOgNS04MIHutd5IzfHjPvp0y+WQvKXs2MluafZAZxrQZL6X0pNqgAXgRNUoGHZTK08LLvC2/x6MS5b7ldeAggz3Gk7dq9y8ttMIW3xEuHUlg4PJ94pPR4ZBnl3v4jYV43mc4/Yze/KM88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un2NaGJ9; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un2NaGJ9"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so22594051fa.2
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 00:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723188294; x=1723793094; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXBwKbr85svcBfzFpRvxqLd67h/nfYJ1X3D9XtTozJs=;
        b=Un2NaGJ9Z3jf2qz1iqLD7tiI7fwS2QdV+For1Jpk3ZXmQ1S+dY35CpkyoiCngmex/S
         uYRNKK4a+/KuZPzVtjhk1VHbw4rPai+kOs5v0F2NWp7VPWzW6PoFZUfJU6aGH6VQv8Ee
         vVKibA2EJ0JuNwP0iRkmJWUMoYx8sVwEM1reJfNUOKMPGfjWDaNGrwfct3VhaT0fC/lW
         NLeQFbYFDYCU4NcYPyWtdBQ8k3HRzNzzLHFXJItnimK71//npiS7bKuUaHXP+pI65XGl
         /zlYq1gGWuJ5dnzLn+cILMyrhpeLwf8tIm/f9xGJuVcjnRWJ+KBhYoMz13NKssYML7Fx
         grsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723188294; x=1723793094;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXBwKbr85svcBfzFpRvxqLd67h/nfYJ1X3D9XtTozJs=;
        b=D+0Uv7Ir2fmP+1hHxaQY6PI6wn1DjueQV8/3QNmuXZ6hNQzSI8lHWifmi8rzEsasXa
         LSkZUcCTVulSCn9D1+L8+12AnOfID2AFwklL6hTNqlM+KXuN2OOPo/Y7JqI6A5ed39D2
         SQj4BP/f/CHuYHym+0x/o+FWDL1kjHiKyc61+2C4gTbu7tDXQy2X+i7grnwyZ5k34558
         djQkFBDjlCOMa7UjC9n4CaQ804xng0xgJld6BrlHbC2gSSXwxU/QLOvtP5qH/TYX+WxK
         Bcrk8bqW1KQm53dCYTCT2x98UMVZCGEnFn1A7NxGhELh4KmLsbM/tGr8E168AvbD/iek
         ymsg==
X-Gm-Message-State: AOJu0YzwORlfXiSiVGCxq3U3EAEZrCGJSm7EMWZcdclOtfGNc5ls8o+I
	F1XpL557Yi3k7Ae4Gn6i/YHdJanmSMBJXxB8T2+prPWTAHcTNIh6f/ei4w==
X-Google-Smtp-Source: AGHT+IFrKG1EhcvSrcJ7Kv4Y4Y3DywZMXF4VkQIUHH01o5wNgkcwwmrBUUIIf3uL4U23x8KRDc6JKQ==
X-Received: by 2002:a2e:a541:0:b0:2f0:25dc:1894 with SMTP id 38308e7fff4ca-2f1a6c4c99cmr6906021fa.2.1723188294062;
        Fri, 09 Aug 2024 00:24:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c74a96bsm61827925e9.24.2024.08.09.00.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 00:24:53 -0700 (PDT)
Message-Id: <pull.1771.v2.git.1723188292498.gitgitgadget@gmail.com>
In-Reply-To: <pull.1771.git.1723123250958.gitgitgadget@gmail.com>
References: <pull.1771.git.1723123250958.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Aug 2024 07:24:52 +0000
Subject: [PATCH v2] diff-tree: fix crash when used with --remerge-diff
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
Cc: Elijah Newren <newren@gmail.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

When using "git-diff-tree" to get the tree diff for merge commits with
the diff format set to `remerge`, a bug is triggered as shown below:

  $ git diff-tree -r --remerge-diff 363337e6eb
  363337e6eb812d0c0d785ed4261544f35559ff8b
  BUG: log-tree.c:1006: did a remerge diff without remerge_objdir?!?

This bug is reported by `log-tree.c:do_remerge_diff`, where a bug check
added in commit 7b90ab467a (log: clean unneeded objects during log
--remerge-diff, 2022-02-02) detects the absence of `remerge_objdir` when
attempting to clean up temporary objects generated during the remerge
process.

After some further digging, I find that the remerge-related diff options
were introduced in db757e8b8d (show, log: provide a --remerge-diff
capability, 2022-02-02), which also affect the setup of `rev_info` for
"git-diff-tree", but were not accounted for in the original
implementation (inferred from the commit message).

Elijah Newren, the author of the remerge diff feature, notes that other
callers of `log-tree.c:log_tree_commit` (the only caller of
`log-tree.c:do_remerge_diff`) also exist, but:

  `builtin/am.c`: manually sets all flags; remerge_diff is not among them
  `sequencer.c`: manually sets all flags; remerge_diff is not among them

so `builtin/diff-tree.c` really is the only caller that was overlooked
when remerge-diff functionality was added.

This commit resolves the crash by adding `remerge_objdir` setup logic to
`builtin/diff-tree.c`, mirroring `builtin/log.c:cmd_log_walk_no_free`.
It also includes the necessary cleanup for `remerge_objdir`.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
    diff-tree: fix crash when used with --remerge-diff

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1771%2Fblanet%2Fxx%2Ffix-diff-tree-crash-on-remerge-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1771/blanet/xx/fix-diff-tree-crash-on-remerge-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1771

Range-diff vs v1:

 1:  f0b86faa275 ! 1:  57f0b1247d8 diff-tree: fix crash when used with --remerge-diff
     @@ Commit message
          When using "git-diff-tree" to get the tree diff for merge commits with
          the diff format set to `remerge`, a bug is triggered as shown below:
      
     -        $ git diff-tree -r --remerge-diff 363337e6eb
     -        363337e6eb812d0c0d785ed4261544f35559ff8b
     -        BUG: log-tree.c:1006: did a remerge diff without remerge_objdir?!?
     +      $ git diff-tree -r --remerge-diff 363337e6eb
     +      363337e6eb812d0c0d785ed4261544f35559ff8b
     +      BUG: log-tree.c:1006: did a remerge diff without remerge_objdir?!?
      
          This bug is reported by `log-tree.c:do_remerge_diff`, where a bug check
          added in commit 7b90ab467a (log: clean unneeded objects during log
     @@ Commit message
          "git-diff-tree", but were not accounted for in the original
          implementation (inferred from the commit message).
      
     -    This commit fixes the bug by adding initialization logic for
     -    `remerge_objdir` in `builtin/diff-tree.c`, mirroring the logic in
     -    `builtin/log.c:cmd_log_walk_no_free`. A final cleanup for
     -    `remerge_objdir` is also included.
     +    Elijah Newren, the author of the remerge diff feature, notes that other
     +    callers of `log-tree.c:log_tree_commit` (the only caller of
     +    `log-tree.c:do_remerge_diff`) also exist, but:
      
     +      `builtin/am.c`: manually sets all flags; remerge_diff is not among them
     +      `sequencer.c`: manually sets all flags; remerge_diff is not among them
     +
     +    so `builtin/diff-tree.c` really is the only caller that was overlooked
     +    when remerge-diff functionality was added.
     +
     +    This commit resolves the crash by adding `remerge_objdir` setup logic to
     +    `builtin/diff-tree.c`, mirroring `builtin/log.c:cmd_log_walk_no_free`.
     +    It also includes the necessary cleanup for `remerge_objdir`.
     +
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
      
       ## builtin/diff-tree.c ##
      @@
     + #include "read-cache-ll.h"
       #include "repository.h"
       #include "revision.h"
     - #include "tree.h"
      +#include "tmp-objdir.h"
     + #include "tree.h"
       
       static struct rev_info log_tree_opt;
     - 
      @@ builtin/diff-tree.c: int cmd_diff_tree(int argc, const char **argv, const char *prefix)
       
       	opt->diffopt.rotate_to_strict = 1;


 builtin/diff-tree.c     | 13 +++++++++++++
 t/t4069-remerge-diff.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 0d3c611aac0..b8df1d4b79b 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -8,6 +8,7 @@
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "revision.h"
+#include "tmp-objdir.h"
 #include "tree.h"
 
 static struct rev_info log_tree_opt;
@@ -166,6 +167,13 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 
 	opt->diffopt.rotate_to_strict = 1;
 
+	if (opt->remerge_diff) {
+		opt->remerge_objdir = tmp_objdir_create("remerge-diff");
+		if (!opt->remerge_objdir)
+			die(_("unable to create temporary object directory"));
+		tmp_objdir_replace_primary_odb(opt->remerge_objdir, 1);
+	}
+
 	/*
 	 * NOTE!  We expect "a..b" to expand to "^a b" but it is
 	 * perfectly valid for revision range parser to yield "b ^a",
@@ -230,5 +238,10 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		diff_free(&opt->diffopt);
 	}
 
+	if (opt->remerge_diff) {
+		tmp_objdir_destroy(opt->remerge_objdir);
+		opt->remerge_objdir = NULL;
+	}
+
 	return diff_result_code(&opt->diffopt);
 }
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 07323ebafe0..ca8f999caba 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -110,6 +110,41 @@ test_expect_success 'can filter out additional headers with pickaxe' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'remerge-diff also works for git-diff-tree' '
+	# With a clean merge
+	git diff-tree -r -p --remerge-diff --no-commit-id bc_resolution >actual &&
+	test_must_be_empty actual &&
+
+	# With both a resolved conflict and an unrelated change
+	cat <<-EOF >tmp &&
+	diff --git a/numbers b/numbers
+	remerge CONFLICT (content): Merge conflict in numbers
+	index a1fb731..6875544 100644
+	--- a/numbers
+	+++ b/numbers
+	@@ -1,13 +1,9 @@
+	 1
+	 2
+	-<<<<<<< b0ed5cb (change_a)
+	-three
+	-=======
+	-tres
+	->>>>>>> 6cd3f82 (change_b)
+	+drei
+	 4
+	 5
+	 6
+	 7
+	-eight
+	+acht
+	 9
+	EOF
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
+	git diff-tree -r -p --remerge-diff --no-commit-id ab_resolution >tmp &&
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup non-content conflicts' '
 	git switch --orphan base &&
 

base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
-- 
gitgitgadget
