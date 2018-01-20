Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADE081F404
	for <e@80x24.org>; Sat, 20 Jan 2018 00:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756261AbeATAPs (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 19:15:48 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35915 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752938AbeATAPq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 19:15:46 -0500
Received: by mail-qt0-f194.google.com with SMTP id z11so8044811qtm.3
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 16:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=sIQqpuEOUQ4URxUCE0rlrCfTP6jIfAVRg2JjLHm6PE8=;
        b=CvFvEoI0S1bGgx/SJhROdfoRiaWODxVpmNbFSaKU3HVPN3veIJt26cCT3ZFgpX96my
         bRD71rKtvUehJWJYjklJy/5UcUfa7CYY+GzE68ERRT+y9vQjf4chmJ0KE2ruVib3x0xp
         mg+MZwR1SY3a+w0IgTsloeQjIaYG1EmZ7jV0wGi/BSrqYSg6QX65SOwhLUezSJvU8MD6
         V1tE7GIb5HKXZGJ0G12+Wg2RN3Hfze3EKqfkxgw7w+ryFYnbjPIv0QYTysndYkaMQEgF
         Gb9qf9FkAkULmgzzIWABoh/TnR2jtKFhzmZgUOOCP1o1hdTNAomG+m8PPbMwZylH7kym
         ULcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=sIQqpuEOUQ4URxUCE0rlrCfTP6jIfAVRg2JjLHm6PE8=;
        b=ZGQB2yyaeqeNwW3FyQVQ9YCIXX0AbI04MyVPUzVjSlryF4cMMmhWIRpnuuw4THDNvE
         L7ZKstTpP7uHF3jkenaCCwIpxFtYFw4nIvxexakM3wwwiQOm01yaiAqs9ktg9TR493FQ
         FHk2Xf9Je9Rx9RZOuvaEl04ofTUSx5jstriLUR/6EAaCYGiCCrr7mRJ6jYxqRp4PX+Xm
         16O6qiBIWIfyk4PQwg18KRmFypN/2m1G00s/YD0MVjk9+uv/gnC4rqdGHrLY9unfiHMF
         ZAOwwUtZyU8YBLXz/ZW32LhyGf2nGFmlrkMOFpCJCLTt0usTtpKSbQ3KxnMnRaEL2t9R
         gKCQ==
X-Gm-Message-State: AKwxytfiHhXIz21VbYpLZ8P2fTNpDfoXy81qdv5kM/8qzF7GBlM7g6eX
        6rmKemetgAM7iWGkj8EPWOA5LgNvlAkCaLXBPLE=
X-Google-Smtp-Source: AH8x2252z95SOsENRKf6UbFAvB3ENMFoQ1tSHi09hfjKgzsAvbLkqAZhPhBA4Wi88HPrOh3TD17wJrzmfzCFFp22nNo=
X-Received: by 10.200.47.130 with SMTP id l2mr340298qta.277.1516407346010;
 Fri, 19 Jan 2018 16:15:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 19 Jan 2018 16:15:45 -0800 (PST)
In-Reply-To: <20180119223130.GC222163@genre.crustytoothpaste.net>
References: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
 <CAPig+cTkBEGyoS93GYCtoDgccTF_UixqBkVTExg7Zf0M1J7KRQ@mail.gmail.com>
 <20180119024738.GA222163@genre.crustytoothpaste.net> <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
 <20180119034025.GB222163@genre.crustytoothpaste.net> <CACsJy8BTFm_0sv=roL1OKKW=1DyU3vqD50NKyHg3KQ7G+mAepQ@mail.gmail.com>
 <20180119074001.GA55929@flurp.local> <20180119223130.GC222163@genre.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Jan 2018 19:15:45 -0500
X-Google-Sender-Auth: o5z5RUhhWCnCxXwKfPLZNa8fbFs
Message-ID: <CAPig+cQmWqQWQrRQHHn=3hn6UFzJxT=9d5kKnJht_dt8sCgwkQ@mail.gmail.com>
Subject: Re: git 2.16.0 segfaults on clone of specific repo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 5:31 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Fri, Jan 19, 2018 at 02:40:02AM -0500, Eric Sunshine wrote:
>> Nice detective work. This particular manifestation is caught by the
>> following test which fails without brian's patch on MacOS (and
>> presumably Windows) and succeeds with it. On Linux and BSD, it will of
>> course succeed always, so I'm not sure how much practical value it
>> has.
>
> I'd argue that it's a worthwhile test to have, since it will fail on
> those systems where it's going to be a problem.  Furthermore, people do
> run the tests (as does Travis) on case-insensitive file systems during
> the development cycle, so if we break something in the future, someone
> will notice while we're still in the development cycle.

Oh, I agree. My original question of its practical value was based
upon my belief that the full test suite is very rarely run on MacOS
(partly because there are so few Git developers on MacOS and partly
because it runs so slowly on the platform, though not nearly as slowly
as on Windows). However, as soon as I hit "Send", it hit me that the
problem would also manifest on Windows, and we know that Dscho runs
the tests regularly on Windows, so I changed my mind. I did consider
Travis but wasn't sure if it was testing on case-insensitive
filesystems.

Are you planning on submitting the test as a proper patch as follow-up
to [1]? I couldn't quite decide in which test script it should reside.

[1]: https://public-inbox.org/git/xmqqr2qlps7r.fsf@gitster.mtv.corp.google.com/
