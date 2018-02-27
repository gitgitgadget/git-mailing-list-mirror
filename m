Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCF8C1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 06:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750981AbeB0GIp (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 01:08:45 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:41337 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbeB0GIo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 01:08:44 -0500
Received: by mail-io0-f196.google.com with SMTP id q24so12634871ioh.8
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 22:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UbZNWjVxnJTFRhzZEO+zd4i4yP18Df2d8xhbgNyq6rk=;
        b=Y3PphTCxkLeZSAKV0UNMNsHNtin/yR00SXOJdyL6Ph2i0uRhhcXCXJZchpWKbQ11/l
         kjqA+Tgy9QCSdkZhMy0s4oh2FpTvOfkJCKC89gcx8IvcTx5cG0g/gSPWl0oK9hOuYO7N
         GBKgVdaDWRLlSkSZM47m5CpvG6NLNaoQfEwu2K1fnO8dZox/i5U590un/LDA4EuUEfCl
         kdakRglf3uA3F3Q7J64vT0Zx73BxA1Dt0jw/AukWr75DWapwIw0oopXFKchSuqMg6ble
         rcXNdJ19157Ze5S8L7mD3G16tYDeHzlHEHyKLygLgjPpO2DOjsFHrrmlJQNJCQgo3nPh
         Y4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UbZNWjVxnJTFRhzZEO+zd4i4yP18Df2d8xhbgNyq6rk=;
        b=ojs5l6o3E8SAzqiEX440jPAiqrjTBrnRg559y/ea/iMUl0Ka/oczSvig9VbbGeZKzv
         4Pkfz4yxosYeTVappuFZGk30GL9Lwp8yKw2uXr3cF9FAPx8FzXmBR1oZfOgNqoZaDKZz
         +IAyP2exWOASQb4/R+Ms+7eALFCjW7Xe2D/n3UjCmyoHaSBlHNMxpDWjiKo5xG8dMFUf
         1IbeWUKFC9NFgPBNgNJAcp+qjufSWXD3Gis2ZXFNbGKX8qf2gn1BtzisjFKIMZzpqofQ
         +Z2RwdFwRbfBbD32YZFvM5PJl74HNcjiN++8A7mJaVaGHIgPxGO4i19rmxc/pykOgIa1
         nhnQ==
X-Gm-Message-State: APf1xPCrTF0HjI8To/kghSVzQXj6liKLR+doEXFwi4bITK9PNa2i86VS
        JQ8e3ONKKbq6nT0t/nlVxkI=
X-Google-Smtp-Source: AG47ELvpHCmGdunomCLCj2MI1dSJb/jy7nMMsW2R/m4YeWGwCqq4qnzroPd9Y6AON1TcZAKbUlXD+g==
X-Received: by 10.107.82.8 with SMTP id g8mr5260402iob.163.1519711723814;
        Mon, 26 Feb 2018 22:08:43 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l123sm56809itl.43.2018.02.26.22.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 22:08:43 -0800 (PST)
Date:   Mon, 26 Feb 2018 22:08:40 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 06/35] transport: use get_refs_via_connect to get refs
Message-ID: <20180227060840.GD65699@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-7-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207011312.189834-7-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Remove code duplication and use the existing 'get_refs_via_connect()'
> function to retrieve a remote's heads in 'fetch_refs_via_pack()' and
> 'git_transport_push()'.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  transport.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)

I like the diffstat.

[...]
> +++ b/transport.c
> @@ -230,12 +230,8 @@ static int fetch_refs_via_pack(struct transport *transport,
>  	args.cloning = transport->cloning;
>  	args.update_shallow = data->options.update_shallow;
>  
> -	if (!data->got_remote_heads) {
> -		connect_setup(transport, 0);
> -		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
> -				 NULL, &data->shallow);
> -		data->got_remote_heads = 1;
> -	}
> +	if (!data->got_remote_heads)
> +		refs_tmp = get_refs_via_connect(transport, 0);

The only difference between the old and new code is that the old code
passes NULL as 'extra_have' and the new code passes &data->extra_have.

That means this populates the data->extra_have oid_array.  Does it
matter?

> @@ -541,14 +537,8 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
>  	struct send_pack_args args;
>  	int ret;
>  
> -	if (!data->got_remote_heads) {
> -		struct ref *tmp_refs;
> -		connect_setup(transport, 1);
> -
> -		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL,
> -				 NULL, &data->shallow);
> -		data->got_remote_heads = 1;
> -	}
> +	if (!data->got_remote_heads)
> +		get_refs_via_connect(transport, 1);

not a new problem, just curious: Does this leak tmp_refs?

Same question as the other caller about whether we mind getting
extra_have populated.

Thanks,
Jonathan
