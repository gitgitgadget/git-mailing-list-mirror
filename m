Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47F1C1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 19:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeBYTu7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 14:50:59 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:41137 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbeBYTu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 14:50:57 -0500
Received: by mail-qt0-f179.google.com with SMTP id j4so1509376qth.8
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 11:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rPE8tB/1QGUph2P+dGmbLHn3Ufb+Y+Dq/e8I8/OKAXo=;
        b=Nu1KoZbiY4KL7xyOqzyekzoteVYaEZ84n8PTrPe5brBX5oxYzRjtN+365U2BfKApmg
         dNxAM1vqAWPfh797QX/+WHsLUTD9sG8V+13nwIOCEOq/ZarZri2PiyKe76XnogXnl4To
         lhkdtqrDzeH25ZdbVOyPluRYDvhZOSGZKwg96k6xoe4JCcyFvtqSLBXNzCKdMeTqKUGp
         nBiOa/4BRBYcWdAXStRYpKH0C7tnFYv5LjY1HdcecbKuNiGSZ+UyAyj87Zp+bVjYvTHt
         4pzmNMJLxRC9HEIUOTokmVPciXodz8q2bF5k10aQF21aAOuHN7kbWvrvyyDG1XyNBHcT
         SQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rPE8tB/1QGUph2P+dGmbLHn3Ufb+Y+Dq/e8I8/OKAXo=;
        b=oqVlNMLAHUtk/rLn1hJh3KyI7vmhX/jJ1hxjwhaokPLl/nKmo0JzHQfy9Yn8+9xUOJ
         f5Urbt/BkfCQ+Zd9SMo2GHMd/ymPhza4d1IF/a42HCMZS1oyfzkc8s1ecLMG8GIMTeac
         dJoLQmUjQmbdDdlWVyLxOGmwXin+fwkwAh4v4hStyucfaa+RG1pNQC+1zT5Zz2oQLvrE
         UZWWg91aJExVw4eGiFKT7shCP3oH2ngwp9u0fOmaTzKa1Tc7uIDVFwygwzpLTxkToToZ
         Fjkd6CZDMHcICTuVrjT3UQX/Xc1q8BZRXSslvvgTtqycHAgK5hTyIRgKLCRLroJQcV8z
         A/ag==
X-Gm-Message-State: APf1xPA3h4Pcxux4Od0u3FQulWWmg3hadh17AxJNUlluEQVDn+rLzUWP
        X5SN5Ulq8uH/C11FIzQdTHLYOkTjqWOCxM2M4Fw=
X-Google-Smtp-Source: AG47ELue/jDGt2F9b4D4XAO8chWLpVAiH/Aq3HmH9na7Lfv066g1qQhmW5E3+D6RFhEZHjIG0/zhGWyEiFaHNJVIzn0=
X-Received: by 10.200.6.5 with SMTP id d5mr14381999qth.205.1519588256850; Sun,
 25 Feb 2018 11:50:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sun, 25 Feb 2018 11:50:56 -0800 (PST)
In-Reply-To: <20180224162801.98860-8-lars.schneider@autodesk.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com> <20180224162801.98860-8-lars.schneider@autodesk.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 25 Feb 2018 14:50:56 -0500
X-Google-Sender-Auth: cGLbqNM-rtl-aRLQMn5zMyZUcms
Message-ID: <CAPig+cR81J3fTOtrgAumAs=RC5hqYFfSmeb-ru-Yf_ahFuBiew@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] convert: add round trip check based on 'core.checkRoundtripEncoding'
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

On Sat, Feb 24, 2018 at 11:28 AM,  <lars.schneider@autodesk.com> wrote:
> UTF supports lossless conversion round tripping and conversions between
> UTF and other encodings are mostly round trip safe as Unicode aims to be
> a superset of all other character encodings. However, certain encodings
> (e.g. SHIFT-JIS) are known to have round trip issues [1].
>
> Add 'core.checkRoundtripEncoding', which contains a comma separated
> list of encodings, to define for what encodings Git should check the
> conversion round trip if they are used in the 'working-tree-encoding'
> attribute.
>
> Set SHIFT-JIS as default value for 'core.checkRoundtripEncoding'.
>
> [1] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/convert.c b/convert.c
> @@ -289,6 +289,39 @@ static void trace_encoding(const char *context, const char *path,
> +static int check_roundtrip(const char* enc_name)
> +{
> +       /*
> +        * check_roundtrip_encoding contains a string of space and/or
> +        * comma separated encodings (eg. "UTF-16, ASCII, CP1125").
> +        * Search for the given encoding in that string.
> +        */
> +       const char *found = strcasestr(check_roundtrip_encoding, enc_name);
> +       const char *next = found + strlen(enc_name);

Is this pointer arithmetic undefined behavior (according to the C
standard) if NULL is returned by strcasestr()? If so, how comfortable
are we with this? Perhaps if you add an 'if' into the mix, you can
avoid it:

    if (found) {
        const char *next = found + strlen(enc_name);
        return ...long complicated expression...;
    }
    return false;

> +       int len = strlen(check_roundtrip_encoding);
> +       return (found && (
> +                       /*
> +                        * check that the found encoding is at the
> +                        * beginning of check_roundtrip_encoding or
> +                        * that it is prefixed with a space or comma
> +                        */
> +                       found == check_roundtrip_encoding || (
> +                               found > check_roundtrip_encoding &&
> +                               (*(found-1) == ' ' || *(found-1) == ',')

Although the 'found > check_roundtrip_encoding' expression is
effectively dead code in this case, it does document that the
programmer didn't just blindly use '*(found-1)' without taking
boundary conditions into consideration.

(It's dead code because, at this point, we know that strcasestr()
didn't return NULL and we know that 'found' doesn't equal
'check_roundtrip_encoding', therefore it _must_ be greater than
'check_roundtrip_encoding'.)

Just an observation; not a request to remove the dead code since it
has some documentation value.

> +                       )
> +               ) && (
> +                       /*
> +                        * check that the found encoding is at the
> +                        * end of check_roundtrip_encoding or
> +                        * that it is suffixed with a space or comma
> +                        */
> +                       next == check_roundtrip_encoding + len || (
> +                               next < check_roundtrip_encoding + len &&
> +                               (*next == ' ' || *next == ',')
> +                       )
> +               ));
> +}
> @@ -366,6 +399,47 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
> +       if ((conv_flags & CONV_WRITE_OBJECT) && check_roundtrip(enc->name)) {
> +               re_src = reencode_string_len(dst, dst_len,
> +                                            enc->name, default_encoding,
> +                                            &re_src_len);
> +
> +               trace_printf("Checking roundtrip encoding for %s...\n", enc->name);
> +               trace_encoding("reencoded source", path, enc->name,
> +                              re_src, re_src_len);
> +
> +               if (!re_src || src_len != re_src_len ||
> +                   memcmp(src, re_src, src_len)) {
> +                       const char* msg = _("encoding '%s' from %s to %s and "
> +                                           "back is not the same");
> +                       die(msg, path, enc->name, default_encoding);

Last two arguments need to be swapped.

> +               }
> +
> +               free(re_src);
> +       }
> +
>         strbuf_attach(buf, dst, dst_len, dst_len + 1);
>         return 1;
>  }
> diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
> @@ -225,4 +225,45 @@ test_expect_success 'error if encoding garbage is already in Git' '
> +test_expect_success 'check roundtrip encoding' '
> +       text="hallo there!\nroundtrip test here!" &&
> +       printf "$text" | iconv -f UTF-8 -t SHIFT-JIS >roundtrip.shift &&
> +       printf "$text" | iconv -f UTF-8 -t UTF-16 >roundtrip.utf16 &&
> +       echo "*.shift text working-tree-encoding=SHIFT-JIS" >>.gitattributes &&
> +
> +       # SHIFT-JIS encoded files are round-trip checked by default...
> +       GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 >/dev/null |
> +               grep "Checking roundtrip encoding for SHIFT-JIS" &&

Why redirect to /dev/null? If something does go wrong somewhere, the
more output available for debugging the problem, the better, so
throwing it away unnecessarily seems contraindicated.

> +       git reset &&
> +
> +       # ... unless we overwrite the Git config!
> +       test_config core.checkRoundtripEncoding "garbage" &&
> +       ! GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 >/dev/null |
> +               grep "Checking roundtrip encoding for SHIFT-JIS" &&
> +       test_unconfig core.checkRoundtripEncoding &&

The "unconfig" won't take place if the test fails. Instead of
test_config/test_unconfig, you could use '-c' to set the config
transiently for the git-add operation:

    ! GIT_TRACE=1 git -c core.checkRoundtripEncoding=garbage add ...

> +       git reset &&
> +
> +       # UTF-16 encoded files should not be round-trip checked by default...
> +       ! GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
> +               grep "Checking roundtrip encoding for UTF-16" &&
> +       git reset &&
> +
> +       # ... unless we tell Git to check it!
> +       test_config_global core.checkRoundtripEncoding "UTF-16, UTF-32" &&
> +       GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
> +               grep "Checking roundtrip encoding for UTF-16" &&
> +       git reset &&
> +
> +       # ... unless we tell Git to check it!
> +       # (here we also check that the casing of the encoding is irrelevant)
> +       test_config_global core.checkRoundtripEncoding "UTF-32, utf-16" &&
> +       GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
> +               grep "Checking roundtrip encoding for UTF-16" &&
> +       git reset &&
> +
> +       # cleanup
> +       rm roundtrip.shift roundtrip.utf16 &&
> +       git reset --hard HEAD
> +'

Same comment as for patch 5/7: This cleanup won't happen if the test
fails. Instead, use test_when_finished() earlier in the test:

    test_expect_success 'check roundtrip encoding' '
        test_when_finished "rm -f roundtrip.shift roundtrip.utf16; git
reset --hard HEAD" &&
        ...
