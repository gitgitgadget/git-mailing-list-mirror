Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FDCD1F404
	for <e@80x24.org>; Mon, 22 Jan 2018 19:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbeAVThs (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 14:37:48 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34311 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbeAVThr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 14:37:47 -0500
Received: by mail-qt0-f173.google.com with SMTP id a27so10672405qtd.1
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 11:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=mpMEeMT/HGNEq4vJtGRupM3t/6S9mvmqL8Yg0IikDws=;
        b=LBPYy7FEE7tLfum76X07jKR3Z/PO/HLsLrHNTwfoacAOeNhfuLI9k7Zcf87AwCJJmf
         eS1JPtVnrv12OeWiGMrbVzUeqxAPIip0yiP9i8rjiqhSocuZaWYY/2EhOq/a7VGPgJ0f
         eD5nuHqwMUZC+a0UVqoDAoxikYQEiOXkMu00DZT/EVTUMSbe09sliJhUIJPtxIh6s9II
         aUCByTQqEEc6bwTwzwPspTxE61eg1b4/jLdrI54SJlrvVaorwP8YmevwGYs75Y5+iXk2
         X/cSn30yicNJHVGowz8OO0Ynr4gGEW5l8NNsZK5tqRSEvqbTYnbgNQ+gSuTCb7bzZmg3
         bxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=mpMEeMT/HGNEq4vJtGRupM3t/6S9mvmqL8Yg0IikDws=;
        b=j/XVqVFlrNkU/bCp0+aEF5CxHljKUrvsgiaKgIoXsm2czqi9rh6EMKcPZp3DodDvTw
         4OTdsLBWFwwpCSZiaOwIQsZPa/y7qdbTIypJ5B5FvPFQ5gJ06PnVktKhqH6IhaEFiRvt
         LoO14VwFM6EIEsJOQgLot7GlgLwdUrPbtn/EtYRwonPQOLlGdHpiVzeDa9iP9PMbj8jK
         rY+BxZXDEydGHyvfAyuQo/MnP8Xd2u7tRMHu8kgrXqAUQDJTt3LXMvollRjV8rQZNNDD
         x7GN8YKxx+x3OfIT4C8/5zTvjxKMo8nN8NdXNoWh7nydSwWqiq067aulO48doxM8Svm8
         AomQ==
X-Gm-Message-State: AKwxyteG4q1OOn4RixpyXwVhUGcgCWa5JLLPKd19RIy35MIompFG6mRF
        xcYrcIhOxafU6oR1pTiEQV8vrlrNmFGHgZw9knk=
X-Google-Smtp-Source: AH8x227AyoGGnYiahNVOF/J+wfdpqZc8jh5oHrA3DI3jT/c0uV23kxnAZgdOqgRgJbya+h3KwuBMKFiecucH0FV3pTI=
X-Received: by 10.55.123.69 with SMTP id w66mr11470848qkc.326.1516649866617;
 Mon, 22 Jan 2018 11:37:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Mon, 22 Jan 2018 11:37:46 -0800 (PST)
In-Reply-To: <20180122180042.70101-1-lars.schneider@autodesk.com>
References: <20180120152418.52859-6-lars.schneider@autodesk.com> <20180122180042.70101-1-lars.schneider@autodesk.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 22 Jan 2018 14:37:46 -0500
X-Google-Sender-Auth: do57r-BgRGrYO3EM-_bpd7HnUE0
Message-ID: <CAPig+cRMHmFuMxQmSeGoK9hhUVEVVVLQs0j10Lo8bE5t8-V9OA@mail.gmail.com>
Subject: Re: SQUASH convert: add tracing for 'working-tree-encoding' attribute
To:     Lars Schneider <lars.schneider@autodesk.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>, simon@ruderich.org,
        Johannes Sixt <j6t@kdbg.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 1:00 PM,  <lars.schneider@autodesk.com> wrote:
> diff --git a/convert.c b/convert.c
> @@ -1165,8 +1165,9 @@ static struct encoding *git_path_check_encoding(struct attr_check_item *check)
> -       enc = xcalloc(1, sizeof(struct convert_driver));
> -       enc->name = xstrdup_toupper(value);  /* aways use upper case names! */
> +       enc = xcalloc(1, sizeof(*enc));
> +       /* Aways use upper case names to simplify subsequent string comparison. */

s/Aways/Always/

https://public-inbox.org/git/20180121142222.GA10248@ruderich.org/

> +       enc->name = xstrdup_toupper(value);
>         *encoding_tail = enc;
>         encoding_tail = &(enc->next);
