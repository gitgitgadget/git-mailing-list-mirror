Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B77364EA5
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368941; cv=none; b=SmQT1NqVVmDZcQGr4ZJj+EsVYxlcnn9+eu2p8iHlpxwlEX+Vtca0xieNW+Yikq6DX96Ht52Quwd7qBE1eC4hIcwTxXqUD5FrrA8yIf1yYi/9CcaRqsaLi8JothBgudlD5otESgB4UR103r8KnAq07gqBifK82fYvx4DZ76i+rvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368941; c=relaxed/simple;
	bh=hvzuzSAdi8fTLc+lUNjCurpMpMwl1zdG5w8lkylKKh4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MVNQ51w737Wibq2sWU9XVqpvBZm84QwGziQDtLCWChOY9eXeb+yImiF9db5mQE6AjfTP/wk3/t+huYmVK1QkF3TIa8Cak33guY0nro8xi294djx3sINdbOuvIe+Lfd/YONPNRqTZityFqlevRc28Vl5y9JU9Tk6F36b+92CcrWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnyFqOG3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnyFqOG3"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so95647435e9.2
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777368937; x=1777973737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ktAgEy4xF30gPk67lq1iFMXG0yHq/H983ttQTjZXNTg=;
        b=VnyFqOG3EbsPruptASTqMpq4zw68+PoJP4xMt1ZFgipiejV+CvyBjeEDsqFm8i+5Vr
         hIzrRD14Gt/0GwXGKUCEHGqYyD2HeNPUwPnuyGl1QXoUpe+9JaZ976uwQYxWPm57Y8pY
         8/UWofw8upfouM6nnX9+mKK1WYOuOLQqFG2dn4Vz7oTXj9dETYXQqc/63Lx1IbiAuJu6
         Zf5iZ66ZoKpVFHoCiT54L0bBbCaNeOGCfDiJ5yfnzztx5PtebE0ifsRBzG6kBODM6ebq
         WUkcDUWMNibMtWA/F59deMQVOuf2biHfVIg3zC7vSd3Zg/ejThiiIACsJ7AUGLl9V9tI
         VmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368937; x=1777973737;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktAgEy4xF30gPk67lq1iFMXG0yHq/H983ttQTjZXNTg=;
        b=dNvi/pwpRtOM7IltkHTurI7viFpdB7GRlEFVZrpbBFC7Gad8OvWBmY24KmdwD3ip6q
         I7rwvN2jqTq4ILnx+6LBAu/dBB5j5c99a9prr94I+Xr+VjwLcWzBgO51Ph9E9WZcNQdS
         EIO88LWzXA2HPIabT5j4aO4lEDH3zZgQF1FiMJdDQ8flMFM6nchDvP8hKCMefuiQQcWl
         75whw3o2QepPw5Kmb9EbvLZVcmDMlPctzqi1ENU6KVvcEtuXY3A1qrsy+pTaSuhnb8DL
         E0DT37cHRN0k0c0Xt2qXjt02YcXb323TipH4ikwHBuRFJ4NLYg0NSUMCE7eEjAV2QnT7
         WEqw==
X-Forwarded-Encrypted: i=1; AFNElJ8gbcJ37uRHHcvkrpt/rZZrkCfl58K3m3E9HsXFVYdKPb9F5wbuQritsg89YhMX5fwPS0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdrX1G3Tbcw8NVbUCvPoS1YHrDUOtTDm7St7852YhXLAhCSKGb
	6VEokif24g55owAi3Z6lIOSLI3x2t4SJMSUYbVfUuWlqMl9WVPaYU2XW
X-Gm-Gg: AeBDietRfbbPg6nTtemlbRVTtAhdld56n5ueZxn9w5O3kiWm4QYKT/gs3CAgZin5pS3
	X2DRo5UuywK0c8dxT7eXIFyKT2lxy3Fr/BKhmyhQXXpcDbJKQfdwRNXAIvITG4QlJzSD508kcg9
	PW74wxx/JzR0ZLd64dXSFygbmE7sbpyttsxv0kpuRm88UfOw/wYZH43miC4WK8iNU08KKwftQCK
	+045vqGputGGFVBJ/wOzNIb3zfDqJmIeTlQPsY/Gz38Qhaii2Jg41fLkyR/CbfFDNW91lxQW4kW
	HwNQ9b9uQKP3s7fseFgRnSGU5qXPw0fg/8i6+Xl1qTt595VLOI8+gFD8HAo//wQQvIpfQKHp7xi
	ZY8ZEkZAzF/KTwNx9Zy2TmwCc1qXTvSaWBc5DDO8FhTXQT6nucDXcu6uSneQedK2tMm/wiLHbre
	nN5rOs19hniFZZriOdLgu+keXhBmi6T/XMrD1H/Nm9QBH2Ux4/94lDpiRoZzSb9kAhi8Bh/oWrj
	PhPQ7I5AB2klg==
X-Received: by 2002:a05:600c:a11:b0:488:ab37:b442 with SMTP id 5b1f17b1804b1-48a77b25374mr34448295e9.28.1777368936572;
        Tue, 28 Apr 2026 02:35:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773af544sm45864805e9.6.2026.04.28.02.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:35:36 -0700 (PDT)
Message-ID: <df5bf999-c545-4cb4-94da-b9062b026421@gmail.com>
Date: Tue, 28 Apr 2026 10:35:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v15 0/5] checkout: 'autostash' for branch switching
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
 <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 24/04/2026 22:10, Harald Nordgren via GitGitGadget wrote:
>   * When the initial merge fails, the caller now knows for sure it was a
>     conflict (not some unrelated error) before kicking off the autostash.
> 
>   * If the second attempt also fails, the user now actually sees why.
>     Previously errors like "would be overwritten by checkout" were being
>     swallowed.
> 
>   * The stash is reapplied right after the second attempt, so it won't get
>     left behind if something else goes wrong later in the checkout.
> 
>   * A couple of clean-up steps only run when we actually stashed, so regular
>     checkouts aren't paying for work they don't need.
> 
>   * Added a small header "The following paths have local changes:" before the
>     list of changed files, so it doesn't look like part of the conflict
>     advice above it.
> 
>   * Reworded the conflict advice into a single paragraph. Feels less shouty
>     and doesn't say "local changes" three times.
> 
>   * Trimmed and consolidated tests in t7201. A bunch of the old ones couldn't
>     actually fail, or were really testing other things; the conflict-path
>     tests are now a single test that checks the stash entry directly.

Thanks for the summary, that all looks good. I've left some comments on 
Patches 1 and 3 but they can be future work and don't need to hold this 
series up. There are a few small issues that need addressing on Patch 5 
but hopefully the next iteration will be the last.

Thanks

Phillip

> Harald Nordgren (5):
>    stash: add --label-ours, --label-theirs, --label-base for apply
>    sequencer: allow create_autostash to run silently
>    sequencer: teach autostash apply to take optional conflict marker
>      labels
>    checkout: rollback lock on early returns in merge_working_tree
>    checkout -m: autostash when switching branches
> 
>   Documentation/git-checkout.adoc |  58 +++++------
>   Documentation/git-stash.adoc    |  11 ++-
>   Documentation/git-switch.adoc   |  33 +++----
>   builtin/checkout.c              | 165 +++++++++++++++-----------------
>   builtin/commit.c                |   3 +-
>   builtin/merge.c                 |  15 ++-
>   builtin/stash.c                 |  28 ++++--
>   sequencer.c                     |  69 +++++++++----
>   sequencer.h                     |   7 +-
>   t/t3420-rebase-autostash.sh     |  16 ++--
>   t/t3903-stash.sh                |  24 +++++
>   t/t7201-co.sh                   |  61 +++++++++++-
>   t/t7600-merge.sh                |   3 +-
>   xdiff-interface.c               |  12 +++
>   xdiff-interface.h               |   1 +
>   xdiff/xmerge.c                  |   6 +-
>   16 files changed, 335 insertions(+), 177 deletions(-)
> 
> 
> base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v15
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v15
> Pull-Request: https://github.com/git/git/pull/2234
> 
> Range-diff vs v14:
> 
>   1:  e18c25599a = 1:  aba8e6a9dc stash: add --label-ours, --label-theirs, --label-base for apply
>   2:  ce29b10264 = 2:  89e0bfa803 sequencer: allow create_autostash to run silently
>   3:  73051d1762 = 3:  a428ce7328 sequencer: teach autostash apply to take optional conflict marker labels
>   4:  191058d8e3 = 4:  f358424085 checkout: rollback lock on early returns in merge_working_tree
>   5:  86f33df1eb ! 5:  96b14db827 checkout -m: autostash when switching branches
>       @@ builtin/checkout.c
>         #include "setup.h"
>         #include "submodule.h"
>         #include "symlinks.h"
>       +@@ builtin/checkout.c: struct checkout_opts {
>       + 	.auto_advance = 1, \
>       + }
>       +
>       ++#define MERGE_WORKING_TREE_UNPACK_FAILED (-2)
>       ++
>       + struct branch_info {
>       + 	char *name; /* The short name used */
>       + 	char *path; /* The full name of a real branch */
>       +@@ builtin/checkout.c: static void setup_branch_path(struct branch_info *branch)
>       +
>       + static void init_topts(struct unpack_trees_options *topts, int merge,
>       + 		       int show_progress, int overwrite_ignore,
>       +-		       struct commit *old_commit)
>       ++		       struct commit *old_commit, bool show_unpack_errors)
>       + {
>       + 	memset(topts, 0, sizeof(*topts));
>       + 	topts->head_idx = -1;
>       +@@ builtin/checkout.c: static void init_topts(struct unpack_trees_options *topts, int merge,
>       + 	topts->initial_checkout = is_index_unborn(the_repository->index);
>       + 	topts->update = 1;
>       + 	topts->merge = 1;
>       +-	topts->quiet = merge && old_commit;
>       ++	topts->quiet = merge && old_commit && !show_unpack_errors;
>       + 	topts->verbose_update = show_progress;
>       + 	topts->fn = twoway_merge;
>       + 	topts->preserve_ignored = !overwrite_ignore;
>       +@@ builtin/checkout.c: static void init_topts(struct unpack_trees_options *topts, int merge,
>       + static int merge_working_tree(const struct checkout_opts *opts,
>       + 			      struct branch_info *old_branch_info,
>       + 			      struct branch_info *new_branch_info,
>       +-			      int *writeout_error)
>       ++			      int *writeout_error,
>       ++			      bool show_unpack_errors)
>       + {
>       + 	int ret;
>       + 	struct lock_file lock_file = LOCK_INIT;
>       +@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
>       +
>       + 		/* 2-way merge to the new branch */
>       + 		init_topts(&topts, opts->merge, opts->show_progress,
>       +-			   opts->overwrite_ignore, old_branch_info->commit);
>       ++			   opts->overwrite_ignore, old_branch_info->commit,
>       ++			   show_unpack_errors);
>       + 		init_checkout_metadata(&topts.meta, new_branch_info->refname,
>       + 				       new_branch_info->commit ?
>       + 				       &new_branch_info->commit->object.oid :
>        @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
>         		ret = unpack_trees(2, trees, &topts);
>         		clear_unpack_trees_porcelain(&topts);
>       @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *op
>        -				return ret;
>        -			}
>        +			rollback_lock_file(&lock_file);
>       -+			return ret;
>       ++			return MERGE_WORKING_TREE_UNPACK_FAILED;
>         		}
>         	}
>         
>       @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
>         			do_merge = 0;
>         	}
>         
>       -+	if (old_branch_info.name)
>       ++	if (old_branch_info.name) {
>        +		stash_label_base = old_branch_info.name;
>       -+	else if (old_branch_info.commit) {
>       ++	} else if (old_branch_info.commit) {
>        +		strbuf_add_unique_abbrev(&old_commit_shortname,
>        +					 &old_branch_info.commit->object.oid,
>        +					 DEFAULT_ABBREV);
>       @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
>        +	}
>        +
>         	if (do_merge) {
>       - 		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
>       -+		if (ret == -1 && opts->merge) {
>       +-		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
>       ++		ret = merge_working_tree(opts, &old_branch_info, new_branch_info,
>       ++					 &writeout_error, false);
>       ++		if (ret == MERGE_WORKING_TREE_UNPACK_FAILED && opts->merge) {
>        +			strbuf_addf(&autostash_msg,
>        +				    "autostash while switching to '%s'",
>        +				    new_branch_info->name);
>       @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
>        +					     "CHECKOUT_AUTOSTASH_HEAD",
>        +					     autostash_msg.buf, true);
>        +			created_autostash = 1;
>       -+			ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
>       ++			ret = merge_working_tree(opts, &old_branch_info, new_branch_info,
>       ++						 &writeout_error, true);
>       ++		}
>       ++		if (created_autostash) {
>       ++			if (opts->conflict_style >= 0) {
>       ++				struct strbuf cfg = STRBUF_INIT;
>       ++				strbuf_addf(&cfg, "merge.conflictStyle=%s",
>       ++					    conflict_style_name(opts->conflict_style));
>       ++				git_config_push_parameter(cfg.buf);
>       ++				strbuf_release(&cfg);
>       ++			}
>       ++			apply_autostash_ref(the_repository,
>       ++					    "CHECKOUT_AUTOSTASH_HEAD",
>       ++					    new_branch_info->name,
>       ++					    "local",
>       ++					    stash_label_base,
>       ++					    autostash_msg.buf);
>        +		}
>         		if (ret) {
>       -+			if (created_autostash)
>       -+				apply_autostash_ref(the_repository,
>       -+						    "CHECKOUT_AUTOSTASH_HEAD",
>       -+						    new_branch_info->name,
>       -+						    "local",
>       -+						    stash_label_base,
>       -+						    autostash_msg.buf);
>         			branch_info_release(&old_branch_info);
>        -			return ret;
>        +			strbuf_release(&old_commit_shortname);
>       @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
>         
>         	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
>         
>       -+	if (opts->conflict_style >= 0) {
>       -+		struct strbuf cfg = STRBUF_INIT;
>       -+		strbuf_addf(&cfg, "merge.conflictStyle=%s",
>       -+			    conflict_style_name(opts->conflict_style));
>       -+		git_config_push_parameter(cfg.buf);
>       -+		strbuf_release(&cfg);
>       ++	if (created_autostash) {
>       ++		discard_index(the_repository->index);
>       ++		if (repo_read_index(the_repository) < 0)
>       ++			die(_("index file corrupt"));
>       ++
>       ++		if (!opts->quiet && new_branch_info->commit) {
>       ++			printf(_("The following paths have local changes:\n"));
>       ++			show_local_changes(&new_branch_info->commit->object,
>       ++					   &opts->diff_options);
>       ++		}
>        +	}
>       -+	apply_autostash_ref(the_repository, "CHECKOUT_AUTOSTASH_HEAD",
>       -+			    new_branch_info->name, "local",
>       -+			    stash_label_base,
>       -+			    autostash_msg.buf);
>       -+
>       -+	discard_index(the_repository->index);
>       -+	if (repo_read_index(the_repository) < 0)
>       -+		die(_("index file corrupt"));
>       -+
>       -+	if (created_autostash && !opts->quiet && new_branch_info->commit)
>       -+		show_local_changes(&new_branch_info->commit->object,
>       -+				   &opts->diff_options);
>        +
>         	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
>         	branch_info_release(&old_branch_info);
>       @@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int atte
>         			ret = error(_("cannot store %s"), stash_oid);
>        +		else if (attempt_apply)
>        +			fprintf(stderr,
>       -+				_("Your local changes are stashed, however, applying it to carry\n"
>       -+				  "forward your local changes resulted in conflicts:\n"
>       -+				  "\n"
>       -+				  " - You can try resolving them now.  If you resolved them\n"
>       -+				  "   successfully, discard the stash entry with \"git stash drop\".\n"
>       -+				  "\n"
>       -+				  " - Alternatively you can \"git reset --hard\" if you do not want\n"
>       -+				  "   to deal with them right now, and later \"git stash pop\" to\n"
>       -+				  "   recover your local changes.\n"));
>       ++				_("Your local changes are stashed, however applying them\n"
>       ++				  "resulted in conflicts.  You can either resolve the conflicts\n"
>       ++				  "and then discard the stash with \"git stash drop\", or, if you\n"
>       ++				  "do not want to resolve them now, run \"git reset --hard\" and\n"
>       ++				  "apply the local changes later by running \"git stash pop\".\n"));
>         		else
>         			fprintf(stderr,
>        -				_("%s\n"
>       @@ t/t3420-rebase-autostash.sh: create_expected_failure_apply () {
>        -	Applying autostash resulted in conflicts.
>        -	Your changes are safe in the stash.
>        -	You can run "git stash pop" or "git stash drop" at any time.
>       -+	Your local changes are stashed, however, applying it to carry
>       -+	forward your local changes resulted in conflicts:
>       -+
>       -+	 - You can try resolving them now.  If you resolved them
>       -+	   successfully, discard the stash entry with "git stash drop".
>       -+
>       -+	 - Alternatively you can "git reset --hard" if you do not want
>       -+	   to deal with them right now, and later "git stash pop" to
>       -+	   recover your local changes.
>       ++	Your local changes are stashed, however applying them
>       ++	resulted in conflicts.  You can either resolve the conflicts
>       ++	and then discard the stash with "git stash drop", or, if you
>       ++	do not want to resolve them now, run "git reset --hard" and
>       ++	apply the local changes later by running "git stash pop".
>         	EOF
>         }
>         
>       @@ t/t3420-rebase-autostash.sh: create_expected_failure_apply () {
>        -	Applying autostash resulted in conflicts.
>        -	Your changes are safe in the stash.
>        -	You can run "git stash pop" or "git stash drop" at any time.
>       -+	Your local changes are stashed, however, applying it to carry
>       -+	forward your local changes resulted in conflicts:
>       -+
>       -+	 - You can try resolving them now.  If you resolved them
>       -+	   successfully, discard the stash entry with "git stash drop".
>       -+
>       -+	 - Alternatively you can "git reset --hard" if you do not want
>       -+	   to deal with them right now, and later "git stash pop" to
>       -+	   recover your local changes.
>       ++	Your local changes are stashed, however applying them
>       ++	resulted in conflicts.  You can either resolve the conflicts
>       ++	and then discard the stash with "git stash drop", or, if you
>       ++	do not want to resolve them now, run "git reset --hard" and
>       ++	apply the local changes later by running "git stash pop".
>         	Successfully rebased and updated refs/heads/rebased-feature-branch.
>         	EOF
>         }
>        
>         ## t/t7201-co.sh ##
>       +@@ t/t7201-co.sh: test_expect_success 'checkout -m with dirty tree' '
>       +
>       + 	test "$(git symbolic-ref HEAD)" = "refs/heads/side" &&
>       +
>       +-	printf "M\t%s\n" one >expect.messages &&
>       ++	printf "The following paths have local changes:\nM\t%s\n" one >expect.messages &&
>       + 	test_cmp expect.messages messages &&
>       +
>       + 	fill "M	one" "A	three" "D	two" >expect.main &&
>        @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
>         	test_cmp expect two
>         '
>         
>       -+test_expect_success 'checkout --merge --conflict=zdiff3 <branch>' '
>       -+	git checkout -f main &&
>       -+	git reset --hard &&
>       -+	git clean -f &&
>       -+
>       -+	fill a b X d e >two &&
>       -+	git checkout --merge --conflict=zdiff3 simple &&
>       -+
>       -+	cat <<-EOF >expect &&
>       -+	a
>       -+	<<<<<<< simple
>       -+	c
>       -+	||||||| main
>       -+	b
>       -+	c
>       -+	d
>       -+	=======
>       -+	b
>       -+	X
>       -+	d
>       -+	>>>>>>> local
>       -+	e
>       -+	EOF
>       -+	test_cmp expect two
>       -+'
>       -+
>       -+test_expect_success 'checkout -m respects merge.conflictStyle config' '
>       -+	git checkout -f main &&
>       -+	git reset --hard &&
>       -+	git clean -f &&
>       -+
>       -+	test_config merge.conflictStyle diff3 &&
>       -+	fill b d >two &&
>       -+	git checkout -m simple &&
>       -+
>       -+	cat <<-EOF >expect &&
>       -+	<<<<<<< simple
>       -+	a
>       -+	c
>       -+	e
>       -+	||||||| main
>       -+	a
>       -+	b
>       -+	c
>       -+	d
>       -+	e
>       -+	=======
>       -+	b
>       -+	d
>       -+	>>>>>>> local
>       -+	EOF
>       -+	test_cmp expect two
>       -+'
>       -+
>       -+test_expect_success 'checkout -m skips stash when no conflict' '
>       -+	git checkout -f main &&
>       -+	git clean -f &&
>       -+
>       -+	fill 0 x y z >same &&
>       -+	git stash list >stash-before &&
>       -+	git checkout -m side >actual 2>&1 &&
>       -+	test_grep ! "Created autostash" actual &&
>       -+	git stash list >stash-after &&
>       -+	test_cmp stash-before stash-after &&
>       -+	fill 0 x y z >expect &&
>       -+	test_cmp expect same
>       -+'
>       -+
>       -+test_expect_success 'checkout -m skips stash with non-conflicting dirty index' '
>       -+	git checkout -f main &&
>       -+	git clean -f &&
>       -+
>       -+	fill 0 x y z >same &&
>       -+	git add same &&
>       -+	git checkout -m side >actual 2>&1 &&
>       -+	test_grep ! "Created autostash" actual &&
>       -+	fill 0 x y z >expect &&
>       -+	test_cmp expect same
>       -+'
>       -+
>       -+test_expect_success 'checkout -m stashes and applies on conflicting changes' '
>       -+	git checkout -f main &&
>       -+	git clean -f &&
>       -+
>       -+	fill 1 2 3 4 5 6 7 >one &&
>       -+	git checkout -m side >actual 2>&1 &&
>       -+	test_grep ! "Created autostash" actual &&
>       -+	test_grep "Applied autostash" actual &&
>       -+	fill 1 2 3 4 5 6 7 >expect &&
>       -+	test_cmp expect one
>       -+'
>       -+
>        +test_expect_success 'checkout -m with mixed staged and unstaged changes' '
>        +	git checkout -f main &&
>        +	git clean -f &&
>       @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
>        +	git add same &&
>        +	fill 1 2 3 4 5 6 7 >one &&
>        +	git checkout -m side >actual 2>&1 &&
>       -+	test_grep ! "Created autostash" actual &&
>        +	test_grep "Applied autostash" actual &&
>        +	fill 0 x y z >expect &&
>        +	test_cmp expect same &&
>       @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
>        +	test_cmp expect one
>        +'
>        +
>       -+test_expect_success 'checkout -m stashes on truly conflicting changes' '
>       ++test_expect_success 'checkout -m creates a recoverable stash on conflict' '
>        +	git checkout -f main &&
>        +	git clean -f &&
>        +
>       @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
>        +	test_must_fail git checkout side 2>stderr &&
>        +	test_grep "Your local changes" stderr &&
>        +	git checkout -m side >actual 2>&1 &&
>       -+	test_grep ! "Created autostash" actual &&
>        +	test_grep "resulted in conflicts" actual &&
>        +	test_grep "git stash drop" actual &&
>       ++	test_grep "git stash pop" actual &&
>       ++	test_grep "The following paths have local changes" actual &&
>       ++	git show --format=%B --diff-merges=1 refs/stash >actual &&
>       ++	sed /^index/d actual >actual.trimmed &&
>       ++	cat >expect <<-EOF &&
>       ++	On main: autostash while switching to ${SQ}side${SQ}
>       ++
>       ++	diff --git a/one b/one
>       ++	--- a/one
>       ++	+++ b/one
>       ++	@@ -3,6 +3,3 @@
>       ++	 3
>       ++	 4
>       ++	 5
>       ++	-6
>       ++	-7
>       ++	-8
>       ++	EOF
>       ++	test_cmp expect actual.trimmed &&
>        +	git stash drop &&
>        +	git reset --hard
>        +'
>        +
>       -+test_expect_success 'checkout -m produces usable stash on conflict' '
>       -+	git checkout -f main &&
>       -+	git clean -f &&
>       -+
>       ++test_expect_success 'checkout -m which would overwrite untracked file' '
>       ++	git checkout -f --detach main &&
>       ++	test_commit another-file &&
>       ++	git checkout HEAD^ &&
>       ++	>another-file.t &&
>        +	fill 1 2 3 4 5 >one &&
>       -+	git checkout -m side >actual 2>&1 &&
>       -+	test_grep "recover your local changes" actual &&
>       -+	git checkout -f main &&
>       -+	git stash pop &&
>       -+	fill 1 2 3 4 5 >expect &&
>       -+	test_cmp expect one
>       -+'
>       -+
>       -+test_expect_success 'checkout -m autostash message includes target branch' '
>       -+	git checkout -f main &&
>       -+	git clean -f &&
>       -+
>       -+	fill 1 2 3 4 5 >one &&
>       -+	git checkout -m side >actual 2>&1 &&
>       -+	git stash list >stash-list &&
>       -+	test_grep "autostash while switching to .side." stash-list &&
>       -+	git stash drop &&
>       -+	git checkout -f main &&
>       -+	git reset --hard
>       -+'
>       -+
>       -+test_expect_success 'checkout -m stashes on staged conflicting changes' '
>       -+	git checkout -f main &&
>       -+	git clean -f &&
>       -+
>       -+	fill 1 2 3 4 5 >one &&
>       -+	git add one &&
>       -+	git checkout -m side >actual 2>&1 &&
>       -+	test_grep ! "Created autostash" actual &&
>       -+	test_grep "resulted in conflicts" actual &&
>       -+	test_grep "git stash drop" actual &&
>       -+	git stash drop &&
>       -+	git reset --hard
>       -+'
>       -+
>       -+test_expect_success 'checkout -m applies stash cleanly with non-overlapping changes in same file' '
>       -+	git checkout -f main &&
>       -+	git reset --hard &&
>       -+	git clean -f &&
>       -+
>       -+	git checkout -b nonoverlap_base &&
>       -+	fill a b c d >file &&
>       -+	git add file &&
>       -+	git commit -m "add file" &&
>       -+
>       -+	git checkout -b nonoverlap_child &&
>       -+	fill a b c INSERTED d >file &&
>       -+	git commit -a -m "insert line near end of file" &&
>       -+
>       -+	fill DIRTY a b c INSERTED d >file &&
>       -+
>       -+	git stash list >stash-before &&
>       -+	git checkout -m nonoverlap_base 2>stderr &&
>       -+	test_grep "Applied autostash" stderr &&
>       -+	test_grep ! "resulted in conflicts" stderr &&
>       -+
>       -+	git stash list >stash-after &&
>       -+	test_cmp stash-before stash-after &&
>       -+
>       -+	fill DIRTY a b c d >expect &&
>       -+	test_cmp expect file &&
>       -+
>       -+	git checkout -f main &&
>       -+	git branch -D nonoverlap_base &&
>       -+	git branch -D nonoverlap_child
>       -+'
>       -+
>       -+test_expect_success 'checkout -m -b skips stash with dirty tree' '
>       -+	git checkout -f main &&
>       -+	git clean -f &&
>       -+
>       -+	fill 0 x y z >same &&
>       -+	git checkout -m -b newbranch >actual 2>&1 &&
>       -+	test_grep ! "Created autostash" actual &&
>       -+	fill 0 x y z >expect &&
>       -+	test_cmp expect same &&
>       -+	git checkout main &&
>       -+	git branch -D newbranch
>       ++	test_must_fail git checkout -m @{-1} 2>err &&
>       ++	test_grep "would be overwritten by checkout" err &&
>       ++	test_grep "another-file.t" err
>        +'
>        +
>         test_expect_success 'switch to another branch while carrying a deletion' '
>       @@ t/t7600-merge.sh: test_expect_success 'merge with conflicted --autostash changes
>         	test_when_finished "test_might_fail git stash drop" &&
>         	git merge --autostash c3 2>err &&
>        -	test_grep "Applying autostash resulted in conflicts." err &&
>       -+	test_grep "your local changes resulted in conflicts" err &&
>       ++	test_grep "applying them" err &&
>       ++	test_grep "resulted in conflicts" err &&
>         	git show HEAD:file >merge-result &&
>         	test_cmp result.1-9 merge-result &&
>         	git stash show -p >actual &&
> 

