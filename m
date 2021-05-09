Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B491C433ED
	for <git@archiver.kernel.org>; Sun,  9 May 2021 22:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC01C61004
	for <git@archiver.kernel.org>; Sun,  9 May 2021 22:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhEIWEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 18:04:10 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:36697 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhEIWEG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 18:04:06 -0400
Received: by mail-ed1-f50.google.com with SMTP id u13so16447969edd.3
        for <git@vger.kernel.org>; Sun, 09 May 2021 15:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=038M37boaxWsawh+e59AzfZXirJdNFGqvMC0H8+gtmA=;
        b=l7NsiTkrw9KyWGj8HwCO6Aseh+DOrRHES6tYxJIT4JUhdHzn3VJputQiotNrO8sM+n
         r+FsQH4IMefFtbPEPHX/wBtM5hgT8KDuK1b3w7JnBYkeauMw6g3OLt2a8fZmPoXt8nC7
         SyVmQNto+PB/tyY42tsjAcNuMC42zITLoCL28xDRpTXRbQlnYx4CBFKTHhH9ET+8PKdu
         UAwnT/LHpUTT25vAAJ8rKyv6w3pZuLQa9q5w2WiIL36EMhObXzKnJ0UE01rzmq8wM0Ml
         CQJTPXpUCFh18AKfV4m22umzRzo5KaeBR3CcH4myAo7AVYw7X7UPPuFO2ZUmaGroZwp0
         rIog==
X-Gm-Message-State: AOAM53327HgaY5usR810DY8eRYvh9qcBSkPdM1UB19sHwEfdtvuzN9G5
        ObL1/w6w2gTYNPlzMeaWz8ZRg5XmnlbdL6nCVD0=
X-Google-Smtp-Source: ABdhPJwhY6pS8SGj85OBfGWOxi0qgCRY1h3ioGvD/jq2+YoTPKhKE5ntKcuCyRCyZyu2h/v9b8EobrADyZq81Qcr9Is=
X-Received: by 2002:aa7:c412:: with SMTP id j18mr25880664edq.163.1620597782124;
 Sun, 09 May 2021 15:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210509212220.29557-1-alexhenrie24@gmail.com>
In-Reply-To: <20210509212220.29557-1-alexhenrie24@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 9 May 2021 18:02:51 -0400
Message-ID: <CAPig+cTm7rW7V2DasW2XTArHAY_91rxxm5QaF31U8rB1ZLXOvQ@mail.gmail.com>
Subject: Re: [PATCH] graph: improve grammar of "invalid color" error message
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 9, 2021 at 5:23 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
> Without the "d", it sounds like a command, not an error, and is liable
> to be translated incorrectly.
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
> diff --git a/graph.c b/graph.c
> @@ -95,7 +95,7 @@ static void parse_graph_colors_config(struct strvec *colors, const char *string)
> -                       warning(_("ignore invalid color '%.*s' in log.graphColors"),
> +                       warning(_("ignored invalid color '%.*s' in log.graphColors"),

Another possibility: "ignoring invalid color ... in ..."

Even better: "invalid color ... in ..."
