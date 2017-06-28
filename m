Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B09EB1FCCA
	for <e@80x24.org>; Wed, 28 Jun 2017 19:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbdF1Tyl (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 15:54:41 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36359 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbdF1Tyf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 15:54:35 -0400
Received: by mail-pf0-f177.google.com with SMTP id q86so38455909pfl.3
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 12:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TL0vsraEUZ1tFVvtoMvyBf7qWdE2Ebkx+FDBKdkYPXA=;
        b=v1DhY81COZyDXYBhX3zNlQB1ZYnU7JzsbRv+74/9Jx+h5ypHUMbDqoq+WTIM09Xf6w
         v2C3rdVtn/HE/PYHwg142y7Y8OqBQg47/CUB8IPnyp/JfaFwWvtmT42AIxOKnFYhbk+X
         q2u4mKv1FriBEKAE27WVMSFjFsbdW3HgeQiVbBjOQKm2VejW1uUm17nY55QQTmXwQeX5
         5lnPZ4V61C6IVe7/DF+pVsVrnUVwOkqTBLef/dw7v0PTRIdkexygiOZ5IAHDPCnBKKju
         ViWV1uF1epSBf6JmBkCXyEjm0rk00iJpPJ3SWKq2Hn6yIs1S+pnU0bJr3u47xH3Dj6cr
         BK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TL0vsraEUZ1tFVvtoMvyBf7qWdE2Ebkx+FDBKdkYPXA=;
        b=hNypByuuj2fX6/6RJ5wVCKvP5HTstA60gz2YMZX1N2AwhTjuElUKI/DZ0nNOzdPvDU
         oJQb42+QdjNztxZXz/jELrsWV+iT28zj98iBF0hNYw9MnDXti/AcWUX/gqkPtiBV2adu
         yH4hHnUOAJkyh2ib0xrrFgAktOVker1JZlFq0m/aQEVFGCahyASPlxkTWVoR8T0XotoM
         5vrwb16EH9WacS+8ZZsrnied5PhwIn+kyYWnCOWrzXx0yoPSWa5o9oH/eGX0aZ/OEf81
         xCB5isU5IYkT3MEOJT/UehARkqlrH07BFaNC0hzHy+fWfODUVV4gq3piri+E9p2RVDv+
         RKFg==
X-Gm-Message-State: AKS2vOxaFsnTZiXo6tcs8r2n/ea8h9K4hyak0+UXb5XzPtUrFbWyTK53
        YSXZP40nK6OT/Sw/r3p8z7v+hnT3qGNqQ2I=
X-Received: by 10.84.232.205 with SMTP id x13mr13922474plm.245.1498679674404;
 Wed, 28 Jun 2017 12:54:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Wed, 28 Jun 2017 12:54:33 -0700 (PDT)
In-Reply-To: <xmqq60fgztud.fsf@gitster.mtv.corp.google.com>
References: <20170628005651.8110-1-sbeller@google.com> <20170628005651.8110-3-sbeller@google.com>
 <xmqq60fgztud.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Jun 2017 12:54:33 -0700
Message-ID: <CAGZ79kY2qhaefcjFJLDAuhFB_ZngGw7bKnzv-hA-5hmCfH3KOA@mail.gmail.com>
Subject: Re: [PATCH 2/6] diff.c: change the default for move coloring to zebra
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2017 at 8:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> diff --git a/diff.h b/diff.h
>> index 98abd75521..9298d211d7 100644
>> --- a/diff.h
>> +++ b/diff.h
>> @@ -192,6 +192,7 @@ struct diff_options {
>>               COLOR_MOVED_NO = 0,
>>               COLOR_MOVED_PLAIN = 1,
>>               COLOR_MOVED_ZEBRA = 2,
>> +             COLOR_MOVED_DEFAULT = 2,
>>               COLOR_MOVED_ZEBRA_DIM = 3,
>>       } color_moved;
>>  };
>
> Hmph.  I would have expected that COLOR_MOVED_DEFAULT would not be
> part of the enum, but a
>
>     #define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
>
> I do not have a strong preference either way; it was just a bit
> unexpected.

Yes it is not as one would expect.
Originally I thought it could buy us some more protection via
smart static analysis (to be invented yet), but now I am not so
sure any more. Changed it to the #define.

Thanks.
