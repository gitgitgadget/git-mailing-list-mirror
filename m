Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0F741F462
	for <e@80x24.org>; Fri, 26 Jul 2019 21:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfGZVzm (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 17:55:42 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44431 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfGZVzl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 17:55:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so54391903edr.11
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 14:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=fYpC0PISEw7fVsz6NztnYrZ7QeEDNFx9WFin3TXZDoY=;
        b=SMjrkZk5u6x0d6/gb1501u3CBNLAo1/Pnoe4ygNzjcfnq4K07afbE8YbgVoNj/HAEh
         kWQfbhAGofjjW2yjVhwwQXe0yVQK0yYDBMx6qussJTLfLrA4Aouqaoudcrr8jwUVbhdK
         ibukKgqAmt3cxxaUbxzQP6x7alp1a3kwgC3/mghLSBw50u/wssrfu5imwvb8uU9YLGqB
         zmsqMmj1FFbqBLZA+iI78H/o4l/fKKBCeCVyHCX0gUbZ9bfvF5FaqX/sRsFFs75ymXyw
         AGXi2BEOxRM/kQlM7UpC5HFyT53xvhhNUpXKko1jFpcNK8ob3K8euDRSWKYVHCSYP42S
         Q/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=fYpC0PISEw7fVsz6NztnYrZ7QeEDNFx9WFin3TXZDoY=;
        b=IDIwRAT+cNJr6nxy1PrJFuAwWrWbcp8SCNKFNE7X/8Fy6PH1aEDKpcZM71TCB7B/8F
         E6MNBTqoDRlIPaNSmvnXzIP9Vj5+tMzp/uwnysmtae813z+CCeluKwSI9AzMEAcmp2eD
         bdyvmMVR9Cc/mxGMTX4zHSA3P71W9bvR9HX8D9a8Xh9ERYnHIpk+SAqvB0EVmNO1Agap
         5mvOlGv8+y0z/fLWom6FGYnYHDPUf63nBFZnUnR4nMdQ2jdZNW77uAbmN74bJwKSlUVu
         wFbUg8PDGtiUTvpgth595+CR6l+Ch3woTk5kMrQg4xU7nGS93A3lX3WVhwoy7HJxv0MP
         ZCLw==
X-Gm-Message-State: APjAAAUmDBOrnmC9qL5hk6pr3c9P2yCZ4o+qRplsjncnkNlk/tT4S4/l
        Tv5w8hQMrjiKsgMZa0UckZg=
X-Google-Smtp-Source: APXvYqx2Q2RUNtOuGuRkz2g8BoaxByVt6hChTHN0ZoozrCf6G2GzrcXgveLol/SmQ8x8cjQ/pW/U3g==
X-Received: by 2002:a17:906:9145:: with SMTP id y5mr75686502ejw.257.1564178140154;
        Fri, 26 Jul 2019 14:55:40 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id a55sm14725667eda.70.2019.07.26.14.55.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 14:55:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 6/8] grep: stess test PCRE v2 on invalid UTF-8 data
References: <20190724151415.3698-1-avarab@gmail.com> <20190726150818.6373-7-avarab@gmail.com> <xmqqlfwkmt62.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqlfwkmt62.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 26 Jul 2019 23:55:38 +0200
Message-ID: <878ssk795x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 26 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/grep.c b/grep.c
>> index 6d60e2e557..5bc0f4f32a 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -615,6 +615,16 @@ static void compile_regexp(struct grep_pat *p, stru=
ct grep_opt *opt)
>>  		die(_("given pattern contains NULL byte (via -f <file>). This is only=
 supported with -P under PCRE v2"));
>>
>>  	p->is_fixed =3D is_fixed(p->pattern, p->patternlen);
>> +#ifdef USE_LIBPCRE2
>> +       if (!p->fixed && !p->is_fixed) {
>> +	       const char *no_jit =3D "(*NO_JIT)";
>> +	       const int no_jit_len =3D strlen(no_jit);
>> +	       if (starts_with(p->pattern, no_jit) &&
>> +		   is_fixed(p->pattern + no_jit_len,
>> +			    p->patternlen - no_jit_len))
>> +		       p->is_fixed =3D 1;
>
> It is unfortunate that is_fixed() takes a counted string.
> Otherwise, using skip_prefix() to avoid "+no_jit_len" would have
> made it much easier to read. i.e.
>
> 	/* an illustration that does not quite work */
> 	char *pattern_body;
> 	if (skip_prefix(p->pattern, "(*NO_JIT)", &pattern_body) &&
>             is_fixed(pattern_body))
> 		p->is_fixed =3D 1;

Indeed, but then we couldn't use this for patterns that have NUL in
them, which we otherwise support (and support here). So I think it's
worth keeping it so it takes ptr+len.

>> +test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: setup invalid UTF=
-8 data' '
>> +	printf "\\200\\n" >invalid-0x80 &&
>> +	echo "=C3=A6var" >expected &&
>> +	cat expected >>invalid-0x80 &&
>> +	git add invalid-0x80
>> +'
>> +
>> +test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep ASCII from i=
nvalid UTF-8 data' '
>> +	git grep -h "var" invalid-0x80 >actual &&
>> +	test_cmp expected actual &&
>> +	git grep -h "(*NO_JIT)var" invalid-0x80 >actual &&
>> +	test_cmp expected actual
>> +'
>> +
>> +test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII fr=
om invalid UTF-8 data' '
>> +	test_might_fail git grep -h "=C3=A6" invalid-0x80 >actual &&
>> +	test_cmp expected actual &&
>> +	test_must_fail git grep -h "(*NO_JIT)=C3=A6" invalid-0x80 &&
>> +	test_cmp expected actual
>> +'
>> +
>> +test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII fr=
om invalid UTF-8 data with -i' '
>> +	test_might_fail git grep -hi "=C3=86" invalid-0x80 >actual &&
>> +	test_cmp expected actual &&
>> +	test_must_fail git grep -hi "(*NO_JIT)=C3=86" invalid-0x80 &&
>> +	test_cmp expected actual
>> +'
>> +
>>  test_done
