Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A288B1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 18:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeKMEBo (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 23:01:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33238 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeKMEBo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 23:01:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id u9-v6so10430638wrr.0
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 10:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M/3tD5C5oHWluUTkBGFpDXa6xt6KNreXZpyOsPq+z3A=;
        b=dNS1DR4ILJvO85ORtPS73pq7EUt+RUsjZfKLrR5RG7BY8BRRaWox3UZ+oucCyyCxxT
         UO4sdUbfaH6DQG88RyH36brsHhchUENyVB9e5NtI4FKRgnraj15gm4KPxHhULE2LyySe
         wvZbLAxnQviIuf/6/G6moYO7RbTZibv8SnEKoBuqzOHC1QOMMZHnF6ZKJe1fCSJc9lFQ
         rWbkqENqEyMe0ED3FGmFrrcKdqK1E1XShx2SjR1U6R0ZJgTI8g8aV7A16xy1Z7joseEC
         wDw9LOpAqWvwR5atZPe+CJeLxvZUc8MT/bJveQh/xpYpRW+yh/wcH6neaasX6CC1vPCr
         IBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M/3tD5C5oHWluUTkBGFpDXa6xt6KNreXZpyOsPq+z3A=;
        b=FqWR15jYsH2H9Hk7dAEGjOcMLrB7kbB+1P3+kCjHeWL2Rs6DH1qILtvwMCnzc8/4xW
         PqpW+qKfszMODXF75++J1HoKrPgCn6vHnEb8K8lF72xARSlU9//WT3ehQvt7QZpnCJ3x
         5hsR7RlPfoh3wws8QPehlukgGQ/Gh172il5YZLY1l3jpCbobVptj9KaM2kNDewg+ylsY
         eDX2WbHadj36VaOxClsUo2qUwpHwUAwdq4twaafyy7i22UV7WqsB87jw9vNW/1Vz5Q5J
         58MrfnE40gt3peq3MdsXKZyWoDK9aWGKHFnq2m9qY1Fka8hbT6r5boKCz8jm5PZCEsVI
         7ZzQ==
X-Gm-Message-State: AGRZ1gJzrH/ny+XcVzQV7zX1/440uhDvgDhmJlvacm2JnmOeV7gD0OHg
        uT+pM0XzFul4xEA1IJYf5s0=
X-Google-Smtp-Source: AJdET5cs2/0CD4iEKCJhw8i1/oJCipTB6/k9XbPWFUX3B/Dv8Mc5I1d0UfcEPWZO75GcquvmzQT6ag==
X-Received: by 2002:a5d:4cc6:: with SMTP id c6-v6mr2024751wrt.75.1542046043117;
        Mon, 12 Nov 2018 10:07:23 -0800 (PST)
Received: from rigel (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id z18-v6sm13563317wru.83.2018.11.12.10.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 10:07:22 -0800 (PST)
Date:   Mon, 12 Nov 2018 18:07:18 +0000
From:   Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, nbelakovski@gmail.com,
        avarab@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] branch: Mark and colorize a branch differently if
 it is checked out in a linked worktree
Message-ID: <20181112180549.ojt3twhsfm5xkako@rigel>
References: <20180927204049.GA2628@rigel>
 <20181111235831.44824-1-nbelakovski@gmail.com>
 <20181111235831.44824-3-nbelakovski@gmail.com>
 <xmqqo9au1tsj.fsf@gitster-ct.c.googlers.com>
 <20181112121423.GA3956@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181112121423.GA3956@sigill.intra.peff.net>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 07:14:23AM -0500, Jeff King wrote:
> just adding a bunch of color variants. It would be nice if we could just
> do this with a run-time parse_color("bold red") or whatever, but we use
> these as static initializers.

I suggested those colors, but now, I think this needs to be
configurable.

I suggested using green and dim green as the obvious theoretical choice
but after using it for a while I found out that both shades are way too
similar, making it really hard to tell by glancing at the output,
especially when they're not side by side.

If we continue with two dual green approach, current branch needs to be
at least bold. But I'm not sure if it's enough.

I've been trying some other colors, and cyan feels neutral-ish.

I think:

    GIT_COLOR_BOLD_GREEN  /* CURRENT */
    GIT_COLOR_CYAN        /* WORKTREE */

makes an ok combination.

But I can see where personal preference starts to play a role here, as
the logical solution isn't good enough. Which makes the case for being
able to configure a bit stronger.

Cheers,
Rafael Ascensão
