Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DE191F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbeHMVH2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:07:28 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:32768 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbeHMVH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:07:28 -0400
Received: by mail-yw1-f68.google.com with SMTP id c135-v6so14297646ywa.0
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7O91r8/QUSl7tbK0HETC4GE4xonErfKdInW7bxh0Wo=;
        b=iHlJ6RxmzE7S0SBLFB8wS3S/u+pjE0J3OW7jZkpfjb7WqipGxd5nUFnRGv9jtX+VIY
         fM0t6EyuHLl9yRbQTbV3qJbBQufR50URL8+hCKwM7mC42GnLgVEvKmU656edFANYWZXp
         VkSpJVJGnRiMUK71dD6/rwq+WMYvsg2Xul3L6Bjo/XlIJBbzC7da/v+DMvA7rD5clxT2
         EwcI/wLoI7bs97wUgZo6BgdD8+RPnZwt46Pfbrwi8g8HwyWqxCM+tFUTLVY4Neku/K2M
         Z+B0AvqZtRrTayR3EjPZVdQVVXDIcZAu35+/MWmdqeGJj6MzcrWdPW83Mfcm1xHusrGR
         vXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7O91r8/QUSl7tbK0HETC4GE4xonErfKdInW7bxh0Wo=;
        b=WCi3L/KGsU6qdMj0GaKvi9hlfdq1OZvkvMtTfSyVqwIs5iqIpjmWXJQ2GYhYDfhSSC
         0koJKZmPCioLR0qPL0J1V3m6PVfsSlEcGluQ//60MeLFOkFAC9qBFTqORD7utfAUc2ay
         zupCNSERqnac9qdML6RI7dJ03CpPgFCMyG0jVDHiwUwfwxW0sH/ION0QOC98Dmq0csNL
         bWit3SMva6SunWWVTdWI5ExnV9LiHpbvv5qIlsr+cEjq2PCt8G7Rw3KHh3rl4HrsU33+
         BIVYod+22PvNYCRjmuRSlGYLXkpxk2aaPosCZOkTxtiijPbunx1gqHc4+H6YBwWtcJIO
         mC8Q==
X-Gm-Message-State: AOUpUlHdysFoUdG5QMr5ZB+En5ROEKgHBqFPf+IhwPfbFv25ENvdsE34
        EXE6jcDKIx3y1bDulr2sWBP+aDFIn4aUDRrxlYTPCg==
X-Google-Smtp-Source: AA+uWPy0IhwH94jQkqWO2tWdIiT2aOLj7ZHE7XNeJeNJAhIvZ02WbR2k7RtAE1G1UWXVLQ6J8RdrKNEyLxEcwQ7Hevg=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr9842771ywh.238.1534184645958;
 Mon, 13 Aug 2018 11:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180810224923.143625-1-sbeller@google.com> <20180810224923.143625-3-sbeller@google.com>
 <nycvar.QRO.7.76.6.1808131343310.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808131343310.71@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Aug 2018 11:23:55 -0700
Message-ID: <CAGZ79kbUKoVPXq_fz7YZMOcAWEe0uiZ04Fj9KD-J4eMmwjUXTw@mail.gmail.com>
Subject: Re: [PATCH 2/4] diff.c: add --output-indicator-{new, old, context}
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 4:47 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Steafn,
>
> On Fri, 10 Aug 2018, Stefan Beller wrote:
>
> > This will prove useful in range-diff in a later patch as we will be able to
> > differentiate between adding a new file (that line is starting with +++
> > and then the file name) and regular new lines.
>
> Very good!
>
> > It could also be useful for experimentation in new patch formats, i.e.
> > we could teach git to emit moved lines with lines other than +/-.
> >
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> >  diff.c | 21 +++++++++++++++++----
> >  diff.h |  5 +++++
> >  2 files changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/diff.c b/diff.c
> > index b3cb73eb69a..b75eb085cb3 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -1237,7 +1237,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
> >                                        struct emitted_diff_symbol *eds)
> >  {
> >       static const char *nneof = " No newline at end of file\n";
> > -     const char *context, *reset, *set, *set_sign, *meta, *fraginfo;
> > +     const char *context, *reset, *set, *set_sign, *meta, *fraginfo, *first;
> >       struct strbuf sb = STRBUF_INIT;
> >
> >       enum diff_symbol s = eds->s;
> > @@ -1288,7 +1288,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
> >                       else if (c == '-')
> >                               set = diff_get_color_opt(o, DIFF_FILE_OLD);
> >               }
> > -             emit_line_ws_markup(o, set_sign, set, reset, " ", line, len,
> > +             first = o->output_indicators[OI_CONTEXT] ?
> > +                     o->output_indicators[OI_CONTEXT] : " ";
> > +             emit_line_ws_markup(o, set_sign, set, reset, first, line, len,
>
> Instead of doing this over and over again, how about
>
> 1) setting o->output_indicators to " " in diff_setup()?

... and when parsing the command line options we could already overwrite it
  in place.

> 2) passing OI_CONTEXT to emit_line_ws_markup() instead of `first`? I.e.
>    change it to the index in the output_indicators, with -1 indicating
>    "none"?

That sounds like an elegant design, as then it is super clear that 'first'
can only ever be a sign (or character that we chose), but
giving -1 for "none" sounds cumbersome. I'll take a look into that.

> > +#define OI_NEW 0
> > +#define OI_OLD 1
> > +#define OI_CONTEXT 2
>
> I could imagine that OI_* is too generic a prefix, and that we would want
> to have a prefix that is less prone to collide with other global
> constants, such as OUTPUT_INDICATOR_*.

I agree on that; will take the suggestion of
OUTPUT_INDICATOR_*.
