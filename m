Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 881411F516
	for <e@80x24.org>; Sun,  1 Jul 2018 05:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeGAFeR (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 01:34:17 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:39722 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeGAFeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 01:34:16 -0400
Received: by mail-ua0-f194.google.com with SMTP id n4-v6so8181755uad.6
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 22:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ekbiq5jFuJ8QLNj4dHBiGH3nk2m6DVkBGsUCtwSscYg=;
        b=WZ2Z0uD4O6IfomzOf66M2FR4Rcni+N1cRjK9dC58pow9ZFqBFsOGBdxQrp2+zzoF8l
         a0ojEpXCfbdoU0wANW35NTBEb4qwTUMwcPo20Tsi/e8FLKRPLgaXiAIYpvfPd3HDUMj4
         MEnlNtyR1zLi6n6o9y/fJUJlvO7THdtx3b5k6zGJGd/ej/V1VAN1bJmTXFy0g2AcjnoV
         YCUTtiT0AHONWtsgIOHqrEMvAwlXj10gjClllbTtTluqlZXRCsqAYPGNgf+BkeCvVo/V
         DMaFCDF4wnfK807Tt+DcSL4PJP8nGJnAxCGSJM6+BN+vlGTEz63j8sotetv/++6iv+c6
         WjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ekbiq5jFuJ8QLNj4dHBiGH3nk2m6DVkBGsUCtwSscYg=;
        b=QshTG7D4XU638uP9VEJDin8DuEapqxidfMJSKTmoQFpIZ09yAMM9y9bxPz+IJxcnIG
         OwU8i6YMHNakorDBBaOg5oL8GnfD//JnTPjGjMe1nD7vIO9LHIm0UoLeA/LwhHZIWp3/
         G7fIiGFbDk6hxFWIDMfxJnyfxrJo96ijgdtUvh6g/H8NUBZI+NQ7pwJ/pskIFfDWSSaL
         ePDQtgWV5dqLbYQUWMXkxFkx8WR5ig/+0RJ6fgHDAtIdRI1Y3BzKKWJKWQDBZGEdXR+e
         JW1XrwAIxrBaoQqaITs0KB/thT1JISkrYsG8VL1u932UdDwh8B386hdvo9Yf6oQuak8P
         zWXw==
X-Gm-Message-State: APt69E2auXldqPsmfQBablBoTee6rk0LNmmzrGTJiD9BLahkZkepWjmA
        1YKA3kP+qKVjK4jQTGIMqpni+CfRgN6lBF+ifEo=
X-Google-Smtp-Source: AAOMgpc10dfreeCJpjpMaQ52246hoUjfbWXG+phCIo0F6fbFyjERZDmeBtm/lQUjDoZTBeb+FWDwJ1bOsY/XfMBoLb4=
X-Received: by 2002:a9f:3666:: with SMTP id s35-v6mr3237304uad.94.1530423254737;
 Sat, 30 Jun 2018 22:34:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 22:34:14
 -0700 (PDT)
In-Reply-To: <20180630090818.28937-8-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com> <20180630090818.28937-8-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 30 Jun 2018 22:34:14 -0700
Message-ID: <CABPp-BEQyEeYvE_JVDeVTWQSpOYj8pCzELQY6dpaz4p2S9d0NQ@mail.gmail.com>
Subject: Re: [PATCH 07/23] builtin/replace.c: mark more strings for translation
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 30, 2018 at 2:08 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  builtin/replace.c | 82 +++++++++++++++++++++++------------------------
>  1 file changed, 41 insertions(+), 41 deletions(-)
>

> -               return error("invalid replace format '%s'\n"
> -                            "valid formats are 'short', 'medium' and 'lo=
ng'\n",
> +               return error(_("invalid replace format '%s'\n"
> +                              "valid formats are 'short', 'medium' and '=
long'"),

Was the removal of the trailing newline intentional?  If so, move it to pat=
ch 1?

> @@ -456,10 +456,10 @@ static int create_graft(int argc, const char **argv=
, int force, int gentle)
>                 return -1;
>         }
>
> -       if (remove_signature(&buf)) {
> -               warning(_("the original commit '%s' has a gpg signature."=
), old_ref);
> -               warning(_("the signature will be removed in the replaceme=
nt commit!"));
> -       }
> +       if (remove_signature(&buf))
> +               warning(_("the original commit '%s' has a gpg signature.\=
n"
> +                         "The signature will be removed in the replaceme=
nt commit!"),
> +                       old_ref);

More message changes that probably belong in patch 1 for consistency.
