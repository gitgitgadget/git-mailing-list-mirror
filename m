Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB0521F42E
	for <e@80x24.org>; Fri,  4 May 2018 07:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeEDHyK (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 03:54:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50483 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeEDHyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 03:54:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id t11so2630899wmt.0
        for <git@vger.kernel.org>; Fri, 04 May 2018 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jzzenz8LKIPR4IB78SNX6BiAW4/2rOkHQ8AywVt4gGU=;
        b=oJsTQ56cKbR84W+IY7Uj029TpL3iqydQzL1I77Q3NcgaWpGHQ9L10IOZeW+wGP99B6
         VYoM8FZSE2CZaw9Tfe0ykH60lRESjGRGC69rE8h9C7+iRdoh6z2SVO1oROfPrB/rvXZj
         oIAcjzisSkyFyG2Jczs2CTQe2jLFWQMXkN1FL0rocTWL3zBFSvKy9YcyMJx6r4MPAZTV
         FMN/pCjkhiZBj/5V3fXoN1VECZYfcoj4NYFcSSqEa94UnCzuHv8BeBQgFXRol9pz4iBL
         /mIij9K54MGwHlepN3/zWpIqLmnofBRki4hBIqLJzdtkoLD+k3z0hmUrxEuGykOGKcsg
         dPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=jzzenz8LKIPR4IB78SNX6BiAW4/2rOkHQ8AywVt4gGU=;
        b=N9kBkiOdsTgsU+e1onUcAV/gCDj+MWepftdc/Cq7p7HKam4Eh5B6uJyvTnxB5MngpE
         GkftOYVLrK6E2jvk6CVQC9faXI/q2OMvZam7/aVSxIE6sg7tMtN4/l3hPplna1lKOPJ6
         8EpJXev14kynwcQCi3155RYsgIULMHXm6FEiY483olED12v2Y78XVaJvsp6aowWIqZrA
         q2ZuuEnZAA1VT5xFkfNrPPPghwXuqMZLbqePwHZIg5Wo5mL6yf4lYf8OyMzElRemN6gK
         DGEHu4A1Jug6PJEqpDNpE/HWoWbDZ53tc5yJ3VeGxEnkGO73HH1kjc/Iye3fejksEWSD
         8ZNQ==
X-Gm-Message-State: ALQs6tBlJF9rU0aGkeQyrbWxW5BXSIEwkVh2612RqSuRIqW1Hy17pLN1
        zxxyE7CYqUuKUI/vz3pn7WLAoBqf
X-Google-Smtp-Source: AB8JxZrEPytbUMjDsrXE+uypq6jug7fa0aXuRHH7aBE9bxOVOAcvQ4TmChmuX20GSOhLJ5tSeVT+Bg==
X-Received: by 2002:a50:ae86:: with SMTP id e6-v6mr34979222edd.285.1525420447999;
        Fri, 04 May 2018 00:54:07 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id f16-v6sm8809525edr.32.2018.05.04.00.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 May 2018 00:54:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] checkout & worktree: introduce checkout.implicitRemote
References: <87y3h1ykwn.fsf@evledraar.gmail.com>
        <20180503131840.27956-1-avarab@gmail.com>
        <CACsJy8CYp3zVSRtS5ozHCitnWU81AamqEGR8RZdDkwujShEatw@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8CYp3zVSRtS5ozHCitnWU81AamqEGR8RZdDkwujShEatw@mail.gmail.com>
Date:   Fri, 04 May 2018 09:54:06 +0200
Message-ID: <87muxfyhy9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 03 2018, Duy Nguyen wrote:

> On Thu, May 3, 2018 at 3:18 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> Introduce a checkout.implicitRemote setting which can be used to
>> designate a remote to prefer (via checkout.implicitRemote=origin) when
>> running e.g. "git checkout master" to mean origin/master, even though
>> there's other remotes that have the "master" branch.
>>
>> I want this because it's very handy to use this workflow to checkout a
>> repository and create a topic branch, then get back to a "master" as
>> retrieved from upstream:
>>
>>     (
>>         rm -rf /tmp/tbdiff &&
>>         git clone git@github.com:trast/tbdiff.git &&
>>         cd tbdiff &&
>>         git branch -m topic &&
>>         git checkout master
>>     )
>>
>> That will output:
>>
>>     Branch 'master' set up to track remote branch 'master' from 'origin'.
>>     Switched to a new branch 'master'
>>
>> But as soon as a new remote is added (e.g. just to inspect something
>> from someone else) the DWIMery goes away:
>>
>>     (
>>         rm -rf /tmp/tbdiff &&
>>         git clone git@github.com:trast/tbdiff.git &&
>>         cd tbdiff &&
>>         git branch -m topic &&
>>         git remote add avar git@github.com:avar/tbdiff.git &&
>>         git fetch avar &&
>>         git checkout master
>>     )
>>
>> Will output:
>>
>>     error: pathspec 'master' did not match any file(s) known to git.
>>
>> The new checkout.implicitRemote config allows me to say that whenever
>> that ambiguity comes up I'd like to prefer "origin", and it'll still
>> work as though the only remote I had was "origin".
>>
>> I considered splitting this into checkout.implicitRemote and
>> worktree.implicitRemote, but it's probably less confusing to break our
>> own rules that anything shared between config should live in core.*
>> than have two config settings, and I couldn't come up with a short
>> name under core.* that made sense (core.implicitRemoteForCheckout?).
>
> I wonder if it's difficult to add a dwim hook that allows us to
> replace the entire dwim logic with a hook? Doing this "preferring
> origin" in a shell script should be easy and it lets us play more with
> tweaking dwim logic. (Yeah sorry I'm getting off topic again)

Realistically the way we do hooks now would make the UI of this suck,
i.e. you couldn't configure it globally or system-wide easily. Something
like what I noted in
https://public-inbox.org/git/871sf3el01.fsf@evledraar.gmail.com/ would
make it suck less, but that's a much bigger task.

I think for now this is a common enough case users run into that it
makes sense to add it to the code, and if we ever do have more
extensible hook features in the future we can just go and replace
various options like these to use them.
