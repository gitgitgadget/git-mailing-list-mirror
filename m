Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA80BC07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 14:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiIXOuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 10:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbiIXOuN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 10:50:13 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B35E2AE13
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 07:50:11 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3450990b0aeso26768377b3.12
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 07:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=D5s5/NbiJpMzHalFokhRjo8+U6AHJNOPTbU4lS1PGnE=;
        b=QCVz+HrAVjw6kotwTMVol5COsKUgnYKaDFiy9opcQEoV5KEP0k9T20FLVe7Iyn9GXH
         X+G4QiHBDEgkEIT9y23j/HHAVddHH/OOHv61k92/cTQYVb6RibI3kCNh6M/VfqaGM25r
         NhacLCONu9oTlqM+KsTKJXc78KB8Z8n7vsRce4leZw4gSIDvdLOeMsJUX6ztV14JckPG
         LKUYh1RjOG2ZXG7FSu+IwDtZJN6wfXcYhlJRN8wnxVFVbTx4nSXdWC1Zk5pkRQ9XJkqh
         Ix4Bo02o1hF0SlrORJirWUXvpCeDNN+jlYRH6brH8MWCdV79m7230e/33TJjgL4dJ31E
         gomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=D5s5/NbiJpMzHalFokhRjo8+U6AHJNOPTbU4lS1PGnE=;
        b=lgj8UZRzVMFvalj5a6soCQyv9Bfz0SZTvxSISa0d68RDu0NxDDofNf06U4BWCMOiYT
         BTtXnk2meQ3Z3zQljH0y9hkYa+oLUk10xUYzVbobZIxjCkCJsu+YADG1oZKbEWnLiE/L
         gLk2Tj+Dn2SBOGHaIlsn41jJBQ0zaU5EvqP2WYF9D3jvm2+HkHeV553S8xU/PxA2FppV
         5syBmm7yrNECxRWwKh5RKEuG+NKawUAH1CxPceTJZoeS6gpCCxQksx5gH569Q7tCGYUw
         Ouf6eRFT9CvGcTnkZn3UJJedrcGeQ33FURr7yZnUA3GUybNcw/fOEjlcs8jmvje3zbqQ
         un3A==
X-Gm-Message-State: ACrzQf2oZG+HwTHnKH9vcde5SeNRV5or/XEv2j7jQr//UGLe2ZWcqANM
        D/XTYffSHJFkeu67P1m1uDe5dD37qA/JSXuq0Hpr5wQXkuSZfw==
X-Google-Smtp-Source: AMsMyM5ccVf2M4F5q6LxG8iL+2h8qqOgix8iNpWHAYeA3740TqOyWdW/iGYmFXaEtJSGEf8hoDDWR5zynNbo3dPI1Fk=
X-Received: by 2002:a81:7851:0:b0:349:5fac:b1ed with SMTP id
 t78-20020a817851000000b003495facb1edmr13369660ywc.311.1664031010371; Sat, 24
 Sep 2022 07:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220923193543.58635-1-siddharthasthana31@gmail.com>
In-Reply-To: <20220923193543.58635-1-siddharthasthana31@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 24 Sep 2022 16:49:59 +0200
Message-ID: <CAP8UFD245ebv95f8bvN9YqPtv1c+Pa4xzAmY_mixs3nrdSdGvA@mail.gmail.com>
Subject: Re: [PATCH] doc/cat-file: allow --use-mailmap for --batch options
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2022 at 9:36 PM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
> The command git cat-file can now use the mailmap mechanism to replace
> idents with their canonical versions for commit and tag objects. There
> are several options like `--batch`, `--batch-check` and
> `--batch-command` that can be combined with `--use-mailmap`. But, the
> documentation for `--batch`, `--batch-check` and `--batch-command`
> doesn't say so. This patch fixes that documentation.
>
> Mentored-by: Christian Couder's avatarChristian Couder <christian.couder@gmail.com>
> Mentored-by: John Cai's avatarJohn Cai <johncai86@gmail.com>

As you told me separately, you should remove "Christian Couder's
avatar" and "John Cai's avatar" from the above trailers.

> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---

Here after the line that contains only '---' and before the short
stats below, you could write some small explanations about where this
patch comes from.

For example you could say that it was previously sent as the first
patch of a a 3 patch series:

https://lore.kernel.org/git/20220916205946.178925-2-siddharthasthana31@gmail.com/

And you could tell what changes you made compared to the previous patch.

>  Documentation/git-cat-file.txt | 44 ++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index ec30b5c574..3fdafc07ce 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -89,26 +89,44 @@ OPTIONS
>  --batch::
>  --batch=<format>::
>         Print object information and contents for each object provided
> -       on stdin.  May not be combined with any other options or arguments
> -       except `--textconv` or `--filters`, in which case the input lines
> -       also need to specify the path, separated by whitespace.  See the
> -       section `BATCH OUTPUT` below for details.
> +       on stdin.
> +
> +       * When used with `--textconv` or `--filters`, the input lines
> +         must specify the path, separated by whitespace. See the section
> +         `BATCH OUTPUT` below for details.
> +
> +       * When used with `--use-mailmap`, the info command shows the size
> +         the object, if the idents recorded in it were the ones "corrected"
> +         by the mailmap mechanism.
> +         Cannot be used with any other options.

Have you checked the result of `git help cat-file` after `make instll-doc`?

Shouldn't you use something like the following instead for additional
paragraphs inside some indented text:

+
* When used with `--textconv` or `--filters`, the input lines
must specify the path, separated by whitespace. See the section
`BATCH OUTPUT` below for details.
+

?

(Note that the + signs in what I suggest above should be actually
added to the file and aren't what a diff displays in front of new
lines.)

Also it's not very clear if "Cannot be used with any other options."
is part of the last "* When ..." paragraph or not.
