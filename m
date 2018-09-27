Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3D201F453
	for <e@80x24.org>; Thu, 27 Sep 2018 15:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeI0VoD (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 17:44:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53372 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeI0VoC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 17:44:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so6351957wme.3
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XFnv5CL3vW5T3WY0hFK6KtUV6fUaZMigMTYdD637QiA=;
        b=etkOsNvOEUgQ9kVsRAkQs5k+rZHuxl+Xz0weuWdKxUmu5c0i0ohDW03T4AfkluMEjO
         69hstdWoBlFF3gx898zZE1Spw590ZL+us9Tg0Splqc8XGuxu5HA2UmT7YaxLeuOg+ZTt
         uCmdLd8yq/ytwgyKRoKYBhtQ+KkNaX3qHx+Yvq5vUQoanRzOhny4wb7cstIP/dlplX1E
         7iFNYeKQMV2N+VmPHTI4yuJRNGhwS8luDrcCid4t/6kFPar/WdJGUp5fG8BP9BvQCMXI
         /H2eHPQaMgHaPCG8BD+6dq+sl075+635+WQo8pfvpg0wr02KF2kkyBuo6yQ6F0V7pfYK
         +EBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XFnv5CL3vW5T3WY0hFK6KtUV6fUaZMigMTYdD637QiA=;
        b=dzL19jBXEJqt36H3RbgeitTFsho/M35LsXERJ9R55uFfCCNUUaTanFhetVw+LBYq3+
         Qi9lATW6DBa7UWOqX296mXWQabZ7ID/Gm9LqWo/dj8Cf7FnZgqZqtYrLDVKFFi/Q1cwb
         ClRQwuJtytihH9aKYfiW/CsyZxerfMUijvIGCI/36sKJpYPEGe/zEH7+l3n1L5H083qz
         bbX9Kq3CLjnwCTlS/ZPGrdRxprYtOic0j+KHWQG7g9PXkLsYvssPMydyz3ahacCMwiJN
         pu8yni8dSGB65/fvHqiYk5s7cwttB/0YsOCuF1jMObAb8LUx47l4unHSxYV2zdnKcl+c
         Wtqg==
X-Gm-Message-State: ABuFfojhgAHP26wW/gIdwTUJgkEwGFw3M1j7HoGY91CURQj7TEDfrynr
        WBhjViF1N/zn2kCyfu4zUJUU9S4Udxw=
X-Google-Smtp-Source: ACcGV60u6AqMyP038B3F750xwuMX7tFMmBTLSRvC4lfWhhhafMW5+lBgQiGy+cUhkZrScQcoPaQ8Fw==
X-Received: by 2002:a1c:2bc3:: with SMTP id r186-v6mr8522585wmr.71.1538061914396;
        Thu, 27 Sep 2018 08:25:14 -0700 (PDT)
Received: from evledraar (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id 64-v6sm3219715wrr.64.2018.09.27.08.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 08:25:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Fix the racy split index problem
References: <20180927124434.30835-1-szeder.dev@gmail.com> <871s9fjbcb.fsf@evledraar.gmail.com> <20180927142336.GJ27036@localhost>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180927142336.GJ27036@localhost>
Date:   Thu, 27 Sep 2018 17:25:12 +0200
Message-ID: <87zhw3hsiv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 27 2018, SZEDER Gábor wrote:

> On Thu, Sep 27, 2018 at 03:53:24PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Thu, Sep 27 2018, SZEDER Gábor wrote:
>>
>> > This is the second attempt to fix the racy split index problem, which
>> > causes occasional failures in several random test scripts when run
>> > with 'GIT_TEST_SPLIT_INDEX=yes'.  The important details are in patches
>> > 1 and 5 (corresponding to v1's 3 and 5).
>>
>> Thanks. I'm running the same sorts of tests I noted in
>> https://public-inbox.org/git/87va7ireuu.fsf@evledraar.gmail.com/ on
>> this. The fix Jeff had that you noted in
>> https://public-inbox.org/git/20180906151439.GA8016@localhost/ is now in
>> "master".
>>
>> I take it your
>> https://github.com/szeder/git/commits/racy-split-index-fix is the same
>> as this submission?
>
> Yes.
>
>> Anyway, I'm testing that cherry-picked on top of the
>> latest master.
>>
>> Unfortunate that we couldn't get the isolated test you made in
>> https://public-inbox.org/git/20180907034942.GA10370@localhost/
>
> Nah, that's not an isolated test case, that's only a somewhat
> narrowed-down, but rather reliable reproduction recipe while I still
> had no idea what was going on :)
>
> The _real_ isolated test is the last test in t1701, that's what it
> eventually boiled down to.

Thanks. I had ~400 runs of the tests I ran before and they were all
OK. Now trying also with t1701 (which I hadn't noticed was a new
test...).


>> but I
>> don't see how it could be added without some very liberal
>> getenv("GIT_TEST_blahblah"), so it's probably best to not add it,
>> particularly with the C rewrite of git-stash in-flight.
>>
>> I'll report back when I have enough test data to say how these patches
>> affect the intermittent test failures under GIT_TEST_SPLIT_INDEX=yes.
