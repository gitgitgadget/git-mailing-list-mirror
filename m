Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EF861F405
	for <e@80x24.org>; Tue, 18 Dec 2018 06:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbeLRGKC (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 01:10:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41370 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeLRGKC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 01:10:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so7602178pfi.8
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 22:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZgqkuaph8Eo2Tv+uLDxW3y6g6gjr7rpRldHPxU+jYE=;
        b=i8CC8lzlI5Kz9XebgpWzPPSyPyTFhvJtgfGaQrcNG6TLL8Y+Q2W5mWIG40C0GWTlnu
         yH+vazlaqvyo7urFERiQaABpFfV7/aaqSqZ4OEC4yB1Cc/Ku9wuKgRKKd0oeUpumLlwC
         Qqaj3qFz8v5HHTKDTWeLUDWY5gHn3jSrFyN4Ls9cqNIz80u4hzipfHueIInVoaqo4O46
         uYL456fOpElqEVUjuB+EOx+EbpLqlirW2HBgpoh2NVwRrzATPYCItfNQyeY2G2/FSzju
         PqkqAtEvJwkUaeaxznOlLGu+//RjtfnMVxM31DA7/8QCEx6gOkNVTc/Qs8283lvGStiB
         /OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZgqkuaph8Eo2Tv+uLDxW3y6g6gjr7rpRldHPxU+jYE=;
        b=WWQiOelRMVvMqntQTessNdNHEjvb4S/QCkIhOHRl2JmWWUsDqjp2toVJ/TPGTvI0Mh
         1ol2o5fr21YfDyMlOi4AMXUbwhHTkT1mqjArceqWL+f8AfjcRZ9nSWoPj0bVAt0V1bb4
         voqmjt3CueUJP9TWS1FahB/YBY096onlk1Cca57XaQu5GZYefgqvXt6Mo19sfQ2gHJsL
         ddzoAt+rBD9B0q1HVz4Edy5Qju0/n3bYuc7d6ITz2cEeMt5ssnbdzEmqE1frVzkyztYr
         Bt5Ipg/PPg7avB9efKEePiIqE0RbPxN+Fu5bysL2uVHQStnjzNV17cUXAldlZPFYipv1
         /yPw==
X-Gm-Message-State: AA+aEWb7JXlHA5J6p+++hCKaE0flM8vdjQiy3DPzpYGZYV7/6HY1cItU
        s+KMzCss0sm2BK+Bh2vpLidfIFUCDYBdEjC/Y56U9kv4
X-Google-Smtp-Source: AFSGD/UZmIVZXIP25d3haNhV4Ui4FPgTyLxNTeSqkNALwFzFv6D3KL+H2WrVz//ClV+aKYi8ah5LmCnl5QiWq3zPq/M=
X-Received: by 2002:a63:b94c:: with SMTP id v12mr14607584pgo.221.1545113401273;
 Mon, 17 Dec 2018 22:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20181217165957.GA60293@google.com>
In-Reply-To: <20181217165957.GA60293@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 18 Dec 2018 07:09:49 +0100
Message-ID: <CAN0heSoekZ_vjR6DRjSAfw74hn_NU3-5TFf6-Hn9z2D_zE-mNg@mail.gmail.com>
Subject: Re: [PATCH] stripspace: allow -s/-c outside git repository
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 17 Dec 2018 at 22:56, Jonathan Nieder <jrnieder@gmail.com> wrote:
> That makes experimenting with the stripspace command unnecessarily
> fussy.  Fix it by discovering the git directory gently, as intended
> all along.

>         if (mode == STRIP_COMMENTS || mode == COMMENT_LINES) {
> -               setup_git_directory_gently(NULL);
> +               setup_git_directory_gently(&nongit);
>                 git_config(git_default_config, NULL);
>         }

Makes me wonder if `setup_git_directory_gently()` should BUG if it
receives NULL. That would require some reshuffling in setup.c, since
`setup_git_directory()` calls out to it with NULL... Just thinking out
loud. In any case, and more importantly, this is the last user providing
NULL except for the one in `setup_git_directory()`.

> diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
> index 5ce47e8af5..0c24a0f9a3 100755
> --- a/t/t0030-stripspace.sh
> +++ b/t/t0030-stripspace.sh
> @@ -430,9 +430,15 @@ test_expect_success '-c with changed comment char' '
>  test_expect_success '-c with comment char defined in .git/config' '
>         test_config core.commentchar = &&
>         printf "= foo\n" >expect &&
> -       printf "foo" | (
> -               mkdir sub && cd sub && git stripspace -c
> -       ) >actual &&
> +       rm -fr sub &&
> +       mkdir sub &&
> +       printf "foo" | git -C sub stripspace -c >actual &&
> +       test_cmp expect actual
> +'

A small while-at-it conversion from subshell (with a funny pipe into it)
to `-C sub`. The `rm -fr` invocation is not in the original, so
shouldn't be needed. This one looks safe enough, though it makes me
wonder why you need it. `mkdir -p sub`? Probably not worth a v2.

> +
> +test_expect_success '-c outside git repository' '
> +       printf "# foo\n" >expect &&
> +       printf "foo" | nongit git stripspace -c >actual &&
>         test_cmp expect actual
>  '

Nice.

Martin
