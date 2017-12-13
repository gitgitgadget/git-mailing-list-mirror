Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4FC1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 16:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753337AbdLMQTA (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 11:19:00 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:41094 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753039AbdLMQS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 11:18:59 -0500
Received: by mail-io0-f180.google.com with SMTP id o2so3391017ioe.8
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 08:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gkJxtPPhKlcJE0GE1xcy89+EODS6aTMrvhMTgXasL8s=;
        b=CkyacjDjroUClxTHhy9Cx7lnokzRxMYlkUIGJXbEEpfBimRkPSSL4R+rMFo8N5OyEr
         SKKsarzmjyG/SiK0njkWwAwlF8+FeyKI6ZTAgH9dLd7oTiLwbGrIjg4qoWRUM/6+wSCy
         juOgztuuoPK7ASFnvBpGaqtoxd6nR/Kwct5obQJmnBBJMPDvzECP+8+ptHODzI15eHl7
         mxE4zN40Q9qPFOrEQz8+JnXd0RJ3VMKor+wxEQgvLe8P6g6ftzHJVuDgh4IHuHUqiloU
         fVcrAtvuPoLSyJfUYcP2dgYC7tl5/YSZkHPjHeXeafeCHYAjitl1bXSYXc7azUIhWAnZ
         qSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gkJxtPPhKlcJE0GE1xcy89+EODS6aTMrvhMTgXasL8s=;
        b=rwCF3P4V4N7arZUv2ll3adHiiEp3aENDd+e62TiAxxXkB6Lcp0+mdl84jKjIElyEa7
         TJEWxEkLGWoA8sPoVf5TkKlDSDMtaCIIk6q4gl9+ZO1A5aPeqhCKbDTvKe56vik0UFId
         vMQGnNdSHwOcLOFOesIBCEZ/VNAsyPi6fpWT9UYNM6AZoiNQooubyDGtRo8wzv/8g1cB
         HZC9tARzpA0Sx4dduywe1pOZpn8m/DywlTRw/+mCpUYhhHOYEGsg7zOcER9KZPVtXPKI
         kcXyyMeFwvq3uKZV7sh1/c82DSGw6QnVYy5ZpqDrUA+wj/ECIkQcBjzuYRiBFEVtnvOB
         jJkQ==
X-Gm-Message-State: AKGB3mKz4ahtGAPIGIcxAGNa0xGJAbrvShBAr/5TuwkMyYwoNf5gVbvq
        aqA+/j2z2TVz4D6lvAQwsX1oAFAMMEotPvHA6oA=
X-Google-Smtp-Source: ACJfBotuauLnUvolIcS0q5ILVunSZBIa6B5D3HfYuzF5xDhtZwJXfPeX1AlF4vAH84s3AyEo2AdDy+ZDQGHXvYsAD7M=
X-Received: by 10.107.20.21 with SMTP id 21mr3621950iou.116.1513181939258;
 Wed, 13 Dec 2017 08:18:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Wed, 13 Dec 2017 08:18:58 -0800 (PST)
In-Reply-To: <53BD7DB89F12403F974A7D2201CC7307@PhilipOakley>
References: <20171213151344.2138-1-chriscool@tuxfamily.org> <53BD7DB89F12403F974A7D2201CC7307@PhilipOakley>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 13 Dec 2017 17:18:58 +0100
Message-ID: <CAP8UFD3Q4h-aYBDABSPOW948LQYVydWZ1hLPAD+kr9ZpXVZiaQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Codespeed perf results
To:     Philip Oakley <philipoakley@iee.org>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 13, 2017 at 5:02 PM, Philip Oakley <philipoakley@iee.org> wrote:

>> The end goal would be to have such a server always available to track
>> how the different git commands perform over time on different kind of
>> repos (small, medium, large, ...) with different optimizations on and
>> off (split-index, libpcre2, BLK_SHA1, ...)
>
> Dumb question: is this expected to also be able to do a retrospective on the
> performance of appropriate past releases? That would allow immediate
> performance comparisons, rather than needing to wait for a few releases to
> see the trends.

Yeah, sure. For example in the perf.conf file above there is
"dirsOrRevs = v2.12.0 v2.13.0" which means that tests will be
performed on v2.12.0 and v2.13.0.
