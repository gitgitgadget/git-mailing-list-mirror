Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E0C21F404
	for <e@80x24.org>; Fri, 24 Aug 2018 14:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeHXSHh (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 14:07:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43014 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeHXSHh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 14:07:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so7657902wre.10
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=fiiQfQ1QlWH6e5rTbI/P7TihR5aBo1bG6Ogyl0XcMwI=;
        b=fmlgr7G1g/eXxSo0Bz1s3h24uAHJ/gabJnekflrnNAYcO8EH9K9rur7eUYHePlR9sz
         GHKyZnPOOaBUgIOREkoGPChGSvy4T6C20jy1sSvttzCJ493lMYRCaUBFILZ5KdAm5qvT
         2Z/yJGpgeRq0uBERgh54f1zTDdYScgE4y1W+YZyLq5HIPPMJx7tbJM/hU2y7/5DQUSVk
         xB22GlC/5g0ySAB2ZHcYTCZ5r7nZPr5lO5ngH+wdTi4BMaSa/CURcCrNV3jIVrk/EmUt
         Y7cwErl5ASgbYrcrjtgsY7nLCWR8KFfs8S09mJZTa0HqOkQ04Xd4pVF4yAvFciVt/8FG
         YW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=fiiQfQ1QlWH6e5rTbI/P7TihR5aBo1bG6Ogyl0XcMwI=;
        b=Swx/ZzxlxK6vxpItyGg+ouGvJWulLmyZv7RwoufLIwUnFMmwKqadCgaRfWvXWw5J1X
         HEhFUKwb2LLkRBamulBSLSLJ02WAeb4Ma6/9PKzuemwe4ASno5hDOrmYgyFhwq3j15lO
         9yv1ep6aRR2wfCP9K7OP9Jo2u6OD0ae8Ph0T/wPC5WulmnjqCWxW5knh7LST6ZZcsVqq
         P1cPIMtExszTgh7xUlhperjHqJRSO/vAm6gIkpu/gy0XgFPK4ykPEzBNVejcFcYLfuAJ
         F2Pg8YSpkG1tiq7LRbOs0RGnzRHtMapSh1utpQ5vFPikTbUAVJLpQhDKKxygYzlg2tVE
         JBmQ==
X-Gm-Message-State: APzg51A6sWs19dgIAzSxlCEB8CQYUj/o25ykBaL2o2lY+5prgj1sjc4l
        40L9dqbAnvwtEXCXcvuC6ol2cVW2eGw=
X-Google-Smtp-Source: ANB0VdZn9vLOB7Npb0unA4CByv8eWGvFuMAVNBM4AzfHDs8kB578OCDckS509gUrnZjc1fgUCg4TbQ==
X-Received: by 2002:a5d:55ca:: with SMTP id i10-v6mr1370667wrw.38.1535121160699;
        Fri, 24 Aug 2018 07:32:40 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id r140-v6sm2170520wmd.7.2018.08.24.07.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 07:32:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 1/9] submodule: add a print_config_from_gitmodules() helper
References: <20180824132951.8000-1-ao2@ao2.it> <20180824132951.8000-2-ao2@ao2.it>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180824132951.8000-2-ao2@ao2.it>
Date:   Fri, 24 Aug 2018 16:32:38 +0200
Message-ID: <87wosfesxl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 24 2018, Antonio Ospite wrote:

> Add a new print_config_from_gitmodules() helper function to print values
> from .gitmodules just like "git config -f .gitmodules" would.
>
> This will be used by a new submodule--helper subcommand to be able to
> access the .gitmodules file in a more controlled way.
>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>  submodule-config.c | 25 +++++++++++++++++++++++++
>  submodule-config.h |  2 ++
>  2 files changed, 27 insertions(+)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index fc2c41b947..eef96c4198 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -682,6 +682,31 @@ void submodule_free(struct repository *r)
>  		submodule_cache_clear(r->submodule_cache);
>  }
>
> +static int config_print_callback(const char *key_, const char *value_, void *cb_data)
> +{
> +	char *key = cb_data;
> +
> +	if (!strcmp(key, key_))
> +		printf("%s\n", value_);
> +
> +	return 0;
> +}

No problem with the code itself, but I'd find this a lot easier to read
in context if it was:

    key_ -> var
    value_ -> value
    key -> wanted_key, perhaps?

I.e. the rest of the file uses the convention of the
config_from_gitmodules callbacks getting "var" and "value",
respectively.

We don't use this convention of suffixing variables with "_" if they're
arguments to the function anywhere else.

> +int print_config_from_gitmodules(const char *key)
> +{
> +	int ret;
> +	char *store_key;
> +
> +	ret = git_config_parse_key(key, &store_key, NULL);
> +	if (ret < 0)
> +		return CONFIG_INVALID_KEY;

Isn't this a memory leak? I.e. we should free() and return here, no?

> +	config_from_gitmodules(config_print_callback, the_repository, store_key);
> +
> +	free(store_key);
> +	return 0;
> +}
> +
>  struct fetch_config {
>  	int *max_children;
>  	int *recurse_submodules;
> diff --git a/submodule-config.h b/submodule-config.h
> index dc7278eea4..ed40e9a478 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -56,6 +56,8 @@ void submodule_free(struct repository *r);
>   */
>  int check_submodule_name(const char *name);
>
> +int print_config_from_gitmodules(const char *key);
> +
>  /*
>   * Note: these helper functions exist solely to maintain backward
>   * compatibility with 'fetch' and 'update_clone' storing configuration in

Another style nit: Makes more sense to put this new function right
underneath "submodule_free" above, instead of under 1/2 of the functions
that have a big comment describing how they work, since that comment
doesn't apply to this new function.
