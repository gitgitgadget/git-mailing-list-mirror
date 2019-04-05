Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDAC620248
	for <e@80x24.org>; Fri,  5 Apr 2019 09:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfDEJ0h (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 05:26:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46969 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbfDEJ0h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 05:26:37 -0400
Received: by mail-io1-f66.google.com with SMTP id p23so3830031iol.13
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 02:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0QSiniKAotBtiRWaLeeaosFkIjboPcuZHd5MBKpLf9s=;
        b=MY3dkFJqvz3Id5B8XYy+kAjfc1EgeZIY8mk0GMojkHilRy/HAx5qppo3fbv0kdLkOM
         BP4Fw9GXgce2WMcSRH+HBkEcgUPLfpiPvAqraPJZC31IT82haHXKHTK7IIImXkxinkCN
         vtpQi7zYBVlV4bLwbH0O0vboQ6GZ1Q8JEd2J+sseUWEKGfU07w3dTY1AbbvypJ7MOIFw
         4ANI8iZA/Hlm5alUjlD96iCmrKzCS9k4T5/xD/7QH6p8QTj8qRNvwX+w0qJcTMrJ0Rnf
         SRthzgwm5AdtD6e5sSSyfKkdHP4UADA1RZgqYUSk+UmVQMRDprYELW7NFC6Smmix5j05
         RMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0QSiniKAotBtiRWaLeeaosFkIjboPcuZHd5MBKpLf9s=;
        b=i9JDERMnI6F26nKGIHC6MPCHDMoMxZQjIHrhhn8EssbrEGyW8trbAFrezNeCtrV/AW
         omcJ+QKDFVf993Z7Gk11xMna5jhyu7wh8uTknVJ5ZKz56MWg/G3b3hXevI6grRXgodBq
         ViJlMKY9e0hFEBJpI5fFtNOO/KfKXDlq4oEayRNR9/JtXrbpqa8+Fku5MOSei5EH68H4
         oHADfDk2L+Dm9HB5fx01Xsvm+YUtVYwsJ9xYDPpN6jZJSXDUUG8tKFss7lBOm6/asbAq
         uKHlvzJzjLfojx9ONGkMFyVkq6W0xbhx2x8Az8scOvSmArM3Dat8mQLmOaOo8Q1HEC18
         zHVQ==
X-Gm-Message-State: APjAAAWpt61eGhFfBy5PE2DKz4tmK+2/JcI9MkE+AnONJ3I65CeZ6ncI
        EsNPomMzhD3zQp2RLfy1Fnsg3Hhvmkuai14EdbI5eA==
X-Google-Smtp-Source: APXvYqxmBmAaZ89XyTV0KCJL2Y6fsxoyQDaZznOsy4YYobGyRX4i1Pgr5j9IQpdEdQy1aDpO0rieg4XaJxFXykVCsp4=
X-Received: by 2002:a5e:9805:: with SMTP id s5mr8238481ioj.149.1554456396330;
 Fri, 05 Apr 2019 02:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190330111927.18645-1-pclouds@gmail.com> <20190403113457.20399-1-pclouds@gmail.com>
 <20190403113457.20399-2-pclouds@gmail.com> <20190404172515.GR32732@szeder.dev>
In-Reply-To: <20190404172515.GR32732@szeder.dev>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 5 Apr 2019 16:26:10 +0700
Message-ID: <CACsJy8C5K15QOeAJmPBb-VkcJnAiha9BNuUwVAL_mH_y6YBjow@mail.gmail.com>
Subject: Re: [PATCH v2 01/32] rebase: 'make coccicheck' cleanup
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 5, 2019 at 12:25 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Wed, Apr 03, 2019 at 06:34:26PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> > ---
> >  builtin/rebase.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 77deebc65c..c064909329 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -1592,8 +1592,7 @@ int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
> >                               branch_name =3D options.head_name;
> >
> >               } else {
> > -                     free(options.head_name);
> > -                     options.head_name =3D NULL;
> > +                     FREE_AND_NULL(options.head_name);
> >                       branch_name =3D "HEAD";
> >               }
> >               if (get_oid("HEAD", &options.orig_head))
> > @@ -1793,7 +1792,7 @@ int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
> >        * we just fast-forwarded.
> >        */
> >       strbuf_reset(&msg);
> > -     if (!oidcmp(&merge_base, &options.orig_head)) {
> > +     if (oideq(&merge_base, &options.orig_head)) {
> >               printf(_("Fast-forwarded %s to %s.\n"),
> >                       branch_name, options.onto_name);
> >               strbuf_addf(&msg, "rebase finished: %s onto %s",
>
> You are already using Coccinelle v1.0.7, aren't you?

No it's 1.0.5. I guess I should upgrade then.

> For some reason previous versions don't notice these two
> transformations.  I have patches with these transformations lying
> around here for some time now, but haven't submitted them yet, because
> I don't really like the way I run Coccinelle v1.0.7 in our static
> analysis CI build jobs [1]
>
> Anyway, here are my commit messages for these transformations, please
> feel free to re-use them:

I'm not sure if even more elaboration is needed. It looks so trivial
(and at least obvious to me). But if you or Junio (or anybody else)
insists, I'll resend with updated commit messages. Or I can drop this
patch too if you have more cocci patches to send soon.

>
>   -- >8 --
>
> Subject: builtin rebase: use oideq()
>
> Use oideq() instead of !oidcmp(), as it is more idiomatic, and might
> give the compiler more opportunities to optimize.
>
> Patch generated with 'contrib/coccinelle/free.cocci' and Coccinelle
> v1.0.7 (previous Coccinelle versions don't notice this).
>
>   -- 8< --
>
> Subject: builtin rebase: use FREE_AND_NULL
>
> Use the macro FREE_AND_NULL to release memory allocated for
> 'head_name' and clear its pointer.
>
> Patch generated with 'contrib/coccinelle/free.cocci' and Coccinelle
> v1.0.7 (previous Coccinelle versions don't notice this).
>
>   -- >8 --
>
>
> [1] https://github.com/szeder/git/commits/travis-coccinelle
>


--=20
Duy
