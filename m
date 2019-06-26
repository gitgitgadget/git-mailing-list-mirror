Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6A8B1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 14:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfFZOPb (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 10:15:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:41163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfFZOPb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 10:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561558405;
        bh=in6cAFF58NBFVuyhTVpLwIVHAjvHjLgpSiO8YyRbUxk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fopecTHloRTUYXa3ItvfY3NCgx4WEXbatkC9uDXJnptcmAHQpqhLr0W1J/BEliE8S
         4c2OrCWgTSSqvUST0fK8CKTZbJjHCTIfvnOVJ0O/sdJE6OklHyv+VE0QbJX2HlUGhU
         wp3vfvfYRJD1tc7CHC5XcqHT7mM55/m1uutZ9c1M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaIsi-1hzrQ52oZM-00JrpM; Wed, 26
 Jun 2019 16:13:25 +0200
Date:   Wed, 26 Jun 2019 16:13:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, gitster@pobox.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [RFC/PATCH 7/7] grep: use PCRE v2 for optimized fixed-string
 search
In-Reply-To: <20190626000329.32475-8-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906261610310.44@tvgsbejvaqbjf.bet>
References: <87r27u8pie.fsf@evledraar.gmail.com> <20190626000329.32475-8-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-535122378-1561558427=:44"
X-Provags-ID: V03:K1:jOttPr3Jgvk16TGZhE/oTpxBCxUQtX1Dsf8ZIVHYVKBxESCE1je
 3RvwRDIk5tJGtLGZzH9fUes3gPBvj/0rLmony4TAw1h4nV0x0NE0pXHgENirN7EfEjmA5/M
 E3dJNsLVa7q1v9crtjbVQP7Q1uQrI2vOFUJcXZxpxkB7NTyzselRWYeblrvkgcYsoWRNQqu
 8Hhg6BIYlqWvoGFr3zpdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/5eyxSpW5DI=:9wUfjHpck8zliTkDBMNUS5
 YTGjBWDQJHSK7RfzpX6aYvKABqdFaW8aT+Y9EIyVl1DfRrQRQHpiXdrtCfSQnjlOGPq85fYaL
 nRVCj6Dl6L5xzdsw/s0XnPXWS4vymbLbbJh/GMjI+Og/Q+7apQqhq+nPVwNLsgZnSmmcojH5n
 VMBnBQgCZlI2w0Wtt7K9msT+P62E045c9fux5B7VYgFsUxx1maR/FiwGPWJyo68FDfp0wr2II
 trJCQA9sY4xgvUJkW+ZlvuifqLyk1lSNLDrXr++Y9gjcUfL+KvhvMWGfXvrjCWuDd02eK/ciX
 GfVu8iDqb9L0WyUbjBiA30SSBSwdCTqmiiC2vpWNe1rECD+A9DWBmYMIN85ZI8MTGHMZ/DBXn
 v733EaLWZjlAtNzGayV4KJAUKISJprkJ0hrtkvE84ikJcJSNYQcBgD/tqWtVIlS8G9NNY9DNa
 VeR+FE7/1bRz4LlROxFeVBfkTujYZQ4GG9lTjk0ysbajHo6nQ9jIfGqkC1UO8prNWWiHjvUkz
 p0iy0Tf8o51sCgEgk6AKoyDGpBRo3nzytFw8XLBtaiCO21juchXaEJM7/8dAAvI3JWVn2itEH
 kDXzVivnmIXQe5xMKJ8N6JvIKo9kMOTIhfcKrq5dAgw/3FTG1HrEjULw/WQ/Z7p9jtGG+Iqfj
 2A6qi0Ref0R6tmnY6V6C+gcDi2DxC7YHl9FDvMnrkvknaUV0DZswM+44723ZMKdE8jdCv0wjz
 LMUqxqVj3Y5b+ltpY7cN58vBW1TP4wf/VXtkcp1w3PjDRJA6mKTEKnguJazsWohiAqOpWfv4N
 kv/lpcbmP490m4Q0FJB3nZW0nhVhAOceYLyXQZEDXnp7uGac2wJ7lcVqj/GbZCZYHulcTwUL9
 gwDBdWivBfTOZuWndZVHJBEDN1Ai8Lna2wgl8weoitMggSNuF2nSd6fkzTa+JkAhSLVwxhB1Y
 4bTyCMlTGhB30cbm5vrsrrEOVcpufbWvKojLmMXy5WxcW3jZA1Qlf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-535122378-1561558427=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 26 Jun 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Bring back optimized fixed-string search for "grep", this time with
> PCRE v2 as an optional backend. As noted in [1] with kwset we were
> slower than PCRE v1 and v2 JIT with the kwset backend, so that
> optimization was counterproductive.
>
> This brings back the optimization for "-F", without changing the
> semantics of "\0" in patterns. As seen in previous commits in this
> series we could support it now, but I'd rather just leave that
> edge-case aside so the tests don't need to do one thing or the other
> depending on what --fixed-strings backend we're using.

Nice. Very, very nice.

> I could also support the v1 backend here, but that would make the code
> more complex, and I'd rather aim for simplicity here and in future
> changes to the diffcore. We're not going to have someone who
> absolutely must have faster search, but for whom building PCRE v2
> isn't acceptable.

I could not agree more.

> diff --git a/grep.c b/grep.c
> index 4716217837..6b75d5be68 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -356,6 +356,18 @@ static NORETURN void compile_regexp_failed(const st=
ruct grep_pat *p,
>  	die("%s'%s': %s", where, p->pattern, error);
>  }
>
> +static int is_fixed(const char *s, size_t len)
> +{
> +	size_t i;
> +
> +	for (i =3D 0; i < len; i++) {
> +		if (is_regex_special(s[i]))
> +			return 0;
> +	}
> +
> +	return 1;
> +}
> +
>  #ifdef USE_LIBPCRE1
>  static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_=
opt *opt)
>  {
> @@ -602,7 +614,6 @@ static int pcre2match(struct grep_pat *p, const char=
 *line, const char *eol,
>  static void free_pcre2_pattern(struct grep_pat *p)
>  {
>  }
> -#endif /* !USE_LIBPCRE2 */

Huh? Removing an `#endif` without removing the corresponding `#if`?

... but...

>  static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *o=
pt)
>  {
> @@ -623,11 +634,13 @@ static void compile_fixed_regexp(struct grep_pat *=
p, struct grep_opt *opt)
>  		compile_regexp_failed(p, errbuf);
>  	}
>  }
> +#endif /* !USE_LIBPCRE2 */

Ah hah!

If we would not have plenty of exercise for the PCRE2 build options, I
would be worried. But AFAICT the CI build includes this all the time, so
we're fine.

>  static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
>  {
>  	int err;
>  	int regflags =3D REG_NEWLINE;
> +	int pat_is_fixed;
>
>  	p->word_regexp =3D opt->word_regexp;
>  	p->ignore_case =3D opt->ignore_case;
> @@ -636,8 +649,38 @@ static void compile_regexp(struct grep_pat *p, stru=
ct grep_opt *opt)
>  	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
>  		die(_("given pattern contains NULL byte (via -f <file>). This is only=
 supported with -P under PCRE v2"));
>
> -	if (opt->fixed) {
> +	pat_is_fixed =3D is_fixed(p->pattern, p->patternlen);
> +	if (opt->fixed || pat_is_fixed) {
> +#ifdef USE_LIBPCRE2
> +		opt->pcre2 =3D 1;
> +		if (pat_is_fixed) {
> +			compile_pcre2_pattern(p, opt);
> +		} else {
> +			/*
> +			 * E.g. t7811-grep-open.sh relies on the
> +			 * pattern being restored, and unfortunately
> +			 * there's no PCRE compile flag for "this is
> +			 * fixed", so we need to munge it to
> +			 * "\Q<pat>\E".
> +			 */
> +			char *old_pattern =3D p->pattern;
> +			size_t old_patternlen =3D p->patternlen;
> +			struct strbuf sb =3D STRBUF_INIT;
> +
> +			strbuf_add(&sb, "\\Q", 2);
> +			strbuf_add(&sb, p->pattern, p->patternlen);
> +			strbuf_add(&sb, "\\E", 2);
> +
> +			p->pattern =3D sb.buf;
> +			p->patternlen =3D sb.len;
> +			compile_pcre2_pattern(p, opt);
> +			p->pattern =3D old_pattern;
> +			p->patternlen =3D old_patternlen;
> +			strbuf_release(&sb);
> +		}
> +#else
>  		compile_fixed_regexp(p, opt);
> +#endif

It might be a bit easier to read if the shorter clause came first.

Other than that: what a nice read. I should save reviewing all your patch
series for just-before-bed time.

Thanks,
Dscho

>  		return;
>  	}
>
> --
> 2.22.0.455.g172b71a6c5
>
>

--8323328-535122378-1561558427=:44--
