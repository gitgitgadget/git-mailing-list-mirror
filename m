Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD779C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE7D06121F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbhJDN4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239020AbhJDN42 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 09:56:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCEBC0613A4
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 06:45:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 133so16601653pgb.1
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 06:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E0rJ11/Us4RJQ2hh3cp3Km5FYDZMHVTvs8p8HUOdTvs=;
        b=UGBveCHgcXA5UbHfQOcZvoPBuwydXM5qHtn7YYO/H5v3W77Wn//6V3NPlhykPsDqQL
         /UYBD3TQxs1cFEpEjaPBrClSJRzxhTeLLeC6jlO+pgXVb2HyrV6X4d/zBfu0y+HDAmsg
         li8X5gHv5O+rfQeBO9P1HiPSNg+NrBlRqNnP9Ty+dXlGmNJEFA/VIUCyHqc7HITH1Xmn
         UhnZ5u5fCxdzmLQm2Dk57TEE2R/sBKeijMFvO9wd19ja0/EXmxpfFAdPE5r1U2XRTvG6
         0NWfuqdTbybSH34Xlnpu433pbfrmpQhxszQXca2+M16Le/lRN9b8tcWa7iY6pTJ+7Hwv
         3nLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E0rJ11/Us4RJQ2hh3cp3Km5FYDZMHVTvs8p8HUOdTvs=;
        b=TbUA8rWg0j+JOZ42aKTrVtbHHr+NqUAJl7d0WO72IsAC0NqAwL7ZRcV2JrFCkRDI18
         w4yZbWZAVe9PdYYvoaYjFv8H3TVixtrg0x2FHrd+tIUso9bDj8mKy3Uqvjca9gk0Eq+c
         z2QlAsCGuaJy08c/lYdS62bI/XJn5VQcNNXtNkQtUaqV4nLxk0B+HI69fnwdyuN/Et7Z
         BZv+/7JijmV9OLRa6Ja55JeJiwyVNa3xQfIw13sJ6NI0TtfxV8BhjRWvx76QO/oA0fpi
         UExqlHG2tLaonvKeZvc3U5I4+hS3BM/j3Av4bGLbreNTWGVAyG6CROWzDRnhmwFlrK+v
         pX4A==
X-Gm-Message-State: AOAM5304G8sQ2BXeh8mdOwgmNlYTyuhf4Eu8lu4pZGzmBEKsEsCWasVY
        DztzRkuV7+iplY5XNMhZtP3dfeLgYYGVRkUUac+Nen7cZgE=
X-Google-Smtp-Source: ABdhPJxpRRPT1km5ixexybJTVKB3zE9ziCqSi73QZ5ECO000f6n3FTBWle/tMWmUcAt+q05kx8T6jMIDTWDKP7+EbWE=
X-Received: by 2002:a05:6a00:1ac6:b0:44c:9e9:9e98 with SMTP id
 f6-20020a056a001ac600b0044c09e99e98mr21129191pfv.69.1633355149102; Mon, 04
 Oct 2021 06:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com> <patch-04.10-9d62edd35bf-20211004T002226Z-avarab@gmail.com>
In-Reply-To: <patch-04.10-9d62edd35bf-20211004T002226Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 06:45:00 -0700
Message-ID: <CABPp-BH4ubjJ98Nvgp2iyKxmU9X+ypw4m1o=iL9Z4vSNZ-QTDw@mail.gmail.com>
Subject: Re: [PATCH 04/10] unpack-trees API: don't have clear_unpack_trees_porcelain()
 reset
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 3, 2021 at 5:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Change the clear_unpack_trees_porcelain() to be like a *_release()
> function, not a *_reset() (in strbuf.c terms). Let's move the only API
> user that relied on the latter to doing its own
> unpack_trees_options_init(). See the commit that introduced
> unpack_trees_options_init() for details on the control flow involved
> here.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  merge-recursive.c | 1 +
>  unpack-trees.c    | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d24a4903f1d..a77f66b006c 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -442,6 +442,7 @@ static void unpack_trees_finish(struct merge_options =
*opt)
>  {
>         discard_index(&opt->priv->orig_index);
>         clear_unpack_trees_porcelain(&opt->priv->unpack_opts);
> +       unpack_trees_options_init(&opt->priv->unpack_opts);

This is wrong.  It suggests that unpack_opts is used after
unpack_trees_finish() (other than an outer merge first calling
unpack_trees_start() again), which can only serve to greatly confuse
future readers.  Drop this hunk.

>  }
>
>  static int save_files_dirs(const struct object_id *oid,
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 94767d3f96f..e7365322e82 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -197,7 +197,6 @@ void clear_unpack_trees_porcelain(struct unpack_trees=
_options *opts)
>  {
>         strvec_clear(&opts->msgs_to_free);
>         dir_clear(&opts->dir);
> -       memset(opts->msgs, 0, sizeof(opts->msgs));

This seems like a very dangerous change.  You want to leave opts->msgs
pointing at freed memory?
