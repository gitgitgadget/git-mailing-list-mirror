Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E82EC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7215F6121F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbhJDN4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239011AbhJDN40 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 09:56:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C3CC061783
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 06:45:39 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id rj12-20020a17090b3e8c00b0019f88e44d85so5667744pjb.4
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 06:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mJm7dUr8fBXAQ9XOrRBZqf6M9BKOBgOY6kY43MR0GQ8=;
        b=Dn+8ZrMx5hYCvuFwkhFS6cHcTdLb4jZNeQJE9CdnXrPs0ijYOkoiGSYqiHjQBR3F/x
         u8ipMnyi1vbVz1d1mzgv1g0fCEqPOT/06fHmTGvgnr7LZgtPYBElHcdZ47SNr9dlCVus
         f8kKE7A5MqL4MHE19FVHIJmDYErnnPrv8c5XPp2Ig2BewJyWoXvIxwpp1rh451IOjrA+
         A8TgrXCsOvs2PyQspc2GP11hn0FWcjkS0f7L5jbGM/OS7ugph3LuST3YjrsQd0cXQ7jN
         /+mHMDLeAcqhIisvAD543gJnT1AYANm5b30TrPsp+/TYz7Z02QusQaiIczgtS1rWT0tq
         +x9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mJm7dUr8fBXAQ9XOrRBZqf6M9BKOBgOY6kY43MR0GQ8=;
        b=LbL8amKKyo2c7VBYgqieEMgQMt88+q3WW/EnXwTuaymzQzQkbkkf3BcQW/ozMiyWnu
         rn7W4SgGuaaJDXpkM8oa9YNkwlu3T7tGz0CY+8Waehcw3OLjnCp8BdbOphZSE4VfeDnU
         fiZKmQAfzzbndNfOZbgSU1eQLwnkS0udCxnJZknWneEBYGyjv4L0RgdU11Gxh8KSR7fL
         lONAqzJqrI5/YJRPsQr9H4TJQnw4MdXOmEMkq1bOCWMq4eo0NtnzRdQk/r/bq/Y+wVbc
         IZACAFvb/xXDyDgW4C/H92lqyqi+NsF16+PG91n5v9/fRiEoqVe0aH+L0L30EBKga0u/
         RkDg==
X-Gm-Message-State: AOAM530ZB8gl5jIkWktuayyIA0sI/QzwjRsKgz9fzM0IB9d8Y8H4muhr
        bgL0voCEIheSzS5WRgr8iUU2DOVWQkW2Rrpj/TToazs/dBc=
X-Google-Smtp-Source: ABdhPJxvhAzTLI3p1aqV2av3ubX4T8OXxMODZ8PjSiPxQ7CKyFNDAubVwFFcsdroN9FnicK0Tt2x62m3NNZzlv1kMqs=
X-Received: by 2002:a17:90a:e453:: with SMTP id jp19mr15094321pjb.11.1633355138760;
 Mon, 04 Oct 2021 06:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com> <patch-05.10-042080b8d6d-20211004T002226Z-avarab@gmail.com>
In-Reply-To: <patch-05.10-042080b8d6d-20211004T002226Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 06:45:00 -0700
Message-ID: <CABPp-BHZZ4ETPAwf_jBZDZfHCvOUsL5Xnz8Ai0dHWAzazz7nnA@mail.gmail.com>
Subject: Re: [PATCH 05/10] dir.[ch]: make DIR_INIT mandatory
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

The subject seems misleading; this patch doesn't make DIR_INIT
mandatory, it is just updating the docs to reflect that and updating
an out-of-date callsite.

>
> The dir_init() initializer has been documented as being mandatory
> since eceba532141 (dir: fix problematic API to avoid memory leaks,
> 2020-08-18), but both it and my ce93a4c6127 (dir.[ch]: replace
> dir_init() with DIR_INIT, 2021-07-01) managed to miss this callsite in
> "add-interactive.c" added before those two commits in
> ab1e1cccaf6 (built-in add -i: re-implement `add-untracked` in C,
> 2019-11-29).
>
> In addition my change to remove dir_init() neglected to update this
> documentation. Let's use "must be initialized with" in reference to
> "DIR_INIT". We have one lazy initialization which pre-dates
> eceba532141 in dir.c. Adjusting this callsite is a prerequisite for
> removing it in favor of trusting the macro to initialize the "struct
> dir_struct" correctly.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  add-interactive.c | 2 +-
>  dir.h             | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/add-interactive.c b/add-interactive.c
> index 6498ae196f1..27daea8d1b3 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -826,7 +826,7 @@ static int get_untracked_files(struct repository *r,
>                                struct prefix_item_list *files,
>                                const struct pathspec *ps)
>  {
> -       struct dir_struct dir =3D { 0 };
> +       struct dir_struct dir =3D DIR_INIT;
>         size_t i;
>         struct strbuf buf =3D STRBUF_INIT;
>
> diff --git a/dir.h b/dir.h
> index 83f46c0fb4c..ff3b4a7f602 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -19,7 +19,7 @@
>   * CE_SKIP_WORKTREE marked. If you want to exclude files, make sure you =
have
>   * loaded the index first.
>   *
> - * - Prepare `struct dir_struct dir` using `dir_init()` function.
> + * - The `struct dir_struct dir` must be initialized with `DIR_INIT`.
>   *
>   * - To add single exclude pattern, call `add_pattern_list()` and then
>   *   `add_pattern()`.
> --
> 2.33.0.1404.g83021034c5d

...other than the subject, the patch looks good
