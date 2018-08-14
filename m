Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97DF1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 17:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733256AbeHNT7C (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 15:59:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40735 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733145AbeHNT7C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 15:59:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so9379205pgp.7
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2buR78/UgwHY5d//TawbvCHxW1ih4SHLXa84bpBmHzI=;
        b=uEOTsAfuNwB98KMKUYBNGSeLiHvXQbDf9fjnqaDk7UOmRjpa69dazlw2DwzwOxiqUf
         QH9N/6W3+eg6RrmkqQIOCCcw8TQ8dCbizgw+2CGqsRj1iaid2G80eoIRY1EXoNq2TBUm
         BuHvQiBUNK8Xu5mP2kWuw/5mLxeuOw/yOrqM6Zl7t2q6rPLvVN6fUh9+WgxlsT5TMR7S
         XKFSBKdkij4cnVrBoQgy+pDnbRaAboctTI+HY0SeyjU4qJhTtUOtNDopIlnnmoVHd7CZ
         lsSAbInJkEhm79DSjwq0ALsnHh797p6MHIHMxOmsYlA7cHOZxvsRZzRIgNB4nOgW3uLe
         fpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2buR78/UgwHY5d//TawbvCHxW1ih4SHLXa84bpBmHzI=;
        b=Hyz8v6lXH9e6nFIfCUot/87CmuvStd3Chs1aVVMAQuTHazN3zhs08Lt4ysvELOM9rs
         hXV39PXfWiR29+ZCLbMNc2wiJ5MYO+aALUzS9Dgvg8DfKP0YRXvj7a1uag8ogS1zqxDJ
         JHFRnCvyUjAVjV7E/GYgX0vXjeVROSHFkbKVr7/kJ/QGiOIgYQIhtCQR5ujYteheDA41
         jiKozCFvY9kbwTqB/qZxJkrQSNcKtARo4sOR5nhd7NMMQcxE89cTpCplV8pCnmANXJnu
         1RtpIOTJ2H6e9OEMKp01apGwA3btSeeUko/jk4RGd9rZi/Nzm6kuz06UFQgCic+PlU9t
         qXtA==
X-Gm-Message-State: AOUpUlFT7coOLFl5LmIMYUhGmqjp3DQgMZ0IJ9gC11f7A+tAf2gcEoeW
        7t5/Ol5FzkjRQxcFW0kYR2wI4A==
X-Google-Smtp-Source: AA+uWPzOTEEOojMw+l/bkqe5NvhcaaV1o623k6tOsRgZ4t3GYLOKl9U9eoo09/D+Z6d5mFkouVGM8w==
X-Received: by 2002:a63:da04:: with SMTP id c4-v6mr21019300pgh.398.1534266660241;
        Tue, 14 Aug 2018 10:11:00 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id h69-v6sm49379915pfh.13.2018.08.14.10.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 10:10:58 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:10:58 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org,
        Daniel =?iso-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 4/7] submodule--helper: add a new 'config' subcommand
Message-ID: <20180814171058.GF240194@google.com>
References: <20180814110525.17801-1-ao2@ao2.it>
 <20180814110525.17801-5-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814110525.17801-5-ao2@ao2.it>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/14, Antonio Ospite wrote:
> Add a new 'config' subcommand to 'submodule--helper', this extra level
> of indirection makes it possible to add some flexibility to how the
> submodules configuration is handled.
> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>  builtin/submodule--helper.c | 14 ++++++++++++++

>  new                         |  0

Looks like you may have accidentally left in an empty file "new" it should
probably be removed from this commit before it gets merged.

Aside from that this patch looks good.  I've recently run into issues
where we don't have a good enough abstraction layer around how we
interact with submodules so I'm glad we're moving towards better
abstractions :)

>  t/t7411-submodule-config.sh | 26 ++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
>  create mode 100644 new
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a3c4564c6c..7481d03b63 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2029,6 +2029,19 @@ static int connect_gitdir_workingtree(int argc, const char **argv, const char *p
>  	return 0;
>  }
>  
> +static int module_config(int argc, const char **argv, const char *prefix)
> +{
> +	/* Equivalent to ACTION_GET in builtin/config.c */
> +	if (argc == 2)
> +		return print_config_from_gitmodules(argv[1]);
> +
> +	/* Equivalent to ACTION_SET in builtin/config.c */
> +	if (argc == 3)
> +		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
> +
> +	die("submodule--helper config takes 1 or 2 arguments: name [value]");
> +}
> +
>  #define SUPPORT_SUPER_PREFIX (1<<0)
>  
>  struct cmd_struct {
> @@ -2057,6 +2070,7 @@ static struct cmd_struct commands[] = {
>  	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
>  	{"is-active", is_active, 0},
>  	{"check-name", check_name, 0},
> +	{"config", module_config, 0},
>  };
>  
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> diff --git a/new b/new
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
> index c6b6cf6fae..4afb6f152e 100755
> --- a/t/t7411-submodule-config.sh
> +++ b/t/t7411-submodule-config.sh
> @@ -142,4 +142,30 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
>  	)
>  '
>  
> +test_expect_success 'reading submodules config with "submodule--helper config"' '
> +	(cd super &&
> +		echo "../submodule" >expected &&
> +		git submodule--helper config submodule.submodule.url >actual &&
> +		test_cmp expected actual
> +	)
> +'
> +
> +test_expect_success 'writing submodules config with "submodule--helper config"' '
> +	(cd super &&
> +		echo "new_url" >expected &&
> +		git submodule--helper config submodule.submodule.url "new_url" &&
> +		git submodule--helper config submodule.submodule.url >actual &&
> +		test_cmp expected actual
> +	)
> +'
> +
> +test_expect_success 'overwriting unstaged submodules config with "submodule--helper config"' '
> +	(cd super &&
> +		echo "newer_url" >expected &&
> +		git submodule--helper config submodule.submodule.url "newer_url" &&
> +		git submodule--helper config submodule.submodule.url >actual &&
> +		test_cmp expected actual
> +	)
> +'
> +
>  test_done
> -- 
> 2.18.0
> 

-- 
Brandon Williams
