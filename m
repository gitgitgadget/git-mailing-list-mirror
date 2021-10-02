Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEDFC433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 19:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8DB610A3
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 19:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhJBTi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 15:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbhJBTi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 15:38:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7476C0613EC
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 12:36:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g7so46808466edv.1
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 12:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHHVMcMcvT5b+R94iSlA7GJ7qsyhih0tMaEol97Vy4Y=;
        b=l6t521LeaihaCez+hciA23MkFZPC4lVJw7jhe2vuI4YGiqgtD8MVFkPU6QjVsrcTUW
         YVmk1/NidOTx00ZzfkjWQkB7u+XUUMpH/AE2yyGTA/8vnTvutJ29/TGVNanVn3AwmNF6
         Cs0fHkbGFz66UFHo8YigQWNsIl9AZB3MJTHdc0DIOKFeCBpjfUHQnEiZdCN+IwpNmgeA
         AkJHdEFySSkMzhMORKQlHOfagokmieNod5zJXYEs4sd+u9kG2qZmRoc2vVImqE5Ctx5e
         MjBliUyr/7V9m7rbGGI13pj3s5kqwQD/7vzKavN3kWWpXPk0dtlsQcDQjpoAwjdDKicG
         e4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHHVMcMcvT5b+R94iSlA7GJ7qsyhih0tMaEol97Vy4Y=;
        b=07DD7AHy+J/jv0qVpaxYtuip8tFDA8rMETIVcv3yY3it4H+dqiU7STjVmZbzRUJGYk
         6EnzOyT+lfHN34bQHuffLrnTb8NeM2jVT5y5dW+hvWGR5B/OxTz+KW4GhJHgupHDx9ys
         5nc28iMAkbY5Rw0UHvogFJt0qS1YYJOPamRJ5d9PH0eE7iJEUWNzsDC3J21NIU7Us0qC
         GjU/oV58EwhcpaDSekwSwm6IGh05sJCBJvCbk2UYUDULpGZ5TMPHDedfbRou0tdzDWR/
         auhqOQ7dH83Hvv3nSUwjQa5U4GV7fxZYgx8DsEm4lGw81B/Wd+h+9/CiRTnyDTxjPivT
         r9gg==
X-Gm-Message-State: AOAM530eE7O/UAPnXGUEpWYRtcEYXrif39/bXYwvJ471V9Bt4EMb/rQm
        BfZC1aQ5vGi8iojY1qPMNbfcd0AupZVb7YIGD39zV7QttMw=
X-Google-Smtp-Source: ABdhPJwKC2le9BzV3MFx+miQbxoqR0YUC1nAzI9t38yuHA6cODlsS20Y/rV8fh/oJXJM40FqLsFJq5F4YHrndoHj+FQ=
X-Received: by 2002:a05:6402:1bdc:: with SMTP id ch28mr6032145edb.41.1633203400291;
 Sat, 02 Oct 2021 12:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211002184407.117282-1-rybak.a.v@gmail.com> <20211002184407.117282-4-rybak.a.v@gmail.com>
In-Reply-To: <20211002184407.117282-4-rybak.a.v@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 2 Oct 2021 12:36:28 -0700
Message-ID: <CABPp-BGq27kdugX5JivX7uFLmCmHXCsRjqfaA1Q2PXHZ4hCznw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] difftool: add space after full stop in comments
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 2, 2021 at 11:49 AM Andrei Rybak <rybak.a.v@gmail.com> wrote:
>
> These punctuation typos were found using:
>
>     git grep -P ' [a-z0-9A-Z-]+[.][A-Z][A-Za-z-]+ '

While Junio has commented that two spaces after the full stop in
fixed-width source code viewing looks better, and I personally prefer
that style as well, I don't think these are worth "fixing".  I'm glad
you separated this from the other changes, but I'd rather see this
patch dropped.

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
> --
> 2.33.0
