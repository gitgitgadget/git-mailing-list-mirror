Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B8121F428
	for <e@80x24.org>; Fri,  5 Jan 2018 21:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbeAEVgc (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 16:36:32 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45075 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753074AbeAEVgb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 16:36:31 -0500
Received: by mail-wm0-f65.google.com with SMTP id 9so4744579wme.4
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 13:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Wywc6l/1IWNnmLiJsm613g84o8ZBQeItXjCnF9kS2Rg=;
        b=kafFNw/XNaUAcpwe5qR/ONjrsrWuYtn57wJm5iSnx9O6IOP7CPahkxRt3NLEW9Hsbm
         v22YGMuI2lnMy1lMw/F7DWssI9XD2aae9frBVZeWAfFZEt4vRLzmPhHTa+up0cj7qQrN
         SAS3PWo/GdGal/3MpYCF2FHyQ0SMfHWBrTnymimSG6Sexrtzhyo8cHfMkJ41ZpwPy66w
         7t78+JGtzcEIVTtTIz1dZlTsKxJ9QbZX34Vzy/s51FYle5zq3M4pkzwfs0f5xQCLxouC
         yMwlNRai+q46zIcljJQb70T3c21l9TX54amU7UeBC37S1eG7QMjmHlMF9wq9XTeVaYhs
         j4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Wywc6l/1IWNnmLiJsm613g84o8ZBQeItXjCnF9kS2Rg=;
        b=N5jNWHl2vBOKCWXUbmODCpBVdUyTdy15/YkwOJQIUXF5o972F3jFLkWYmDfhd3YoVO
         06urTAGn/rpJ55c+cOMYVmLUAvKeFjLp9sW8NnSkUQqYi79T1NFbMhfGnkgr+7hzwBEj
         KJt2VBNVJkO8TWvIZiTPg4QZ8DicPby6tz7hqXP2JkBk0gwIhW8SimHzZvxCkdQBSj1Y
         MG6K4ekBPIREKcuw2/ZPIYwB10/pXJ4l5gWxkSmyS9NMagT8uBN917T2JfhJEm5fLI95
         HJFpoXNRiJxJsR6e/0JbGgnMp3sWAARJ/tOyQ1lc97K5N0d15fITSsETG1tKVjRYON0l
         OSdQ==
X-Gm-Message-State: AKGB3mLt5+r73+qL/VPXbGCKiqRhwXXbd90YkiaMONDRoBvnctKYvaUk
        BB96v1ZY6oG8T52OFVCWrZdYYQUy
X-Google-Smtp-Source: ACJfBoveWSafGk6iQa/mqSP5fmnalsAeEX3dPyZRcYre9PaTgNhyMxm2YcbpP2nYIJa99nNKsw8QnA==
X-Received: by 10.80.163.221 with SMTP id t29mr6079989edb.39.1515188190002;
        Fri, 05 Jan 2018 13:36:30 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id q3sm4716437edd.61.2018.01.05.13.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 13:36:28 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] perf: amend the grep tests to test grep.threads
References: <20171229225903.19688-1-avarab@gmail.com> <xmqqinchfowj.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqinchfowj.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 05 Jan 2018 22:36:27 +0100
Message-ID: <87o9m8asys.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 04 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Ever since 5b594f457a ("Threaded grep", 2010-01-25) the number of
>> threads git-grep uses under PTHREADS has been hardcoded to 8, but
>> there's no performance test to check whether this is an optimal
>> setting.
>>
>> Amend the existing tests for the grep engines to support a mode where
>> this can be tested, e.g.:
>>
>>     GIT_PERF_GREP_THREADS='1 8 16' GIT_PERF_LARGE_REPO=~/g/linux ./run p782*
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>
>> This looks less scary under diff -w.
>>
>>  t/perf/p7820-grep-engines.sh       | 52 ++++++++++++++++++++++++++++-------
>>  t/perf/p7821-grep-engines-fixed.sh | 55 ++++++++++++++++++++++++++++++--------
>>  2 files changed, 86 insertions(+), 21 deletions(-)
>>
>> diff --git a/t/perf/p7820-grep-engines.sh b/t/perf/p7820-grep-engines.sh
>> index 62aba19e76..8b09c5bf32 100755
>> --- a/t/perf/p7820-grep-engines.sh
>> +++ b/t/perf/p7820-grep-engines.sh
>> @@ -12,6 +12,9 @@ e.g. GIT_PERF_7820_GREP_OPTS=' -i'. Some options to try:
>> ...
>> +		if ! test_have_prereq PERF_GREP_ENGINES_THREADS
>>  		then
>> -			test_cmp out.basic out.perl
>> +			test_perf $prereq "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern'" "
>> +				git -c grep.patternType=$engine grep$GIT_PERF_7820_GREP_OPTS -- '$pattern' >'out.$engine' || :
>> +			"
>> +		else
>> +			for threads in $GIT_PERF_GREP_THREADS
>> +			do
>> +				test_perf PTHREADS,$prereq "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern' with $threads threads" "
>
> Is it guaranteed that $prereq is not empty at this point?
>
> Judging by the way the other side uses "test_perf $prereq ..."
> without quotes around it, I suspect you do expect it to be empty in
> some cases.  It means you expect test_have_prereq is prepared to
> skip an empty prerequisite in a prereq list, but I do not recall
> writing that helper in such a way, so...
>
> 	PTHREADS${prereq:+,}$prereq
>
> or something along that line, perhaps?

It's not, but a trailing comma at the end of the prereq list works since
test_have_prereq() relies on setting the IFS to ",", so as long as this
is portable:

    $ str="foo,bar,baz,"; export IFS=,; for word in $str; do echo "w:<$word>"; done
    w:<foo>
    w:<bar>
    w:<baz>

And I'm not 100% sure that it is, this should be fine. Works on both
bash & dash for me.

We could use the ${...} pattern above if you prefer, but since it
doesn't appear to be needed...

>> diff --git a/t/perf/p7821-grep-engines-fixed.sh b/t/perf/p7821-grep-engines-fixed.sh
>> index c7ef1e198f..61e41b82cf 100755
>> --- a/t/perf/p7821-grep-engines-fixed.sh
>> +++ b/t/perf/p7821-grep-engines-fixed.sh
>> @@ -6,6 +6,9 @@ Set GIT_PERF_7821_GREP_OPTS in the environment to pass options to
>> ...
>>  for pattern in 'int' 'uncommon' 'æ'
>>  do
>>  	for engine in fixed basic extended perl
>> @@ -23,19 +31,44 @@ do
>> ...
>> +		if ! test_have_prereq PERF_GREP_ENGINES_THREADS
>>  		then
>> -			test_cmp out.fixed out.perl
>> +			test_perf $prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern" "
>> +				git -c grep.patternType=$engine grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine' || :
>> +			"
>> +		else
>> +			for threads in $GIT_PERF_GREP_THREADS
>> +			do
>> +				test_perf PTHREADS,$prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern with $threads threads" "
>> +					git -c grep.patternType=$engine -c grep.threads=$threads grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine.$threads' || :
>> +				"
>> +			done
>
> Same here, which means these two scripts share somewhat large body
> of text and makes me wonder if it is worth refactoring it to ease
> future updates to them.

Yeah, but I wanted to leave refactoring these for some other time.
