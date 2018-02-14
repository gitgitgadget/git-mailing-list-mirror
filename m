Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDBF31F404
	for <e@80x24.org>; Wed, 14 Feb 2018 21:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031445AbeBNVkK (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 16:40:10 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:44499 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031325AbeBNVkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 16:40:09 -0500
Received: by mail-yw0-f196.google.com with SMTP id y65so4618568ywg.11
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 13:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W5S7lnerK2u6yKggQKNR6CwoUMEkrtRRBqQV2jEtLJU=;
        b=NxcTmMBclSetIAvPkGt8+gn8V6mBRKGxfn6vwoP80AF5EXdkH7VcsLUJjt5enjwEfP
         toeYc95ctQe/6Wkxd89hkKsMDaNO3RMeOcWnJdAYJmvVVR3ohOuJl375cDSAFFV48lWd
         +nXfj/Sq+qSnSXab2zNaxHg+87EvzMqxze9/JYHK9fNgPU2tdcG1QIL73mK0XpnY78pp
         V2HLR2Kqx5zSYyUwB0SxJg6T5MfaOM10hiGq8Iv3vS3m9VDJZ3+akLlMzpSrWUwtj65p
         ZyrZuqHnSWp2rnn1HkvLmhw3P4HBP2fofKxYH7iT+nNwagRElFZEq1hKvyqceaqXV0PS
         UPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W5S7lnerK2u6yKggQKNR6CwoUMEkrtRRBqQV2jEtLJU=;
        b=XRxHBvw9HomzxBsFcni1a/O7dVzlSToyck+I7wU3JyMn8/HDv6SonbzSTBtV0pVONb
         07bpmmiFTYBWD4j79SGrnjKm19vlnXPIqdFqe6a2UH4YQrbRjKJGLuoqeTgarhmCN73H
         IU5Na1WbJkf8L4nl/nWP1W4KnVXYZdEzGIrqry8u6L3z+CFYmeizD5/sWmgUWcciokSd
         jv6oh1+5v7WCsP+OxY1kG/Ww/Cg8GltgIDv3BEr8VkSPAQqwybACbVDQsx04NETD1HZ/
         t+ii2wUhJ/oFAykiPxB+oMUgwVcIQmp6NhcclS7FVyc+7weqaf3xlXOnjdF79m1yHgT/
         Wq0Q==
X-Gm-Message-State: APf1xPCMZ0pqTXQjDBDUHqZ8B+OUJkMOLYUu5USbWWslveIi1qp/IpaT
        oebXyVa8DXzERhgzDljj2vIpa6dHTEKPBgPNQgAlpQ==
X-Google-Smtp-Source: AH8x225aCjU0AITe1r2MB5PzPx6nr+2IbTx2EHjha8zxZLOnQTscNdTLt9TBo+A9pnS9DZT6VfMKFPw2mcNvas35ZdQ=
X-Received: by 10.37.37.87 with SMTP id l84mr531386ybl.386.1518644408391; Wed,
 14 Feb 2018 13:40:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 14 Feb 2018 13:40:07
 -0800 (PST)
In-Reply-To: <20180214185959.221906-9-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
 <20180214185959.221906-9-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Feb 2018 13:40:07 -0800
Message-ID: <CAGZ79kbaSmuju7Arc8FLPtHG0i5ivFeSX=i_x2uZUahQeNS+Dg@mail.gmail.com>
Subject: Re: [PATCH v2 08/37] apply: rename 'new' variables
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 10:59 AM, Brandon Williams <bmwill@google.com> wrote:
> Rename C++ keyword in order to bring the codebase closer to being able
> to be compiled with a C++ compiler.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  apply.c | 54 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 071f653c6..e9f34dceb 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -2301,7 +2301,7 @@ static void update_pre_post_images(struct image *preimage,
>                                    size_t len, size_t postlen)
>  {
>         int i, ctx, reduced;
> -       char *new, *old, *fixed;
> +       char *new_buf, *old_buf, *fixed;

*_buf makes it sound like it could be a strbuf at first,
but it is just a buffer. That is ok, as we take over a buffer from
'postimage->buf'. I was suggesting a new name, but given that
reuse of "buf", I guess this is fine.
