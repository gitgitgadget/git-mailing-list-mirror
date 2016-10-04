Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B0E20986
	for <e@80x24.org>; Tue,  4 Oct 2016 21:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754214AbcJDVeS (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:34:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32851 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753107AbcJDVeR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:34:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id p138so21610999wmb.0
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=MBNempraBDgWUaE2X40CkEZ0G3EAYoVzdAB6wevSpJc=;
        b=W9CCHh828YZgRte+TxJxyUSyEgzzRTLi8n4QFppuXhYn9l0HrXk0EtkbKM0MAioxlA
         8preJ/VtSd/EgmYjeB67r91vi71vKNKy4XwuRlZoH5c3gtbEIb1aZIqOMfDpIpEub++u
         vLsiPQjbu7w4ox6dv5w/LZp1z4HDREshOeMfKPGCmXDow3MsnwPKwmR+uF8QM0pJ5At9
         2KxCDEphggTuOEgb4jf3NJ0sX27NkgtbpTiLIJwbxcXAIJ+Mp6CjFFBHao7BabCvq96l
         cJENgTOrbdPjNMuAL0dgfAlT9MVEzKEvk/psZ6IA/rhUg4tioDu3nelfSo7ZN0TZvsKw
         rs/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=MBNempraBDgWUaE2X40CkEZ0G3EAYoVzdAB6wevSpJc=;
        b=CgBeDP24dEZBDJ2poGedHFO7S/eIw02JF/BlWArUFAatHP3Aj11ewaNm8syjHcGqtU
         8nu/WgSurFnbevbw0Ec4JTQ1aF/rWBv5JAApxs6ZTUSoQWpdMRgdwIHmdBUzGLdw8zi9
         t8sCsemKIxoIJ/+7OsrhZn32P9jy9TP57djRO5Px0UbxT/0bMrKKyKUTbe+RzRKdJrcK
         zDehuwLVa3Vk+oBWPL7EsJBLiROFdOq3dz+SS81JlJwuFqeBBZCpWMmo+29VYq93mwIR
         /75xv6UuKSTmCHC/mKAHsQB59WGNjrCoEPzH+nKGBAB3sskxnMmtWA2MteoU7RUER48/
         KAEA==
X-Gm-Message-State: AA6/9RliQ/Fv5MNq49qc9dOWjNaydm8WPU/M1iYmzPiTMaKR/B22LVDXc/RqSuZmVME1eg==
X-Received: by 10.194.68.106 with SMTP id v10mr4827958wjt.149.1475616855197;
        Tue, 04 Oct 2016 14:34:15 -0700 (PDT)
Received: from [192.168.1.26] (dbs112.neoplus.adsl.tpnet.pl. [83.23.44.112])
        by smtp.googlemail.com with ESMTPSA id h3sm5436384wjp.45.2016.10.04.14.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2016 14:34:13 -0700 (PDT)
Subject: Re: [PATCH v8 11/11] convert: add filter.<driver>.process option
To:     Lars Schneider <larsxschneider@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-12-larsxschneider@gmail.com>
 <e8815048-212e-64c6-8811-9185f595aaf6@gmail.com>
 <7C680AE2-7F5A-47E4-8E79-6C3F4AEBD39B@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5ffb5c17-01b5-a429-85e7-a15be713216b@gmail.com>
Date:   Tue, 4 Oct 2016 23:34:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <7C680AE2-7F5A-47E4-8E79-6C3F4AEBD39B@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Some of answers and comments may got invalidated by v9]

W dniu 01.10.2016 o 17:34, Lars Schneider pisze:
>> On 29 Sep 2016, at 01:14, Jakub Narębski <jnareb@gmail.com> wrote:
>>
>> Part third (and last) of the review of v8 11/11.

[...]
>>> +
>>> +test_expect_success PERL 'required process filter should filter data' '
>>> +	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
>>> +	test_config_global filter.protocol.required true &&
>>> +	rm -rf repo &&
>>> +	mkdir repo &&
>>> +	(
>>> +		cd repo &&
>>> +		git init &&
>>
>> Don't you think that creating a fresh test repository for each
>> separate test is a bit too much?  I guess that you want for
>> each and every test to be completely independent, but this setup
>> and teardown is a bit excessive.
>>
>> Other tests in the same file (should we reuse the test, or use
>> new test file) do not use this method.
> 
> I see your point. However, I am always annoyed if Git tests are
> entangled because it makes working with them way way harder.
> This test test runs in 4.5s on a slow Travis CI machine. I think
> that is OK considering that we have tests running 3.5min (t3404).

All right, this is good argument... though inconsistency (assuming
that we don't switch to separate test for multi-file filter) could
be argument against.

Though I wonder if test preparation could be extracted into a
common function...

[...]
>>> +		cp ../test.o test.r &&
>>> +		cp ../test2.o test2.r &&
>>
>> What does this test2.o / test2.r file tests, that test.o / test.r
>> doesn't?  The name doesn't tell us.
> 
> This just tests multiple files with different content.

All right, so it is here to test multiple files (and that filter
actually process multiple files).

>> Why it is test.r, but test2.r?  Why it isn't test1.r?
> 
> test.r already existed (created in setup test).

With each test in separate repository we could copy test.r prepared
in 'setup' into test1.r in each of multi-file tests.

[...]
>>> +		>test4-empty.r &&
>>
>> You test ordinary file, file in subdirectory, file with filename
>> containing spaces, and an empty file.
>>
>> Other tests of single file `clean`/`smudge` filters use filename
>> that requires mangling; maybe we should use similar file?
>>
>>        special="name  with '\''sq'\'' and \$x" &&
>>        echo some test text >"$special" &&
> 
> OK.

This test was required because of %f to pass filename as parameter
coupled with the fact that we use `clean` and `smudge` as shell
script fragment (so e.g. pipes and redirection would work in
one-shot filter definition).

This is not the case with multi-file filter, where filenames are
passed internally, and we don't need to worry about shell quoting
at all.
 
>> In case of `process` filter, a special filename could look like
>> this:
>>
>>        process_special="name=with equals and\nembedded newlines\n" &&
>>        echo some test text >"$process_special" &&
> 
> I think this test would create trouble on Windows. I'll stick to
> the special characters used in the single shot filter.

This would test... example parser.  Well, all right, better not
give problems for Windows.

But... you can create such files in Git Bash:

  $ touch "$(echo -n -e "fo=o\nbar\n")"

and though they look strange

  $ ls -1 fo*
  'fo=o'$'\n''bar'

but work all right

  $ echo "strangest" >>"$(echo -n -e "fo=o\nbar\n")"
  $ name="$(echo -n -e "fo=o\nbar\n")"
  $ cat "$name"
  strangest

>> Third, why the filter even writes output size? It is no longer
>> part of `process` filter driver protocol, and it makes test more
>> fragile.
> 
> I would prefer to leave that in. I think it is good for the test to
> check that we are transmitting the amount of content that what we 
> think we transmit.

Right, we test that we processed full file this way, in the multi
packet test. 

>>> +				<<-\EOF &&
>>> +					START
>>> +					wrote filter header
>>> +					STOP
>>> +				EOF
>>
>> Why is even filter process invoked?  If this is not expected, perhaps
>> simply ignore what checking out almost empty branch (one without any
>> files marked for filtering) does.
>>
>> Shouldn't we test_expect_failure no-call?
> 
> Because a clean operation could happen. I added a clean operation to
> the expected log in order to make this visible (expected log is stripped
> of clean operations in the same way as the actual log per your suggestion
> above).

If we are testing that if there is no "smudge" capability, then
there were no "smudge" operations, why we don't test just that:
that grepping for "smudge" in long doesn't find anything.

Current version feels convoluted (and would stop working if Git
is improved to not run "clean" in this case for optimization).
 
>>> +
>>> +		check_filter_ignore_clean \
>>> +			git checkout master \
>>
>> Does this checks different code path than 'git checkout .'? For
>> example, does this test increase code coverage (e.g. as measured
>> by gcov)?  If not, then this test could be safely dropped.
> 
> We checked out the "empty-branch" before. That's why we check here
> that the smudge filter runs for all files (smudge filter did not run
> for all files with `git checkout .`).

All right, it runs for more files, but does it cover different
code paths?  If not, it only makes test run longer...

>>> +				<<-\EOF &&
>>> +					START
>>> +					wrote filter header
>>> +					IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]
>>> +					IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
>>> +					IN: smudge test4-empty.r 0 [OK] -- OUT: 0  [OK]
>>> +					IN: smudge testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]
>>
>> Can we assume that Git would pass files to filter in alphabetical
>> order?  This assumption might make the test unnecessary fragile.
> 
> I have never experienced another behavior. If we see fragility we could
> sort the result...
 
All right (perhaps comment for future would be good idea, though).
 
>>>
>>> +test_expect_success PERL 'required process filter should clean only and take precedence' '
>>
>> Trying to describe it better results in overly long description,
>> which probably means that this test should be split into few
>> smaller ones:
>>
>> - `process` filter takes precedence over `clean` and/or `smudge`
>>   filters, regardless if it supports relevant ("clean" or "smudge")
>>   capability or not
>>
>> - `process` filter that includes only "clean" capability should
>>   clean only (be used only for 'clean' operation)
> 
> Agreed!
> 
> 
>> In my opinion all functions should be placed at beginning,
>> or even in separate file (if they are used in more than
>> one test).
> 
> OK
> 
> 
>>> +generate_test_data () {
>>
>> The name is not good, it doesn't describe what kind of data
>> we want to generate.
> 
> "generate_random_characters" ok?!

All right.

[...]
>>> +		echo "*.file filter=protocol" >.gitattributes &&
>>> +		check_filter \
>>> +			git add *.file .gitattributes \
>>
>> Should it be shell expansion, or git expansion, that is
>>
>>   			git add '*.file' .gitattributes
> 
> Both have the same output. Would the difference matter?

In one case *.file is expanded by shell, then expansion passed
as parameters to `git add` (perhaps not on MS Windows); in the
other '*.file' is passed as pattern to `git add` and expanded
by Git itself (this might be case for both patterns on Win).

But this doesn't matter here, anyway. I think.

[...]
>>> +
>>> +test_expect_success PERL 'process filter should not restart in case of an error' '
>>
>> Errr... what? This description is not clear.  Did you mean
>> that filter should not be restarted if it *signals* an error
>> with file (either before sending anything, or after sending
>> partial contents)?
> 
> OK renamed to "process filter should not be restarted if it signals an error"

This is better.
 
>>> +test_expect_success PERL 'process filter should be able to signal an error for all future files' '
>>
>> Did you mean here that filter can abort processing of
>> all future files?
> 
> "process filter signals abort once to abort processing of all future files", better?

"process filter aborting stops processing of all further files", maybe?

>>> +
>>> +		cp ../test.o test.r &&
>>> +		test_must_fail git add . 2> git_stderr.log &&
>>> +		grep "not support long running filter protocol" git_stderr.log
>>
>> Shouldn't this use gettext poison (or rather C locale)?
>> This error message could be translated in the future.
> 
> I would prefer to adjust that when we translate it.

All right, good enough.

>>> +    $str =~ y/A-Za-z/N-ZA-Mn-za-m/;
>>
>> Why not use tr/// version of this quote-like operation?
>> Or do you follow prior art here?
> 
> I am not Perl expert. That worked for me :-)

y/// and tr/// are the same operator.  Though y/// is supposedly
more Perl-ish, and I think it is used more in Git tests (or rather
it functions).

[...]
>>> +packet_flush();
>>> +print $debug "wrote filter header\n";
>>
>> Or perhaps "handshake end"?
> 
> "init handshake complete", ok?

Better.
 
>>> +    print $debug " $pathname";
>>
>> No " pathname=$pathname" ?
> 
> Yes, otherwise it gets too verbose in the tests.

All right.  And the lines gets too long.

[...]

Regards,
-- 
Jakub Narębski

