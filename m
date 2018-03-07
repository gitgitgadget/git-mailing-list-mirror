Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A7691F404
	for <e@80x24.org>; Wed,  7 Mar 2018 18:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeCGSEr (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 13:04:47 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34080 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753168AbeCGSEq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 13:04:46 -0500
Received: by mail-qt0-f173.google.com with SMTP id l25so3720783qtj.1
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 10:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9+tC5fctH9yzoT3Gck1Q+HpPArI2hH56HPh6IrLVVSQ=;
        b=l2E66kK1LR4++0nCegGwMbG93mOy3i+GXtLzTfA/bh8EtiyiQWjQTuQTLsEA3Vt/vx
         /XKGD57ViXoemG8RGI0P5M+gFOnXrwmXwDMjNZHXd/5axKwOdhAMaDtSeJAQKA5U5lNb
         lDILCHCi2lqlkgV1K6v1W+pp150mEVMiW9fcv7fSPvM4uvhv/tCatPmToQkZ2Uz+N64B
         477wHk/s1zuaw1d519+Ej1dmceP1bJQNsxaJgx5udM2dpBvq6qeBJiOKYPGyXS2vs8m8
         +DnUFVh5/jG1ueMYe26rQWWQQCeDqytmbF0KF4flxY/QcYzS2fmlzQWkUwHiVSsCLV9B
         kIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9+tC5fctH9yzoT3Gck1Q+HpPArI2hH56HPh6IrLVVSQ=;
        b=IPLmUI8PcNy5k9B4ibTDtrihpf5OS/GK6UX2Z3XFX3f+FymyDCIbaWVjBqpLfT4JwY
         rJH5CTP+fH+mxQhyNcJKclRvqSqd/9ISPivAv6ESc2o11tSbQcbGlnrCkue1bB6tu4T6
         SEEGNM27yVPxK9AhVbx4EWEtZm7BdXl15+HvzE4MZvKSCxJ6rbZ9PctbxZASYxdhx7vk
         1qcy7plS0KAJVoLXMkatBCnYKb/PI0DP4afjAjs4LpCiGqINMFYhFYunPhT9apHeA2Hv
         31IQGCYtNVGE0Ji/iueTbEb/Wo1XVY0Kqbzc+Vfm/2FZgjFH2S2hKcGVOLpFkJgcqHKR
         yNtw==
X-Gm-Message-State: AElRT7FhWjd5da40MxGoJbakXFmuIlFkjI7Js7/XDR4RU+3dVL8yfLmf
        d1V4vMHr5SrdSHwPlZUNcd8N10l8Zmg5ciGI+B4=
X-Google-Smtp-Source: AG47ELuDXIk9Sza7sBu6Em/O0OPpcu9FGTmlVfTi3GQPv7Q0z9FZ0UvceRYUpCE5cTiNBfrGI4HmKAbdJyipRT8kaSc=
X-Received: by 10.237.62.233 with SMTP id o38mr34021050qtf.3.1520445885298;
 Wed, 07 Mar 2018 10:04:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Wed, 7 Mar 2018 10:04:44 -0800 (PST)
In-Reply-To: <20180307173026.30058-8-lars.schneider@autodesk.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com> <20180307173026.30058-8-lars.schneider@autodesk.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 7 Mar 2018 13:04:44 -0500
X-Google-Sender-Auth: P2KLpS3W0STgJwTMkWT8Zh3S7Yo
Message-ID: <CAPig+cTsRufRNZbKJS-02fvbtaLB30FO3Em6HR_LZrsK+CfOjw@mail.gmail.com>
Subject: Re: [PATCH v10 7/9] convert: check for detectable errors in UTF encodings
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

On Wed, Mar 7, 2018 at 12:30 PM,  <lars.schneider@autodesk.com> wrote:
> Check that new content is valid with respect to the user defined
> 'working-tree-encoding' attribute.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/convert.c b/convert.c
> @@ -266,6 +266,58 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
> +static int validate_encoding(const char *path, const char *enc,
> +                     const char *data, size_t len, int die_on_error)
> +{
> +       /* We only check for UTF here as UTF?? can be an alias for UTF-?? */
> +       if (startscase_with(enc, "UTF")) {
> +               /*
> +                * Check for detectable errors in UTF encodings
> +                */
> +               if (has_prohibited_utf_bom(enc, data, len)) {
> +                       const char *error_msg = _(
> +                               "BOM is prohibited in '%s' if encoded as %s");
> +                       /*
> +                        * This advice is shown for UTF-??BE and UTF-??LE encodings.
> +                        * We cut off the last two characters of the encoding name
> +                        # to generate the encoding name suitable for BOMs.

s/#/*/

> +                        */
> +                       const char *advise_msg = _(
> +                               "The file '%s' contains a byte order "
> +                               "mark (BOM). Please use %s as "
> +                               "working-tree-encoding.");
> +                       char *upper_enc = xstrdup_toupper(enc);
> +                       upper_enc[strlen(upper_enc)-2] = '\0';

Due to startscase_with(...,"UTF"), we know at this point that the
string is at least 3 characters long, thus it's safe to back up by 2.
Good.

> +                       advise(advise_msg, path, upper_enc);
> +                       free(upper_enc);
> +                       if (die_on_error)
> +                               die(error_msg, path, enc);
> +                       else {
> +                               return error(error_msg, path, enc);
> +                       }
> diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
> @@ -62,6 +62,46 @@ test_expect_success 'check $GIT_DIR/info/attributes support' '
>  for i in 16 32
>  do
> +       test_expect_success "check prohibited UTF-${i} BOM" '
> +               test_when_finished "git reset --hard HEAD" &&
> +
> +               echo "*.utf${i}be text working-tree-encoding=utf-${i}be" >>.gitattributes &&
> +               echo "*.utf${i}le text working-tree-encoding=utf-${i}le" >>.gitattributes &&

v10 is checking only hyphenated lowercase encoding name; earlier
versions checked uppercase. For better coverage, it would be nice to
check several combinations: all uppercase, all lowercase, mixed case,
hyphenated, not hyphenated.

I'm not suggesting running all the tests repeatedly but rather just
varying the format of the encoding name in these tests you're adding.
For instance, the above could instead be:

    echo "*.utf${i}be text working-tree-encoding=UTF-${i}be" >>.gitattributes &&
    echo "*.utf${i}le text working-tree-encoding=utf${i}LE" >>.gitattributes &&

or something.

> +               # Here we add a UTF-16 (resp. UTF-32) files with BOM (big/little-endian)
> +               # but we tell Git to treat it as UTF-16BE/UTF-16LE (resp. UTF-32).
> +               # In these cases the BOM is prohibited.
> +               cp bebom.utf${i}be.raw bebom.utf${i}be &&
> +               test_must_fail git add bebom.utf${i}be 2>err.out &&
> +               test_i18ngrep "fatal: BOM is prohibited .* utf-${i}be" err.out &&
> +
> +               cp lebom.utf${i}le.raw lebom.utf${i}be &&
> +               test_must_fail git add lebom.utf${i}be 2>err.out &&
> +               test_i18ngrep "fatal: BOM is prohibited .* utf-${i}be" err.out &&
> +
> +               cp bebom.utf${i}be.raw bebom.utf${i}le &&
> +               test_must_fail git add bebom.utf${i}le 2>err.out &&
> +               test_i18ngrep "fatal: BOM is prohibited .* utf-${i}le" err.out &&
> +
> +               cp lebom.utf${i}le.raw lebom.utf${i}le &&
> +               test_must_fail git add lebom.utf${i}le 2>err.out &&
> +               test_i18ngrep "fatal: BOM is prohibited .* utf-${i}le" err.out
> +       '
> +
> +       test_expect_success "check required UTF-${i} BOM" '
> +               test_when_finished "git reset --hard HEAD" &&
> +
> +               echo "*.utf${i} text working-tree-encoding=utf-${i}" >>.gitattributes &&

This is another opportunity for checking a variation (case,
hyphenation) of the encoding name rather than using only hyphenated
lowercase.

> +
> +               cp nobom.utf${i}be.raw nobom.utf${i} &&
> +               test_must_fail git add nobom.utf${i} 2>err.out &&
> +               test_i18ngrep "fatal: BOM is required .* utf-${i}" err.out &&
> +
> +               cp nobom.utf${i}le.raw nobom.utf${i} &&
> +               test_must_fail git add nobom.utf${i} 2>err.out &&
> +               test_i18ngrep "fatal: BOM is required .* utf-${i}" err.out
> +       '
