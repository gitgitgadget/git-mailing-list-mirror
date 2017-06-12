Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E28720C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 19:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbdFLT5P (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 15:57:15 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33069 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752076AbdFLT5O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 15:57:14 -0400
Received: by mail-pf0-f177.google.com with SMTP id 83so55798983pfr.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 12:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jKn468k1Jn0Vz40wp3LV6YW26VSYtlm+yo/MITatgq0=;
        b=pZHW9ZlAS9GlVfwJHgLd39YeY1xEStY5uiijPf43D8hIRHGNhV6UF9YS9hNMYYAuST
         /leCN1vwznsuvX05tJ+22l3za5nij/Y3a3iB8+BitE8TEmvxAQbiMHSAlyQrLtaWTsl/
         7j8AsPybHeS9oJiswbyUD794bjI35hNXr3IqEXdK8kpedGA1DKxgsSgTAb45jdD9PKK5
         6zv3A6oKxDnjYA2Jkkyk7a37iyovoT2Fb/Qk5Iy7mJu5n7jTxFr/qI3zJ8wkMrtALrVv
         pVWzyQZABgRXmwWol3aR7BV5mM6dqCE2DN0fObW3WIfBDwLhnmvJeD3mCttvXTWPapea
         mf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jKn468k1Jn0Vz40wp3LV6YW26VSYtlm+yo/MITatgq0=;
        b=b4DSGtYM7CrnC5C9mvckunf0ZYu2ydXxODOEb7cfh5bJBo+adJRIgeCaFnaiIawp83
         5ki9efzRb8f6SZNBZjJTFxqdhjLES0By5eLRQw3RBqB3jUgot5Nq0roRpb/Yc1vMKs5E
         n4ND6CK3BOPZqt/izucek9d28kaALNYCE4SQsYxdOALul7DR9Iiem7XPVs3dNErH3AKV
         KPcIA9LBF0X+iPCHGU6gTbuCmggcK2pF4ZzYupscxr4aFXYvidVrtvbLa2jI5SMMtDqY
         Q+WkE1zAhh/E/M35c+6QM/OGB/ByNi3djieSCagp5L6WBxGaGA3NjaJ4quiRghkKZNBl
         C+qA==
X-Gm-Message-State: AODbwcAbC6KGTRI8S/GlVGcKDSKbJkjQ0zBptmcWyJOc25cq3NkxqC7e
        MtZTFHrmNR5Lol7xmFeSiQ==
X-Received: by 10.84.164.193 with SMTP id l1mr49769508plg.243.1497297432845;
        Mon, 12 Jun 2017 12:57:12 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:9d75:7c5f:d212:fb28])
        by smtp.gmail.com with ESMTPSA id y66sm19760585pfa.54.2017.06.12.12.57.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 12:57:11 -0700 (PDT)
Date:   Mon, 12 Jun 2017 12:57:10 -0700
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 04/32] config: don't implicitly use gitdir
Message-ID: <20170612195710.GC154599@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
 <20170608234100.188529-5-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608234100.188529-5-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/08, Brandon Williams wrote:
> Commit 2185fde56 (config: handle conditional include when $GIT_DIR is
> not set up) added a 'git_dir' field to the config_options struct.  Let's
> use this option field explicitly all the time instead of occasionally
> falling back to calling 'git_pathdup("config")' to get the path to the
> local repository configuration.  This allows 'do_git_config_sequence()'
> to not implicitly rely on global repository state.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/config.c | 2 ++
>  config.c         | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/config.c b/builtin/config.c
> index 753c40a5c..90f49a6ee 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -539,6 +539,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		config_options.respect_includes = !given_config_source.file;
>  	else
>  		config_options.respect_includes = respect_includes_opt;
> +	if (have_git_dir())
> +		config_options.git_dir = get_git_common_dir();
>  
>  	if (end_null) {
>  		term = '\0';
> diff --git a/config.c b/config.c
> index 2390f98e3..ff09b27b8 100644
> --- a/config.c
> +++ b/config.c
> @@ -1548,8 +1548,6 @@ static int do_git_config_sequence(const struct config_options *opts,
>  
>  	if (opts->git_dir)
>  		repo_config = mkpathdup("%s/config", opts->git_dir);
> -	else if (have_git_dir())
> -		repo_config = git_pathdup("config");
>  	else
>  		repo_config = NULL;
>  
> @@ -1613,6 +1611,8 @@ static void git_config_raw(config_fn_t fn, void *data)
>  	struct config_options opts = {0};
>  
>  	opts.respect_includes = 1;
> +	if (have_git_dir())
> +		opts.git_dir = get_git_common_dir();
>  	if (git_config_with_options(fn, data, NULL, &opts) < 0)
>  		/*
>  		 * git_config_with_options() normally returns only

I missed a case in 'include_by_gitdir'.

Given that these config changes touch a lot of files (making a config.h
files and including it everyone) I think I'll break this into its own
series so that it can get reviewed and merged in faster.  This is
especially due to this series breaking pu right now.


-- 
Brandon Williams
