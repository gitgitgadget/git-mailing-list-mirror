Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7555B1F403
	for <e@80x24.org>; Sat,  2 Jun 2018 21:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeFBVTp (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 17:19:45 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:40075 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeFBVTo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 17:19:44 -0400
Received: by mail-wm0-f48.google.com with SMTP id x2-v6so8000458wmh.5
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 14:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Bxhu4L6vArz8Yiy1PTvbUN3EjZHGIdooemqriBb+v/I=;
        b=WmwCVvVyMYKpTaGwwLSWUsV6IrVE9D34ssvnKiYe8fRm48BaPG2ufaQW5D9mUmIPyH
         Yni5FO7iEQi0veVjIPDLaBgQ5BfpXueoHY4nFNF89piz7wmqUQlN6EEvpVO6g6IEibFp
         7EYxTyFctJ/DmKcKwNW/+rJIIUnAF4DP9kgjEyxghRj/bIba6NcZwDkjIshegNlAxAZB
         yGYi5ispDj1GTBi0FkJIrQtGpo0POqeFaFLs7lxBeE63MAbykFB7WZBz6uHYQ6CfBNYp
         sdwYR2w5Lby9R+8GR9i3mTEb8Ty59LpdgPVOMpus163eH7XJ3YWB6wrWJOP1LZDlTojJ
         1V2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Bxhu4L6vArz8Yiy1PTvbUN3EjZHGIdooemqriBb+v/I=;
        b=L4Q++en6sX1Fl641L7zn/QdtMmTUvsRsrod2rLHBi5a887UqHT5bEGXfPmA9K7FvKO
         6IViGxMMCQidOyHrNS0zFp2NQ0C+hSU5hc3l9Hvrihj07hWlqwKH8TFfxTF6S9ac1Ux0
         4R3aGNln29ApnpFQ1DapE7HXGZvSyJuuYjnjvQGTXkMidM81SE9TuVfYZmmnQla7pcWd
         fbrFbX9UrxXcQTQNg8+DhwpWf35MwQAXlCXHFzERYvmVY+20CIQVmuLjJGl4t7cwZxHn
         kQ/hytxAtStUd85t5UUrCtlqBmuNPx8hh5R+DaFfAhu+w8KKvbLTeQNs+RGvEMr3E3ar
         b9YA==
X-Gm-Message-State: APt69E3pbBGeEKcEoHDrG6Rv5nYhcQNyILaKQ+S9+l474rCH1kW8y3c7
        y9cyAXMni4eZAUZSuaF9qpKUWTNR
X-Google-Smtp-Source: ADUXVKIlTpiM/kHT8fmVfG44UkOvN/vaHwo2iOJkPQSIRZrvzEFHLkNcEzQwrlFsDbEpmZ0X+W5Epg==
X-Received: by 2002:a1c:bfc8:: with SMTP id o69-v6mr6231090wmi.8.1527974382923;
        Sat, 02 Jun 2018 14:19:42 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abri112.neoplus.adsl.tpnet.pl. [83.8.102.112])
        by smtp.gmail.com with ESMTPSA id b72-v6sm6565362wmf.2.2018.06.02.14.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Jun 2018 14:19:40 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 06/20] commit-graph: add 'verify' subcommand
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-7-dstolee@microsoft.com>
        <86y3g4yahm.fsf@gmail.com>
        <4343f593-5650-3b24-54ec-a0d97d5251e9@gmail.com>
Date:   Sat, 02 Jun 2018 23:19:37 +0200
In-Reply-To: <4343f593-5650-3b24-54ec-a0d97d5251e9@gmail.com> (Derrick
        Stolee's message of "Wed, 30 May 2018 12:07:39 -0400")
Message-ID: <86d0x8rimu.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 5/27/2018 6:55 PM, Jakub Narebski wrote:
>> Derrick Stolee <dstolee@microsoft.com> writes:
[...]
>>> +static int verify_commit_graph_error;
>>> +
>>> +static void graph_report(const char *fmt, ...)
>>> +{
>>> +	va_list ap;
>>> +	struct strbuf sb =3D STRBUF_INIT;
>>> +	verify_commit_graph_error =3D 1;
>>> +
>>> +	va_start(ap, fmt);
>>> +	strbuf_vaddf(&sb, fmt, ap);
>>> +
>>> +	fprintf(stderr, "%s\n", sb.buf);
>>> +	strbuf_release(&sb);
>>> +	va_end(ap);
>>
>> Why do you use strbuf_vaddf + fprintf instead of straighforward
>> vfprintf (or function instead of variable-level macro)?
>>
>> Is it because of [string] safety?
>
> It's because I've never used this variable-parameter thing before and
> found a different example.
>
> I'll use vfprintf() in v4, as it is simpler.

All right, if it is not dangerous, then simpler is better.

Sidenote: such error messaging is often handled by variadic macros,
e.g.:

  #define eprintf(...) fprintf(stderr, __VA_ARGS__)

[...]
>>> diff --git a/commit-graph.h b/commit-graph.h
>>> index 96cccb10f3..71a39c5a57 100644
>>> --- a/commit-graph.h
>>> +++ b/commit-graph.h
>>> @@ -53,4 +53,6 @@ void write_commit_graph(const char *obj_dir,
>>>   			int nr_commits,
>>>   			int append);
>>>   +int verify_commit_graph(struct commit_graph *g);
>>> +
>> Why does this need to be exported?  I think it is not used outside of
>> commit-graph.c, isn't it?
>
> Used by builtin/commit-graph.c

Ah, true.

[...]
>>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>>> index 77d85aefe7..6ca451dfd2 100755
>>> --- a/t/t5318-commit-graph.sh
>>> +++ b/t/t5318-commit-graph.sh
>>> @@ -11,6 +11,11 @@ test_expect_success 'setup full repo' '
>>>   	objdir=3D".git/objects"
>>>   '
>>> +test_expect_success 'verify graph with no graph file' '
>>> +	cd "$TRASH_DIRECTORY/full" &&
>>> +	git commit-graph verify
>>> +'
>>> +
>>>   test_expect_success 'write graph with no packs' '
>>>   	cd "$TRASH_DIRECTORY/full" &&
>>>   	git commit-graph write --object-dir . &&
>>> @@ -230,4 +235,9 @@ test_expect_success 'perform fast-forward merge in =
full repo' '
>>>   	test_cmp expect output
>>>   '
>>>   +test_expect_success 'git commit-graph verify' '
>>> +	cd "$TRASH_DIRECTORY/full" &&
>>> +	git commit-graph verify >output
>>> +'
>> Those are tests with nearly the same code, but they are (by their
>> descriptions) testing different things.  This means that they rely on
>> side effects of earlier tests.
>>
>> This is suboptimal, as it means that it would be impossible or very
>> difficult to run individual tests (e.g. with GIT_SKIP_TESTS environment
>> variable, or with an individual test suite --run option), unless you
>> know which tests setup the repository state for later tests.
>>
>> It also means that running only failed tests with prove
>> --state=3Dfailed,save or equivalently with
>>
>>    $ make DEFAULT_TEST_TARGET=3Dprove GIT_PROVE_OPTS=3D'--state=3Dfailed=
,save' test
>>
>> wouldn't work correctly.
>>
>> As Johannes Schindelin (alias Dscho) said in latest Git Rev News
>> interview: https://git.github.io/rev_news/2018/05/16/edition-39/
>>
>> JS> We have a test suite where debugging a regression may mean that you
>> JS> have to run 98 test cases before the failing one every single time in
>> JS> the edit/compile/debug cycle, because the 99th test case may depend =
on
>> JS> a side effect of at least one of the preceding test cases. Git=E2=80=
=99s test
>> JS> suite is so not [21st century best practices][1].
>> JS>
>> JS> [1]: https://www.slideshare.net/BuckHodges/lessons-learned-doing-dev=
ops-at-scale-at-microsoft
>>
>>
>> I think can be solved quite efficiently by creating and using shell
>> function, or two shell functions, which would either:
>>
>>   * rename commit-graph file to some other temporary name if it exists,
>>     and move it back after the test.
>>   * create commit-graph file if it does not exist.
>>
>> For example (untested):
>>
>>    prepare_no_commit_graph() {
>>    	mv .git/info/commit-graph .git/info/commit-graph.away &&
>>    	test_when_finished "mv .git/info/commit-graph.away .git/info/commit-=
graph"
>>    }
>>
>>    prepare_commit_graph() {
>>    	if ! test -f ".git/info/commit-graph"
>>    	then
>>    		git commit-graph write
>>    	fi
>>    }
>>
>> Or something like that.
>
> Do we have a way to run individual steps of the test suite? I am
> unfamiliar with that process.

The t/README describes three such ways in "Skipping Tests" section:

- GIT_SKIP_TESTS environment variable, which can either can match the
  "t[0-9]{4}" part to skip the whole test, or t[0-9]{4} followed by
  ".$number" to say which particular test to skip

- For an individual test suite --run could be used to specify that
  only some tests should be run or that some tests should be
  excluded from a run (the latter with '!' prefix).

- 'prove' harness can also run individual tests; one of more useful
  options is --state, which for example would allow to run only failed
  tests with --state=3Dfailed,save ... if the tests were independent.

>
> Adding the complexity of storing a copy of the commit-graph file for
> re-use in a later test is wasted energy right now, because we need to
> run the steps of the test that create the repo shape with the commits
> laid out as set earlier in the test. This shape changes as we test
> different states of the commit-graph (exists and contains all commits,
> exists and doesn't contain all commits, etc.)

I think we can solve most of the problem by separating validation tests
(which all or almost all use the same commit-graph file) and other test;
putting them in different test scripts.  This means that the more
complicated case would be limited to the subset of tests.

Anyway, if the setup stages are clearly separated and clearly marked as
such, we would be able to at least manually skip tests, or manually run
only a subset of tests.

Test independence is certainly something nice to have, but as the git
testsuite is not in best shape wrt this, it is not a requirement.

Best,
--=20
Jakub Nar=C4=99bski
