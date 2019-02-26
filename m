Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE2AD20248
	for <e@80x24.org>; Tue, 26 Feb 2019 17:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfBZREG (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 12:04:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33764 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfBZREG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 12:04:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so14816652wrw.0
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 09:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s0wKD5db0sx223KjrNHJs/EPUf7Oc0aFZN5uejozIgc=;
        b=VXkCkGzE8wf2XXLpJ+BRBvWfwezNXGcyjtKgUK592OoICTg1R5WTewN6VfeAdnJMZd
         tQMtwIrZbvRjLHFUXdD1T36CcGSSMgx/KOOHLXETvIbf9Q9F5ldxi9TAC5H5PJ9t2+t8
         Hsq9GmDcARyzAQ+4/Zq7O1+K+NQqZVACg99B/2z+oXp2bVY6mRgMa8iYYNcRrgKDGigI
         8KGEOXFHoiK8mC1zye7bnxPR/80dU8Quwor9b+yoDXZDWkhFdJrIGrSqFNhkRoY3b/Ni
         /glYDLxEhuAORbD4cdxr4cBWdb7bsqB94AEVTiHN7c2aZthnT3LY8CypRTIAMdmMpBGQ
         M5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s0wKD5db0sx223KjrNHJs/EPUf7Oc0aFZN5uejozIgc=;
        b=RYpUZm3RFv8NuBzT1LfCpzemIutpWUKwMWOwfzPDW7saC0wBEB3NJBPNUjIT0a+wFj
         81PmnoQxJw2bKNpAZkR2l05F60D0lt1/4q2rqlB8FymHX6L50tUKySgSGsI1L1IKOtVp
         5VzMfOvGNFzDZAblY4c81RUK4ybaJlIwCk/deyrr1o1zZOzJ5tP3a0rMB1ZWDd4vAtyN
         2+XrlBlxj+uMNUlVBRJQ1/9NqdgFnvry60uRtjFzBwENN7tX18a/zuzdcWcsCdYeO2ZX
         ls7T1z3hXkjyGItvuoM63yOEna3qjmGNEzBelcqK6CN2FPftmkyQGdGyqoQV3lLYSX1P
         TaoQ==
X-Gm-Message-State: AHQUAuaPesSlEPNu0QeEYiDaOYbw+G+pOW3pArH59ZaZFQPbAsjSFn94
        6okKbCbp9tI60NzG9G5X7aY=
X-Google-Smtp-Source: AHgI3IZnaERuHah7YD0H+d20VmkvudG9mJbZMUh+TqTS7XY76N6bPQSOLstjS1PxxT/77phK/0CcRg==
X-Received: by 2002:adf:a49c:: with SMTP id g28mr16586008wrb.147.1551200643826;
        Tue, 26 Feb 2019 09:04:03 -0800 (PST)
Received: from szeder.dev (x4db46559.dyn.telefonica.de. [77.180.101.89])
        by smtp.gmail.com with ESMTPSA id v67sm24307722wmb.9.2019.02.26.09.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:04:03 -0800 (PST)
Date:   Tue, 26 Feb 2019 18:04:00 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: Do test-path_is_{file,dir,exists} make sense anymore with -x?
Message-ID: <20190226170400.GC19739@szeder.dev>
References: <pull.152.git.gitgitgadget@gmail.com>
 <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
 <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com>
 <87sgwav8cp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sgwav8cp.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 05:10:30PM +0100, Ævar Arnfjörð Bjarmason wrote:
> However. I wonder in general if we've re-visited the utility of these
> wrappers and maybe other similar wrappers after -x was added.

> But 4 years after this was added in a136f6d8ff ("test-lib.sh: support -x
> option for shell-tracing", 2014-10-10) we got -x, and then with "-i -v -x":

'-x' tracing doesn't work in all test scripts, unless it is run with a
Bash version already supporting BASH_XTRACEFD, i.e. v4.1 or later.
Notably the default Bash shipped in macOS is somewhere around v3.2.

> And at least to me whenever I have a test failure the first thing I do
> is try with -x (if I wasn't already using it). Under that the wrapper
> output is more verbose and no more helpful. It's immediately clear
> what's going on with:
> 
>     + test -f doesnotexist
>     error: last command exited with $?=1
> 
> Whereas:
> 
>     + test -f doesnotexist
>     + echo File doesnotexist doesn't exist.
>     File doesnotexist doesn't exist.
>     + false
>     error: last command exited with $?=1
> 
> Gives me the same thing, but I have to read 5 lines instead of 2 that
> ultimately don't tell me any more (and a bit of "huh, 'false' returned
> 1? Of course! Oh! It's faking things up and it's the 'echo' that
> matters...").

I didn't find this to be an issue, but because of functions like
'test_seq' and 'test_must_fail' I've thought about suppressing '-x'
output for test helpers (haven't actually done anything about it,
though).

> Looking over test-lib-functions.sh this patch would do it. I couldn't
> spot any other functions redundant to -x:
> 
>     diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>     index 80402a428f..b3a95b4968 100644
>     --- a/t/test-lib-functions.sh
>     +++ b/t/test-lib-functions.sh
>     @@ -555,33 +555,6 @@ test_external_without_stderr () {
>      	fi
>      }
> 
>     -# debugging-friendly alternatives to "test [-f|-d|-e]"
>     -# The commands test the existence or non-existence of $1. $2 can be
>     -# given to provide a more precise diagnosis.

Note the second parameter; though, of course, you could argue that we
use it so rarely that it wouldn't really be missed.

>     -test_path_is_file () {
>     -	if ! test -f "$1"
>     -	then
>     -		echo "File $1 doesn't exist. $2"
>     -		false
>     -	fi
>     -}
>     -
>     -test_path_is_dir () {
>     -	if ! test -d "$1"
>     -	then
>     -		echo "Directory $1 doesn't exist. $2"
>     -		false
>     -	fi
>     -}
>     -
>     -test_path_exists () {
>     -	if ! test -e "$1"
>     -	then
>     -		echo "Path $1 doesn't exist. $2"
>     -		false
>     -	fi
>     -}
>     -
>      # Check if the directory exists and is empty as expected, barf otherwise.
>      test_dir_is_empty () {
>      	test_path_is_dir "$1" &&
>     @@ -593,19 +566,6 @@ test_dir_is_empty () {
>      	fi
>      }
> 
>     -test_path_is_missing () {
>     -	if test -e "$1"
>     -	then
>     -		echo "Path exists:"
>     -		ls -ld "$1"

This 'ls' command gives a bit of additional info.

>     -		if test $# -ge 1
>     -		then
>     -			echo "$*"
>     -		fi
>     -		false
>     -	fi
>     -}
>     -
>      # test_line_count checks that a file has the number of lines it
>      # ought to. For example:
>      #
>     @@ -849,6 +809,9 @@ verbose () {
>      # otherwise.
> 
>      test_must_be_empty () {
>     +	# We don't want to remove this as noted in ec10b018e7 ("tests:
>     +	# use 'test_must_be_empty' instead of '! test -s'",
>     +	# 2018-08-19)

Indeed.

>      	test_path_is_file "$1" &&

This still uses 'test_path_is_file'.

>      	if test -s "$1"
>      	then
