Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F3C31F404
	for <e@80x24.org>; Tue, 17 Apr 2018 03:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeDQDs6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 23:48:58 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36644 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeDQDs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 23:48:57 -0400
Received: by mail-wr0-f194.google.com with SMTP id q13so27944277wre.3
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 20:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=UQoSQBxrUbGaMBdbj/MWjvp7Cb2erDEy/9ucnL4TqWY=;
        b=jJFRzxlkVUY4hHRgHx4cvCJCr5KSVgpLEtCAHGSdONkRzYMRFBAR0Kn0FTPtLWFKHR
         URNfPeqdSfzYLk6AXlsC32H8dQ4eeKHtdPirxFrwQUDauYj7YHYARRrctOZB3eDfyXaZ
         oK9J3mvLzMWZPi1eQS6/UWhcxWXGS8imk3kbn9pkAjRe8qu2pSLjSmEnGy0USG7RMs/O
         GjiHpExIOZ1fcr0WAcYRH96O/ccItqmvMJmz6Sv7AYJowubNi8DAGRLNKedkKdZZnyQ4
         drGsH6GXRH0dUqETNwlC/DLqW6+weLsiZD5cCs41RjG7lx7dBnJVi6s1PDUAHuiCcplp
         96Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=UQoSQBxrUbGaMBdbj/MWjvp7Cb2erDEy/9ucnL4TqWY=;
        b=eNoYUGqUPQ8XjmpSDTpUkB+bOXOrx/fjb/7fYkKoI6JapkqUCy6mbwKZ9EYhLnFcms
         9POt0Z5XMxWzwgBSaEX4KmhozZA2PkysQsHfg7xpG7yvlWelMv7dviMs8OC4xmmavf6s
         Twkm47WV88tPCP5atxm3AyNqDVS2eLW93TflnF9PktQO0JNQxUuZs3ZYKb9v+r4DEHty
         8VffiLbENJsRx2HzZFEtaMdBZkcqGPV7yF1X3H1X7k1B952nm4tWfcyG2V8psODpmKsG
         9ZAnJG6lyxXFUeBEq00Fpxy8Gky/p9Y8M204WFl+BfsIgPmHR6BVAxaEHUeaq8LNMtKh
         cJ3g==
X-Gm-Message-State: ALQs6tCJt6EZC2lSliAQg+QZ+n1bPn6948nytvWxGlZ04+aHUt0jyOgV
        guKZyO9WulyMj3kbIguH/Wo=
X-Google-Smtp-Source: AIpwx48+nf6QGOCWxFZpOcy7DjbqywlGGJg+BnhPYbV+LN6ixEuMyTNw81bwYLcqkyLlXcO7S9+1KQ==
X-Received: by 10.28.126.69 with SMTP id z66mr502383wmc.56.1523936935981;
        Mon, 16 Apr 2018 20:48:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 71sm11578513wmg.11.2018.04.16.20.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 20:48:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH 01/11] t9902-completion: add tests demonstrating issues with quoted pathnames
References: <20180318012618.32691-1-szeder.dev@gmail.com>
        <20180416224113.16993-1-szeder.dev@gmail.com>
        <20180416224113.16993-2-szeder.dev@gmail.com>
Date:   Tue, 17 Apr 2018 12:48:54 +0900
In-Reply-To: <20180416224113.16993-2-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Tue, 17 Apr 2018 00:41:05 +0200")
Message-ID: <xmqq7ep6v6ft.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>     Do any more new tests need FUNNYNAMES* prereq?

Hmph, all of these look like they involve some funnynames ;-)

> +test_expect_failure 'complete files - escaped characters on cmdline' '
> +	test_when_finished "rm -rf \"New|Dir\"" &&
> +	mkdir "New|Dir" &&
> +	>"New|Dir/New&File.c" &&
> +
> +	test_completion "git test-path-comp N" \
> +			"New|Dir" &&	# Bash will turn this into "New\|Dir/"
> +	test_completion "git test-path-comp New\\|D" \
> +			"New|Dir" &&
> +	test_completion "git test-path-comp New\\|Dir/N" \
> +			"New|Dir/New&File.c" &&	# Bash will turn this into
> +						# "New\|Dir/New\&File.c "
> +	test_completion "git test-path-comp New\\|Dir/New\\&F" \
> +			"New|Dir/New&File.c"
> +'
> +
> +test_expect_failure 'complete files - quoted characters on cmdline' '
> +	test_when_finished "rm -r \"New(Dir\"" &&

This does not use -rf unlike the previous one?

> +	mkdir "New(Dir" &&
> +	>"New(Dir/New)File.c" &&
> +
> +	test_completion "git test-path-comp \"New(D" "New(Dir" &&
> +	test_completion "git test-path-comp \"New(Dir/New)F" \
> +			"New(Dir/New)File.c"
> +'

OK.

> +test_expect_failure 'complete files - UTF-8 in ls-files output' '
> +	test_when_finished "rm -r árvíztűrő" &&
> +	mkdir árvíztűrő &&
> +	>"árvíztűrő/Сайн яваарай" &&
> +
> +	test_completion "git test-path-comp á" "árvíztűrő" &&
> +	test_completion "git test-path-comp árvíztűrő/С" \
> +			"árvíztűrő/Сайн яваарай"
> +'
> +
> +if test_have_prereq !MINGW &&
> +   mkdir 'New\Dir' 2>/dev/null &&
> +   touch 'New\Dir/New"File.c' 2>/dev/null
> +then
> +	test_set_prereq FUNNYNAMES_BS_DQ
> +else
> +	say "Your filesystem does not allow \\ and \" in filenames."
> +	rm -rf 'New\Dir'
> +fi
> +test_expect_failure FUNNYNAMES_BS_DQ \
> +    'complete files - C-style escapes in ls-files output' '
> +	test_when_finished "rm -r \"New\\\\Dir\"" &&
> +
> +	test_completion "git test-path-comp N" "New\\Dir" &&
> +	test_completion "git test-path-comp New\\\\D" "New\\Dir" &&
> +	test_completion "git test-path-comp New\\\\Dir/N" \
> +			"New\\Dir/New\"File.c" &&
> +	test_completion "git test-path-comp New\\\\Dir/New\\\"F" \
> +			"New\\Dir/New\"File.c"
> +'
> +
> +if test_have_prereq !MINGW &&
> +   mkdir $'New\034Special\035Dir' 2>/dev/null &&
> +   touch $'New\034Special\035Dir/New\036Special\037File' 2>/dev/null

The $'...' quote is bash-ism, but this is about testing bash
completion, so as long as we make sure non-bash shells won't touch
this part of the test, it is OK.

Do we want to test a more common case of a filename that is two
words with SP in between, i.e. 

	$ >'hello world' && git add hel<TAB>

or is it known to work just fine without quoting/escaping (because
the funny we care about is output from ls-files and SP is not special
in its one-item-at-a-time-on-a-line output) and not worth checking?
