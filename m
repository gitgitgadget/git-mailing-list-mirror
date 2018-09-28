Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3DC41F453
	for <e@80x24.org>; Fri, 28 Sep 2018 06:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeI1NUO (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 09:20:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41717 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeI1NUN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 09:20:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id f38-v6so7199327edd.8
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 23:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Io2Xr9fPJgHunyZJwAvDkxwLuP6Ch5ymJnLlsWKqezU=;
        b=K92YsrNZNnm4U0waLUOxcDuYvG7ElwJb4Qgv4p8/fijulFW8sDROzxY+/PYyY/cNlj
         By8TVQKNLbvVnMG8f97NBsoO9KLD7ywg5aYwuulJpuLsd18nDZVWW909571xsAl7l2Ku
         oGa0TWAio47YK+s6uEn9l0cj5I4lhQl97emIUohJZFBeBILI2y5LUGMaPokmDliVjw1A
         2Gjs/vsdWWn3dsbUdXLJWc4fKa2cQg+bn3Y9mhXeIR4u6pAR3f60zeKHrn2fgJipQqeU
         ZzlLH4FJXkgklZ8U/yK+kmFfVlNcxAxrtayq9myzJVxhVq5hTUHVCPnk/o2zHe2rxsor
         HaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Io2Xr9fPJgHunyZJwAvDkxwLuP6Ch5ymJnLlsWKqezU=;
        b=RlGYWvOHw8SuknUuKapZhr818wL5/0dJ/96v5+Um/fZpKKk4dlzHGM61DImlSDwntM
         /N2NHkLDPa755ALg2kn/41rm1cesNdWrxqXf4ANfq9Ok5SGAZkso4WPk2kiAz7HcqzjB
         TtMjIvECOMSlp10KLv8PkFRIlWSh/gt7UZGMn9WTXsWW4F+lRkyFUgdVue3EiHvutK9q
         LVS04SN0Lmv+b/NpVP//kxMe9DMcf6DdV4Jue9X/WH5TbpBsRAJYmFdP+74PeIQKhMZQ
         AE24wQiDTMRlNmh4YtFGom6cMnmyyqc4M8EAl9Pw7Opxts9vytekcAud2VhRUtqpbXpw
         QMkw==
X-Gm-Message-State: ABuFfoiN2cpBl9uIOCYocTN4yEBXtIfqvGJORsXJ9Io29rc14V17Q4TI
        SVaSKO+AwpsnfV4RvplVU0DV/vwQy9o=
X-Google-Smtp-Source: ACcGV62tH7D8FUXF8vyPtXUP6IXrO8joBwNND/pfyktHPHJO+Owx3GOGXiHpTnyqIsrwVQDTwPTBSg==
X-Received: by 2002:a17:906:35d2:: with SMTP id p18-v6mr1086765ejb.6.1538117875316;
        Thu, 27 Sep 2018 23:57:55 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id t44-v6sm2118802edd.96.2018.09.27.23.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 23:57:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Fix the racy split index problem
References: <20180927124434.30835-1-szeder.dev@gmail.com> <871s9fjbcb.fsf@evledraar.gmail.com> <20180927142336.GJ27036@localhost> <87zhw3hsiv.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87zhw3hsiv.fsf@evledraar.gmail.com>
Date:   Fri, 28 Sep 2018 08:57:53 +0200
Message-ID: <87k1n6hzwu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 27 2018, Ævar Arnfjörð Bjarmason wrote:

> On Thu, Sep 27 2018, SZEDER Gábor wrote:
>
>> On Thu, Sep 27, 2018 at 03:53:24PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Thu, Sep 27 2018, SZEDER Gábor wrote:
>>>
>>> > This is the second attempt to fix the racy split index problem, which
>>> > causes occasional failures in several random test scripts when run
>>> > with 'GIT_TEST_SPLIT_INDEX=yes'.  The important details are in patches
>>> > 1 and 5 (corresponding to v1's 3 and 5).
>>>
>>> Thanks. I'm running the same sorts of tests I noted in
>>> https://public-inbox.org/git/87va7ireuu.fsf@evledraar.gmail.com/ on
>>> this. The fix Jeff had that you noted in
>>> https://public-inbox.org/git/20180906151439.GA8016@localhost/ is now in
>>> "master".
>>>
>>> I take it your
>>> https://github.com/szeder/git/commits/racy-split-index-fix is the same
>>> as this submission?
>>
>> Yes.
>>
>>> Anyway, I'm testing that cherry-picked on top of the
>>> latest master.
>>>
>>> Unfortunate that we couldn't get the isolated test you made in
>>> https://public-inbox.org/git/20180907034942.GA10370@localhost/
>>
>> Nah, that's not an isolated test case, that's only a somewhat
>> narrowed-down, but rather reliable reproduction recipe while I still
>> had no idea what was going on :)
>>
>> The _real_ isolated test is the last test in t1701, that's what it
>> eventually boiled down to.
>
> Thanks. I had ~400 runs of the tests I ran before and they were all
> OK. Now trying also with t1701 (which I hadn't noticed was a new
> test...).

Ran that overnight with the same conditions as before. 2683 OK runs and
0 failures (and counting). So it seems like the combination of the two
fixed the split index bugs.

>>> but I
>>> don't see how it could be added without some very liberal
>>> getenv("GIT_TEST_blahblah"), so it's probably best to not add it,
>>> particularly with the C rewrite of git-stash in-flight.
>>>
>>> I'll report back when I have enough test data to say how these patches
>>> affect the intermittent test failures under GIT_TEST_SPLIT_INDEX=yes.
