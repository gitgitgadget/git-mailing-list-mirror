Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7B731F404
	for <e@80x24.org>; Fri,  2 Feb 2018 14:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeBBOei (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 09:34:38 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:37677 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBBOeh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 09:34:37 -0500
Received: by mail-vk0-f66.google.com with SMTP id g83so13569305vki.4
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 06:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/evX7oCoPxXNWUKy1TrrzGF94LXvrBK99L9LCu0t8Vc=;
        b=rtV/Eh4TLBni3NWa1JOkXEtCJ1hlrfPZUyJiviYEK8xsaF0llfC2hiSnlPh4y/qRpU
         iz6Gu8ONxkURtTNFA2BpwckzQGmt9nA0Au1Xl25bH1au5xBJSy65zYuXBjDC4k0rBlNm
         M1RrjAqBBbz5P5kLK3NjuTk0SWoAwWcsRfFM2Swcngc83J+1RFjGO+zLlGERyYG2vMSr
         WqyNoMiivhLKg7GoY9sdwGR0wvNTRd8VfsGRix95M28Fsn9KEarGn0My2z0GLIGuOAyx
         SV25w4NBBobwIty2+CuJkSSvzBD2eCME2je/B9+LUBN3VGzZFXszUN36xO8poQQrb1jq
         YX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/evX7oCoPxXNWUKy1TrrzGF94LXvrBK99L9LCu0t8Vc=;
        b=tSfZNHukCakLSwL5cUfgICklqI2zOY5Q5yKnWtXQ18/N8pnPfPyfVgzxbKeTYjnk2G
         ZiqHfSbcLb3SaEqyZdqYC85XaaKJ2p75Q1NRMeO5zo2ik+Mww1FP9xCBwJwFS7ZcU/Jo
         nYF0n/hmBVmNWYVu7mZzJ4g7U/Xn1R9CeRc91S783XgttmpMVzaadksRI55iP3hLVJIW
         MULlb38R8bLcoQqR65vyDoBf49ek3Qa7wVQg2zD70GD1gLVhRZuBTEZaFxXrA1lVWdO0
         W1r/E5NjcSWk045rqtD8Qh/8VA3HaFvaFolKA2yQo+pr6V/zzlrXx6BTmjdDDEapt2RC
         8NEQ==
X-Gm-Message-State: AKwxytfK5vGoZLCkOyQwpXsXNeXw7YV03fDndXaZH/BHU9olSblPX2y5
        6c32D08edY9wA1XyDrF36swFQkU0FfsOoBIUEL8=
X-Google-Smtp-Source: AH8x227yjGVUvudWGNkGohXuXe+aUheC7ou0Ngh9cNd4j0k9w6G2Hp7fC7XM+Y0fd21LTGxoqvokJVc4vZkknOYji2w=
X-Received: by 10.31.60.69 with SMTP id j66mr23590786vka.155.1517582076105;
 Fri, 02 Feb 2018 06:34:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Fri, 2 Feb 2018 06:34:35 -0800 (PST)
In-Reply-To: <376eb2e8-0a95-233b-743b-cdc1caa49015@web.de>
References: <376eb2e8-0a95-233b-743b-cdc1caa49015@web.de>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 2 Feb 2018 15:34:35 +0100
Message-ID: <CAM0VKjnoux1CBq-HvzRW14hXZyviG_z_Rv-qv7d0kakh18zXcw@mail.gmail.com>
Subject: Re: [PATCH] cocci: simplify check for trivial format strings
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 1, 2018 at 7:56 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> 353d84c537 (coccicheck: make transformation for strbuf_addf(sb, "...")
> more precise) added a check to avoid transforming calls with format
> strings which contain percent signs, as that would change the result.
> It uses embedded Python code for that.  Simplify this rule by using the
> regular expression matching operator instead.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> Inspired by the Coccinelle package in Debian experimental, which lost
> support for Python for some reason.  Tested only with that version
> (1.0.6.deb-3) and Debian testing's 1.0.4.deb-3+b3.

FWIW, it appears to be working fine with Coccinelle version
1.0.0~rc19.deb-3 running on Travis CI.
Applied it on top of 'rs/strbuf-cocci-workaround' currently at cd9a4b6d9
(cocci: use format keyword instead of a literal string, 2018-01-19)
along with an other patch to show the resulting suggestions in
'.../*.cocci.patch' files, and the results look fine:

  https://travis-ci.org/szeder/git/jobs/336573242#L1466

and are the same as without this patch:

  https://travis-ci.org/szeder/git/jobs/336257153#L1466


>
>  contrib/coccinelle/strbuf.cocci | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.=
cocci
> index 6fe8727421..e34eada1ad 100644
> --- a/contrib/coccinelle/strbuf.cocci
> +++ b/contrib/coccinelle/strbuf.cocci
> @@ -1,21 +1,6 @@
>  @ strbuf_addf_with_format_only @
>  expression E;
> -constant fmt;
> -@@
> -  strbuf_addf(E,
> -(
> -  fmt
> -|
> -  _(fmt)
> -)
> -  );
> -
> -@ script:python @
> -fmt << strbuf_addf_with_format_only.fmt;
> -@@
> -cocci.include_match("%" not in fmt)
> -
> -@ extends strbuf_addf_with_format_only @
> +constant fmt !~ "%";
>  @@
>  - strbuf_addf
>  + strbuf_addstr
> --
> 2.16.1
