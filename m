Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2D81F404
	for <e@80x24.org>; Tue,  6 Mar 2018 20:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753868AbeCFUzO (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 15:55:14 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:37328 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753466AbeCFUzN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 15:55:13 -0500
Received: by mail-qt0-f172.google.com with SMTP id r16so9446qtm.4
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 12:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ar/6aUbL/UqpFo2rUcI/LcwCehoNnvNcjyk+Ayg88As=;
        b=lobxQry41nnBbC8ARYGPpSQAZIVuob6j8PhX+wsF7J9Ps69q8LgcgPB0bV31oevA2H
         uE4CJSDD9JK3TRUOnwjeG/ru+OSuSM3/kB4ebrglkzKeiLJUBZOK3Hf9yV0i+oPp4JyD
         lk0xq5l/MPkco4e6l/KxRbGhMa/NZx61SR5fC5fLowRQCLxTeMR1tFt3nyBALYSKFIKH
         ZaZMuJpmI57pboWAN6jYlpUqApOW/Vc13IoIuhUo1aRpvhqxR+ohSIrHGlQ8UdT2MF9d
         re0CVlyS3uTWiCUV/b74wGvYdd06JdNRL87ZUuly5lBtH+U316xn53DssLbXC69hvB0V
         emBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ar/6aUbL/UqpFo2rUcI/LcwCehoNnvNcjyk+Ayg88As=;
        b=bNwEMDVfLSRucGVTNYFCEsXcQ1OgmnmbsEr0lM8k3aB7UIfIciw1Hblx+8ENrxLuUj
         UVii6LsqmnOe+uOzhJUn5QrvVZk9kl09GqLunf+I4/T1IMoJsBWQJurnVwNqULOJHCia
         wHbfGwb9fZ00rPqhPURPsD6F0iHTyUCodq13pHLbfFsXMXrP/Vd9kyMuTTIpnzkanFCn
         +ybBHv9rJDqafU850LSdXYJA8RmIIPSJ2Q+H4+rcf5k0sfnkjNwdinlzrq0gdvaYoPL8
         dudp216oUl6VkZnqp/8+Z/98cI7LFJXIjgxnBQO26wmdVd29BPLlb0sk77/UZNFF4GJi
         1oLA==
X-Gm-Message-State: AElRT7GVOUbFTFO81wXXKliWK7B5VDk0Bgaa3OglZ0Hyxc6I5y7lg5ZW
        Po7RyxazSeKKhujkguihcPgE3I4pNzGdLgQQ2Yc=
X-Google-Smtp-Source: AG47ELtV9nHVQWKJ/RcHHlE5GvLDKt6duc0pwqEo8ItgHXxK0c08oy4EWvCO1kE6HxUV7nINS8tgLlIl8AP9ZWGrBN4=
X-Received: by 10.237.62.233 with SMTP id o38mr29246699qtf.3.1520369712819;
 Tue, 06 Mar 2018 12:55:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Tue, 6 Mar 2018 12:55:12 -0800 (PST)
In-Reply-To: <20180304201418.60958-7-lars.schneider@autodesk.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com> <20180304201418.60958-7-lars.schneider@autodesk.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Mar 2018 15:55:12 -0500
X-Google-Sender-Auth: YzxeYJLNkMh_2ruk1DzSGmzcUkA
Message-ID: <CAPig+cSoka-yBTYBz42JGQTyCH7LDWnToeOvdZfG0_64o9QnBQ@mail.gmail.com>
Subject: Re: [PATCH v9 6/8] convert: check for detectable errors in UTF encodings
To:     Lars Schneider <lars.schneider@autodesk.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 4, 2018 at 3:14 PM,  <lars.schneider@autodesk.com> wrote:
> Check that new content is valid with respect to the user defined
> 'working-tree-encoding' attribute.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/convert.c b/convert.c
> @@ -266,6 +266,53 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
> +static int validate_encoding(const char *path, const char *enc,
> +                     const char *data, size_t len, int die_on_error)
> +{
> +       if (!memcmp("UTF-", enc, 4)) {
> +               [...]
> +               if (has_prohibited_utf_bom(enc, data, len)) {
> +                       [...]
> +                       if (die_on_error)
> +                               die(error_msg, path, enc);
> +                       else {
> +                               return error(error_msg, path, enc);
> +                       }
> +               } [...]
> +       return 0;
> +}
> @@ -291,6 +338,9 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
> +       if (validate_encoding(path, enc, src, src_len, die_on_error))
> +               return 0;

There could be a cleaner separation of responsibilities here which, as
a nice side-effect, would eliminate the repeated "if (die_on_error)
die(...); else return error(...);" pattern. Rather than passing a
'die_on_error' flag to validate_encoding(), it could accept a 'strbuf
*err' to populate in case of error:

    static int validate_encoding(..., struct strbuf *err)
    {
        if validation error:
            populate 'err'
            return -1;
        return 0
    }

and let the caller be responsible for deciding how to handle failure:

    struct strbuf err = STRBUF_INIT;
    ...
    if (validate_encoding(..., &err)) {
        if (die_on_error)
            die(err.buf);
        else {
            error(err.buf);
            strbuf_release(&err);
            return 0;
        }
    }

Not necessarily worth a re-roll, but perhaps a cleanup someone could
submit at some point if interested.

>         dst = reencode_string_len(src, src_len, default_encoding, enc,
>                                   &dst_len);
