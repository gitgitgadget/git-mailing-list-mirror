Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6F431F42D
	for <e@80x24.org>; Sun, 20 May 2018 09:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750928AbeETJQA (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 05:16:00 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35729 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeETJP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 05:15:59 -0400
Received: by mail-pl0-f66.google.com with SMTP id i5-v6so7029191plt.2
        for <git@vger.kernel.org>; Sun, 20 May 2018 02:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FgcbL5BbXa5Y2OQ4uI36IrQvS4ZE1rpzrU3elcym+fE=;
        b=BJFF2sjahgj6DaC1Qn0gGGYSCOYdbtGvrazpYv87SzxxgUQFvWBDvcu5B1LO2JwmUb
         ttbXbc+/xHBoys6JM//2TQQ7UhMsVhlMvvVMUlUV72XOH1Hh5u8EmL7vOpFJS5XJoEUU
         gD+LiMHiwD9CoK+hnfpode6Wxv9jxIAbE8pmJC3fNzhpxXRvLx7Pn6vrqVTBYE/pGgDW
         16mp1OteUI4gIhSNbjjK4zwdeDTub5KeNgeqJtZfg4Qtz0d08lsJfBbBeYoT+YT8ahou
         EDr8ANuugwsVaeIuAGpI99AOr3YVCWxnfDoZhHmRYrC/uOiHE0G7LzjVGthw3hKO1emx
         lbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FgcbL5BbXa5Y2OQ4uI36IrQvS4ZE1rpzrU3elcym+fE=;
        b=KIauenuwUnM67KUQb7F0BjAPUjGVRRsOMZuk64RiF0yq04rcc/Ht6fqJHvy/YH3wdM
         H1uRg9Ho0mdvd870EoBh8x42r3HmZa81cgVJPmH9xQZf8IH4PI+PlziZaNGtxP5j/hjc
         APvFtgjXzqPcLY9mJa7pJYzbBdahDVPVkTdHY5Be3pyqMhQsviGmzXEzon5uSP06c05v
         kTSTrHPTgGsU+38+BEvRbduI1vP5EnNVjV/Cr4pbSJXzy/g0kSXihk/Cif4rh4NFTDMH
         PZViARrt9bUWaC45Zo+mzzyVOHTdzOXOYThUn5Ve99y/2Ii9eELci0OJYNJra2onAAT1
         H1kA==
X-Gm-Message-State: ALKqPwcjDPbwIQd/ZrmKV1vpcrLz/Op7k4vF/1WTMHiwSu2fwLccIfFz
        iZXgy7V25Owc/BChtLPNmMOhXMiOmowni+0tNBOqHFKh
X-Google-Smtp-Source: AB8JxZrmsEMfRi5t8ZUJDdNTU2+5aBbWKnK1TtJ0uVhMlmjE8JSHm0iuqwn9BRq0ZevjyuE9eF1g/J2znWGa5HQA0mE=
X-Received: by 2002:a17:902:284b:: with SMTP id e69-v6mr15733161plb.240.1526807759338;
 Sun, 20 May 2018 02:15:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Sun, 20 May 2018 02:15:58 -0700 (PDT)
In-Reply-To: <20180520081244.14619-1-pclouds@gmail.com>
References: <20180520081244.14619-1-pclouds@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 20 May 2018 11:15:58 +0200
Message-ID: <CAN0heSpdtiUVSYGsT+VnUaSy0BO+p+mnod6Ut4Y3UrNVVQkrbA@mail.gmail.com>
Subject: Re: [PATCH] Use OPT_SET_INT_F() for cmdline option specification
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 May 2018 at 10:12, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds=
@gmail.com> wrote:
> The only thing these commands need is extra parseopt flags which can be
> passed in by OPT_SET_INT_F() and it is a bit more compact than full
> struct initialization.

> diff --git a/archive.c b/archive.c
> index 93ab175b0b..4fe7bec60c 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -411,11 +411,9 @@ static void parse_treeish_arg(const char **argv,
>  }
>
>  #define OPT__COMPR(s, v, h, p) \
> -       { OPTION_SET_INT, (s), NULL, (v), NULL, (h), \
> -         PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, (p) }
> +       OPT_SET_INT_F(s, NULL, v, h, p, PARSE_OPT_NONEG)
>  #define OPT__COMPR_HIDDEN(s, v, p) \
> -       { OPTION_SET_INT, (s), NULL, (v), NULL, "", \
> -         PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN, NULL, (p)=
 }
> +       OPT_SET_INT_F(s, NULL, v, "", p, PARSE_OPT_NONEG | PARSE_OPT_HIDD=
EN)

Right. We have NULLs in the fifth and the second-to-last positions, and
we use PARSE_OPT_NOARG.  By switching to OPT_SET_INT_F we get those for
free.

Do we want to keep "(s)" instead of "s", just to be safe? And same for
"(v)", "(p)". Macro expansion always makes me paranoid.

> diff --git a/builtin/am.c b/builtin/am.c
> index d834f9e62b..666287b497 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2231,12 +2231,12 @@ int cmd_am(int argc, const char **argv, const cha=
r *prefix)
>                         N_("pass -b flag to git-mailinfo"), KEEP_NON_PATC=
H),
>                 OPT_BOOL('m', "message-id", &state.message_id,
>                         N_("pass -m flag to git-mailinfo")),
> -               { OPTION_SET_INT, 0, "keep-cr", &keep_cr, NULL,
> -                 N_("pass --keep-cr flag to git-mailsplit for mbox forma=
t"),
> -                 PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1},
> -               { OPTION_SET_INT, 0, "no-keep-cr", &keep_cr, NULL,
> -                 N_("do not pass --keep-cr flag to git-mailsplit indepen=
dent of am.keepcr"),
> -                 PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
> +               OPT_SET_INT_F(0, "keep-cr", &keep_cr,
> +                       N_("pass --keep-cr flag to git-mailsplit for mbox=
 format"),
> +                       1, PARSE_OPT_NONEG),
> +               OPT_SET_INT_F(0, "no-keep-cr", &keep_cr,
> +                       N_("do not pass --keep-cr flag to git-mailsplit f=
or mbox format"),
> +                       0, PARSE_OPT_NONEG),

I found `-w` and `--word-diff` useful. You actually change the N_("...")
for `--no-keep-cr` here: [-independent of am.keepcr-]{+for mbox format+}
Copy-paste mistake?

Other than that, `--word-diff` has a very structured appearance and
nothing stood out. The ordering is different (f goes at the end in the
post-image), which makes the diff busier than it would have had to be.
(That's obviously nothing this patch can do anything about.)

Martin
