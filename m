Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349D81F404
	for <e@80x24.org>; Mon, 11 Dec 2017 18:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751705AbdLKSj3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 13:39:29 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46999 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdLKSj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 13:39:28 -0500
Received: by mail-qt0-f193.google.com with SMTP id r39so41010863qtr.13
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 10:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=D3OLjUCVCxdN62E7/AvtcbgJQFPut++08MYoWFaQLr0=;
        b=NZgiK0grKwaZezIQ5XFapZsrNrgFacO9Vkn2UJ4+k0NKF3tFvND6VgdLlOWBqM0Gwk
         /ku1/nGW6OBeubZyQrriytv6WoCqvgLxGcPdkhOHoYOCwd8BLoQIgWA0SY9qCEQ5MwEv
         1YleFzNMQowM3rB4hTqMmCZ56xepawoEe7RqSrecUXaGclRnM8IPuq0so/IsfqjhLLxN
         ZTnaY1EznlzHVcOCMTxVOGJWHsRvr+0/K7lkylEz0bDDXVVjtmKz0ZSL5B0ZjCAmyRLQ
         TDLMWvk0JtPD5CF+ZbmSQ5t3pE3L+mXHLb4tlyXXwMpdEZo5qMpKomxMLrlz/N5+GTwD
         Siaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=D3OLjUCVCxdN62E7/AvtcbgJQFPut++08MYoWFaQLr0=;
        b=mn+UxKk2X21IVDm2GMvmdXawzg1CuOgIVbzwM4Klubwru7PaJlcxTDC/RHyrdD1uXE
         rpVYmpRH/8KRf7ANJGFoI+g07jsa7eRbs9EDYHgiWjVokmDNcXoSgkZfhr6UcAtWfeP8
         TN6ScXYr7Zw9Gthre2siemCTQME4uB7T7CKWffBn3nqi0THgApDhhlg7oqJmogGC/Ew2
         0Ny9rCfJzCkvNehOL/w376uEXMOi8ka/YbQpNaseDK4IB3TS55iApjPk+maLcczDU7YZ
         zOANSvQbfX97h3sM7HV68ITNCP9tWtNT4BJ5bT56XmEjv1kpRAQDHOEu3/V8ZfyMOGIc
         croA==
X-Gm-Message-State: AKGB3mLICI6O3Db5DMOVz8qo+zGbvgSu3+T0aa8HTMXeNbhOjPamtVYJ
        QZYqfLad4iY5lYTsh3ZOos0dcd8yTuGRgdWeXpM=
X-Google-Smtp-Source: ACJfBovgY9qhF3ENIo8bCigX7WmrUvMUl8/sXyyQv1oqie+44n7tSt3cURu5Ocax8pVjoBmUOx/eeKe7TdDe9+luVJU=
X-Received: by 10.237.37.162 with SMTP id x31mr2015999qtc.58.1513017567965;
 Mon, 11 Dec 2017 10:39:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Mon, 11 Dec 2017 10:39:27 -0800 (PST)
In-Reply-To: <20171211155023.1405-1-lars.schneider@autodesk.com>
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Dec 2017 13:39:27 -0500
X-Google-Sender-Auth: jfl3L65oKGNHI7Qf1aT3Aj6cwVU
Message-ID: <CAPig+cQ6VSXXSYJOiZeTqUpwijVhvvUYzXF8U3KCBsOQ91HPZQ@mail.gmail.com>
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
To:     Lars Schneider <lars.schneider@autodesk.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>, patrick@luehne.de,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 11, 2017 at 10:50 AM,  <lars.schneider@autodesk.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Git and its tools (e.g. git diff) expect all text files in UTF-8
> encoding. Git will happily accept content in all other encodings, too,
> but it might not be able to process the text (e.g. viewing diffs or
> changing line endings).
>
> Add an attribute to tell Git what encoding the user has defined for a
> given file. If the content is added to the index, then Git converts the
> content to a canonical UTF-8 representation. On checkout Git will
> reverse the conversion.
>
> Reviewed-by: Patrick L=C3=BChne <patrick@luehne.de>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/convert.c b/convert.c
> @@ -256,6 +257,149 @@ static int will_convert_lf_to_crlf(size_t len, stru=
ct text_stat *stats,
> +static int encode_to_git(const char *path, const char *src, size_t src_l=
en,
> +                        struct strbuf *buf, struct encoding *enc)
> +{
> +#ifndef NO_ICONV
> +       char *dst, *re_src;
> +       int dst_len, re_src_len;
> +
> +       /*
> +        * No encoding is specified or there is nothing to encode.
> +        * Tell the caller that the content was not modified.
> +        */
> +       if (!enc || (src && !src_len))
> +               return 0;
> +
> +       /*
> +        * Looks like we got called from "would_convert_to_git()".
> +        * This means Git wants to know if it would encode (=3D modify!)
> +        * the content. Let's answer with "yes", since an encoding was
> +        * specified.
> +        */
> +       if (!buf && !src)
> +               return 1;
> +
> +       if (enc->to_git =3D=3D invalid_conversion) {
> +               enc->to_git =3D iconv_open(default_encoding, encoding->na=
me);
> +               if (enc->to_git =3D=3D invalid_conversion)
> +                       warning(_("unsupported encoding %s"), encoding->n=
ame);
> +       }
> +
> +       if (enc->to_worktree =3D=3D invalid_conversion)
> +               enc->to_worktree =3D iconv_open(encoding->name, default_e=
ncoding);

Do you need to be calling iconv_close() somewhere on the result of the
iconv_open() calls? [Answering myself after reading the rest of the
patch: You're caching these opened 'iconv' descriptors, so you don't
plan on closing them.]

> + [...]
> +       /*
> +        * Encode dst back to ensure no information is lost. This wastes
> +        * a few cycles as most conversions are round trip conversion
> +        * safe. However, content that has an invalid encoding might not
> +        * match its original byte sequence after the UTF-8 conversion
> +        * round trip. Let's play safe here and check the round trip
> +        * conversion.
> +        */
> +       re_src =3D reencode_string_iconv(dst, dst_len, enc->to_worktree, =
&re_src_len);
> +       if (!re_src || strcmp(src, re_src)) {

You're using strcmp() as opposed to memcmp() because you expect
're_src' will unconditionally be UTF-8-encoded, right?

> +               die(_("encoding '%s' from %s to %s and back is not the sa=
me"),
> +                       path, enc->name, default_encoding);
> +       }
> +       free(re_src);
> +
> +       strbuf_attach(buf, dst, dst_len, dst_len + 1);
> +       return 1;
> +#else
> +       warning(_("cannot encode '%s' from %s to %s because "
> +               "your Git was not compiled with encoding support"),
> +               path, enc->name, default_encoding);
> +       return 0;
> +#endif
> +}
