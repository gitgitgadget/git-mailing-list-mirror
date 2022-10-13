Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0648C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 08:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJMImx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJMImv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 04:42:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C34811C247
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:42:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j16so1715835wrh.5
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlPGO3VqK7DNalzaZnM6Ixv/zW2Yz+jrmQ2/CFhc+do=;
        b=HTCexmIAf1SlUs0kZnUk+Rj3FatJuGPiYUAX1ykHK5q7Hj3dGU5NwOIGpSXRrOTCp9
         wAWkpHDx3T7cc68+xBO2j9ZOZN4rii/KKLIY+Zhr8C7JCV2SR5UZjDew0+3oLP6JtYH/
         Ufm6VSD6cpLcreZZwqiC5QKWMmFSICUVbT42hWBSRXzNEPTUZy1gsyMPS9Rg1MVb+WJR
         ocjci2e+rk+HXWNiIc9iHbms/X4HeDDJ3mf8BRhr4f05JuiCenvY/1shfAkbhnWq/27i
         K+jPiQTJ4+jS9dIEs5YY01ZdwkXjWtLBP/n0B6Ug9ZI9kZKT7UfGwkDSBtmOJ4gv9MXT
         tOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlPGO3VqK7DNalzaZnM6Ixv/zW2Yz+jrmQ2/CFhc+do=;
        b=nSza9K4plxTxf2oUR4LrgGIO/XqS16BnP7F4owRlH/mBGLIG5rN4uWe7SCvAvjO/Ho
         xLsFnKGPbxZcPFnBWP//gwyVD9kRz806Is0DZTO7FHG5gEhardYf9AUgPABJVSEOnEvg
         dsorCz9Rd/gb2+YwxKvkLvYhQ2MSM3L1Klbhjp4BpLZib1I/CHLzH0h09FRXcuBKbY/A
         0GQzmjPx6/2xaGZQVFxrQFSPEkvymqmY+lU2j2Ffy20GgOCZC1ZzQ9Ff89LLJMGWQn2r
         HZRkeEUOW/4NsVANNZvCYPx3z0FW/bttm4emVrEfRVGJLrieOz+XOTjtbYEkASfn0VIu
         cqfQ==
X-Gm-Message-State: ACrzQf2bawdm/oh2K3gMY21gtsIg58qeFk+XcpNin91+68JmEwYOHL2h
        ZFa8JMdAmGRL/+M5WyXdRd7usLSbXic=
X-Google-Smtp-Source: AMsMyM7Url4a/vG5Xqm4slk7HPbS1xPNbFCtC2bjYPyBgp3+SiKukrz0AqbD/IHvZRoY8Xy3zgb1gw==
X-Received: by 2002:a5d:46c6:0:b0:22e:4b9a:3f02 with SMTP id g6-20020a5d46c6000000b0022e4b9a3f02mr20693429wrs.516.1665650566751;
        Thu, 13 Oct 2022 01:42:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6-20020adfdf86000000b00230c9d427f9sm1521548wrl.53.2022.10.13.01.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 01:42:45 -0700 (PDT)
Message-Id: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 08:42:36 +0000
Subject: [PATCH v3 0/8] rebase --keep-base: imply --reapply-cherry-picks and --no-fork-point
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
        Phillip Wood <phillip.wood@dunelm.org.uk>
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
 builtin/rebase.c                 | 139 ++++++++++++++++++-------------
 t/t3416-rebase-onto-threedots.sh |  62 ++++++++++----
 t/t3431-rebase-fork-point.sh     |   2 +-
 4 files changed, 148 insertions(+), 87 deletions(-)


base-commit: afa70145a25e81faa685dc0b465e52b45d2444bd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1323%2Fphillipwood%2Fwip%2Frebase--keep-base-tweaks-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1323/phillipwood/wip/rebase--keep-base-tweaks-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1323

Range-diff vs v2:

 1:  12fb0ac6d5d = 1:  12fb0ac6d5d t3416: tighten two tests
 2:  d6f2f716c77 = 2:  d6f2f716c77 t3416: set $EDITOR in subshell
 -:  ----------- > 3:  1fd58520253 rebase: be stricter when reading state files containing oids
 3:  9daee95d434 ! 4:  dc056b13ed5 rebase: store orig_head as a commit
     @@ Commit message
          the merge base and fork point as it no longer has to convert from an
          oid to a commit.
      
     +    To avoid changing the behavior of "git rebase <upstream> <branch>" we
     +    keep the existing call to read_ref() and use lookup_commit_reference()
     +    on the oid returned by that rather than calling
     +    lookup_commit_reference_by_name() which applies the ref dwim rules to
     +    its argument. lookup_commit_reference() will dereference tag objects
     +    but we do not expect the branch being rebased to be pointing to a tag
     +    object.
     +
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## builtin/rebase.c ##
     @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
       	} else if (!read_oneliner(&buf, state_dir_path("head", opts),
       				  READ_ONELINER_WARN_MISSING))
       		return -1;
     --	if (get_oid(buf.buf, &opts->orig_head))
     -+	opts->orig_head = lookup_commit_reference_by_name(buf.buf);
     -+	if (!opts->orig_head)
     +-	if (get_oid_hex(buf.buf, &opts->orig_head))
     ++	if (get_oid_hex(buf.buf, &oid) ||
     ++	    !(opts->orig_head = lookup_commit_reference(the_repository, &oid)))
       		return error(_("invalid orig-head: '%s'"), buf.buf);
       
       	if (file_exists(state_dir_path("quiet", opts)))
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       		ret = finish_rebase(&options);
       		goto cleanup;
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     + 	 */
     + 	if (argc == 1) {
     + 		/* Is it "rebase other branchname" or "rebase other commit"? */
     ++		struct object_id branch_oid;
     + 		branch_name = argv[0];
     + 		options.switch_to = argv[0];
     + 
       		/* Is it a local branch? */
       		strbuf_reset(&buf);
       		strbuf_addf(&buf, "refs/heads/%s", branch_name);
      -		if (!read_ref(buf.buf, &options.orig_head)) {
     -+		options.orig_head = lookup_commit_reference_by_name(buf.buf);
     -+		if (options.orig_head) {
     ++		if (!read_ref(buf.buf, &branch_oid)) {
       			die_if_checked_out(buf.buf, 1);
       			options.head_name = xstrdup(buf.buf);
     ++			options.orig_head =
     ++				lookup_commit_reference(the_repository,
     ++							&branch_oid);
       		/* If not is it a valid ref (branch or commit)? */
       		} else {
      -			struct commit *commit =
      +			options.orig_head =
       				lookup_commit_reference_by_name(branch_name);
      -			if (!commit)
     -+			if (!options.orig_head)
     - 				die(_("no such branch/commit '%s'"),
     - 				    branch_name);
     +-				die(_("no such branch/commit '%s'"),
     +-				    branch_name);
      -			oidcpy(&options.orig_head, &commit->object.oid);
       			options.head_name = NULL;
       		}
     ++		if (!options.orig_head)
     ++			die(_("no such branch/commit '%s'"), branch_name);
       	} else if (argc == 0) {
     + 		/* Do not need to switch branches, we are already on it. */
     + 		options.head_name =
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
       			FREE_AND_NULL(options.head_name);
       			branch_name = "HEAD";
 4:  cca933a5f1d = 5:  00f70c90344 rebase: rename merge_base to branch_base
 5:  fc45b996d34 ! 6:  2efbfc94187 rebase: factor out branch_base calculation
     @@ builtin/rebase.c: static int can_fast_forward(struct commit *onto, struct commit
      -	merge_bases = get_merge_bases(onto, head);
      -	if (!merge_bases || merge_bases->next) {
      -		oidcpy(branch_base, null_oid());
     -+	if (is_null_oid(branch_base))
     - 		goto done;
     +-		goto done;
      -	}
     ++	if (is_null_oid(branch_base))
     ++		goto done; /* fill_branch_base() found multiple merge bases */
       
      -	oidcpy(branch_base, &merge_bases->item->object.oid);
       	if (!oideq(branch_base, &onto->object.oid))
 6:  faad7eaf0d6 = 7:  bc39c76b217 rebase --keep-base: imply --reapply-cherry-picks
 7:  6410b101d7f = 8:  4d0226e1dcc rebase --keep-base: imply --no-fork-point

-- 
gitgitgadget
