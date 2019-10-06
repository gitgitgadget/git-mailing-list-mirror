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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5438C1F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 04:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfJFEOJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 00:14:09 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34767 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfJFEOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 00:14:09 -0400
Received: by mail-ua1-f68.google.com with SMTP id q11so3144989uao.1
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 21:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBgTNZGwYBz4/7cSWa+AgYwUi4+XzsUtFpqJy0X2arA=;
        b=S0AW8r0tFuyogOc5ICsj2A7JETX9vQUlz6mMFnjd1F3h73EuPM4aZI7qZfpklJ1s+3
         d87aVW6BhiChumooqaQuu/N/Ztav/ttK0x2SVOH2Cd1hG+8DAv3ErOSojvn6MOaLVUPh
         piOZjiyMu4O3ntZ7USxJN6RzZvT8V8UzaAgwemdETHtC9b9ppMwFowc5+uiCvRyt+paW
         eRUqd8fCzqGyGkKrfD2LT7z11q0X/5AdLB2KuQ0r7S7cvt/zaCe9AlVhslvjA1f5S/BB
         +RMQCZCvuBTvXfv/1vfHHR1OGR6hwvAywafnytniVMSI63eMoo3lWQq8JAc4i6gDDE8f
         dhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBgTNZGwYBz4/7cSWa+AgYwUi4+XzsUtFpqJy0X2arA=;
        b=PsT7SPzETFCfBj4ZX9I1Ri0vCpeJWU38nWo1m18zJig1Q0vLFTSOb6Spzk1TVSFqLi
         xfEtNZpMuCI9GA+1IJ4tjldSbnjOYO9D8duy8dUYieAqJ4PDqTsJRj5Csjc49WAfaGpE
         BmEzSqVOTkcwxxir1g3f63X/FM0Bez0NDBl6+V/binXhZKp8OpseU8Y1CE319J5gckbi
         /Asme+6HYuUcF5jBqDd4+E0Heu4GHJBiyiBWWU4wYZqa9CBQhBbeJ6x/LTIa7EYUYjNM
         CZnA6TGtkIKVSwmw2kyR6NkNXFcu5/yTbwj6lF5nQd7xc6Z0epdOIAKiBsXy74fBpmkW
         d9cg==
X-Gm-Message-State: APjAAAXJJLGyNCGdEp4WltLcC5ACfRhO4hYm3HB+PLJ7L50BgEGgY6pZ
        TLnVr47IELstC+LB6TqKCVP1P/xFloiS+nb45lw=
X-Google-Smtp-Source: APXvYqw3DfbfVkosHZ/4veqLddh4Rp0pm8P6obP7tH2tNqKzc18P07UseWnKnUBMfoU6VQIcFbmdf08Fo7ER+0v5uvU=
X-Received: by 2002:ab0:4891:: with SMTP id x17mr621650uac.87.1570335247974;
 Sat, 05 Oct 2019 21:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <pull.316.v2.git.gitgitgadget@gmail.com>
 <25642f8df28825cce61812a24cbd87bf7cb2025f.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <25642f8df28825cce61812a24cbd87bf7cb2025f.1568904188.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Oct 2019 21:13:54 -0700
Message-ID: <CABPp-BFmUOoQJ6nepb9AHGcjRU+-mHvFH8TB2pP17e1C0djxmw@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] trace2: add region in clear_ce_flags
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 10:15 AM Jeff Hostetler via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> When Git updates the working directory with the sparse-checkout
> feature enabled, the unpack_trees() method calls clear_ce_flags()
> to update the skip-wortree bits on the cache entries. This
> check can be expensive, depending on the patterns used.
>
> Add trace2 regions around the method, including some flag
> information, so we can get granular performance data during
> experiments. This data will be used to measure improvements
> to the pattern-matching algorithms for sparse-checkout.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  unpack-trees.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index cd548f4fa2..26be8f3569 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1404,15 +1404,23 @@ static int clear_ce_flags(struct index_state *istate,
>                           struct pattern_list *pl)
>  {
>         static struct strbuf prefix = STRBUF_INIT;
> +       char label[100];
> +       int rval;
>
>         strbuf_reset(&prefix);
>
> -       return clear_ce_flags_1(istate,
> +       xsnprintf(label, sizeof(label), "clear_ce_flags(0x%08lx,0x%08lx)",
> +                 (unsigned long)select_mask, (unsigned long)clear_mask);
> +       trace2_region_enter("unpack_trees", label, the_repository);
> +       rval = clear_ce_flags_1(istate,
>                                 istate->cache,
>                                 istate->cache_nr,
>                                 &prefix,
>                                 select_mask, clear_mask,
>                                 pl, 0);
> +       trace2_region_leave("unpack_trees", label, the_repository);
> +
> +       return rval;
>  }
>
>  /*
> --
> gitgitgadget

Thanks for the updates to the commit message, and the tweaks from
"exp" to "unpack_trees" in the patch.  I still don't know trace2, but
it's much clearer how this relates to the series now.
