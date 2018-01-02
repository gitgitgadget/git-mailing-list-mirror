Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AA561F404
	for <e@80x24.org>; Tue,  2 Jan 2018 05:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeABFRj (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 00:17:39 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38904 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeABFRi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 00:17:38 -0500
Received: by mail-qt0-f196.google.com with SMTP id d4so61579106qtj.5
        for <git@vger.kernel.org>; Mon, 01 Jan 2018 21:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=H3xspAjzG0XxXtRdC7cpeEQgMM/96MrS4akRialBvHM=;
        b=lkqr6wW6//mSPBW3EL9B7zfhEKjy2jC6ZWO87rbMxYT4HwGBF/ZkgNRPZ42fgfdpvZ
         /OnoNOxYb8enpTU2zyefNr23NhaZqehLANYTmDuIkAbYAlp9+i5LNYTzuGgr53YXcyF4
         FoRixaI7vuamJj92g4T6UovWCqRbeE3fad3MC0DX6mp3V34BqPHqR7WHeZ0JKiDMXDeg
         Iv4OZLZrCsRf7it2dHdb+kxTnShmwgDniYvN/Xy4CqWsUgaownFdAPDCsiz40QTD5Rym
         V8BSaKAagIGCgBAgl05NV1hiPat0hBF0VOyixqkUSNIY5URLnRRWOwpl12/O+qhSRPD5
         TGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=H3xspAjzG0XxXtRdC7cpeEQgMM/96MrS4akRialBvHM=;
        b=dv5BIAn3wDZzvLhE2sU6WHXDmmk2bxnw3QVq4sWAWNoDm1J8pGzCxMPYsaVqEF/7re
         TylgU1ajouMlZoJSOF8+mH3fjETXG8B26wMEugUqsobbDN+QxQFuBTWUm5jCYu1/TAga
         aAvhEG8HZSRZY/1t8wAJBOZGHhyTg8Z1uJd+IZF+4q7JTu/hMRtsC4W7TqIcwdypJvBA
         H/SC0/Qbi+H1J/Lj8K+4wtYxO2ODaHGwTvewhmZVdHsPG6JnDCnEszdqtZGfemSTmz9v
         u2rhQZzSVmnXBMk2eCVNYIGXSB3wlC/MW7bmEDMWCTUNp9yjRgIXtxRdNJZHmREM3YrM
         V0dw==
X-Gm-Message-State: AKGB3mKPJUUKhXIFdFF67vtGDYMcEVzv7PZZZf7NZNgSnAN8lDIF3XTi
        8gC3F89cM6+AkjR2OiBmkujX+d9PA5PxuB7Rets=
X-Google-Smtp-Source: ACJfBouC26bHrigroY4kHteDEUkiBzgkg9JpsaS87n2e6ZsEtGi5r4gMeWEcFXHvB3Jf7KR6UPaNnxWQndwHk7QY/0A=
X-Received: by 10.237.59.22 with SMTP id p22mr58921448qte.34.1514870257208;
 Mon, 01 Jan 2018 21:17:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Mon, 1 Jan 2018 21:17:36 -0800 (PST)
In-Reply-To: <20180101225448.2561-5-szeder.dev@gmail.com>
References: <20180101225448.2561-1-szeder.dev@gmail.com> <20180101225448.2561-5-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 2 Jan 2018 00:17:36 -0500
X-Google-Sender-Auth: cm8sAtkviDiYTxf4BO_rHCyuTMg
Message-ID: <CAPig+cQ=Fj-sWrxDH1RV=PnYT01LGapzJjrRT5QdqUTkyc0rfg@mail.gmail.com>
Subject: Re: [PATCH 4/4] branch: add '--show-description' option
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 1, 2018 at 5:54 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> 'git branch' has an option to edit a branch's description, but lacks
> the option to show that description.
>
> Therefore, add a new '--show-description' option to do just that, as a
> more user-friendly alternative to 'git config --get
> branch.$branchname.description':
>   [...]
>   - errors out with a proper error message when the given branch
>     doesn't exist (but exits quietly with an error code when the
>     branch does exit but has no description, just like the 'git config'

s/exit/exist/

>     query does).
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
> diff --git a/builtin/branch.c b/builtin/branch.c
> @@ -737,6 +741,35 @@ int cmd_branch(int argc, const char **argv, const ch=
ar *prefix)
> +       } else if (show_description) {
> +               [...]
> +               if (!argc) {
> +                       if (filter.detached)
> +                               die(_("cannot show description on detache=
d HEAD"));
> +                       branch_name =3D head;
> +               } else if (argc =3D=3D 1)
> +                       branch_name =3D argv[0];
> +               else
> +                       die(_("cannot show description of more than one b=
ranch"));

Aside from paralleling the single branch accepted by
--edit-description, why this limitation? (Just curious; I don't feel
strongly one way or the other.)
