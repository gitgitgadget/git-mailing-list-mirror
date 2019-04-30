Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAE731F453
	for <e@80x24.org>; Tue, 30 Apr 2019 22:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfD3WHS (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 18:07:18 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45205 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfD3WHR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 18:07:17 -0400
Received: by mail-qk1-f194.google.com with SMTP id d5so9228770qko.12
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rmWKal27gJe0g1XA9acvtTwSGVIU3grLItyC6U5X6eM=;
        b=q6w5g8j7hDxyKkBWWQH2YGcSgkrTFR89Lrn37/24j6YBRi7xDR+fBBqkku8ifPbtnz
         LrStxgzwqjX2/KqfvNFgyyTy5SLkEfqhrOLU9OScgQ1CE7yAiHYCFNhVjhWn/pCA0bHQ
         ORQ3FuYFZ9WxSQP3gRVr5TnIhGsP42Eip/V98TJnlw7IbfvGVjN2S7tDUyiFfzYnbnM4
         ZKMnTCxgmyPro8BNGPDi6aFgeopCisl3b++Cq5XXFhCGdC/E0H1kgmmCU2mIExM6xpYo
         t2I14kiLG4NrAJX2DuhxLTqIcCkWhHdnrnxIHbHaRyXjKcHNaZoguIrEds1aBw+I3Cyk
         ePqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rmWKal27gJe0g1XA9acvtTwSGVIU3grLItyC6U5X6eM=;
        b=H9gaQJthTwFY5jfkUC95itlHfN7GZo5Wgg4VQAaYp02U3VCQLOPsJyU5IzdF6wlxui
         /yuUhuofoVXo34s/GMEsJnK8PEA6sT9lI2rpU1BEicEedK/kLzDqLsgUz4v3hlEcR/pL
         AELJ8fQ0f9Y0YLnM0+l63Rw1Fh6a0Ch/9CI7d545ccsSyC9SX8s/YPMLSkfPAJXQCXgS
         r25prdRdNxUBoGh0WFDCRfQ9VstypCyNdReIzkoRZUyYbx2Ov7IOj6CqQA2ihxoecdpk
         3SmVOvF5IxQ35VCEUt9tgIdffbpFNSNyh1mu1GSky1if0eW1qA5kBg2Vo6LNMwHLS7Ku
         5rzQ==
X-Gm-Message-State: APjAAAUQeel7bT05NGkgR4mfUZyODvItNG/Yf2mbGFZAeJtfYbGvm4vQ
        MKr2X7CfOt8XpESplMgosavXq+EursXl7KfIyZQ=
X-Google-Smtp-Source: APXvYqzPsHN8YSLM4z9c5ssv2zAG1Ki0W/iNQvtTcY2B+EnpcIK0VzZ8pKylyb1PuvnIWH1JNvawyjpBN0kbpOrysB8=
X-Received: by 2002:a37:658d:: with SMTP id z135mr42772165qkb.93.1556662036866;
 Tue, 30 Apr 2019 15:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190324131755.26821-1-pclouds@gmail.com> <20190326094101.26294-1-pclouds@gmail.com>
In-Reply-To: <20190326094101.26294-1-pclouds@gmail.com>
From:   Jason Karns <jason.karns@gmail.com>
Date:   Tue, 30 Apr 2019 18:07:06 -0400
Message-ID: <CAKNmmv1Y48zfUZ0TvjDVdVngrMyA1YyNacdNbw7O05_E4FHsbQ@mail.gmail.com>
Subject: Re: [PATCH v3] config: correct '**' matching in includeIf patterns
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 5:42 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> The current wildmatch() call for includeIf's gitdir pattern does not
> pass the WM_PATHNAME flag. Without this flag, '*' is treated _almost_
> the same as '**' (because '*' also matches slashes) with one exception:
>
> '/**/' can match a single slash. The pattern 'foo/**/bar' matches
> 'foo/bar'.
>
> But '/*/', which is essentially what wildmatch engine sees without
> WM_PATHNAME, has to match two slashes (and '*' matches nothing). Which
> means 'foo/*/bar' cannot match 'foo/bar'. It can only match 'foo//bar'.
>
> The result of this is the current wildmatch() call works most of the
> time until the user depends on '/**/' matching no path component. And
> also '*' matches slashes while it should not, but people probably
> haven't noticed this yet. The fix is straightforward.
>
> Reported-by: Jason Karns <jason.karns@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  v3 updates the test to avoid mkdir and cd, and break long lines.
>
>  config.c                  |  2 +-
>  t/t1305-config-include.sh | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/config.c b/config.c
> index 0f0cdd8c0f..c2846df3f1 100644
> --- a/config.c
> +++ b/config.c
> @@ -242,7 +242,7 @@ static int include_by_gitdir(const struct config_opti=
ons *opts,
>         }
>
>         ret =3D !wildmatch(pattern.buf + prefix, text.buf + prefix,
> -                        icase ? WM_CASEFOLD : 0);
> +                        WM_PATHNAME | (icase ? WM_CASEFOLD : 0));
>
>         if (!ret && !already_tried_absolute) {
>                 /*
> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index 635918505d..579a86b7f8 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -229,6 +229,19 @@ test_expect_success 'conditional include, early conf=
ig reading' '
>         )
>  '
>
> +test_expect_success 'conditional include with /**/' '
> +       REPO=3Dfoo/bar/repo &&
> +       git init $REPO &&
> +       cat >>$REPO/.git/config <<-\EOF &&
> +       [includeIf "gitdir:**/foo/**/bar/**"]
> +       path=3Dbar7
> +       EOF
> +       echo "[test]seven=3D7" >$REPO/.git/bar7 &&
> +       echo 7 >expect &&
> +       git -C $REPO config test.seven >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_expect_success SYMLINKS 'conditional include, set up symlinked $HOM=
E' '
>         mkdir real-home &&
>         ln -s real-home home &&
> --
> 2.21.0.479.g47ac719cd3
>

Thank you all for looking into this! (and your work on git!) It is
very much appreciated.

Jason
