Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048BAC433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 02:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiGKCAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 22:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKCAs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 22:00:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF091DFA0
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 19:00:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ss3so440640ejc.11
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 19:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJ91KO/k5XvYiomVaPe46+VzMaNnSRdx34sj8QgNjNU=;
        b=HAaSUv/JFm0Ljx/qNMsE0AUjCUkZ3897BIncIUH+sGaAxlMimZ6+AY5WOtSIlg7JIE
         z8J1dZ2UfLpzgZHs1sjAr6S8aVviuHYolS1eN2/c+gfXeaI1CnGItRIfcjVSUDWZkxOz
         GCZmpSzcM4JIo10jHwEao03ipw4AxQ6WDpsMEygRwYYFGZbWkOt6SbgwvnE+pxFUmMgf
         lU677n/pXZIb6MZqvzuTW0hYkveAOjdMIAjKCR9L4R/DAF/hTkmFEOyReo5sa6f28d0j
         LJm94PddHelcN6oVqnbPx0h7rYgUNfCV1tjlil2TWXz75LcXkVKsM8ApjWRQNJvxH642
         5lSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJ91KO/k5XvYiomVaPe46+VzMaNnSRdx34sj8QgNjNU=;
        b=Bk0EFQin0Es8ET4Ro0AlA6Zrw51rGNEnNkotJkybhuyfd6EUfoS1qQO+dAmk7O6eEs
         khUUDDk2Vi33J3oG0+zUzTlxdT32Cz5bhXtCb8f1V1ZuzT4ecOv0cej+cAriBcBc1JfY
         RfnLFSUgp16qRj5dGhUlyS4w1/Oo9ERZepYwLZNp7FNmrjrPWoYoMjE5qhDdqg5TDbSN
         6lJAeq0gecF0fL5D69m7A43P+Gj67UQJa+/wmUa/h3nwGu76AGZtdXK6lc98R9GtQzOx
         0aLrfm7dXhij3EiQ6aCwFH05vHNJgYrQ04MGX65qabIqoOeHmqotZ3ZfFQUr0/LpBGVz
         axIw==
X-Gm-Message-State: AJIora+gQhdhxat39tfzi938i6cJOE1u2pcEzd1DiNG9iEy8EeM4Oiuw
        ZSCnN7Vxpp4WBBZxkCuHEDISFkxqGKnwFs8v884=
X-Google-Smtp-Source: AGRyM1tList7FL1W/2XUKKjD5aZ1azkKWh8xeP6a35GVewldyChqIotBEp1amnedn66jKMuGG2ViFWIAg7RvduwTcmc=
X-Received: by 2002:a17:907:b11:b0:72b:54a5:7d2f with SMTP id
 h17-20020a1709070b1100b0072b54a57d2fmr2815383ejl.173.1657504846458; Sun, 10
 Jul 2022 19:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220710081135.74964-1-sunshine@sunshineco.com>
In-Reply-To: <20220710081135.74964-1-sunshine@sunshineco.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Mon, 11 Jul 2022 10:00:35 +0800
Message-ID: <CAO0brD0PBXDqe2HDdjg1ZhXWoYZihQ0=SY80UR+Cy3xRqqH8Sg@mail.gmail.com>
Subject: Re: [PATCH] unpack-objects: fix compilation warning/error due to
 missing braces
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 10, 2022 at 4:12 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On macOS High Sierra (10.13), Apple's `clang`[1] complains about missing
> braces around initialization of a subobject, which is problematic when
> building with `DEVELOPER=YesPlease` which enables `-Werror`:
>
>     builtin/unpack-objects.c:388:26: error: suggest braces around
>         initialization of subobject [-Werror,-Wmissing-braces]
>             git_zstream zstream = { 0 };
>
> [1]: `cc --version` => "Apple LLVM version 10.0.0 (clang-1000.10.44.4)"
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> Notes:
>     This is atop 'hx/unpack-streaming' which is already in 'next'.
>     All the CI builds are fine with this change.
>
>     As I understand it, this should be a safe change; the fields which
>     follow `z_stream z` in `git_zstream` will be initialized to zero
>     since the first field has an explicit initializer.
>
>  builtin/unpack-objects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 43789b8ef2..c606c92e37 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -385,7 +385,7 @@ static const void *feed_input_zstream(struct input_stream *in_stream,
>
>  static void stream_blob(unsigned long size, unsigned nr)
>  {
> -       git_zstream zstream = { 0 };
> +       git_zstream zstream = {{ 0 }};
>         struct input_zstream_data data = { 0 };
>         struct input_stream in_stream = {
>                 .read = feed_input_zstream,
> --
> 2.37.0.236.gcef32db0b6.dirty
>

Not a comment, just wondering, when should I use "{ { 0 } }" and when
should I use "{ 0 }"?

I didn't get the error with "Apple clang version 13.0.0
(clang-1300.0.29.30)",  because it's
a higher version ?

Thanks.
-Han Xin
