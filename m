Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794211426;
	b=0H4Z22b87gsjfMvQj1PV0pub3MxwhBzdsimzlr7Ql2eASoEsGEwu3NcWEmWBJ7zKF8jh
	 E2PLTktU7+DC48n7TAUMbiyqGzB4kf0b1lzrTKk0FnGqJ/8qIQ560Au/fmwqGe8822zj6
	 d7//WAnuAndLlXV/PZC2vcB7hiUNkNe/gMtOJAQzHcGvePcJbuFckI3BcrqKtWa2HkVwq
	 V8byGQDeBWp3CNVYw9PiB1SD5BV3KUNzeht18DPocbytrLgw3pUv2jxBdxiM5s5OP833a
	 bd9mUdt3PZGHIuKA+p8DXabBMm2fU/+KGppL3U0UFesaW0ZzUZiNdSY6GrFROYxCxPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211426;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
	 X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=IlSHCdTVYIhTNSRK7VjapT1ivPPTad4XMSBLVi8xuPQ=;
	b=Ky01XkV/JknXfzLLUAxzrl4WGwRq/0mKQjj8dMd3IFL50dH2qdQie3Br8BvB6jooacFo
	 eNRE4/FYmkKnEDu1MdWCHxPU5akpUD+jPQZb9WVferkd+eBV+bbCMDTDaSZhxNFo+3NJc
	 PlbcoQpbCTUtFpCcvgC5VkB0wLPxFQdbP0/e1qqyDqu+jjrxw30Ou7ViGUmjo+z0XUsRY
	 qKsiX0bHVU3QSUbDU1h5W8RX/V4UUGCt1oO4LESlTRA1AzWu6IQvpiBwqdypLYV8Ln2yo
	 DnxW3tR5qVrDv9Zfg36FtK3JCEChRTnEy5bt2mLce+j1/np9pcv6bYZ1LJARv29IYLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=NA86arPT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022CF60A2604
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 08:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 022CF60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=NA86arPT
ARC-Seal: i=1; a=rsa-sha256; t=1794211419; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LBEZ8JB7ZloBxJcLpSUdd8N46x0uq4P93nq5KP1pzYVviWcvc8GKveLEjsmSGl7iocnzTWbKMqnzrqPVVbQv/aHZMR6InGoCS05gsKK2vVhZ7tpGnD1oL4QcTnv482+jiCSRLwhUSrLv8Y0ofnVBLjdXxhPHixaIEr3UFoHwigQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794211419; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IlSHCdTVYIhTNSRK7VjapT1ivPPTad4XMSBLVi8xuPQ=; 
	b=P3MAAW+sXNC2gN66yWt/6Hk+RTt+AO1q5x7ZkPGiyS5bbqKbJTY9C9SCWquo8sW1VWi7LoLETwny6e6CjP8LLAEL1rwbh/Vp1OwaHUm3Neh3JpFv3RPgpNb45MPHbBR+UP+09pidZQtqFaEBF8XZqOHg8uawh9zY9Q1Iy/2Silo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=NA86arPT7pwf2HZMj8PlLETNfMESfZd/yP6A7hueLIvQ/7VU5g10h/oIuNCGYhdmv/oZP95er/voOsYNCHkyheNh97BpqNUWLYUV/mya/6lTmNnTgQwB2Mcn0QjAGahplM5rBXnasRlMxO+ocG0JSPRyDGw6F1Fd0e3nP+lsmvI=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=IlSHCdTVYIhTNSRK7VjapT1ivPPTad4XMSBLVi8xuPQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794211417034301.6013857319824;
	Mon, 9 Nov 2026 00:03:37 -0800 (PST)
Date: Mon, 9 Nov 2026 09:03:33 +0100
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: [PATCH v5 0/5] log: speed up --follow following renames for
 non-linear history
Message-ID: <cover.1794078554.git.vmiklos@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793298331.git.vmiklos@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.182.33
X-ZohoMailClient: External

Hi Patrick,

Thanks for the reviews of v4. Changes in v5:

- The fix of the old 6/6 is now squashed into the speedup patch (5/5),
  so no commit in the series loses history, and its test is moved to
  1/5. While at it, I simplified 5/5: instead of two passes of diffs
  against the parents, it first finds a parent where the path is
  unchanged, and then only diffs against the other parents if they
  still need renames to be followed. Because of the squash, the
  range-diff pairs the new 5/5 with the old 6/6.

- 5/5 now also follows renames when a parent has no merge base with
  the parent where the path is unchanged, e.g. a subtree merge of
  unrelated histories. Added a test for this to 1/5.

- 5/5 now also follows copies, not only renames, when the merge dropped
  the edit of the copy source. Added your test for this to 1/5. With
  this, the linux.git case takes about 42s, instead of 37s.

Thanks,

Miklos

Miklos Vajna (5):
  t4219: test more --follow cases across merges
  log: extract showing the remerge/combined diff of a merge commit
  log: fix -m --follow losing the history of later parents
  log: simplify --follow following renames for non-linear history
  log: speed up --follow following renames for non-linear history

 log-tree.c                  | 258 +++++++++++++++++++++++++++++-------
 t/t4219-log-follow-merge.sh | 230 ++++++++++++++++++++++++++++++++
 2 files changed, 438 insertions(+), 50 deletions(-)

Range-diff against v4:
1:  aabf5652c9 ! 1:  5512aa682f t4219: test more --follow cases across merges
    @@ Commit message
         t4219: test more --follow cases across merges
     
         A later commit in this series will speed up 'git log --follow' for
    -    merge commits. Add tests for cases which already work, but had no
    +    merge commits. Add tests for cases which already work, but have no
         test coverage, so it's easy to break them while optimizing:
     
    +    - a subtree merge adding the history of a file that was copied before
         - --follow through a fork with renames on both sides, with -c, --cc
           and --remerge-diff
         - a --no-ff merge taking a rename from the second parent, in both commit
    @@ Commit message
         - a merge keeping the path, while the other side renamed it
         - --diff-merges=first-parent, which diffs merges only against their
           first parent, but still walks all parents
    +    - a merge keeping the renamed path, while the other side edited the old
    +      one
    +    - a merge keeping the copied path, while the other side edited the
    +      original
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
     
      ## t/t4219-log-follow-merge.sh ##
    +@@ t/t4219-log-follow-merge.sh: test_expect_success '--follow finds the pre-merge commit through a subtree merge
    + 	test_cmp expect actual
    + '
    + 
    ++test_expect_success 'setup subtree merge adding the history of a copied file' '
    ++	git init graft &&
    ++	echo outer >graft/outer.txt &&
    ++	git -C graft add outer.txt &&
    ++	test_tick &&
    ++	git -C graft commit -m "outer init" &&
    ++	mkdir graft/inner &&
    ++	cp inner/inner.txt graft/inner/ &&
    ++	git -C graft add inner &&
    ++	test_tick &&
    ++	git -C graft commit -m "copy inner.txt to inner/" &&
    ++
    ++	git -C graft fetch ../inner master &&
    ++	test_tick &&
    ++	git -C graft merge -s ours --allow-unrelated-histories \
    ++		-m "Merge the history of inner/" FETCH_HEAD
    ++'
    ++
    ++test_expect_success '--follow finds the history of a copied file through a subtree merge' '
    ++	git -C graft log --follow --pretty=tformat:%s inner/inner.txt >actual &&
    ++	cat >expect <<-\EOF &&
    ++	copy inner.txt to inner/
    ++	inner init
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    + test_expect_success 'setup merge of two branches that both renamed a file to README' '
    + 	git init foo &&
    + 	mkdir foo/foo &&
     @@ t/t4219-log-follow-merge.sh: test_expect_success '--follow follows renames through a fork in a single history
      	test_cmp expect actual.sorted
      '
    @@ t/t4219-log-follow-merge.sh: test_expect_success '--follow follows renames throu
     +	EOF
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'setup merge keeping the renamed path, other side edited the old one' '
    ++	git init keep-renamed &&
    ++	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >keep-renamed/F &&
    ++	git -C keep-renamed add F &&
    ++	test_tick &&
    ++	git -C keep-renamed commit -m "O: add F" &&
    ++	git -C keep-renamed branch B &&
    ++	git -C keep-renamed mv F G &&
    ++	test_tick &&
    ++	git -C keep-renamed commit -m "A1: rename F to G on master" &&
    ++
    ++	git -C keep-renamed checkout B &&
    ++	printf "line 1\nline 2\nline 3\nline 4 T\nline 5\n" >keep-renamed/F &&
    ++	test_tick &&
    ++	git -C keep-renamed commit -am "B2: update F on B" &&
    ++
    ++	git -C keep-renamed checkout master &&
    ++	test_tick &&
    ++	git -C keep-renamed merge -s ours -m "M: merge B, keep G, drop F" B
    ++'
    ++
    ++test_expect_success '--follow follows an edit on the side the merge did not take' '
    ++	git -C keep-renamed log --follow --pretty=tformat:%s G >actual &&
    ++	cat >expect <<-\EOF &&
    ++	B2: update F on B
    ++	A1: rename F to G on master
    ++	O: add F
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'setup merge keeping the copied path, other side edited the original' '
    ++	git init keep-copied &&
    ++	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >keep-copied/F &&
    ++	git -C keep-copied add F &&
    ++	test_tick &&
    ++	git -C keep-copied commit -m "O: add F" &&
    ++	git -C keep-copied branch B &&
    ++	cp keep-copied/F keep-copied/G &&
    ++	git -C keep-copied add G &&
    ++	test_tick &&
    ++	git -C keep-copied commit -m "A1: copy F to G on master" &&
    ++
    ++	git -C keep-copied checkout B &&
    ++	printf "line 1\nline 2\nline 3\nline 4 T\nline 5\n" >keep-copied/F &&
    ++	test_tick &&
    ++	git -C keep-copied commit -am "B2: update F on B" &&
    ++
    ++	git -C keep-copied checkout master &&
    ++	test_tick &&
    ++	git -C keep-copied merge -s ours -m "M: merge B, keep F and G" B
    ++'
    ++
    ++test_expect_success '--follow follows an edit of the copy source on the side the merge did not take' '
    ++	git -C keep-copied log --follow --pretty=tformat:%s G >actual &&
    ++	cat >expect <<-\EOF &&
    ++	B2: update F on B
    ++	A1: copy F to G on master
    ++	O: add F
    ++	EOF
    ++	test_cmp expect actual
    ++'
     +
      test_done
2:  b172890bf4 = 2:  f36129714b log: extract showing the remerge/combined diff of a merge commit
3:  6586e8f004 = 3:  85b6067fbd log: fix -m --follow losing the history of later parents
4:  b903152bc4 ! 4:  5ba93e49cf log: simplify --follow following renames for non-linear history
    @@ Commit message
         log: simplify --follow following renames for non-linear history
     
         Code added in 304812ed33 (log: improve --follow following renames for
    -    non-linear history, 2026-06-22) implemented the feature by introducing a
    +    non-linear history, 2026-06-22) implements the feature by introducing a
         new propagate_follow_pathspec_to_parent() function which adds a new call
         to diff_tree_oid(). Also it introduces a new loop to record what path
         each parent of a merge commit should use when following a path.
     
    -    This was working, but it caused a performance regression: e.g. 'git log
    -    --stat --follow -- include/linux/rsc_table.h' in linux.git went from 28s
    -    to 6m43s. The new code diffs each merge against each of its parents with
    -    rename detection, which is expensive when a parent doesn't have the
    -    followed path yet. Fixing this would require adding even more custom
    -    code, instead of just extending the existing code in log_tree_diff(). So
    -    first simplify the code here, and fix the performance regression in a
    -    follow-up commit.
    +    This works, but it causes a performance regression: e.g. 'git log
    +    --stat --follow -- include/linux/rsc_table.h' in linux.git takes 6m43s,
    +    while it took 28s before that commit. The new code diffs each merge
    +    against each of its parents with rename detection, which is expensive
    +    when a parent doesn't have the followed path yet. Fixing this would
    +    require adding even more custom code, instead of just extending the
    +    existing code in log_tree_diff(). So first simplify the code here, and
    +    fix the performance regression in a follow-up commit.
     
         Remove propagate_follow_pathspec_to_parent() and the loop calling it
         for each parent. Instead, record the path to follow for each parent in
    -    the parent loop of log_tree_diff(), right after diff_tree_oid() updated
    +    the parent loop of log_tree_diff(), right after diff_tree_oid() updates
         the pathspec in case of a rename. Merges are not diffed by default, so
         with --follow, run the same loop for them as well, but without showing
         anything. With -c, --cc or --remerge-diff, show the merge diff after the
5:  072d90b865 < -:  ---------- log: speed up --follow following renames for non-linear history
6:  7be8cfb3ba ! 5:  ddcac2115e log: fix --follow following an edit on a side the merge did not take
    @@ Metadata
     Author: Miklos Vajna <vmiklos@collabora.com>
     
      ## Commit message ##
    -    log: fix --follow following an edit on a side the merge did not take
    +    log: speed up --follow following renames for non-linear history
     
    -    Take a history where F is renamed to G on master, F is edited on a side
    -    branch, and the side branch is merged with '-s ours', so the merge keeps
    -    G and drops F. Here 'git log --follow G' doesn't show the edit of F on
    -    the side branch, while it did before the previous commit.
    +    Test the performance of 'git log --stat --follow --
    +    include/linux/rsc_table.h' on linux.git: since commit 304812ed33 (log:
    +    improve --follow following renames for non-linear history, 2026-06-22),
    +    it takes 6m43s, while it took about 28 seconds before.
     
    -    The problem is that follow_needs_renames() only searches for renames in
    -    a parent without the path if the merge base still has the path, which
    -    covers the case when the parent renamed the path. Here the other side
    -    of the merge did the rename, so the merge base only has the old name.
    -    The parent is then told to follow G, which it doesn't have, and the
    -    history of F on its side is lost. Searching for renames in each parent
    -    that lacks the path would fix this, but that is the expensive search
    -    that the previous commit avoids, e.g. 148 merges hit this case for
    -    include/linux/rsc_table.h in linux.git.
    +    What happens is that log_tree_diff() diffs each merge against all of its
    +    parents with rename following. diff_tree_oid() only does the expensive
    +    rename detection when the path is added relative to a parent, but that
    +    is common for merges, e.g. when a branch forked before the path was
    +    created merges mainline, and this slows down 'git log --follow'.
     
    -    Fix the problem by also searching for renames when the merge base
    -    doesn't have the path, but the parent changed a file since the merge
    -    base that the merge no longer has: only such a file can be the old name
    -    of the path that still needs to be followed in the parent. This check
    -    is cheap, since it only diffs the changes of the side branch, and it
    -    rules out 146 of the 148 merges in linux.git. Then do a plain rename
    -    detection from the parent to the merge, which only looks at the files
    -    deleted by the merge, not at all files of the parent like --follow does.
    +    Fix the problem by first diffing the merge against its parents without
    +    rename following, to find a parent where the path is unchanged. If there
    +    is such a parent, then skip the diff against the other parents and just
    +    follow the same path there. The exception is a parent that doesn't have
    +    the path, but still needs renames to be followed:
    +    - The merge base has the path, i.e. that side renamed or removed it, or
    +      there is no merge base, e.g. a subtree merge of unrelated histories.
    +    - The merge base doesn't have the path, but the parent changed a file
    +      since then, and the merge dropped that change. A copy detection also
    +      finds that file as the source of the path, i.e. the other side renamed
    +      or copied the path from that file.
    +    If the path changed relative to all parents, then diff against them with
    +    rename following, as before. Given that this way a parent may be asked
    +    to follow a path that it doesn't have, also adjust
    +    remember_follow_pathspec(): if children disagree on what should be the
    +    path for a commit, then prefer the path that exists in that commit.
     
    -    Reported-by: Patrick Steinhardt <ps@pks.im>
    +    Now the above use case takes 42s, somewhat close to the original cost.
    +
    +    Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
     
      ## log-tree.c ##
    +@@
    + #include "range-diff.h"
    + #include "strmap.h"
    + #include "tree.h"
    ++#include "tree-walk.h"
    + #include "wildmatch.h"
    + #include "write-or-die.h"
    + #include "pager.h"
     @@ log-tree.c: static void set_pathspec_to_single_path(struct pathspec *ps, const char *path)
      		       PATHSPEC_LITERAL_PATH, "", paths);
      }
      
    --static int commit_has_path(struct rev_info *opt, struct commit *c,
    --			   const char *path)
     +static int tree_has_path(struct rev_info *opt, struct object_id *tree,
     +			 const char *path)
    - {
    - 	struct object_id oid;
    - 	unsigned short mode;
    - 
    ++{
    ++	struct object_id oid;
    ++	unsigned short mode;
    ++
     +	return !get_tree_entry(opt->diffopt.repo, tree, path, &oid, &mode);
     +}
     +
     +static int commit_has_path(struct rev_info *opt, struct commit *c,
     +			   const char *path)
     +{
    - 	parse_commit_or_die(c);
    --	return !get_tree_entry(opt->diffopt.repo, get_commit_tree_oid(c), path,
    --			       &oid, &mode);
    ++	parse_commit_or_die(c);
     +	return tree_has_path(opt, get_commit_tree_oid(c), path);
    - }
    - 
    ++}
    ++
      static void remember_follow_pathspec(struct rev_info *opt,
    + 				     struct commit *c, const char *path)
    + {
    +@@ log-tree.c: static void remember_follow_pathspec(struct rev_info *opt,
    + 		init_follow_pathspec_slab(opt->follow_pathspec_slab);
    + 	}
    + 	slot = follow_pathspec_slab_at(opt->follow_pathspec_slab, c);
    +-	if (*slot && !strcmp(*slot, path))
    +-		return;
    ++	/* If children of 'c' disagree on the path, prefer the one 'c' has. */
    ++	if (*slot) {
    ++		if (!strcmp(*slot, path) || commit_has_path(opt, c, *slot) ||
    ++		    !commit_has_path(opt, c, path))
    ++			return;
    ++	}
    + 	free(*slot);
    + 	*slot = xstrdup(path);
    + }
     @@ log-tree.c: void release_follow_pathspec_slab(struct rev_info *opt)
      	FREE_AND_NULL(opt->follow_pathspec_slab);
      }
      
    ++/* Find a parent where 'path' is the same as in the merge. */
    ++static struct commit *follow_same_parent(struct rev_info *opt,
    ++					 struct commit_list *parents,
    ++					 struct object_id *merge_tree)
    ++{
    ++	struct commit *same = NULL;
    ++
    ++	opt->diffopt.flags.follow_renames = 0;
    ++	for (; parents && !same; parents = parents->next) {
    ++		parse_commit_or_die(parents->item);
    ++		diff_tree_oid(get_commit_tree_oid(parents->item), merge_tree,
    ++			      "", &opt->diffopt);
    ++		if (!diff_queued_diff.nr)
    ++			same = parents->item;
    ++		diff_queue_clear(&diff_queued_diff);
    ++	}
    ++	opt->diffopt.flags.follow_renames = 1;
    ++	return same;
    ++}
    ++
     +/*
    -+ * Did 'parent' change a file since 'base' that the merge (with tree 'oid') no
    -+ * longer has? Only such a file can be the source of a rename on the other side
    -+ * of the merge that still needs to be followed in 'parent'.
    ++ * Did 'parent' change a file since 'base', but the merge tree dropped that
    ++ * change? I.e. the merge doesn't have the file or it's the same as in 'same'.
     + */
     +static int follow_parent_changed_dropped_file(struct rev_info *opt,
     +					      struct commit *base,
     +					      struct commit *parent,
    -+					      struct object_id *oid)
    ++					      struct commit *same,
    ++					      struct object_id *merge_tree)
     +{
     +	struct diff_options diff_opts;
     +	int i, ret = 0;
    @@ log-tree.c: void release_follow_pathspec_slab(struct rev_info *opt)
     +		      "", &diff_opts);
     +	for (i = 0; i < diff_queued_diff.nr && !ret; i++) {
     +		struct diff_filepair *p = diff_queued_diff.queue[i];
    ++		struct object_id merge_oid, same_oid;
    ++		unsigned short mode;
     +
    -+		ret = DIFF_FILE_VALID(p->two) &&
    -+		      !tree_has_path(opt, oid, p->two->path);
    ++		if (!DIFF_FILE_VALID(p->two))
    ++			continue;
    ++		if (get_tree_entry(opt->diffopt.repo, merge_tree, p->two->path,
    ++				   &merge_oid, &mode))
    ++			ret = 1;
    ++		else
    ++			ret = !oideq(&merge_oid, &p->two->oid) &&
    ++			      !get_tree_entry(opt->diffopt.repo,
    ++					      get_commit_tree_oid(same),
    ++					      p->two->path, &same_oid, &mode) &&
    ++			      oideq(&merge_oid, &same_oid);
     +	}
     +	diff_queue_clear(&diff_queued_diff);
     +	diff_free(&diff_opts);
     +	return ret;
     +}
     +
    -+/*
    -+ * Is 'path' in the merge (with tree 'oid') renamed from a file of 'parent'?
    -+ * Only look at the files that the merge deleted, not at all files of 'parent'
    -+ * like --follow does.
    -+ */
    ++/* Is 'path' in the merge tree renamed or copied from a file of 'parent'? */
     +static int follow_has_rename_source(struct rev_info *opt,
     +				    struct commit *parent,
    -+				    struct object_id *oid, const char *path)
    ++				    struct object_id *merge_tree,
    ++				    const char *path)
     +{
     +	struct diff_options diff_opts;
     +	int i, ret = 0;
     +
     +	repo_diff_setup(opt->diffopt.repo, &diff_opts);
     +	diff_opts.flags.recursive = 1;
    -+	diff_opts.detect_rename = DIFF_DETECT_RENAME;
    ++	diff_opts.detect_rename = DIFF_DETECT_COPY;
     +	diff_opts.rename_score = opt->diffopt.rename_score;
     +	diff_opts.single_follow = path;
     +	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
     +	diff_setup_done(&diff_opts);
    -+	diff_tree_oid(get_commit_tree_oid(parent), oid, "", &diff_opts);
    ++	diff_tree_oid(get_commit_tree_oid(parent), merge_tree, "", &diff_opts);
     +	diffcore_std(&diff_opts);
     +	for (i = 0; i < diff_queued_diff.nr && !ret; i++) {
     +		struct diff_filepair *p = diff_queued_diff.queue[i];
     +
    -+		ret = p->status == DIFF_STATUS_RENAMED &&
    ++		ret = (p->status == DIFF_STATUS_RENAMED ||
    ++		       p->status == DIFF_STATUS_COPIED) &&
     +		      !strcmp(p->two->path, path);
     +	}
     +	diff_queue_clear(&diff_queued_diff);
    @@ log-tree.c: void release_follow_pathspec_slab(struct rev_info *opt)
     +	return ret;
     +}
     +
    - /*
    -  * When the path in a merge is the same as in 'same', does the path still need
    -  * renames to be followed in 'parent'? Only if the merge has the path, 'parent'
    -- * doesn't have it, but its fork point with 'same' had it, e.g. 'parent'
    -- * renamed the path.
    -+ * doesn't have it, and either:
    -+ *
    -+ * - its fork point with 'same' had it, e.g. 'parent' renamed the path, or
    -+ * - 'same' renamed the path from a file that 'parent' changed.
    -  */
    - static int follow_needs_renames(struct rev_info *opt, struct commit *parent,
    --				struct commit *same, const char *path)
    -+				struct commit *same, struct object_id *oid,
    -+				const char *path)
    - {
    - 	struct commit_list *bases = NULL, *base;
    --	int ret = 0;
    ++/*
    ++ * When the path in a merge tree is the same as in 'same', does the path still
    ++ * need renames to be followed in 'parent'?
    ++ */
    ++static int follow_needs_renames(struct rev_info *opt, struct commit *parent,
    ++				struct commit *same,
    ++				struct object_id *merge_tree, const char *path)
    ++{
    ++	struct commit_list *bases = NULL, *base;
     +	int ret = 0, changed_dropped = 0;
    - 
    - 	if (commit_has_path(opt, parent, path) ||
    - 	    !commit_has_path(opt, same, path))
    - 		return 0;
    - 	if (repo_get_merge_bases(opt->diffopt.repo, parent, same, &bases) < 0)
    - 		exit(128);
    --	for (base = bases; base && !ret; base = base->next)
    ++
    ++	if (parent == same || commit_has_path(opt, parent, path) ||
    ++	    !commit_has_path(opt, same, path))
    ++		return 0;
    ++	if (repo_get_merge_bases(opt->diffopt.repo, parent, same, &bases) < 0)
    ++		exit(128);
    ++	/* Unrelated histories, e.g. a subtree merge */
    ++	ret = !bases;
     +	for (base = bases; base && !ret; base = base->next) {
    - 		ret = commit_has_path(opt, base->item, path);
    ++		ret = commit_has_path(opt, base->item, path);
     +		if (!ret && !changed_dropped)
     +			changed_dropped = follow_parent_changed_dropped_file(
    -+				opt, base->item, parent, oid);
    ++				opt, base->item, parent, same, merge_tree);
     +	}
    - 	commit_list_free(bases);
    ++	commit_list_free(bases);
     +	if (!ret && changed_dropped)
    -+		ret = follow_has_rename_source(opt, parent, oid, path);
    - 	return ret;
    - }
    ++		ret = follow_has_rename_source(opt, parent, merge_tree, path);
    ++	return ret;
    ++}
    ++
    + /* Show the remerge or combined diff of a merge commit */
    + static int log_tree_merge_diff(struct rev_info *opt, struct commit *commit,
    + 			       struct commit_list *parents,
    +@@ log-tree.c: static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
    + 	int all_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
    + 	int follow_only = 0;
    + 	char *path = NULL;
    ++	struct commit *same = NULL;
      
    + 	if (!all_need_diff && !opt->merges_need_diff)
    + 		return 0;
     @@ log-tree.c: static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
    - 			     parents = parents->next) {
    - 				if (parents->item != parent &&
    - 				    follow_needs_renames(opt, parents->item,
    --							 parent, path))
    -+							 parent, oid, path))
    - 					tail = &commit_list_insert(parents->item,
    - 								   tail)->next;
    - 				else
    -
    - ## t/t4219-log-follow-merge.sh ##
    -@@ t/t4219-log-follow-merge.sh: test_expect_success '--follow with --diff-merges=first-parent follows all parent
    - 	test_cmp expect actual
    - '
    + 	if (opt->diffopt.flags.follow_renames)
    + 		path = xstrdup_or_null(
    + 			pathspec_single_path(&opt->diffopt.pathspec));
    ++	if (path && is_merge && (follow_only || opt->first_parent_merges))
    ++		same = follow_same_parent(opt, parents, oid);
      
    -+test_expect_success 'setup merge keeping the renamed path, other side edited the old one' '
    -+	git init keep-renamed &&
    -+	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >keep-renamed/F &&
    -+	git -C keep-renamed add F &&
    -+	test_tick &&
    -+	git -C keep-renamed commit -m "O: add F" &&
    -+	git -C keep-renamed branch B &&
    -+	git -C keep-renamed mv F G &&
    -+	test_tick &&
    -+	git -C keep-renamed commit -m "A1: rename F to G on master" &&
    -+
    -+	git -C keep-renamed checkout B &&
    -+	printf "line 1\nline 2\nline 3\nline 4 T\nline 5\n" >keep-renamed/F &&
    -+	test_tick &&
    -+	git -C keep-renamed commit -am "B2: update F on B" &&
    -+
    -+	git -C keep-renamed checkout master &&
    -+	test_tick &&
    -+	git -C keep-renamed merge -s ours -m "M: merge B, keep G, drop F" B
    -+'
    -+
    -+test_expect_success '--follow follows an edit on the side the merge did not take' '
    -+	git -C keep-renamed log --follow --pretty=tformat:%s G >actual &&
    -+	cat >expect <<-\EOF &&
    -+	B2: update F on B
    -+	A1: rename F to G on master
    -+	O: add F
    -+	EOF
    -+	test_cmp expect actual
    -+'
    -+
    - test_done
    + 	showed_log = 0;
    + 	all_parents = parents;
    +@@ log-tree.c: static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
    + 		struct commit *parent = parents->item;
    + 
    + 		parse_commit_or_die(parent);
    +-		diff_tree_oid(get_commit_tree_oid(parent),
    +-			      oid, "", &opt->diffopt);
    ++		/*
    ++		 * Same as in a parent: follow the path as-is, unless renames
    ++		 * still need to be followed in this parent.
    ++		 */
    ++		if (!follow_only || !same ||
    ++		    follow_needs_renames(opt, parent, same, oid, path))
    ++			diff_tree_oid(get_commit_tree_oid(parent),
    ++				      oid, "", &opt->diffopt);
    + 		if (follow_only) {
    + 			diff_queue_clear(&diff_queued_diff);
    + 			opt->diffopt.found_follow = 0;
-- 
2.51.0

