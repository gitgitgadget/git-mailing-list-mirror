Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE7A71F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 07:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeFAHxT (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 03:53:19 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46337 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeFAHxS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 03:53:18 -0400
Received: by mail-qt0-f196.google.com with SMTP id h5-v6so23105137qtm.13
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 00:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Hd79kCIj2rbbekeZ7gtDQi5bpLgV8QHFQ4Qp+/wkfjw=;
        b=lmcMQUL0xv9wgkwZBvDnjq8NTgS5koDSP25g//UKtEpMAFRy2XxWrNFiFatIJahQ2w
         qB5BcrmzR/TOLdSdAV/PYkaXb6qynjTqmWoKdyitIdc+la/YJpJrSbAUtqqnZDuPJ8jZ
         aXfW93srUXhZYTHkQUu8T1+CTGvO8OubjnfNwIZeb84YsGg8Asf/dUBvhLxVaSNrW2RZ
         wWNhKNQI3eODnvyfrKerrD79mIXo0oTcVxYW/Zy/4lPgGXNgZNy3NHntf9AOZ0TpsRu5
         DAWddQBwNcvx6wtVJyQ6VC99heykmHg3wgABEyBp4OqVtoKLqM+twxl3veeE1sBza6WY
         wMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Hd79kCIj2rbbekeZ7gtDQi5bpLgV8QHFQ4Qp+/wkfjw=;
        b=mE9l2CsakNkaa86znKIu3LDTvDktLtAWPsgtsL6FcEy264rkf9czqNAi6dFKn0z6Mw
         aCNxtCiAYGz03XNtCM28fm0wNf24APzu5o9UlnI8JRrAGDCOr3jPfzWwEkjTw2944BN+
         YTUf+C+i+Bzdv9AcCMNF2b5TomdsmGqnFtEkvW78xe6gES5flmclJAKzy/uuzm38d4bZ
         1qFYCZtVkoDfheP0e4tDuZ+jNcd9Iw/U8PZ1OvPZWjWqBQaLudNzb0s+Sj6NQVH8+r2u
         0r3bvhzNVXMpHQveTnrM6TgELgL1nnTo2lp8HD+RXi5DICA2h8mhwnJQOuvloPUOHyRN
         dPbQ==
X-Gm-Message-State: APt69E3rnd7qMILu1WiwfBvApM2UcwwaK62DcArxG/XHVHkRblJ/n+FG
        qIzbkbwZdCfERabR/90H45eDNfJW2C2H15nDPDQ=
X-Google-Smtp-Source: ADUXVKIDCUyQ4crnu6bvRCqEqDuMKtPKQEaJEXVoyGsCGDSa0gvvYdWdGGTZuCvSp43xgZMSjbe5hVqle7PGGYALpjk=
X-Received: by 2002:ac8:3886:: with SMTP id f6-v6mr9336385qtc.165.1527839597444;
 Fri, 01 Jun 2018 00:53:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 00:53:17 -0700 (PDT)
In-Reply-To: <20180531195252.29173-9-avarab@gmail.com>
References: <87a7sg9sjz.fsf@evledraar.gmail.com> <20180531195252.29173-1-avarab@gmail.com>
 <20180531195252.29173-9-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Jun 2018 03:53:17 -0400
X-Google-Sender-Auth: nYYi0ompPEnPHba1ffzvZn8g8Yw
Message-ID: <CAPig+cQfw8-qJSt=Xbyxy1SUUDQZ-e1cGrG4g0KnO4zd7m+2dw@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] checkout: add advice for ambiguous "checkout <branch>"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 3:52 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> As the "checkout" documentation describes:
>
>     If <branch> is not found but there does exist a tracking branch in
>     exactly one remote (call it <remote>) with a matching name, treat
>     as equivalent to [...] <remote>/<branch.
>
> This is a really useful feature, the problem is that when you another

s/, the/. The/
s/you/& add/

> remote (e.g. a fork) git won't find a unique branch name anymore, and
> will instead print this nondescript message:
>
>     $ git checkout master
>     error: pathspec 'master' did not match any file(s) known to git
>
> Now it will, on my git.git checkout, print:
>
>     $ ./git --exec-path=3D$PWD checkout master
>     error: pathspec 'master' did not match any file(s) known to git.
>     hint: The argument 'master' matched more than one remote tracking bra=
nch.
>     hint: We found 26 remotes with a reference that matched. So we fell b=
ack
>     hint: on trying to resolve the argument as a path, but failed there t=
oo!
>     hint:
>     hint: Perhaps you meant fully qualify the branch name? E.g. origin/<n=
ame>

s/meant/& to/

>     hint: instead of <name>?
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> @@ -1269,6 +1270,16 @@ int cmd_checkout(int argc, const char **argv, cons=
t char *prefix)
> +               if (ret && dwim_remotes_matched > 1 &&
> +                   advice_checkout_ambiguous_remote_branch_name)
> +                       advise(_("The argument '%s' matched more than one=
 remote tracking branch.\n"
> +                                "We found %d remotes with a reference th=
at matched. So we fell back\n"
> +                                "on trying to resolve the argument as a =
path, but failed there too!\n"
> +                                "\n"
> +                                "Perhaps you meant fully qualify the bra=
nch name? E.g. origin/<name>\n"

s/meant/& to/

> +                                "instead of <name>?"),
