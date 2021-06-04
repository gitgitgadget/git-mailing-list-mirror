Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1691C4743D
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 20:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B46613F4
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 20:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFDU6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 16:58:35 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:33742 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhFDU6e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 16:58:34 -0400
Received: by mail-vs1-f43.google.com with SMTP id f11so5563071vst.0
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 13:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ToTBHzGS/yu8Hg4o0QWLM3gHAwv2/77rR8KKvAZgeo=;
        b=Tl1WQRaape1h8ih/EP6zhsruP6ArhctRflV1S0QBrt9RvGLRe16wvD6EHLH7tUw4Jh
         YGYeB3c6RWYs0FXatoXwMZwZpjt0Anq+Lrphay3Cus0aKeb06uSh7LYeOUR7ZoFtPzJU
         SbsHYJg37O697ZXGXi0M815c4lOuckLoMMf4Gi+xj2fQ/Ji2d7Oa3Wcv53cFWURKTxMF
         0K81Q8QcagtGPYctoe3mdXM9wckH7/nEnIvLFhO+SkMnaL9xSuXONVbR33pK+bcCoU8b
         jMkpXI6uCyjJR5bsgAgLqAACupBFa9cSUJWSoxHHbZpBi8Or6nl5aw73eL+J2jfmT7Bl
         P9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ToTBHzGS/yu8Hg4o0QWLM3gHAwv2/77rR8KKvAZgeo=;
        b=Rp0BN72n4Ecr2C+ZwtS8Ryy44eiUFS8lr2Qhsx7c8vUa2sCkOqvYSrZzFjJVsqA+v8
         Y2d5A0W7HcHuY5sin5tX1G2Zt7SYN9jvx/LYtO5mlS3mZwdnoyxN2jLLr9we4Om5Eo28
         S1XHDNkmHXphGITZVB0NmF5sIqqHnS3azlNNhalvN4ysigvzP6vIjY/F2IRwFA+RZG3G
         Ihqs3ZGsZT9P0u9Vk8e9xYrPFMkMMyIZ6KtPYw5VoT8CXCtIBOwc6sfttkHMbfh07K02
         NOcXRrlpv67PrC8N9ka/iDAHr0JriYn1/pnzhTW7L79VegAPepuBA5hT8HRxb/DyCcu7
         ZIxg==
X-Gm-Message-State: AOAM533QiBTGZgl/DLwHqMEFsMXm3lcgSBszXWK1ZWzu+Ic7VMFUHHO8
        NYa8LzrCh4ARRFJsqlYQspjxU/dQ0AiyCTEl4lo=
X-Google-Smtp-Source: ABdhPJzDzMHcGDJ/wnqqQf5XwLqZ3mGgNh8XfAhwauGBROWYlpZpj6PxS2A+mwnWxGbSAcxJClzIpibBnSZ0qgAwGdw=
X-Received: by 2002:a05:6102:2008:: with SMTP id p8mr4351281vsr.53.1622840147085;
 Fri, 04 Jun 2021 13:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.970.git.1622828605.gitgitgadget@gmail.com> <3170f78daa5fa89f04f61e24c9c64c93ea5b394f.1622828605.git.gitgitgadget@gmail.com>
In-Reply-To: <3170f78daa5fa89f04f61e24c9c64c93ea5b394f.1622828605.git.gitgitgadget@gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 5 Jun 2021 02:25:35 +0530
Message-ID: <CAKiG+9UT+B-kFiY7sA8ZedB31xYARbFgSFwQRzktww_S2B_tfA@mail.gmail.com>
Subject: Re: [PATCH 1/3] cmake: add knob to disable vcpkg
To:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 4, 2021 at 11:13 PM Matthew Rogers via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> -if(WIN32)
> +
> +if (WIN32 AND NOT NO_VCPKG)
> +       set(USING_VCPKG TRUE)
> +else()
> +       set(USING_VCPKG FALSE)
> +endif()

I think it would be better if we could have an option for this knob.
Maybe like this

option(NO_VCPKG "Don't use vcpkg for obtaining dependencies. Only
applicable to Windows platforms" OFF)

I would prefer to use `USE_VCPKG`.

Thank You,
Sibi Siddharthan
