Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A38E21847
	for <e@80x24.org>; Wed,  2 May 2018 18:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeEBSZt (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 14:25:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51890 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeEBSZs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 14:25:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id j4so24424031wme.1
        for <git@vger.kernel.org>; Wed, 02 May 2018 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oZI/QEyzCeUrxIgmzUiR6+QBN08hfN1d/CoDSeCtJto=;
        b=IEVryaBRpGkFlEnXhnIIUUSfERQ/9xdoEwAmZXsoqiKhfl07Syn9hW6UB7oK3tAZND
         QVoAMQgKiFKawLlw+pGCFIdgR26kJEXrdfK0I+10Aovxh41BWs/zxNK56S7YFFlg1XZj
         kj4L65laZfOTfof9Nozrmhu9e3oHVEf8AQk/Ynjzth9zbIgatWmuJqCcwtiFT7Avyfv4
         FJAzYlVxMlmIUSP61ZYwJ7eKab2vgHKv7WMwSoVmIeA28y2BDUh1/yFya0LnLehrCpys
         ZDqCMZq0hZbvK8dNKDkW9dG2WMINQM31k0p/nLkkmkmebbjaTJhNrmpOEfolkIqBNX8D
         ZBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=oZI/QEyzCeUrxIgmzUiR6+QBN08hfN1d/CoDSeCtJto=;
        b=rWFT4Lz9/KUHX+lpFUggCBKjqRklghExTqLaTo73pD3D4SktlvpPiVx+ileeghse4m
         lRNOFzzwrAjbHuOVJjJrVjzx7qNfA9sYh9CD6rgT4pxJWYZgHx71RQ17JVeP8n2nOM0x
         x5pBKIfFLOEmJAgZrJnzzHxAz9Fc2oiEuMUs/l4YFBkww2D+FvBlD3IquCwgagpnSDgM
         98/iGou2PAwUaGBHxkfsQRab2peQKkqt3h7EgHRvC8Um2Gj3xse6GKcM1RISamLkjy/0
         k06UwcGXW3VHZGcfcTgNxdbiVwMTfhrtP9RzQG6fuev4YATxXgWH5p2t2gAwa/Ia3sq9
         QZVQ==
X-Gm-Message-State: ALQs6tAWOQyx6qKFkYsVaFhVJLCsWmYDzWgxKa6Ogh3KYeq3KpFZ1S2g
        PJjVtO/sV4a+zaQeaNVEYPU=
X-Google-Smtp-Source: AB8JxZqg1CmydNsEqq3pvNLnU7WMvvbtK/dnJ8jNinxKc5JORs99lVtoXZv2DPX71o1iooVMQM8YUA==
X-Received: by 2002:a50:abc2:: with SMTP id u60-v6mr27552056edc.43.1525285546629;
        Wed, 02 May 2018 11:25:46 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 49-v6sm6336016edz.87.2018.05.02.11.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 11:25:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] checkout & worktree: introduce a core.DWIMRemote setting
References: <20180502105452.17583-1-avarab@gmail.com>
        <CACsJy8Ae9PP8BMbyX5mPJukGpC06jMvvbg0fMFL+fu+EUg1kPw@mail.gmail.com>
        <CAPig+cTZyYC-1_TxL2PrfOF6HAktUxxM+g5EXcByS5fCDMdCHg@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAPig+cTZyYC-1_TxL2PrfOF6HAktUxxM+g5EXcByS5fCDMdCHg@mail.gmail.com>
Date:   Wed, 02 May 2018 20:25:44 +0200
Message-ID: <87y3h1ykwn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 02 2018, Eric Sunshine wrote:

> On Wed, May 2, 2018 at 11:21 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Wed, May 2, 2018 at 12:54 PM, Ævar Arnfjörð Bjarmason
>> <avarab@gmail.com> wrote:
>>> Introduce a core.DWIMRemote setting which can be used to designate a
>>> remote to prefer (via core.DWIMRemote=origin) when running e.g. "git
>>> checkout master" to mean origin/master, even though there's other
>>> remotes that have the "master" branch.
>>
>> Do we anticipate more dwimy customizations to justify a new dwim group
>> in config (i.e. dwim.remote instead of core.dwimRemote)?
>
> A few observations:
>
> 1. DWIM has broad meaning; while this certainly falls within DWIM,
> it's also just a _default_, so should this instead be named
> "defaultRemote"?
>
> 2. Building on #1: How well is the term "DWIM" understood by non-power
> users? A term, such as "default" is more well known.

I've got no love for the DWIM term. And I think I should change it in
v2, I just want some way to enable this functionality since this
behavior has annoyed me for a long time.

I wonder though if something like "core.defaultRemote" might not bring
up connotations about whether this would e.g. affect "push" in the minds
of users (not that my initial suggestion is better).

So maybe something like checkout.implicitRemote would be better? And we
could just break the rule that only git-checkout would use it, since
git-worktree could be said to be doing something checkout-like, or just
also add a worktree.implicitRemote.

> 3. git-worktree learned --guess-remote and worktree.guessRemote in [1]
> and [2], which, on the surface, sound confusingly similar to
> "DWIMRemote". Even though I was well involved in the discussion and
> repeatedly reviewed the patch series which introduced those, it still
> took me an embarrassingly long time, and repeated re-reads of all
> commit messages involved, to grasp (or re-grasp) how "guess remote"
> and "DWIM remote" differ. If it was that difficult for me, as a person
> involved in the patch series, to figure out "guess remote" vs. "DWIM
> remote", then I worry that it may be too confusing in general. If the
> new config option had been named "defaultRemote", I don't think I'd
> have been confused at all.

I hadn't looked at this at all before today when I wrote the patch, and
I've never used git-worktree (but maybe I should...), but my
understanding of this --[no-]guess-remote functionality is that it
effectively splits up the functionality that the "git checkout" does,
and we'll unconditionally check out the branch, but the option controls
whether or not we'd set up the equivalent of remote tracking for
git-worktree.

But maybe I've completely misunderstood it.

> It may sound as if I'm advocating the name "defaultRemote", but that
> wasn't the intention, and I'm not wedded to it; that name simply fell
> out naturally as I enumerated the above observations.
>
> [1]: 71d6682d8c (worktree: add --guess-remote flag to add subcommand,
> 2017-11-29)
> [2]: e92445a731 (add worktree.guessRemote config option, 2017-11-29)
