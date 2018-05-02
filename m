Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5E6921841
	for <e@80x24.org>; Wed,  2 May 2018 07:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeEBH5x (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 03:57:53 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36006 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbeEBH5w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 03:57:52 -0400
Received: by mail-wr0-f172.google.com with SMTP id f2-v6so1107418wrm.3
        for <git@vger.kernel.org>; Wed, 02 May 2018 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7wEwSG2Cw01aqLI5TszEXeJI9PUhDtJj3ISR/ZA6SC4=;
        b=lj1c0RngAKRO650/qK+Fk0IMkrIsC6hn0fB8R9Y9Sm8FgGKaw6P3UoATwvXEzFq69f
         L3Sz/YLkxVXD3GKto2qU+S5Hny+Rpv542cguqC/dPq5bVB+3IVL4v+lEo5TUl97ISBee
         dB5AiFmBwJmcjEZsduZ2bUmYoJMmPUlEuYAJ7fzBP8KzpuR+iA3OxR4tl4l1EBoyy46o
         vJy+EJdIibSPlzWXK6m/GxjRAi1fNxi6iCSxg/lWRyfp/P5Cr7pNh1ysAb/07O5zlRrD
         o4Pg31Aj5VBKlpEK4LmjVi8pApK71SxWrF1sFQYw8zLW4QlvWaGjZzotUhjtRsmg0E2H
         EZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=7wEwSG2Cw01aqLI5TszEXeJI9PUhDtJj3ISR/ZA6SC4=;
        b=qu6/acsCt1VB2IJBOuU5VdgmNWLKoQB+ih7eM7yd75Ym0ef0xdAiUb1fKIF/+8MKeb
         5krjVDjCSSMWer/zAiKKsnd9V7gXkSylpJ2lSRkzogA2kiBtWPL2xeto6Nqgl7yFHtdk
         ohwe4wmH2o1A5zfOrchz8CdXBd9hoN8xUgWBiV7KeL2gDlu/Ax8BbmfD6MHVFRMZmh6E
         MZZ8E0Iqck3GZu/Fxk7voHQTCaIrWPwQBCJk85r3G6MQeKG/96w/2YjOPRUXOmbJ7Yn2
         T8d/cV724embNqtvZq+Q4isYN0sW79GH1MFzdiOSGzRO2otfNbQzh+o+nFPT4XEPrYsV
         pnMA==
X-Gm-Message-State: ALQs6tDVl7MKH1tKv9cUIpbNFNubXOWnqxqvfscZaj5wDRP4R0StQ5u1
        pvUskRHZCSZpTB5Kfbyyr/w=
X-Google-Smtp-Source: AB8JxZrw1nRcJpLvQhaRaflmBIv73qt06uF/GqzwS/RNBBHvnhE/5czQnRk4R0LVcpUwQYYmfgk6uw==
X-Received: by 2002:adf:a970:: with SMTP id u103-v6mr13298198wrc.71.1525247871300;
        Wed, 02 May 2018 00:57:51 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (afs230.neoplus.adsl.tpnet.pl. [83.25.148.230])
        by smtp.gmail.com with ESMTPSA id a13-v6sm10611916wrc.19.2018.05.02.00.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 00:57:49 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v4 10/10] commit-graph.txt: update design document
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-11-dstolee@microsoft.com>
        <86d0ygfext.fsf@gmail.com>
        <2ea2c1d0-e2ad-2051-ba98-1584fcb51a46@gmail.com>
Date:   Wed, 02 May 2018 09:57:45 +0200
In-Reply-To: <2ea2c1d0-e2ad-2051-ba98-1584fcb51a46@gmail.com> (Derrick
        Stolee's message of "Tue, 1 May 2018 08:00:51 -0400")
Message-ID: <86o9hy1ocm.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 4/30/2018 7:32 PM, Jakub Narebski wrote:
>> Derrick Stolee <dstolee@microsoft.com> writes:
[...]
>>>   - After computing and storing generation numbers, we must make graph
>>>     walks aware of generation numbers to gain the performance benefits =
they
>>>     enable. This will mostly be accomplished by swapping a commit-date-=
ordered
>>>     priority queue with one ordered by generation number. The following
>>> -  operations are important candidates:
>>> +  operation is an important candidate:
>>>   -    - paint_down_to_common()
>>>       - 'log --topo-order'
>>
>> Another possible candidates:
>>
>>         - remove_redundant() - see comment in previous patch
>>         - still_interesting() - where Git uses date slop to stop walking
>>           too far
>
> remove_redundant() will be included in v5, thanks.

Oh.  Nice.

I'll try to review the new patch in detail soon.

> Instead of "still_interesting()" I'll add "git tag --merged" as the
> candidate to consider, as discussed in [1].
>
> [1] https://public-inbox.org/git/87fu3g67ry.fsf@lant.ki.iif.hu/t/#u
> =C2=A0=C2=A0=C2=A0 "branch --contains / tag --merged inconsistency"

All right.  I have mentioned still_interesting() as a hint where
possible additional generation numbers based optimization may lurk
(because that's where heuristic based on dates is used - similarly to
how it was done in this series with paint_down_to_common()).

[...]
>> One important issue left is handling features that change view of
>> project history, and their interaction with commit-graph feature.
>>
>> What would happen, if we turn on commit-graph feature, generate commit
>> graph file, and then:
>>
>>    * use graft file or remove graft entries to cut history, or remove cut
>>      or join two [independent] histories.
>>    * use git-replace mechanims to do the same
>>    * in shallow clone, deepen or shorten the clone
>>
>> What would happen if without re-generating commit-graph file (assuming
>> tha Git wouldn't do it for us), we run some feature that makes use of
>> commit-graph data:
>>
>>    - git branch --contains
>>    - git tag --contains
>>    - git rev-list A..B
>>
>
> The commit-graph is not supported in these scenarios (yet). grafts are
> specifically mentioned in the future work section.
>
> I'm not particularly interested in supporting these features, so they
> are good venues for other contributors to get involved in the
> commit-graph feature. Eventually, they will be blockers to making the
> commit-graph feature a "default" feature. That is when I will pay
> attention to these situations. For now, a user must opt-in to having a
> commit-graph file (and that same user has possibly opted in to these
> history modifying features).

Well, that is sensible approach.  Get commit-graph features in working
condition, and worry about beng able to make it on by default later.

Nice to have it clarified.  I'll stop nagging about that, then ;-P

One issue: 'grafts' are mentioned in the future work section of the
technical documentation, but we don't have *any* warning about
commit-graph limitations in user-facing documentation, that is
git-commit-graph(1) manpage.

Best,
--=20
Jakub Nar=C4=99bski
