Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE3AB1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 23:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeIFDp0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 23:45:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38573 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeIFDp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 23:45:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id t84-v6so2325680pgb.5
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 16:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7pFszwlrqqvYnTniKm6kIJ0k1UTa99MXr0vWhS6M3Qc=;
        b=jk0TBVnvQ+QIFTLNr8x4hRU8OKQb2R4ebGAXbql61NmMjkPYYyy/nQD79j0/rOiF66
         3V2GN2SrPzf/7YvSPZRRos0RhN6zt2q3at0CkFAiftiA5kUJh1jQo56zYNpeeGY+UdnH
         X+5u5m+YwIQ5ERuY6hNmtOR4tjgyG7rBVRdobmCXzCVOliUnwy4uOYNFerPSm5xujpTr
         HcZZWLPrMyYvEhUJgQBUmzOwJkHgtF687ff183chCtm7Gur/BWaM8wWZhL2Tttf+CVwH
         qAL3a8PM7KDZ+JAoBICkv/VeBgxyCiK/BByGu7y+OAoLte08a/CvxOUH7I6QSHq+nl7Y
         AO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7pFszwlrqqvYnTniKm6kIJ0k1UTa99MXr0vWhS6M3Qc=;
        b=nvOUETedc362nJzxTsQvA775YPeCsBSu5+dojdRDdwoXt1X6aRYC2q1QkGB2RLVEOZ
         wM2Z7BxT67Pruq1ElYT0xQsgXTwH6hJ/GRQz26eJipuX8Iji6urHDyokINjhNvy/RNKf
         76T78UlGuobgRSunc/kJOa6l8TyFBBe2nqL4FKuQD+rjQBMZ/jWVJpUQ6JTCWUi8ggZC
         Flr/l1R+P7SKehzN/3eeJg2zv1nr/u/oslbzwcIsQBzVdYsAnpJtmj83i0VDvR0IQDoz
         Eb4FMQbAVtcYf6R9imi5RSglf+8yrohrmHbsToRl1/+289XMX1nTLkK2dqR+ZSwZOHPE
         Cu5g==
X-Gm-Message-State: APzg51DZPnOBnxs1xohzB2AB9r4dDuk6ESWBESCjPN2VEiBhSoukUliD
        e2TS8S4OhE1gtMjePIQpFXr7TO+a
X-Google-Smtp-Source: ANB0VdZY+jgUoFcO40iTKc9zH068WEVmGl+FXWW7TfG0lYQIosqeP1WIjXyqghrai3Hl14odyKwBPA==
X-Received: by 2002:a63:1021:: with SMTP id f33-v6mr33254pgl.72.1536189180729;
        Wed, 05 Sep 2018 16:13:00 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z22-v6sm5280492pgc.67.2018.09.05.16.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 16:12:59 -0700 (PDT)
Date:   Wed, 5 Sep 2018 16:12:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: allow --recurse-submodules as an synonym for
 --submodule
Message-ID: <20180905231258.GD120842@aiede.svl.corp.google.com>
References: <20180905225828.17782-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905225828.17782-1-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Many commands have flags to recurse into submodules, which is named
> --recurse-submodules. The diff family also has a submodule recursion flag,
> but that is named differently. Add a synonym --recurse-submodules, which
> means the same as the --submodule flag, such that across all git commands
> supporting submodules we have the --recurse-submodules flag available.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/diff-options.txt | 1 +
>  diff.c                         | 2 ++
>  2 files changed, 3 insertions(+)

Makes sense.

[...]
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -227,6 +227,7 @@ linkgit:git-config[1]).
>  	of the `--diff-filter` option on what the status letters mean.
>  
>  --submodule[=<format>]::
> +--recurse-submodules[=<format>]::
>  	Specify how differences in submodules are shown.  When specifying
>  	`--submodule=short` the 'short' format is used.  This format just
>  	shows the names of the commits at the beginning and end of the range.
> diff --git a/diff.c b/diff.c
> index 145cfbae592..d3d5a989bd1 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5023,6 +5023,8 @@ int diff_opt_parse(struct diff_options *options,
>  		handle_ignore_submodules_arg(options, arg);
>  	} else if (skip_to_optional_arg_default(arg, "--submodule", &arg, "log"))
>  		return parse_submodule_opt(options, arg);
> +	else if (skip_to_optional_arg_default(arg, "--recurse-submodules", &arg, "log"))
> +		return parse_submodule_opt(options, arg);

It seems like various commands are gaining --recurse-submodules options
taking different kinds of arguments:

- clone takes --recurse-submodules=<pathspec>
- fetch takes --recurse-submodules=<mode>
- after this patch, diff takes --recurse-submodules=<mode>

Is there a unifying principle?  Can Documentation/gitsubmodules.txt
say a word or two about what kind of argument values the user should
expect to be accepted by these options?

Thanks,
Jonathan
