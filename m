Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE6BF1FAE2
	for <e@80x24.org>; Tue, 27 Feb 2018 06:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeB0GSS (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 01:18:18 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:36758 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbeB0GSR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 01:18:17 -0500
Received: by mail-io0-f193.google.com with SMTP id e30so9453970ioc.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 22:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uDMpe3lYB769mrRzkysnUW7y9PDPWtqVZbUWpwHSqmI=;
        b=BaHpI/Y3FJw9RMuE9MUciD/A2hZqCxIoSvsCI13g2/0zlmZvEtD7i1pdVrSyw137sr
         Ty3WNwE+dCfLAf3g9D+W/d4BqyNoi2qo0mt3TyEMq0d7NR9bY/hUR85E/olJrUpXU2N5
         uHhi0A+iwOwhibkzSyXzfs9wDaMQt9CVVnfmxoKKHVW+zuiQiVIwmpBtTXmdxoqy2blx
         Dc9azlYTRNGH0cTWyOepKcikYgNnu6lybf+PNVJj3Qg8T+rma9QvL8d43h4pXrpbuT8o
         MFI9CE3WOG4YskIpBkrMYIR1zsmGeJ5X7qcnEJV5wY/IjLZ9ETcT0BvW9u0WqPTVAc7h
         AL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uDMpe3lYB769mrRzkysnUW7y9PDPWtqVZbUWpwHSqmI=;
        b=mPWM5yjI5BMiPlnY2aEXN5CVnZ4/ukJMtDr7xNAsdjhBZCrowv0Z5hna2qSF5Odzm8
         f8KIVwPO00RUZScrlWiKBKXiWXxHyyDZNeuxJcsb7hvSXNDKuRS9XMHtSKLUYFTxRs6h
         JP9GX9egFeF+R5kRjP7YyTJQoxn2MR8ntHZKNvjnUGp/8cHiwUaDf082N1QzpHoUHL1F
         WV8iMBYAyicyt/lqGrXmtxKtfq9AZ2IIBpq8MZSqqDtSAM53ss1OBqkKhjVl2Z0eXf2a
         0Z+1hf4Lzc6ay43tiYYH4I04fNhRKaiPVVSR0r36b+HFV3xP4S7aA37mOlzZrNbCx0HC
         zFPw==
X-Gm-Message-State: APf1xPCKCuDjTnQzRHmX3c7mwxe4dfgwxjLRr+v1cEgmm9NuOCYBZUkf
        D2z3AZC3DyBZPiuSYeHx214=
X-Google-Smtp-Source: AG47ELt5uqLoOpK1xr7alWoe4oXvpzhPbwARxN2VI+wTG+olAS2W5YZwAHwMcB4c1VMUX89Skho/Uw==
X-Received: by 10.107.16.22 with SMTP id y22mr14420758ioi.213.1519712296506;
        Mon, 26 Feb 2018 22:18:16 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j88sm7024763iod.22.2018.02.26.22.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 22:18:15 -0800 (PST)
Date:   Mon, 26 Feb 2018 22:18:13 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 10/35] protocol: introduce enum protocol_version value
 protocol_v2
Message-ID: <20180227061813.GF65699@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-11-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207011312.189834-11-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Introduce protocol_v2, a new value for 'enum protocol_version'.
> Subsequent patches will fill in the implementation of protocol_v2.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---

Yay!

[...]
> +++ b/builtin/fetch-pack.c
> @@ -201,6 +201,9 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>  			   PACKET_READ_GENTLE_ON_EOF);
>  
>  	switch (discover_version(&reader)) {
> +	case protocol_v2:
> +		die("support for protocol v2 not implemented yet");
> +		break;

This code goes away in a later patch, so no need to do anything about
this, but the 'break' is redundant after the 'die'.

[...]
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1963,6 +1963,12 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  		unpack_limit = receive_unpack_limit;
>  
>  	switch (determine_protocol_version_server()) {
> +	case protocol_v2:
> +		/*
> +		 * push support for protocol v2 has not been implemented yet,
> +		 * so ignore the request to use v2 and fallback to using v0.
> +		 */
> +		break;

As you mentioned in the cover letter, it's probably worth doing the
same fallback on the client side (send-pack), too.

Otherwise when this client talks to a new-enough server, it would
request protocol v2 and then get confused when the server responds
with the protocol v2 it requested.

Thanks,
Jonathan
