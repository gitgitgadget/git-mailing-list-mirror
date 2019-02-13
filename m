Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFA531F453
	for <e@80x24.org>; Wed, 13 Feb 2019 20:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfBMUqH (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 15:46:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41992 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfBMUqH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 15:46:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so4049124wrx.9
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 12:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XCjUPbgjK9c40/8WoEiAJ1x0ujjQWuljAUvy/8KuI3A=;
        b=awahLtweufo0aKIhoo4cGawBF4G46htT/TJTb84T0BHaZdRHOp20qhXJjjZ+i4FOYa
         8SRzyirxRLgQqBkjbamK24mBa0cDC2Cav7yFeZZsjmDzg3sWZ1l0B3vH1733NZAbcYUh
         Y/BMXnnHMZ+0cZYbhMuUgEkSp5v213oY5u92gp27JzQXOOpeXT6zvG3zdRdzpdBTTEqH
         3QT2u0xDGddG6KE2M36ah3uouQ2V7B8NWK6neMlV4EVKXtRjLyTfDONlPs0sDbXqr5ZT
         BhO/ui+aavpuvdGNgAkmkcZz58G8dM9gbfPsOBphp4Nobw02ExzejocfejDIeinLxXWG
         NzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=XCjUPbgjK9c40/8WoEiAJ1x0ujjQWuljAUvy/8KuI3A=;
        b=TAMl58Eb5e16yM5VEtQZtS4ZBbnu12juWzodeXRWC0m2CKrXEZVI3vY2+Y6E6NStNQ
         /B424HQ/NNqxqsfW/vhzAMr2FlidELx6hCW0Iiyv2lLrWCcFb+F0qIfAwz447biv2yfZ
         uSztmO6dAvdI/wtlXCRH02ilDlDbSBdwcG5QkR4ciuAVvvXR9SwT7DNVVjJFyJoLgKIP
         2Ga70z+bQAttDTdyd+B2zSkvK81UUc5t5y0GT4UHk0Cz5DkoRCtjIAtMK9qiZRcitump
         3vcUqd0Yu3cw6DAz8kIOj0jPmGTicW+f426X9deY/PucC08nJtdKclyIkYaMsarXtYfS
         zacg==
X-Gm-Message-State: AHQUAuYRZKhWQ4lvLaoOEorb6aWPm7y1iVeiQbn1EwvwMdZlgD7OHQZO
        Lox9toJmmPOBMkFgscfOnvo=
X-Google-Smtp-Source: AHgI3IZ61sQkoh6ak1BIoBLohTb4xIXAi6TuwXCgH9lIbfgded6LxAPRzZPCmk3NvisayJW6zBft9A==
X-Received: by 2002:adf:fd07:: with SMTP id e7mr25957wrr.175.1550090765124;
        Wed, 13 Feb 2019 12:46:05 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w23sm441721wmc.38.2019.02.13.12.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 12:46:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase: remove the rebase.useBuiltin setting
References: <87ftsrke6r.fsf@evledraar.gmail.com>
        <20190213142209.8226-1-avarab@gmail.com>
Date:   Wed, 13 Feb 2019 12:46:03 -0800
In-Reply-To: <20190213142209.8226-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 13 Feb 2019 15:22:09 +0100")
Message-ID: <xmqqva1nbeno.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Remove the rebase.useBuiltin setting, which was added as an escape
> hatch to disable the builtin version of rebase first released with Git
> 2.20.
> ...
>> This patch breaks the test suite (with these two new tests) under
>> GIT_TEST_REBASE_USE_BUILTIN=false. So a 2.21.0-rc0 regression.
>>
>> It would have been better to raise this before the rc period, but I just
>> noticed this now, but we can now:
>>
>>  1. Skip the test under that mode
>>  2. Fix the shell code to do the same thing
>>  3. Just remove the shell code & GIT_TEST_REBASE_USE_BUILTIN=false mode
>>
>> Maybe we should just do #3. The reason for the escape hatch was in case
>> we had bugs, and now we've had a full release cycle, but maybe that's
>> too early...

If a new feature is added to the built-in version, I do not think it
is a good use of our time to backport it to the scripted version, if
only to make the USE_BUILTIN=false test pass, especially when the
problematic thing is a fringe feature, lack of which would not
affect the real users too much.

So I do agree that #2 is a bad choice.

However, it is way too late in the cycle to say that we will ship
without the escape hatch for the upcoming release, so #3 is a non
starter.  And you are reading too much into a full release cycle,
which is merely less than 1k commits and a bit short of 3 months.

It would however be long enough to declare victory _immediately
after_ the upcoming release and start the next cycle without the
escape hatch.  At that point we'd be committed to maintain only the
built-in version.

The more important every-day features should still be covered by
tests, if the scripted ones are to be kept as escape hatch.  So to
me #1 looks like the only sensible choice at this point, if you want
to see a test cycle with USE_BUILTIN=false to fully pass (i.e. by
skipping the ones that are known not to pass).

