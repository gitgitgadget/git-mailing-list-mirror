Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF0D9466
	for <git@vger.kernel.org>; Mon,  1 Jan 2024 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="mSTeZUUS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704129502; x=1704734302; i=l.s.r@web.de;
	bh=YEkRTDg6ck7bcE4C9glqBrE9Vvv+rrA7C32Aih1lGZQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=mSTeZUUS4n5nXSoHyJ6S73jDt4/KiRvZBHSIXAAf+QZ/tlxbGUYh0hdGmgK3OsUT
	 ye9TY7Jkz+WkhFSS2VmwqiPiKWdrTd0TbghBrbWaR0c7vpkYp/sPeQbez1pytZU+N
	 cg3Ch7HPFJkW+lHoSY+u3bbV4PYZcYW/pTI3x4EXTYyJLeMW+UAakUk1fsDpvwPy0
	 ittlwFFZO65x7sIJAO4/ET6aoIvrYp57R/K8OlJiF0qxMQKAf2yTlxFtFAonno4K4
	 HeqXL/+3xeWBGfSIaZER5SsuVUmpUh1fwK0LTL2j7eop8cetwyquooJ6hR3u2RDlB
	 oLnFdqcofXHj0VNNdQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhWkh-1qgK0j1ymB-00e9Xx; Mon, 01
 Jan 2024 18:18:22 +0100
Message-ID: <55309061-5996-4f70-8e6b-b341fc632ddf@web.de>
Date: Mon, 1 Jan 2024 18:18:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] grep: default to posix digits with -P
Content-Language: en-US
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 git@vger.kernel.org
References: <20240101150336.89098-1-carenas@gmail.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240101150336.89098-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vCE+XPI9cn/5eEaDaABCHgaelZeMAxFEaPGbvVd/frotAnSOr3D
 hhjL4BOMzS4PVkJyBgblD/6fV32//Bw+m3akNwaQ0pkKjxmGdLzWOj5hs658VkiY2hT9itd
 ILp8gzkAc4317Kg9aIUERVgi0jt2U5IKwkP3+Jr8yFUGDZM9ghDjBWk98hGH0xIvs89yMoI
 fmieFZI7Xr+d69gPTdFLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oEcLxLWAVtA=;pDsUyyFXbXQQcNrcz6hYSdRt6NV
 xBW6GvZqR7JHh3AhquNmVlq75gQKxQrlh0A48HCJLvVtOhSmPykqt+/2uSB+V6tLjYppxQFh9
 jbpE2UXY8wh4E7s95w/J4dmUJbTcYApBzgV7kQimpcvGwiwcM9xrdI1jIbhbaN4meayEbqg9m
 AVXzlsXjWwd16c4lusgiMAEhckl20wEiDzHNZ7IhuN0dAh2+bIaJQvq2ebDrY+TN3EA1jdrbw
 c0VqiYyH+5yyuOx+qizZiLi5/kIGYMVFqew1btDbrMbbp9ccciqyKNfPAu7meZzYUptMWVP4M
 /cnEfouFqmUJqCBJIEpySGK1smXKYQz1UPNqK2tjdTZKBPifddTYqZ+/ueOmFC6VEkNZINFFC
 nJ8G0JC8+XmTHGqxSQgzRNCOnv/G6n222W6pUJp2PZV2kguCeNSW5EVyFeUnOipJfM/G9ftbF
 630bzTAGRYmUzKTKb8L0iQZ1OYIbmQup0FCNh5NxnSwoJEIs32Ys0Kr6XzkS59/6Li+uhLMlG
 +oEfngafHSFdprmBPDtUsxlXY4q+s4r64Bd+cOAzcejtbDEgWOiK9hrcdFVjx6eK9AJ41x+tl
 dnItBoUrpleioDOubrVax8mT2MNNqZ8yLOziIFltWT7UXPzmyu7wXFkBGTqXRG0EvIPfMi+Te
 RpsV7Gq4DXQUnL8S0nccIhq9xa+Afj3SY+gb5KZK9/8ZW+CHR9aK/mJkxtkpc/zaZwEearg/1
 xwGscUzJF0d7LlVyMUCSs6XosDjrfGVTPWoWVbYzTXerZMzhpodYVa2xouVQkbgYHHZY5GTJX
 ekHUiKkczbWYKu23aODHzC8Gvdd6vvi50xO5RUoULzNsKTY7QDrzWY9wHxs2NaTBLk6GwSH3h
 fdxzDS03oXiRja6ABDy/gqgZQJYnfNGVkDU/EK6xFnYe/L+oYcKy+7W8AA2bqMzlXPBHKTsIT
 HUt5WMEVuPBJrPO3HV+Rz+htHJs=

Am 01.01.24 um 16:03 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> Since acabd2048e (grep: correctly identify utf-8 characters with
> \{b,w} in -P, 2023-01-08), PCRE2's UCP mode has been enabled when
> UTF content was expected and therefore muktibyte characters are
> included as part of all character classes (when defined).
>
> note that if the locale used is not UTF enabled (specially: C, POSIX)
> or uses an extended charmap binary that is not unicode compatible, binar=
y
> match will be used instead.
>
> It was argued that doing so, at least for \d, was not a good idea,
> as that might not be what the user expected based on its historical
> meaning and was also slower, and indeed a similar change that was done
> to GNU grep was reverted and required further tweaks.
>
> At that time, PCRE2 didn't have a way to disable UCP's character
> expansion selectively, but flags to do so, and that will be
> available in the next release (planned soon) were added, and
> one of them has been in use by GNU grep since their last release
> in May (only if built and linked against the prereleased PCRE2
> library though).
>
> Add flags to make sure that both \d and [:digit:] only include
> ASCII digits so that `git grep` will be closer to GNU grep and
> improve performance as a side effect, but add a configuration flag
> to allow keeping the current behaviour (which is closer to perl
> and ripgrep).
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  Documentation/config/grep.txt       |  4 ++++
>  grep.c                              | 37 ++++++++++++++++++++++-------
>  grep.h                              |  5 ++++
>  t/perf/p7822-grep-perl-character.sh | 11 +++++++--
>  t/t7818-grep-digit.sh               | 32 +++++++++++++++++++++++++
>  5 files changed, 78 insertions(+), 11 deletions(-)
>  create mode 100755 t/t7818-grep-digit.sh
>
> diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.t=
xt
> index e521f20390..4e405c8ad1 100644
> --- a/Documentation/config/grep.txt
> +++ b/Documentation/config/grep.txt
> @@ -26,3 +26,7 @@ grep.fullName::
>  grep.fallbackToNoIndex::
>  	If set to true, fall back to git grep --no-index if git grep
>  	is executed outside of a git repository.  Defaults to false.
> +
> +grep.perl.digit::
> +	If set to true, use the perl definitions for \d and [:digit:].
> +	Defaults to false.
> diff --git a/grep.c b/grep.c
> index fc2d0c837a..fec36ccb30 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -88,6 +88,11 @@ int grep_config(const char *var, const char *value,
>  		return 0;
>  	}
>
> +	if (!strcmp(var, "grep.perl.digit")) {
> +		opt->perl_digit =3D git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "color.grep"))
>  		opt->color =3D git_config_colorbool(var, value);
>  	if (!strcmp(var, "color.grep.match")) {
> @@ -301,6 +306,7 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>  	int patinforet;
>  	size_t jitsizearg;
>  	int literal =3D !opt->ignore_case && (p->fixed || p->is_fixed);
> +	uint32_t xoptions =3D 0;
>
>  	/*
>  	 * Call pcre2_general_context_create() before calling any
> @@ -321,17 +327,22 @@ static void compile_pcre2_pattern(struct grep_pat =
*p, const struct grep_opt *opt
>  		}
>  		options |=3D PCRE2_CASELESS;
>  	}
> -	if (!opt->ignore_locale && is_utf8_locale() && !literal)
> -		options |=3D (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALID_UTF);
> +	if (!opt->ignore_locale && is_utf8_locale() && !literal) {
> +		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>
> -#ifndef GIT_PCRE2_VERSION_10_35_OR_HIGHER
> -	/*
> -	 * Work around a JIT bug related to invalid Unicode character handling
> -	 * fixed in 10.35:
> -	 * https://github.com/PCRE2Project/pcre2/commit/c21bd977547d
> -	 */
> -	options &=3D ~PCRE2_UCP;
> +#ifdef GIT_PCRE2_VERSION_10_35_OR_HIGHER
> +		/*
> +		 * Work around a JIT bug related to invalid Unicode character handlin=
g
> +		 * fixed in 10.35:
> +		 * https://github.com/PCRE2Project/pcre2/commit/c21bd977547d
> +		 */
> +		options |=3D PCRE2_UCP;
> +#ifdef GIT_PCRE2_VERSION_10_43_OR_HIGHER
> +		if (!opt->perl_digit)
> +			xoptions |=3D (PCRE2_EXTRA_ASCII_BSD | PCRE2_EXTRA_ASCII_DIGIT);
>  #endif
> +#endif

Why do we need that extra level of indentation?

The old code turned PCRE2_UCP on by default and turned it off for older
versions.  The new code enables PCRE2_UCP only for newer versions.  The
result should be the same, no?  So why change that part at all?

But the comment is now off, isn't it?  The workaround was turning
PCRE2_UCP off for older versions (because those were broken), not
turning it on for newer versions (because it would be required by some
unfixed regression).

Do we need to nest the checks for GIT_PCRE2_VERSION_10_35_OR_HIGHER and
GIT_PCRE2_VERSION_10_43_OR_HIGHER?  Keeping them separate would help
keep the #ifdef parts as short as possible and maintainable
independently.

> +	}
>
>  #ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
>  	/* Work around https://bugs.exim.org/show_bug.cgi?id=3D2642 fixed in 1=
0.36 */
> @@ -339,6 +350,14 @@ static void compile_pcre2_pattern(struct grep_pat *=
p, const struct grep_opt *opt
>  		options |=3D PCRE2_NO_START_OPTIMIZE;
>  #endif
>
> +	if (xoptions) {
> +		if (!p->pcre2_compile_context)
> +			p->pcre2_compile_context =3D pcre2_compile_context_create(p->pcre2_g=
eneral_context);
> +
> +		pcre2_set_compile_extra_options(p->pcre2_compile_context,
> +						xoptions);
> +	}
> +
>  	p->pcre2_pattern =3D pcre2_compile((PCRE2_SPTR)p->pattern,
>  					 p->patternlen, options, &error, &erroffset,
>  					 p->pcre2_compile_context);
> diff --git a/grep.h b/grep.h
> index 926c0875c4..cd5c416a0a 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -4,6 +4,9 @@
>  #ifdef USE_LIBPCRE2
>  #define PCRE2_CODE_UNIT_WIDTH 8
>  #include <pcre2.h>
> +#if (PCRE2_MAJOR >=3D 10 && PCRE2_MINOR >=3D 43) || PCRE2_MAJOR >=3D 11
> +#define GIT_PCRE2_VERSION_10_43_OR_HIGHER
> +#endif
>  #if (PCRE2_MAJOR >=3D 10 && PCRE2_MINOR >=3D 36) || PCRE2_MAJOR >=3D 11
>  #define GIT_PCRE2_VERSION_10_36_OR_HIGHER
>  #endif
> @@ -178,6 +181,8 @@ struct grep_opt {
>
>  	void (*output)(struct grep_opt *opt, const void *data, size_t size);
>  	void *output_priv;
> +
> +	unsigned perl_digit:1;
>  };
>
>  #define GREP_OPT_INIT { \
> diff --git a/t/perf/p7822-grep-perl-character.sh b/t/perf/p7822-grep-per=
l-character.sh
> index 87009c60df..cc88d5a695 100755
> --- a/t/perf/p7822-grep-perl-character.sh
> +++ b/t/perf/p7822-grep-perl-character.sh
> @@ -8,6 +8,13 @@ etc.) we will test the patterns under those numbers of =
threads.
>
>  . ./perf-lib.sh
>
> +# setting a LOCALE is needed, but not yet supported by :
> +#. "$TEST_DIRECTORY"/lib-gettext.sh
> +
> +# Invoke like:
> +#
> +# LC_ALL=3Dis_IS.utf8 ./p7822-grep-perl-character.sh
> +
>  test_perf_large_repo
>  test_checkout_worktree
>
> @@ -27,13 +34,13 @@ do
>  	if ! test_have_prereq PERF_GREP_ENGINES_THREADS
>  	then
>  		test_perf "grep -P '$pattern'" --prereq PCRE "
> -			git -P grep -f pat || :
> +			git grep -P -f pat || :
>  		"
>  	else
>  		for threads in $GIT_PERF_GREP_THREADS
>  		do
>  			test_perf "grep -P '$pattern' with $threads threads" --prereq PTHREA=
DS,PCRE "
> -				git -c grep.threads=3D$threads -P grep -f pat || :
> +				git -c grep.threads=3D$threads grep -P -f pat || :

What's going on here?  You remove the -P option of git (--no-pager) and
add the -P option of git grep (--perl-regexp).  So this perf test never
tested PCRE despite its name?  Seems worth a separate patch.

Do the performance numbers in acabd2048e (grep: correctly identify utf-8
characters with \{b,w} in -P, 2023-01-08) still hold up in that light?

>  			"
>  		done
>  	fi

Ren=C3=A9

