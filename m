Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0A972095B
	for <e@80x24.org>; Sat, 18 Mar 2017 19:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdCRTwe (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 15:52:34 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:38332 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdCRTwd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 15:52:33 -0400
Received: by mail-it0-f46.google.com with SMTP id m27so60611970iti.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qaeNlVmviusESwvM5TxzQHqgZTIIb0C//n2zbWxHHKA=;
        b=pjbgVRI8FcfYwhbrbgpc31U8uE+TQG+tKxu9V6xEoUhPfBCeP7FAwJEtbH4x8RMzXA
         b7+x9VwoyraVWysJKPWZ1f6Q8nO9vrRwmfwdQLxiYGfsLEr/J2/+0uaFEx8O9GkjWOeA
         2gaOI/Q2FS/dqUNlRJ+qOAP6QE/oKF/GEJAAB0H3zFq+f76+B0B52Otx7feeayM8rlye
         qBODDqMS28BTeJQKGG3mK0bGE9QS/82MJUihxYW0dGgSoVpol9j0Tn4bVcbR4dodDA0l
         rQmC+h1xuQZRDd6v9tpo9atocfq1QeFqzyQUh301ERVjOoWDSs/6yvkfR/5UmiTZG1SZ
         UAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qaeNlVmviusESwvM5TxzQHqgZTIIb0C//n2zbWxHHKA=;
        b=LayNHHvelJ1Aqps+LDORgWWOwNI/pLA1lyq5x536riDHqDIdQsgszBftv4T8jLd9Q2
         RZlD0+eGh+sUDWzJCdhFg6lsZh2VdnKnaPHVc+WoRihmxrdJ5Es+9ZyjSALHmN06QzFR
         PmJCZo6pyzKCrqlmZBwuzQl5S1UJ/HG2/srdClZu7AYjGFGuuoA63nwu5lOY+W6/R1JS
         eohMoBQ+yq7RsquT86o2pouPSBIck1rpbzMHNutoo6Nssfmz0QaWbm/PmAXMYUb5c9T1
         bgX7WWaohID/cZ9N+FsGh23jKg7mSQvqHVV7aoy1/ow6WpeMcyL387yrFX5zLZ+WP+NV
         4sig==
X-Gm-Message-State: AFeK/H188B2ld0bn25yyF4+OOCq0cUfHbSWVHh/+9Q8y6DJ8B/Lp1QRfU9IVFocZBM0HTIFBhEqAdDRiLYtfNw==
X-Received: by 10.107.57.2 with SMTP id g2mr23017969ioa.117.1489866752070;
 Sat, 18 Mar 2017 12:52:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 18 Mar 2017 12:52:11 -0700 (PDT)
In-Reply-To: <xmqqinn62z74.fsf@gitster.mtv.corp.google.com>
References: <20170318103256.27141-1-avarab@gmail.com> <20170318103256.27141-9-avarab@gmail.com>
 <xmqqinn62z74.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 18 Mar 2017 20:52:11 +0100
Message-ID: <CACBZZX5y7ZntOO1RsX74AHoYDJb6pUrjFDbNcamXVJ4Yieeviw@mail.gmail.com>
Subject: Re: [PATCH 8/8] tag: Change --point-at to default to HEAD
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 7:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the --points-at option to default to HEAD for consistency with
>> its siblings --contains, --merged etc. which default to HEAD. This
>> changes behavior added in commit ae7706b9ac (tag: add --points-at list
>> option, 2012-02-08).
>
> Makes a lot of sense to me.
>
>> +test_expect_success '--points-at is a synonym for --points-at HEAD' '
>> +     git tag --points-at >actual &&
>
> Even if "expect" is the same one established earlier, it is easier
> to read and understand individual tests if you explicitly said what
> this one expects.

Makes sense. Queued that change in my WIP v2.
