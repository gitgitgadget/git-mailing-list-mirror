Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F00271F461
	for <e@80x24.org>; Sat,  7 Sep 2019 23:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfIGXhe (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 19:37:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41497 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfIGXhd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 19:37:33 -0400
Received: by mail-io1-f65.google.com with SMTP id r26so20845354ioh.8
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 16:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TC+c2dH4dqWiiFa5OlhC7IdvP1YPatf4qwYgv8Kc6jU=;
        b=Nmy6Pg+jMOZaucX03VqFvV4TNlTWrLZ0mTKOiwB8i5VFAlNO4WOZRSPfTsq/UF+4Ic
         WgAYKMtqJ/nZge1U2hukfva5Ufk3zppnBBPwlnOhECIFZWWaaUNC1kTo/01pQHxB67+g
         KDkFAbkGUzfs9ovyTljbg6N/UP0423LkiCLbes5G9vfqDhNbz5INib+T6VXKMaaYF2gg
         6loTswb3Oaa8U/JPC1vx/8jw9f6kjyQuSYjrZhV1n/3c+ghVZsKdRZUIGdHiHMovx12Q
         MD08xz740RRY5r5PXkylEQuvp8J5DTK23BhySNe2+sm9+Ffs80WNWxdBkepBE0pTerFq
         NTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TC+c2dH4dqWiiFa5OlhC7IdvP1YPatf4qwYgv8Kc6jU=;
        b=J4KjNM6IhId5ufy316zi22AYd7289nO7InE3sKyc0q4/PYhTl0iHpwyxYWBQFLlqQy
         jzHCQEU+Wo2VGHTBdThkb+A7rn3MY/XLI88JzSj5VjEsQZofnvEJ8MNqSqKDjKlJQTwI
         kXZ0bqYsjzf0ffcMH02tncPj1zZgLYZixTgikGjPMdy1iAzlASzCJFcZMkGEKgeJOyAf
         yXat4GsqCbsd/EOrSSmrCspC407sxkIaNGtkjbatYRWG4YkeDSOwn0dydhqIZGci3YPI
         TLGWbAkEOnUIF4gxT8CVBzkProJxf2GgskTs4FJIdYgIZapAElU/VEFtH/16o9dDEPmj
         oRdw==
X-Gm-Message-State: APjAAAU+HtWsXbWrSv6krUZfCjRha5HftEirHZB6PFMO6gaLpAuzTZ0P
        FxvlPBidOukKYedCqED2aT9WRkT1km0=
X-Google-Smtp-Source: APXvYqyCqOiHhb+FRzH6QsK3dDip2dYWO0cpNpz/jfoZg/896UzUZV1qsohC24oJf1hannNG7ewEZQ==
X-Received: by 2002:a05:6602:c9:: with SMTP id z9mr18615257ioe.28.1567899452730;
        Sat, 07 Sep 2019 16:37:32 -0700 (PDT)
Received: from localhost ([206.121.37.170])
        by smtp.gmail.com with ESMTPSA id y19sm8537592ioq.69.2019.09.07.16.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 16:37:32 -0700 (PDT)
Date:   Sat, 7 Sep 2019 19:37:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Freese <ericdfreese@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] for-each-ref: add '--no-symbolic' option
Message-ID: <20190907233730.GA43328@syl.local>
References: <20190907213646.21231-1-ericdfreese@gmail.com>
 <20190907213646.21231-2-ericdfreese@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190907213646.21231-2-ericdfreese@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sat, Sep 07, 2019 at 03:36:46PM -0600, Eric Freese wrote:
> Using the new flag will omit symbolic refs from the output.
>
> Without this flag, it is possible to get this behavior by using the
> `%(symref)` formatting field name and piping output through grep to
> include only those refs that do not output a value for `%(symref)`, but
> having this flag is more elegant and intention revealing.

Please include a 'Signed-off-by' trailer from yourself in this commit.
You can write one yourself, but instead use 'git commit -s' when
committing.
I'm a little timid around a single-bit value prefixed with 'no'. Maybe
it would be clearer as:

  int sym = 1;

...instead of the negated form. Of course, the rest of the readers of
this variable would have to be updated, too, but involving fewer
negations seems like it would only improve the clarity.

>       struct ref_array array;
>       struct ref_filter filter;
>       struct ref_format format = REF_FORMAT_INIT;
> @@ -46,6 +46,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>               OPT_CONTAINS(&filter.with_commit, N_("print only refs which contain the commit")),
>               OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't contain the commit")),
>               OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
> +             OPT_BOOL(0, "no-symbolic", &nosym, N_("exclude symbolic refs")),

I'm a little bit weary of this "no-" prefixing, but this time for a
different reason. The parse-options API has a built-in "negative" option
to pair with each 'OPT_BOOL'. So, for example, in the line above yours,
it is actually the case that you can run 'git for-each-ref
--ignore-case' just as much as you can run 'git for-each-ref
--no-ignore-case'.

Applying your patch shows that I can write the following:

  $ git for-each-ref --no-no-symbolic

Which is likely unintended. There are two ways that you can go about
this:

  - write this as 'OPT_BOOL(0, "symbolic", ...)', to make sure that the
    option you _actually_ want is the one generated by the complement,
    not the complement's complement.

  - or, pass 'PARSE_OPT_NONEG' to tell the parse-options API not to
    generate the complement in the first place.

I'd lean towards the former, at the peril of having a meaningless
default option (i.e., passing '--symbolic' is wasteful, since
'--symbolic' is implied by its default value). But, there are certainly
counter-examples, which you can find with

  $ git grep 'OPT_BOOL(.*\"no-'

So, I'd be curious to hear about the thoughts of others.

>               OPT_END(),
>       };
>
> @@ -72,6 +73,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>               sorting = ref_default_sorting();
>       sorting->ignore_case = icase;
>       filter.ignore_case = icase;
> +     filter.no_symbolic = nosym;
>
>       filter.name_patterns = argv;
>       filter.match_as_path = 1;
> diff --git a/ref-filter.c b/ref-filter.c
> index f27cfc8c3e..01beb279dc 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2093,6 +2093,10 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>               return 0;
>       }
>
> +     if (filter->no_symbolic && flag & REF_ISSYMREF) {
> +             return 0;
> +     }
> +

In Documentation/CodingGuidelines, we avoid braces around single-line
if-statements.
This style is uncommon, and instead it is preferred to write:

  ! grep refs/symbolic actual

Since 'test_must_fail' also catches segfaults, whereas '!' does not.
Since we'd like this test to fail if/when grep segfaults, use of the
later is preferred here.

> +'
> +
>  test_done
> --
> 2.23.0

Thanks,
Taylor
