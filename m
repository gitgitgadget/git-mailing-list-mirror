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
	by dcvr.yhbt.net (Postfix) with ESMTP id C89121F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfI3Jw4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:52:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:40267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbfI3Jw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569837169;
        bh=GDGMfYtakOwC6l79PcwnzqR2wDPC3Pdr0wEYvxxLWwM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Us0BMrcIIXl51Zer9cchKVdMavk+ivdcKlHES+gNPmADdjqEHidrJtph+rZP25g9k
         UzEc6GhpkaxN8Hlh4YHJxywEyvj5qxPa1llbC/9JKQBbNzdQMPd0lj3tO/M7yMnJS8
         eQo9eXkiUk4NIuzHyzLdnWMf9/KksXNMAIcYML88=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1po0-1iH5Hl0sTg-002IHb; Mon, 30
 Sep 2019 11:52:49 +0200
Date:   Mon, 30 Sep 2019 11:52:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 11/13] tests: let --immediate and --write-junit-xml play
 well together
In-Reply-To: <xmqq7e5sjc1p.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1909301151050.46@tvgsbejvaqbjf.bet>
References: <pull.288.git.gitgitgadget@gmail.com> <99724f6a1e45b497e15037bbac1cb5f70a3bb236.1569486607.git.gitgitgadget@gmail.com> <xmqq7e5sjc1p.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dT/CuGUFhGdAIRyTv2UmVWVrOlLxBYWeMJGiREh4BRtmECg+Le9
 DdZ5/eoaqBtNlfR8NJWkvMJVa5Oltu/op5iLn/m6RLhRM7sX5UA/o/OA+JRzlbpbIhjctMt
 0jcDXnLeYvDJbjRvF4GErnevNCjmHvMdgEQgb7VX35QE+P3ucSVbRFog29gsye6WNZjrVdo
 /0U7ZcPrkeIL2OqMwDLWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g47pTSU4Wco=:B2IV4465rP7yRW5q66Rxdb
 IuXUvriInAnmNCCmMoYAIZWJxciXUb4dmtqJ/TsXADe+1Yxsqyl7QDlUOjiewx6zDQkb657aE
 tumiqzHnXBLjpyEP9ZJ2mQs1KPEcXzQz/M84yo4GZChbpuC5+lfbicrVUgJ4KKixAzV7Im6xb
 f/iK6MEkJ/9A8yhckUyesMWDOiF/kgC7LDPM0RoZozm7ywhHrezJhgWFiXGX+M9DC2ND4ut+S
 DTSmi2rfJfpe/+RPLWZAoKPp+4GMEe0Fvmc+sB7yDAwHBonGVTCSX68xiGqSbfrr86dJm9uu4
 oD6Xf4JurhsOcZh4UfTVlAvDObA8XVC80XByULG78P895MXBD9olSUJNEFQVFcCCHiulgQbXp
 yUDoFCDPkqt8Hsuw/BOlmHB3e/yrRtSQUuHUxcj9rncuK8nuW9rcjQToMjnLjn73PcQKE20bm
 Th3PaqSpbvf7EEywmsiE1PrzqTfvf/oT3qK1z3x8IbNW30VZB61xa48j11wA2cRDyIMNgfidf
 RQrSYcADm3rfMgvsm3JNRIue5nIWMSGE1IXFWB6dbMEbEvsWHhLgVTUTgebvsdninblzeJXjD
 Kh9cpLmVJJt1Wb0eXL8ApJY5UMdPTzhmDH9mwk+AngSnYzQaZ27R7SSQi9fDdS68ouxrCUUN7
 ylUz1AjSy6tuIQaYzpRI0knvwLxal75/jYdYwKqnlPA7RV8eaaWTfzjPU/ryjZpUXfM4TOJzU
 pjCm7qVrVuss0GSawHwhuz6tZTqQxP56J9Yfc1z5K0IefRjtXQxX5cansfgKhOM861oogfcUi
 tj6ds10YLY4Il69/f0RST8CYQGIHpbVc9IXz9g9oHr9UeNdsiqIWTTYOZPm5yVFMkAby9YZOG
 qomDYBNxcZv88lK4on+EjOuPEiisHZmUvaavrphqEGlDat3SlNu1DuL+1tB0vr4K5wDSmbQXv
 mA+GCIR+apHxO5FI2wxJSxkmXKSbc1q4gRKDUcF+S8F2iCQrK6tDvDr4Doce8+fo54LVSrTsD
 D2alb0m7qqCVZ750So8bwoLqILm3T1AsJfrdNS1ArvcrcMYNkDqt9CaMBBhowHNHsFqnktQ7k
 D1az4ABokk1z8m3nQBPnxWLHmR+NKYclg6LVlgFnhctukPnh3BrrZLd1j8lA91FVl17GKpq90
 rMRy+0vF1KQqobr1pJwK9ZVlyK/cTMBv9dIFzmzmS3p+MuLwdm2OlqmkTaHyx8Yk7tSV+NsfO
 SAmHOER4hvv6RnF/CaGHGm9VeA2w874e65RrKR/x6Gk8KBMno08iUc7xqGkw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 29 Sep 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index d1ba33745a..f21c781e68 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -695,7 +695,7 @@ test_failure_ () {
> >  	say_color error "not ok $test_count - $1"
> >  	shift
> >  	printf '%s\n' "$*" | sed -e 's/^/#	/'
> > -	test "$immediate" =3D "" || { GIT_EXIT_OK=3Dt; exit 1; }
> > +	test "$immediate" =3D "" || { finalize_junit_xml; GIT_EXIT_OK=3Dt; e=
xit 1; }
> >  }
>
> There are three places that do GIT_EXIT_OK=3Dt in the test framework,
> and the above covers one of them.  The original in test_done is
> another, and that place is made to call the "finalize" thing (it
> used to have the same finalization code inlined).
>
> The remaining one appears in
>
>         error () {
>                 say_color error "error: $*"
>                 GIT_EXIT_OK=3Dt
>                 exit 1
>         }
>
> I wonder if we should cover this case, too.  One caller of "error" I
> know is BUG that says "bug in the test script", which means that
> after successfully passing 30 tests, when the 31st test has 5 params
> to test_expect_success by mistake, without finailzation we will lose
> the result for the first 30.

Good point.

> And if we call "finalize" from the "error" helper, perhaps it makes
> even more sense to update the above manual exit in test_failure_ to
> do something like
>
> 	if test -n "$immediate"
> 	then
> 		error "immediate exit after the first error"
> 	fi
>
> to delegate the finalization.

This adds an additional message. I am not sure how many scripts/CI
integrations are there that rely on the current behavior, so I would
like to exclude this change from this here patch series: it is about
including a Visual Studio build in our Azure Pipeline, nothing more,
nothing less...

Ciao,
Dscho

>
> > @@ -1085,21 +1104,7 @@ test_done () {
> >  	# removed, so the commands can access pidfiles and socket files.
> >  	test_atexit_handler
> >
> > -	if test -n "$write_junit_xml" && test -n "$junit_xml_path"
> > -	then
> > -		test -n "$junit_have_testcase" || {
> > -			junit_start=3D$(test-tool date getnanos)
> > -			write_junit_xml_testcase "all tests skipped"
> > -		}
> > -
> > -		# adjust the overall time
> > -		junit_time=3D$(test-tool date getnanos $junit_suite_start)
> > -		sed "s/<testsuite [^>]*/& time=3D\"$junit_time\"/" \
> > -			<"$junit_xml_path" >"$junit_xml_path.new"
> > -		mv "$junit_xml_path.new" "$junit_xml_path"
> > -
> > -		write_junit_xml "  </testsuite>" "</testsuites>"
> > -	fi
> > +	finalize_junit_xml
> >
> >  	if test -z "$HARNESS_ACTIVE"
> >  	then
>
