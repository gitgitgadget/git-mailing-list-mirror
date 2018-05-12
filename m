Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F5F1F406
	for <e@80x24.org>; Sat, 12 May 2018 13:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbeELNni (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 09:43:38 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:45988 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbeELNnh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 09:43:37 -0400
Received: by mail-pl0-f48.google.com with SMTP id bi12-v6so4822368plb.12
        for <git@vger.kernel.org>; Sat, 12 May 2018 06:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m++pjYq7KKrUiBS0nuYOJD7uqAs/tfoG+cXUuBDSlQI=;
        b=r3QAV5czweG9Dy39SpBnh/fBcKz5FMNlXxqP6fGJezdME/Yihwxc1pah8YYd+2T0ty
         aiQsBo6aE+oKhkItEZyYLgFzAtEfimsnmZU6xkGaV4nERKxIpepWbxcCz+U2SslthNT6
         YwyHBQXx42SgudVVMYQ4OAuZCuYqOYD+k28UBWaE1Vi75NDps/2k8C0/kZQG83R0B8QG
         xKZHEVvU+3P7F+wLKpyCC0CKIBHJC+yDeEfAsTxvVPwl/sowBsBwBubKB4cvI2yOFgIV
         DU9jk74pkG3VX3qsL8UPxLO8Xv+nFm7hcngH06ADVMFIY1oYUJMcUudWhWBEYz3JDWKQ
         yRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m++pjYq7KKrUiBS0nuYOJD7uqAs/tfoG+cXUuBDSlQI=;
        b=IRrD3Tes4cGgiNOliVbCLnlxPlfIbkDyLJ+LqO/kw8Wasmfh3z2wZjH87NXN2P65Rg
         cYloyYFbDZYBt5z8+d0vOxt1mNT2iEdoWF3gqetGLGOHnx8SHsG9E73/Juys9BNfEJD6
         7d8EsLx/QSl1dheT0D2WkEGPtrOiibbQ4kVLuhxfN6S6U57vmUn6UI1rZfAp6560P8OJ
         PJzt8nlLtISSsgz1pg9PBMJwf/dZotixLdnsmJM4TegLauSsU+TqbEiZRINm1isxtJeq
         wyPq9mzZ09wg8efbMSPMmtOwNuRnFfBrJWqNPTjz/gNCdLIcu8vRh+DpogBqIyx4axPB
         ehdw==
X-Gm-Message-State: ALKqPwfHlRV6zF4IN71r06exA9qrcSnJQMSn5sQqfs77OkZF53XvblO2
        2ehZdi41x1q8U+lvRoizJlb6L5ieYZ5C4d35iSG6Pw==
X-Google-Smtp-Source: AB8JxZp+YVYFbxhE8pr2oaSb0bIFkXGFtSiOXc7owRBZ1ER/nCBM1FwvSw+uTZQeTBB67SiDAVrAV4vteV87toHfyKg=
X-Received: by 2002:a17:902:1c7:: with SMTP id b65-v6mr2528842plb.298.1526132617069;
 Sat, 12 May 2018 06:43:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Sat, 12 May 2018 06:43:36 -0700 (PDT)
In-Reply-To: <20180511211504.79877-4-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com> <20180511211504.79877-1-dstolee@microsoft.com>
 <20180511211504.79877-4-dstolee@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 12 May 2018 15:43:36 +0200
Message-ID: <CAN0heSqYOY4HyinuL7ye0XL3u+rUxWeT9KwsiXWCcsVN_hmc2Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] commit-graph: test that 'verify' finds corruption
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 May 2018 at 23:15, Derrick Stolee <dstolee@microsoft.com> wrote:

> +test_expect_success 'detect bad signature' '
> +       cd "$TRASH_DIRECTORY/full" &&

I was a bit surprised at the "cd outside subshell", but then realized
that this file already does that. It will only be a problem if later
tests think they're somewhere else. Let's read on.

> +       cp $objdir/info/commit-graph commit-graph-backup &&
> +       test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> +       corrupt_data $objdir/info/commit-graph 0 "\0" &&
> +       test_must_fail git commit-graph verify 2>err &&
> +       grep -v "^\+" err > verify-errors &&
> +       test_line_count = 1 verify-errors &&
> +       grep "graph signature" verify-errors
> +'
> +
> +test_expect_success 'detect bad version number' '
> +       cd "$TRASH_DIRECTORY/full" &&
> +       cp $objdir/info/commit-graph commit-graph-backup &&
> +       test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> +       corrupt_data $objdir/info/commit-graph 4 "\02" &&
> +       test_must_fail git commit-graph verify 2>err &&
> +       grep -v "^\+" err > verify-errors &&
> +       test_line_count = 1 verify-errors &&
> +       grep "graph version" verify-errors
> +'
> +
> +test_expect_success 'detect bad hash version' '
> +       cd "$TRASH_DIRECTORY/full" &&
> +       cp $objdir/info/commit-graph commit-graph-backup &&
> +       test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> +       corrupt_data $objdir/info/commit-graph 5 "\02" &&
> +       test_must_fail git commit-graph verify 2>err &&
> +       grep -v "^\+" err > verify-errors &&
> +       test_line_count = 1 verify-errors &&
> +       grep "hash version" verify-errors
> +'

These look a bit boiler-platey. Maybe not too bad though.

> +test_expect_success 'detect too small chunk-count' '

s/too small/bad/?

To be honest, I wrote this title without thinking too hard about the
problem. In general, it would be quite hard for `git commit-graph
verify` to say "*this* is wrong in your file" ("the number of chunks is
too small") -- it should be much easier to say "*something* is wrong".

> +       cd "$TRASH_DIRECTORY/full" &&
> +       cp $objdir/info/commit-graph commit-graph-backup &&
> +       test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> +       corrupt_data $objdir/info/commit-graph 6 "\01" &&
> +       test_must_fail git commit-graph verify 2>err &&
> +       grep -v "^\+" err > verify-errors &&
> +       test_line_count = 2 verify-errors &&
> +       grep "missing the OID Lookup chunk" verify-errors &&
> +       grep "missing the Commit Data chunk" verify-errors

Maybe these tests could go with the previous patch(es). IMVHO I would
prefer reading the test with the implementation. A separate commit for
the tests might make sense if they're really tricky and need some
explaining, but I don't think that's the case here.

All of these comments are just minor nits, or not even that. I will
continue with the other patches at another time.

Thank you, I'm really looking forward to Git with commit-graph magic.

Martin
