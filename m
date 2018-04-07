Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6BEA1F424
	for <e@80x24.org>; Sat,  7 Apr 2018 06:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbeDGGzp (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 02:55:45 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:42200 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeDGGzp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 02:55:45 -0400
Received: by mail-qk0-f176.google.com with SMTP id b198so3645835qkg.9
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 23:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vVtzmbPAdmOoz1cBFM9AZ2xl/zAzEnooKK9//1TyfLI=;
        b=ATDvG+ssektvEF6xIXwP0IsSVy2n6K3/otz2w6x5IDxuiwYg8bHFMd1JOQC9PVHFeG
         Fk56iIlAUygqbVYBP4prwLVllNQys8W7bB3QcHSNPbdr0NLFDLr439/weSRXrtw3UGpo
         nwG/IGVPQBSwXSg9652SxVXMXo50iq4bokqs5zBV9jQkP+ob5rDsvZK3v1Pcg7pXfWt+
         bUZnRK8LsTXTm5f9lw7mIglP2srGeVOhv+W/gcs2GnuSRGce0udoqUcY/cbZpApJoJ0Q
         y+nwhZbVmEl8Rx9+w/vD20qqLcX+mpz9ocrV6uXjzE660hyOJKmt+h/xCnOv0IQJPErT
         YGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vVtzmbPAdmOoz1cBFM9AZ2xl/zAzEnooKK9//1TyfLI=;
        b=gT4xX1sG/bb+p0k/SQZyfB9Iecj5Bx0eqKNicSp7BFHW5tXYRZVrNEpCDqO1tmtcpy
         0fegDJ7YG2IfHrEWvxhMlb3ZvP+ux4g2Izz/Cllx9mUUXHbzRFNjzC8/AOotH3geWKvz
         J//941zINoNhJA7rt87AHdlUuA1UEbgYsTmiDT28Wvoi/G/2b6NNcgCufElT/MA4hYd8
         Qnm8zjYoijxy2k0OhsnTJzP9l6UlzbDTb7K0qWQi3SZ5W57FhJF/ubo7zU5GUiGcvjui
         BDc+hX2nribSkD4m86KPdQsIKlBVHqkbHzk80PC/fZoIAymKMWZz96HAAHJgGmMv4WB6
         L/zg==
X-Gm-Message-State: ALQs6tBxQjUnPx61gisQPeWjUvuKD6o70XwnRyKsgqOCmf9hYiEkd655
        o+JDLlOx+vp7tcSuXQIZ6PC23t5byG4TzyEO0R8=
X-Google-Smtp-Source: AIpwx4//3OMIuf7f+4ampUb72VA7iYCcIoKZ0VgkUv/SGNsCtIKrtoTL8sm0nEA17Jmf716dtX1Zuob5y1Y2hqjwKQI=
X-Received: by 10.55.182.70 with SMTP id g67mr38549593qkf.314.1523084144416;
 Fri, 06 Apr 2018 23:55:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 6 Apr 2018 23:55:44 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804061414330.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1518783709.git.johannes.schindelin@gmx.de>
 <cover.1522968472.git.johannes.schindelin@gmx.de> <516b28e82ace0a0b6831c644f246c19dad1187ac.1522968472.git.johannes.schindelin@gmx.de>
 <CAPig+cRW6VhZGrV3qN5gDyMu1Oc=hjDOpyo_OY43jyoQNc6Q1A@mail.gmail.com> <nycvar.QRO.7.76.6.1804061414330.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 7 Apr 2018 02:55:44 -0400
X-Google-Sender-Auth: 6P8HF2fdK2PmsIiThE-FYd2I4MM
Message-ID: <CAPig+cR+=8fWYtiOyuvuRoLPRSUUAVz_iU3p64Jttff+2xdHYg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Document the new color.* settings to colorize push errors/hints
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 6, 2018 at 8:15 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Fri, 6 Apr 2018, Eric Sunshine wrote:
>> On Thu, Apr 5, 2018 at 6:48 PM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>> > +color.advice.advice::
>> > +       Use customized color for hints.
>>
>> Is "color.advice.advice" correct?
>
> As per the patch, yes. But you're right, it sounds silly. Will change to
> `color.advice.hint`, okay?

That's more understandable. Thanks.
