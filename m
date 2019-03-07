Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DE6020248
	for <e@80x24.org>; Thu,  7 Mar 2019 16:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfCGQsF (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 11:48:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53957 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGQsF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 11:48:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id e74so9929586wmg.3
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 08:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0jh4hfAQiichgmLU8mrWfF32ES5mJ325fx6GUJbsgw=;
        b=r1d+aiLTLuazNebhowjbz53tyus3EQBTSNEiEaA/IyThYv32NWI2hRqUOMHW5/43+2
         7vT5zR/9f1AWQm98BltXrzNWzUcMb4ZYfHV0fqMHvEhAPciKj+oeDLyOG+uyaIZIUQLF
         WKjgWjAmfMButlFp4deFibgZWRDQhS1IEGP/muKUoI5xfs5VPzPetqLcEZJwV3ktyfz3
         3Tx4sB3VHuo3W0QMWchGVOkmIDut6yTEsW3Evoiol+FXwod613pgzKklXF64JCUvJPCx
         AMkcy4qrV4KcBzX03xD/3VtqevlS+FHAZECNI9Nhz79cq+TLFmtvUcc46thqbaegsiOw
         PCag==
X-Gm-Message-State: APjAAAUwtxJxK1vQ8WUIykG/RCcw5YzdSCmU9EGMZ0NHcbnRAmK4pWpz
        EH7sn4IaJhhePGiBtKC4Q6sqiqV7mW7D0mobTS4=
X-Google-Smtp-Source: APXvYqxY1+Jp5otmGXOjQoDqMgL1ERnGKXFwTARNo20zGXwxfJMA0HfOLVJJCC13NTKFRLycl5n9yKwJWox/1i1Q2HU=
X-Received: by 2002:a1c:730d:: with SMTP id d13mr6274498wmb.37.1551977283518;
 Thu, 07 Mar 2019 08:48:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.158.git.gitgitgadget@gmail.com> <6407430da7f75cb2385d243c9820ac8c2ea7fee3.1551952855.git.gitgitgadget@gmail.com>
In-Reply-To: <6407430da7f75cb2385d243c9820ac8c2ea7fee3.1551952855.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 7 Mar 2019 11:47:52 -0500
Message-ID: <CAPig+cSTtn6ON3rMeno+0ikOER6gq2bF=ktC-ehcaCo1pMd3MQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] rebase: deprecate --preserve-merges
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 7, 2019 at 6:11 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> We have something much better now: --rebase-merges (which is a
> complete re-design --preserve-merges, with a lot of issues fixed such as
> the inability to reorder commits with --preserve-merges).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> @@ -427,9 +427,10 @@ See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
>  --preserve-merges::
> +       [DEPRECATED: use --rebase-merges instead] Recreate merge commits

s/--rebase-merges/`&`/

> +       instead of flattening the history by replaying commits a merge commit
> +       introduces. Merge conflict resolutions or manual amendments to merge
> +       commits are not preserved.
