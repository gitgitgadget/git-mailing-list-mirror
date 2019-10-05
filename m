Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6181F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 19:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfJETer (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 15:34:47 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44452 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfJETeq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 15:34:46 -0400
Received: by mail-vs1-f67.google.com with SMTP id w195so6330561vsw.11
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 12:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKhYDuGcfpbWYKvwtv49kSYlWnDzf3dlqxGMopJWv1Y=;
        b=t4u0gvfCSWc9F5ZkQx8asJLF9oup2a8YyvTJt0OgJ+9dhu8043Uc2QYfvFTdw59H5q
         23A6hSItrA4qVi+i7N4sU9mNjRysVCnFw2zg07Uz5r3CsG5ss8gvV+NOuTf2wdujPavS
         Cf05aiPVJHmRY5/kChVkMCr3PvwYfajWZDAPLjACqlt3kEeayomJoLw5Dd+s5gq5/A35
         3RZdTZrO3sDYNkNlCWzlADgnMUKrmd2jiDKOb4g1fibjB+DfbEbRlDR9EkJXmC9aZDTi
         Q4ITLuF97Aw8xSIDSxEKst5dnUISjsdKTJVjXJtB1EmMXOSZAUrAe9B0yYpzbDQCZi77
         QXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKhYDuGcfpbWYKvwtv49kSYlWnDzf3dlqxGMopJWv1Y=;
        b=E2J8TmcuoJKsYSoaSUMIuguj7yNg7Fuwfj0a3sKQDXGZ3IdBu+iwFy1cW/RSKQRuTd
         uJCT/LfhIUGPab5GxfVq8t4YVU95HiGGe/WVny0arJMWaHRNNoJ9lZrKXQ3/GcrzJif1
         y+uX5l4ce4M0oKnO94xvE9GDSZqLkZ1V/b3S8IZHLgGXa0FYK+R+LiuCamLnYdlW/76l
         P5euAk+Wuqw0NaKPn9oKSadKncgYT1U9LRHyehnZKLSllYP4RybgeKqqhNIBPswpUJDh
         vPTBuPkmWHlV8NqUeabmg7y0OyQBi0x69Jjn0dpFTMKsa2uBQYhnkyJQNOUtuBFnFrMM
         0xBQ==
X-Gm-Message-State: APjAAAV/i1TZZQnCQ7qAfn2ibkksIvGD8K3ZCLOwhNOORd6aeNH5L5JS
        lnjXnjra2l41OIz4i+vfchrUSvK1MXKOSHmeT90=
X-Google-Smtp-Source: APXvYqxU2lv83iiE5anbqNET/KmBpwo3C3wfXlvGHoYcNguogPtyRc48W3shdzqZxc2O3k1As4mjNq2FzP47ws2PjIA=
X-Received: by 2002:a67:f502:: with SMTP id u2mr11302448vsn.117.1570304085478;
 Sat, 05 Oct 2019 12:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <pull.316.v2.git.gitgitgadget@gmail.com>
 <412211f5dd6d4d995f258403bf377bc0cb6332b4.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <412211f5dd6d4d995f258403bf377bc0cb6332b4.1568904188.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Oct 2019 12:34:34 -0700
Message-ID: <CABPp-BFV7TA0qwZCQpHCqx9N+JifyRyuBQ-pZ_oGfe-NOgyh7A@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] sparse-checkout: create 'init' subcommand
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 3:06 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Getting started with a sparse-checkout file can be daunting. Help
> users start their sparse enlistment using 'git sparse-checkout init'.
> This will set 'core.sparseCheckout=true' in their config, write
> an initial set of patterns to the sparse-checkout file, and update
> their working directory.

...and ensure extensions.worktreeConfig is set to true.

> Using 'git read-tree' to clear directories does not work cleanly
> on Windows, so manually delete directories that are tracked by Git
> before running read-tree.

I thought you said you fixed this?  It appears to no longer be part of
the patch, so I'm guessing you just forgot to remove this comment from
the commit message?

> The use of running another process for 'git read-tree' is likely
> suboptimal, but that can be improved in a later change, if valuable.

I think it would also be worth mentioning that not only is a
subprocess suboptimal, but the behavior of `git read-tree -mu HEAD` is
itself suboptimal for a sparse-checkout.  (We either need more error
checking e.g. when the user is in the middle of a rebase or merge or
cherry-pick and have conflicted entries with a more focused error
message for the user, or we need a command that won't abort if the
conflicts aren't in the paths we're trying to remove from or bring
back to the working tree.)


Patch looks good to me, assuming the caveats of using `git read-tree
-mu HEAD` are better documented -- and hopefully addressed at some
point.  You addressed all my other feedback on this patch from the RFC
series.
