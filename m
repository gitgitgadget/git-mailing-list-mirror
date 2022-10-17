Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14132C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiJQNRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJQNRt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:17:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE5A5C9E8
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:48 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso9948999wmb.5
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FMhUdEHdH+MdT9kd2YhpyU+zE0VxXw4cKxWazfxjMk=;
        b=FHJFHCLE1BsHUAQU0ly2681y57MYqaniFxtU+NCIT+Rxb/OYqkUw+zqMlyMCWmq40c
         Zf9Plv1oKtCB3sn3ysKsiwEib/ynXUeg1E3G9IQ672oPvrloIw3GvW2/fVzpObE0UxpY
         gxQPkUmgRiqhKcZmbXcSgWnyPiugEHmrUq/c6tfM/9jVcSJd8sTjJw6hbyao1M2kq57G
         o6J4X3L98egdOwUpnaTeQCaOfi0EeITfjKE7ZpS+zT6Z5dvuwxsf8U6KTRxCZR6BISGC
         mH9uGD7GRd524hIxamA8uLEImv3lh1Lf1sepwAe1TacETwVQi7npV++nI+KYkqqvLaGY
         aBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FMhUdEHdH+MdT9kd2YhpyU+zE0VxXw4cKxWazfxjMk=;
        b=XR2QzRShrjZ9YTeblfNo8kSjNyAhk/r6O5uL8Epc8zjXGZEQtENYg7Lpxf/oz7oKRe
         vTGNxOQz/A8c0z5l+NRMZthrUWh5yQBcAYDQqwwOOzZXm4WSG81tQVNF94ct8EuF0/vz
         rElHcZalokuK9b0trYwK30gtIUNaW/vXzrMljnD3omwIxuEWJniHP6wmhF6H+VQ1QIya
         woEN4c3esbCvn21kuprcHdb1XJfWc9JSc3CHWhsiq0zJkJe+KIZw+ar29QmKl7/l7uom
         w65jadUchMrHcEINqIaVDQG7WUag/NNfmrpZ6YiLO+Of23yHf9IfDVuC2FlT9RwMlfK+
         NFLA==
X-Gm-Message-State: ACrzQf1QEh9TMOYLtMQLdpvMlQHbe2fRrTvBSv7QdSKSllOIFspkoaUO
        N9OlHO/XgxL6Sv8jeArG7nTGm8XLzzM=
X-Google-Smtp-Source: AMsMyM7efWEKTQ+pT/IfvlmZ9D5ZYRw2zBeEpi34EeLYGyi1SyF+2HJVmfyMYOrQqF+HiLHfyaJFSQ==
X-Received: by 2002:a05:600c:3d10:b0:3c6:e1fb:b336 with SMTP id bh16-20020a05600c3d1000b003c6e1fbb336mr14356669wmb.9.1666012666496;
        Mon, 17 Oct 2022 06:17:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4-20020adf8b04000000b00231893bfdc7sm8945087wra.2.2022.10.17.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:17:46 -0700 (PDT)
Message-Id: <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
References: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 13:17:37 +0000
Subject: [PATCH v4 0/8] rebase --keep-base: imply --reapply-cherry-picks and --no-fork-point
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A while a go Philippe reported [1] that he was surprised 'git rebase
--keep-base' removed commits that had been cherry-picked upstream even
though to branch was not being rebased. I think it is also surprising if
'--keep-base' changes the base of the branch without '--fork-point' being
explicitly given on the command line. This series therefore changes the
default behavior of '--keep-base' to imply '--reapply-cherry-picks' and
'--no-fork-point' so that the base of the branch is unchanged and no commits
are removed.

Thanks to Junio and Ævar for their comments, the changes since V3 are:

 * Patch 3: added lookup_commit_object() that works like
   lookup_commit_reference() but without dereferencing tags.
 * Patch 4: changed lookup_commit_reference() to lookup_commit_object()
 * Patch 5: unchanged - Ævar has concerns about renaming merge_base to
   branch_base but I think this is an improvement overall.
 * Patches 6 & 8: fixed a whitespace issue

Thanks to Junio for his comments, the changes since V2 are:

 * Patch 3 new patch to make sure we're reading hex oids from state files
 * Patch 4 restored the call to read_refs() to avoid the dwim behavior of
   lookup_commit_reference_by_name()
 * Patch 6 added a comment to clarify what a null oid branch_base means

Thanks to everyone who commented for their reviews, the changes since V1
are:

 * Patch 1: new patch to tighten a couple of existing tests
 * Patch 2: reworded commit message in response to Junio's comments
 * Patch 3: fixed a typo in the commit message spotted by Elijah and tidied
   code formatting
 * Patch 4: new patch to rename a variable suggested by Junio
 * Patch 5: clarified commit message and removed some redundant code spotted
   by Junio
 * Patch 6: improved --reapply-cherry-picks documentation to mention
   --keep-base and vice-versa suggested by Philippe
 * Patch 7: expanded the commit message and documentation in response to
   Junio's comments

[1]
https://lore.kernel.org/git/0EA8C067-5805-40A7-857A-55C2633B8570@gmail.com/

Phillip Wood (8):
  t3416: tighten two tests
  t3416: set $EDITOR in subshell
  rebase: be stricter when reading state files containing oids
  rebase: store orig_head as a commit
  rebase: rename merge_base to branch_base
  rebase: factor out branch_base calculation
  rebase --keep-base: imply --reapply-cherry-picks
  rebase --keep-base: imply --no-fork-point

 Documentation/git-rebase.txt     |  32 ++++---
 builtin/rebase.c                 | 144 ++++++++++++++++++-------------
 commit.c                         |   8 ++
 commit.h                         |  13 +++
 t/t3416-rebase-onto-threedots.sh |  62 ++++++++++---
 t/t3431-rebase-fork-point.sh     |   2 +-
 6 files changed, 172 insertions(+), 89 deletions(-)


base-commit: afa70145a25e81faa685dc0b465e52b45d2444bd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1323%2Fphillipwood%2Fwip%2Frebase--keep-base-tweaks-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1323/phillipwood/wip/rebase--keep-base-tweaks-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1323

Range-diff vs v3:

 1:  12fb0ac6d5d = 1:  12fb0ac6d5d t3416: tighten two tests
 2:  d6f2f716c77 = 2:  d6f2f716c77 t3416: set $EDITOR in subshell
 3:  1fd58520253 ! 3:  1d5e0419c45 rebase: be stricter when reading state files containing oids
     @@ Commit message
      
          The state files for 'onto' and 'orig_head' should contain a full hex
          oid, change the reading functions from get_oid() to get_oid_hex() to
     -    reflect this.
     +    reflect this. They should also name commits and not tags so add and use
     +    a function that looks up a commit from an oid like
     +    lookup_commit_reference() but without dereferencing tags.
      
          Suggested-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
       		xstrdup(head_name.buf) : NULL;
       	strbuf_release(&head_name);
      -	if (get_oid(buf.buf, &oid))
     -+	if (get_oid_hex(buf.buf, &oid))
     - 		return error(_("could not get 'onto': '%s'"), buf.buf);
     - 	opts->onto = lookup_commit_or_die(&oid, buf.buf);
     +-		return error(_("could not get 'onto': '%s'"), buf.buf);
     +-	opts->onto = lookup_commit_or_die(&oid, buf.buf);
     ++	if (get_oid_hex(buf.buf, &oid) ||
     ++	    !(opts->onto = lookup_commit_object(the_repository, &oid)))
     ++		return error(_("invalid onto: '%s'"), buf.buf);
       
     + 	/*
     + 	 * We always write to orig-head, but interactive rebase used to write to
      @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
       	} else if (!read_oneliner(&buf, state_dir_path("head", opts),
       				  READ_ONELINER_WARN_MISSING))
     @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
       		return error(_("invalid orig-head: '%s'"), buf.buf);
       
       	if (file_exists(state_dir_path("quiet", opts)))
     +
     + ## commit.c ##
     +@@ commit.c: struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
     + 	return c;
     + }
     + 
     ++struct commit *lookup_commit_object (struct repository *r,
     ++				     const struct object_id *oid)
     ++{
     ++	struct object *obj = parse_object(r, oid);
     ++	return obj ? object_as_type(obj, OBJ_COMMIT, 0) : NULL;
     ++
     ++}
     ++
     + struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
     + {
     + 	struct object *obj = lookup_object(r, oid);
     +
     + ## commit.h ##
     +@@ commit.h: enum decoration_type {
     + void add_name_decoration(enum decoration_type type, const char *name, struct object *obj);
     + const struct name_decoration *get_name_decoration(const struct object *obj);
     + 
     ++/*
     ++ * Look up commit named by "oid" respecting replacement objects.
     ++ * Returns NULL if "oid" is not a commit or does not exist.
     ++ */
     ++struct commit *lookup_commit_object(struct repository *r, const struct object_id *oid);
     ++
     ++/*
     ++ * Look up commit named by "oid" without replacement objects or
     ++ * checking for object existence. Returns the requested commit if it
     ++ * is found in the object cache, NULL if "oid" is in the object cache
     ++ * but is not a commit and a newly allocated unparsed commit object if
     ++ * "oid" is not in the object cache.
     ++ */
     + struct commit *lookup_commit(struct repository *r, const struct object_id *oid);
     + struct commit *lookup_commit_reference(struct repository *r,
     + 				       const struct object_id *oid);
 4:  dc056b13ed5 ! 4:  22f3d265b57 rebase: store orig_head as a commit
     @@ Commit message
          oid to a commit.
      
          To avoid changing the behavior of "git rebase <upstream> <branch>" we
     -    keep the existing call to read_ref() and use lookup_commit_reference()
     +    keep the existing call to read_ref() and use lookup_commit_object()
          on the oid returned by that rather than calling
          lookup_commit_reference_by_name() which applies the ref dwim rules to
     -    its argument. lookup_commit_reference() will dereference tag objects
     -    but we do not expect the branch being rebased to be pointing to a tag
     -    object.
     +    its argument.
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
       		return -1;
      -	if (get_oid_hex(buf.buf, &opts->orig_head))
      +	if (get_oid_hex(buf.buf, &oid) ||
     -+	    !(opts->orig_head = lookup_commit_reference(the_repository, &oid)))
     ++	    !(opts->orig_head = lookup_commit_object(the_repository, &oid)))
       		return error(_("invalid orig-head: '%s'"), buf.buf);
       
       	if (file_exists(state_dir_path("quiet", opts)))
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       			die_if_checked_out(buf.buf, 1);
       			options.head_name = xstrdup(buf.buf);
      +			options.orig_head =
     -+				lookup_commit_reference(the_repository,
     -+							&branch_oid);
     ++				lookup_commit_object(the_repository,
     ++						     &branch_oid);
       		/* If not is it a valid ref (branch or commit)? */
       		} else {
      -			struct commit *commit =
 5:  00f70c90344 = 5:  79a8c0fe284 rebase: rename merge_base to branch_base
 6:  2efbfc94187 ! 6:  bd24409a266 rebase: factor out branch_base calculation
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       				options.onto_name);
      +		fill_branch_base(&options, &branch_base);
       	}
     --
     + 
       	if (options.fork_point > 0)
     - 		options.restrict_revision =
     - 			get_fork_point(options.upstream_name, options.orig_head);
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
       	 * Check if we are already based on onto with linear history,
       	 * in which case we could fast-forward without replacing the commits
 7:  bc39c76b217 ! 7:  367e44c6928 rebase --keep-base: imply --reapply-cherry-picks
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       
       	if (gpg_sign)
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     - 				options.onto_name);
       		fill_branch_base(&options, &branch_base);
       	}
     + 
      +	if (keep_base && options.reapply_cherry_picks)
      +		options.upstream = options.onto;
      +
 8:  4d0226e1dcc = 8:  656b9c9dab6 rebase --keep-base: imply --no-fork-point

-- 
gitgitgadget
