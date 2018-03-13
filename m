Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14C1A1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 19:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeCMTSd (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 15:18:33 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33934 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbeCMTSc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 15:18:32 -0400
Received: by mail-pf0-f194.google.com with SMTP id j20so315478pfi.1
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 12:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7yNtNQ8P/aEqBW62FAEURm18zMs1Lrz5XajsGsR6XUA=;
        b=a0Uhxg+vhOU5Gyri82Liio/aZep+NUGHuH+oQnkh0ImI1WrW/D50x/wMMPxPCMLx00
         IXXJuvBee9sKwkclNvNmpmJlFqy3/VdaCTp+S4BOaROxM1Um2TjVCbJuTj7U4rpfcAlX
         cRlJ6mB+rh5sik9UDals/+20Bcidwwb5zivtRfreUgbKnfOVJxgMT9/nJlH2mlJBf9Fe
         /Su/d4iLQ5xjmbiWRTuSIAN4HNBCaEW0PyVLIIQzr9YB/y+0JMWFSCBCcEUEmyVUByUz
         XctXQPuK/3GCF/s+9AO3IaRGHpVedKVF+LWs+mXGbC4q3h57y9KojTRKTNi2Ht9xes1z
         4uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7yNtNQ8P/aEqBW62FAEURm18zMs1Lrz5XajsGsR6XUA=;
        b=kHLa2lD+dPXm3zRTFuPmGpHaCCuMuxY8RidKfW75t8UwnW8Sd9yyo/G2o0S64Sj3uJ
         VXWpeMv5ekTKELG2MsCSK+fA6/0zDuWGufulmotDvw9PJO+lgvqp6jjqfEeRmSKSvRpE
         8P6YjKv9NA4Op7JjsgNAccRfI36ASu8aHkAHlmw+O4X1AYcfGUxSqxhuIPjyT5pXFTJy
         04v5l6SHxq20HveFuNWGKv+8L0KEVI3J0OtV1h3qvVtMuTaQ+NR3S4HDsmdesYHwo23O
         AiVejNTE0KU3SfPYdpjVZZY6XD5R1s2Mlzd9lY9/iKsYzynK4lo3jsf3fvctQoBOvu9V
         VVxg==
X-Gm-Message-State: AElRT7GiDUY4eu3XjNH7z+XT54aQKuuUU6q+IW/3h3nKP5WulNMWXxhP
        luPKr0TvjXPBTCcMKPoNV5h9Db1/6TvdDIz1Xq/93Q==
X-Google-Smtp-Source: AG47ELvYO0lRxZ8MltBGmgVu027LFfA02ljPOeRFGgUmOu6v79PAeymQYFpccUJ101ENdrbIAqyZuh6RodiD6+ITJts=
X-Received: by 10.99.103.133 with SMTP id b127mr1355988pgc.155.1520968712202;
 Tue, 13 Mar 2018 12:18:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.191.144 with HTTP; Tue, 13 Mar 2018 12:18:31 -0700 (PDT)
In-Reply-To: <010201621edc982f-92123a33-386b-4b94-be0c-f793856e6c16-000000@eu-west-1.amazonses.com>
References: <010201621edc97a4-a4239b1e-86d2-4400-aaac-d81727710f4f-000000@eu-west-1.amazonses.com>
 <010201621edc982f-92123a33-386b-4b94-be0c-f793856e6c16-000000@eu-west-1.amazonses.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 13 Mar 2018 20:18:31 +0100
Message-ID: <CAN0heSrogCMT-8R4nht=_9syMNUfJe21BvZSVD4AUcf9PwN7rQ@mail.gmail.com>
Subject: Re: [RFC 3/4] ref-filter: change parsing function error handling
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 March 2018 at 11:16, Olga Telezhnaya <olyatelezhnaya@gmail.com> wrote:
> Continue removing any printing from ref-filter formatting logic,
> so that it could be more general.
>
> Change the signature of parse_ref_filter_atom() by changing return value,
> adding previous return value to function parameter and also adding
> strbuf parameter for error message.

I think the current return value is always non-negative. Maybe it would
be easier to leave the return value as-is, except return negative on
error? Unless I am missing something?

>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> ---
>  ref-filter.c | 45 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 13 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 07bedc636398c..e146215bf1e64 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -397,7 +397,8 @@ struct atom_value {
>   * Used to parse format string and sort specifiers
>   */
>  static int parse_ref_filter_atom(const struct ref_format *format,
> -                                const char *atom, const char *ep)
> +                                const char *atom, const char *ep, int *res,
> +                                struct strbuf *err)
>  {
>         const char *sp;
>         const char *arg;
> @@ -406,14 +407,18 @@ static int parse_ref_filter_atom(const struct ref_format *format,
>         sp = atom;
>         if (*sp == '*' && sp < ep)
>                 sp++; /* deref */
> -       if (ep <= sp)
> -               die(_("malformed field name: %.*s"), (int)(ep-atom), atom);
> +       if (ep <= sp) {
> +               strbuf_addf(err, _("malformed field name: %.*s"), (int)(ep-atom), atom);
> +               return -1;
> +       }
>
>         /* Do we have the atom already used elsewhere? */
>         for (i = 0; i < used_atom_cnt; i++) {
>                 int len = strlen(used_atom[i].name);
> -               if (len == ep - atom && !memcmp(used_atom[i].name, atom, len))
> -                       return i;
> +               if (len == ep - atom && !memcmp(used_atom[i].name, atom, len)) {
> +                       *res = i;
> +                       return 0;
> +               }
>         }

If you did so, this hunk above would not need to be changed ...

> @@ -458,7 +465,8 @@ static int parse_ref_filter_atom(const struct ref_format *format,
>                 need_tagged = 1;
>         if (!strcmp(valid_atom[i].name, "symref"))
>                 need_symref = 1;
> -       return at;
> +       *res = at;
> +       return 0;
>  }

... nor this one above ...

>                 if (!ep)
>                         return error(_("malformed format string %s"), sp);
>                 /* sp points at "%(" and ep points at the closing ")" */
> -               at = parse_ref_filter_atom(format, sp + 2, ep);
> +               if (parse_ref_filter_atom(format, sp + 2, ep, &at, &err))
> +                       die("%s", err.buf);

And this would be more like "if (at < 0) die(...)".

>         for (cp = format->format; *cp && (sp = find_next(cp)); cp = ep + 1) {
>                 struct atom_value *atomv;
> +               struct strbuf err = STRBUF_INIT;
> +               int pos;
>
>                 ep = strchr(sp, ')');
>                 if (cp < sp)
>                         append_literal(cp, sp, &state);
> -               get_ref_atom_value(info,
> -                                  parse_ref_filter_atom(format, sp + 2, ep),
> -                                  &atomv);
> +               if (parse_ref_filter_atom(format, sp + 2, ep, &pos, &err))
> +                       return -1;
> +               get_ref_atom_value(info, pos, &atomv);
>                 if (atomv->handler(atomv, &state, error_buf))
>                         return -1;
> +               strbuf_release(&err);

This looks leaky: if we get an error, we've got something in the buffer
but we do not release it because we return early. Stepping back a bit, I
wonder why we do not do anything at all with "err". Stepping back a bit
more :-) I wonder if you could get rid of "err" and pass "error_buf" to
parse_ref_filter_atom() instead. Our caller would like to have access to
the error string?

This ties back to my comment on the first patch -- "return negative if
and only if you add some error string to the buffer" might be a useful
rule?

Martin
