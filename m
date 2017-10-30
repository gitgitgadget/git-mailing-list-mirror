Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55689202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 17:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932582AbdJ3RfR (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:35:17 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:55672 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932538AbdJ3RfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:35:16 -0400
Received: by mail-qt0-f196.google.com with SMTP id v41so17370520qtv.12
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ifSGRBgXeRNOdbXPf5OVH9P0Rovc9bcA2lhFl9hiYBk=;
        b=uMbAKlHM+ce0WBp5H35zilmJxuhZmh6ZRk4fQQm3OXP3KSkG6SP7igoCLvhBlXUhy7
         h59xuekHCzMYxJPGbQyIAkZZvRjqMQHAyuqa6l/Ujes08Ar0ojR88wmb/t9tyjVuQMR4
         WeZBJHS0bgVFFIwDkG3GYniMFk9IE0A3PGWSSTRFfghLwk+zpslLeb91GfjL7KZoWl4C
         7D71DRccU8aqtZKR3cO4+MwRR5cahk5oz3cs4mlbipZGtw3K34bRl1zo1Yb2LrUiQQHx
         nIJo5/23+qsDg1e/5qmIUCjlsqDC6CvsE/udoTU02pT4XukNJlAQW3ih6T1iuUn/PvqH
         NgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ifSGRBgXeRNOdbXPf5OVH9P0Rovc9bcA2lhFl9hiYBk=;
        b=eJGdch/0P0zaGWR3jviILu6J58WF8aGPpiLxkMYiD910ecGU8Ros+yCADhY1+jhZp+
         KkM5amMug9dHuSXmPYWuBy+FzdK4g5XVK/622Z9y/T3qU5ZuVumvBNcezU4EyPOyqFAR
         yCVeDuEOO9lcF1f9GRSwQmPLyHXIXyyCCFg2W9YI30kONIg7fs850DkbHZ8blvN4qlUV
         YfltZ9k85EZSEuz5VDtFistYdgnYv2FM2Nc3wkoVamOFqpYP9MYMkNVI9TFktunhckx/
         AgXqPwTwqrdIr22BC4lZi7lgLAFYmJNOVu3HBTKERCe4nGLhYR7a9OQ6XxAUpQ9Pzn5m
         Szcw==
X-Gm-Message-State: AMCzsaXkClcyLu2wyJ4vd5Id2ONh5Zj8JMd9KLxPqZ71QQ60olc99Lqh
        g0JLcdDvvjVU6R4vNmxn0UdzdQDdQHuLq/A4sHI=
X-Google-Smtp-Source: ABhQp+Su8uqKm9ZX3SZf4iewAql31IhRxf6lXxyU2Gte5qeX/VSdK7cRYB0eWJZu8t0hw7blV6Ztlh964gf2JmU+Vms=
X-Received: by 10.237.59.198 with SMTP id s6mr15540992qte.281.1509384915757;
 Mon, 30 Oct 2017 10:35:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.28.246 with HTTP; Mon, 30 Oct 2017 10:35:15 -0700 (PDT)
In-Reply-To: <20171027172845.15437-1-martin.agren@gmail.com>
References: <0102015f5e5ee22c-ea9c3a38-5d42-4dce-a54b-45c59768a70b-000000@eu-west-1.amazonses.com>
 <20171027172845.15437-1-martin.agren@gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Mon, 30 Oct 2017 23:05:15 +0530
Message-ID: <CAFZEwPP7dkWwRJD2ohDfnV_Phb0ga7YPZoVC920JPrQXLAGekw@mail.gmail.com>
Subject: Re: [PATCH v16 Part II 2/8] bisect--helper: `bisect_write` shell
 function in C
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Martin,

On Fri, Oct 27, 2017 at 10:58 PM, Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> On 27 October 2017 at 17:06, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> +static void free_terms(struct bisect_terms *terms)
>> +{
>> +       if (!terms->term_good)
>> +               free((void *) terms->term_good);
>> +       if (!terms->term_bad)
>> +               free((void *) terms->term_bad);
>> +}
>
> These look like no-ops. Remove `!` for correctness, or `if (...)` for
> simplicity, since `free()` can handle NULL.

I probably forgot to do this here. I will make the change.

> You leave the pointers dangling, but you're ok for now since this is the
> last thing that happens in `cmd_bisect__helper()`. Your later patches
> add more users, but they're also ok, since they immediately assign new
> values.
>
> In case you (and others) find it useful, the below is a patch I've been
> sitting on for a while as part of a series to plug various memory-leaks.
> `FREE_AND_NULL_CONST()` would be useful in precisely these situations.

Honestly, I wouldn't be the best person to judge this.

Regards,
Pranit Bauva
