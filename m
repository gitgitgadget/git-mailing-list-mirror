Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AC011F462
	for <e@80x24.org>; Mon, 29 Jul 2019 01:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfG2BsW (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 21:48:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43900 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfG2BsW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 21:48:22 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so116548743ios.10
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 18:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FGWn7LjZxZDRC8UiGS7I6k3eRb4SZqcVfdo2KvWko7o=;
        b=H/9dJkQR3+VmX/YgefBa4WLv4XCDrIteWk56W6q9f3MkU1Ah2KwEkew3XkhQDj8/8Z
         qdozHrEQeDfr4KVoOSSQu/JuC/I8Kx8/YH7kji2PrnzXK2U3bLr3RQ2Ervh2QM9UPWJI
         0kqXvM8gh/SO6hvUhzzCvUxATsQGEwE+6vhIuoAr57g097ElhsTh9cV1z1wWOP+0htOq
         c44ZwQ3zyOB3n27aHteqcP4knS2bBFOUIatEOMX4fkvciZy4dLJXzvUfBveyryH0clpA
         n7UzVt3ayCzfBD0kYafDk2ST6OiCEye4Kiz3W9aiw9Bnap4AUIUxJd0OwJO5tluuqkcx
         lUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FGWn7LjZxZDRC8UiGS7I6k3eRb4SZqcVfdo2KvWko7o=;
        b=Civ5jGcmOk1h0EAq8J+3o+zUAVEz4F+JW2FKK5LOcaaMCn/3Pxhokwi0AQUqQyPswo
         2aPBmjRJiqMHDcRhRCS0wWVYXi4ru10o4GDbClFtwgW8n4/rpoGRw6nB+gkpkNI4uY2c
         WjrOGhwca8UNaGZs4eg7So9gSFbvMPzMIEcBp7kWfDP9+aUOeAvM51hTMWpTlMINd+vp
         qfDkr+7O+VAiG/CdCKNTrX8+dlfFn7H6NX8X3l+2ggNsAb5dQoOwoJqX0eQJ0Y/yF1mL
         a5Z50m2xrvrhgJjsj10xDIGzXU+2GCICQwOSuLaiaPBLSiX5Abey3wC0gn9uNvP37+/u
         TN2w==
X-Gm-Message-State: APjAAAX4wQ6Gje+ZVAiKK0vGSIwCsjnZoiqgTmXgp6akAvphOPf+FKnZ
        nQLUD87OArTD+BfFcNa2Ao+WF/ESUjoF+bZrwhA=
X-Google-Smtp-Source: APXvYqxhxrRiIrvhMPQi28LUmQoD2AxjJCij/Ocxj0sOAS80a3WQpcQK99Tru45SE6RO/UjB2zsoflBcEXye7AK1FqY=
X-Received: by 2002:a5d:968b:: with SMTP id m11mr52185070ion.16.1564364901255;
 Sun, 28 Jul 2019 18:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190724151415.3698-1-avarab@gmail.com> <20190726150818.6373-5-avarab@gmail.com>
In-Reply-To: <20190726150818.6373-5-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 28 Jul 2019 18:48:10 -0700
Message-ID: <CAPUEspgay3RnLH3pdEWyktgn8XeuiKZ8PYPNB_38gyxffmh5Jw@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] grep: consistently use "p->fixed" in compile_regexp()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 8:09 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> It's less confusing to use that variable consistently that switch back
> & forth between the two.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  grep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/grep.c b/grep.c
> index 9c2b259771..b94e998680 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -616,7 +616,7 @@ static void compile_regexp(struct grep_pat *p, struct=
 grep_opt *opt)
>                 die(_("given pattern contains NULL byte (via -f <file>). =
This is only supported with -P under PCRE v2"));
>
>         pat_is_fixed =3D is_fixed(p->pattern, p->patternlen);
> -       if (opt->fixed || pat_is_fixed) {
> +       if (p->fixed || pat_is_fixed) {

at the end of this series we have:

  if (p->fixed || p->is_fixed)

which doesn't make sense; at least with opt->fixed it was clear that
what was meant is that grep was passed -P

maybe is_fixed shouldn't exist and fixed when applied to the pattern
means we had determined it was a fixed
pattern and overridden the user selection of engine.

that at least will give us a logical way to fix the pattern reported
in [1] and that currently requires the user to know
git's grep internals and know he can skip the "is_fixed" optimization
by doing something like :

  $ git grep 'foo[ ]bar'

Carlo

[1] https://public-inbox.org/git/20190728235427.41425-1-carenas@gmail.com/
