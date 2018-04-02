Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABCDE1F424
	for <e@80x24.org>; Mon,  2 Apr 2018 06:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754144AbeDBGhd (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 02:37:33 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37484 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbeDBGhc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 02:37:32 -0400
Received: by mail-wm0-f46.google.com with SMTP id r131so25076724wmb.2
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 23:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=V0uRW2OKWsLi7JrsWreA+A4qHP4iXE3Ja6av6kMsGTY=;
        b=TG7mwEegnIdwCHcoAIyaNHkqFcYEv80wCaLsRIBpMSatZ2IOmbXDfmAlXpPujaBdQz
         BxC4kmv/11OxAC1KzhQl4hB1Ypjd66hMHh3HpCwRYI9KnIqvkL6tAWL+IqNAoKdiAXqT
         UJEjl2LsTgzKMQTfNFNHk/mJvF+I/2DshksWMmMNNuxu3OoAMwcEzP6dJ+P9Rw9MmsgL
         28PjJtfFZUoYEdlQzGW7hEIYWBitqfAywvMV9amZfdFBTzwwaPYl71dLDuQdns54wV2E
         X8eM3fWeffVQ3EDtpWHEa0LFXv9XXVWf2nFa9H3D2I8Z/lHoLKN+pUVVg1hBJg2CYtQT
         vc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=V0uRW2OKWsLi7JrsWreA+A4qHP4iXE3Ja6av6kMsGTY=;
        b=fliG+4zSyiOmOvW/mgmj6ReIrJM/uYhBaRf+TWba+Ev6jVRM20qbHEvkbxN7VSgpbf
         NagtS/ucpzZUU948i8LSmKcWCHsAX+JKmSqZbmFEfH9xhRULWW6T83xss0/RR3z1pKpT
         di3bL837NJ7B2ihMZTvWgZbuCXxp46zAJ70prwLbn8PWMAWI3HhuoH8KxIEgg52uhI/9
         sT2FVz9Y0mMHexWxU14fTQ0tYFleFPyC46dpaCErkr55Gf2NxHRnI6Cm06dWd8V/qddO
         fUavEpgAYKQDZspe1BYJ42A299GQBUtvwrBAnHzNula0eMW3iHFy5uT4ufeJOYhv/GG2
         juSg==
X-Gm-Message-State: AElRT7HqdFk6zv6oU7b5tmbCCFwleuDLyNnnUZZeWAimLR8U319+TXQP
        wCxvYs/mzz/zSal2yo+erHlZVUMa
X-Google-Smtp-Source: AIpwx4/YfYp8o5JDBtHJtfOREE+gfQCRmW3nU7ySsRPgmcdpp1MABMqeHwC2jfJDLFH/aoo8jOlj/A==
X-Received: by 10.80.181.12 with SMTP id y12mr11573635edd.166.1522651051356;
        Sun, 01 Apr 2018 23:37:31 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id e18sm8392118edj.38.2018.04.01.23.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Apr 2018 23:37:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ls-remote: create option to sort by versions
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180402005248.52418-1-haraldnordgren@gmail.com>
Date:   Mon, 02 Apr 2018 08:37:29 +0200
Message-ID: <87605aw1ue.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 02 2018, Harald Nordgren wrote:

> Create the options '-V ' and '--version-sort' to sort
> 'git ls-remote' output by version semantics. This is useful e.g. for
> the Go repository after the release of version 1.10, where otherwise
> v1.10 is sorted before v1.2. See:
>
> 	$ git ls-remote -t https://go.googlesource.com/go
> 	...
> 	205f850ceacfc39d1e9d76a9569416284594ce8c	refs/tags/go1.1
> 	d260448f6b6ac10efe4ae7f6dfe944e72bc2a676	refs/tags/go1.1.1
> 	1d6d8fca241bb611af51e265c1b5a2e9ae904702	refs/tags/go1.1.2
> 	bf86aec25972f3a100c3aa58a6abcbcc35bdea49	refs/tags/go1.10
> 	ac7c0ee26dda18076d5f6c151d8f920b43340ae3	refs/tags/go1.10.1
> 	9ce6b5c2ed5d3d5251b9a6a0c548d5fb2c8567e8	refs/tags/go1.10beta1
> 	594668a5a96267a46282ce3007a584ec07adf705	refs/tags/go1.10beta2
> 	5348aed83e39bd1d450d92d7f627e994c2db6ebf	refs/tags/go1.10rc1
> 	20e228f2fdb44350c858de941dff4aea9f3127b8	refs/tags/go1.10rc2
> 	1c5438aae896edcd1e9f9618f4776517f08053b3	refs/tags/go1.1rc2
> 	46a6097aa7943a490e9bd2e04274845d0e5e200f	refs/tags/go1.1rc3
> 	402d3590b54e4a0df9fb51ed14b2999e85ce0b76	refs/tags/go1.2
> 	9c9802fad57c1bcb72ea98c5c55ea2652efc5772	refs/tags/go1.2.1
> 	...

This is a sensible thing to want, but why not follow the UI we have for
this with git-tag? I.e. --sort=<key> & -i (or --ignore-case)? Of course
ls-remote doesn't just show tags, so maybe we'd want --tag-sort=<key>
and --ignore-tag-case or something, but the rest should be equivalent,
no?

> [...]
> @@ -101,13 +115,22 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  	if (transport_disconnect(transport))
>  		return 1;
>
> -	if (!dest && !quiet)
> -		fprintf(stderr, "From %s\n", *remote->url);
>  	for ( ; ref; ref = ref->next) {
>  		if (!check_ref_type(ref, flags))
>  			continue;
>  		if (!tail_match(pattern, ref->name))
>  			continue;
> +		REALLOC_ARRAY(refs, nr + 1);
> +		refs[nr++] = ref;
> +	}
> +
> +	if (version_sort)
> +		QSORT(refs, nr, cmp_ref_versions);
> +
> +	if (!dest && !quiet)
> +		fprintf(stderr, "From %s\n", *remote->url);

Is there some subtlety here I'm missing which means that when sorting
we'd now need to print this "From" line later (i.e. after sorting?
