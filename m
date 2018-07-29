Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D0A9208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 13:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeG2PPb (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 11:15:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38428 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeG2PPb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 11:15:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so10653204wmi.3
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 06:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JY36PZuWOgLtpAR91kOxVJ4aGlusRSe0dACWHH3CvF8=;
        b=ndforhf6fFPFLi4YwjOyqONqNMOSmCeLH4x1KxVPoor3aYiJO2XHB6t/lT8z+e4rYx
         ghod8uET7tToYD2sVZxi0kRCFgqiQwD2hPwlsL3ct5RLIIYU8iZNLNgqn897VsVY/z2f
         bDoUgpgzSRYHIRTRY4oafkP3WZ4zoAnJ9q2//pupYcmzhBRafTcNuGD4I+WO2RMkN4kT
         oa0WzdguqXTBDyqUf6fQrd2Kkx59cBRX/n6+CF7XsjV3ee5bdJy0N4ykOKmfjce15A/6
         hyAQTxwm+0c3pc3ovTkG1eNRKg9ENPXvtE3NwqDoSX/0Rus30oaGsOgSSYAZ7ef26bQK
         Othw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=JY36PZuWOgLtpAR91kOxVJ4aGlusRSe0dACWHH3CvF8=;
        b=fTvF4a8KYkrouTTXCrcGWLCyqUHA0KLBhBeXNGTiv/qRDbvmpsSJg1f9k3VDduTAOb
         998eYJ2jvg+v5ODy+/2xC3seOqR2eBhjE7qr6Zd4ep4kW3XMBEA6aXsBxljJ7BdzGs++
         U9y6Aai89VrXc8Vh2OXmztusS61I8FeOFQoO4Zuj1ByFgiJmtXKq0YJUw3daJvL1M41S
         3ONuqoOBfay4+F0f/Wj9X801m9YVrodp/E7mE4u8s7OLr7q/I2TMxm4uC5LuFnRiAG1a
         MubXnUwW6vIURG1WZbF66w8qBxO8UKl3+DlN90s5B+wdv//hpJEHgSvro6pZDPchgR0b
         rO0A==
X-Gm-Message-State: AOUpUlG2wQY5cGSRgUHIgOUfXbdKBguBQGDlIQTa+1wJ0J/PYFDL+ikJ
        lL2DBE45T0/SkIzD6XFqo4E=
X-Google-Smtp-Source: AAOMgpftBiPhhnk6RpfTjYTpbz16ZaMj+0dISH/7hHiwTsrg57iVLMFjjrBWK1DyqtskWMaPOLP3uQ==
X-Received: by 2002:a1c:6d17:: with SMTP id i23-v6mr12135726wmc.139.1532871898625;
        Sun, 29 Jul 2018 06:44:58 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egi236.neoplus.adsl.tpnet.pl. [83.21.72.236])
        by smtp.gmail.com with ESMTPSA id w23-v6sm4348199wmc.43.2018.07.29.06.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 06:44:57 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/8] commit-graph: update design document
References: <pull.11.git.gitgitgadget@gmail.com>
        <5e90d36f8482e03df842d483bfe6f237f0247166.1531926932.git.gitgitgadget@gmail.com>
Date:   Sun, 29 Jul 2018 15:44:56 +0200
In-Reply-To: <5e90d36f8482e03df842d483bfe6f237f0247166.1531926932.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 18 Jul 2018
        08:15:38 -0700 (PDT)")
Message-ID: <86bmaq88br.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> As it exists right now, the commit-graph feature may provide
> inconsistent results when combined with commit grafts, replace objects,
> and shallow clones. Update the design document to discuss why these
> interactions are difficult to reconcile and how we will avoid errors by
> preventing updates to and reads from the commit-graph file when these
> other features exist.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/commit-graph.txt | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

It would be nice to have this information not only in the technical
documentation, but also in user-facing documentation, for example
git-commit-graph manpage.

>
> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
> index c664acbd7..18948f11a 100644
> --- a/Documentation/technical/commit-graph.txt
> +++ b/Documentation/technical/commit-graph.txt
> @@ -112,12 +112,24 @@ Design Details
>  - The file format includes parameters for the object ID hash function,
>    so a future change of hash algorithm does not require a change in format.
>  
> +- Commit grafts and replace objects can change the shape of the commit
> +  history. These can also be enabled/disabled on the fly using

I think you meant "The latter can..." instead of "These can...", as
grafts cannot be disabled with `--no-replace-objects` option.

> +  `--no-replace-objects`. This leads to difficultly storing both possible
> +  interpretations of a commit id, especially when computing generation
> +  numbers. The commit-graph will not be read or written when
> +  replace-objects or grafts are present.
> +
> +- Shallow clones create grafts of commits by dropping their parents. This
> +  leads the commit-graph to think those commits have generation number 1.
> +  If and when those commits are made unshallow, those generation numbers
> +  become invalid. Since shallow clones are intended to restrict the commit
> +  history to a very small set of commits, the commit-graph feature is less
> +  helpful for these clones, anyway. The commit-graph will not be read or
> +  written when shallow commits are present.
> +
>  Future Work
>  -----------
>  
> -- The commit graph feature currently does not honor commit grafts. This can
> -  be remedied by duplicating or refactoring the current graft logic.
> -
>  - After computing and storing generation numbers, we must make graph
>    walks aware of generation numbers to gain the performance benefits they
>    enable. This will mostly be accomplished by swapping a commit-date-ordered
