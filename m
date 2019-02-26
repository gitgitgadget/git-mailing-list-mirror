Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F23202AA
	for <e@80x24.org>; Tue, 26 Feb 2019 16:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfBZQKh (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 11:10:37 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:36551 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfBZQKg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 11:10:36 -0500
Received: by mail-ed1-f50.google.com with SMTP id g9so11211506eds.3
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 08:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=WrvJ5qNpRuDlSY1+zH/pyk7JUrI7qiUYs9PZui96ANU=;
        b=JdmrqV9JLlGAcLwJccJQqGqLkBfsYtkcB7tV+gvp4bQWEnp29ZfZr+CTa1Ci1ETsn1
         l8p0tvmwCLJtenKjMIMEAL1rdFUA9oTslIBkbYPqzwik/8vNUhzcvNBB4R1evJNof9uH
         1YUgeInOaLmNZY0285i1GHG17LNcL1uLYKflyKacSZuArO4vcQbRweKPmOQAf9CjfMtJ
         kw0KQcUN6cn6ARO4RJyRVvr6C83qZd1cf1Xr9H9NMcFP1y78lQ5aCgI/XZ+Gx3VBQHXy
         4jR6g7515Hgc7wOJTdJPkLt8e3nQhHWl2VDvbr7807Z1ac+341Acf5P30R44FayDGYpb
         Ah7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=WrvJ5qNpRuDlSY1+zH/pyk7JUrI7qiUYs9PZui96ANU=;
        b=A7N+s1aZwTa6INUvly4zJtUV0gaLpLT+fqpGKp2qQUFo846cBAHmH5Esa2Ux4eeZJV
         qRpTIKJO6K/b68G/3S03eibOJOoKOdMJXfdFoCJoSLPgTkHOdE16CVncE+TyVd5oNV6L
         Jja0oIEBwiJK5pD/zg5gbwdyFFeOtUYohVN/rOcNz9KjagNTYMJlOCPw/tx30YJF84qP
         VwSdoihjUjuKumILBdiqKZasxOe7/BKstDv8TNQ3QfB6gU/hB/DdoFmwMeqIM42GH+Em
         JnU0SRzayEsSTAXyR5iQuuHnFNy9Lz7t34M7/PHIPUKjIanW8W/m7A/NqZUv0PbGIYX8
         kJoA==
X-Gm-Message-State: AHQUAuY/LSt986Bpke4O+SNkkycIQa7H0oD35NA3HFWlqqDKWb4I2bPQ
        9Ms2uWo46kG/CtPMch9mKTAt9OhWpOg=
X-Google-Smtp-Source: AHgI3IatcyIXa0BQfcSglggRrJcL5B0f9jorAJU21bdGV5apwIAgm9p/1Xqt+Y5mnRYi1qTCAPltRg==
X-Received: by 2002:a17:906:7b03:: with SMTP id e3mr17519956ejo.21.1551197433946;
        Tue, 26 Feb 2019 08:10:33 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id g13sm623906eda.71.2019.02.26.08.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 08:10:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>
Subject: Do test-path_is_{file,dir,exists} make sense anymore with -x?
References: <pull.152.git.gitgitgadget@gmail.com> <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com> <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com>
Date:   Tue, 26 Feb 2019 17:10:30 +0100
Message-ID: <87sgwav8cp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 26 2019, Duy Nguyen wrote:

> On Tue, Feb 26, 2019 at 8:42 PM Rohit Ashiwal via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>>
>> t3600-rm.sh: Previously we were using `test -(d|f)`
>> to verify the presencee of a directory/file, but we
>> already have helper functions, viz, test_path_is_dir
>> and test_path_is_file with same functionality. This
>
> It's not just the same (no point replacing then). It's better. When
> test_path_is_xxx fails, you get an error message. If "test -xxx"
> fails, you get a failed test with no clue what caused it.

I swear I'm not just on a mission to ruin everyone's GSOC projects. This
patch definitely looks good, and given that we have this / document it
makes sense.

However. I wonder in general if we've re-visited the utility of these
wrappers and maybe other similar wrappers after -x was added.

Back when this was added in 2caf20c52b ("test-lib: user-friendly
alternatives to test [-d|-f|-e]", 2010-08-10) we didn't have -x. So we'd
at best fail like this:

    $ ./t0001-init.sh  -v -i
    Initialized empty Git repository in /home/avar/g/git/t/trash directory.t0001-init/.git/
    expecting success:
            test -d .git &&
            test -f doesnotexist &&
            test -f .git/config

    not ok 1 - check files
    #
    #               test -d .git &&
    #               test -f doesnotexist &&
    #               test -f .git/config
    #

At that point this was a definite improvement:

    expecting success:
            test_path_is_dir .git &&
            test_path_is_file doesnotexist &&
            test_path_is_file .git/config

    File doesnotexist doesn't exist.
    not ok 1 - check files

But 4 years after this was added in a136f6d8ff ("test-lib.sh: support -x
option for shell-tracing", 2014-10-10) we got -x, and then with "-i -v -x":

    expecting success:
            test_path_is_dir .git &&
            test_path_is_file doesnotexist &&
            test_path_is_file .git/config

    + test_path_is_dir .git
    + test -d .git
    + test_path_is_file doesnotexist
    + test -f doesnotexist
    + echo File doesnotexist doesn't exist.
    File doesnotexist doesn't exist.
    + false
    error: last command exited with $?=1
    not ok 1 - check files

But by just using "test -d/-e": the much shorter:

    + test -d .git
    + test -f doesnotexist
    error: last command exited with $?=1
    not ok 1 - check files

So I wonder if these days we shouldn't do this the other way around and
get rid of these. Every test_* wrapper we add adds a bit of cognitive
overload when you have to remember Git's specific shellscript dialect.

And at least to me whenever I have a test failure the first thing I do
is try with -x (if I wasn't already using it). Under that the wrapper
output is more verbose and no more helpful. It's immediately clear
what's going on with:

    + test -f doesnotexist
    error: last command exited with $?=1

Whereas:

    + test -f doesnotexist
    + echo File doesnotexist doesn't exist.
    File doesnotexist doesn't exist.
    + false
    error: last command exited with $?=1

Gives me the same thing, but I have to read 5 lines instead of 2 that
ultimately don't tell me any more (and a bit of "huh, 'false' returned
1? Of course! Oh! It's faking things up and it's the 'echo' that
matters...").

Looking over test-lib-functions.sh this patch would do it. I couldn't
spot any other functions redundant to -x:

    diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
    index 80402a428f..b3a95b4968 100644
    --- a/t/test-lib-functions.sh
    +++ b/t/test-lib-functions.sh
    @@ -555,33 +555,6 @@ test_external_without_stderr () {
     	fi
     }

    -# debugging-friendly alternatives to "test [-f|-d|-e]"
    -# The commands test the existence or non-existence of $1. $2 can be
    -# given to provide a more precise diagnosis.
    -test_path_is_file () {
    -	if ! test -f "$1"
    -	then
    -		echo "File $1 doesn't exist. $2"
    -		false
    -	fi
    -}
    -
    -test_path_is_dir () {
    -	if ! test -d "$1"
    -	then
    -		echo "Directory $1 doesn't exist. $2"
    -		false
    -	fi
    -}
    -
    -test_path_exists () {
    -	if ! test -e "$1"
    -	then
    -		echo "Path $1 doesn't exist. $2"
    -		false
    -	fi
    -}
    -
     # Check if the directory exists and is empty as expected, barf otherwise.
     test_dir_is_empty () {
     	test_path_is_dir "$1" &&
    @@ -593,19 +566,6 @@ test_dir_is_empty () {
     	fi
     }

    -test_path_is_missing () {
    -	if test -e "$1"
    -	then
    -		echo "Path exists:"
    -		ls -ld "$1"
    -		if test $# -ge 1
    -		then
    -			echo "$*"
    -		fi
    -		false
    -	fi
    -}
    -
     # test_line_count checks that a file has the number of lines it
     # ought to. For example:
     #
    @@ -849,6 +809,9 @@ verbose () {
     # otherwise.

     test_must_be_empty () {
    +	# We don't want to remove this as noted in ec10b018e7 ("tests:
    +	# use 'test_must_be_empty' instead of '! test -s'",
    +	# 2018-08-19)
     	test_path_is_file "$1" &&
     	if test -s "$1"
     	then
