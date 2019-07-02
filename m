Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1886B1F461
	for <e@80x24.org>; Tue,  2 Jul 2019 08:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfGBIGT (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 04:06:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42599 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbfGBIGS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 04:06:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so16610803wrl.9
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 01:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3spsAs2UQQBLIQtGJacsY89icN+INLOOen2faARnm0U=;
        b=hHgrXFYCtyfx0Vb6LqBHsZGYz75VFwUkxyiKEQ5rL1y1Nq++BVu67kXJ1hzlSnsBm8
         35LQeh752ZkFGysdpCbroqLEc9qEtP5rygdmt2vmqsk4mNnFQVeNNdmK+zrwql9kR/LI
         NgAudkbNdwvbQBGxbCx9+SNviqIUjByCPB2MUqlFXR1quGv8/Zlpvvji7OdOHLldppmS
         AHm+KVO0ERg0pX6m/ku128EZZYnkO05JGaSAdGnteGY6ATlfHQ0fuYcPB5J5c0NzfyXg
         3i99AMUut+DX2HVRpLDf7MCLPe6Cg8Gpbcl4qHA0TOdGDNBet7TL8e6pgtqZGZHWLxuD
         mYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3spsAs2UQQBLIQtGJacsY89icN+INLOOen2faARnm0U=;
        b=eEmhS6zJSL/bGnB+r4ZVroIQcew4BzV7FISLFRXCf95Qyqgo7DJukGWW/5C2ruiQjJ
         xSaNch351+YbMFTUdpSPSLuGo6qVyoKjOm95MVPlcbMnYcvA3VbHVX7k8e/ecN69mBu2
         Gl7bvhWQlCBqUXIbzpkmnMV5ENuP5I/DSxWZG0zLz7/efrdVQnfKYxpfsmynobzGye+6
         jKoAagQP76vwlIhu4tMuMaBeq7At9xFOEjdAzzI6/zz5d39gXDuSw8ACtJXL1FBAcmPq
         w8bzLNfELH6WpR+Z4/5mx9y0xYeVYllP0hi3n+feXiJ6NBCm4bZK+g1PhCBRTL8nmc+D
         9PVg==
X-Gm-Message-State: APjAAAUCo9x7t1zcQiKqKhJfjAlY8xvPwS/YiNeMSrIYFhs2X9PHDdAi
        QMUnq6dMC4FpbgHQw8A7LXM=
X-Google-Smtp-Source: APXvYqxgyX/4BWb8LO0BofedivDg4duBz+p9H2aP4Q7nNArGVOyXzRanoeva+HmGaxJNKqe7ESSP6g==
X-Received: by 2002:adf:eacf:: with SMTP id o15mr2071895wrn.309.1562054774917;
        Tue, 02 Jul 2019 01:06:14 -0700 (PDT)
Received: from szeder.dev (x4dbd205f.dyn.telefonica.de. [77.189.32.95])
        by smtp.gmail.com with ESMTPSA id y24sm1502449wmi.10.2019.07.02.01.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 01:06:13 -0700 (PDT)
Date:   Tue, 2 Jul 2019 10:06:11 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v6 07/27] checkout: inform the user when removing branch
 state
Message-ID: <20190702080611.GL21574@szeder.dev>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
 <20190329103919.15642-8-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190329103919.15642-8-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 29, 2019 at 05:38:59PM +0700, Nguyễn Thái Ngọc Duy wrote:
> After a successful switch, if a merge, cherry-pick or revert is ongoing,
> it is canceled. This behavior has been with us from the very early
> beginning, soon after git-merge was created but never actually
> documented [1]. It may be a good idea to be transparent and tell the
> user if some operation is canceled.

After this entered 'next' last week, today it greeted me with 167(!)
of these warnings...  before I even had my breakfast.

Now, my script does a lot of repeated cherry-picks and expects that
rerere is able to deal with most of the conflicts, i.e. it does
approximately this:

  if ! git cherry-pick $oid >/dev/null 2>&1
  then
      if was_the_conflict_resolved
      then
          echo "using previous conflict resolution"
          git commit --no-edit --cleanup=strip --quiet
      else
          die "uh-oh"
      fi
  fi

That 'git commit' in there always prints:

  warning: cancelling a cherry picking in progress

I don't understand why committing after a cherry-pick is considered
"cancelling"...  in my view it's finishing it and there should be no
warning whatsoever.

> I consider this a better way of telling the user than just adding a
> sentence or two in git-checkout.txt, which will be mostly ignored
> anyway.
> 
> PS. Originally I wanted to print more details like
> 
>     warning: cancelling an in-progress merge from <SHA-1>
> 
> which may allow some level of undo if the user wants to. But that seems
> a lot more work. Perhaps it can be improved later if people still want
> that.
> 
> [1] ... and I will try not to argue whether it is a sensible behavior.
> There is some more discussion here if people are interested:
> CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  branch.c           | 11 +++++++----
>  branch.h           |  2 +-
>  builtin/am.c       |  2 +-
>  builtin/checkout.c |  2 +-
>  builtin/rebase.c   |  4 ++--
>  builtin/reset.c    |  2 +-
>  builtin/revert.c   |  2 +-
>  7 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/branch.c b/branch.c
> index 28b81a7e02..8dd5bb9f1c 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -337,11 +337,14 @@ void create_branch(struct repository *r,
>  	free(real_ref);
>  }
>  
> -void remove_branch_state(struct repository *r)
> +void remove_branch_state(struct repository *r, int verbose)
>  {
> -	unlink(git_path_cherry_pick_head(r));
> -	unlink(git_path_revert_head(r));
> -	unlink(git_path_merge_head(r));
> +	if (!unlink(git_path_cherry_pick_head(r)) && verbose)
> +		warning(_("cancelling a cherry picking in progress"));
> +	if (!unlink(git_path_revert_head(r)) && verbose)
> +		warning(_("cancelling a revert in progress"));
> +	if (!unlink(git_path_merge_head(r)) && verbose)
> +		warning(_("cancelling a merge in progress"));
>  	unlink(git_path_merge_rr(r));
>  	unlink(git_path_merge_msg(r));
>  	unlink(git_path_merge_mode(r));
> diff --git a/branch.h b/branch.h
> index 29c1afa4d0..aed045901e 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -64,7 +64,7 @@ extern int validate_new_branchname(const char *name, struct strbuf *ref, int for
>   * Remove information about the state of working on the current
>   * branch. (E.g., MERGE_HEAD)
>   */
> -void remove_branch_state(struct repository *r);
> +void remove_branch_state(struct repository *r, int verbose);
>  
>  /*
>   * Configure local branch "local" as downstream to branch "remote"
> diff --git a/builtin/am.c b/builtin/am.c
> index 4fb107a9d1..99b66508fd 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1957,7 +1957,7 @@ static int clean_index(const struct object_id *head, const struct object_id *rem
>  	if (merge_tree(remote_tree))
>  		return -1;
>  
> -	remove_branch_state(the_repository);
> +	remove_branch_state(the_repository, 0);
>  
>  	return 0;
>  }
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 0e6037b296..f66bd2f56d 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -899,7 +899,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  				delete_reflog(old_branch_info->path);
>  		}
>  	}
> -	remove_branch_state(the_repository);
> +	remove_branch_state(the_repository, !opts->quiet);
>  	strbuf_release(&msg);
>  	if (!opts->quiet &&
>  	    (new_branch_info->path || (!opts->force_detach && !strcmp(new_branch_info->name, "HEAD"))))
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 52114cbf0d..646d0f9fb1 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1272,7 +1272,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		if (reset_head(NULL, "reset", NULL, RESET_HEAD_HARD,
>  			       NULL, NULL) < 0)
>  			die(_("could not discard worktree changes"));
> -		remove_branch_state(the_repository);
> +		remove_branch_state(the_repository, 0);
>  		if (read_basic_state(&options))
>  			exit(1);
>  		goto run_rebase;
> @@ -1292,7 +1292,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			       NULL, NULL) < 0)
>  			die(_("could not move back to %s"),
>  			    oid_to_hex(&options.orig_head));
> -		remove_branch_state(the_repository);
> +		remove_branch_state(the_repository, 0);
>  		ret = finish_rebase(&options);
>  		goto cleanup;
>  	}
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 7882829a95..6d9397c844 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -420,7 +420,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  			print_new_head_line(lookup_commit_reference(the_repository, &oid));
>  	}
>  	if (!pathspec.nr)
> -		remove_branch_state(the_repository);
> +		remove_branch_state(the_repository, 0);
>  
>  	return update_ref_status;
>  }
> diff --git a/builtin/revert.c b/builtin/revert.c
> index a47b53ceaf..ebf2789225 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -196,7 +196,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>  	if (cmd == 'q') {
>  		int ret = sequencer_remove_state(opts);
>  		if (!ret)
> -			remove_branch_state(the_repository);
> +			remove_branch_state(the_repository, 0);
>  		return ret;
>  	}
>  	if (cmd == 'c')
> -- 
> 2.21.0.479.g47ac719cd3
> 
