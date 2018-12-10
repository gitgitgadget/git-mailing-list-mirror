Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C3D520A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 23:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbeLJXU5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 18:20:57 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35569 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeLJXU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 18:20:57 -0500
Received: by mail-vk1-f196.google.com with SMTP id b18so2962214vke.2
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 15:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=St+vL3EMyPJ5YjdT7bmlLhPsCKE02jwP0YtsDKRgoC0=;
        b=sQImxBwiL9UqhC4RuQoMt9+TD+BOUh6ti3I0Dut5i0hdKPkZmFd1DecYq2nRHNTVAf
         XywtkkX88guIPN7h99O7BqZ+3Lgb7vXmGDa7SUOwTNqzNLYBTYuPPuKA234XXMo6xqIy
         gR4Ua1xzMfIB/7M7C66ADtgfS8uKUl93tYx7BSiVfxF7WPWwYeETzfrGg/NUwCWX+TFw
         TbFLxGfeggBXJedDioU1KugSsdQY5xtbUdFTRChzKtvBnQBFElMZO0D96VGQ0gxeZC1f
         B1STO/MCWhTz13aFNVj7q2OfWwQgfSUXNR9IOuDbQhvBg+o7N9K61S9Dt2Y52xWiqC6G
         oChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=St+vL3EMyPJ5YjdT7bmlLhPsCKE02jwP0YtsDKRgoC0=;
        b=BIcj+XBqGDPpLHIq7VpydjR3kN+D5LOcs4wbrNZwjnBTyWgKQyYe/XJjbKU8z4twec
         xhzGZ9WjcL5vTgH0xF0mieFVB08Qg9M+ZlH0LHyqfJKXTJWsqbgHc5+ndYC1WYujunFB
         mjvtU+wqJgIdrrjJd3TshN8K1nf0BQWzI2lOV2aLBeFJioVczsI1kWnmJ3EGR65phBus
         LRxvqTAwMO1C0XW1xeIjwzp1VrLZkJd4ziUBBOCH4OQ8El9bmmDVlI2ypjPMJonGb5lo
         bNI4HegYcocFFocex6CZlda2P3qR1mFjtySxVPsjgzM2zHLsYmIhfxMpI5cjaQgB510/
         bFfg==
X-Gm-Message-State: AA+aEWbO1C6qwfQny/JDN+uXw03HE3F1TgAeusVUs/jSZIZI4YlRZw9+
        zUompbl4MlJ3wxo8IJelEfS35W2nRlVP5JCEJrCgyw==
X-Google-Smtp-Source: AFSGD/XMvRZHOIRIML74dVIGPpTIVyE7iMbMKupGoC9e4FrGg9OtNHww7L33ltDNicUnJrTVy9G47plPSC46b4EQFOs=
X-Received: by 2002:a1f:2d89:: with SMTP id t131mr5943426vkt.27.1544484056084;
 Mon, 10 Dec 2018 15:20:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.90.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.90.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Dec 2018 15:20:43 -0800
Message-ID: <CABPp-BGeDA=Cm6MYkrCK=pN94y9AKRHgknjyXN1oMfnSsTCnzw@mail.gmail.com>
Subject: Re: [PATCH 0/3] rebase: offer to reschedule failed exec commands automatically
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 3:13 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> The idea was brought up by Paul Morelle.
>
> To be honest, this idea of rescheduling a failed exec makes so much sense
> that I wish we had done this from the get-go.
>
> So let's do the next best thing: implement a command-line option and a
> config setting to make it so.
>
> The obvious intent behind that config setting is to not only give users a
> way to opt into that behavior already, but also to make it possible to flip
> the default at a later date, after the feature has been battle-tested and
> after deprecating the non-rescheduling behavior for a couple of Git
> versions.
>
> If the team agrees with my reasoning, then the 3rd patch (introducing -y
> <cmd> as a shortcut for --reschedule-failed-exec -x <cmd>) might not make
> much sense, as it would introduce a short option that would become obsolete
> soon.
>

Complete side-track: This email showed up for me just five minutes
ago, whereas the rest of the series showed up four hours ago, making
me think this email had disappeared and trying to figure out how to
respond when I didn't have the original.  Any ideas why there might be
that level of lag?
