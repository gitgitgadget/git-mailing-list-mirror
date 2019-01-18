Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CA2E1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 15:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfARPJ1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 10:09:27 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35463 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfARPJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 10:09:26 -0500
Received: by mail-ed1-f68.google.com with SMTP id x30so11402578edx.2
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 07:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JpUzold2VLGw/6IDxzJtE0B+1vzADy4UJqBbACDkwLw=;
        b=uwHFh8VMiNyBoVbBDKYIa/TpNHuqbsG+2gMLUJ9SdbaptiEEndBBKsvc3Mu6nDNyhQ
         m8Oub68JQ3fc7yihjShaXvMtW3JfIC3WsIgrJPRWBcMrn9GHe82q6e43SQOOmMG5085F
         ptrgaUThLzrUc1cYjgiHF1qGuddYm11EjpZTJrYnRbOpGlmkjF5McnxA2BLoMAHDOxzs
         bMkY/c+ZQeuavh64d/V4Q8B1sCgmatpPZuNGl05lB7CO9P5wa78FZQbHGg0xSPTbrSlL
         sfnz7zijuD01hHRui8sqBBP//pJdtqGiHEFYof0uPSn4mcRVroTHOzkyZlCCJHVP08Cd
         lLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JpUzold2VLGw/6IDxzJtE0B+1vzADy4UJqBbACDkwLw=;
        b=cfTtQlBDx57p4p/MZnlDQqwAzZCx3UEqqXVXFDIMspJz0msZ0gIQ775QMCv6kBq5jt
         1muUTqbQFsPCsA0qoH/4l75EgMoLCxs6xWgff4R4T/vDwGDWBGbT0PvJkQx55ETKqEsr
         VZQISPTUC/H3WsQbtuoqk2oHQcI+6j6MHMZG1yJ20QHZEgr3u771AR+t8KSwR1Md1UAF
         UYTcR7+gR/va6GCB9+iHev0iPJPDbCDAmKJ++nCFy+tPGEO006hsEwG1yHP6B9uCzSen
         sOOKGjlUzNXE09PD7op2U2lUoh3YwFBKc1xXH06wjQJGLWOidkNVnUv5/+8E0vj8UW7A
         v8cQ==
X-Gm-Message-State: AJcUukd9kBPdACEv/CeI+XlwijkGbriaIn9djnpDKpSP92YMBtQ08hgg
        25iWaDIsuctY/iBIceD68WQEBIpV
X-Google-Smtp-Source: ALg8bN4hRhGXagPGFgEaioXn58HDgYjNo1zTphCNEy/1xnq+qJEZF4hF7a7cWc165siZWzY6tu5JpQ==
X-Received: by 2002:a50:ae8f:: with SMTP id e15mr16548638edd.250.1547824164216;
        Fri, 18 Jan 2019 07:09:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j21-v6sm4011434ejz.51.2019.01.18.07.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 07:09:23 -0800 (PST)
Date:   Fri, 18 Jan 2019 07:09:23 -0800 (PST)
X-Google-Original-Date: Fri, 18 Jan 2019 15:09:18 GMT
Message-Id: <pull.24.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.24.git.gitgitgadget@gmail.com>
References: <pull.24.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/4] Let the builtin rebase call the git am command directly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Especially on Windows, where Unix shell scripting is a foreign endeavor, and
an expensive one at that, we really want to avoid running through the Bash.

This not only makes everything faster, but also more robust, as the Bash we
use on Windows relies on a derivative of the Cygwin runtime, which in turn
has to jump through a couple of hoops that are sometimes a little too tricky
to make things work. Read: the less we rely on Unix shell scripting, the
more likely Windows users will be able to enjoy our software.

Changes since v1:

 * Rebased on top of master to avoid merge conflicts.
 * Adjusted the commit message talking about double entries, to clarify that
   it talks about HEAD's reflog.
 * Replaced a misleading action parameter "checkout" for the reset_head() 
   function by the empty string: we do not check out here, we just update
   the refs, and certainly do not want any checkout functionality (such as
   hooks) to be involved.
 * Reused a just-prepared refs_only variable instead of repeating the value
   assigned to it.
 * Fixed a stale comment about the shell variable "$upstream" (which should
   have been negated to begin with).
 * Fixed error messages when files could not be opened.

Johannes Schindelin (4):
  rebase: move `reset_head()` into a better spot
  rebase: avoid double reflog entry when switching branches
  rebase: teach `reset_head()` to optionally skip the worktree
  built-in rebase: call `git am` directly

 builtin/rebase.c | 424 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 305 insertions(+), 119 deletions(-)


base-commit: 77556354bb7ac50450e3b28999e3576969869068
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-24%2Fdscho%2Fbuiltin-rebase--am-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-24/dscho/builtin-rebase--am-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/24

Range-diff vs v1:

 1:  175dc7d29a ! 1:  e886ae3de5 rebase: move `reset_head()` into a better spot
     @@ -91,7 +91,7 @@
      +	}
      +
      +	tree = parse_tree_indirect(oid);
     -+	prime_cache_tree(the_repository->index, tree);
     ++	prime_cache_tree(the_repository, the_repository->index, tree);
      +
      +	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0) {
      +		ret = error(_("could not write index"));
     @@ -217,7 +217,7 @@
      -	}
      -
      -	tree = parse_tree_indirect(oid);
     --	prime_cache_tree(the_repository->index, tree);
     +-	prime_cache_tree(the_repository, the_repository->index, tree);
      -
      -	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0) {
      -		ret = error(_("could not write index"));
 2:  4c5f87b9dc ! 2:  3a68f1c509 rebase: avoid double reflog entry when switching branches
     @@ -3,8 +3,8 @@
          rebase: avoid double reflog entry when switching branches
      
          When switching a branch *and* updating said branch to a different
     -    revision, let's avoid a double entry by first updating the branch and
     -    then adjusting the symbolic ref HEAD.
     +    revision, let's avoid a double entry in HEAD's reflog by first updating
     +    the branch and then adjusting the symbolic ref HEAD.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
 3:  21939140e0 ! 3:  387071dcd7 rebase: teach `reset_head()` to optionally skip the worktree
     @@ -40,7 +40,7 @@
       	if (!oid)
       		oid = &head_oid;
       
     -+	if (flags & RESET_HEAD_REFS_ONLY)
     ++	if (refs_only)
      +		goto reset_head_refs;
      +
       	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
 4:  2b5ece8263 ! 4:  3c40318682 built-in rebase: call `git am` directly
     @@ -16,6 +16,10 @@
          itself a derivative of the Cygwin runtime): when no shell script is
          called, the POSIX emulation layer is avoided altogether.
      
     +    Note: we pass an empty action to `reset_head()` here when moving back to
     +    the original branch, as no other action is applicable, really. This
     +    parameter is used to initialize `unpack_trees()`' messages.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/builtin/rebase.c b/builtin/rebase.c
     @@ -78,8 +82,7 @@
      +		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
      +	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
      +		    opts->head_name);
     -+	ret = reset_head(NULL, "checkout", opts->head_name,
     -+			 RESET_HEAD_REFS_ONLY,
     ++	ret = reset_head(NULL, "", opts->head_name, RESET_HEAD_REFS_ONLY,
      +			 orig_head_reflog.buf, head_reflog.buf);
      +
      +	strbuf_release(&orig_head_reflog);
     @@ -114,7 +117,6 @@
      +		if (status)
      +			return status;
      +
     -+		discard_cache();
      +		return move_to_original_branch(opts);
      +	}
      +	if (opts->action && !strcmp("skip", opts->action)) {
     @@ -124,7 +126,6 @@
      +		if (status)
      +			return status;
      +
     -+		discard_cache();
      +		return move_to_original_branch(opts);
      +	}
      +	if (opts->action && !strcmp("show-current-patch", opts->action)) {
     @@ -134,7 +135,7 @@
      +
      +	strbuf_addf(&revisions, "%s...%s",
      +		    oid_to_hex(opts->root ?
     -+			       /* this is now equivalent to ! -z "$upstream" */
     ++			       /* this is now equivalent to !opts->upstream */
      +			       &opts->onto->object.oid :
      +			       &opts->upstream->object.oid),
      +		    oid_to_hex(&opts->orig_head));
     @@ -143,7 +144,7 @@
      +	format_patch.out = open(rebased_patches,
      +				O_WRONLY | O_CREAT | O_TRUNC, 0666);
      +	if (format_patch.out < 0) {
     -+		status = error_errno(_("could not write '%s'"),
     ++		status = error_errno(_("could not open '%s' for writing"),
      +				     rebased_patches);
      +		free(rebased_patches);
      +		argv_array_clear(&am.args);
     @@ -185,7 +186,7 @@
      +
      +	am.in = open(rebased_patches, O_RDONLY);
      +	if (am.in < 0) {
     -+		status = error_errno(_("could not read '%s'"),
     ++		status = error_errno(_("could not open '%s' for reading"),
      +				     rebased_patches);
      +		free(rebased_patches);
      +		argv_array_clear(&am.args);
     @@ -207,7 +208,6 @@
      +	free(rebased_patches);
      +
      +	if (!status) {
     -+		discard_cache();
      +		return move_to_original_branch(opts);
      +	}
      +

-- 
gitgitgadget
