Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D36B1F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 23:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbcI1XOu (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 19:14:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34842 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbcI1XOr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 19:14:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id b4so8135434wmb.2
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 16:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=sX8CTu41b/FoxDgiKjs1pTt8VA2NrdTWvtMRMrYX8K4=;
        b=OA+EtJ7Isr+/PB5cjvh13FQNMtyMaaxsMG/JZBbp5msobM1KcXUdf+qiM+wSCJcGIb
         SBflNz9u+EkeycO8O81BrftGp0ysrty60bgs3KMZQJkfD0jJcCxoYFSWFrEZoRmdRP/E
         oSKPTLn+QDCQ32VSM2+xG6/8cdwPJ5xuK1NRixp2yFTYMDG1YZa4xlF65dIoBCJjkDDM
         rTnLZcAKqHIdTeEJ4VSAyGhUwVvbi4QOLAuk3OAHG6rkWMbh3cu5DBTS2hLgkTF6fDto
         i/fRCIgjZ8Qv2M3Oo5RTsbYFVOkbbIzQcAXJasKhtIM+1/QA76tZzF9TvlG3Mb3ofxqJ
         FXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=sX8CTu41b/FoxDgiKjs1pTt8VA2NrdTWvtMRMrYX8K4=;
        b=Ehjh2+L55wVLDJwN4KJDJbBbRwL82NB4duVXoSIISOtHPOKOwOPR7xMxAkD3W95fj0
         l6rFpZNuhD9hc+mNUmyrH2FLUmW9EAVUz5eprNehKS0kS/Mz2dTLe0VwRwkEIHX9Weqo
         6CB++Q7Wg6eHHVWRmsaKzpLxh3P4UQ6P7uvOi/tMHVRlPHMCfYkST407ve+TAkGE6P4Z
         2R5EjoIWYPcwjYSynUuGqOqc87eK56IgW8iX/7/MmTGN24cGSiI8uaa3muzbq0C1wOxx
         xqpgahQq1y8s0CbOhkWBjobIDs0j/capKQ/3zZGnndOqqzocmydA8ScaP2s12+8k83fN
         ybDg==
X-Gm-Message-State: AA6/9RkpETVdcwXFY4RAMfO4JEsKvzRQBsKRalWv7SAPrkWi6GZYNwYEHryUMGKBLOP6Lg==
X-Received: by 10.28.39.133 with SMTP id n127mr10921846wmn.6.1475104485695;
        Wed, 28 Sep 2016 16:14:45 -0700 (PDT)
Received: from [192.168.1.26] (ddj41.neoplus.adsl.tpnet.pl. [83.23.87.41])
        by smtp.googlemail.com with ESMTPSA id m75sm24890750wmi.0.2016.09.28.16.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2016 16:14:44 -0700 (PDT)
Subject: Re: [PATCH v8 11/11] convert: add filter.<driver>.process option
To:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-12-larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <e8815048-212e-64c6-8811-9185f595aaf6@gmail.com>
Date:   Thu, 29 Sep 2016 01:14:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160920190247.82189-12-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Part third (and last) of the review of v8 11/11.

W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com napisał:
[...]
> diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-filter/example.pl
> new file mode 100755
> index 0000000..c13a631
> --- /dev/null
> +++ b/contrib/long-running-filter/example.pl
[...]
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index dc50938..210c4f6 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh

One thing that could have been done as yet another preparatory
patch would be to modernize existing t/t0021-conversion.sh tests.
For example use here-doc instead of series of echo-s, use cp
to copy files and not echo, etc.

> @@ -31,7 +31,10 @@ test_expect_success setup '
>  	cat test >test.i &&
>  	git add test test.t test.i &&
>  	rm -f test test.t test.i &&
> -	git checkout -- test test.t test.i
> +	git checkout -- test test.t test.i &&
> +
> +	echo "content-test2" >test2.o &&
> +	echo "content-test3 - subdir" >"test3 - subdir.o"

I see that you prepare here a few uncommitted files, but both
their names and their contents leave much to be desired - you
don't know from the name and contents what they are for.

And the '"subdir"' file which is not in subdirectory is
especially egregious.

>  '
>  
>  script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
> @@ -279,4 +282,364 @@ test_expect_success 'diff does not reuse worktree files that need cleaning' '
>  	test_line_count = 0 count
>  '
>  

A small comment on parameters of this function would be nice.

> +check_filter () {
> +	rm -f rot13-filter.log actual.log &&
> +	"$@" 2> git_stderr.log &&
> +	test_must_be_empty git_stderr.log &&
> +	cat >expected.log &&

This is too clever by half.  Having a function that both tests
the behavior and prepares 'expected' file is too much.

In my opinion preparation of 'expected.log' file should be moved
to another function or functions.

Also, if we are running sort on output, I think we should also
run sort on 'expected.log', so that what we write doesn't need to
be created sorted (so we don't have to sort expected lines by hand).
Or maybe we should run the same transformation on rot13-filter.log
and on the contents of expected.log.

> +	sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" >actual.log &&
> +	test_cmp expected.log actual.log
> +}
> +
> +check_filter_count_clean () {
> +	rm -f rot13-filter.log actual.log &&
> +	"$@" 2> git_stderr.log &&
> +	test_must_be_empty git_stderr.log &&

All those functions (well, wait?) have common setup, which we can
extract into separate shell function, I think.  IMVHO.

> +	cat >expected.log &&
> +	sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" |
> +		sed "s/^\([0-9]\) IN: clean/x IN: clean/" >actual.log &&
> +	test_cmp expected.log actual.log
> +}
> +
> +check_filter_ignore_clean () {
> +	rm -f rot13-filter.log actual.log &&
> +	"$@" &&

Why we don't check for stderr here?

> +	cat >expected.log &&
> +	grep -v "IN: clean" rot13-filter.log >actual.log &&
> +	test_cmp expected.log actual.log
> +}
> +
> +check_filter_no_call () {
> +	rm -f rot13-filter.log &&
> +	"$@" 2> git_stderr.log &&
> +	test_must_be_empty git_stderr.log &&
> +	test_must_be_empty rot13-filter.log
> +}
> +

A small comment on parameters of this function would be nice.
And a comment what it does.

> +check_rot13 () {
> +	test_cmp "$1" "$2" &&
> +	./../rot13.sh <"$1" >expected &&

Why there is .. in this invocation?

> +	git cat-file blob :"$2" >actual &&
> +	test_cmp expected actual
> +}
> +
> +test_expect_success PERL 'required process filter should filter data' '
> +	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
> +	test_config_global filter.protocol.required true &&
> +	rm -rf repo &&
> +	mkdir repo &&
> +	(
> +		cd repo &&
> +		git init &&

Don't you think that creating a fresh test repository for each
separate test is a bit too much?  I guess that you want for
each and every test to be completely independent, but this setup
and teardown is a bit excessive.

Other tests in the same file (should we reuse the test, or use
new test file) do not use this method.

> +
> +		echo "*.r filter=protocol" >.gitattributes &&
> +		git add . &&
> +		git commit . -m "test commit" &&
> +		git branch empty &&

Err... I think it would be better to name it 'empty-branch'
(or 'almost-empty-branch', as it does include .gitattributes file).
See my mistake below (marked <del>...</del>).

> +
> +		cp ../test.o test.r &&
> +		cp ../test2.o test2.r &&

What does this test2.o / test2.r file tests, that test.o / test.r
doesn't?  The name doesn't tell us.

Why it is test.r, but test2.r?  Why it isn't test1.r?

> +		mkdir testsubdir &&
> +		cp "../test3 - subdir.o" "testsubdir/test3 - subdir.r" &&

Why it needs to have different contents?

I guess that you test two things here: file in a subdirectory,
and file with spaces in names.  Shouldn't it be better split
into two separate test files?

> +		>test4-empty.r &&

You test ordinary file, file in subdirectory, file with filename
containing spaces, and an empty file.

Other tests of single file `clean`/`smudge` filters use filename
that requires mangling; maybe we should use similar file?

        special="name  with '\''sq'\'' and \$x" &&
        echo some test text >"$special" &&

In case of `process` filter, a special filename could look like
this:

        process_special="name=with equals and\nembedded newlines\n" &&
        echo some test text >"$process_special" &&

> +
> +		check_filter \
> +			git add . \

I assume that this kind of test is here also to check that
we are not regressing / backsliding, and we do not start to
run "clean" operation more than once per file for "git add",
isn't it?

> +				<<-\EOF &&
> +					1 IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
> +					1 IN: clean test2.r 14 [OK] -- OUT: 14 . [OK]
> +					1 IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
> +					1 IN: clean testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]
> +					1 START
> +					1 STOP
> +					1 wrote filter header
> +				EOF

First, this indentation level confirms that the check_filter
function is too clever by half, and that preparing expected.log
file should be a separate step.

Second, if we run "sort" on contents to be in expected.log, we
can write it in more natural, and less fragile way:

  +		sort >expected.log <<-\EOF &&
  +			1 START
  +			1 wrote filter header
  +			1 IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
  +			1 IN: clean test2.r 14 [OK] -- OUT: 14 . [OK]
  +			1 IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
  +			1 IN: clean testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]
  +			1 STOP
  +		EOF

Third, why the filter even writes output size? It is no longer
part of `process` filter driver protocol, and it makes test more
fragile.

If we are to keep sizes, then to make test less fragile with
respect to changes in contents of tested files, we should use
variables containing file size:

   		test_r_size=$(wc -c test.r)
   		...
   		sort >expected.log <<-EOF &&
   		...
   			1 IN: clean test.r $test_r_size [OK] -- OUT: $test_r_size . [OK]

> +
> +		check_filter_count_clean \
> +			git commit . -m "test commit" \

I guess that you use "git commit ." (not very visible this '.')
in order to force cleaning of all files, isn't it?

Use of *_count_clean function is here, from what I remember,
because 'git commit .' sometimes call `clean` multiple times
for the same file (?), and sometimes it calls `smudge` (probably
as part of some optimization?).

I guess that fixing "git commit" so that calls clean operation
at most once per file is left for a separate patch series; this
one is long enough and involved enough as it is.

> +				<<-\EOF &&
> +					x IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
> +					x IN: clean test2.r 14 [OK] -- OUT: 14 . [OK]
> +					x IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
> +					x IN: clean testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]
> +					1 START
> +					1 STOP
> +					1 wrote filter header
> +				EOF
> +
> +		rm -f test?.r "testsubdir/test3 - subdir.r" &&

Why 'test?.r' when we are removing only 'test2.r'; why not be explicit?

> +
> +		check_filter_ignore_clean \
> +			git checkout . \
> +				<<-\EOF &&
> +					START
> +					wrote filter header
> +					IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
> +					IN: smudge testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]

Ah, I see that there are no shenningans for `clean`
operation, calling op multiple time for single file.

> +					STOP
> +				EOF
> +
> +		check_filter_ignore_clean \
> +			git checkout empty \

<del>
First, isn't it test4-empty.r?  Trying to check out non-existent
file should not run filter, isn't it?  How the heck this passed???
There is no branch 'empty'.

Second, the one-shot filter tests have empty-in-worktree and
empty-in-repo files; why not reuse them?
</del>

My mistake, but the branch is named a bit strange.

> +				<<-\EOF &&
> +					START
> +					wrote filter header
> +					STOP
> +				EOF

Why is even filter process invoked?  If this is not expected, perhaps
simply ignore what checking out almost empty branch (one without any
files marked for filtering) does.

Shouldn't we test_expect_failure no-call?

> +
> +		check_filter_ignore_clean \
> +			git checkout master \

Does this checks different code path than 'git checkout .'? For
example, does this test increase code coverage (e.g. as measured
by gcov)?  If not, then this test could be safely dropped.

> +				<<-\EOF &&
> +					START
> +					wrote filter header
> +					IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]
> +					IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
> +					IN: smudge test4-empty.r 0 [OK] -- OUT: 0  [OK]
> +					IN: smudge testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]

Can we assume that Git would pass files to filter in alphabetical
order?  This assumption might make the test unnecessary fragile.

> +					STOP
> +				EOF
> +
> +		check_rot13 ../test.o test.r &&
> +		check_rot13 ../test2.o test2.r &&
> +		check_rot13 "../test3 - subdir.o" "testsubdir/test3 - subdir.r"

All right.

> +	)
> +'
> +
> +test_expect_success PERL 'required process filter should clean only and take precedence' '

Trying to describe it better results in overly long description,
which probably means that this test should be split into few
smaller ones:

 - `process` filter takes precedence over `clean` and/or `smudge`
   filters, regardless if it supports relevant ("clean" or "smudge")
   capability or not

 - `process` filter that includes only "clean" capability should
   clean only (be used only for 'clean' operation)

 - required process filter should do something (???)
   

> +	test_config_global filter.protocol.clean ./../rot13.sh &&
> +	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean" &&
> +	test_config_global filter.protocol.required true &&
> +	rm -rf repo &&
> +	mkdir repo &&
> +	(
> +		cd repo &&
> +		git init &&
> +
> +		echo "*.r filter=protocol" >.gitattributes &&
> +		git add . &&
> +		git commit . -m "test commit" &&
> +		git branch empty &&
> +
> +		cp ../test.o test.r &&
> +
> +		check_filter \
> +			git add . \
> +				<<-\EOF &&
> +					1 IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
> +					1 START
> +					1 STOP
> +					1 wrote filter header
> +				EOF
> +
> +		check_filter_count_clean \
> +			git commit . -m "test commit" \

Is this part really necessary?  I think it duplicates what we
have tested earlier, and would not catch any new errors.  Removing
spurious/redundant tests results in faster testsuite, which is
quite important.

> +				<<-\EOF
> +					x IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
> +					1 START
> +					1 STOP
> +					1 wrote filter header
> +				EOF

And this test checks only the first one from the list.
Well, actually the first part, without "regardless if it
supports relevant ('clean' [...]) capability or not".

> +	)
> +'
> +

In my opinion all functions should be placed at beginning,
or even in separate file (if they are used in more than
one test).

> +generate_test_data () {

The name is not good, it doesn't describe what kind of data
we want to generate.

> +	LEN=$1
> +	NAME=$2
> +	test-genrandom end $LEN |

Why do you use 'end' as <seed_string> parameter to test-genrandom?

> +		perl -pe "s/./chr((ord($&) % 26) + 97)/sge" >../$NAME.file &&

Those constants (26 and 97) are a bit cryptic; magical constants.
I guess this is

  +		perl -pe "s/./chr((ord($&) % (ord('z') - ord('a') + 1) + ord('a'))/sge" >../$NAME.file &&

or

  +		perl -pe "s/./chr((ord($&) % 26 + ord('a'))/sge" >../$NAME.file &&

That is, convert to a-z range (why not ASCII printable characters,
that is characters from ' ' / chr(32) to '~' / chr(126), which is
95 characters instead of 26?)

I guess this is so we can be sure that rot13 filter would work
(note: the filter is defined for A-Za-z, not only a-z, never
the mind pass-through for other characters).

> +	cp ../$NAME.file . &&

Do we re-generate this file each time?

> +	./../rot13.sh <../$NAME.file >../$NAME.file.rot13

Anyway, I wonder if taking the last two lines out of the function
(as they are not about _generating_ a file) would make it more
readable or not.

> +}
> +
> +test_expect_success PERL 'required process filter should process multiple packets' '
> +	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
> +	test_config_global filter.protocol.required true &&
> +
> +	rm -rf repo &&
> +	mkdir repo &&
> +	(
> +		cd repo &&
> +		git init &&
> +
> +		# Generate data that requires 3 packets
> +		PKTLINE_DATA_MAXLEN=65516 &&

Shouldn't this be set once per whole test?

> +
> +		generate_test_data $(($PKTLINE_DATA_MAXLEN        )) 1pkt_1__ &&
> +		generate_test_data $(($PKTLINE_DATA_MAXLEN     + 1)) 2pkt_1+1 &&
> +		generate_test_data $(($PKTLINE_DATA_MAXLEN * 2 - 1)) 2pkt_2-1 &&
> +		generate_test_data $(($PKTLINE_DATA_MAXLEN * 2    )) 2pkt_2__ &&
> +		generate_test_data $(($PKTLINE_DATA_MAXLEN * 2 + 1)) 3pkt_2+1 &&

Looks good to me.

> +
> +		echo "*.file filter=protocol" >.gitattributes &&
> +		check_filter \
> +			git add *.file .gitattributes \

Should it be shell expansion, or git expansion, that is

   			git add '*.file' .gitattributes


> +				<<-\EOF &&
> +					1 IN: clean 1pkt_1__.file 65516 [OK] -- OUT: 65516 . [OK]
> +					1 IN: clean 2pkt_1+1.file 65517 [OK] -- OUT: 65517 .. [OK]
> +					1 IN: clean 2pkt_2-1.file 131031 [OK] -- OUT: 131031 .. [OK]
> +					1 IN: clean 2pkt_2__.file 131032 [OK] -- OUT: 131032 .. [OK]
> +					1 IN: clean 3pkt_2+1.file 131033 [OK] -- OUT: 131033 ... [OK]

I think it would be better for those sizes to be calculated,
not entered by hand.  Though in this case this doesn't matter
much - it would always be this size.

> +					1 START
> +					1 STOP
> +					1 wrote filter header
> +				EOF
> +		git commit . -m "test commit" &&

Is this needed / necessary?

> +
> +		rm -f *.file &&
> +		git checkout -- *.file &&

Is this necessary?  I guess this checks that it doesn't crash, but
we do not check that smudge operation works correctly, as we did
for clean.

> +
> +		for f in *.file
> +		do
> +			git cat-file blob :$f >actual &&
> +			test_cmp ../$f.rot13 actual
> +		done

Wasn't there helper function for this?

> +	)
> +'
> +
> +test_expect_success PERL 'required process filter should with clean error should fail' '
                                                     ^^^^^^                  ^^^^^^

Errr... what?  You have 'should' twice here.

Also, does it matter that the error is during clean operation?
We don't test that error during smudge operation is handled in
the same way, do we?

> +	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&

Do we need to pass 'clean smudge', or does it provide both by
default?

> +	test_config_global filter.protocol.required true &&
> +	rm -rf repo &&
> +	mkdir repo &&
> +	(
> +		cd repo &&
> +		git init &&
> +
> +		echo "*.r filter=protocol" >.gitattributes &&
> +
> +		cp ../test.o test.r &&
> +		echo "this is going to fail" >clean-write-fail.r &&
> +		echo "content-test3-subdir" >test3.r &&
> +
> +		# Note: There are three clean paths in convert.c we just test one here.

What does this comment is about?  What 'three clean paths'?

> +		test_must_fail git add .
> +	)
> +'
> +
> +test_expect_success PERL 'process filter should restart after unexpected write failure' '
> +	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
> +	rm -rf repo &&
> +	mkdir repo &&
> +	(
> +		cd repo &&
> +		git init &&
> +
> +		echo "*.r filter=protocol" >.gitattributes &&
> +
> +		cp ../test.o test.r &&
> +		cp ../test2.o test2.r &&

Note that the preparation step is almost the same, and we
repeat it over, and over, and over (no shell function for
this; and we always do full setup / teardown).

> +		echo "this is going to fail" >smudge-write-fail.o &&
> +		cat smudge-write-fail.o >smudge-write-fail.r &&

This cat is cp.

> +		git add . &&
> +		git commit . -m "test commit" &&

You don't need to commit for 'git checkout <path>' (e.g. for .)
or 'git cat-file -p :<file>' to work.

> +		rm -f *.r &&
> +
> +		check_filter_ignore_clean \
> +			git checkout . \
> +				<<-\EOF &&
> +					START
> +					wrote filter header
> +					IN: smudge smudge-write-fail.r 22 [OK] -- OUT: 22 [WRITE FAIL]
> +					START
> +					wrote filter header
> +					IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]
> +					IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
> +					STOP
> +				EOF
> +
> +		check_rot13 ../test.o test.r &&
> +		check_rot13 ../test2.o test2.r &&

Looks good.

> +
> +		! test_cmp smudge-write-fail.o smudge-write-fail.r && # Smudge failed!
> +		./../rot13.sh <smudge-write-fail.o >expected &&
> +		git cat-file blob :smudge-write-fail.r >actual &&
> +		test_cmp expected actual							  # Clean worked!

This is almost negation of check_rot13 - perhaps a helper function
would help here (check_not_rot13?).

Also, what this comment is about, and why so far to the right?

> +	)
> +'
> +
> +test_expect_success PERL 'process filter should not restart in case of an error' '

Errr... what? This description is not clear.  Did you mean
that filter should not be restarted if it *signals* an error
with file (either before sending anything, or after sending
partial contents)?

> +	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
> +	rm -rf repo &&
> +	mkdir repo &&
> +	(
> +		cd repo &&
> +		git init &&
> +
> +		echo "*.r filter=protocol" >.gitattributes &&
> +
> +		cp ../test.o test.r &&
> +		cp ../test2.o test2.r &&
> +		echo "this will cause an error" >error.o &&
> +		cp error.o error.r &&

And here you (correctly) use cp, and not cat.

> +		git add . &&
> +		git commit . -m "test commit" &&
> +		rm -f *.r &&
> +
> +		check_filter_ignore_clean \
> +			git checkout . \
> +				<<-\EOF &&
> +					START
> +					wrote filter header
> +					IN: smudge error.r 25 [OK] -- OUT: 0 [ERROR]
> +					IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]
> +					IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
> +					STOP
> +				EOF
> +
> +		check_rot13 ../test.o test.r &&
> +		check_rot13 ../test2.o test2.r &&
> +		test_cmp error.o error.r

Looks good to me.

> +	)
> +'
> +
> +test_expect_success PERL 'process filter should be able to signal an error for all future files' '

Did you mean here that filter can abort processing of
all future files?

> +	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
> +	rm -rf repo &&
> +	mkdir repo &&
> +	(
> +		cd repo &&
> +		git init &&
> +
> +		echo "*.r filter=protocol" >.gitattributes &&
> +
> +		cp ../test.o test.r &&
> +		cp ../test2.o test2.r &&
> +		echo "error this blob and all future blobs" >abort.o &&
> +		cp abort.o abort.r &&
> +		git add . &&
> +		git commit . -m "test commit" &&
> +		rm -f *.r &&
> +
> +		check_filter_ignore_clean \
> +			git checkout . \
> +				<<-\EOF &&
> +					START
> +					wrote filter header
> +					IN: smudge abort.r 37 [OK] -- OUT: 0 [ABORT]
> +					STOP

How can we know that 'abort' file is processed first?
Though more resilent solution would be harder to create...

> +				EOF
> +
> +		test_cmp ../test.o test.r &&
> +		test_cmp ../test2.o test2.r &&
> +		test_cmp abort.o abort.r
> +	)
> +'
> +
> +test_expect_success PERL 'invalid process filter must fail (and not hang!)' '
> +	test_config_global filter.protocol.process cat &&

We could use rot13.sh, that is one-shot filter here.

> +	test_config_global filter.protocol.required true &&

All right, filter is required to easier distinguish it not
working from not filtered.

> +	rm -rf repo &&
> +	mkdir repo &&
> +	(
> +		cd repo &&
> +		git init &&
> +
> +		echo "*.r filter=protocol" >.gitattributes &&
> +
> +		cp ../test.o test.r &&
> +		test_must_fail git add . 2> git_stderr.log &&
> +		grep "not support long running filter protocol" git_stderr.log

Shouldn't this use gettext poison (or rather C locale)?
This error message could be translated in the future.

> +	)
> +'
> +
>  test_done

I wonder how does the code coverage for the new v2 filter
code looks like...

Anyway, I think it would be good idea to write at the beginning
of new tests (be they in old test, or in new test) what we want
to test:

 - that 'clean' and 'smudge' operations are invoked, for all
   possible combinations (covering all code paths), and that
   filter is invoked only once
 - that special types of files work:
   * empty file (in worktree, in index, in repo)
   * file in subdirectory
   * filename with special characters
   * large file (test marked as EXPENSIVE), multiple maximum
     packet size
   * perhaps binary file?
 - that 'process' overrides old-style 'clean' and 'smudge'
   filters, regardless of the former capabilities
 - that limiting capabilities works
 - that requiring filter works correctly (doubles number of
   tests, at least for a subset of them)
 - that filter is restarted if it fails on non-required,
   fails git command if required
 - that filter can error out out of filtering a file,
   upfront and after partial contents, without restart;
   fails git command if required
 - that filter can abort,
   fails git command if required (?)

> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
> new file mode 100755
> index 0000000..8958f71
> --- /dev/null
> +++ b/t/t0021/rot13-filter.pl
> @@ -0,0 +1,191 @@
> +#!/usr/bin/perl
> +#
> +# Example implementation for the Git filter protocol version 2
> +# See Documentation/gitattributes.txt, section "Filter Protocol"
> +#
> +# The script takes the list of supported protocol capabilities as
> +# arguments ("clean", "smudge", etc).
> +#
> +# This implementation supports special test cases:
> +# (1) If data with the pathname "clean-write-fail.r" is processed with
> +#     a "clean" operation then the write operation will die.
> +# (2) If data with the pathname "smudge-write-fail.r" is processed with
> +#     a "smudge" operation then the write operation will die.
> +# (3) If data with the pathname "error.r" is processed with any
> +#     operation then the filter signals that it cannot or does not want
> +#     to process the file.
> +# (4) If data with the pathname "abort.r" is processed with any
> +#     operation then the filter signals that it cannot or does not want
> +#     to process the file and any file after that is processed with the
> +#     same command.

Nice to have this description.

BTW. why write-fail is per operation (clean or smudge), but error and abort
is not?


> +#
> +
> +use strict;
> +use warnings;

I guess there is some duplication with the code in contrib, isn't it?

> +
> +my $MAX_PACKET_CONTENT_SIZE = 65516;
> +my @capabilities            = @ARGV;
> +
> +open my $debug, ">>", "rot13-filter.log";

   	or die "cannot open file for appending: $!";

Good, three argument open.  Bad (?), not error handling.

> +
> +sub rot13 {
> +    my ($str) = @_;
   ^^^^

Why 4 spaces, and not TAB character?


I think

   	my $str = shift;

is more idiomatic Perl.

> +    $str =~ y/A-Za-z/N-ZA-Mn-za-m/;

Why not use tr/// version of this quote-like operation?
Or do you follow prior art here?

> +    return $str;
> +}
> +
> +sub packet_bin_read {
> +    my $buffer;
> +    my $bytes_read = read STDIN, $buffer, 4;
> +    if ( $bytes_read == 0 ) {
> +
> +        # EOF - Git stopped talking to us!
> +        print $debug "STOP\n";
> +        exit();
> +    }
> +    elsif ( $bytes_read != 4 ) {
> +        die "invalid packet size '$bytes_read' field";

Errr, $bytes_read is not packet size field.  It is $buffer.
Also, error message looks strange

   		invalid packet size '004' field

Shouldn't it be at end?

> +    }
> +    my $pkt_size = hex($buffer);

$pkt_size greater than $MAX_PACKET_CONTENT_SIZE is also an error,
as is sizes 1-3 (not that it matters much, at least here).

> +    if ( $pkt_size == 0 ) {
> +        return ( 1, "" );

It feels a bit strange to me to return list instead of hashref,
but this is a matter of opinion.

> +    }
> +    elsif ( $pkt_size > 4 ) {
> +        my $content_size = $pkt_size - 4;
> +        $bytes_read = read STDIN, $buffer, $content_size;
> +        if ( $bytes_read != $content_size ) {
> +            die "invalid packet ($content_size expected; $bytes_read read)";

It would read, strangely

   		   "invalid packet (8 expected, 7 read)"

The "size" or "bytes" is missing from this output.

> +        }
> +        return ( 0, $buffer );
> +    }
> +    else {
> +        die "invalid packet size";

Is keep-alive packet valid ("0004")?

> +    }
> +}
> +
> +sub packet_txt_read {
> +    my ( $res, $buf ) = packet_bin_read();
> +    unless ( $buf =~ /\n$/ ) {
> +        die "A non-binary line SHOULD BE terminated by an LF.";

First, if SHOULD BE, then perhaps 'warn' not 'die'... though for
tests it is probably better to 'die'.

Second, we should probably print (a fragment of) this line.

> +    }
> +    return ( $res, substr( $buf, 0, -1 ) );

Same comment as for example file in contrib/ - use s/// and no
need for substr stuff.

> +}
> +
> +sub packet_bin_write {
> +    my ($packet) = @_;
> +    print STDOUT sprintf( "%04x", length($packet) + 4 );
> +    print STDOUT $packet;
> +    STDOUT->flush();
> +}
> +
> +sub packet_txt_write {
> +    packet_bin_write( $_[0] . "\n" );
> +}
> +
> +sub packet_flush {
> +    print STDOUT sprintf( "%04x", 0 );
> +    STDOUT->flush();
> +}

Looks good to me (though same comments as to contrib/ file applies).

> +
> +print $debug "START\n";
> +$debug->flush();
> +
> +( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
> +( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
> +( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";
> +
> +packet_txt_write("git-filter-server");
> +packet_txt_write("version=2");
> +
> +( packet_txt_read() eq ( 0, "clean=true" ) )  || die "bad capability";
> +( packet_txt_read() eq ( 0, "smudge=true" ) ) || die "bad capability";
> +( packet_bin_read() eq ( 1, "" ) )            || die "bad capability end";
> +
> +foreach (@capabilities) {
> +    packet_txt_write( $_ . "=true" );
> +}
> +packet_flush();
> +print $debug "wrote filter header\n";

Or perhaps "handshake end"?

> +$debug->flush();
> +
> +while (1) {
> +    my ($command) = packet_txt_read() =~ /^command=([^=]+)$/;
> +    print $debug "IN: $command";
> +    $debug->flush();
> +
> +    my ($pathname) = packet_txt_read() =~ /^pathname=([^=]+)$/;

All right, here list context is necessary.

> +    print $debug " $pathname";

No " pathname=$pathname" ?

> +    $debug->flush();
> +
> +    # Flush
> +    packet_bin_read();

Same comment as earlier: read_flush, or read_varlist (till flush)
to have would be better.

> +
> +    my $input = "";
> +    {
> +        binmode(STDIN);
> +        my $buffer;
> +        my $done = 0;
> +        while ( !$done ) {
> +            ( $done, $buffer ) = packet_bin_read();
> +            $input .= $buffer;
> +        }
> +        print $debug " " . length($input) . " [OK] -- ";
> +        $debug->flush();
> +    }
> +
> +    my $output;
> +    if ( $pathname eq "error.r" or $pathname eq "abort.r" ) {
> +        $output = "";
> +    }
> +    elsif ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
> +        $output = rot13($input);
> +    }
> +    elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
> +        $output = rot13($input);
> +    }
> +    else {
> +        die "bad command '$command'";
> +    }
> +
> +    print $debug "OUT: " . length($output) . " ";

Shouldn't we write the length of output only if we don't error out,
abort, or fail?

> +    $debug->flush();
> +
> +    if ( $pathname eq "error.r" ) {
> +        print $debug "[ERROR]\n";
> +        $debug->flush();
> +        packet_txt_write("status=error");
> +        packet_flush();
> +    }
> +    elsif ( $pathname eq "abort.r" ) {
> +        print $debug "[ABORT]\n";
> +        $debug->flush();
> +        packet_txt_write("status=abort");
> +        packet_flush();
> +    }

Looks good, so this is upfront status=error or status-abort.

> +    else {
> +        packet_txt_write("status=success");
> +        packet_flush();
> +
> +        if ( $pathname eq "${command}-write-fail.r" ) {
> +            print $debug "[WRITE FAIL]\n";
> +            $debug->flush();
> +            die "${command} write error";
> +        }
> +
> +        while ( length($output) > 0 ) {
> +            my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
> +            packet_bin_write($packet);
> +            print $debug ".";

All right, so number of dots is the number of packets.  This is
surprisingly opaque.

> +            if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
> +                $output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
> +            }
> +            else {
> +                $output = "";
> +            }
> +        }
> +        packet_flush();
> +        print $debug " [OK]\n";
> +        $debug->flush();
> +        packet_flush();

Should we test partial contents case?  Or failure during printing?
What happens then - is file cleared by Git, or left partially converted?

> +    }
> +}
> 

Keep up good work.  Looks quite good.
-- 
Jakub Narębski

