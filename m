Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44A7F20248
	for <e@80x24.org>; Mon, 25 Mar 2019 05:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbfCYFrf (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 01:47:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38895 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbfCYFre (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 01:47:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so3676874pgl.5
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 22:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nro3S9qob0HtQM5Ga0G3H2Owdb/rYLPj3dmnnyCVDkM=;
        b=F+ytyRC5FfPxiXPIG0hTxWkrxlrlhhoszCpDgfIfhQA06ti+Mnc0MUCCLAaiC3lDLK
         hSbNnW+PnnjcMso03SKlxLi7I3Fnb3DFYl9kQQi6jm2WoacQ47X47dGWJjMLr0eZHqaC
         eUsm4Krhkng8VpsrQohpRzpQtLJHwtuytbvYw/fVa1yrIWxXjKjtEbPfAs2c+f2C5UuE
         JXRKLvWe5+C7H5FxdrBTjval1q27U3+dymO+6HKKk25b9MiXHecVJrykmnarOSbaZKRs
         ZunTlWZwD1CjRK/cju1X6mQwm+J+NkP3iLmg6Ot31Ep4cWkSxj/JqSMbAXKe2VMbKxqs
         ncxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nro3S9qob0HtQM5Ga0G3H2Owdb/rYLPj3dmnnyCVDkM=;
        b=pIEAeyex8/l6XSwjJDycCposQ7dgG5YI+nC2Amw8nOvtAQgDd/hDxvatkuQr5UEcG3
         +jBS0ccK/nrCQuFNExGFYpCxqeYGspvS70xj9RlIgamg4Js0ekmE15ZsnPvc9750SZyG
         vZLDpuzgnvrig4xw0Sqyo9O0bPlzfWU0Nix/N20UWvirH36tU8b1m4jQDP/s4FkA4VlW
         fTcrDfg6eOL3j736cFGbZ/RUm3vJ/pzuc7n+oDTpqTp6HTrYBC6mQyPizjBH37zqNNCr
         uA9LLIB1tCOv2Ven5s+ZBJffFCoSyXbZaYjc6cTuRHsWGwB+HyrBQYGWl6caekXb5XA3
         gNMA==
X-Gm-Message-State: APjAAAUfiw5L5I1oLgIizjhmCuDCWLePvfxpfVR31hyBbeLIVnKX89Ln
        WIYp1uxCRKVhwWtXwlulkcJhdVZ+
X-Google-Smtp-Source: APXvYqx1r0aFaZ2fnxgIwbondKNPfXlzdvr6qdhGo2MGeqg8xvBEHQcKsGT0/QTHT7FCpFwrnF09Pw==
X-Received: by 2002:a17:902:b707:: with SMTP id d7mr23246061pls.91.1553492853116;
        Sun, 24 Mar 2019 22:47:33 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id t129sm22520685pfb.127.2019.03.24.22.47.31
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 22:47:32 -0700 (PDT)
Date:   Sun, 24 Mar 2019 22:47:30 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] rebase: teach rebase --keep-base
Message-ID: <20190325054730.GB1652@archbookpro.localdomain>
References: <cover.1553354374.git.liu.denton@gmail.com>
 <f802e5442013613221a4efd8ef1fecce0f3a9914.1553354374.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f802e5442013613221a4efd8ef1fecce0f3a9914.1553354374.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 23, 2019 at 08:25:28AM -0700, Denton Liu wrote:
> A common scenario is if a user is working on a topic branch and they
> wish to make some changes to intermediate commits or autosquashing, they

Sorry, small typo here:

s/autosquashing/autosquash/

-Denton

> would run something such as
> 
> 	git rebase -i --onto master... master
> 
> in order to preserve the merge base. This prevents unnecessary commit
> churning.
> 
> Alternatively, a user wishing to test individual commits in a topic
> branch without changing anything may run
> 
> 	git rebase -x ./test.sh master... master
> 
> Since rebasing onto the merge base of the branch and the upstream is
> such a common case, introduce the --keep-base option as a shortcut.
> 
> This allows us to rewrite the above as
> 
> 	git rebase -i --keep-base master
> 
> and
> 
> 	git rebase -x ./test.sh --keep-base master
> 
> respectively.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  builtin/rebase.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 77deebc65c..fffee89064 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -27,8 +27,8 @@
>  #include "branch.h"
>  
>  static char const * const builtin_rebase_usage[] = {
> -	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
> -		"[<upstream>] [<branch>]"),
> +	N_("git rebase [-i] [options] [--exec <cmd>] "
> +		"[--onto <newbase> | --keep-base] [<upstream> [<branch>]]"),
>  	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
>  		"--root [<branch>]"),
>  	N_("git rebase --continue | --abort | --skip | --edit-todo"),
> @@ -1018,6 +1018,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	};
>  	const char *branch_name;
>  	int ret, flags, total_argc, in_progress = 0;
> +	int keep_base = 0;
>  	int ok_to_skip_pre_rebase = 0;
>  	struct strbuf msg = STRBUF_INIT;
>  	struct strbuf revisions = STRBUF_INIT;
> @@ -1051,6 +1052,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		OPT_STRING(0, "onto", &options.onto_name,
>  			   N_("revision"),
>  			   N_("rebase onto given branch instead of upstream")),
> +		OPT_BOOL(0, "keep-base", &keep_base,
> +			 N_("use the merge-base of upstream and branch as the current base")),
>  		OPT_BOOL(0, "no-verify", &ok_to_skip_pre_rebase,
>  			 N_("allow pre-rebase hook to run")),
>  		OPT_NEGBIT('q', "quiet", &options.flags,
> @@ -1217,6 +1220,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		usage_with_options(builtin_rebase_usage,
>  				   builtin_rebase_options);
>  
> +	if (keep_base) {
> +		if (options.onto_name)
> +			die(_("cannot combine '--keep-base' with '--onto'"));
> +		if (options.root)
> +			die(_("cannot combine '--keep-base' with '--root'"));
> +	}
> +
>  	if (action != NO_ACTION && !in_progress)
>  		die(_("No rebase in progress?"));
>  	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
> @@ -1541,10 +1551,19 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	/* Make sure the branch to rebase onto is valid. */
> -	if (!options.onto_name)
> +	if (keep_base) {
> +	    strbuf_reset(&buf);
> +	    strbuf_addstr(&buf, options.upstream_name);
> +	    strbuf_addstr(&buf, "...");
> +	    options.onto_name = xstrdup(buf.buf);
> +	} else if (!options.onto_name)
>  		options.onto_name = options.upstream_name;
>  	if (strstr(options.onto_name, "...")) {
>  		if (get_oid_mb(options.onto_name, &merge_base) < 0)
> +		    if (keep_base)
> +			die(_("'%s': need exactly one merge base with branch"),
> +				options.upstream_name);
> +		    else
>  			die(_("'%s': need exactly one merge base"),
>  			    options.onto_name);
>  		options.onto = lookup_commit_or_die(&merge_base,
> -- 
> 2.21.0.512.g57bf1b23e1
> 
