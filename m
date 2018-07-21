Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39AC31F597
	for <e@80x24.org>; Sat, 21 Jul 2018 19:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeGUUf1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 16:35:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35384 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbeGUUf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 16:35:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id e6-v6so229976edr.2
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 12:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=9B2LUKTysHzsxP3n0PoF/PmVV2d3hcaCVJTIrop0Z+Y=;
        b=cAzSaUbAd+AErtNhz2gBcaN8MpMFmcElSuXyKdbaJ0QDvpQX62/v5f+NdfdN1wZi4h
         tFB316OsYiJDonSx3qfAomTE1mrXByiZ8R8lcisIBpOzskl9LoGrQVAJVQ7JqW+90cRm
         BZKnIxArmuPC9zMHjSvHYBiRIKE9znqMgh7c4zQtSqWwzYCjJcqrRGfN0EWJFglCTxQk
         P3IxtfSJ4b0knwE4HfL7ZwFFjyNGisCDPgpUpixRcbXSHad1pMP3qS3AGhhGWmUue0F9
         6zK3W13q5FOe/bq6rmNLJCbj7knr9Twa5PJ29pAn+oyv89ws9u2zGR/0GDryl/wdk0I+
         yhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=9B2LUKTysHzsxP3n0PoF/PmVV2d3hcaCVJTIrop0Z+Y=;
        b=SP7BfDNHguTxBlIy3DBr1TqvaDlFnNOlY314ClW2lVEo/S9OpHXNZ++zdtACMNP23+
         q76s1MPudCdfJ5HVxHoXckf+w8FdOo4Q6yE5yFLAKsysAY8ScLeEQEOoPXimeG89usc6
         Ns3zv/S8P7GQ0FFd1QOw9fw0U1M9S+GvALSgC+FFVwRXTazwn87fE8Ow4jJeu+cYiYwf
         DPmieS7GlYgaS2NSPVfAT8neYWVt/VlmFW7zY7TnIvot+WmIRIdtfkPwWGSWVuEvqG+4
         x89YxUdZNLgZ4jndRQrprqAlbZCK1J/s2hEOdqh9nZawuO3RfDFFeAkJgs4YR9wnravF
         SN6w==
X-Gm-Message-State: AOUpUlEWvCcgqULT15g+dz9O352Pbk52auBHWJuI2TEpQep2sURCZSTc
        2t7X3dzC0ZZGLxPjx04GOLw=
X-Google-Smtp-Source: AAOMgpfn1ErSV4fIVjP2JVDjqoiJIzT7gTdcCPFqilqlpgKZfHKCA579ia5J3ZtMaZhwI/qxkniY8g==
X-Received: by 2002:a50:eacb:: with SMTP id u11-v6mr7698917edp.7.1532202094418;
        Sat, 21 Jul 2018 12:41:34 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id a13-v6sm7102088edf.84.2018.07.21.12.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 12:41:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] Makefile: add a DEVOPTS flag to get pedantic compilation
References: <20180721185933.32377-1-dev+git@drbeat.li>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180721185933.32377-1-dev+git@drbeat.li>
Date:   Sat, 21 Jul 2018 21:41:32 +0200
Message-ID: <87wotobclv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 21 2018, Beat Bolli wrote:

> In the interest of code hygiene, make it easier to compile Git with the
> flag -pedantic.
>
> Pure pedantic compilation results in one warning per use of the
> translation macro `N_`, therefore also disable the parenthesising of
> i18n strings with -DUSE_PARENS_AROUND_GETTEXT_N=0 to show only real
> warnings.

I like this...

> diff --git a/Makefile b/Makefile
> index 0cb6590f24..f800054379 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -484,6 +484,10 @@ all::
>  #        The DEVELOPER mode enables -Wextra with a few exceptions. By
>  #        setting this flag the exceptions are removed, and all of
>  #        -Wextra is used.
> +#
> +#    pedantic:
> +#
> +#        Enable -pedantic compilation.

But let's mention that we toggle USE_PARENS_AROUND_GETTEXT_N implicitly
when this is set here.

> +CFLAGS += -pedantic
> +# don't warn for each N_ use
> +CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
> +endif

...and set this to "no" not "0" since we document that that's the way to
toggle it off in the Makefile, i.e. let's be consistent.

Also, it would be helpful for future digging if the commit message
mentioned which -W flag included in -Wpedantic is triggering this
USE_PARENS_AROUND_GETTEXT_N condition that previously wasn't triggered,
and on which compiler & version. 290c8e7a3f ("gettext.h: add parentheses
around N_ expansion if supported", 2015-01-11) doesn't mention anything
like that.
