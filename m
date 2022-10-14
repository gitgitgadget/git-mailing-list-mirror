Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC07C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 08:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiJNI4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 04:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJNI4t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 04:56:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEA314EC4D
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:56:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j16so6541531wrh.5
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TCrhn2hRmI/JueVsCbNFTbF7l2ygUAXqLCvWFfpdns=;
        b=JuTKhdR4UfhGhEH27Ogh7LeLpLxiYDOou8XSlOT9IMTJPebAfRdbn2xpBiPdi7XYnI
         rJwhUKZ+gjJwguF/F5d2ewjltB8uUQ1ZDC2AEXi+h3r6TUoaTckvzWBYo5moS3wX5u/o
         +UGuzQVbRP4jFjOfguLWXvrrN3+6RW0rLLPti8OPPYQx8rFbBgkgWC6UDUuhctXTu+1+
         D3lTauCyrs5p7eQXKd+36W2Ly7xtoZnBJID9LHcarSO9NEvC+WOhg3EW2KEKQrroRZuA
         LbXWxvoTUQS2SDdJLSgZmlVZUaBn1oP6TPZZATLG/UCog4cl68/ODMG0pnL/UR3iQo4+
         MTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TCrhn2hRmI/JueVsCbNFTbF7l2ygUAXqLCvWFfpdns=;
        b=3fBa5RppOuN777BdMNGliXv+KuzanG9wjYghXVLrVJeYR5EvADzbJOoUDJwdibyLgJ
         z9HpMPn+1GyjWDOAz4LaEGq/J/SITW/vZw3DPriu69P+xDayqPdvJ+jyyHg1lKkLyT+A
         hiuaiItS3ao9rsMpEF03LurBknDF2UUXH/wn/OL7Nr67iMIfteYHk2xaGL0VNowfLxE+
         A5WYGfxfh35AdkEnjX0sL8ewrX5krYWtMp3D7XV7UHWCI2OMdxVtx68SBNwn4k6HYTH1
         BjI6ma0VAy4KvzFd5yNldIqBAEk2Rzkevc+VaPg+qkIIPgAV74smNwBNXaYb1g8tqWJi
         eQ9A==
X-Gm-Message-State: ACrzQf2flM07OEeL7QCGvTxy5h00lCRUA6wi8Dnl4fYzonKnyw23wqaq
        HZX7v9TUkktiLpIzY7Vh6cJLF6Ep9+I=
X-Google-Smtp-Source: AMsMyM66Kw7aClonVcQGGDFkXg+vFP6uOnqW7b8Ox6xdu7JVl6a2X/1abGR4nD3HPabDtk3+ayHCWw==
X-Received: by 2002:adf:ba8f:0:b0:22c:def3:1179 with SMTP id p15-20020adfba8f000000b0022cdef31179mr2603389wrg.571.1665737806306;
        Fri, 14 Oct 2022 01:56:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16-20020a056000011000b0022e38c93195sm1433759wrx.34.2022.10.14.01.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:56:45 -0700 (PDT)
Message-Id: <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 08:56:37 +0000
Subject: [PATCH v3 0/7] patch-id fixes and improvements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches add fixes and features to the "git patch-id" command, mostly
discovered through our usage of patch-id in the revup project
(https://github.com/Skydio/revup). On top of that I've tried to make general
cleanup changes where I can.

Summary:

1: Fixed a bug in the combination of --stable with binary files and
header-only, and expanded the test to cover both binary and non-binary
files.

2: Switch internal usage of patch-id in rebase / cherry-pick to use the
stable variant to reduce the number of code paths and improve testing for
bugs like above.

3: Fixed bugs with patch-id and binary diffs. Previously patch-id did not
behave correctly for binary diffs regardless of whether "--binary" was given
to "diff".

4: Fixed bugs with patch-id and mode changes. Previously mode changes were
incorrectly excluded from the patch-id.

5: Add a new "--include-whitespace" mode to patch-id that prevents
whitespace from being stripped during id calculation. Also add a config
option for the same behavior.

6: Remove unused prefix from patch-id logic.

7: Update format-patch doc to specify when patch-ids are going to be equal
to those generated by "git patch-id".

V1->V2: Fixed comment style V2->V3: The ---/+++ lines no longer get added to
the patch-id of binary diffs. Also added patches 3-7 in the series.

Signed-off-by: Jerry Zhang jerry@skydio.com

Jerry Zhang (7):
  patch-id: fix stable patch id for binary / header-only
  patch-id: use stable patch-id for rebases
  builtin: patch-id: fix patch-id with binary diffs
  patch-id: fix patch-id for mode changes
  builtin: patch-id: add --include-whitespace as a command mode
  builtin: patch-id: remove unused diff-tree prefix
  documentation: format-patch: clarify requirements for patch-ids to
    match

 Documentation/git-format-patch.txt |   4 +-
 Documentation/git-patch-id.txt     |  25 +++++--
 builtin/log.c                      |   2 +-
 builtin/patch-id.c                 | 114 +++++++++++++++++++++--------
 diff.c                             |  75 +++++++++----------
 diff.h                             |   2 +-
 patch-ids.c                        |  10 +--
 patch-ids.h                        |   2 +-
 t/t3419-rebase-patch-id.sh         |  63 +++++++++++++---
 t/t4204-patch-id.sh                |  95 ++++++++++++++++++++++--
 10 files changed, 291 insertions(+), 101 deletions(-)


base-commit: d420dda0576340909c3faff364cfbd1485f70376
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1359%2Fjerry-skydio%2Fjerry%2Frevup%2Fmaster%2Fpatch_ids-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1359/jerry-skydio/jerry/revup/master/patch_ids-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1359

Range-diff vs v2:

 1:  945508df7b6 ! 1:  7d4c2e91ce0 patch-id: fix stable patch id for binary / header-only
     @@ Commit message
          populates the object ids, and normal which populates the text
          diff. All branches will end up flushing the hunk.
      
     +    Don't populate the ---a/ and +++b/ lines for binary diffs, to correspond
     +    to those lines not being present in the "git diff" text output.
     +    This is necessary because we advertise that the patch-id calculated
     +    internally and used in format-patch is the same that what the
     +    builtin "git patch-id" would produce when piped from a diff.
     +
          Update the test to run on both binary and normal files.
      
          Signed-off-by: Jerry Zhang <jerry@skydio.com>
      
       ## diff.c ##
      @@ diff.c: static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
     - 			the_hash_algo->update_fn(&ctx, p->two->path, len2);
     + 		if (p->one->mode == 0) {
     + 			patch_id_add_string(&ctx, "newfilemode");
     + 			patch_id_add_mode(&ctx, p->two->mode);
     +-			patch_id_add_string(&ctx, "---/dev/null");
     +-			patch_id_add_string(&ctx, "+++b/");
     +-			the_hash_algo->update_fn(&ctx, p->two->path, len2);
     + 		} else if (p->two->mode == 0) {
     + 			patch_id_add_string(&ctx, "deletedfilemode");
     + 			patch_id_add_mode(&ctx, p->one->mode);
     +-			patch_id_add_string(&ctx, "---a/");
     +-			the_hash_algo->update_fn(&ctx, p->one->path, len1);
     +-			patch_id_add_string(&ctx, "+++/dev/null");
     +-		} else {
     +-			patch_id_add_string(&ctx, "---a/");
     +-			the_hash_algo->update_fn(&ctx, p->one->path, len1);
     +-			patch_id_add_string(&ctx, "+++b/");
     +-			the_hash_algo->update_fn(&ctx, p->two->path, len2);
       		}
       
      -		if (diff_header_only)
     @@ diff.c: static int diff_get_patch_id(struct diff_options *options, struct object
       			the_hash_algo->update_fn(&ctx, oid_to_hex(&p->two->oid),
       					the_hash_algo->hexsz);
      -			continue;
     +-		}
     +-
     +-		xpp.flags = 0;
     +-		xecfg.ctxlen = 3;
     +-		xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
     +-		if (xdi_diff_outf(&mf1, &mf2, NULL,
     +-				  patch_id_consume, &data, &xpp, &xecfg))
     +-			return error("unable to generate patch-id diff for %s",
     +-				     p->one->path);
      +		} else {
     ++			if (p->one->mode == 0) {
     ++				patch_id_add_string(&ctx, "---/dev/null");
     ++				patch_id_add_string(&ctx, "+++b/");
     ++				the_hash_algo->update_fn(&ctx, p->two->path, len2);
     ++			} else if (p->two->mode == 0) {
     ++				patch_id_add_string(&ctx, "---a/");
     ++				the_hash_algo->update_fn(&ctx, p->one->path, len1);
     ++				patch_id_add_string(&ctx, "+++/dev/null");
     ++			} else {
     ++				patch_id_add_string(&ctx, "---a/");
     ++				the_hash_algo->update_fn(&ctx, p->one->path, len1);
     ++				patch_id_add_string(&ctx, "+++b/");
     ++				the_hash_algo->update_fn(&ctx, p->two->path, len2);
     ++			}
     + 
      +			if (fill_mmfile(options->repo, &mf1, p->one) < 0 ||
      +			    fill_mmfile(options->repo, &mf2, p->two) < 0)
      +				return error("unable to read files to diff");
     @@ diff.c: static int diff_get_patch_id(struct diff_options *options, struct object
      +					  patch_id_consume, &data, &xpp, &xecfg))
      +				return error("unable to generate patch-id diff for %s",
      +					     p->one->path);
     - 		}
     --
     --		xpp.flags = 0;
     --		xecfg.ctxlen = 3;
     --		xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
     --		if (xdi_diff_outf(&mf1, &mf2, NULL,
     --				  patch_id_consume, &data, &xpp, &xecfg))
     --			return error("unable to generate patch-id diff for %s",
     --				     p->one->path);
     --
     ++		}
       		if (stable)
       			flush_one_hunk(oid, &ctx);
       	}
      
       ## t/t3419-rebase-patch-id.sh ##
      @@ t/t3419-rebase-patch-id.sh: test_expect_success 'setup: 500 lines' '
     - 	git cherry-pick main >/dev/null 2>&1
     - '
     + 	git add newfile &&
     + 	git commit -q -m "add small file" &&
     + 
     +-	git cherry-pick main >/dev/null 2>&1
     +-'
     ++	git cherry-pick main >/dev/null 2>&1 &&
       
      -test_expect_success 'setup attributes' '
      -	echo "file binary" >.gitattributes
     --'
     --
     ++	git branch -f squashed main &&
     ++	git checkout -q -f squashed &&
     ++	git reset -q --soft HEAD~2 &&
     ++	git commit -q -m squashed
     + '
     + 
       test_expect_success 'detect upstream patch' '
     - 	git checkout -q main &&
     +-	git checkout -q main &&
     ++	git checkout -q main^{} &&
       	scramble file &&
     + 	git add file &&
     + 	git commit -q -m "change big file again" &&
      @@ t/t3419-rebase-patch-id.sh: test_expect_success 'detect upstream patch' '
     - 	git checkout -q other^{} &&
     - 	git rebase main &&
     - 	git rev-list main...HEAD~ >revs &&
     --	test_must_be_empty revs
     -+	test_must_be_empty revs &&
     + 	test_must_be_empty revs
     + '
     + 
     ++test_expect_success 'detect upstream patch binary' '
      +	echo "file binary" >.gitattributes &&
      +	git checkout -q other^{} &&
      +	git rebase main &&
      +	git rev-list main...HEAD~ >revs &&
      +	test_must_be_empty revs &&
     -+	rm .gitattributes
     - '
     - 
     ++	test_when_finished "rm .gitattributes"
     ++'
     ++
       test_expect_success 'do not drop patch' '
     -@@ t/t3419-rebase-patch-id.sh: test_expect_success 'do not drop patch' '
     - 	git commit -q -m squashed &&
     +-	git branch -f squashed main &&
     +-	git checkout -q -f squashed &&
     +-	git reset -q --soft HEAD~2 &&
     +-	git commit -q -m squashed &&
       	git checkout -q other^{} &&
       	test_must_fail git rebase squashed &&
      -	git rebase --quit
     -+	git rebase --abort &&
     ++	test_when_finished "git rebase --abort"
     ++'
     ++
     ++test_expect_success 'do not drop patch binary' '
      +	echo "file binary" >.gitattributes &&
      +	git checkout -q other^{} &&
      +	test_must_fail git rebase squashed &&
     -+	git rebase --abort &&
     -+	rm .gitattributes
     ++	test_when_finished "git rebase --abort" &&
     ++	test_when_finished "rm .gitattributes"
       '
       
       test_done
 2:  30ec43cd129 ! 2:  25e28b7dab3 patch-id: use stable patch-id for rebases
     @@ Commit message
          patch-id: use stable patch-id for rebases
      
          Git doesn't persist patch-ids during the rebase process, so there is
     -    no need to specifically invoke the unstable variant.
     -
     -    This allows the legacy unstable id logic to be cleaned up.
     +    no need to specifically invoke the unstable variant. Use the stable
     +    logic for all internal patch-id calculations to minimize the number of
     +    code paths and improve test coverage.
      
          Signed-off-by: Jerry Zhang <jerry@skydio.com>
      
 -:  ----------- > 3:  21642128927 builtin: patch-id: fix patch-id with binary diffs
 -:  ----------- > 4:  6e07cfd5691 patch-id: fix patch-id for mode changes
 -:  ----------- > 5:  bbaa2425ad0 builtin: patch-id: add --include-whitespace as a command mode
 -:  ----------- > 6:  a1f6f36d487 builtin: patch-id: remove unused diff-tree prefix
 -:  ----------- > 7:  69440797f30 documentation: format-patch: clarify requirements for patch-ids to match

-- 
gitgitgadget
