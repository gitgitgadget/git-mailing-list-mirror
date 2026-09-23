Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715964E379B
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168357; cv=none; b=DnVv997m+LVqVTNAd/GAjs5DNTS/6SyQ6fzqa7NA3rasCVcaTJpofpXWdAHXRGGuAFzpz81TRpNl1HS7ogLW+tVOZPa6SmOMHspMb9VbffEvLl17+GXGuSq9lHvuwKxuWHtTfqW/Q2CiQWc3s1Pe1PtrF23+n7so7KK/rOaQEdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168357; c=relaxed/simple;
	bh=kI3ScaxlVjE/h6slE3vXwsXzUtfCkCC1pHRnFecQIyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjGLbawXJAXAVDkSeGq561TZV/M5miLVlVr+KuW1XkzwYO+jMXLCmjc9cX7nyfoVnNBwZfVcIrTatHFuR+CcK1pxgM9zKlc8pQdPzs5FLke98txJlTVsoWPoFwcMAT8OgCeM9DolIndRDtH7yB9lAXLYcmAyeeuky+d6krjT5Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfGiWYsA; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfGiWYsA"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66fb93aee5eso884001d50.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790168354; x=1790773154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kiivDX+mOq6N21iBPmaAL6ab8LO7HNHQ9Z298kURAUw=;
        b=bfGiWYsAajDPAiW9CcUyL1JjshZnAqYHTzTK8qCnVoAMzsICdRTzJ18zqs/yGffiLk
         7mPrs1nh5IcMl4bj13RiGq+9/EgNMCJ8ZUIhXsAvLe/DRqsacEK83A4ZfbVZxeG3U0AR
         BlW2kDFj9G7g58rmg2mV7twHbAKMSb3njM7nMzphQJJcVVHIU12r1cgW+8A0QnBbEf23
         tfPjrN/okcFmh4Aa09puAyhrHknEtDHojnvodN55zcAiUJmzlB7gcNXy7DkH8Ylr0Hia
         1C70CXG7gBavc/F6YTuW0lOr5ZL7agISiqGeI1iZdjQgFPa3xaD2L9eiP7tmyphAhKax
         JGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790168354; x=1790773154;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kiivDX+mOq6N21iBPmaAL6ab8LO7HNHQ9Z298kURAUw=;
        b=x0TNLubTYIo5FNRQZLrSOCc49pn38zVxRHzU2br9zRN6Ywk4AVjvzD3ui/LI+eJOZo
         pvwGSqWPlKp985cnRLNwJwhZ1u9Bej+tXj8U68bYJescz5bjIlWSlReR+l6+7iWXI1vl
         U5CwovdkPUMBFtOOyOS/AtzMn5lW+fptfW1BAEM9mTa1nwvNzPZCM/IZRAL8/pq7lFIM
         jpYty0lOGrKWin2bc+WhJzE285qBYyb9udh5iI7hNGUKcXo2Y5/YwJiaoXwTdyIyXV/P
         J4pSChgJwZs4nnCY1YMvAme+wYMPmHR8MvTGuBSfxQh6dW93DazjjrZsZ7y3KM80+3te
         mMTw==
X-Gm-Message-State: AFuF++kmobjn8nPxRPsCSwIwRsXb4UvPkckb6+eafIvArG4aPSufB8uZ
	wx0wlLtHxlXL7OIMRFIx0J40r+l4AfcFfVI5p5wEvX2P4STm/D5Q7V9XyF69Cyar
X-Gm-Gg: AYBFou24c2d6wzP1YDNMmMMPD8uOtqATWdebvBVQV3zdOnZ3GkW7oIwIYqyWvsU5cw4
	HmKCOWvyCvp9VQ1Mddt5sXECQ/T3kdH6YWKXuCn8WVKBk0CBrZ+0ORWDi5NNveZpr/bFP87x8Ng
	YUMI99pAEmBRQu8JjKvsALVwk6Q92ycEvAHpZi3pZVjmhddKUlpjfHa7BZD35t3aiqZSih1VGAA
	kAgyyOurSvKy3F07v6Npfc1Vw/fSPYweedc6IY0lERMTKla9dCyo9ZSn+TPJa7KHBq3f1nPkUuk
	CyM+Aqm4D3yH0e9HkRd42eDFTmYMk3rxmD6EbsQieJGndFRuvRNdUosy2p+D278sx6UlyVM2pH3
	PRYgrCqCqFYIHJqeo4U022j576lXLg7aKMb2szfTl+ar/yYHUsvqtuMlbcXEJPgY+rOFD4ZtYH3
	UHb/Yoz5N0pl9ywk3NAvrt8J5RsQ3V9AYhyhqLX3/e76yG/AOVAl7B/n65UtH7t1KNIo8maCwyp
	7FfqeBhYwtZgSqu8NQgRNtrAvlY43MiCaiG9u+zGTZes050un2Zhp2KmXaUV0tZxfcqYImVSPSD
	uuvXPculZ2+7ApNWxKx+qw==
X-Received: by 2002:a05:690e:4142:b0:671:20d6:e1e6 with SMTP id 956f58d0204a3-672d585b4d9mr1206855d50.40.1790168354217;
        Wed, 23 Sep 2026 05:59:14 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672d81ce7dcsm833063d50.18.2026.09.23.05.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 05:59:13 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/4] stash: clean up index-mode test merge
Date: Wed, 23 Sep 2026 08:58:03 -0400
Message-ID: <cover.1790168285.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1789853192.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This small patch series fixes a bug reported by Eli Barzilay in the
interaction between autostashing, staged index entries, and
stash.index=true.

The first patch is an incidental cleanup, and the second re-arranges one
line to make the change easier. The third adds a new test, while the
fourth holds the interesting bits.

Changes in v2:

• Do give branch labels for the incore merge, although they are never
  seen (and clarify commit message as a result, also keeping the
  merge-ort asserts). Phillip was right: without those, we do segfault
  on conflicts.
• Use the ui merge options to keep the same diff algorithm.
• Use merge_finalize instead of clear_merge_options, and reuse the
  options between merge calls if they are already initialized.
• Add a new 2/4 to simplify merge options initialization.
• Add a new 3/4 with a test case for conflicted index merges.

v1: <cover.1789853192.git.ben.knoble@gmail.com>

[1/4] builtin/stash: remove unused header
[2/4] stash: prepare merge options earlier
[3/4] t: test failed "stash apply --index"
[4/4] builtin/stash: merge index in-core

 builtin/stash.c  | 83 +++++++++++-------------------------------------
 t/t3903-stash.sh | 18 +++++++++++
 t/t7600-merge.sh |  9 ++++++
 3 files changed, 45 insertions(+), 65 deletions(-)

Diff-intervalle contre v1 :
1:  b6798c8a25 = 1:  b6798c8a25 builtin/stash: remove unused header
-:  ---------- > 2:  1e2343c7fc stash: prepare merge options earlier
-:  ---------- > 3:  5bd4b78cac t: test failed "stash apply --index"
2:  782fe91251 ! 4:  e49936ee12 builtin/stash: merge index in-core
    @@ Commit message
     
         Fortunately, we can achieve 2 goals at once: avoid round-tripping to the
         file-system (and invoking expensive subprocesses) by performing the
    -    merge in-core. Since the results are never seen, we don't need to set
    -    the usual branch and ancestor labels.
    +    merge in-core. If there are conflicts, we discard the resulting tree, so
    +    we don't see the usual branch and ancestor labels, but the merge
    +    subroutines insist on their presence, so use something simple.
     
         We *could* swap just the git-reset(1) subprocess with our internal
         reset_tree() and refresh_index(), which would fix the bug. We'd much
    @@ Commit message
         Reported-by: Eli Barzilay <eli@barzilay.org>
         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
    -
    - ## Notes (benknoble/commits) ##
    -    We *could* leave the asserts in, but then we somewhat uselessly set the
    -    conflict labels, which I did in the original patch [1]. Phillip
    -    suggested we don't need them, and I otherwise agree.
    -
    -    [1]: https://lore.kernel.org/git/CALnO6CDfwscMWZktBu3FtXOQVbcBRo76nqK07kMnrzC5cPyZiQ@mail.gmail.com/
    -
    -    In all the versions of 231e2dd49d (merge-ort: add some high-level
    -    algorithm structure, 2020-12-13) I could find on the mailing list, the
    -    "assert(opt->ancestor)" is present without explanation or comment, so
    -    I'm not in a good place to assess the impact of removing it and its
    -    compatriots.
    -
    -    Cc: Elijah Newren <newren@gmail.com>
    -
      ## builtin/stash.c ##
     @@ builtin/stash.c: static int create_index_from_tree(const struct object_id *tree_id,
      	return ret;
    @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
     -				return error(_("could not generate diff %s^!."),
     -					     oid_to_hex(&info->w_commit));
     -			}
    -+			init_basic_merge_options(&o, the_repository);
    ++			o.branch1 = "Upstream index";
    ++			o.branch2 = "Stashed index changes";
    ++			o.ancestor = "Stash base";
      
     -			ret = apply_cached(&out);
     -			strbuf_release(&out);
    @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
     -			discard_index(the_repository->index);
     -			repo_read_index(the_repository);
     +			oidcpy(&index_tree, &result.tree->object.oid);
    -+			clear_merge_options(&o);
    ++			merge_finalize(&o, &result);
      		}
      	}
      
     
    - ## merge-ort.c ##
    -@@ merge-ort.c: static void merge_start(struct merge_options *opt, struct merge_result *result)
    - 	trace2_region_enter("merge", "sanity checks", opt->repo);
    - 	assert(opt->repo);
    - 
    --	assert(opt->branch1 && opt->branch2);
    --
    - 	assert(opt->detect_directory_renames >= MERGE_DIRECTORY_RENAMES_NONE &&
    - 	       opt->detect_directory_renames <= MERGE_DIRECTORY_RENAMES_TRUE);
    - 	assert(opt->rename_limit >= -1);
    -@@ merge-ort.c: void merge_incore_nonrecursive(struct merge_options *opt,
    - 	trace2_region_enter("merge", "incore_nonrecursive", opt->repo);
    - 
    - 	trace2_region_enter("merge", "merge_start", opt->repo);
    --	assert(opt->ancestor != NULL);
    - 	merge_check_renames_reusable(opt, result, merge_base, side1, side2);
    - 	merge_start(opt, result);
    - 	/*
    -
      ## t/t7600-merge.sh ##
     @@ t/t7600-merge.sh: verify_no_mergehead () {
      	test_cmp result.1-5 file

base-commit: 339ab2a8f14c0c304ae2f28df1a859f3d2cf610c
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

