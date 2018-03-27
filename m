Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69E961F404
	for <e@80x24.org>; Tue, 27 Mar 2018 22:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeC0W5e (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 18:57:34 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46816 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbeC0W5d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 18:57:33 -0400
Received: by mail-pg0-f66.google.com with SMTP id t12so202491pgp.13
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 15:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oaeK0X6UDYHBvgeVLSDOtPWfFqwUipswLIHZJtqMFk0=;
        b=cMKLVVpcM5790km5F5GIEfmC8AF9B9YMA+ScPtXRpo3fAk8/Vy1WFUL3eGFD7sWCHa
         mxx1oLXWoAXjEFoXr1A3+sfAGOAneWP/oeEIpBWOQtkl7gRhYD1p5hLBROYiQVODP2Do
         AYAHmVdUy7GZUpFaYGpzGRqQeL34CwSyBtz0/GME3IcArNkjNFghV5D26WLk3TaLVwAR
         47VO1M+F99/JI5jjj7EpNB0f3IgSvDoQ2zYb7uJ6Qqwr3V/IbMtUOO4EOV07K6fMW43R
         KndFebetR0CuhY5aOQNEtNto/ELWMDsC2Pykr2FQwvITS+XykDjoPYtzwFmuhFJ44Wmn
         /57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oaeK0X6UDYHBvgeVLSDOtPWfFqwUipswLIHZJtqMFk0=;
        b=f9YnzbVJSFaxWqKXTF1dZOU4bF8GxdUo4Oi8CWEsxOvgQ4H/rm94GHzA7WWEpXpBlk
         2WPIOKxUiH/pYMAc7S+KndrNvpIcEcNx+W4REbmH8lPJCL3NVy/ebg9gRParUoh/+txF
         /C4xYPSPUJ+juUJsd8gh4Udgxy75jPQfb29YiJCaGCw9UoXDwI80OuOdey7iSLzAhqv2
         TkiYvDZnPBdWWIBsECXzziPmHAtzUHawaEpSqr7L6xVJ0YgIrYNzOAYDUuij4Dorrszl
         ZU2CmKOl8kqrdKQYbOP6rTV5ZBjbgObYslzi6JPgptqmWdTFRJd/qP3aqndNGUBY/yaU
         zsyw==
X-Gm-Message-State: AElRT7H2A1l+B/cpwMNGSaGAVsYk+1EPL+pGgJIq6DmrrOhdHAJCeer4
        I/Lpkdjzq46TP/Y98lZvV5T/nA==
X-Google-Smtp-Source: AIpwx49zYA/K5WoX6TZmD2DndPLo9yIirI3Cgu3BqWjIGeq+YcRSiAQxAl2ZJ5mJ597lr4kGv+pvwA==
X-Received: by 10.99.100.6 with SMTP id y6mr796941pgb.254.1522191452427;
        Tue, 27 Mar 2018 15:57:32 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p14sm4287425pgu.44.2018.03.27.15.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 15:57:31 -0700 (PDT)
Date:   Tue, 27 Mar 2018 15:57:30 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, seanwbehan@riseup.net, hvoigt@hvoigt.net
Subject: Re: [PATCH 2/5] submodule-config: allow submodule_free to handle
 arbitrary repositories
Message-ID: <20180327225730.GA215480@google.com>
References: <20180327213918.77851-1-sbeller@google.com>
 <20180327213918.77851-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327213918.77851-3-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/27, Stefan Beller wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>

Looks good.  At some point we may want to rename this function so that
it describes what it actually does as 'submodule_free' doesn't quite
describe that this clears a repository's submodule cache.  But that's
beyond the scope of this.

> ---
>  Documentation/technical/api-submodule-config.txt | 2 +-
>  builtin/grep.c                                   | 2 +-
>  submodule-config.c                               | 6 +++---
>  submodule-config.h                               | 2 +-
>  t/helper/test-submodule-config.c                 | 2 +-
>  unpack-trees.c                                   | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
> index ee907c4a82..fb06089393 100644
> --- a/Documentation/technical/api-submodule-config.txt
> +++ b/Documentation/technical/api-submodule-config.txt
> @@ -38,7 +38,7 @@ Data Structures
>  Functions
>  ---------
>  
> -`void submodule_free()`::
> +`void submodule_free(struct repository *r)`::
>  
>  	Use these to free the internally cached values.
>  
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 789a89133a..8f04cde18e 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -651,7 +651,7 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
>  
>  		/* load the gitmodules file for this rev */
>  		if (recurse_submodules) {
> -			submodule_free();
> +			submodule_free(repo);
>  			gitmodules_config_oid(&real_obj->oid);
>  		}
>  		if (grep_object(opt, pathspec, real_obj, list->objects[i].name, list->objects[i].path,
> diff --git a/submodule-config.c b/submodule-config.c
> index 602ba8ca8b..a3efff1a34 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -642,8 +642,8 @@ const struct submodule *submodule_from_cache(struct repository *repo,
>  			   key, lookup_path);
>  }
>  
> -void submodule_free(void)
> +void submodule_free(struct repository *r)
>  {
> -	if (the_repository->submodule_cache)
> -		submodule_cache_clear(the_repository->submodule_cache);
> +	if (r->submodule_cache)
> +		submodule_cache_clear(r->submodule_cache);
>  }
> diff --git a/submodule-config.h b/submodule-config.h
> index a5503a5d17..df6bd6e6db 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -46,6 +46,6 @@ extern const struct submodule *submodule_from_path(
>  extern const struct submodule *submodule_from_cache(struct repository *repo,
>  						    const struct object_id *treeish_name,
>  						    const char *key);
> -extern void submodule_free(void);
> +extern void submodule_free(struct repository *r);
>  
>  #endif /* SUBMODULE_CONFIG_H */
> diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
> index f23db3b19a..9971c5e9dd 100644
> --- a/t/helper/test-submodule-config.c
> +++ b/t/helper/test-submodule-config.c
> @@ -64,7 +64,7 @@ int cmd_main(int argc, const char **argv)
>  		arg += 2;
>  	}
>  
> -	submodule_free();
> +	submodule_free(the_repository);
>  
>  	return 0;
>  }
> diff --git a/unpack-trees.c b/unpack-trees.c
> index d5685891a5..05e5fa77eb 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -290,7 +290,7 @@ static void load_gitmodules_file(struct index_state *index,
>  		if (!state && ce->ce_flags & CE_WT_REMOVE) {
>  			repo_read_gitmodules(the_repository);
>  		} else if (state && (ce->ce_flags & CE_UPDATE)) {
> -			submodule_free();
> +			submodule_free(the_repository);
>  			checkout_entry(ce, state, NULL);
>  			repo_read_gitmodules(the_repository);
>  		}
> -- 
> 2.17.0.rc1.321.gba9d0f2565-goog
> 

-- 
Brandon Williams
