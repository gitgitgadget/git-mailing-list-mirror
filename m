Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 571881F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbeAYXGw (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:06:52 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:46315 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbeAYXGu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:06:50 -0500
Received: by mail-wm0-f67.google.com with SMTP id 143so17648328wma.5
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=f89c7FrWI2kMKfAtp46mv3OTXqa/mYfYbTQw0HHBNn4=;
        b=Uc/mpP7xQJT3ujzQjxpMFK1SqsT9bi0nqAT9oMH7HrPsDPVPYNuBq3+FR0BOlZfUHF
         W6lDR8BxVW8/AOZzqAYAg3tCDaKZjKmfKFA7FJxbZREG81E4wW/FgI/J68f0C0iA2s08
         HMQNZ9FF7jdgdwGLkltjoc2mnXk2YIA8ST+HHyROsF+J91ATTP6WsJJy0JxyjotVEbDb
         lxxDXhI2FNN9AnYD3wzn6wbkYmvBGNGpVT1jhM5iMs+SlHkFItvklAjJQ0262OWddxD9
         JP5Vy0Fs5f4QtpihBu/pG/7Vs272VrWurHqqb4NuOAdsyGJ4ljZsCPNmQ6ps7zKwKlzD
         +/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=f89c7FrWI2kMKfAtp46mv3OTXqa/mYfYbTQw0HHBNn4=;
        b=TePAtGaMj4LNPYvqbkmRaUYIvvCR4MBzdjg83Gxifz43emxCUDAWAhBA+TZg5rkCqU
         Q2SyIupMt4Rb0tCvz578ySjUg+KPkuLv9EB+YMpgPadvEkU3zibA+Bu1VI6pGEBhaVdg
         rv8ip93JjVpoNJFxVvSs/mXO4uX4WTzq2CPFL5C/Nsczq82Tm1Hbbto+tOZqa7nV3PWJ
         opESk8xdoCdlOcTWqhyjh3gntN1B0NS2bwk0BgSLMZ3VZrqISXzteB6tvtHrBPrD2wsH
         wKs32JiX6+Lxip9ga3t7j3qA3XKSub3oh9ZaqJrA9+mwpNHj/22E0fTFqlep567unwWk
         PJJg==
X-Gm-Message-State: AKwxytc53kvUDJACECsQK9QlN1z0ferDRmi4iCH+qRr/4NWSnooRHon2
        HFfsYarKn0LKvFN378iMtJo=
X-Google-Smtp-Source: AH8x225D7m7F5/hlU1GKpyWeGZor2W0cYg935plpnkCvUBQQ9D85SQ6HCq/fRZ8UilUQ3ozW/7t6Pw==
X-Received: by 10.80.132.170 with SMTP id 39mr30540018edq.231.1516921609695;
        Thu, 25 Jan 2018 15:06:49 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id p57sm1788801edc.33.2018.01.25.15.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jan 2018 15:06:48 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH 00/14] Serialized Commit Graph
References: <20180125140231.65604-1-dstolee@microsoft.com> <871siex7pc.fsf@evledraar.gmail.com> <fe9d20da-eb70-d725-0530-cab1c029a0c8@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <fe9d20da-eb70-d725-0530-cab1c029a0c8@gmail.com>
Date:   Fri, 26 Jan 2018 00:06:47 +0100
Message-ID: <87wp05wnaw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 25 2018, Derrick Stolee jotted:

> On 1/25/2018 10:46 AM, Ævar Arnfjörð Bjarmason wrote:
>> On Thu, Jan 25 2018, Derrick Stolee jotted:
>>
>>> * 'git log --topo-order -1000' walks all reachable commits to avoid
>>>    incorrect topological orders, but only needs the commit message for
>>>    the top 1000 commits.
>>>
>>> * 'git merge-base <A> <B>' may walk many commits to find the correct
>>>    boundary between the commits reachable from A and those reachable
>>>    from B. No commit messages are needed.
>>>
>>> * 'git branch -vv' checks ahead/behind status for all local branches
>>>    compared to their upstream remote branches. This is essentially as
>>>    hard as computing merge bases for each.
>> This is great, spotted / questions so far:
>>
>> * git graph --blah says you need to enable the config, should say
>>    "unknown option --blah <help>". I.e. overzelous config guard.
>
> This is a good point.
>
>> * On a big repo (git show-ref -s | ~/g/git/git-graph --write
>>    --update-head) is as of writing this still hanging for me, but strace
>>    shows it's brk()-ing. Presumably just still busy, a progress bar would
>>    be very nice.
>
> Oops! This is my mistake. The correct command should be:
>
>  git show-ref -s | git graph --write --update-head --stdin-commits
>
> Without "--stdin-commits" the command will walk all packed objects
> to look for commits and then build the graph. That's why it's taking
> so long. That method takes several minutes on the Linux repo, but with
> --stdin-commits it should take as long as "git log >/dev/null".

Thanks, it took around 15m to finish with the command I initially ran on
my test repo.

Then the `merge-base --is-ancestor` performance problem I was
complaining about in
https://public-inbox.org/git/87608bawoa.fsf@evledraar.gmail.com/ takes
around 1s with your series, 5s without it. Nice.
