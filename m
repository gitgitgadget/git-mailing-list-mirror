Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7719C1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 19:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389107AbeG0UfD (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 16:35:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33067 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389075AbeG0UfD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 16:35:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id g6-v6so6062998wrp.0
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=04epfDpp70eTBVzGChoflAQtmrwM5nDEB6h08kvIVm4=;
        b=hjlpz4lRyeoau9cMpk4mQHxYjsvY6WHsYm4zabpUZ5YQTGihSMEoef7rrCLhy+p3fM
         jX0SXz1oq5KyTFHH2qy3VX8l2L5Pwsyq344a5nzE0DAlm2p2fYjmUkKQO4vKP9SBV6/R
         e8sUuZqc+JyzZqmyx/YIXPGHIFuAZxLzUb5SWDOOE75ZL3Q0V9jBVBz9z83fEJyRzdRv
         G6o7HVZAiDlHFqcpTO7KVhuwbmHogMUCc7LA7jJsS6rHcQtZFKkvXOwQKuzZrDMOhgP5
         e93oJrI1ftqTJ5tuu25NHlWUZ09+cKJA2c3kORHoSB1eFazE6wCju+gCOw9zNEFG5GzK
         m05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=04epfDpp70eTBVzGChoflAQtmrwM5nDEB6h08kvIVm4=;
        b=IumkGZkSWJDueb/zYGlt9JDajQu6QorGUKFz2VK7IjDs0zhz83idNxajCe7/+ZcGIr
         kjVzgwD9ngUlQp5GdmAAeeX9oiEGpfweq8RJqzrOl+qOXWnmh/jS7u0W/lLR1KOKEP1V
         Rm7kOqLqBu79FGrmve9rM+q88jJzdzYBLM2rXiF1ejQTY6M/sjYJ0H7vf+q9bMYbCcPX
         wJKUtC6K4wZS06vncjJBoKzMxUzfWw1dMviM82WBYJyQ8CKOAgRFp21f57gKwf9g1LwE
         Tlho1nlRqmsEL5VpJMLFoWW7WITxeMRja67/oaZLMCukq/D5XGBZo1apg7xZ5Ho67Ay+
         YRUQ==
X-Gm-Message-State: AOUpUlHxlPyhGxf+PvSyYRtCuSpgCq7M3hYYtXHhwweqSImk2rWuoXV+
        SnJcl086VYsjbVVju0XKKZ0=
X-Google-Smtp-Source: AAOMgpceUDtw1FHd1odeVOd24VPR1KpQ5NjGv28VkkoVC6LaWz1qWHTFJeOLkyqe2cVLfO3qzDAQCQ==
X-Received: by 2002:adf:8ec2:: with SMTP id q60-v6mr5790925wrb.275.1532718707775;
        Fri, 27 Jul 2018 12:11:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k4-v6sm5781056wrv.4.2018.07.27.12.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 12:11:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 01/10] receive.fsck.<msg-id> tests: remove dead code
References: <20180525192811.25680-1-avarab@gmail.com>
        <20180727143720.14948-2-avarab@gmail.com>
Date:   Fri, 27 Jul 2018 12:11:46 -0700
In-Reply-To: <20180727143720.14948-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 27 Jul 2018 14:37:11 +0000")
Message-ID: <xmqqva90mr2l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Remove the setting of a receive.fsck.badDate config variable to
> "ignore". This was added in efaba7cc77 ("fsck: optionally ignore
> specific fsck issues completely", 2015-06-22) but never did anything,
> presumably it was part of some work-in-progress code that never made
> it into git.git.
>
> None of these tests will emit the "invalid author/committer line - bad
> date" warning. The dates on the commit objects we're setting up are
> not invalid.

It is a timestamp somewhere mid February of 2009.  Perhaps the code
is playing defensive against the lack of email address on the
deliberately broken author line, i.e.

    author Bugs Bunny 1234567890 +0000
    committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000

in case the parser punted and failed to parse that timestamp
correctly?  IOW, the above _could_ be a commit written by "Bugs
Bunny 1234567890" with missing e-mail and missing timestamp.

So I dunno.  It won't break the test with today's system if we
removed this config, but with an updated parser from the next year,
it may start to break.

>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t5504-fetch-receive-strict.sh | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
> index 49d3621a92..e1f8768094 100755
> --- a/t/t5504-fetch-receive-strict.sh
> +++ b/t/t5504-fetch-receive-strict.sh
> @@ -149,8 +149,6 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
>  	git --git-dir=dst/.git branch -D bogus &&
>  	git --git-dir=dst/.git config --add \
>  		receive.fsck.missingEmail ignore &&
> -	git --git-dir=dst/.git config --add \
> -		receive.fsck.badDate warn &&
>  	git push --porcelain dst bogus >act 2>&1 &&
>  	! grep "missingEmail" act
>  '
