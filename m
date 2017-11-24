Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF1B32036D
	for <e@80x24.org>; Fri, 24 Nov 2017 17:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753921AbdKXRdw (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 12:33:52 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33849 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753777AbdKXRYu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 12:24:50 -0500
Received: by mail-qk0-f196.google.com with SMTP id v137so25327634qkb.1
        for <git@vger.kernel.org>; Fri, 24 Nov 2017 09:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=zqksCmo1M3CxqhGz/ysoeFJZ3bbC7gKBOBa8BC/VDGc=;
        b=i1y3jTLDcxr6dz7pIFMLQkPWF9g5aCg/X4GPDC9m7SPErsCzNqc3JU+AIm6lA8c9nd
         6YASztqpmGBxSKlAjL3FBiCjabRXNqiyAeKFkXr2WO7o0VJi8m3CJOiDwSpBNYi2tzYa
         TunIKZk9B/AEa3fq5PSpjZQnZQculFfspmjjiu9piePS4wvb9q2o7W5Gn65LevcRrTbR
         FOm16Gg4jROfvXrxOqYvDyGZWBwg7d+viOFUsroushdgPshUerM/d4LaCTI2TZHQFyX0
         cfXji46BbVdVgW9Dw4gKuuz8n7z++Nsgq6NZRlcg6ev8nVsdEgvC7PiC8vHCQneED7XU
         nQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=zqksCmo1M3CxqhGz/ysoeFJZ3bbC7gKBOBa8BC/VDGc=;
        b=cUBYKsUHwSeNhiAnUjrEd9L70fIAMzrqa5LQ+8XHpK8Q6MSxWKmnzZP2PK5C+tg8WS
         fN75ECLmmecLUwY5iutntjQyBWew4Mpr0UiJYdzkAS31DYtXOTjWBig+rwVmp/H/9dKH
         Dwv8fj5b8BJvITjvHitQEE4WkgbmhxUTE2mxT9C1F4oJujdgA3DX4rZxySrT/E9pAZic
         Iz1rEjkAvZxCr5Bn+PSbulqgwFpQzFAUixhO4DdH9Wo9swuzKquXiZp9LjnG8zpKXc89
         1si0MI7drhvgxuaNw4+Z1Q8etRgPvZ3nqnMbbd9DFGtYwjlwXsr+TOOU6zRhuwkVZBDv
         XBvA==
X-Gm-Message-State: AJaThX7vuHdJFX6iH7Xkiz5m6LX7tZPLM8RYSXs1GZnwVNEtrZaRkmfh
        2nrNsk32oDAVfzMrRxXePYzKt7R8EBoINdDAl+o=
X-Google-Smtp-Source: AGs4zMaPwZMTsJQ6k7Hyaluur53XC/duzxeDRL0CJ7MZ64RTCKIHsmhvpAMDtaCNiTaZrY0MD7h1VfNM9C3Fctc1EY4=
X-Received: by 10.55.126.7 with SMTP id z7mr8227524qkc.306.1511544289245; Fri,
 24 Nov 2017 09:24:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Fri, 24 Nov 2017 09:24:48 -0800 (PST)
In-Reply-To: <20171124161407.30698-1-tboegi@web.de>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
 <20171124161407.30698-1-tboegi@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 24 Nov 2017 12:24:48 -0500
X-Google-Sender-Auth: 3n81iONyPbKLwb0CxnH_9XZcCx4
Message-ID: <CAPig+cT7=yLUVpmtutmTep5NBbSRNOL17dsOuVvn_Scu7_+p_w@mail.gmail.com>
Subject: Re: [PATCH 1/1] convert: tighten the safe autocrlf handling
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git List <git@vger.kernel.org>, ashishnegi33@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 24, 2017 at 11:14 AM,  <tboegi@web.de> wrote:
> When a text file had been commited with CRLF and the file is commited
> again, the CRLF are kept if .gitattributs has "text=3Dauto".
> This is done by analyzing the content of the blob stored in the index:
> If a '\r' is found, Git assumes that the blob was commited with CRLF.
>
> The simple search for a '\r' does not always work as expected:
> A file is encoded in UTF-16 with CRLF and commited. Git treats it as bina=
ry.
> Now the content is converted into UTF-8. At the next commit Git treats th=
e
> file as text, the CRLF should be converted into LF, but isn't.
>
> Solution:
> Replace has_cr_in_index() with has_crlf_in_index(). When no '\r' is found=
,
> 0 is returned directly, this is the most common case.
> If a '\r' is found, the content is analyzed more deeply.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> diff --git a/convert.c b/convert.c
> @@ -220,18 +220,27 @@ static void check_safe_crlf(const char *path, enum =
crlf_action crlf_action,
> -static int has_cr_in_index(const struct index_state *istate, const char =
*path)
> +static int has_crlf_in_index(const struct index_state *istate, const cha=
r *path)
>  {
>         unsigned long sz;
>         void *data;
> -       int has_cr;
> +       const char *crp;
> +       int has_crlf =3D 0;
>
>         data =3D read_blob_data_from_index(istate, path, &sz);
>         if (!data)
>                 return 0;
> -       has_cr =3D memchr(data, '\r', sz) !=3D NULL;
> +
> +       crp =3D memchr(data, '\r', sz);
> +       if (crp && (crp[1] =3D=3D '\n')) {

If I understand correctly, this isn't a NUL-terminated string and it
might be a binary blob, so if the lone CR in a file resides at the end
of the file, won't this try looking for LF out-of-bounds? I would have
expected the conditional to be:

    if (crp && crp - data + 1 < sz && crp[1] =3D=3D '\n') {

or any equivalent variation.

> +               unsigned int ret_stats;
> +               ret_stats =3D gather_convert_stats(data, sz);
> +               if (!(ret_stats & CONVERT_STAT_BITS_BIN) &&
> +                   (ret_stats & CONVERT_STAT_BITS_TXT_CRLF))
> +                       has_crlf =3D 1;
> +       }
>         free(data);
> -       return has_cr;
> +       return has_crlf;
>  }
