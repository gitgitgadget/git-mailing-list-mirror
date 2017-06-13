Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6D31FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 19:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753801AbdFMTtR (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 15:49:17 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:35840 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbdFMTtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 15:49:16 -0400
Received: by mail-ot0-f179.google.com with SMTP id s7so2861154otb.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 12:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uOhaM2xUa6rF8cMjTv1K1Moh2OhWVhUEk5G16nld178=;
        b=srx+es/hx6zNIAmOBEjU7m658CK9WJW49o/aEY/Bqe2gLzhzr8S3l82GfJg9Dn7zEM
         q1n55C1g3W0y2poqd5FIpK09j524vKOngxckF3YwqSDGsIqH3WEMGP3zcKuIbFlHSkN9
         SgRN4uiE0du6YhPSPtSAGT++Z740xFi9PrDXYzGg/RM09wYBUlh0gU4RlWo7XbNdqrnZ
         OUp2i2EZtttg5N2GkmX9O7Pjeece7s94OzGEeClXy/RQCd35qXVBCj8CPnl78nQvlH5m
         rqXGyOgs6V9rv7b9wJLtQK6Iwrhqq1JMI3eUwYSXo7e+2c3oJH1zHKcgjaHdnwzQtPUW
         dkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=uOhaM2xUa6rF8cMjTv1K1Moh2OhWVhUEk5G16nld178=;
        b=ppwxfYrQ0LB5Kc/EvJ2TzOJYOoHEjJuvK2mAa/4iQLjq3VWXzistkMGS0NX9RgjDuv
         58hEAWeb5p8BjI2EhPJL9yVIvdxCY00HDHCCoYYzXztTII8eqTXuuU+96qafDLcLKHBk
         dMdqqB1Misj4BXEFdi2VSK5r6hG34gDSJ3mn+lJKbKAuQLP2JI2yBWbmiK9mGkupZWv1
         yE4P5lO19uTvWcMiQUWuypyBaMTH6Ak7f8lZRMo9vupAEPFaz7/pAfvYTGpcEWfIAGR7
         OsIZButbhg363EatDTme0IoADAs37X79+6YFwqIJgzrboJCWc8TlqaE8Q80XYv9rZxG4
         rhHA==
X-Gm-Message-State: AKS2vOzauXX6YBCSVWSDEVwJax/lPrH+oz1+f/NZ7Dq/ItyMoLarOXeo
        tq7v7Lqkbpg5LZLyEKnWM/YsF715xQ==
X-Received: by 10.157.60.119 with SMTP id j52mr1198907ote.31.1497383355305;
 Tue, 13 Jun 2017 12:49:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.51.169 with HTTP; Tue, 13 Jun 2017 12:48:54 -0700 (PDT)
In-Reply-To: <xmqqa85b65a8.fsf@gitster.mtv.corp.google.com>
References: <20170608005535.13080-1-joel@teichroeb.net> <20170608005535.13080-4-joel@teichroeb.net>
 <xmqqa85b65a8.fsf@gitster.mtv.corp.google.com>
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Tue, 13 Jun 2017 12:48:54 -0700
X-Google-Sender-Auth: DofenZ5e_U7LfBzFFB9yrnVk2HU
Message-ID: <CA+CzEk8U6P58OqruPkP1HePFurNWjgf=Q-h=Hu57zoHpDeenmA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] stash: add test for stashing in a detached state
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 12:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Joel Teichroeb <joel@teichroeb.net> writes:
>
>> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
>> ---
>>  t/t3903-stash.sh | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
>> index 5399fb05ca..ce4c8fe3d6 100755
>> --- a/t/t3903-stash.sh
>> +++ b/t/t3903-stash.sh
>> @@ -822,6 +822,18 @@ test_expect_success 'create with multiple arguments for the message' '
>>       test_cmp expect actual
>>  '
>>
>> +test_expect_success 'create in a detached state' '
>> +     test_when_finished "git checkout master" &&
>> +     git checkout HEAD~1 &&
>> +     >foo &&
>> +     git add foo &&
>> +     STASH_ID=$(git stash create) &&
>> +     HEAD_ID=$(git rev-parse --short HEAD) &&
>> +     echo "WIP on (no branch): ${HEAD_ID} initial" >expect &&
>> +     git show --pretty=%s -s ${STASH_ID} >actual &&
>> +     test_cmp expect actual
>> +'
>
> Hmph.  Is the title automatically given to the stash the
> only/primary thing that is of interest to us in this test?  I think
> we care more about that we record the right thing in the resulting
> stash and also after creating the stash the working tree and the
> index becomes clean.  Shouldn't we be testing that?

In this case, the title is really what I wanted to test. There are
other tests already to make sure that stash create works, but there
were no tests to ensure that a stash was created with the correct
title when not on a branch. That being said though, I'll add more
validation as more validation is always better.

>
> If "git stash create" fails to make the working tree and the index
> clean, then "git checkout master" run by when-finished will carry
> the local modifications with us, which probably is not what you
> meant.  You'd need "reset --hard" there, too, perhaps?

Agreed.

>
>>  test_expect_success 'stash -- <pathspec> stashes and restores the file' '
>>       >foo &&
>>       >bar &&
