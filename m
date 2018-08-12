Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7481F404
	for <e@80x24.org>; Sun, 12 Aug 2018 04:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbeHLHJH (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 03:09:07 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39903 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeHLHJH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 03:09:07 -0400
Received: by mail-io0-f193.google.com with SMTP id l7-v6so7509226iok.6
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 21:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tVpnbTGttqzm85muZaceCxbAjMS4WPbcYhPIz4jDU1Y=;
        b=nMLpn9fV9j5hA2u+b6NG0L6ekGCLGvoHZLYy4UERYjpzrzIX+d/+oIYk1jU01oI16l
         432qdtHzFnNIy3nGOGpcEzfCJ0qOFsesludyM5dPefwpVS93fdTq+7iKpGTumjipdTsn
         aB018vamcFy1X5oh4BUIqPQV8UW8rYrbxbGKhen8xwRpx9KJ3y2VjnU5AHxDU8eKwNE0
         1vCAKR8kQRgUkzPw7iWLWn39vyVbQ2X4fevlFbOB9yAWjd/tFaOHEeOk1lXIsFG6Ixr5
         lhvyasjOLjpUwLGuJZS+xGmbnLjsKuKd24OAew82X1b1tkyrKgQjwKztWInJTYZSQSH1
         H+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tVpnbTGttqzm85muZaceCxbAjMS4WPbcYhPIz4jDU1Y=;
        b=PmvE4PIYcw2MvAJT/FXJcPrbU3Lv2KG8Vkm6uLpVDJD8IzeC9uCwEueBQpJRnK51G5
         2KElr9OaVg88Dn8b4JJpHJ29K6WBa3ee1WagDkZ7G1KE78dvkU5yKUspmIwddYP8P1SI
         MopNGoyJorM/xbblXIT6LY8+MX/yV5+SM5B3e8EV7Zjx1i2JueOCNaowKXRO4JKo0pE9
         JTDyTIivPwCiByYP055uaY4m4XSdZJ/YExFxITOUWc4K8W6UAA5aSiUWJSIoT23wxaXc
         XizTRiyCKBDEKIk6kOqO3R+cFZiKXaxItQjv/FUcCO8YjGRRvEo1WqUC1KC/wV11G7Cl
         YXHg==
X-Gm-Message-State: AOUpUlHLYqmbBKN3RP+GPP23pRTj+J5/mUC9aHtV2kLroZB65dxLqoxk
        NhZ3jD4pMeaYs/2qimPdhE6I2jyd889mc0GrPh0=
X-Google-Smtp-Source: AA+uWPyrDOeRMo+B+pmZQ0VCsrYM9sui2UXfGS90emvj5hlJ3l0azeIiQDTSPBGGk66+eVU3dpPG7DevRMBnbLcy4Mc=
X-Received: by 2002:a6b:5a08:: with SMTP id o8-v6mr10573956iob.5.1534048352059;
 Sat, 11 Aug 2018 21:32:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 21:32:31
 -0700 (PDT)
In-Reply-To: <20180811141251.GA17649@sigill.intra.peff.net>
References: <20180809155532.26151-1-chriscool@tuxfamily.org>
 <20180809155532.26151-3-chriscool@tuxfamily.org> <20180811090418.26674-1-szeder.dev@gmail.com>
 <CAP8UFD0uoOKyUkNDrQgzcf6rGtnd9-Jk26swtzdyNDeCHefYJA@mail.gmail.com> <20180811141251.GA17649@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 12 Aug 2018 06:32:31 +0200
Message-ID: <CAP8UFD34ycq-De_ZDYYZRgz6s0q0fBaAQhoYfJYxyF71=NYf9g@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] Add delta-islands.{c,h}
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 11, 2018 at 4:12 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Aug 11, 2018 at 12:32:32PM +0200, Christian Couder wrote:
>
>> Ok, I have made the following changes in the branch I will send next.
>>
>> diff --git a/delta-islands.c b/delta-islands.c
>> index 92137f2eca..22e4360810 100644
>> --- a/delta-islands.c
>> +++ b/delta-islands.c
>> @@ -322,8 +322,7 @@ static int island_config_callback(const char *k,
>> const char *v, void *cb)
>>
>>                 if (island_regexes_nr >= island_regexes_alloc) {
>>                         island_regexes_alloc = (island_regexes_alloc + 8) * 2;
>> -                       island_regexes = xrealloc(island_regexes,
>> -                                       island_regexes_alloc * sizeof(regex_t));
>> +                       REALLOC_ARRAY(island_regexes, island_regexes_alloc);
>>                 }
>
> I think this whole block could actually be ALLOC_GROW().

Yeah, thanks! The whole block will be replaced with the following in
the next reroll:

ALLOC_GROW(island_regexes, island_regexes_nr + 1, island_regexes_alloc);
