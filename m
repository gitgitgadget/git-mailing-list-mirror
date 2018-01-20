Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A0CA1F424
	for <e@80x24.org>; Sat, 20 Jan 2018 22:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756733AbeATWZO (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 17:25:14 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37109 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756712AbeATWZN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 17:25:13 -0500
Received: by mail-ot0-f193.google.com with SMTP id a24so4456590otd.4
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 14:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ADwDIWbFubScR/DLj5FX8Ljb+EbnjGMUvA8WpMaVeJM=;
        b=G5oP4UjhI5LxOk+PH5OeHxzT4R9S8jSplm0rHivfM7YvuqpLn7J+xA6wMqN4Ibn9GA
         icIqeQeQws326OUKFxYnfIldwyRFuP5aAay6YnwQ8XqT2ivw+59Y01fe5k31i2ymTKBq
         kouBVSw1lSxaBIbcoEPP2m32wI3HoxLVhHI24g6ESnyaN78qBlnWZi9+QK8UVGL55E3y
         NnOLZZRwhHQ0EF4dcD6hLzdZJKKly50gD2TdB5FcbN0qeyPCwIzZtbJ7UxXzV1xZvVWp
         6iplvJL1O50/fK5OtKO5i5mS2wbioHR6D3cYDg/1Yp0lJZPWOStA7BBc0RXvbzUHGhYC
         b80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ADwDIWbFubScR/DLj5FX8Ljb+EbnjGMUvA8WpMaVeJM=;
        b=NrHwtiORulCwbiBjfEXhsd0RYCWXZ4w+4eH1amt7YsZPwCoVOoARuuB3i9e1dGuJ4U
         1Yn1FBmNjHcBkvgXmLCl0L6AAMbIqxZsT7OAN4xI3KDH/zOR2I8Lca8Hf2Z9QHioT9ep
         FSD1uiUkEySjvH8kkPZeqMyRdUYoiFpCO8UH5MHxTHdddM7DyeXrwKgfsepQPzK0sf5H
         We+ntyD3kdzZMDLXF07tfeDzkGmlwKAof9cy5cisT/Euxc5El0RFe+lWLjIBzmtj6anf
         DF0ddFyK55UmTFXhy6nQxzOH5zGd+xOM/cspkMLM9fXnFzNuKs3q4aXXlgjY0tmmmLuk
         HTxA==
X-Gm-Message-State: AKwxytf5oUsBtpfqFDcoZx+Kc7xigE3HufbuybHVL7SIUEfwzedInd4Y
        VGTZAFGjbnhmbF8bS6clbpQCqmL61p+YTHCzKN4=
X-Google-Smtp-Source: AH8x224ax5M8BfWtmsSiVwQg4G2Ff1icgIGLsQ+SuQl3RZYBRZq2RHRu/eEb6Eqf2dz77aEyuUS4GNCarMyZLc/sgm8=
X-Received: by 10.157.12.230 with SMTP id o35mr1738556otd.191.1516487112563;
 Sat, 20 Jan 2018 14:25:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.160.203 with HTTP; Sat, 20 Jan 2018 14:24:42 -0800 (PST)
In-Reply-To: <20180120010228.hhyvirqp44taf3cz@dcvr.yhbt.net>
References: <1516404987-3420-1-git-send-email-gs051095@gmail.com> <20180120010228.hhyvirqp44taf3cz@dcvr.yhbt.net>
From:   Gargi Sharma <gs051095@gmail.com>
Date:   Sat, 20 Jan 2018 22:24:42 +0000
Message-ID: <CAOCi2DGKkLnY_=-7pMr9VyP7TVsj0b8w-msdNn9ZtXKK8g7u9g@mail.gmail.com>
Subject: Re: [PATCH v3] mru: Replace mru.[ch] with list.h implementation
To:     Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 20, 2018 at 1:02 AM, Eric Wong <e@80x24.org> wrote:
> Gargi Sharma <gs051095@gmail.com> wrote:
>> --- a/list.h
>> +++ b/list.h
>> @@ -93,6 +93,13 @@ static inline void list_move(struct list_head *elem, struct list_head *head)
>>       list_add(elem, head);
>>  }
>>
>> +/* Move to the front of the list. */
>> +static inline void list_move_to_front(struct list_head *elem, struct list_head *head)
>> +{
>> +     list_del(elem);
>> +     list_add(elem, head);
>> +}
>> +
>
> Since we already have list_move and it does the same thing,
> I don't think we need a new function, here.
>
> Hackers coming from other projects (glibc/urcu/Linux kernel)
> might appreciate having fewer differences from what they're used
> to.

I think the idea behind this function was that it is already being used in two
places in the code and might be used in other places in the future. I agree
with your stance, but a list_move_to_front is pretty self explanatory and not
too different, so it should be alright.

>
> Anyways thanks for working on this!
