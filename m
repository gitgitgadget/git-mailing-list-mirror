Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A47A020357
	for <e@80x24.org>; Mon, 10 Jul 2017 23:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755028AbdGJXcv (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 19:32:51 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35698 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754952AbdGJXcu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 19:32:50 -0400
Received: by mail-pg0-f41.google.com with SMTP id j186so56822387pge.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 16:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gEQE/qdF1LvgwSjoffhPzg7HnR01tXiTLFQRve2EoPg=;
        b=qQgqBEX5ZykoJkX0BYragrbSONvvvkhZAVB1YIGrDrDGeqh1RJhB0keCNQo4SUJ3ds
         Q5VoybvpoSQkYYc6bGqiBa4NnmC8mg5+1XPpt1b6uUOnMCLqfMfBneeZOq/XcRqDkvCb
         Y754ELbviti6WhK227Si/hF4oRCG6oGzEkegc5Uu6Y3ZqiBAj/ZngAsQfgyyXGbLQwaw
         pS52/ghjsGSL/EjpeVfZ4xn831VLuvCr78wBgDETEy0mn8blgwvX94LNptI7mi6wSsMm
         hM4D3M8CKIJWNwyW0B35brv8pXeciz5F5gSGRSnazfYN8IXUOhJpL/d0Y7fmBfB0+DRs
         gd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gEQE/qdF1LvgwSjoffhPzg7HnR01tXiTLFQRve2EoPg=;
        b=Q7yMlL3WmSl8MgwX0q1xOM0BlTqqTWyhYd4Hvnd7AepjOdzY+BIm2dGj/utRllLFcf
         +euf/PqAjDBcIcXPIIg56qkD1QY4dTds8skSgzyE+etnAZVn7Hy6TR10qWusprIVsy0o
         XNIaPOO7bTj0bnCFaH/FwV5UdRhzCgpjbdgK4bdLgs1hEYp8mTfefPdHDSnhNYu/e9HD
         ZbTFU6c36n8Qi7zdiPdThthsL0EYXcBYXpQpg+FeUXPLvXOc2y3A5FaVpYtiQC1OkuZt
         eBpeNUPvIyo3xq+DmserGsNsNZYYQ56Vky7ba3xAN8c2HOVsw9M9ASmJZjo6anT7Gvsf
         fsDw==
X-Gm-Message-State: AIVw1115mo6SROu7SPj9/iOncGf85gGm81O5OWJ6ZkHs8/VrA227EPGO
        fDypBeHU9QdwIDb5
X-Received: by 10.99.156.18 with SMTP id f18mr17057707pge.25.1499729569646;
        Mon, 10 Jul 2017 16:32:49 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c8d3:611:f474:c770])
        by smtp.gmail.com with ESMTPSA id y14sm26165013pgr.1.2017.07.10.16.32.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 16:32:48 -0700 (PDT)
Date:   Mon, 10 Jul 2017 16:32:47 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com,
        christian.couder@gmail.com, gitster@pobox.com
Subject: Re: [GSoC][PATCH 1/8] submodule--helper: introduce
 get_submodule_displaypath()
Message-ID: <20170710233247.GC161700@google.com>
References: <CAME+mvU_8-S4AhTtMYm1L6PK81v23wu4EuB+EnOgkDhi=jo9Rg@mail.gmail.com>
 <20170710225407.29344-1-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170710225407.29344-1-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11, Prathamesh Chavan wrote:
> Introduce function get_submodule_displaypath() to replace the code
> occurring in submodule_init() for generating displaypath of the
> submodule with a call to it.
> 
> This new function will also be used in other parts of the system
> in later patches.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>  builtin/submodule--helper.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 6abdad329..7af4de09b 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -220,6 +220,27 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
>  	return 0;
>  }
>  
> +static char *get_submodule_displaypath(const char *path, const char *prefix)
> +{
> +	const char *super_prefix = get_super_prefix();
> +
> +	if (prefix && super_prefix) {
> +		BUG("cannot have prefix '%s' and superprefix '%s'",
> +		    prefix, super_prefix);
> +	} else if (prefix) {
> +		struct strbuf sb = STRBUF_INIT;
> +		char *displaypath = xstrdup(relative_path(path, prefix, &sb));
> +		strbuf_release(&sb);
> +		return displaypath;
> +	} else if (super_prefix) {
> +		int len = strlen(super_prefix);
> +		const char *format = is_dir_sep(super_prefix[len - 1]) ? "%s%s" : "%s/%s";
> +		return xstrfmt(format, super_prefix, path);
> +	} else {
> +		return xstrdup(path);
> +	}
> +}
> +
>  struct module_list {
>  	const struct cache_entry **entries;
>  	int alloc, nr;
> @@ -339,16 +360,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  
>  	/* Only loads from .gitmodules, no overlay with .git/config */
>  	gitmodules_config();
> -
> -	if (prefix && get_super_prefix())
> -		die("BUG: cannot have prefix and superprefix");
> -	else if (prefix)
> -		displaypath = xstrdup(relative_path(path, prefix, &sb));
> -	else if (get_super_prefix()) {
> -		strbuf_addf(&sb, "%s%s", get_super_prefix(), path);
> -		displaypath = strbuf_detach(&sb, NULL);
> -	} else
> -		displaypath = xstrdup(path);
> +	displaypath = get_submodule_displaypath(path, prefix);
>  
>  	sub = submodule_from_path(null_sha1, path);
>  
> @@ -363,7 +375,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  	 * Set active flag for the submodule being initialized
>  	 */
>  	if (!is_submodule_active(the_repository, path)) {
> -		strbuf_reset(&sb);

Is this line removal intended?  It doesn't look related to the rest of
this patch.

>  		strbuf_addf(&sb, "submodule.%s.active", sub->name);
>  		git_config_set_gently(sb.buf, "true");
>  	}
> -- 
> 2.13.0
> 

-- 
Brandon Williams
