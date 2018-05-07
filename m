Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3EE200B9
	for <e@80x24.org>; Mon,  7 May 2018 00:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeEGAD3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 20:03:29 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42372 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeEGAD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 20:03:28 -0400
Received: by mail-qk0-f196.google.com with SMTP id j10so20620380qke.9
        for <git@vger.kernel.org>; Sun, 06 May 2018 17:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SzYenctDXM/3BnrJFiQT6uspYye10ZbPlKssyOHhUXY=;
        b=Td3dMuIkT9c36aoJ0relw2kYw9ib1dhjd15cxeknOV4Qh1dUc6TZafScvyb1bxvNT/
         V3UC/IAl1ewADBfKOYHnoYusact9dcTWSgvbSoD6QWyotGY7vbW7Yx9XKIxaWYt9E+YQ
         miyIEof3BqzU2kL8YecfGUlk6a9TAjh/v+dUHbAHi8xoHiMGOgA9tKXB8sSmgrwlExWB
         U7teCcy182SmTWqfxYrXdrtxLjOQKsK+GCdJ5WwWBAIBbPH3LSqnnv7mXIhd97K+rbB+
         qfcxkvU3KGPRT3yVtdyIIz93v6lkC8m4NxPUNCJ/mFFuzycYzd98K83zk6HtERXVRDXz
         ljMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=SzYenctDXM/3BnrJFiQT6uspYye10ZbPlKssyOHhUXY=;
        b=Ksi0/JVzwso/J1MNC/ATmFADg4YDhbYBOVoi20+yTIKv5KD7OHCLXxYu5nC96aaM0c
         B4O3b1dxMl5V1ikpETQXrbWXu7pZhSV3dd7JuhdeCGhkhjHvb1KPtel7nGmldyCLS8mf
         L6p6tNKbEIHla01HdMIqwNS5yWDC/K+cJbRV/z4boOOlqvGMV1SsD298XocwfLQ/6u8I
         HBACquLxdoWaaRhjG/kmEzre/PMxPB3Ryt/NpGO9j9X4KfVTpcKqDZcVuXxGuIjNtcfD
         yt4UpcoDOJWN+R4eyA0Mhb16hLaHYDO9Uyvk9wBPnFDV16XJ8WkFwKgwjydFQO4csTIv
         ywiw==
X-Gm-Message-State: ALQs6tBvFbxaL7YiFdBtoLu1qxilOMmab/q9Jk0ACuyOewc5lCrcoABh
        r/inUIoNFungbyEU0AxFGYgnZAvLKLICYLwaeWQ=
X-Google-Smtp-Source: AB8JxZo9QCsfmfBoxNnqH/E/RdGptgl2nSCzaCsewX4hqDsjr83JKF/ffJWeyILRqqpupIf6ZpxFuyKMrtRqKH4luMs=
X-Received: by 10.55.108.198 with SMTP id h189mr19474558qkc.2.1525651407867;
 Sun, 06 May 2018 17:03:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Sun, 6 May 2018 17:03:27 -0700 (PDT)
In-Reply-To: <20180506231752.975110-15-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net> <20180506231752.975110-15-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 May 2018 20:03:27 -0400
X-Google-Sender-Auth: jkxaIHZo3yOmL6M78nYcXV4g9rw
Message-ID: <CAPig+cQ7hn_P_xZW70X4vCztCr_r84+ofh_ApEbZwfQKRRq6Nw@mail.gmail.com>
Subject: Re: [PATCH 14/28] t3905: abstract away SHA-1-specific constants
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 6, 2018 at 7:17 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Adjust the test so that it computes variables for blobs instead of using
> hard-coded hashes.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
> @@ -34,25 +34,26 @@ test_expect_success 'stash save --include-untracked cleaned the untracked files'
>         git status --porcelain >actual &&
>         test_cmp expect actual
>  '
> -
> +tracked=$(git rev-parse --short $(echo 1 | git hash-object --stdin))
> +untracked=$(git rev-parse --short $(echo untracked | git hash-object --stdin))

You lost the blank line following the previous test.

>  cat > expect.diff <<EOF
>  diff --git a/HEAD b/HEAD
>  new file mode 100644
> -index 0000000..d00491f
> +index 0000000..$tracked
>  --- /dev/null
>  +++ b/HEAD
