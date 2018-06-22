Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CBCE1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 16:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754512AbeFVQuF (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 12:50:05 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44063 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeFVQuD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 12:50:03 -0400
Received: by mail-pf0-f195.google.com with SMTP id h12-v6so3476493pfk.11
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DEDanf5NZYZ31UXe6uQKJnFMdr/pD1XHcdaDKm71+34=;
        b=v4kk//W/MPaOE6LLLYXnX0sXY3pXMKtobveMaATm7H/qTcCs1HdMiY72s2GnvSQoGt
         xZv2Wrp8WmZjdYEFi8XLz+tZTRNqvAzo6LdNN+II9n8w9XnEJ3Vo0f1gdoJXneclZYiQ
         jdku10xivExgoFlK/OUzPPp+MPyiIBtHWFT1wRsU9ayQ8PJu2N3rjBFM/348xbfnNNSE
         f0II3TCBhyG6fk2vWdm8PhgOUyI76iffQD8dcWo8HQLRRk7AMUFJWKm+RvpU80fy0eWj
         kQg10q/vhDRE0KH4mY/wUWh77rA1Bu48tV0bEH47Ea+UZ7XkB4+CXrLlwYLKrRxw74pj
         qFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DEDanf5NZYZ31UXe6uQKJnFMdr/pD1XHcdaDKm71+34=;
        b=NMGQgV/6GVeoRh+JaE9ozLMFFqWjeXXPKkb5/LmZy4Lr1MwPdJCJniDeclp0tVI1MO
         nKOulgEAMi9XpzaMZ4kTbNF5QFZAqTK43KQTlraNrxQp/l8iz4ksLQf76rQivTNsDsFM
         SKJhfyhWFMB5lJNVAfSvpj2lPfu3chbUKuU1I9Nm/L6cLv1v85mj3BsFCQIIuBkg08AZ
         EObPZGe5Q6nAK3zZMJYuDngdxdh/+7GJOLpdPHFp0d5rRyODJmGdY6MaLCiHWmKGAF5C
         2mdsiPiABbTIkmSDbj6dr9Ed5TBwl3gMeDKBrcl4JpHdecbyQJlAdFJeWJlRPLtWkQf/
         Odww==
X-Gm-Message-State: APt69E2igd/CSyNL6ygev1ZHTXtp01ftLCxl9m66DUspBw5mGgK7aktk
        /4oHw4602N8CeFF9esKVKsM6jA==
X-Google-Smtp-Source: ADUXVKJfAIY/LKqyCJwhxfBAlLqX+7bxKXRz/lx0nvxXEtW9mu0Ky1+Maac0udog/7nH1NPIAEmrhQ==
X-Received: by 2002:a63:83c3:: with SMTP id h186-v6mr2070243pge.298.1529686202422;
        Fri, 22 Jun 2018 09:50:02 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id e81-v6sm18833712pfb.62.2018.06.22.09.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 09:50:01 -0700 (PDT)
Date:   Fri, 22 Jun 2018 09:50:00 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/7] submodule-config: add helper function to get 'fetch'
 config from .gitmodules
Message-ID: <20180622165000.GA244185@google.com>
References: <20180622162656.19338-1-ao2@ao2.it>
 <20180622162656.19338-3-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622162656.19338-3-ao2@ao2.it>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/22, Antonio Ospite wrote:
> diff --git a/submodule-config.c b/submodule-config.c
> index b431555db..ef292eb7c 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -688,3 +688,31 @@ void config_from_gitmodules(config_fn_t fn, void *data)
>  		free(file);
>  	}
>  }
> +
> +struct fetch_config {
> +	int *max_children;
> +	int *recurse_submodules;
> +};
> +
> +static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
> +{
> +	struct fetch_config *config = cb;
> +	if (!strcmp(var, "submodule.fetchjobs")) {
> +		*(config->max_children) = parse_submodule_fetchjobs(var, value);
> +		return 0;
> +	} else if (!strcmp(var, "fetch.recursesubmodules")) {
> +		*(config ->recurse_submodules) = parse_fetch_recurse_submodules_arg(var, value);

There shouldn't be a space before "->" in this line.

-- 
Brandon Williams
