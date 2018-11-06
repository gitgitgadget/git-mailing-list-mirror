Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 581471F453
	for <e@80x24.org>; Tue,  6 Nov 2018 03:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeKFMu3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 07:50:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36290 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbeKFMu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 07:50:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id z13-v6so9412485wrs.3
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 19:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=0uDJYntAGcFcTLsuycOrTsX0ob8NFzQdclfBxtJoQDo=;
        b=X1VZEsRMiby5Wu2RZe17geRrL1kJhQBLC71zDHOZWCc6wfstGFOjRAjFxGOaAqYTgA
         EpM+ebIVhXEyb4+AQuZjYJXrMfUTibAaAJ19N1G6wqWDZ/X27C61czFQzouLFispk4cp
         Wh4AX/vmbCRH4hCR8+oLgVLlEN0kDTqZyBlL4jjzyBl8QvSXmarxSJbnCMKBsr+Pkq82
         /+PIRUdoVeEHgM+H9AWRywtHRlEpvOVgrO9ZqK11XLx97dHhlAmt0+EvuiVF7sjnDW/x
         +N6gJStuGLe2X5FFalyF5CgAQWjrDYH0L3YaaDak5pp8pQXh16akIfgCgZMaAAAX0P+n
         76MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=0uDJYntAGcFcTLsuycOrTsX0ob8NFzQdclfBxtJoQDo=;
        b=kCtXvKwi9VFgXQuduYrjtmFbBgnqL4cBh8q5jLYvyz5HwvUXm0rUizLCaVNAH8m2C5
         9EW7TAhRaIEX06vntqbG7pOLJwqzcK+YpsIRF75jfRv5WaRauE2SXgS4lm6nTR4pkotd
         wnOOF3trJUrHE5pHdZYQ2TFPxbKFWyCkPEn0CI1hymm5JUA2UAHBW62lSPMpXPSSABqq
         fohhH5ykZGOD5LLckQwoKlG18tA6UuCCZH7Wr94toCaIxmH/pKp14PgxLPluo2wnAk0i
         VilImz44XxoVFWSRkNN2DMOXyf/ykazC9T6P7dIu3tN7V2vymRVfyCeGDOX/cZ0UbEn4
         MNNA==
X-Gm-Message-State: AGRZ1gLA2p8rbfx5LIBp6HeqiXIoJAX8zdsbaOLoHSDD+zNv+pvgYFMf
        abJSwQaHemy5cubAgLEeEsY=
X-Google-Smtp-Source: AJdET5fvMAhtQLuFGBRu8w3dsqJbVCxoOm2MYBUVRyZ/h1s+WqfZ48UCDdQWnhN9KDY/S0+O2F/dIA==
X-Received: by 2002:adf:fac4:: with SMTP id a4-v6mr22962417wrs.202.1541474844586;
        Mon, 05 Nov 2018 19:27:24 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e8-v6sm22748679wrw.75.2018.11.05.19.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 19:27:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 13/16] parse-options.c: turn some die() to BUG()
References: <20181028065157.26727-1-pclouds@gmail.com>
        <20181105192059.20303-1-pclouds@gmail.com>
        <20181105192059.20303-14-pclouds@gmail.com>
Date:   Tue, 06 Nov 2018 12:27:22 +0900
In-Reply-To: <20181105192059.20303-14-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 5 Nov 2018 20:20:56 +0100")
Message-ID: <xmqqh8guga1x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> diff --git a/parse-options.c b/parse-options.c
> index 0bf817193d..3f5f985c1e 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -197,7 +197,7 @@ static int get_value(struct parse_opt_ctx_t *p,
>  		return 0;
>  
>  	default:
> -		die("should not happen, someone must be hit on the forehead");
> +		BUG("opt->type %d should not happen", opt->type);
>  	}
>  }

OK, this should not happen.

> @@ -424,7 +424,7 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
>  	ctx->flags = flags;
>  	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
>  	    (flags & PARSE_OPT_STOP_AT_NON_OPTION))
> -		die("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
> +		BUG("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");

The correctness of this conversion was not immediately obvious, as
"git rev-parse --parse-options" could allow end-users to specify
flags, and when these two flags came together from that codepath, it
is an end-user error that should be diagnosed with die(), not BUG().

It turns out that stop-at-non-option can be passed, but keep-unknown
is not (yet) available to the codepath, so this conversion to BUG()
is correct---an end user futzing with Git correctly compiled from a
bug-free source should not be able to trigger this.
