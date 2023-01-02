Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6C4C4167B
	for <git@archiver.kernel.org>; Mon,  2 Jan 2023 06:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjABGel (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Jan 2023 01:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjABGej (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2023 01:34:39 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A9CD56
        for <git@vger.kernel.org>; Sun,  1 Jan 2023 22:34:37 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id t15so29386048ybq.4
        for <git@vger.kernel.org>; Sun, 01 Jan 2023 22:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P2uxe8m8MrMbQpeZJ21cl6mANNJxSkEybNFpEDpCXFw=;
        b=f4rJtbE/SSjazY/GOgWuUOOP72mA0VlBh9LHbIlt6pDklYp/uni3ZC1vinDPeIBmER
         12Xdn6lOczA6TlTI35C+KNL2zrb9n3H5lv+BC/wAbQDebwSv5HEKAT1MurNRaEH8FGuS
         w8IdZ8jAGZ81Cs0TcuEAjC4sFaDPbd8/WX16CRUTiiDRUvoxmSIYz0BvMorqtkypITnj
         z6OssDrCQ162OHNMmDq6ZZCBDqqN/AiLkS327+bhCBl6ev7npizWznh2Tk26bH5ibf0p
         WavzAJ9GZY0cY61tyRs8F7FCIqOOA+htLD/zVew+VeDCZq6lA+K3UHaOTpve6/AFa5Xv
         3EjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2uxe8m8MrMbQpeZJ21cl6mANNJxSkEybNFpEDpCXFw=;
        b=cNVOmkvKWaVZ/FDPP5+YkDBRHFCrOH92Lv3tn7tZlEw2HRuCo7OwxdykBGpi499HzE
         YSg6+Lkod0PI/MntamPIc61bL1HxJWObkDFSPscFplMbqsOnhwNdy/Hoz1WkE8oeZ33B
         9JA4wFHTBzi743Drl2vTtb6Ei4Bpb/g8Cgu8TxbzT0/+shzqIFAXGHXrrA2w190WhjJD
         r+SGbJeMbhEpT7BC5aUevJQ1yDGZEeWuJZsSWe4BC9y/4g96Q/jOvsJPkm5+XGLZKxGY
         gM3gGAe41+0uLjkxm7HvcvuEVXt+oPitPnYrhozDjGnzsBhjIG4FU5mnR/HnRlg4cCgT
         DBHA==
X-Gm-Message-State: AFqh2koal8KS4j1WKcywjShypCNYGP1YXKq3wOj+K8iXquOdhwIydGEz
        03rLuBIPQTKYarJfnCpt+FtOIYQQGQVQwubL/Fc=
X-Google-Smtp-Source: AMrXdXtO2FBWqBbURYafdM/rTnfTN+n6+4hJRnFFaXvoVbcs5yPDg9PKSFmLB8+hgzka2M7lw3MuXSO7nzBTIQrcdMs=
X-Received: by 2002:a25:d209:0:b0:738:fe3:1e3a with SMTP id
 j9-20020a25d209000000b007380fe31e3amr4519554ybg.103.1672641276996; Sun, 01
 Jan 2023 22:34:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.git.1672102523902.gitgitgadget@gmail.com> <Y6qMk3e+FqEThL5f@coredump.intra.peff.net>
In-Reply-To: <Y6qMk3e+FqEThL5f@coredump.intra.peff.net>
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Mon, 2 Jan 2023 01:34:26 -0500
Message-ID: <CA+PPyiF3GzcnsuX6amUiaCa8onFVqMAO=naE4krpibip-c4bxw@mail.gmail.com>
Subject: Re: [PATCH] ref-filter: add new atom "signature" atom
To:     Jeff King <peff@peff.net>
Cc:     nsengaw4c via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> diff --git a/ref-filter.c b/ref-filter.c
> index a4c3f89f64..3b3592acb2 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -405,8 +405,9 @@ static int subject_atom_parser(struct ref_format *format UNUSED,
>         return 0;
>  }
>
> -static int signature_atom_parser(struct ref_format *format, struct used_atom *atom,
> -                              const char *arg, struct strbuf *err)
> +static int signature_atom_parser(struct ref_format *format UNUSED,
> +                                struct used_atom *atom,
> +                                const char *arg, struct strbuf *err)
>  {
>         if (arg) {
>                 if (!strcmp(arg, "signer"))
>
> This will eventually be necessary once we turn on -Wunused-parameter.
> I'm preparing a patch to convert all of the other parsers that need it,
> and I don't want to create a dependency between the two patches (it's OK
> for you to add the UNUSED now, it's just not enforced yet).
>
> I can also circle back after your patch is merged and add it, but it's a
> bit easier to do it up front.

Thanks, worked on it

> +{
> +     if (arg) {
> +             if (!strcmp(arg, "signer"))
> +                     atom->u.signature.option = S_SIGNER;
> +             else if (!strcmp(arg, "grade"))
> +                     atom->u.signature.option = S_GRADE;
> +             else if (!strcmp(arg, "key"))
> +                     atom->u.signature.option = S_KEY;
> +             else if (!strcmp(arg, "fingerprint"))
> +                     atom->u.signature.option = S_FINGERPRINT;
> +             else if (!strcmp(arg, "primarykeyfingerprint"))
> +                     atom->u.signature.option = S_PRI_KEY_FP;
> +             else if (!strcmp(arg, "trustlevel"))
> +                     atom->u.signature.option = S_TRUST_LEVEL;
> +             else
> +                     return strbuf_addf_ret(err, -1, _("unknown %%(signature) argument: %s"), arg);
> +     }

The ref-filter code recently got a helper function to report this kind
of argument error consistently, via dda4fc1a84 (ref-filter: factor out
"unrecognized %(foo) arg" errors, 2022-12-14). If you rebase the patch
on the current master, you can just do:

  return err_bad_arg(err, "signature", arg);

which will make the error message match the others (which in turn saves
>
> work for translators).

Thanks for this, I have seen it too


On Tue, Dec 27, 2022 at 1:11 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Dec 27, 2022 at 12:55:23AM +0000, nsengaw4c via GitGitGadget wrote:
>
> > This only works for commits. Add "signature" atom with `grade`,
> > `signer`, `key`, `fingerprint`, `primarykeyfingerprint`, `trustlevel`
> > as arguments. This code and it's documentation are inspired by
> > how the %GG, %G?, %GS, %GK, %GF, %GP, and %GT pretty formats were
> > implemented.
>
> I don't have a real review for you, but rather two small requests since
> I was working in this area recently.
>
> > @@ -378,6 +383,30 @@ static int subject_atom_parser(struct ref_format *format, struct used_atom *atom
> >       return 0;
> >  }
> >
> > +static int signature_atom_parser(struct ref_format *format, struct used_atom *atom,
> > +                            const char *arg, struct strbuf *err)
>
> Can you squash in an annotation for the unused parameter, like this:
>
> diff --git a/ref-filter.c b/ref-filter.c
> index a4c3f89f64..3b3592acb2 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -405,8 +405,9 @@ static int subject_atom_parser(struct ref_format *format UNUSED,
>         return 0;
>  }
>
> -static int signature_atom_parser(struct ref_format *format, struct used_atom *atom,
> -                              const char *arg, struct strbuf *err)
> +static int signature_atom_parser(struct ref_format *format UNUSED,
> +                                struct used_atom *atom,
> +                                const char *arg, struct strbuf *err)
>  {
>         if (arg) {
>                 if (!strcmp(arg, "signer"))
>
> This will eventually be necessary once we turn on -Wunused-parameter.
> I'm preparing a patch to convert all of the other parsers that need it,
> and I don't want to create a dependency between the two patches (it's OK
> for you to add the UNUSED now, it's just not enforced yet).
>
> I can also circle back after your patch is merged and add it, but it's a
> bit easier to do it up front.
>
> > +{
> > +     if (arg) {
> > +             if (!strcmp(arg, "signer"))
> > +                     atom->u.signature.option = S_SIGNER;
> > +             else if (!strcmp(arg, "grade"))
> > +                     atom->u.signature.option = S_GRADE;
> > +             else if (!strcmp(arg, "key"))
> > +                     atom->u.signature.option = S_KEY;
> > +             else if (!strcmp(arg, "fingerprint"))
> > +                     atom->u.signature.option = S_FINGERPRINT;
> > +             else if (!strcmp(arg, "primarykeyfingerprint"))
> > +                     atom->u.signature.option = S_PRI_KEY_FP;
> > +             else if (!strcmp(arg, "trustlevel"))
> > +                     atom->u.signature.option = S_TRUST_LEVEL;
> > +             else
> > +                     return strbuf_addf_ret(err, -1, _("unknown %%(signature) argument: %s"), arg);
> > +     }
>
> The ref-filter code recently got a helper function to report this kind
> of argument error consistently, via dda4fc1a84 (ref-filter: factor out
> "unrecognized %(foo) arg" errors, 2022-12-14). If you rebase the patch
> on the current master, you can just do:
>
>   return err_bad_arg(err, "signature", arg);
>
> which will make the error message match the others (which in turn saves
> work for translators).
>
> -Peff
