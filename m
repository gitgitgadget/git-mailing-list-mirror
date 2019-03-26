Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F8A020248
	for <e@80x24.org>; Tue, 26 Mar 2019 10:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfCZKLX (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 06:11:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40099 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfCZKLX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 06:11:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id h22so10206337edw.7
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 03:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ETEf+mv32FWz32asBPUaVvoPkMAhFhNqKTMOnkQq+a0=;
        b=iGIqbr8ORXVwl8a3FV/Scdcfn1lx39sgPJFIVqRwwboK2gvolkTCXkdvpA4X3a8t6J
         sbonvM/jeaTUvrBddZ6MTThKno9/vnnn97wqck5U8ozSR67FSLHDGrMfQF/VQGt6G8Cu
         8cvmmunk4DPfsm+TDeWIrQ7PbZKr3gkI+D4EV4p3+KTcPml2cKRiWaYM/WGR04iMuegl
         0ZQU81K5hY2Ajg3QhZxJB0wHuXaT/a2jX5HOxkowtmunoUdZbLnCO6q2yTair378q+yx
         qyl1pOEiP60opkGfvuLImjMMTJqBQX3GVa/vCsbdrUZj0B5tqsaBB3jBMvFVvHv84fiv
         KeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ETEf+mv32FWz32asBPUaVvoPkMAhFhNqKTMOnkQq+a0=;
        b=DxeOPANvt1Ck26MEkXiu7jUV6D70AMNG8FMnfDUf1JhKzE/P1Skcj3s7H0tnjorbPa
         5Xl1dT9ZJA8Q1utFzUDtewtuI8O1Ar67yBbxlDF722RdEqUKmur4ZeC/LV1SrwCji4Mv
         yzy3y6kWUFvLde/W8fK2b0gqBw1aDni3Beu4WHhKlurHEiMtgd2WzebE+r8U829ORR9u
         R0Bz3LP9IZVN7QVMG7gxfvJzrtdNadrwWo30mpK1XI+BotmVdn8L/vbO2T0invEBszdF
         2tptV0hkLNW8FdbsRPrsiW4bhrE8gZabqRCfXI4bxpReAP+9ShusKXe1Hs5OORiq/vTC
         HgjQ==
X-Gm-Message-State: APjAAAXd3mpzdheZlXpZ49sl3dJC7gy2sKhb2TUil1YTrRSIidreUyut
        RGpz2rv/p1ldBy9+CcWXtg8/UQ6X0Ek=
X-Google-Smtp-Source: APXvYqxLb/kQ3OGGrVS4kNNmjmonF+W7LC7l7rS6GT38P3dvHBiychOgTh5kIiUkMhuDnYaZ/5+s0g==
X-Received: by 2002:a50:90b3:: with SMTP id c48mr18597246eda.8.1553595081229;
        Tue, 26 Mar 2019 03:11:21 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id l20sm1042892ejb.30.2019.03.26.03.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 03:11:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: [PATCH 2/3] t7004: ensure recursive tag behavior is working
References: <20190325233723.GD23728@sigill.intra.peff.net> <cover.1553586707.git.liu.denton@gmail.com> <d545bed9d3686b41ba67cfb25e00bb5a8b61c77b.1553586707.git.liu.denton@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <d545bed9d3686b41ba67cfb25e00bb5a8b61c77b.1553586707.git.liu.denton@gmail.com>
Date:   Tue, 26 Mar 2019 11:11:19 +0100
Message-ID: <87h8bqaqt4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 26 2019, Denton Liu wrote:

> Add tests to ensure that recursive tags are disallowed unless the
> "--allow-recursive-tag" option is provided.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t7004-tag.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 7a7c0ccee9..5297da952d 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1700,6 +1700,14 @@ test_expect_success '--points-at finds annotated tags of tags' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'recursive tagging should fail without --allow-recursive-tag' '
> +	test_must_fail git tag -m recursive recursive annotated-v4.0
> +'
> +
> +test_expect_success 'recursive tagging should pass with --allow-recursive-tag' '
> +	git tag --allow-recursive-tag -m recursive recursive annotated-v4.0
> +'
> +
>  test_expect_success 'multiple --points-at are OR-ed together' '
>  	cat >expect <<-\EOF &&
>  	v2.0

Mmm, I see part of my feedback on 1/3 is addressed here. IMO better just
to squash this into that, or at least say in the commit message "this
commit leaves us with a test blind spot for XYZ reason, but it will be
added back...".
