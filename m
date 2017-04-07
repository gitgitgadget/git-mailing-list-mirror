Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C2320966
	for <e@80x24.org>; Fri,  7 Apr 2017 10:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753282AbdDGK5s (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 06:57:48 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36839 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdDGK5q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 06:57:46 -0400
Received: by mail-oi0-f68.google.com with SMTP id b187so11467646oif.3
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PtcrRszTy/QI0Iu7r/kyGOj6bioEnhlg0jTmR1fI0xc=;
        b=smk3OfLPqsrPqBZAFio0LFTdwybKAn49n3EOxNStNrUiZPw2JmY0Gl3V/A7bFGP0wj
         zngcmRwpHKwor1VmaV2jlICJxmfQxQnGa3uKa0p2ErNBz94pxWRRbiRomVLTiOsF9BS1
         v9WVyHJ1WEBbzUsLSAsZGAfhplgC7+pB509oNHLJRaHHNoca+Lo2ecJQ7pT/DEo2qmB/
         uGaHGCLQSxNC0kJM1s3iQS5UCLV0Vfhd+yRe84E34TwBVMPIlEuLtzQvkRQFjROSuIDn
         PxaxDpqENbNtqEE3d/YmUbhmbMV2+7fipp3h2V2vuM2TVLdFeRqd9BPal184X30WLNaF
         DZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PtcrRszTy/QI0Iu7r/kyGOj6bioEnhlg0jTmR1fI0xc=;
        b=Zxspou0WvtaEoYvYtklZfVomzyYdj12KBplHBmgo7oIwgY819hf8w67NyCJiNTl53F
         IxBAR+qF0Rwv1Ogpxpfpy9h7zqgXNquNMLVB6x/WEMOkvtZXvHyZM1qDlbLBAwd18FCT
         cm3elnuFe5NQxQ58HVhHzMxejGGOl6dZ6lXCNALV/17Y1WWZ/lGExuYofysETUrQ0qmi
         mQK3BCvlRHCrmmY/pSXp1iZLMnaMOu3EsXo+RjHrr8MkCxgfhuD0lvZeuVlYEP3Qdoxi
         //LPI29sO0h400QDB/9NnzyUYLKZv5HcOaKs1cPAeWXB1iVY3KqZg+41S+dqFXYWBaq9
         QS+g==
X-Gm-Message-State: AFeK/H0/IdDmVuyMwwpGpcRWgNpAvTy2A1BHFtXsHApOv0KNLK7/v5sZfQ4QMo4fdGPb3HfsVNPc60CYBdLugg==
X-Received: by 10.157.9.179 with SMTP id q48mr9814175otd.128.1491562665618;
 Fri, 07 Apr 2017 03:57:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Fri, 7 Apr 2017 03:57:15 -0700 (PDT)
In-Reply-To: <840b199ad58f11a690c684ad110807ed81d3b0eb.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu> <840b199ad58f11a690c684ad110807ed81d3b0eb.1490966385.git.mhagger@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 7 Apr 2017 17:57:15 +0700
Message-ID: <CACsJy8CECcC1EDpr8u39Pzq75E5KXrYwm_Bz+UTXobWvgV5weA@mail.gmail.com>
Subject: Re: [PATCH v2 03/20] refs_ref_iterator_begin(): new function
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 9:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Extract a new function from `do_for_each_ref()`. It will be useful
> elsewhere.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c               | 15 +++++++++++++--
>  refs/refs-internal.h | 11 +++++++++++
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 0ed6c3c7a4..aeb704ab92 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1230,6 +1230,18 @@ int head_ref(each_ref_fn fn, void *cb_data)
>         return head_ref_submodule(NULL, fn, cb_data);
>  }
>
> +struct ref_iterator *refs_ref_iterator_begin(
> +               struct ref_store *refs,
> +               const char *prefix, int trim, int flags)
> +{
> +       struct ref_iterator *iter;
> +
> +       iter = refs->be->iterator_begin(refs, prefix, flags);
> +       iter = prefix_ref_iterator_begin(iter, prefix, trim);

Off topic. This code made me wonder if we really need the prefix
iterator if prefix is NULL. And in fact we don't since
prefix_ref_iterator_begin() will return the old iter in that case. But
it's probably better to move that optimization outside. I think it's
easier to understand that way, calling prefix_ref_ will always give
you a new iterator. Don't call it unless you want to have it.

> +/*
> + * Return an iterator that goes over each reference in `refs` for
> + * which the refname begins with prefix. If trim is non-zero, then
> + * trim that many characters off the beginning of each refname. flags
> + * can be DO_FOR_EACH_INCLUDE_BROKEN to include broken references in
> + * the iteration.
> + */

Do we need a separate docstring here? I think we document more or less
the same for ref_iterator_begin_fn (except the include-broken flag).

> +struct ref_iterator *refs_ref_iterator_begin(
> +               struct ref_store *refs,
> +               const char *prefix, int trim, int flags);
> +
-- 
Duy
