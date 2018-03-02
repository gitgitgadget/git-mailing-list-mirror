Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68C321F404
	for <e@80x24.org>; Fri,  2 Mar 2018 16:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1945964AbeCBQJ3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 11:09:29 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37600 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424002AbeCBQJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 11:09:27 -0500
Received: by mail-wm0-f66.google.com with SMTP id 139so4004404wmn.2
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 08:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WF0whw5ay/mnR7ACdlhHPuZZnDb+AK4e9MOrRU7aBeQ=;
        b=EEgdk1MZnmIyAJvxE5ltM8U3QcdTtAb8miRVg9LcIcj5mJrCbqfYeNqAl31nPaYl1m
         WKvFeGYqEFCU7aoc6TDxL8qioAAs2rqmaQVLKGzuVRG3bZMHF0bWYFthgoL5LPfdMcwA
         K54XmLA1kIncvY+kNeNutiPR8ZCA7ggWZHpOLAJKYmhO443SUB9gkiOO+aY4EAqoJZJV
         xolBpA0rVFZhkSsZOtqEpK668BqqC0s3OFSjr+WrOzETT/Ok8JDYySTzX75cwud4DFpj
         iAMxTbUofm++6+GicfwMNqBIgZkw2qNQx8seqjuNTcqSrfDsPF5vU6EeeTofWNSvvRRJ
         3SnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WF0whw5ay/mnR7ACdlhHPuZZnDb+AK4e9MOrRU7aBeQ=;
        b=o+UcNmvjxjRjJDoetqUEHuNroj5O7bQpHFmFQy8+ErXz1jY7xdNlIAsidSuodsSDFW
         OXJZFlhakegIuHK8iPNq3pvlCJM7AdvTWkcYsbOXHsFosAmBNEyHQySxi3WX/1oXZUlX
         G11nJFuzObdGCajuh3uDcMEIg1/y8lKr7zonopJUOtUCoHxMDL/ro6X7iReuz4LCCQb2
         6sKNkW6GLgO58UK7qKAgb1IrvXa/YzyyfbYammf1kKcyYTb4Li/eDlL8Gs8PsxBWE19f
         fOBaWkr6kFCne0fitawld9ihPjPXYeAMnscEyV7LjSUksrbwjKMecW//ToGj5sAs786/
         nh1g==
X-Gm-Message-State: AElRT7GPbb6nXAiQNu+IqtLgpc2quZ0hUpvs71S6x7tgAfXGDhCK2usO
        Q4fGEAXS6ApMzk9C1DMiGiY=
X-Google-Smtp-Source: AG47ELsXKOWANcClRvkJWZl6atF/CGV14Ro7nsLpPnnmxyBJqKeUX19B7HGvY43fJYRxstElZ+nyhA==
X-Received: by 10.28.17.77 with SMTP id 74mr1945223wmr.67.1520006966056;
        Fri, 02 Mar 2018 08:09:26 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s21sm5612024wra.45.2018.03.02.08.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Mar 2018 08:09:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 4/9] t3701: don't hard code sha1 hash values
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
        <20180301105103.24268-1-phillip.wood@talktalk.net>
        <20180301105103.24268-5-phillip.wood@talktalk.net>
        <20180302155528.12106-1-szeder.dev@gmail.com>
Date:   Fri, 02 Mar 2018 08:09:24 -0800
In-Reply-To: <20180302155528.12106-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 2 Mar 2018 16:55:28 +0100")
Message-ID: <xmqqa7vqe9xn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> +diff_cmp () {
>> +	for x
>> +	do
>> +		sed  -e '/^index/s/[0-9a-f]*[1-9a-f][0-9a-f]*\.\./1234567../' \
>> +		     -e '/^index/s/\.\.[0-9a-f]*[1-9a-f][0-9a-f]*/..9abcdef/' \
>> +		     -e '/^index/s/ 00*\.\./ 0000000../' \
>> +		     -e '/^index/s/\.\.00*$/..0000000/' \
>> +		     -e '/^index/s/\.\.00* /..0000000 /' \
>> +		     "$x" >"$x.filtered"
>> +	done
>> +	test_cmp "$1.filtered" "$2.filtered"
>> +}
>
> t3701 is not the only test script comparing diffs, many other
> tests do so:
>
>   $ git grep 'diff --git' t/ |wc -l
>   835
>
> It's totally inaccurate, but a good ballpark figure.
>
> I think this function should be a widely available test helper
> function in 'test-lib-functions.sh', perhaps renamed to
> 'test_cmp_diff', so those other tests could use it as well.

I am on the fence.  

The above does not redact enough (e.g. rename/copy score should be
redacted while comparing) to serve as a generic filter.

We could certainly extend it when we make code in other tests use
the helper, but then we can do the moving to test-lib-functions when
that happens, too.

Those who will be writing new tests that need to compare two diff
outputs are either (1) people who are careful and try to find
existing tests that do the same, to locate the helper we already
have to be reused in theirs, or (2) people who don't and roll their
own.  The latter camp cannot be helped either way, but the former
will run "git grep 'diff --git' t/" and find the helper whether it
is in this script or in test-lib-functions, I would think.

So, I certainly do not mind a reroll to move it to a more generic
place, but I do not think I would terribly mind if we leave it in
its current place, later to be moved by the first new caller that
wants to use it from outside this script.
