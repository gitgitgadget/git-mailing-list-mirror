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
	by dcvr.yhbt.net (Postfix) with ESMTP id C7C741F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 23:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfJLXAx (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 19:00:53 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40925 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfJLXAw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 19:00:52 -0400
Received: by mail-vk1-f193.google.com with SMTP id d126so2853365vkf.7
        for <git@vger.kernel.org>; Sat, 12 Oct 2019 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ou2QMGltTvHpdJzBpnRQGyoRi0/ZiPZab15Yj2kTjbY=;
        b=DdUBpGJqVjVralpiI2N3LNEUJfWgp9mM9JRdM7mitdE0h9sXjRlZ1ckeB826Lx4epK
         Mc8Cen41daIzO+UyjDYoNaBV0zz9mwJyPGxKJj0zIozXu4302+mDuKcpMRfIIDcWqnp7
         fOL4hiruZA9VHdJ12BdbN66pJplamY2PBFKlph0+0fEadRyAznDa5fGTRxf4ld0/xyVH
         lEAc1cj4cPGuS11X+r0oFKI0/zpbIMHCiYpSZW4KapBP1oDd7c3VNz6VJwkXr3oXiEDU
         dmk7URyE9HQjwaTegNHkcVYsvvSGNJyFB1CsBwW+URaVrnkALifE32ph45bS1s5XWbfg
         5tsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ou2QMGltTvHpdJzBpnRQGyoRi0/ZiPZab15Yj2kTjbY=;
        b=Vhy6I3xcaREydhzeZwOJ9P6X4gSr7PKqLWPA3sMggBYOweVwDnc7maDg7WMa0elsc4
         +j2t2H4Jg2tV/RcvwB++F44bmz9TAiOEvyjPRCMzYwddqeY889lqaL3ejWnpiBBkSQrr
         Slc9Blwj+xvg4RbfqfZ1XXaMosFwiF/T6ks/3l2JXgyrOfxXj1TX7TZRPo5DY/Kc/Q/C
         uqXgngNLWXW9T7ZBxr3xfazx0GhNVJNYW6EkjdTQzwAm5DrT/X5/mUp8Kts0gAWOEBwU
         I/F0jnN2IJvCdwK4ZVKj3yctXuuylBgIIJGTFkBL9Vqni2fsUpyHhterkE1L9PzMhRdN
         PXuQ==
X-Gm-Message-State: APjAAAVa6fEMnjXYL2QiwXRFJUYa5ypsp1JLHWjr38Glu0Ik4uLFJV1r
        msf+Tj9Enie4QHcB8o06H5TBorlJTD0CuUAnOliF0Jv4
X-Google-Smtp-Source: APXvYqzL2esddypCDbeZcTwdf+fxF75L1ZWC/jncyjgJVLoizyQ2JkTMoI2VlC6N3sOi6BEsd/bpbytnjFAlGl1Ka9Q=
X-Received: by 2002:a1f:b2d6:: with SMTP id b205mr12465453vkf.90.1570921251532;
 Sat, 12 Oct 2019 16:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.v2.git.gitgitgadget@gmail.com> <pull.316.v3.git.gitgitgadget@gmail.com>
 <7f377c1407274aec87c6261f05bb9a944b659ba0.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <7f377c1407274aec87c6261f05bb9a944b659ba0.1570478905.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 12 Oct 2019 16:00:40 -0700
Message-ID: <CABPp-BHs+c83imzHUHarsJhFsNUQNkPCkDHLX8KH-2CJztGdGA@mail.gmail.com>
Subject: Re: [PATCH v3 17/17] sparse-checkout: cone mode should not interact
 with .gitignore
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 7, 2019 at 1:08 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> During the development of the sparse-checkout "cone mode" feature,
> an incorrect placement of the initializer for "use_cone_patterns = 1"
> caused warnings to show up when a .gitignore file was present with
> non-cone-mode patterns. This was fixed in the original commit
> introducing the cone mode, but now we should add a test to avoid
> hitting this problem again in the future.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1091-sparse-checkout-builtin.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index f22a4afbea..ed9355384a 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -269,4 +269,11 @@ test_expect_success 'fail when lock is taken' '
>         test_i18ngrep "File exists" err
>  '
>
> +test_expect_success '.gitignore should not warn about cone mode' '
> +       git -C repo config --worktree core.sparseCheckoutCone true &&
> +       echo "**/bin/*" >repo/.gitignore &&
> +       git -C repo reset --hard 2>err &&
> +       test_i18ngrep ! "disabling cone patterns" err
> +'
> +
>  test_done
> --

Makes sense; thanks for adding good preventative tests.
