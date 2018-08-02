Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65BD1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 11:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbeHBNez (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 09:34:55 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39948 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731083AbeHBNez (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 09:34:55 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so2663776ita.5
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BalGt+GPKQGOgKrGZ4clIgQD54Ac4iM7x+pLny3QOYM=;
        b=nUfFJLCDiZDfKYVwcKxKmVwLmbWW9qcqtWSDAbXopDy6eW0VzvBxH5d16sEMUDNMbJ
         0Q5RT5xeFo/XUoALYmp5MBdccX6yMOySXnCFk96iJ+SR2KdKI27Ng8leNyZ0/YBJ5+Ot
         mEE//p3UIfvlOzPOJYWXFfwbHX/zc7GwjOko3bynZ0bIt/4THT25UXm5q0Tb9Yy/668G
         ET5911LiMW7oLxc5VnL38hXBUWYGTrba756NSWJSToknC7S3lmazEmxi3fFvML+gHg6D
         Kce2UBzZxjXGDXVfRkvWYQEL75x07r0EiXNJl0+9wrwf7UhAkgdNEbcCxrjBvJ7cdxmt
         vKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BalGt+GPKQGOgKrGZ4clIgQD54Ac4iM7x+pLny3QOYM=;
        b=PzyJjEi7Ajj+EEWBgykdhi6GCawkhCsJEL+oqwOIwJzt3W1M81RCT6N/7BIx2JtoH9
         Ai15FqWDj/lM2zN+1t7VVMPEfH8MkcHtDzLGE3DJ11FXt4fkTuY94cdlJCcWTRNn7BFw
         nI4Mqe8uHIWeyCreh0H4wpodLCRjyq3jk9Gxl9yeMVYUVzHopQLNbn/Lvjq772yFtpRV
         zGOqrhwnKylPaX60v2mkMjbqPJpbmVa4FCC/Zo7R0tfLdeLsd/EXHPxgk+T0+DEEKW2l
         Ryj1j33tb4clI7SdxxhmeeM3jvpqmrUBXgeViCV37a5OohvMl787s5hSN9ZCGaFM6mtV
         IPTA==
X-Gm-Message-State: AOUpUlEogrlrw960Pr5mEufIDHbvsFaCfcYhAeeF4vZ+WpEXgrrwunGp
        zV0NIH9/X2Rrb6QTu3celJKQIonv0GRqThqDfAEVSg==
X-Google-Smtp-Source: AAOMgpfXkprCNWQNYm5u7MQ2ipuO1bYsgGKLxxfndOZh/B+5cPAhPjwV+4Y37HJ2zxkhw5THZjq6QNbGDGrFUF0TX/s=
X-Received: by 2002:a24:282:: with SMTP id 124-v6mr1976862itu.151.1533210246985;
 Thu, 02 Aug 2018 04:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180731173651.184716-1-hanwen@google.com> <20180731173651.184716-3-hanwen@google.com>
 <CAPig+cSbibJ7i8LwJqPe06xJObnq6dJdMUnJoC1uAg4zUQq3KA@mail.gmail.com>
In-Reply-To: <CAPig+cSbibJ7i8LwJqPe06xJObnq6dJdMUnJoC1uAg4zUQq3KA@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 2 Aug 2018 13:43:53 +0200
Message-ID: <CAFQ2z_OZjGykJ6xUwXB69MSChJpPQzc0xBPDw82oA6+tOs00qQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Highlight keywords in remote sideband output.
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 10:21 PM Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
>
> On Tue, Jul 31, 2018 at 1:37 PM Han-Wen Nienhuys <hanwen@google.com> wrot=
e:
> > Highlight keywords in remote sideband output.
>
> Prefix with the module you're touching, don't capitalize, and drop the
> period. Perhaps:

Done.

>     sideband: highlight keywords in remote sideband output
>
> > The highlighting is done on the client-side. Supported keywords are
> > "error", "warning", "hint" and "success".
> >
> > The colorization is controlled with the config setting "color.remote".
>
> What's the motivation for this change? The commit message should say
> something about that and give an explanation of why this is done
> client-side rather than server-side.

Added

> > Co-authored-by: Duy Nguyen <pclouds@gmail.com>
>
> Helped-by: is more typical.

Done.

> > Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> > ---
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > @@ -1229,6 +1229,15 @@ color.push::
> > +color.remote::
> > +       A boolean to enable/disable colored remote output. If unset,
> > +       then the value of `color.ui` is used (`auto` by default).
>
> If this is "boolean", what does "auto" mean? Perhaps update the
> description to better match other color-related options.

All other doc entries say "boolean" here too. I'm happy to fix
phrasing of this file in a follow-on change, but let's keep it like
this for consistency.

> > diff --git a/sideband.c b/sideband.c
> > @@ -1,6 +1,97 @@
> > +void maybe_colorize_sideband(struct strbuf *dest, const char *src, int=
 n)
> > +{
> > +       int i;
> > +
> > +       load_sideband_colors();
> > +       if (!want_color_stderr(sideband_use_color)) {
> > +               strbuf_add(dest, src, n);
> > +               return;
> > +       }
>
> Can load_sideband_colors() be moved below the !want_color_stderr() condit=
ional?

Reorganized this a bit.

> > +
> > +       while (isspace(*src)) {
> > +               strbuf_addch(dest, *src);
> > +               src++;
> > +               n--;
> > +       }
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(keywords); i++) {
> > +               struct kwtable* p =3D keywords + i;
> > +               int len =3D strlen(p->keyword);
>
> Would it make sense to precompute each keyword length so you don't
> have to recompute them repeatedly, or is that premature optimization?

That is premature optimization.  The next line does a strncasecmp on
the same data so the cost (loading the keywords into CPU cache) is the
same, while precomputing the length makes the code more error prone.

> > +               if (!strncasecmp(p->keyword, src, len) && !isalnum(src[=
len])) {
>
> So, the strncasecmp() is checking if one of the recognized keywords is
> at the 'src' position, and the !isalnum() ensures that you won't pick
> up something of which the keyword is merely a prefix. For instance,
> you won't mistakenly highlight "successful". It also works correctly
> when 'len' happens to reference the end-of-string NUL. Okay.

added comment.

> > +                       strbuf_addstr(dest, p->color);
> > +                       strbuf_add(dest, src, len);
> > +                       strbuf_addstr(dest, GIT_COLOR_RESET);
> > +                       n -=3D len;
> > +                       src +=3D len;
> > +                       break;
> > +               }
>
> So, despite the explanation in the commit message, this function isn't
> _generally_ highlighting keywords in the sideband. Instead, it is
> highlighting a keyword only if it finds it at the start of string
> (ignoring whitespace). Perhaps the commit message could be more clear
> about that.

updated message.

> A natural follow-on question is whether strings are fed to this
> function one line at a time or if the incoming string may have
> embedded newlines (in which case, you might need to find a prefix
> following a newline, as well?).

added comment.

--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
