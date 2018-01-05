Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1F981F428
	for <e@80x24.org>; Fri,  5 Jan 2018 19:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeAETIn (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 14:08:43 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:45568 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeAETIm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 14:08:42 -0500
Received: by mail-wm0-f48.google.com with SMTP id 9so4178687wme.4
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 11:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GJd/zqDpyUn4pCXmiHVFK1rcs9RcemXttmKKiN2Lr9g=;
        b=LxYR8xCI1fwPuqwD+IGj2C1IB2abxupSc6Jboa9HfTYGZ70bhJw01wKLvaDysbm068
         LsfSSlA+BlPe5Rc5pO1UACEHRRD7nwlAk1kiD/iPAJ4NPULPlirWbT4cHGyewarNVCCL
         bbSbX7GkRnLDELyNUWezZZOaEbn/jUt/c20hI24Ud/mFolOI8FmIlTKil14MMmIolAz9
         DTi1dnAxP9Bh9QQnkBdg1exNbIaVRlF5wBtbbvzXJykQ8UROPNFQKfCa+JeJfBT1HQxt
         F8l62fI8akabcaPoyT5T3w4xuiudeFgGpVdyxoXH2P5pOOqA1eaet/MI812ahiPXiWO6
         x0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=GJd/zqDpyUn4pCXmiHVFK1rcs9RcemXttmKKiN2Lr9g=;
        b=D2j+W9SVvoyj5PMMrtBf+2LYApf+mGYltn8KY1atznBB1logEJwL4hCPMTP7LQ8fpo
         YJpIsBzAKHiY0cT/6utN+3NCZa5ey5pGzQA3XGoUreocljLQ1Qi5Gi5kOs5Z+aHTDV1u
         VmLKRzzYGoYnQ4hvjzA+MX6O3HEcMT9UuOzGh0nW3vJwOJKbavQ+/bUf8cbxYao1YtH3
         D4e6Cg9R26ZqElO6kro2UGHYaWkhY3MPtmLGPDf5yzq9AZlfI1sgbrz6QraMQQhTlWQr
         OJl3m647rl06VrV3JRRkQBLMOg2xmBFPh+dyBVnm9KLjQYOJhW7g/dfxMAyjoKt9biUD
         /DXw==
X-Gm-Message-State: AKGB3mJLcneB1IcdZdi0L5LXqA3fca/X9or3ls+lyWY+TdsjmILcuyag
        0S/J8NtbjFYzHv/FJGvlDXRMCbkK
X-Google-Smtp-Source: ACJfBos4NIs0H45zPzFtyD2RYCKSyDrFMbE+CFK5gTUdD3oSM3/Aa8YP8XgFiqOqur8MAX2YpRDqFg==
X-Received: by 10.80.163.231 with SMTP id t36mr5772920edb.110.1515179321123;
        Fri, 05 Jan 2018 11:08:41 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id g61sm4216658edd.48.2018.01.05.11.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 11:08:39 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v4 7/7] wildmatch test: create & test files on disk in addition to in-memory
References: <20180104192657.28019-1-avarab@gmail.com> <20180104192657.28019-8-avarab@gmail.com> <nycvar.QRO.7.76.6.1801051622010.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <nycvar.QRO.7.76.6.1801051622010.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
Date:   Fri, 05 Jan 2018 20:08:38 +0100
Message-ID: <87r2r4azt5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 05 2018, Johannes Schindelin jotted:

> I spent the last 3.5 hours chasing down a bug in your patch series that
> seems to be Windows specific, so please forgive me if the following might
> leak a bit of my frustration into the open...

Thanks for looking into this.

> On Thu, 4 Jan 2018, Ævar Arnfjörð Bjarmason wrote:
>
>>  t/t3070-wildmatch.sh | 301 +++++++++++++++++++++++++++++++++++++++++++++++++--
>
> Wow, this file is ugly. Sorry, that was an outburst, you did not deserve
> that, but I have to say that it is *really* hard to wrap your head around
> lines like this:
>
> 	wildtest 1 1 1 1 'foo*' 'foo\*'
>
> What are those 1s supposed to mean? Granted, for you, the author of this
> line, it is easy.

Just for some context, this line has looked very similar to this since
feabcc173b ("Integrate wildmatch to git", 2012-10-15):

    match 1 1 'foo' 'foo'

It could be made less verbose at the expense of some complexity in
wildmatch(), i.e.:

    match 1 'foo' 'foo'

Which would implicitly mean:

    match 1 1 1 1 'foo' 'foo'

But I thought it was more readable to maintain vertical alignment of the
patterns, but I'm open to ideas on how to make this less shitty.

> The point, though, of regression tests is not only to catch regressions
> but also to make it easy to fix them. Not only for the test script's
> author, but for others, too (and your script is not even the best example
> we have for a script that needs hours to study before one can even hope to
> begin to see what is going wrong... I am looking at you, t0027, yes, you.
> You know why).
>
> So then I go and see that the `wildtest` function has magic to handle both
> 6 and 10 parameters. And those parameters get assigned to variable names
> as intuitive as `match_f_w_pathmatchi`...
>
> The next thing about the test script is this: calling it with -x is pretty
> much useless, because *so much* is happening outside of
> test_expect_success clauses (and is therefore *not* traced).

Good point. I guess create_test_file() could create a file only if we
can create the test file, and then we run the actual test as a condition
of that. I.e. to move its logic into a test_expect_success() which would
always succeed.

> Of course I can debug this, but can't this be easier? And this is not even
> a regression after a couple of years, this is fresh from the start...
>
> So here is the first bummer about your rather extensive test (which I
> think tests the same behavior over and over and over again, just with
> slight variations which however do not matter all that much... for
> example, it should be enough to verify *without* filenames that the
> globbing of wildmatch() works, and then a single test *with* a filename
> should suffice to verify that the connection between globbing and files
> works): it requires filenames that are illegal on Windows. Stars, question
> marks: forbidden.

That's really not the case. The path match code is not simply taking a
full path and a pattern and calling wildmatch(), if it was I'd agree
that roundtrip testing like this on every single pattern would be
completely pointless.

As noted in v1
(https://public-inbox.org/git/20171223213012.1962-1-avarab@gmail.com/)
this series came out of my attempts to replace the underlying wildmatch
engine, which after trying for a bit I found I was blocked by rather bad
wildmatch test coverage.

I'd make code changes and some random other test would fail, but not
t3070-wildmatch.sh, which later turned out to be a blindspot that this
series rectifies.

A pattern like "t/**.sh" isn't just matched against a path like
"t/test-lib.sh" internally, instead we peel off "t/" since we know it's
a dir, and then try to match "**.sh" against "test-lib.sh".

As 7/7 shows there's several cases where the behavior is different, and
without roundtrip testing like this there's no telling what other case
might inadvertently be added in the future.

However, read on...

> Worse, since we have to use Unix shell scripts to perform our
> "platform-independent" tests, we have to rely on a Unix shell interpreter,
> and Git for Windows uses MSYS2's Bash, which means that we inherit most of
> Cygwin's behavior.
>
> Now, Cygwin wants to be cute and allow those illegal filenames because (as
> is demonstrated here quite nicely) Unix programmers don't give one bit of
> a flying fish about portable filesystem requirements.
>
> So Cygwin maps those illegal characters into a private Unicode page. Which
> means that Cygwin can read them alright, but no non-Cygwin program
> recognizes the stars and question marks and tabs and newlines. Including
> Git.
>
> In short: the Unix shell script t3070 manages to write what it thinks is a
> file called 'foo*', but Git only sees 'foo<some-undisplayable-character>'.
>
> I tried to address this problem with this patch:

...I don't see any particular value in trying to do these full roundtrip
tests on platforms like Windows. Perhaps we should just do these on a
whitelist of POSIX systems for now, and leave expanding that list to
some future step.

> -- snip --
> diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
> index f606f91acbb..51dcb675e7b 100755
> --- a/t/t3070-wildmatch.sh
> +++ b/t/t3070-wildmatch.sh
> @@ -4,6 +4,14 @@ test_description='wildmatch tests'
>
>  . ./test-lib.sh
>
> +if test_have_prereq !MINGW && touch -- 'a*b' 2>/dev/null
> +then
> +	test_set_prereq FILENAMESWITHSTARS
> +else
> +	say 'Your filesystem does not allow stars in filenames.'
> +fi
> +rm -f 'a*b'
> +
>  create_test_file() {
>  	file=$1
>
> @@ -28,6 +36,17 @@ create_test_file() {
>  	*/)
>  		return 1
>  		;;
> +	# On Windows, stars are not allowed in filenames. Git for Windows'
> +	# Bash, however, is based on Cygwin which plays funny names with a
> +	# private Unicode page to emulate stars in filenames. Meaning that
> +	# the shell script will "succeed" to write the file, but Git will
> +	# not see it. Nor any other, regular Windows process.
> +	*\**|*\[*)
> +		if ! test_have_prereq FILENAMESWITHSTARS
> +		then
> +			return 1
> +		fi
> +		;;
>  	# On Windows, \ in paths is silently converted to /, which
>  	# would result in the "touch" below working, but the test
>  	# itself failing. See 6fd1106aa4 ("t3700: Skip a test with
> -- snap --
>
> This gets us further. But not by much:

Okey, that's very weird. So you can:

    touch "./*"; echo $?

And it'll return 0 but then the file won't exist?

How about this:

    touch "./*" && test -e "./*"; echo $?

I.e. could we more generally just test whether the file got created
successfully? Does that work on Windows?

The reason this latest version stopped creating files with "\" in them
unless under BSLASHPSPEC is because Cygwin would silently translate it,
so it would create the file but it would actually mean something the
tests didn't expect.

For anything else, such as stars not being allowed in filenames I was
expecting that "touch" command to return an error, but if that's not the
case maybe we need the "test -e" as well, unless I'm missing something
here.


> fatal: Invalid path '\[ab]': No such file or directory
>
> You see, any path starting with a backslash *is* an absolute path on
> Windows. It is relative to the current drive.

Right, which I was trying to avoid by not actually creating \[ab], but
"./\[ab]", is that the same filename on Windows?

> This affects *quite* a few of the test cases you added.
>
> And even if I just comment all of those out, I run into the next problem
> where you try to create a file whose name consists of a single space,
> which is also illegal on Windows.

Okey, but ditto above about touch not catching it, does:

    touch "./ "; echo $?

Not return an error? Then how about:

    touch "./ " && test -e "./ "; echo $?

> These woes demonstrate one problem with the approach of overzealously
> testing *everything*[...]

I think the rest of this gets into topics I've covered above. I.e. that
this increased test coverage has caught bugs.
