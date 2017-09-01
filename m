Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0982A1F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 17:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbdIAR2s (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 13:28:48 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:37353 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752119AbdIAR2s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 13:28:48 -0400
Received: by mail-pg0-f49.google.com with SMTP id 83so2271217pgb.4
        for <git@vger.kernel.org>; Fri, 01 Sep 2017 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W4SWab7xUKNm7FzJq64gRRnAwH8M5wuxOAegHHQ9Tc8=;
        b=tZ2Um3cx8HpAXwn8Wum09VTQsrU6LJlJL0z9FS7zW1xKfDsWGF1Jb06GOMHBey5lPE
         cmq221izqvyl9hAcf8NDyylhkYG8pZ0vnLBI3r/Xxb5hWHNraP0PvGG1VJXaeqG38wd8
         c9ZpChz1JnS3SxqEMSWv17G4JAfP6OmiHGdRHVQZNKrwrgRQA4PzOx91kawSd1SBDWLc
         6JJLo0depiPSt0239YDvB7maFvwWAWe27Rdr2Ls1Nl5gM+IuB+KucsCwYnbMgg9hG99/
         ul2Wv5L+ENFHirPGn41EmVctbpeB1W5BtW2G86nzaCYeo3PgopgTOTHEEPoO78zdj1rm
         c1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W4SWab7xUKNm7FzJq64gRRnAwH8M5wuxOAegHHQ9Tc8=;
        b=GqvgsXRy060gLAI4R5kh29eV/DLikr8PGO+OwWyd1hYz6UQuTyPnjXT0nabVyTj+yW
         QRHXk7Iyh7kaFwLeaFBwCwY4BtYRWZUFCrIsaKTJbLNwY8+9aPDyRjvpI7cd0QGzKt58
         rm/F7fVPpUkVBArwiXMTcFmUY10PG80OAOM9Sb0WRfC2ys0rz2mkiNdlKOqmkLdF4cdJ
         iP5i327TUgfNEZq4/LMBDC2QY90ngAIq+4UTQmHsMjIoY6KNze/9R5hdqvBCnTuT0GdR
         9G78p1Jgrq9oZT2oQCNw9Xjndd+06GgSz/DdfbBT5+Xgxupi1PGJ7CVFWKvwCTNThuT2
         Q/Jg==
X-Gm-Message-State: AHPjjUi1nuvMkSp+yGZ7wsaIGak2WnlPq1AyydwWqR7lz2nZBgfl6i6D
        G+VS8eQkzBkqHFcoZJc=
X-Google-Smtp-Source: ADKCNb72ls0IvMCniERwFPexA4p3CBr/wCccxGdirvBuOL2NbZHKmLvVFxcTST/LCpHuAJEnAr/wug==
X-Received: by 10.98.5.69 with SMTP id 66mr3119808pff.89.1504286927561;
        Fri, 01 Sep 2017 10:28:47 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c8a:d1f4:a5bc:2c5f])
        by smtp.gmail.com with ESMTPSA id k88sm908333pfb.150.2017.09.01.10.28.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 01 Sep 2017 10:28:46 -0700 (PDT)
Date:   Fri, 1 Sep 2017 10:28:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     git@vger.kernel.org, magnus@homann.se
Subject: Re: [PATCH] pull: honor submodule.recurse config option
Message-ID: <20170901172815.GA143138@aiede.mtv.corp.google.com>
References: <eba8e727-25ef-b34b-cd2b-e92602709c9b@homann.se>
 <cc70ea38-9980-120f-afaa-af7a6e3a8c36@morey-chaisemartin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc70ea38-9980-120f-afaa-af7a6e3a8c36@morey-chaisemartin.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Nicolas Morey-Chaisemartin wrote:

> git pull used to not parse the submodule.recurse config option and simply
> consider the --recurse-submodules CLI option.
> When using the config option, submodules would only be fetched recursively
> while the CLi option would tigger both fetch and update/merge.
>
> Reported-by: Magnus Homann <magnus@homann.se>
> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>

nits:

* Git's commit messages usually use the present tense to describe the
  behavior of Git in absence of a patch, as though writing a bug report.
  They use the imperative mood to describe what the patch will do, as
  though commanding the code to do better.
* spelling: s/CLi/CLI/; s/tigger/trigger/
* please also wrap lines consistently

That would make

	"git pull" supports a --recurse-submodules option but does not parse the
	submodule.recurse configuration item to set the default for that option.
	Meanwhile "git fetch" does support submodule.recurse, producing
	confusing behavior: when submodule.recurse is enabled, "git pull"
	recursively fetches submodules but does not update them after fetch.

	Handle submodule.recurse in "git pull" to fix this.

> ---
>  builtin/pull.c | 5 +++++
>  1 file changed, 5 insertions(+)

Can you add a test to avoid future changes causing this to regress?
See t/t5572-pull-submodule.sh for some existing tests to get
inspiration from.

> diff --git a/builtin/pull.c b/builtin/pull.c
> index 7fe281414..e4edf23c5 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -326,6 +326,11 @@ static int git_pull_config(const char *var, const char *value, void *cb)
>  		config_autostash = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "submodule.recurse")) {
> +		int r = git_config_bool(var, value) ?
> +			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
> +		recurse_submodules = r;
> +	}
>  	return git_default_config(var, value, cb);
>  }
>  

The rest looks good.

Thanks for working on this,
Jonathan
