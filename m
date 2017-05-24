Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8853C20281
	for <e@80x24.org>; Wed, 24 May 2017 06:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935410AbdEXGXn (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 02:23:43 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35637 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935037AbdEXGXl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 02:23:41 -0400
Received: by mail-pg0-f47.google.com with SMTP id q125so60758401pgq.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 23:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=b11jDmRTlrQtRy7k8BjlzATa8iGm7jacA2lI8dzh92o=;
        b=aTxGusS5+5chIKrg8owMPVuqXmtKtGNuCnM46wZv4t/oJ+Oqqmyy+1RhTpuyPwkBAy
         7LCVvxKrjLuV0z9yqtKtGKeCzqh+4vGex5ccQhTSb3voFSSbr8HEqAkij6Ycy4pZmbU2
         RlFtTb989oPsEw0o8smEq5CyqdcoNsoaqksjVV7EazHdpZd0SgBg9EF6/ZPnwA19Le2V
         CnU3ZjpX/T0Q5zjJ2SbpkUEDpoRJLMXbF9w0oEKDzWDMZST3de33EFdDbDu40XDsTM6h
         qeEckjqVmx1WFrFO+79IR2PE1PFKyvhcADZOQ6HWZazlqc26jiA1xhUXmekywT6ruT6z
         k36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=b11jDmRTlrQtRy7k8BjlzATa8iGm7jacA2lI8dzh92o=;
        b=WgtVw1H4lsWvFKh9WWkHON5GbO+y1RPxos8jbA3/y6uMqjWAwGRSUilfNnNQEh+IZo
         S/UyC9MT3ECPV471PrRuIn9xgC3HYMCMUHX7Itci+0DVX0LOkur1V8cMRaIBDM9lTzfQ
         sjDBrr2VHhclc7czbVtx2ff2/LyNNDVP58arw77ZdSIyd2oZcWpIZUGYczEJYSdk7lBn
         IeFgujHaxkNgM9fMSc0MaUANa4E3l7WeWAPGFCFRz1bpy32vwHs8E3oMwQkxs5WFsajW
         5Qz3MDOA7HdjNo9XRAvEzM+IigBe0M7tQm1q/FPZL3GPz0VLeRFnow0OYXtJi1jOzD8u
         L5IQ==
X-Gm-Message-State: AODbwcDoEtyR+mlFwWjSJqr54QzZA922lo3xmdGKxnzvoGHxsLeRgtQ6
        wfoR9qr74wYMEw==
X-Received: by 10.98.89.201 with SMTP id k70mr36038010pfj.196.1495607020701;
        Tue, 23 May 2017 23:23:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:167:7063:293b:a24d])
        by smtp.gmail.com with ESMTPSA id v64sm5123029pfk.86.2017.05.23.23.23.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 23:23:39 -0700 (PDT)
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
Subject: Re: [PATCH v2 7/7] grep: add support for PCRE v2
References: <20170523192453.14172-1-avarab@gmail.com>
        <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
        <20170523192453.14172-8-avarab@gmail.com>
Date:   Wed, 24 May 2017 15:23:38 +0900
In-Reply-To: <20170523192453.14172-8-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 23 May 2017 19:24:53 +0000")
Message-ID: <xmqqa862hixh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Add support for v2 of the PCRE API. This is a new major version of
> PCRE that came out in early 2015[1].
>
> The regular expression syntax is the same, but while the API is
> similar, pretty much every function is either renamed or takes
> different arguments. Thus using it via entirely new functions makes
> sense, as opposed to trying to e.g. have one compile_pcre_pattern()
> that would call either PCRE v1 or v2 functions.
>
> Git can now be compiled with either USE_LIBPCRE1=YesPlease or
> USE_LIBPCRE2=YesPlease, with USE_LIBPCRE=YesPlease currently being a
> synonym for the former. Providing both is a compile-time error.
>
> With earlier patches to enable JIT for PCRE v1 the performance of the
> release versions of both libraries is almost exactly the same, with
> PCRE v2 being around 1% slower.
>
> However after I reported this to the pcre-dev mailing list[2] I got a
> lot of help with the API use from Zoltán Herczeg, he subsequently
> optimized some of the JIT functionality in v2 of the library.
>
> Running the p7820-grep-engines.sh performance test against the latest
> Subversion trunk of both, with both them and git compiled as -O3, and
> the test run against linux.git, gives the following results. Just the
> /perl/ tests shown:
>
>     $ GIT_PERF_REPEAT_COUNT=30 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_MAKE_COMMAND='grep -q LIBPCRE2 Makefile && make -j8 USE_LIBPCRE2=YesPlease CC=~/perl5/installed/bin/gcc NO_R_TO_GCC_LINKER=YesPlease CFLAGS=-O3 LIBPCREDIR=/home/avar/g/pcre2/inst LDFLAGS=-Wl,-rpath,/home/avar/g/pcre2/inst/lib || make -j8 USE_LIBPCRE=YesPlease CC=~/perl5/installed/bin/gcc NO_R_TO_GCC_LINKER=YesPlease CFLAGS=-O3 LIBPCREDIR=/home/avar/g/pcre/inst LDFLAGS=-Wl,-rpath,/home/avar/g/pcre/inst/lib' ./run HEAD~2 HEAD~ HEAD p7820-grep-engines.sh
>     [...]
>     Test                                           HEAD~2            HEAD~                    HEAD
>     ----------------------------------------------------------------------------------------------------------------
>     7820.3: perl grep 'how.to'                      0.22(0.40+0.48)   0.22(0.31+0.58) +0.0%   0.22(0.26+0.59) +0.0%
>     7820.7: perl grep '^how to'                     0.27(0.62+0.50)   0.28(0.60+0.50) +3.7%   0.22(0.25+0.60) -18.5%
>     7820.11: perl grep '[how] to'                   0.33(0.92+0.47)   0.33(0.94+0.45) +0.0%   0.25(0.42+0.51) -24.2%
>     7820.15: perl grep '(e.t[^ ]*|v.ry) rare'       0.35(1.08+0.46)   0.35(1.12+0.41) +0.0%   0.25(0.52+0.50) -28.6%
>     7820.19: perl grep 'm(ú|u)lt.b(æ|y)te'          0.30(0.78+0.51)   0.30(0.86+0.42) +0.0%   0.25(0.29+0.54) -16.7%
>
> See commit ("perf: add a comparison test of grep regex engines",
> 2017-04-19) for details on the machine the above test run was executed
> on.
>
> Here HEAD~2 is git with PCRE v1 without JIT, HEAD~ is PCRE v1 with
> JIT, and HEAD is PCRE v2 (also with JIT). See previous commits of mine
> mentioning p7820-grep-engines.sh for more details on the test setup.
>
> For ease of readability, a different run just of HEAD~ (PCRE v1 with
> JIT v.s. PCRE v2), again with just the /perl/ tests shown:
>
>     Test                                           HEAD~             HEAD
>     ---------------------------------------------------------------------------------------
>     7820.3: perl grep 'how.to'                      0.23(0.41+0.47)   0.23(0.26+0.59) +0.0%
>     7820.7: perl grep '^how to'                     0.27(0.64+0.47)   0.23(0.28+0.56) -14.8%
>     7820.11: perl grep '[how] to'                   0.34(0.95+0.44)   0.25(0.38+0.56) -26.5%
>     7820.15: perl grep '(e.t[^ ]*|v.ry) rare'       0.34(1.07+0.46)   0.24(0.52+0.49) -29.4%
>     7820.19: perl grep 'm(ú|u)lt.b(æ|y)te'          0.30(0.81+0.46)   0.22(0.33+0.54) -26.7%
>
> I.e. the two are either neck-to-neck, but PCRE v2 usually pulls ahead,
> when it does it's around 20% faster.
>
> A brief note on thread safety: As noted in pcre2api(3) & pcre2jit(3)
> the compiled pattern can be shared between threads, but not some of
> the JIT context, however the grep threading support does all pattern &
> JIT compilation in separate threads, so this code doesn't need to
> concern itself with thread safety.

Nicely explained.

> -# Define LIBPCREDIR=/foo/bar if your libpcre header and library files are in
> +# Currently USE_LIBPCRE is a synonym for USE_LIBPCRE1, define
> +# USE_LIBPCRE2 instead if you'd like to use version 2 of the PCRE
> +# library. The USE_LIBPCRE flag will likely be changed to mean v2 by
> +# default in future releases.
> +#
> +# Define LIBPCREDIR=/foo/bar if your PCRE header and library files are in
>  # /foo/bar/include and /foo/bar/lib directories.

As there is no way to use both, having a single LIBPCREDIR is not a
hurting limitation, which makes sense.

> @@ -2241,6 +2258,7 @@ GIT-BUILD-OPTIONS: FORCE
>  	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@+
>  	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
>  	@echo USE_LIBPCRE1=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@+

Shouldn't the line above record $(USE_LIBPCRE1) instead of the
generic fallback?

> +	@echo USE_LIBPCRE2=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE2)))'\' >>$@+
>  	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
>  	@echo NO_PTHREADS=\''$(subst ','\'',$(subst ','\'',$(NO_PTHREADS)))'\' >>$@+
>  	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+

> diff --git a/grep.c b/grep.c
> index 3c0c30f033..569cf9e290 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -179,22 +179,36 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
>  	case GREP_PATTERN_TYPE_BRE:
>  		opt->fixed = 0;
>  		opt->pcre1 = 0;
> +		opt->pcre2 = 0;
>  		break;
>  
>  	case GREP_PATTERN_TYPE_ERE:
>  		opt->fixed = 0;
>  		opt->pcre1 = 0;
> +		opt->pcre2 = 0;
>  		opt->regflags |= REG_EXTENDED;
>  		break;
>  
>  	case GREP_PATTERN_TYPE_FIXED:
>  		opt->fixed = 1;
>  		opt->pcre1 = 0;
> +		opt->pcre2 = 0;
>  		break;
>  
>  	case GREP_PATTERN_TYPE_PCRE:
>  		opt->fixed = 0;
> +#ifdef USE_LIBPCRE2
> +		opt->pcre1 = 0;
> +		opt->pcre2 = 1;
> +#else
> +		/* It's important that pcre1 always be assigned to
> +		 * even when there's no USE_LIBPCRE* defined. We still
> +		 * call the PCRE stub function, it just dies with
> +		 * "cannot use Perl-compatible regexes[...]".
> +		 */
>  		opt->pcre1 = 1;

Very well thought-out comment.  Our style wants you to have
slash-aster that opens a multi-line comment on its own line, though.

> +		opt->pcre2 = 0;
> +#endif
>  		break;
>  	}
>  }
> @@ -446,6 +460,126 @@ static void free_pcre1_regexp(struct grep_pat *p)
>  }
>  #endif /* !USE_LIBPCRE1 */
>  
> +#ifdef USE_LIBPCRE2
> +static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
> +{
> +...
> +	p->pcre2_pattern = pcre2_compile((PCRE2_SPTR)p->pattern,
> +					 p->patternlen, options, &error, &erroffset,
> +					 p->pcre2_compile_context);

Are all die("BUG:...") in this function actual bugs, or just
"die()"?  Just like the comment on an earlier patch, things like
running out of memory that you as a Git programmer cannot fix by
correcting this code are not die("BUG:"), but normal runtime errors.

> +
> +	if (p->pcre2_pattern) {
> +		p->pcre2_match_data = pcre2_match_data_create_from_pattern(p->pcre2_pattern, NULL);
> +		if (!p->pcre2_match_data)
> +			die("BUG: Couldn't allocate PCRE2 match data");
> +	} else {
> +		pcre2_get_error_message(error, errbuf, sizeof(errbuf));
> +		compile_regexp_failed(p, (const char *)&errbuf);
> +	}
> +
> +	pcre2_config(PCRE2_CONFIG_JIT, &canjit);
> +	if (canjit == 1) {
> +		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
> +		if (!jitret)
> +			p->pcre2_jit_on = 1;

I think the same "would it be better to do this without canjit?"
comment applies here.

> +#else /* !USE_LIBPCRE2 */
> +static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
> +{
> +	/* Unreachable until USE_LIBPCRE2 becomes synonymous with
> +	 * USE_LIBPCRE. See the sibling comment in
> +	 * grep_set_pattern_type_option().
> +	 */
> +	die("cannot use Perl-compatible regexes when not compiled with USE_LIBPCRE");
> +}

Wow.  If I were doing this, I wouldn't have been this cautious, but
I have no complaints ;-).

