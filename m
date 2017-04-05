Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C3120966
	for <e@80x24.org>; Wed,  5 Apr 2017 14:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755220AbdDEOEK (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 10:04:10 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33900 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755182AbdDEOEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 10:04:09 -0400
Received: by mail-oi0-f42.google.com with SMTP id d2so16253455oig.1
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 07:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xpdAXzECFwiNfpRAGNCwRyJBCjDhBMSjHP8ugcCZfJ0=;
        b=UiHtI7qzKMGL1Svg9YLRxWFFnwFLAbnwcM5eGh2IjiqcQ51Mx88vD9Fg42SKQFWPDw
         WgQX1YR4k4hfRX4hQMDSZNULN/o3BoQw1JadGlMG8cVp1w4HautyCBjlBAEyzxhxlI3G
         ZMfd+e0pMcI5DT7nNNN5Xmmf9T3aBNIrvUrvUmsFTQ5KhqMCG/LBwSZqNW6hbTQoZEAd
         JRIoU3qAJcUsAZt2W5TiPIe7Rxh7pmVUVuJl2+bKdTtjp4URZWWshYldRCyQARf6iE1z
         TvD+EvETkqI9+5mkmRWEYwpyhScq1Ja4+0kzOmBs8fxKoSlYVx54E0B7Y/v6/HA/C1ch
         nT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xpdAXzECFwiNfpRAGNCwRyJBCjDhBMSjHP8ugcCZfJ0=;
        b=gn3nC9AlxH4wnHY4ofiqMX23jxOTf84muAUycPZ6swaF9dWa2qxVupTDK0Zb8cFX/4
         0qSVKv3OxGnSeAwtZ8vJqXY/o8oMr/vwb4/YlayWq8RdD9+Ah8CkREzWk+52I4pC9coj
         7XDAqkKa0oHy6YWu39hh4BeGHNbrOnmQVWlfKMh5sFExL5gKGbRK3ZKgiR7CmjUfDM2x
         udZaYu3tqjFNEJz0Q6Hv0f2FGu2dNvxl24SMl6wVbHPEttQbTo44qhZf83cb9lGvidrq
         jcgqqeD2eT6+jjnAM1t9FBTCj5MlCGICy5DA0xgHTLAO9jkceCKRmcwauEU3S8mZ20mR
         1IBQ==
X-Gm-Message-State: AFeK/H0IjRAf5o0jTZrQRbnFR70ROuPmm2/MkVhZz/98xeQC0mQoWTXie/SDiKW9ffcwnM2ORlOt9n/fHKTcUw==
X-Received: by 10.157.14.69 with SMTP id n5mr2773510otd.271.1491401048316;
 Wed, 05 Apr 2017 07:04:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Wed, 5 Apr 2017 07:03:37 -0700 (PDT)
In-Reply-To: <13eaacf0-5923-ad33-79ed-2cec47660904@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu> <xmqq1std1lmb.fsf@gitster.mtv.corp.google.com>
 <13eaacf0-5923-ad33-79ed-2cec47660904@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 5 Apr 2017 21:03:37 +0700
Message-ID: <CACsJy8BErEEmbq884XOvg=pQbcVhCkdmsaux58sMaNW_B0nSZg@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] Separate `ref_cache` into a separate module
To:     Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 1, 2017 at 12:16 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Duy, have you looked over my patch series? Since you've been working in
> the area, your feedback would be very welcome, if you have the time for it.

You probably have guessed my answer based on my lack of response :)
Tomorrow is holiday though, will have a look. But I doubt I would find
anything given that both you and Jeff are involved in this.

On Sun, Apr 2, 2017 at 4:26 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> I sent Duy some comments on that branch (an unused function and
> a 'plain integer used as NULL pointer' warning).

I still remember :) Or at least I vaguely remember something I need to
fix from you, and made sure comments in all my re-rolls are addressed.
nd/prune-in-worktree should be the next one, soon.
-- 
Duy
