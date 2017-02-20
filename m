Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7789A201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 14:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753555AbdBTOVz (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 09:21:55 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36852 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752691AbdBTOVx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 09:21:53 -0500
Received: by mail-qk0-f178.google.com with SMTP id x71so30293841qkb.3
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 06:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1twF/DPTjhdEsooHcpkCbbOQLTWkqOwNrwwzhqbkmIQ=;
        b=a5CWAtdv7smQFPNu3cY4fBX/uUFAvfufT3V63gPyEB5ZqOHkhb/5ex0THZzwo7WOlF
         3yfZfNGbK3eTRbsBwYwB6AxoJwauq0raqdAZ/MbojaapKcPasSEUZcRaY0+3+yPdgFRj
         qRu+5gTSw5OQT+8Z5lRHZuvuCmfONaKpQCsykbfuBQXn7yaUJlFTEMyVQdntovCP6itI
         NH4NLrfWdyXAIg74A6OGZg0XLbbs6x+ywRRIKoV73bcHDJR2sBkj89Ci8Kg+9G/mBEka
         nl+GHe17i1Po6X21uteaj33BQstSocmrmqHZpoMx4zQWC7UKrRn7r8jNgn0npYRLyteI
         4JEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1twF/DPTjhdEsooHcpkCbbOQLTWkqOwNrwwzhqbkmIQ=;
        b=hXYaMRLfllQM7DOx6sq9ssGkvugLGZKoGlZGL8IXCb5LiTmSpnpEwOr3CMUEBa3FRL
         UdUo0XU7t4dzdGxXvIxvHdjbHugysqIhvuwDVd5bHysX63RkxJWJ2AI1Pja+lxVFaVy3
         ABBJO4rfJH8NPhIQAy4bl6XUKUrRY7/LWG5zGlRsjPVmzp23nxJfWCCNX2hRPHMM9tGP
         b1VZ63p5pPZrw7rt1rXm1FJku3HK3CCBBFyaSTWEV0/W/hj/0308pGMgG6ELmoJW0DCI
         Mx/xHnvn9q+QX+g7sbBUKCp0y7tt8E5ZCLLRRQPUD26Plbx9ViT018+fq8OXc2MZsqkt
         ucgg==
X-Gm-Message-State: AMke39mjtSBt/mn0hjYEPLq7mrXvCY2ZTAeXt5YqNNoMw7bPzT9nih781yD+oAgPWJs2pTjGjh81rJeIISccBw==
X-Received: by 10.55.159.214 with SMTP id i205mr11631497qke.94.1487600512543;
 Mon, 20 Feb 2017 06:21:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.106.138 with HTTP; Mon, 20 Feb 2017 06:21:12 -0800 (PST)
In-Reply-To: <xmqq8tp6x8b6.fsf@gitster.mtv.corp.google.com>
References: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
 <1487258054-32292-5-git-send-email-kannan.siddharth12@gmail.com> <xmqq8tp6x8b6.fsf@gitster.mtv.corp.google.com>
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
Date:   Mon, 20 Feb 2017 19:51:12 +0530
Message-ID: <CAN-3QhoXBnLWyfuUsuvvRMYNnoupMrQHxE_G=ysyA_14KX4Yrw@mail.gmail.com>
Subject: Re: [PATCH 4/4 v4] sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Jeff King <peff@peff.net>, pclouds@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17 February 2017 at 00:38, Junio C Hamano <gitster@pobox.com> wrote:
> Having said all that, I do not think the remainder of the code is
> prepared to take "-", not yet anyway [*1*], so turning "-" into
> "@{-1}" this patch does before it calls get_sha1_basic(), while it
> is not an ideal final state, is probably an acceptable milestone to
> stop at.

So, is it okay to stop with just supporting "-" and not support things
like "-@{yesterday}"?

Matthieu's comments on the matter:

    Siddharth Kannan <kannan.siddharth12@gmail.com> writes:

    > As per Matthieu's comments, I have updated the tests, but there
is still one
    > thing that is not working: log -@{yesterday} or log -@{2.days.ago}

    Note that I did not request that these things work, just that they seem
    to be relevant tests: IMHO it's OK to reject them, but for example we
    don't want them to segfault. And having a test is a good hint that you
    thought about what could happen and to document it.

[Quoted from email <vpqa89mnl4z.fsf@anie.imag.fr>]


>
> It is a separate matter if this patch is sufficient to produce
> correct results, though.  I haven't studied the callers of this
> change to make sure yet, and may find bugs in this approach later.
>

-- 

Best Regards,

- Siddharth Kannan.
