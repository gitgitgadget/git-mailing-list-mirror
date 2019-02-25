Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C6E20248
	for <e@80x24.org>; Mon, 25 Feb 2019 21:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfBYVoU (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 16:44:20 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:34460 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732142AbfBYVa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 16:30:27 -0500
Received: by mail-ed1-f50.google.com with SMTP id a16so8912694edn.1
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 13:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OD+5NQisiTJ1vNX3LAlAKRb5SPlgBB7vtz+R8ctpB/s=;
        b=fZTsplqg4047yB4nTPy2tZq5iuJaoDZLTnD/4YKfhRhIA3x+Iqfuci5QjDWbBy7SIt
         imXCuWQBYl2g340kzTd5C0U9VuPqMo9PJ8hzEoXLv8vPC0DxiDFzgaCHmPRBBBTOw1VK
         4RLdOrwqctEfaQyVcCWzikhUAItLOEImFPYIiVxlbkKnzSDKjlKx7koxiLWSEt+Gqx26
         8ptkxOUyHsAAYBewHwe+XUWmJlfvb/RXIphUkHSWG9rq9tFungG0kGrdPssYXVMea/kW
         1pn2esmNQSLKNIaM12mcZKnxLPs7+GTkSCIUOiGp+vjPula3nQ15AF/t0mvB+TpApZYq
         HNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OD+5NQisiTJ1vNX3LAlAKRb5SPlgBB7vtz+R8ctpB/s=;
        b=c/SRUcgEEkjOd5EN9o0BQ32OPHpZx5/tdP+DhifNktsSKjZoM5F7OUeCe9GTzEWfyY
         Uc/C6k8O6lhua1a0qc0Mw91lBFnbIIER+l0k9YLVGTqr3wW0tNr80V+NHMPx9oHKUB8q
         ECdgzpYF+mFYc/CozHY4slei/RySOt3fBTXVdFUAwGD0us8G6155VIJ0BveobtvY4F2/
         8HH/NFBrgvVI8/UHJiDxYZ6TMd3WHmomfZcrj4dmN29EJIjU/TFv9zbrTvsszjfe3cTO
         o64pSk1s7h+U8km2WAfuOtObny3OmYo5A/PrxS/bkkM+unKAKxETZffTi1LbrdFx3ard
         7dXw==
X-Gm-Message-State: AHQUAuYlWrkZuZaqKCRwdAy7NMFbtJwPcCND4ODPI9B63OSuQnBkGMB+
        Uxa+J3F2OcqeWz572CeI4Ew2qkFkXlxxg9/uhBB1aavS7dk=
X-Google-Smtp-Source: AHgI3IYZ18iTiCRn4NbTCE1/ljZ/UWhGv3qfTxZv2nJFghCxKE9s715HUzWjNNrMIxH2m/wi6kFFm7T7qu54bFV2fkc=
X-Received: by 2002:a17:906:4893:: with SMTP id v19mr14209335ejq.196.1551130225718;
 Mon, 25 Feb 2019 13:30:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com>
In-Reply-To: <cover.1550963965.git.jonathantanmy@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 25 Feb 2019 22:30:14 +0100
Message-ID: <CAP8UFD19521P=-R1XEdRK++HPatt3BJaxWPvpPRo8LHr3eisjA@mail.gmail.com>
Subject: Re: [WIP 0/7] CDN offloading of fetch response
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 24, 2019 at 12:39 AM Jonathan Tan <jonathantanmy@google.com> wrote:

> There are probably some more design discussions to be had:

[...]

>  - Client-side whitelist of protocol and hostnames. I've implemented
>    whitelist of protocol, but not hostnames.

I would appreciate a more complete answer to my comments in:

https://public-inbox.org/git/CAP8UFD16fvtu_dg3S_J9BjGpxAYvgp8SXscdh=TJB5jvAbzi4A@mail.gmail.com/

Especially I'd like to know what should the client do if they find out
that for example a repo that contains a lot of large files is
configured so that the large files should be fetched from a CDN that
the client cannot use? Is the client forced to find or setup another
repo configured differently if the client still wants to use CDN
offloading?

Wouldn't it be better if the client could use the same repo and just
select a CDN configuration among many?
