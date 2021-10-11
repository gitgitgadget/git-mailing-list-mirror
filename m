Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5453FC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 15:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38BFD60C4B
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 15:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbhJKPpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 11:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238321AbhJKPpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 11:45:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18352C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 08:43:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g10so68741443edj.1
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eFhG9yfpYrOl7cOczs+RYWXGNe+qF7Z6n16l2xckl/4=;
        b=ckCAeeqy+HqiqtslDJQ4fG9eUFkrtM/y4cPgFPVqXkpN1STZmu29CUOt2Yuz8I+LqE
         BArXOgjyTxg1p+2tP1KlCWzpPZh1A65Tegrr8nPpB+vsqO+kdTsXKmRYKOC3KpKnPnoR
         7w4um6GlSPVEIGsX+s5bp972DPgQ1i9/9KEasKEVor5GRKcjVqMOFSuPzZ7JAJNe86QV
         2pvPzUfA5MrAzRVy2pV3PaXBL3EL6Jv6cjh9dTlHTpT8g1RXdOUBV6GF/wJVPhpwAFmR
         gQ+stJhU9/iHZwsO2l6kXY86xht3jniFsCzPsiBmi/xxIKiQSr4R+EJSbW6PraQrXQfS
         HU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFhG9yfpYrOl7cOczs+RYWXGNe+qF7Z6n16l2xckl/4=;
        b=1n6hplS8CVYigIOZPkO0ACX+0GLeXLLvqGpxcumgzCE7rDDCDtq+DHkmRMNGMufbt4
         +vf7ar0U0mTGXwATDwWpFJC6oQTxz70i3u/Yza6mBbUN4lTYryRVZYl/venZuLTeLKBX
         GbieifJND+vkX1H6jpM7ZD63YZBpDAHcwKoWH7AkI/3aQbuqG7hbBOKZtpaiGULxVkN6
         9rZ21KfwN/svSr91qbMBp77VJN1jYnJS2kaE/mF4uz0J0gdM3jmoUF5tg4wL+hIQgoOB
         gpAErXUj9s8VpTMVO4RW4LQmUz3fT1/3RSJ/AHVYNu84S+9ChWqI7vuJ7798yM1IIHur
         Oxkg==
X-Gm-Message-State: AOAM5337IlTshG4OwzS268fn8xquSR5/hzltu9NHtj8pP2wR201RWRXl
        USRVe5rRWQ8WnHMcG75tYw2+uaAe06bGCmgd/BI=
X-Google-Smtp-Source: ABdhPJy753OmJ3Drl0a22/J1WmNzLpXVokLnHwvUilIY4Z6yXZdunYhYur5LRQt2rGMztWoI/Fd5hwuB2IP6Vwuvrvo=
X-Received: by 2002:a05:6402:42c8:: with SMTP id i8mr39175855edc.349.1633966993951;
 Mon, 11 Oct 2021 08:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211002184407.117282-1-rybak.a.v@gmail.com> <20211002184407.117282-4-rybak.a.v@gmail.com>
In-Reply-To: <20211002184407.117282-4-rybak.a.v@gmail.com>
From:   David Aguilar <davvid@gmail.com>
Date:   Mon, 11 Oct 2021 08:42:37 -0700
Message-ID: <CAJDDKr7KUP3BPBU+C6=Yn+=fTebQNMDMLsQqFRTe_CRfRyJA0w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] difftool: add space after full stop in comments
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 2, 2021 at 11:49 AM Andrei Rybak <rybak.a.v@gmail.com> wrote:
>
> These punctuation typos were found using:
>
>     git grep -P ' [a-z0-9A-Z-]+[.][A-Z][A-Za-z-]+ '
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>
> I've also looked for similar typos around commas and semicolons and didn't find
> any.
>
>  builtin/difftool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index bb9fe7245a..d9a4e55caf 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -529,7 +529,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>                 goto finish;
>
>         /*
> -        * Changes to submodules require special treatment.This loop writes a
> +        * Changes to submodules require special treatment. This loop writes a
>          * temporary file to both the left and right directories to show the
>          * change in the recorded SHA1 for the submodule.
>          */
> @@ -548,7 +548,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>         }
>
>         /*
> -        * Symbolic links require special treatment.The standard "git diff"
> +        * Symbolic links require special treatment. The standard "git diff"
>          * shows only the link itself, not the contents of the link target.
>          * This loop replicates that behavior.
>          */

Heads-up -- this 2nd hunk is already in "next". Please see:

28c10ecbfc (difftool: add a missing space to the run_dir_diff()
comments, 2021-09-30)

The 1st hunk above it (submodules) is still relevant.

It might be worth rebasing this patch against the da/difftool topic in
"next". This patch should become a one-liner once that's done.
-- 
David
