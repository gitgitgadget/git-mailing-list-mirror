Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207C31F403
	for <e@80x24.org>; Mon, 11 Jun 2018 07:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932109AbeFKH7X (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 03:59:23 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:32827 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754006AbeFKH7W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 03:59:22 -0400
Received: by mail-yb0-f195.google.com with SMTP id x36-v6so6396181ybi.0
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 00:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8sq8RFoq1el99vLVwrhFTxgLEG8YI3EyrXdW8plwC7I=;
        b=suMBS1dSLHpI1+fyjZuIuvNcEbqFcso74hptELpUEcfAthfT07m+ZUV6c6JiQKAiBO
         MB3YTf48wea3mNdDNLidKBEC36+2BZeFGeEuCcHzCCm92zcP/PXV1zs9sV9/kYkTIKNf
         9BsWZcVgYuUIakbaP91xpATQ6cMswzzFTK1S+Ty9YEaV4ZN3E2FtUh5Lm817kt0JqVxk
         5Yo9OBSRkE3eZMQeNeliqUiO9yBDlwgKgC8/2Vbo5Yo8QlVd+QBWKKOZGgoRdwMRJtW5
         0Fq2+p2lDy/bBv0MPgwHE+vH23rRJuSPEQRoMZKJ/RP97x/hSoRUagCNJ6rK37A7HJRF
         W4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8sq8RFoq1el99vLVwrhFTxgLEG8YI3EyrXdW8plwC7I=;
        b=GEFZB0Ik96SWuk64KIZjYADcWp7CH2MQQV8cvV7+cohc4/lo35N4eFAfH/9/mo9jv/
         t5cI5DI0ldxqGEUzLi7hZ93ie6jnToHMxfH5+BjGubvXeT9wStH3frwfxyrD8iqzgtYe
         6bCdZmq4Jxan/neBaVU3wmqbIU0cJd274+rFgUMQFvcka3XX8RpCvJ4tFbX4ibvU2m+F
         DecgV1ymb/Xr8/K5W8+c1e8CZhZ3l9Mq5naQWaySfet/fb4Dk69f0vq++GErZwkMks/v
         Rcle4H3zDX4XO3MIjzoM8lN4tqTC2NcdlgnAPV2NdxrCmT2CB/MK7mYLEjUnV3VH3wjs
         Xhjg==
X-Gm-Message-State: APt69E2cRWJKpvwu2y+uH0CxJ4DiNUUpsPjANM0QXDyOAfuAazNENWE1
        NZzDC9AwgzOuBPkmZykQCtseOyXCJGWZHfMjoO4=
X-Google-Smtp-Source: ADUXVKJw7tGE9YJj3MpDCUhBT/P/ZhzCTiJMBTTbhX0P0B7itMQZOvQjF1dOt3Qs3vEgpA7YUCktitUesb13eMtdt8Q=
X-Received: by 2002:a25:d612:: with SMTP id n18-v6mr9546955ybg.12.1528703961840;
 Mon, 11 Jun 2018 00:59:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3dc7:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 00:59:21
 -0700 (PDT)
In-Reply-To: <20180604235229.279814-4-sandals@crustytoothpaste.net>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net> <20180604235229.279814-4-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Jun 2018 03:59:21 -0400
X-Google-Sender-Auth: -Kd9yNcGMWOn9wOISiTOMyOjapQ
Message-ID: <CAPig+cSKCCzVtCqK7WctfZkc+jLUYAhDY_7L+YPkMx-3wanHHQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] t0002: abstract away SHA-1-specific constants
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 4, 2018 at 7:52 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Adjust the test so that it computes variables for object IDs instead of
> using hard-coded hashes.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
> @@ -89,14 +89,16 @@ test_expect_success 'enter_repo non-strict mode' '
>                 cd enter_repo &&
>                 test_tick &&
>                 test_commit foo &&
> +               git rev-parse HEAD >head-revision &&
>                 mv .git .realgit &&
>                 echo "gitdir: .realgit" >.git
>         ) &&
> +       head=$(cat enter_repo/head-revision) &&

Stashing the value temporarily in a file ("head-revision") is
unnecessary and somewhat ugly. Just grab it directly after the
subshell exits:

    (
        cd enter_repo &&
        ...
    ) &&
    head=$(git -C enter_repo rev-parse HEAD) &&
    ...
