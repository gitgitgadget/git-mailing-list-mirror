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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DA141F453
	for <e@80x24.org>; Wed,  3 Oct 2018 14:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeJCVHN (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 17:07:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35560 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJCVHN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 17:07:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id o18-v6so5853431wmc.0
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=e0WOEvF1xlAicbdV9Iyh8RRfuztfQGTpBTKV48NBh/w=;
        b=jYpvT8KMVqG3ldVDCyaliFvmkUP3FaM+gtzc7ASBNoE945Exyw//SB55f9aNsG6vRV
         AuWBFzFShgMrqVYNc+l1uKGXl/ed/JtomAfeyoUcIQrQUdvAXZEqEOlDcRWjb9OW7ALQ
         /BbO8f2kY6AoCheV06B6HrztZ2JI7zm0Ftktrky8DcPJvbP1I41BkVc1pRBzTp3Whz2M
         bTCmvM8pgxvh4SjvZPKbrPtOr3a1iBsBT/1VmVVk0HKqVu/J+nufp9zqSK+6YdSgc0IJ
         Msqo2q2ADsVpKfpdDajvyHndlA8yHWM3VhAAAvhGvirfdniy0aBgsENASxHyJaXkWmiw
         5p/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=e0WOEvF1xlAicbdV9Iyh8RRfuztfQGTpBTKV48NBh/w=;
        b=DsGlPOZ5xit0gtroqs/+pkZCi20O7B6QJ0wg1qZDoohmBffZ3/LPCJ/U2rA/LatvYS
         PHljbsc/WPDJfDESU7qz8NG1RypqhXnep11ftSonBp+pFzIR/bfxzJ6GXzooVsUtY3Wp
         vJu4IhRKzhpv/I++4LfpmgMPrz4vpOYBAZOLnsV0fnXhlmGnJ5B8uYGZrJUC2Da3yXJV
         cXs059TFBNpmaUwjtSbqvriq62a3Lp/nm5zxtIz/H+S91AMVV2GQbX9CcwjplRIAy5tm
         FcLcoBgAg4SbQh2bmbz13vu5O3SrAfK1u9dFq4iDCiQ21Tmqyh5zjpU8gPD/Au883cTG
         xz8Q==
X-Gm-Message-State: ABuFfohZgVngw9Vn0EMr65fKTh29m0zSLEB0hy4KJ2NGv1JJGxbLuN84
        y6c5e0RUGJqIgi11w8fGeGfdLS+C
X-Google-Smtp-Source: ACcGV61/eoSv3hfvCUnViZsvEPEmuvdbPuj/Y6B5L5HINp4S9MEohrkjwf81F7PZZO7GpZOHgxqqfg==
X-Received: by 2002:a1c:ae15:: with SMTP id x21-v6mr1575957wme.73.1538576315215;
        Wed, 03 Oct 2018 07:18:35 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id a17-v6sm1714221wme.40.2018.10.03.07.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 07:18:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit graph
References: <87tvm3go42.fsf@evledraar.gmail.com> <20181003133650.GN23446@localhost> <836a8d28-0879-73a5-7e0b-75f438ff6785@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <836a8d28-0879-73a5-7e0b-75f438ff6785@gmail.com>
Date:   Wed, 03 Oct 2018 16:18:33 +0200
Message-ID: <87pnwrgll2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 03 2018, Derrick Stolee wrote:

> On 10/3/2018 9:36 AM, SZEDER Gábor wrote:
>> On Wed, Oct 03, 2018 at 03:23:57PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>> Don't have time to patch this now, but thought I'd send a note / RFC
>>> about this.
>>>
>>> Now that we have the commit graph it's nice to be able to set
>>> e.g. core.commitGraph=true & gc.writeCommitGraph=true in ~/.gitconfig or
>>> /etc/gitconfig to apply them to all repos.
>>>
>>> But when I clone e.g. linux.git stuff like 'tag --contains' will be slow
>>> until whenever my first "gc" kicks in, which may be quite some time if
>>> I'm just using it passively.
>>>
>>> So we should make "git gc --auto" be run on clone,
>> There is no garbage after 'git clone'...
>
> And since there is no garbage, the gc will not write the commit-graph.

I should probably have replied to this instead of SZEDER's in
https://public-inbox.org/git/87r2h7gmd7.fsf@evledraar.gmail.com/ anyway
my 0.02 on that there.

>>
>>> and change the
>>> need_to_gc() / cmd_gc() behavior so that we detect that the
>>> gc.writeCommitGraph=true setting is on, but we have no commit graph, and
>>> then just generate that without doing a full repack.
>> Or just teach 'git clone' to run 'git commit-graph write ...'
>
> I plan to add a 'fetch.writeCommitGraph' config setting. I was waiting
> until the file is incremental (on my to-do list soon), so the write is
> fast when only adding a few commits at a time. This would cover the
> clone case, too.

It's re-arranging deck chairs on the Titanic at this point, but this
approach seems like the wrong way to go in this whole "do we have crap
to do?" git-gc state-machine.

In my mind we should have only one entry point into that, and there
shouldn't be magic like "here's the gc-ish stuff we do on
fetch". Because if we care about a bunch of new commits being added on
"fetch", that can also happen on "commit", "am", "merge", all of which
run "gc --auto" now.

Which is why I'm suggesting that we could add a sub-mode in need_to_gc()
that detects if a file we want to generate is entirely missing, which is
extendable to future formats, and the only caveat at that point is if
we'd like that subset of "gc" to block and run in the foreground in the
"clone" (or "fetch", ...) case.

And then if we have a desire to incrementally add recently added commits
to such formats, "gc --auto" could learn to consume reflogs or some
other general inventory of "stuff added since last gc", and then we
wouldn't have to instrument "fetch" specifically, the same would work
for "commit", "am", "merge" etc.
