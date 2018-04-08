Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 523F01F424
	for <e@80x24.org>; Sun,  8 Apr 2018 09:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeDHJpB (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 05:45:01 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:38265 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeDHJo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 05:44:59 -0400
Received: by mail-qt0-f175.google.com with SMTP id z23so6009912qti.5
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XtkfkmaSmKjaqmnUEV7nw7hF30NEujH5IXg0wCtQyfY=;
        b=jaqQRkakYCEhveqdyHPpUyY28eBza/aB4KRull4hmKm69YMddabuOSnIOpvmaSaEND
         +8WAWyKt17acuYVaqpdkdGKVUoIHNP6qR92xnS2SSZ+pK59/aiL+2qbjOwJ0iExdkJgf
         Ocic2xR73Ei7T1Y+UTysmj4CJ2WyOj3B/UkWtDvnBCF06F/Y3czYor4Ut6w/N9dqtkOi
         HRjAf2zI57P2Nr2zyFlKU6dZO6zWwYsjjtf3XljW3o7grrQHlWCdEWMM2GXvQFED/qUj
         Bgj2XalTUxtE7rFNq9T/IFhg4EM9G7QT9uEpVsYfHcq6SoopxVu0kfG5H1HZD0XiMq5K
         a94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XtkfkmaSmKjaqmnUEV7nw7hF30NEujH5IXg0wCtQyfY=;
        b=j2Zr7VnTCIZIlp47N0z+/M1X9rGSjOoESJ7BgENXnxLZluKcbeAjsuWBXunn8tH6Ml
         RJESkamYe/Ugk36eYKojMzuMT2kZzUhETNXHeAkJvtPDA01AzRQz8ADVCKs/vCUz7aBU
         irVYyj0V8x9qXzaEb2uyoNuZFU/NMpuXxt+I3KfhjiMi8WpgJAy842BgN6XFm4Js8iSe
         KpIOkCF5hBcXiK0ZUMvdsWaHSrBYcU3knJAK6fGjP84qteYTKImPbYZRoigAMHqY7esZ
         KxcRireoPdb/V9gQhQMePlDeWtV46kj8uGJ1RG3qSaTnM+6GrrSUgApbZIzEDXwo0XSI
         ei2A==
X-Gm-Message-State: ALQs6tCkZpqmok3OJESQcTEaqGEgjHFihXGScjhZu3uPWocCNUv7R0+7
        eXFERIfCyl+9h2VY7SI2Bkvgv5/98wyplvuNZq4=
X-Google-Smtp-Source: AIpwx4/+RmcdBQo17ZmoLhuGUXXMDoJkUF95ivFRec3uVtMOBVAX2qKxsxi8VHni/G9N07OzPSZ5K7k0v7Ta/cGuW90=
X-Received: by 10.200.1.2 with SMTP id e2mr47675372qtg.121.1523180698762; Sun,
 08 Apr 2018 02:44:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 8 Apr 2018 02:44:58 -0700 (PDT)
In-Reply-To: <20180408093513.17769-2-chriscool@tuxfamily.org>
References: <20180408093513.17769-1-chriscool@tuxfamily.org> <20180408093513.17769-2-chriscool@tuxfamily.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 8 Apr 2018 05:44:58 -0400
X-Google-Sender-Auth: 1qRPwL_EYCuvqEuMhoWa7h1gAiI
Message-ID: <CAPig+cT=kn0hujoeLxkYTv1wZA93QxP-CQPepmzs1SDq1QJWEw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf/run: add --subsection option
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 8, 2018 at 5:35 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> This new option makes it possible to run perf tests as defined
> in only one subsection of a config file.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/t/perf/run b/t/perf/run
> @@ -1,21 +1,34 @@
> +while [ $# -gt 0 ]; do

I was going to ask if you meant to use 'test' here rather than '[',
however, I see that this script already has a mix of the two, so...

Likewise, scripts in Git usually omit the semicolon and place 'do' on
its own line, however, again I see that this script has a mix of the
two styles, so...
