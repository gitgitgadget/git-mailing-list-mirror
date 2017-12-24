Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C01E1F406
	for <e@80x24.org>; Sun, 24 Dec 2017 11:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbdLXLGO (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 06:06:14 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:46918 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbdLXLGM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 06:06:12 -0500
Received: by mail-wm0-f65.google.com with SMTP id r78so28792472wme.5
        for <git@vger.kernel.org>; Sun, 24 Dec 2017 03:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jfLYWA6mmSpiXbSs/FO3vyR4FhUfWPFsnhfnw3Lw8zM=;
        b=BjuEWlgXIIOgmSxUnGMLAJh3W10FAPx69iUQjFOVKWHk++ADcfoLRScKvQ6F/SFuBl
         D9mtYpie7w1UF0XUWZ6/fZQdQMRRxsRqGoMwp/6aj269jBwCL07z+IHS8Y2UMGCMHUwU
         dGn0i1y6hlMlG+KDGdTkpROcthZCfbmtENW7OIG/FSm+w9tB9xUnFRyyIs60blOe1nIF
         YcvhUrQoLDQf6CXcUOam3f302y7lSXK9oBQMnUHZ/aiRMaA6y50TEvk0hZrVM86BCSbh
         /73Sq3b+hOlN6XajX4wLfhnM6MW0OuFdw66Sh2VU5C2mhRE5H4jIWwUlQ0qFzKDJkzpg
         GcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=jfLYWA6mmSpiXbSs/FO3vyR4FhUfWPFsnhfnw3Lw8zM=;
        b=fI1QGZwaKLxO6HxgQsk7VDwpyi2riXO2KfnNSxArOjE4WBfH/0HCxRku/ZjtlEhWcT
         6zV0ufgcIiVDPpU7YnmwqwzrGcd0yH37qn9RZknLoa+KhupdcB/3uEG33NKaW1lfvbKY
         wkgRwrmQEIR7TLj0F3zRMEPnkGuTkoZVrzOXfJT//BqOpWKXp6a/kT+UUquPXPpFQEng
         R4lB0Q1SgKeMYf0qr1bVLP1IRjKqb5Ro6Vk0CEh1O/bFmZSInsLshKyAFsg0o59OZL4A
         eg1Erd87HsQJJHNQMz14iK1pxZbiAC4KuNAQORKa3KRwO3FdcuRpgHfbPKYi7U2t8tsu
         TzwQ==
X-Gm-Message-State: AKGB3mIifIwVplfT7PVxiFnt3dvMQMp/u5hk1h/+CZrGR3lLJV5q3Wqx
        JQ6gDMoJ+OvSKt09SUbALCE=
X-Google-Smtp-Source: ACJfBot7t0RCZku1ptMiOVyGtrZvHgjxB9HRmcsBdLl71zXb/kbrIuu2BqMs9MOpFqwJ5vDbsNLoqg==
X-Received: by 10.80.134.197 with SMTP id 5mr23136540edu.129.1514113571588;
        Sun, 24 Dec 2017 03:06:11 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id b2sm24971929edd.26.2017.12.24.03.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Dec 2017 03:06:10 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 6/6] wildmatch test: create & test files on disk in addition to in-memory
References: <20171223213012.1962-1-avarab@gmail.com> <20171223213012.1962-7-avarab@gmail.com> <8f4cdb23-8e2e-144a-1f70-99776b027166@kdbg.org>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <8f4cdb23-8e2e-144a-1f70-99776b027166@kdbg.org>
Date:   Sun, 24 Dec 2017 12:06:09 +0100
Message-ID: <874logs7vi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 24 2017, Johannes Sixt jotted:

> Am 23.12.2017 um 22:30 schrieb Ævar Arnfjörð Bjarmason:
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>   a[]b                 |   0
>>   t/t3070-wildmatch.sh | 336 ++++++++++++++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 319 insertions(+), 17 deletions(-)
>>   create mode 100644 a[]b
>>
>> diff --git a/a[]b b/a[]b
>> new file mode 100644
>> index 0000000000..e69de29bb2
>
> A big no-no! This file can't be created on Windows!

Urgh, that was a mistake of mine. Will be gone in v2.

>> diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
>> index 47b479e423..d423bb01f3 100755
>> --- a/t/t3070-wildmatch.sh
>> +++ b/t/t3070-wildmatch.sh
>> @@ -4,31 +4,146 @@ test_description='wildmatch tests'
>>
>>   . ./test-lib.sh
>>
>> +create_test_file() {
>> +	file=$1
>> +
>> +	# `touch .` will succeed but obviously not do what we intend
>> +	# here.
>> +	test "$file" = "." && return 1
>> +	# We cannot create a file with an empty filename.
>> +	test "$file" = "" && return 1
>> +	# The tests that are testing that e.g. foo//bar is matched by
>> +	# foo/*/bar can't be tested on filesystems since there's no
>> +	# way we're getting a double slash.
>> +	echo "$file" | grep -q -F '//' && return 1
>> +	# When testing the difference between foo/bar and foo/bar/ we
>> +	# can't test the latter.
>> +	echo "$file" | grep -q -E '/$' && return 1
>> +
>> +	dirs=$(echo "$file" | sed -r 's!/[^/]+$!!')
>
> Booh! Booh! So many fork()s! ;)
>
> 	case "$file" in
> 	*//*)
> 		# The tests that are testing that e.g. foo//bar is matched by
> 		# foo/*/bar can't be tested on filesystems since there's no
> 		# way we're getting a double slash.
> 		return 1;;
> 	*/)
> 		# When testing the difference between foo/bar and foo/bar/ we
> 		# can't test the latter.
> 		return 1;;
> 	esac
>
> 	dirs=${file%/*}

Thanks. Will fix.

>> +
>> +	# We touch "./$file" instead of "$file" because even an
>> +	# escaped "touch -- -" means something different.
>> +	if test "$file" != "$dirs"
>> +	then
>> +		mkdir -p -- "$dirs" 2>/dev/null &&
>> +		touch -- "./$file" 2>/dev/null &&
>> +		return 0
>> +	else
>> +		touch -- "./$file" 2>/dev/null &&
>> +		return 0
>> +	fi
>> +	return 1
>> +}
>> +
>>   wildtest() {
>> -	match_w_glob=$1
>> -	match_w_globi=$2
>> -	match_w_pathmatch=$3
>> -	match_w_pathmatchi=$4
>> -	text=$5
>> -	pattern=$6
>> +	if test "$#" = 6
>> +	then
>> +		# When test-wildmatch and git ls-files produce the same
>> +		# result.
>> +		match_w_glob=$1
>> +		match_f_w_glob=$match_w_glob
>> +		match_w_globi=$2
>> +		match_f_w_globi=$match_w_globi
>> +		match_w_pathmatch=$3
>> +		match_f_w_pathmatch=$match_w_pathmatch
>> +		match_w_pathmatchi=$4
>> +		match_f_w_pathmatchi=$match_w_pathmatchi
>> +		text=$5
>> +		pattern=$6
>> +	elif test "$#" = 10
>> +	then
>> +		match_w_glob=$1
>> +		match_w_globi=$2
>> +		match_w_pathmatch=$3
>> +		match_w_pathmatchi=$4
>> +		match_f_w_glob=$5
>> +		match_f_w_globi=$6
>> +		match_f_w_pathmatch=$7
>> +		match_f_w_pathmatchi=$8
>> +		text=$9
>> +		pattern=$10
>> +	fi
>>
>> +	# $1: Case sensitive glob match: test-wildmatch
>>   	if test "$match_w_glob" = 1
>>   	then
>> -		test_expect_success "wildmatch:     match '$text' '$pattern'" "
>> +		test_expect_success "wildmatch: match '$text' '$pattern'" "
>>   			test-wildmatch wildmatch '$text' '$pattern'
>>   		"
>>   	elif test "$match_w_glob" = 0
>>   	then
>> -		test_expect_success "wildmatch:  no match '$text' '$pattern'" "
>> +		test_expect_success "wildmatch: no match '$text' '$pattern'" "
>>   			! test-wildmatch wildmatch '$text' '$pattern'
>>   		"
>>   	else
>>   		test_expect_success "PANIC: Test framework error. Unknown matches value $match_w_glob" 'false'
>
> I think you can write this as 'say ...; exit 1'. See t0000*.

Thanks. Didn't see an existing idiom for this, will use that.

>>   	fi
>>
>> +	# $1: Case sensitive glob match: ls-files
>> +	if test "$match_f_w_glob" = 'E'
>> +	then
>> +		if create_test_file "$text"
>> +		then
>> +			test_expect_success "wildmatch(ls): match dies on '$pattern' '$text'" "
>> +				test_when_finished \"
>> +					rm -rf -- * &&
>
> Can we be a bit more careful with this rm -rf, please?
> There is only one similarly loose case in t/t7003-filter-branch.sh,
> and it is outside test_when_finished, i.e., it is well under control;
> this instance here inside test_when_finished is not.

I can create the files inside some subfolder, cd to that and then run
the ls-files there. It would also cover cases where we have pattern
matching text that starts with ".".

>> +					git reset
>> +				\" &&
>> +				git add -A &&
>> +				>expect.err &&
>> +				printf '%s' '$text' >expect &&
>> +				test_must_fail git --glob-pathspecs ls-files -z -- '$pattern'
>> +			"
>> +		else
>> +			test_expect_failure "wildmatch(ls): match skip '$pattern' '$text'" 'false'
>> +		fi
>> +	elif test "$match_f_w_glob" = 1
>> +	then
>> +		if create_test_file "$text"
>> +		then
>> +			test_expect_success "wildmatch(ls): match '$pattern' '$text'" "
>> +				test_when_finished \"
>> +					rm -rf -- * &&
>> +					git reset
>> +				\" &&
>> +				git add -A &&
>> +				>expect.err &&
>> +				printf '%s' '$text' >expect &&
>
> There are no single-quotes in any $text instances, right?

There's not, but maybe we should be more careful here and use here-docs.

>> +				git --glob-pathspecs ls-files -z -- '$pattern' 2>actual.err | tr -d '\0' >actual &&
>
> If possible, do not put git commands in the upstream of a pipe.
> It does not detect failures.

Thanks, will split these up.

> Unfortunately, printf '%s\0' foo is not portable. If it were,
> you could omit the tr invocation alltogether.
>
>> +				test_cmp expect.err actual.err &&
>> +				test_cmp expect actual
>> +			"
>> +		else
>> +			test_expect_failure "wildmatch(ls): match skip '$pattern' '$text'" 'false'
>> +		fi
>
> -- Hannes
