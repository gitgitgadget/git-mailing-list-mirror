Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3D31F403
	for <e@80x24.org>; Sun, 17 Jun 2018 17:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753321AbeFQRQK (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 13:16:10 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:44647 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbeFQRQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 13:16:09 -0400
Received: by mail-yb0-f194.google.com with SMTP id w74-v6so5176840ybe.11
        for <git@vger.kernel.org>; Sun, 17 Jun 2018 10:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PdQkf999oZYf2r3FbWxmCY98A14symfFknZxDRgV5sc=;
        b=BsGLSMdVic00vyquOCcEZN6LU+VCQU7FfcB/euVp6F/dhGs1wi063DjSEKhkwOYmqa
         D8iDFuGJDmzUk/k4TqzLLh6TowpWC47x564ZjZn00fgb2lB5NMTv0UjpkKgaNLgqYetJ
         WvUpbawq7VqZUFQQ9ZwGgf1yEQvrMgrs+S5jz14y7Nfyk3O0hknpxa9zZJspItdDJsPM
         e7pLskvdpDOdLPO+VHSq18o02PkwxyoKTFuYdPMcp9dEYBiH7ILVbd/IHYbWAO1NQ6dV
         d+VOsvGcJReChi7JQNO2jAnfJGPFOJtSbzdF9C1joaeVfhlWQzAoxR1L6kQ0ozmuN/PL
         1BiQ==
X-Gm-Message-State: APt69E0LRUI4fpGyHSzRKgqUiuxwMuw4m4cGIViTypW+SpaL4yyAFgzo
        2sgL1VNmGMfHYtmk/wVQh+6C3naw0GO3+aURGSk=
X-Google-Smtp-Source: ADUXVKIpovgZrklB92EyAWpUPVsWQoE5zlEfk49Ipiff/OBaXeV6Hfs/8y/dx5hPjGQ0nXDc8jdeyqQGuaO/mamli/A=
X-Received: by 2002:a25:83c6:: with SMTP id v6-v6mr4983187ybm.263.1529255768524;
 Sun, 17 Jun 2018 10:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180607050654.19663-1-newren@gmail.com> <20180617055856.22838-1-newren@gmail.com>
 <20180617055856.22838-2-newren@gmail.com>
In-Reply-To: <20180617055856.22838-2-newren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 17 Jun 2018 13:15:57 -0400
Message-ID: <CAPig+cScoXgSrGQseX_u8SaXo1J-beb-fpZpF8V-rpwH5s-AUA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] git-rebase.txt: document incompatible options
To:     Elijah Newren <newren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 17, 2018 at 1:59 AM Elijah Newren <newren@gmail.com> wrote:
> git rebase has many options that only work with one of its three backends.
> It also has a few other pairs of incompatible options.  Document these.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> @@ -487,6 +510,51 @@ recreates the topic branch with fresh commits so it can be remerged
> +Flags only understood by the interactive backend:
> + [...]
> + * --edit-todo
> + * --root + --onto

What does "+" mean? Is it "and"?

> +Other incompatible flag pairs:
> +
> + * --preserve-merges && --interactive
> + * --preserve-merges && --signoff
> + * --preserve-merges && --rebase-merges
> + * --rebase-merges && --strategy

It's somewhat odd seeing "programmer" notation in end-user
documentation. Perhaps replace "&&" with "and"?
