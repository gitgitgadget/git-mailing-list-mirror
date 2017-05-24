Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9CEF20281
	for <e@80x24.org>; Wed, 24 May 2017 05:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966061AbdEXFRj (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:17:39 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35322 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969171AbdEXFRS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:17:18 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so31636418pfd.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=LR4upWAmfYUN/p24lcVXrfmzsvyU6/dyf6lorCZLYC8=;
        b=lCkqyrmj7LGmVDQHG8wRmQ6i0jf8EK3LJ+fzJgYUDNhMg2HzAyVxgYcO/FD1Zk9JYW
         hiLE+4vA0wfhXLh47vJI0RloawO+jCeQvcN7Awml1OxJJM4qbHZHJDkYyyeiPQQbV6IB
         a0/+nanBgzo0V3YioxArL1oBBjvxU73zRHqj7rO1bPgQbxYBMQjOqWs0fmdZFiGNTkDc
         I4m9bbuKDPntxgn4h4JDlpPMno6BvV/aWvYgtv8MMFBHKXptMuzxJ1Kr1WEbmAMLMpVu
         JtE+QN1HHq0T4WgVdeconegX8BpvPeVaJO51NnoCMx+kig4a8ITcTorfjnmklbVkb2SY
         Z/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=LR4upWAmfYUN/p24lcVXrfmzsvyU6/dyf6lorCZLYC8=;
        b=c+rKsp3SwoA4zOyhtXRe1FeOmmJXg2xIZcrCaXDMxC4Mp6F5gy9GgKGUs8DPf9mlyf
         t134ZvBy5o/EEN7GApBuqRDAGoN5yye9tQlYKhvFtXGHp8aGLk4w+CY0GJ8Qep3SC5nE
         Z38m1HkgOy0C97/scW/bY9YM0McQKs9GYj1t+C3nF2GAIvK2VIn7v5bDspa3WpwygC9c
         rcrbcbPWH15EfAyW84L0nm8MLn5Wyzk8fe+mlZZTZGj275YHypISQ9qhaAu5bzVWubih
         dpAqBc3aXCdbZEOHLKsqpczljBeGHRbCUDIyx+5WG8wSf+k22Mfh6bTwEPoIpqKs9Npt
         QYUw==
X-Gm-Message-State: AODbwcDD8lYJnxgyeoPPkh86ipaQlv0DPZvbg5aio+e0EPyWmUpFwykY
        jWsRwnV/N7BCag==
X-Received: by 10.99.125.87 with SMTP id m23mr36295310pgn.79.1495603032978;
        Tue, 23 May 2017 22:17:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:167:7063:293b:a24d])
        by smtp.gmail.com with ESMTPSA id a3sm4948356pfc.26.2017.05.23.22.17.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 22:17:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v2 4/7] grep: add support for the PCRE v1 JIT API
References: <20170523192453.14172-1-avarab@gmail.com>
        <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
        <20170523192453.14172-5-avarab@gmail.com>
Date:   Wed, 24 May 2017 14:17:11 +0900
In-Reply-To: <20170523192453.14172-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 23 May 2017 19:24:50 +0000")
Message-ID: <xmqqlgpmhm08.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> diff --git a/grep.c b/grep.c
> index 1157529115..49e9aed457 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -351,6 +351,9 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
>  	const char *error;
>  	int erroffset;
>  	int options = PCRE_MULTILINE;
> +#ifdef PCRE_CONFIG_JIT
> +	int canjit;
> +#endif

Is "canjit" a property purely of the library (e.g. version and
compilation option), or of combination of that and nature of the
pattern, or something else like the memory pressure?

I am wondering if it is worth doing something like this:

	static int canjit = -1;
	if (canjit < 0) {
		pcre_config(PCRE_CONFIG_JIT, &canjit);
	}

if it depends purely on the library linked to the process.

> @@ -365,9 +368,20 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
>  	if (!p->pcre1_regexp)
>  		compile_regexp_failed(p, error);
>  
> -	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, 0, &error);
> +	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, PCRE_STUDY_JIT_COMPILE, &error);
>  	if (!p->pcre1_extra_info && error)
>  		die("%s", error);
> +
> +#ifdef PCRE_CONFIG_JIT
> +	pcre_config(PCRE_CONFIG_JIT, &canjit);
> +	if (canjit == 1) {
> +		p->pcre1_jit_stack = pcre_jit_stack_alloc(1, 1024 * 1024);
> +		if (!p->pcre1_jit_stack)
> +			die("BUG: Couldn't allocate PCRE JIT stack");

I agree that dying is OK, but as far as I can tell, this is not a
BUG (there is no error a programmer can correct by a follow-up
patch); please do not mark it as such (it is likely that we'll later
do a tree-wide s/die("BUG:/BUG("/ and this will interfere).

> +		pcre_assign_jit_stack(p->pcre1_extra_info, NULL, p->pcre1_jit_stack);
> +		p->pcre1_jit_on = 1;

Contrary to what I wondered about "canjit" above, I think it makes
tons of sense to contain the "is JIT in use?" information in "struct
grep_pat" and not rely on any global state.  Not that we are likely
to want to be able to JIT some patterns while not doing others.  So
I agree with the design choice of adding pcre1_jit_on field to the
structure.

But then, wouldn't it make more sense to do all of the above without
the canjit variable at all?  i.e. something like...

        #ifdef PCRE_CONFIG_JIT
                pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
                if (p->pcre1_jit_on)
                        ... stack thing ...
        #else
                p->pcre1_jit_on = 0;
        #endif

> +#ifdef PCRE_CONFIG_JIT
> +	if (p->pcre1_jit_on) {
> +		pcre_free_study(p->pcre1_extra_info);
> +		pcre_jit_stack_free(p->pcre1_jit_stack);
> +	} else
> +#endif
> +	/* PCRE_CONFIG_JIT !p->pcre1_jit_on else branch */
>  	pcre_free(p->pcre1_extra_info);
> +
>  	pcre_free((void *)p->pcre1_tables);

It is very thoughtful to add a blank line here (and you did the same
in another similar hunk), but I have a feeling that it is still a
bit too subtle a hint to signal to the readers that these two
pcre_free()s fire differently, i.e. the former does not fire if jit
is on but the latter always fires.

Would this be a bit safer while being not too ugly to live, I wonder?

        #ifdef PCRE_CONFIG_JIT
                if (p->pcre1_jit_on) {
                        pcre_free_study(p->pcre1_extra_info);
                        pcre_jit_stack_free(p->pcre1_jit_stack);
                } else
        #endif
                {
                        /* PCRE_CONFIG_JIT !p->pcre1_jit_on else branch */
                        pcre_free(p->pcre1_extra_info);
                }
                pcre_free((void *)p->pcre1_tables);

Thanks.
