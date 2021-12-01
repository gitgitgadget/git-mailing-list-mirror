Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6547C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 05:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbhLAFHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 00:07:25 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:41517 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbhLAFHY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 00:07:24 -0500
Received: by mail-pf1-f174.google.com with SMTP id g19so23079828pfb.8
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 21:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wz9PK5nKnEYf68ojDD7bVClbmeHBiKeSowWFcnkPy+k=;
        b=P/CuESurnF+DlbLVog2oqX49DqV90lEBsUE0SRDOtuv+jeni7ueP7BT8IMKh7BD0iw
         RTtyI+2gaSuOXxBibFagi7yGmotPHfbH6SBIJbioSvTG8XXl2XQV3IAMPt5NBohPNemU
         nn9UQFOl+qdtHNsd73udFWhxa+bgfjwjp+72f4atgtg4GY9yzR+hJ51PVFAAn4azeT/D
         XZFZhRmpM95dNsiHj8K3jzBsRBReC29jlKDqBnHdNqVKf5Kc3eU+BUBFoXaM7ZfQMV2V
         udizWu7SMtic88I261igZxmYxXY+wPAmM9UEClHcYL9qbUNWm+gY2UK+04ciTF9/XuxW
         fqtQ==
X-Gm-Message-State: AOAM532UeNzTrpoKxq4wfpruJXR3lIFDEEdgzrVS0FGyMndM+TJ8ruXf
        vOrIdzsE9nGuf32KOi5pHkI35+/33c5CHLAR59Y=
X-Google-Smtp-Source: ABdhPJyu4x4gA9nvrcq8hWhrmw+pSUoAluEzoj4kOuB7QGpriMchJ7RSDHwRPOoUdWIoYybC67sb4+VoSOVpkmKuH6o=
X-Received: by 2002:aa7:9561:0:b0:49f:c8cd:ce6d with SMTP id
 x1-20020aa79561000000b0049fc8cdce6dmr3620402pfq.67.1638335043863; Tue, 30 Nov
 2021 21:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20211130204333.174967-1-greenfoo@u92.eu>
In-Reply-To: <20211130204333.174967-1-greenfoo@u92.eu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Dec 2021 00:03:52 -0500
Message-ID: <CAPig+cQg=P1BNCwfmNAE3oHZHh4CPJ5QNQh-vgfOQDGGwenMow@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] vimdiff: new implementation with layout support
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        rogi@skylittlesystem.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 3:43 PM Fernando Ramos <greenfoo@u92.eu> wrote:
>   * Use "$" inside arithmetic expressions $((...))
>     NOTE: "shellcheck" issues a warning stating that "$" is not needed inside
>     arithmetic expressions.

Just a side note: I understand that [1] recommended adding the "$"
inside arithmetic expressions, but by chance I happened to be browsing
the history of CodingGuidelines and ran across 32b5fe7f0e
(CodingGuidelines: drop arithmetic expansion advice to use "$x",
2020-05-04) which dropped[2] the recommendation to use "$" inside the
expression. Anyhow, certainly not worth a re-roll.

By the way, since you've removed Bashisms, do you still need the
`#!/bin/bash` at the top of the script?

[1]: https://lore.kernel.org/git/CAJDDKr5KZK3wpox6FJPOL9koPr=k5+qTzZtPPFEmg4iZsvwoog@mail.gmail.com/
[2]: https://lore.kernel.org/git/20200504160709.GB12842@coredump.intra.peff.net/
