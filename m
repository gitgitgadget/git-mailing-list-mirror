Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31B6D1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 11:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeKLVhY (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 16:37:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46850 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbeKLVhX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 16:37:23 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so3958692pgp.13
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 03:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GqbbCyT2m55wrZXR12O0/lqhJr6dOMyeYeu1mESHr/E=;
        b=Ja1n1/wR04g8Xr4gKbewsXxb7d7tM4ghTmp1Ruv5bSCxvgwh8Ld7wjY2BsZKkAOjUS
         MDy1ot5+Pp3srVRssam6OUtmUfw//jcGfSvp3h3jxvVNVMTDESTZMsjTmN9Bn+kfdYkQ
         0UUiVaZPPtjGyDxd70fFMLPA3lnNQCbkRip6IqNm2MKMX90LOt2PMfb/I9fp1weB5IYi
         gshmsUw5RntZnSkzG3OItFnLn3CguJicq7RawLyF8a7vDRFz87cFZfdZ49oBaWCVX5Wc
         j13cWLMUApqkhghmJjeQlwApNa2TugSsCy7i+j7id0lyNI1bxTbe8ayIIAD+VeCMoZXB
         YKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GqbbCyT2m55wrZXR12O0/lqhJr6dOMyeYeu1mESHr/E=;
        b=kAXA+C7vK+xVcrZ9puLMMa2neJpOtwmhsHqm7cdzaKrQgdHrGl3yXchrMFv6qd7AWu
         oxE5f0gqQtxh8p3kEop9O9jmdwLWuxOjmNY4kWYl9awkx0cLr0WM1UYJNapsceWnV5Ci
         5gqFi1oH5QMxS/164t7p8U6b3WQeSSvYZ4HApBpOAJFPFfTfklfs3SvymBOY7OvQfSFY
         qxfEO1YnOg3gy0zlUE1VzBybOwfi7WM3vOs5V8h0k0VvdmMN7HCp/6i4zn4gZLTas+oI
         T1mxJUDFADyJEZVpr4/ZpJ54iiGKfw7+FDJpZrJoNQfLqk2mSkucufMO3VHC2fY+NSv6
         7kIw==
X-Gm-Message-State: AGRZ1gJexKjBXKYrKL9Vft3FthtQaXX5pjzT2XkySxK3MQW3sAZA4IUG
        VSqJ3zojAc7H0rPGHXuKzjiEYbQ1
X-Google-Smtp-Source: AJdET5cgjG0Y58bsMWNc64e4pf+TLPHWaEmMeOSacw0sLhqHjuzhokEShZRbfmCaZHtMu5sJxBrr/w==
X-Received: by 2002:a62:e30a:: with SMTP id g10-v6mr562257pfh.151.1542023069337;
        Mon, 12 Nov 2018 03:44:29 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id h10sm15675854pgn.11.2018.11.12.03.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 03:44:28 -0800 (PST)
Date:   Mon, 12 Nov 2018 03:44:28 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 11:44:23 GMT
Message-Id: <pull.72.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.72.git.gitgitgadget@gmail.com>
References: <pull.72.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/3] Fix built-in rebase perf regression
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

In our tests with large repositories, we noticed a serious regression of the
performance of git rebase when using the built-in vs the shell script
version. It boils down to an incorrect conversion of a git checkout -q:
instead of using a twoway_merge as git checkout does, we used a oneway_merge 
as git reset does. The latter, however, calls lstat() on all files listed in
the index, while the former essentially looks only at the files that are
different between the given two revisions.

Let's reinstate the original behavior by introducing a flag to the 
reset_head() function to indicate whether we want to emulate reset --hard 
(in which case we use the oneway_merge, otherwise we use twoway_merge).

Johannes Schindelin (3):
  rebase: consolidate clean-up code before leaving reset_head()
  rebase: prepare reset_head() for more flags
  built-in rebase: reinstate `checkout -q` behavior where appropriate

 builtin/rebase.c | 79 ++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 33 deletions(-)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-72%2Fdscho%2Fbuiltin-rebase-perf-regression-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-72/dscho/builtin-rebase-perf-regression-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/72

Range-diff vs v1:

 1:  64597fe827 ! 1:  28e24d98ab rebase: consolidate clean-up code before leaving reset_head()
     @@ -11,6 +11,33 @@
      --- a/builtin/rebase.c
      +++ b/builtin/rebase.c
      @@
     + 	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
     + 		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
     + 
     +-	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
     +-		return -1;
     ++	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
     ++		ret = -1;
     ++		goto leave_reset_head;
     ++	}
     + 
     + 	if (!oid) {
     + 		if (get_oid("HEAD", &head_oid)) {
     +-			rollback_lock_file(&lock);
     +-			return error(_("could not determine HEAD revision"));
     ++			ret = error(_("could not determine HEAD revision"));
     ++			goto leave_reset_head;
     + 		}
     + 		oid = &head_oid;
     + 	}
     +@@
     + 		unpack_tree_opts.reset = 1;
     + 
     + 	if (read_index_unmerged(the_repository->index) < 0) {
     +-		rollback_lock_file(&lock);
     +-		return error(_("could not read index"));
     ++		ret = error(_("could not read index"));
     ++		goto leave_reset_head;
       	}
       
       	if (!fill_tree_descriptor(&desc, oid)) {
     @@ -31,15 +58,17 @@
       	}
       
       	tree = parse_tree_indirect(oid);
     -@@
     + 	prime_cache_tree(the_repository->index, tree);
       
     - 	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0)
     +-	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0)
     ++	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0) {
       		ret = error(_("could not write index"));
      -	free((void *)desc.buffer);
     - 
     - 	if (ret)
     +-
     +-	if (ret)
      -		return ret;
      +		goto leave_reset_head;
     ++	}
       
       	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
       	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
 -:  ---------- > 2:  db963b2094 rebase: prepare reset_head() for more flags
 2:  070092b430 ! 3:  a7360b856f built-in rebase: reinstate `checkout -q` behavior where appropriate
     @@ -20,15 +20,18 @@
      @@
       #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
       
     + #define RESET_HEAD_DETACH (1<<0)
     ++#define RESET_HEAD_HARD (1<<1)
     + 
       static int reset_head(struct object_id *oid, const char *action,
     --		      const char *switch_to_branch, int detach_head,
     -+		      const char *switch_to_branch,
     -+		      int detach_head, int reset_hard,
     + 		      const char *switch_to_branch, unsigned flags,
       		      const char *reflog_orig_head, const char *reflog_head)
       {
     + 	unsigned detach_head = flags & RESET_HEAD_DETACH;
     ++	unsigned reset_hard = flags & RESET_HEAD_HARD;
       	struct object_id head_oid;
      -	struct tree_desc desc;
     -+	struct tree_desc desc[2];
     ++	struct tree_desc desc[2] = { { NULL }, { NULL } };
       	struct lock_file lock = LOCK_INIT;
       	struct unpack_trees_options unpack_tree_opts;
       	struct tree *tree;
     @@ -42,18 +45,18 @@
       	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
       		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
      @@
     - 	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
     - 		return -1;
     + 		goto leave_reset_head;
     + 	}
       
      -	if (!oid) {
      -		if (get_oid("HEAD", &head_oid)) {
     --			rollback_lock_file(&lock);
     --			return error(_("could not determine HEAD revision"));
     +-			ret = error(_("could not determine HEAD revision"));
     +-			goto leave_reset_head;
      -		}
      -		oid = &head_oid;
     -+	if (get_oid("HEAD", &head_oid)) {
     -+		rollback_lock_file(&lock);
     -+		return error(_("could not determine HEAD revision"));
     ++	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
     ++		ret = error(_("could not determine HEAD revision"));
     ++		goto leave_reset_head;
       	}
       
      +	if (!oid)
     @@ -70,7 +73,7 @@
       	unpack_tree_opts.merge = 1;
       	if (!detach_head)
      @@
     - 		return error(_("could not read index"));
     + 		goto leave_reset_head;
       	}
       
      -	if (!fill_tree_descriptor(&desc, oid)) {
     @@ -104,7 +107,8 @@
       		string_list_clear(&merge_rr, 1);
       
      -		if (reset_head(NULL, "reset", NULL, 0, NULL, NULL) < 0)
     -+		if (reset_head(NULL, "reset", NULL, 0, 1, NULL, NULL) < 0)
     ++		if (reset_head(NULL, "reset", NULL, RESET_HEAD_HARD,
     ++			       NULL, NULL) < 0)
       			die(_("could not discard worktree changes"));
       		if (read_basic_state(&options))
       			exit(1);
     @@ -113,7 +117,8 @@
       			exit(1);
       		if (reset_head(&options.orig_head, "reset",
      -			       options.head_name, 0, NULL, NULL) < 0)
     -+			       options.head_name, 0, 1, NULL, NULL) < 0)
     ++			       options.head_name, RESET_HEAD_HARD,
     ++			       NULL, NULL) < 0)
       			die(_("could not move back to %s"),
       			    oid_to_hex(&options.orig_head));
       		ret = finish_rebase(&options);
     @@ -122,34 +127,7 @@
       			printf(_("Created autostash: %s\n"), buf.buf);
       			if (reset_head(&head->object.oid, "reset --hard",
      -				       NULL, 0, NULL, NULL) < 0)
     -+				       NULL, 0, 1, NULL, NULL) < 0)
     ++				       NULL, RESET_HEAD_HARD, NULL, NULL) < 0)
       				die(_("could not reset --hard"));
       			printf(_("HEAD is now at %s"),
       			       find_unique_abbrev(&head->object.oid,
     -@@
     - 				strbuf_addf(&buf, "rebase: checkout %s",
     - 					    options.switch_to);
     - 				if (reset_head(&oid, "checkout",
     --					       options.head_name, 0,
     -+					       options.head_name, 0, 0,
     - 					       NULL, NULL) < 0) {
     - 					ret = !!error(_("could not switch to "
     - 							"%s"),
     -@@
     - 			 "it...\n"));
     - 
     - 	strbuf_addf(&msg, "rebase: checkout %s", options.onto_name);
     --	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1,
     -+	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1, 0,
     - 	    NULL, msg.buf))
     - 		die(_("Could not detach HEAD"));
     - 	strbuf_release(&msg);
     -@@
     - 		strbuf_addf(&msg, "rebase finished: %s onto %s",
     - 			options.head_name ? options.head_name : "detached HEAD",
     - 			oid_to_hex(&options.onto->object.oid));
     --		reset_head(NULL, "Fast-forwarded", options.head_name, 0,
     -+		reset_head(NULL, "Fast-forwarded", options.head_name, 0, 0,
     - 			   "HEAD", msg.buf);
     - 		strbuf_release(&msg);
     - 		ret = !!finish_rebase(&options);

-- 
gitgitgadget
