Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24D01F51C
	for <e@80x24.org>; Mon, 21 May 2018 22:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752979AbeEUW2h (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 18:28:37 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35683 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752817AbeEUW2c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 18:28:32 -0400
Received: by mail-yw0-f176.google.com with SMTP id m8-v6so4964626ywd.2
        for <git@vger.kernel.org>; Mon, 21 May 2018 15:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M9snEY8e4JF8tzei0I/suK4ZJZJEH7N2xpSmuQXFtN0=;
        b=B81q1mE5MB3bTCrg1LKM0xKTANHFjhRpf6sXROKWqcvR5z2BnlRY6j6eg+/BKmzyPM
         TRX4kP3QiJaJwkBd8sTR9b0Da1PPzf62hp1U2k111IT28cgIsEKQAYJjLiC9XGn1c9Ac
         E9TC7ZDXbCZ5rCDouRpFPIVf9Evb4uL0tVaFgyhCHOVSTBfUNrpYCXYXUpdAE4ocju8+
         E+K+OpPNJFg6hlGPasmE2I5Ba3xGRMAyI5rrtIDSMZXYW/LuZ90s4xym3PkcxP+06pN1
         NH3SS5TLjo5WLPtd2xs8h1dYidHGz7O08ZesPafKRTT9mPDy7h/jcjwtVPOTd7enDGQW
         lUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M9snEY8e4JF8tzei0I/suK4ZJZJEH7N2xpSmuQXFtN0=;
        b=ufY9enlR1uQBJCyFCWFIK7sGoOsNCyv5WRVMV6YcmwL3PuMhC2XhkB7CvB2kInHkQq
         ynV4MyHVQyY1SpjL3iljqkZuLVptBvt1Mc5yjBpBiPF4uEg9hCDUpH2mJ9B3czAXT4ch
         UzHLcYQN5tFWreLDDrzs8a0Mzvmx1iM5YUzo4uxacIFW9V48l9lD1tCqsd2yXVb30LGO
         6KetYN0Ij/p+btjQIANM4RmwVnctB7z16vTpGaEuc+/PWzBmFRtSLuiOdZFNKO2S9vfM
         nXAiDzWmrFIf9BohqQ6yeMehbuC03hM5HSUYBZSUV4WU35+0MnFeFwhH6SzDIC5v0R08
         GU6A==
X-Gm-Message-State: ALKqPwdZvn7jJlKAKL+8fvUnavYE/aA/D9+aBSe3Ts/FRcpRmxb+fjfY
        fZEJRILus1wfs8LBix9rm1Yc5bb0n7R947zcht6sLA==
X-Google-Smtp-Source: AB8JxZok5tJeOLDjYQ2n3n2c/rKMVFBDtnl5R1QIHBsJek3KD1za2Asgn6dchsugPucaATuFak/2K8JunGHPSS8Veio=
X-Received: by 2002:a0d:fd84:: with SMTP id n126-v6mr10988578ywf.33.1526941711480;
 Mon, 21 May 2018 15:28:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Mon, 21 May 2018 15:28:30 -0700 (PDT)
In-Reply-To: <20180521215046.GA16623@sigill.intra.peff.net>
References: <e78a115a-a5ea-3c0a-5437-51ba0bcc56e1@gmail.com>
 <CABPp-BFEd+fK_i3qoYWudYS5mhWE1jsXR_xcSCZoJ=4Vd61LAQ@mail.gmail.com> <20180521215046.GA16623@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 May 2018 15:28:30 -0700
Message-ID: <CAGZ79kb_eUas+7MtSm3KDyY=3sB4h=Z422nTyWaOoh4=UN72zA@mail.gmail.com>
Subject: Re: commit-graph: change in "best" merge-base when ambiguous
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 2:50 PM, Jeff King <peff@peff.net> wrote:
> On Mon, May 21, 2018 at 11:33:11AM -0700, Elijah Newren wrote:
>
>> > In t6024-recursive-merge.sh, we have the following commit structure:
>> >
>> >     # 1 - A - D - F
>> >     #   \   X   /
>> >     #     B   X
>> >     #       X   \
>> >     # 2 - C - E - G
>> >
>> > When merging F to G, there are two "best" merge-bases, A and C. With
>> > core.commitGraph=false, 'git merge-base F G' returns A, while it returns C
>> > when core.commitGraph=true. This is due to the new walk order when using
>> > generation numbers, although I have not dug deep into the code to point out
>> > exactly where the choice between A and C is made. Likely it's just whatever
>> > order they are inserted into a list.
>>
>> Ooh, interesting.
>>
>> Just a guess, but could it be related to relative ordering of
>> committer timestamps?  Ordering of committer timestamps apparently
>> affects order of merge-bases returned to merge-recursive, and although
>> that shouldn't have mattered, a few bugs meant that it did and the
>> order ended up determining what contents a successful merge would
>> have.  See this recent post:
>>
>> https://public-inbox.org/git/CABPp-BFc1OLYKzS5rauOehvEugPc0oGMJp-NMEAmVMW7QR=4Eg@mail.gmail.com/
>>
>> The fact that the merge was successful for both orderings of merge
>> bases was the real bug, though; it should have detected and reported a
>> conflict both ways.
>
> Traditionally we've inserted commits into the walk queue in commit-date
> ordering, but with identical dates it may depend on the order in which
> you reach the commits. Many of the tests are particularly bad for
> showing this off because they do not use test_tick, and so you end up
> with a bunch of commits with identical timestamps.
>
> If we're just using generation numbers for queue ordering, we're even
> more likely to hit these cases, since they're expected to increase along
> parallel branches at roughly the same rate. It's probably a good idea to
> have some tie-breakers to make things more deterministic (walk order
> shouldn't matter, but it can be confusing if we sometimes use one order
> and sometimes the other).
>
> Even ordering by {generation, timestamp} isn't quite enough, since you
> could still tie there. Perhaps {generation, timestamp, hash} would be a
> sensible ordering?

The hash sounds reasonable as the definite tie breaker.

git merge-base is documented as "Find as good common ancestors
as possible for a merge", so in case we do not require the tie
breaking to be cheap, we could go by "smallest diff output"
of the two diffs against the potential merge commit.

Though I don't think this is really optimal for performance reasons.
