Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 160A7209FC
	for <e@80x24.org>; Thu, 25 May 2017 09:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964900AbdEYJti (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 05:49:38 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37248 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937820AbdEYJth (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 05:49:37 -0400
Received: by mail-it0-f47.google.com with SMTP id g126so54464355ith.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UqGC0/kx4wMXjrMAycNhCxmsgvdRSQNOIOYsqtnq35Q=;
        b=bwT9wkODYVHHp+cSSHlCT2CBRNc2Pcj0jT8slQBRZ5yBma6da8hZi2ihc6hKfgEjB6
         UQBXppnqJEcE56cgyJVO2HFio8k9SFhH19LgxiOsJctfrsXmCGmcJ28tOjGJeNjLZGSJ
         iOh0mHTXvPxs+ta8oBvL4v6T9ELdykAp5OXT4lVR4dpZe/74xTiSziijWQG2BKHiH4JD
         pHEKTSZ1hcyalEGSNPZQLnEc5BT+JQPYYOLi0yclp9L3AEbDNscu1bhIWKky6eorNCqf
         4i15T2XOZXq0WyG2INGAqilBYi7GYG3nW+kPxqnhfBSrOOdQngVO456hs3/9Hg4LrSYS
         QGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UqGC0/kx4wMXjrMAycNhCxmsgvdRSQNOIOYsqtnq35Q=;
        b=KgAW3q7rjSd1evRALzimzNqy/jTNwpDm71+oweR7qmTXxz+NyS1pVgO+e3w8+Vwua3
         u5WjiRtwpkLag8V9FmCmk0jquVOjQP6kOhw87+iSIXrIE+VdOaRxbtKtch3JPyI5y/nP
         tkSXbXic9CA30ftw6GQqS72tji8nHXtvj2ib9nDclzfYSSqXO3usaNjqENNOG2hBwZR/
         w2K2fc+C4oVvp9vFKPIBQfchVmKfMZENfQBgSJz8Okf8EF6DHl+/X190iLTjG/d5/2Wm
         OSZoBKXh/DrWBoLoQxt5YiX+g4LlWstcTMdyTQHCbYtQTCunUSLqYWCRp6NxAr/Lgumc
         lYqw==
X-Gm-Message-State: AODbwcBN8qv/4ptkU9A3co0bAZ7UskcFV77Q+EYNX8TrhtXKq1BAHEB8
        FrpgXwCYzKIxQI+jke0hmiyBad1uJQ==
X-Received: by 10.36.37.78 with SMTP id g75mr12332026itg.94.1495705776107;
 Thu, 25 May 2017 02:49:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 25 May 2017 02:49:15 -0700 (PDT)
In-Reply-To: <xmqqa862hixh.fsf@gitster.mtv.corp.google.com>
References: <20170523192453.14172-1-avarab@gmail.com> <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
 <20170523192453.14172-8-avarab@gmail.com> <xmqqa862hixh.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 25 May 2017 11:49:15 +0200
Message-ID: <CACBZZX5Bp43eoWYvpnTtkwA8LyHzwZmrumxBG=-XXuqu1DMKSw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] grep: add support for PCRE v2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Simon Ruderich <simon@ruderich.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 8:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Add support for v2 of the PCRE API. This is a new major version of
>> PCRE that came out in early 2015[1].
>>
>> The regular expression syntax is the same, but while the API is
>> similar, pretty much every function is either renamed or takes
>> different arguments. Thus using it via entirely new functions makes
>> sense, as opposed to trying to e.g. have one compile_pcre_pattern()
>> that would call either PCRE v1 or v2 functions.
>>
>> Git can now be compiled with either USE_LIBPCRE1=3DYesPlease or
>> USE_LIBPCRE2=3DYesPlease, with USE_LIBPCRE=3DYesPlease currently being a
>> synonym for the former. Providing both is a compile-time error.
>>
>> With earlier patches to enable JIT for PCRE v1 the performance of the
>> release versions of both libraries is almost exactly the same, with
>> PCRE v2 being around 1% slower.
>>
>> However after I reported this to the pcre-dev mailing list[2] I got a
>> lot of help with the API use from Zolt=C3=A1n Herczeg, he subsequently
>> optimized some of the JIT functionality in v2 of the library.
>>
>> Running the p7820-grep-engines.sh performance test against the latest
>> Subversion trunk of both, with both them and git compiled as -O3, and
>> the test run against linux.git, gives the following results. Just the
>> /perl/ tests shown:
>>
>>     $ GIT_PERF_REPEAT_COUNT=3D30 GIT_PERF_LARGE_REPO=3D~/g/linux GIT_PER=
F_MAKE_COMMAND=3D'grep -q LIBPCRE2 Makefile && make -j8 USE_LIBPCRE2=3DYesP=
lease CC=3D~/perl5/installed/bin/gcc NO_R_TO_GCC_LINKER=3DYesPlease CFLAGS=
=3D-O3 LIBPCREDIR=3D/home/avar/g/pcre2/inst LDFLAGS=3D-Wl,-rpath,/home/avar=
/g/pcre2/inst/lib || make -j8 USE_LIBPCRE=3DYesPlease CC=3D~/perl5/installe=
d/bin/gcc NO_R_TO_GCC_LINKER=3DYesPlease CFLAGS=3D-O3 LIBPCREDIR=3D/home/av=
ar/g/pcre/inst LDFLAGS=3D-Wl,-rpath,/home/avar/g/pcre/inst/lib' ./run HEAD~=
2 HEAD~ HEAD p7820-grep-engines.sh
>>     [...]
>>     Test                                           HEAD~2            HEA=
D~                    HEAD
>>     --------------------------------------------------------------------=
--------------------------------------------
>>     7820.3: perl grep 'how.to'                      0.22(0.40+0.48)   0.=
22(0.31+0.58) +0.0%   0.22(0.26+0.59) +0.0%
>>     7820.7: perl grep '^how to'                     0.27(0.62+0.50)   0.=
28(0.60+0.50) +3.7%   0.22(0.25+0.60) -18.5%
>>     7820.11: perl grep '[how] to'                   0.33(0.92+0.47)   0.=
33(0.94+0.45) +0.0%   0.25(0.42+0.51) -24.2%
>>     7820.15: perl grep '(e.t[^ ]*|v.ry) rare'       0.35(1.08+0.46)   0.=
35(1.12+0.41) +0.0%   0.25(0.52+0.50) -28.6%
>>     7820.19: perl grep 'm(=C3=BA|u)lt.b(=C3=A6|y)te'          0.30(0.78+=
0.51)   0.30(0.86+0.42) +0.0%   0.25(0.29+0.54) -16.7%
>>
>> See commit ("perf: add a comparison test of grep regex engines",
>> 2017-04-19) for details on the machine the above test run was executed
>> on.
>>
>> Here HEAD~2 is git with PCRE v1 without JIT, HEAD~ is PCRE v1 with
>> JIT, and HEAD is PCRE v2 (also with JIT). See previous commits of mine
>> mentioning p7820-grep-engines.sh for more details on the test setup.
>>
>> For ease of readability, a different run just of HEAD~ (PCRE v1 with
>> JIT v.s. PCRE v2), again with just the /perl/ tests shown:
>>
>>     Test                                           HEAD~             HEA=
D
>>     --------------------------------------------------------------------=
-------------------
>>     7820.3: perl grep 'how.to'                      0.23(0.41+0.47)   0.=
23(0.26+0.59) +0.0%
>>     7820.7: perl grep '^how to'                     0.27(0.64+0.47)   0.=
23(0.28+0.56) -14.8%
>>     7820.11: perl grep '[how] to'                   0.34(0.95+0.44)   0.=
25(0.38+0.56) -26.5%
>>     7820.15: perl grep '(e.t[^ ]*|v.ry) rare'       0.34(1.07+0.46)   0.=
24(0.52+0.49) -29.4%
>>     7820.19: perl grep 'm(=C3=BA|u)lt.b(=C3=A6|y)te'          0.30(0.81+=
0.46)   0.22(0.33+0.54) -26.7%
>>
>> I.e. the two are either neck-to-neck, but PCRE v2 usually pulls ahead,
>> when it does it's around 20% faster.
>>
>> A brief note on thread safety: As noted in pcre2api(3) & pcre2jit(3)
>> the compiled pattern can be shared between threads, but not some of
>> the JIT context, however the grep threading support does all pattern &
>> JIT compilation in separate threads, so this code doesn't need to
>> concern itself with thread safety.
>
> Nicely explained.
>
>> -# Define LIBPCREDIR=3D/foo/bar if your libpcre header and library files=
 are in
>> +# Currently USE_LIBPCRE is a synonym for USE_LIBPCRE1, define
>> +# USE_LIBPCRE2 instead if you'd like to use version 2 of the PCRE
>> +# library. The USE_LIBPCRE flag will likely be changed to mean v2 by
>> +# default in future releases.
>> +#
>> +# Define LIBPCREDIR=3D/foo/bar if your PCRE header and library files ar=
e in
>>  # /foo/bar/include and /foo/bar/lib directories.
>
> As there is no way to use both, having a single LIBPCREDIR is not a
> hurting limitation, which makes sense.

Will nevertheless add a comment to clarify this.

>> @@ -2241,6 +2258,7 @@ GIT-BUILD-OPTIONS: FORCE
>>       @echo NO_CURL=3D\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >=
>$@+
>>       @echo NO_EXPAT=3D\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\'=
 >>$@+
>>       @echo USE_LIBPCRE1=3D\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCR=
E)))'\' >>$@+
>
> Shouldn't the line above record $(USE_LIBPCRE1) instead of the
> generic fallback?

Yes, will fix.

>> +     @echo USE_LIBPCRE2=3D\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCR=
E2)))'\' >>$@+
>>       @echo NO_PERL=3D\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >=
>$@+
>>       @echo NO_PTHREADS=3D\''$(subst ','\'',$(subst ','\'',$(NO_PTHREADS=
)))'\' >>$@+
>>       @echo NO_PYTHON=3D\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'=
\' >>$@+
>
>> diff --git a/grep.c b/grep.c
>> index 3c0c30f033..569cf9e290 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -179,22 +179,36 @@ static void grep_set_pattern_type_option(enum grep=
_pattern_type pattern_type, st
>>       case GREP_PATTERN_TYPE_BRE:
>>               opt->fixed =3D 0;
>>               opt->pcre1 =3D 0;
>> +             opt->pcre2 =3D 0;
>>               break;
>>
>>       case GREP_PATTERN_TYPE_ERE:
>>               opt->fixed =3D 0;
>>               opt->pcre1 =3D 0;
>> +             opt->pcre2 =3D 0;
>>               opt->regflags |=3D REG_EXTENDED;
>>               break;
>>
>>       case GREP_PATTERN_TYPE_FIXED:
>>               opt->fixed =3D 1;
>>               opt->pcre1 =3D 0;
>> +             opt->pcre2 =3D 0;
>>               break;
>>
>>       case GREP_PATTERN_TYPE_PCRE:
>>               opt->fixed =3D 0;
>> +#ifdef USE_LIBPCRE2
>> +             opt->pcre1 =3D 0;
>> +             opt->pcre2 =3D 1;
>> +#else
>> +             /* It's important that pcre1 always be assigned to
>> +              * even when there's no USE_LIBPCRE* defined. We still
>> +              * call the PCRE stub function, it just dies with
>> +              * "cannot use Perl-compatible regexes[...]".
>> +              */
>>               opt->pcre1 =3D 1;
>
> Very well thought-out comment.  Our style wants you to have
> slash-aster that opens a multi-line comment on its own line, though.
Will fix.
>> +             opt->pcre2 =3D 0;
>> +#endif
>>               break;
>>       }
>>  }
>> @@ -446,6 +460,126 @@ static void free_pcre1_regexp(struct grep_pat *p)
>>  }
>>  #endif /* !USE_LIBPCRE1 */
>>
>> +#ifdef USE_LIBPCRE2
>> +static void compile_pcre2_pattern(struct grep_pat *p, const struct grep=
_opt *opt)
>> +{
>> +...
>> +     p->pcre2_pattern =3D pcre2_compile((PCRE2_SPTR)p->pattern,
>> +                                      p->patternlen, options, &error, &=
erroffset,
>> +                                      p->pcre2_compile_context);
>
> Are all die("BUG:...") in this function actual bugs, or just
> "die()"?  Just like the comment on an earlier patch, things like
> running out of memory that you as a Git programmer cannot fix by
> correcting this code are not die("BUG:"), but normal runtime errors.
Will fix these.
>> +
>> +     if (p->pcre2_pattern) {
>> +             p->pcre2_match_data =3D pcre2_match_data_create_from_patte=
rn(p->pcre2_pattern, NULL);
>> +             if (!p->pcre2_match_data)
>> +                     die("BUG: Couldn't allocate PCRE2 match data");
>> +     } else {
>> +             pcre2_get_error_message(error, errbuf, sizeof(errbuf));
>> +             compile_regexp_failed(p, (const char *)&errbuf);
>> +     }
>> +
>> +     pcre2_config(PCRE2_CONFIG_JIT, &canjit);
>> +     if (canjit =3D=3D 1) {
>> +             jitret =3D pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_C=
OMPLETE);
>> +             if (!jitret)
>> +                     p->pcre2_jit_on =3D 1;
>
> I think the same "would it be better to do this without canjit?"
> comment applies here.
Yup, changed.
>> +#else /* !USE_LIBPCRE2 */
>> +static void compile_pcre2_pattern(struct grep_pat *p, const struct grep=
_opt *opt)
>> +{
>> +     /* Unreachable until USE_LIBPCRE2 becomes synonymous with
>> +      * USE_LIBPCRE. See the sibling comment in
>> +      * grep_set_pattern_type_option().
>> +      */
>> +     die("cannot use Perl-compatible regexes when not compiled with USE=
_LIBPCRE");
>> +}
>
> Wow.  If I were doing this, I wouldn't have been this cautious, but
> I have no complaints ;-).
>
