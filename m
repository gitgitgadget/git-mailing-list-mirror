Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A43521F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 16:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbdFIQWA (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 12:22:00 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:36304 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdFIQV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 12:21:59 -0400
Received: by mail-it0-f49.google.com with SMTP id m47so491590iti.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 09:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6EIyx8Gl6dD75dSfBgIoLDfsxDCprVfBwyM9EUD7Qdc=;
        b=uM+Wvqpt/IpzFD2wq57m8iDQp/PoATv15c91pASeirCfhl7KaIrgb8BCM285/GlB17
         h9DFAXxNuXjGXCBDqII80VLddACUYxbkmi5pGZIq4RGFERrOC0bXeXihR1Y+9b3y7qiD
         9qoVfyhMXGW6Q/jTGI/jM3dYWHd8rBO/GFoD5698pV7IU18C+3cucr4uXBJS0V11GVLL
         s5KitCA0fvvdygR2Xs4sZMMkq2Hr8kmh2q5/X7+xVwXQM0ZfEeybRVqvRefZp8+6sRWS
         GFs2T5qetS7DJI5FepsqwwEcSJ+qw1C1/tYOPS21qCJUPFPL9G6Nk4JFOUpH0+kr4Zzq
         I/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6EIyx8Gl6dD75dSfBgIoLDfsxDCprVfBwyM9EUD7Qdc=;
        b=rlEVn5kU+oQdi7H0AwlOLUCjE45lW6bb4oRbjvIxZGB4KdpmBN5CEiHoXiqucA7NHN
         8uQGMOyGp2U3W2YqdBL6cEK5JXGuOYBJOA1bqgFOZLpIpGt1EFAoMkn9lK61Saa0oKvB
         vEytTAgwabQzu3FTKX3EBuIt25BUneIuQlMZAl3y0kM3s4tcKLMmR108kGFVcdMP0bD9
         qFp/1U6RLvN8UACU2pimJDPWTFIPNcnjoPZnnYBMUInjAKw5Drbg7LEPGSYjnQPZePOW
         pH10RqJnyoD7ICZdoi/yOSWJoBAuqqFBpYuNL5egZM+mcjTopsb4SY97ZasrQBMDRj0+
         rncw==
X-Gm-Message-State: AODbwcA0UG6/65K5y2hQyhIlvzyx3Kh61fFqJs9DyBbrwDrSb0YcUj75
        jgiCTbd68d4pGQNFnRpTo4lX/n8Fco6D
X-Received: by 10.36.127.208 with SMTP id r199mr329692itc.66.1497025318511;
 Fri, 09 Jun 2017 09:21:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Fri, 9 Jun 2017 09:21:37 -0700 (PDT)
In-Reply-To: <0102015c492e27c6-669f7ca8-e7c6-484f-9c5b-7cb9358ee966-000000@eu-west-1.amazonses.com>
References: <0102015c492e27c6-669f7ca8-e7c6-484f-9c5b-7cb9358ee966-000000@eu-west-1.amazonses.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 9 Jun 2017 18:21:37 +0200
Message-ID: <CACBZZX44Wc1c2RXfnZMu4cX8NAkdyuaktxZpCWcWK83oiJ2iRQ@mail.gmail.com>
Subject: Re: [PATCH] wildmatch test: cover a blind spot in "/" matching
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 27, 2017 at 11:13 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Add a test which covers a blindspot in how these tests should assert
> that negated character classes are allowed or not allowed to match "/"
> in certain circumstances.

Junio: I didn't CC you on this, because I probably clicked some wrong
option in submitgit which I was testing for this patch. Could you
please queue this one?

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/t3070-wildmatch.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
> index ef509df35160..65ea07b68356 100755
> --- a/t/t3070-wildmatch.sh
> +++ b/t/t3070-wildmatch.sh
> @@ -82,6 +82,7 @@ match 1 0 'foo/bar' 'foo/**/bar'
>  match 1 0 'foo/bar' 'foo/**/**/bar'
>  match 0 0 'foo/bar' 'foo?bar'
>  match 0 0 'foo/bar' 'foo[/]bar'
> +match 0 0 'foo/bar' 'foo[^a-z]bar'
>  match 0 0 'foo/bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
>  match 1 1 'foo-bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
>  match 1 0 'foo' '**/foo'
> @@ -226,6 +227,7 @@ pathmatch 0 foo/bba/arr 'foo/*z'
>  pathmatch 0 foo/bba/arr 'foo/**z'
>  pathmatch 1 foo/bar 'foo?bar'
>  pathmatch 1 foo/bar 'foo[/]bar'
> +pathmatch 1 foo/bar 'foo[^a-z]bar'
>  pathmatch 0 foo '*/*/*'
>  pathmatch 0 foo/bar '*/*/*'
>  pathmatch 1 foo/bba/arr '*/*/*'
>
> --
> https://github.com/git/git/pull/362
