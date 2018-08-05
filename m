Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14C61208E9
	for <e@80x24.org>; Sun,  5 Aug 2018 17:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeHETdY (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:33:24 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35922 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeHETdY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:33:24 -0400
Received: by mail-it0-f66.google.com with SMTP id p81-v6so15092012itp.1
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M2+owJsloSoudR4OeN7mTvGi9mawfPg347QGPVT8sX4=;
        b=lZsVHI2cIC8IYWbHpqYa+J1bpoHnt583fjWt6jUxuuvrgFUX3c71Z8DZJHa8HQAd38
         Vp17pG2lFLEQTPg8eUopuj65Bszjig0f6BQRHZvaAm2DacTiOCKqz+HHU6jasVNteQvv
         UXb4EV7Ykrdk/t/9oC3IwNcOVT2TQxrOGXrabp4c9U5PanjjppKMU+s8+l+p0zvt6ATR
         ybsazxzkQ2N8ZMEheV5vqgl5hdHvJIlEEJ8LX2UuJCpPxo+jKvmmkY+2fbH3UvNAEZDA
         9EOIIZqLWpFcpoQ2snMaB/ciKxqeZG2xIz7OoCAfbu4IAVj4nLTUcQV0ShMDiQXIa5bu
         DKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M2+owJsloSoudR4OeN7mTvGi9mawfPg347QGPVT8sX4=;
        b=IeXReNxVkQ8zaya2D4VGtsj1Ma15YL6qeFIZkxcpcliE+8jsvWZ3CiY6Hu7/Kvx+R7
         hZiWSozIu11b//ixqJ9iQz1paBjZT1VgVFFu5HcAQT6JHtgaVQ5Z96cxR5bu/wpAFH15
         NXyM3qU8//Ez42ZXbKkBAeoxT2jY8bc+XGbeOala7Zg6BXai1CBkF51VrzpmaVI6vzIM
         YEm1jyVjFDopQjnumJ1ZFzLLT9fAW/4DY6EbC4mSOj+rusvc6GDAsekCSRyUFjHo3zuk
         OpRY1O8LJaHofboB8P70ZkD/i/l7+ROksrXKWL7bmbb785l/2PQtmMqeVVNoQsqhIq0o
         YwFg==
X-Gm-Message-State: AOUpUlFrUQ33jJImUBftSFC66Jvm2pe8A9MNS744exbD3OUOQgVI8c1q
        Im68yIHp2aVN/J1ALMoNVLjVvJj88HeQ6DWstmc=
X-Google-Smtp-Source: AAOMgpdVL7Gcu2NHal23NWA+mXqbZ7FWlHlnoPl7DmIjIIAR26bZ1p65MQfhxnjqXJI84EkHIDbF/XEPxmTDZCXVuLQ=
X-Received: by 2002:a02:6016:: with SMTP id i22-v6mr10689366jac.8.1533490086783;
 Sun, 05 Aug 2018 10:28:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 10:28:06 -0700 (PDT)
In-Reply-To: <CACsJy8CmJt1Wj=e4TNUUxY-Czn+h0BTVAWLY0ujJhgUKC+Y6yw@mail.gmail.com>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-4-chriscool@tuxfamily.org> <CACsJy8CmJt1Wj=e4TNUUxY-Czn+h0BTVAWLY0ujJhgUKC+Y6yw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 5 Aug 2018 19:28:06 +0200
Message-ID: <CAP8UFD38--s_yCsQYu5Ou++7g15L11Bw-YcUByRxxE5yyrDjzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] pack-objects: add delta-islands support
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 22, 2018 at 10:55 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Jul 22, 2018 at 7:52 AM Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> -       /*
>> -        * And then all remaining commits and tags.
>> -        */
>> -       for (i = last_untagged; i < to_pack.nr_objects; i++) {
>> -               if (oe_type(&objects[i]) != OBJ_COMMIT &&
>> -                   oe_type(&objects[i]) != OBJ_TAG)
>> -                       continue;
>> -               add_to_write_order(wo, &wo_end, &objects[i]);
>> -       }
>> +               /*
>> +                * Then fill all the tagged tips.
>> +                */
>
> If we move the code in this loop to a separate function, in a separate
> patch, first, would it produce a better diff? I think all the
> indentation change here makes it a bit hard to read.

Sorry I just realized that I forgot to try to do that. It will be on
my todo list for the next iteration.

Thanks,
Christian.
