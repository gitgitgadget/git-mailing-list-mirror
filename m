Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 718B220188
	for <e@80x24.org>; Sat, 13 May 2017 19:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758353AbdEMT44 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 15:56:56 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35290 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758310AbdEMT4z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 15:56:55 -0400
Received: by mail-io0-f196.google.com with SMTP id o12so8570152iod.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 12:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KNhWQOiX9B7/3KVz74EQ0e8QA4qd5YekEjlki5T6tC4=;
        b=k2D6eUAqkcJv9LEuynC8Xfd2i8iZd8V2GLJKTPyErLh+DQ90rTogC9GEoQPWvUSnEH
         wd8JF/9lNP8e3q52LrQn2WWGlkGG927vX3UoFW1h2l8+shHKtu1HYbvsw3w8mO3Vr5kX
         /2DDSfYlRm0bS/aZFl5C6H5SnW26akQ6VOGZrnvwZedX6ouAICJ4wJ/0Cb9JsMTYnBOv
         hRf9tJvzzVrkORu3pN/VunfeLAs9mvRv/ESwjIdTW7Om0JVmWRyZVqTcSIlgvd16mJs2
         Up3C6YmGzzm34Y4RWTiPop3TolAuNfTSUMpRx3QjpOK9USygtG8Le5bm5TT6FpDvddvt
         pExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KNhWQOiX9B7/3KVz74EQ0e8QA4qd5YekEjlki5T6tC4=;
        b=LFiLIPsSgaTl2rqIPIuH5XyqtO5FyqopvxtjXu5BYIC2XKHr1bNol01aEn1oJQSfJN
         ypKRtRa+SYmEkE2OHEwJKb2buLjiDDXGPx2U6a6y+5hsiUEDieZ9qpAyFbtH9ABq0TwL
         Vqa6H1pUgmnpQZCG8H5njhWNCKwGdCUzzupHZWggU4O2omMMciSWXjY56FwjMUfjn7o9
         38jQoZzvKUYeZrxXABTZYcK7tqspQfot1bmCTK/rNcuyAfX0pA5RYDlV4NOH/84jAbq1
         9bE7l6FYtJvMBUNXXILo/UQzUAOAfcbZv4dnXwpePp0lUHdkCUrmEgY2wjXTvwrQrRCD
         vMgg==
X-Gm-Message-State: AODbwcB8j0K9jGR6WSKVFNp+IoY2t6aEapDX+frO1nqGVZBaMfI4M7MO
        VHp6xSm5ubxFxXylFrT5ekuAz+Bki7KS
X-Received: by 10.107.178.12 with SMTP id b12mr9639361iof.50.1494705415020;
 Sat, 13 May 2017 12:56:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 13 May 2017 12:56:34 -0700 (PDT)
In-Reply-To: <a38670f6-2d47-f455-c9d3-d887a58e1e29@cs-ware.de>
References: <20170513095716.C718E221C2B@srv1.79p.de> <CACBZZX6dcy9DEp8AZsdV5SPG-86ELOXUSuFkOaoUxjVreJXhDA@mail.gmail.com>
 <a38670f6-2d47-f455-c9d3-d887a58e1e29@cs-ware.de>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 13 May 2017 21:56:34 +0200
Message-ID: <CACBZZX66ALcHuVh14R4OfW-D5PJS9prnzG5hw2SKvC-V+4+PVA@mail.gmail.com>
Subject: Re: [PATCH] Use https links to Wikipedia to avoid http redirects
To:     Sven Strickroth <email@cs-ware.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 13, 2017 at 11:54 AM, Sven Strickroth <email@cs-ware.de> wrote:
> Signed-off-by: Sven Strickroth <email@cs-ware.de>

Thanks! FWIW:

Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

> ---
>  Documentation/gitweb.txt | 2 +-
>  bisect.c                 | 2 +-
>  gitweb/gitweb.perl       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
> index 96156e5e1..88450589a 100644
> --- a/Documentation/gitweb.txt
> +++ b/Documentation/gitweb.txt
> @@ -84,7 +84,7 @@ separator (rules for Perl's "`split(" ", $line)`").
>
>  * Fields use modified URI encoding, defined in RFC 3986, section 2.1
>  (Percent-Encoding), or rather "Query string encoding" (see
> -http://en.wikipedia.org/wiki/Query_string#URL_encoding[]), the differenc=
e
> +https://en.wikipedia.org/wiki/Query_string#URL_encoding[]), the differen=
ce
>  being that SP (" ") can be encoded as "{plus}" (and therefore "{plus}" h=
as to be
>  also percent-encoded).
>  +
> diff --git a/bisect.c b/bisect.c
> index 08c9fb726..fa477a3e2 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -546,7 +546,7 @@ static unsigned get_prn(unsigned count) {
>
>  /*
>   * Custom integer square root from
> - * http://en.wikipedia.org/wiki/Integer_square_root
> + * https://en.wikipedia.org/wiki/Integer_square_root
>   */
>  static int sqrti(int val)
>  {
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7cf68f07b..d8209c7a0 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -8085,7 +8085,7 @@ sub git_search_help {
>  <p><strong>Pattern</strong> is by default a normal string that is matche=
d precisely (but without
>  regard to case, except in the case of pickaxe). However, when you check =
the <em>re</em> checkbox,
>  the pattern entered is recognized as the POSIX extended
> -<a href=3D"http://en.wikipedia.org/wiki/Regular_expression">regular expr=
ession</a> (also case
> +<a href=3D"https://en.wikipedia.org/wiki/Regular_expression">regular exp=
ression</a> (also case
>  insensitive).</p>
>  <dl>
>  <dt><b>commit</b></dt>
> --
> 2.12.1.windows.1
>
