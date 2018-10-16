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
	by dcvr.yhbt.net (Postfix) with ESMTP id 192491F453
	for <e@80x24.org>; Tue, 16 Oct 2018 12:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeJPUr4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 16:47:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36017 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeJPUr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 16:47:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so25411976wrw.3
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=GX4Hp1tF5M7kK8GIVwRLSbh7HK4MMIY+gEUI4Ev44kw=;
        b=EaAjXbnD/fAviIC6vY4Rzm7qzUj4r/wLqyscX5pCS5GlrUkKsMqfYMAWwCMt7s/n0B
         Updbcu6Wf2+1FH8xwp8XyzBxPQJg7ASjO8Gccdy+2OB5dwcZfOwkXSh13dlHTC1dVdbN
         vBb0KPq73OYqRAkoyO1yPE0ckNvTUY+cRrDyO8BWK/4TRLgnKg/8Vt01xPXs+jviM2PL
         Y4u8eYbxfB1dktl3mVDznfKJQfYR4r6ZZ2HbghGlUEx6JjfDyxa3z4JD4jog+Qj0l7yi
         /KZjT/nJaV4zY2pjQXFLPezvfX+3NkAQ4latw+aMQKTfMZo20AI2+F978QpqJDnFRpU2
         kaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=GX4Hp1tF5M7kK8GIVwRLSbh7HK4MMIY+gEUI4Ev44kw=;
        b=Do1N26X56Z0Q857SYblmbDaavzkiYkFMbidM6I4xRu+fh1Wz2NZ4vavKbEyA+BOfw3
         I25PviUjR+KJvVwJGBgheP2Wxc8ze4USXZHLDRJUZwuaAfAOv/AoNqxJWUAcLw6NCom2
         ZxOcWHFDkGsw8fDdU5JZelxh/jPQVPeMClyk3Lmj6wNGgIZrLSMbPDzj7JByKYA6yYJ2
         kikH0QCzcJdDmT80Go9VHn7NH6muxo23EVh5Bo+al9b0VndfMPxE8/ebOwU9JYLZjbix
         ds5cBksi4DSbStmLqej6HZT+BDE5u2CrLSjrxrNc93wF+Dgrj8ENEfQPOnVtSc9snSw1
         o3yA==
X-Gm-Message-State: ABuFfohvmvacLW1KSkogM6loTNvAua1njYOPGuvST+JrmdRM5RrQadYB
        uB6Fvm6YU3OzT3XpH8YDbaA=
X-Google-Smtp-Source: ACcGV63n8C+e+a4dUew/Mpz2CjKHmaabxFZVDDdodKDekWN22QYzw7LXhDIJtYJTyuwPH0kJHW4ecA==
X-Received: by 2002:a5d:404b:: with SMTP id w11-v6mr17395216wrp.147.1539694652729;
        Tue, 16 Oct 2018 05:57:32 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id o7-v6sm9915189wma.17.2018.10.16.05.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 05:57:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/4] Bloom filter experiment
References: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com> <20181009193445.21908-1-szeder.dev@gmail.com> <61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com> <xmqqlg6y1ovh.fsf@gitster-ct.c.googlers.com> <8c66cbe3-6830-05cb-f3bb-be2e4902e8f5@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <8c66cbe3-6830-05cb-f3bb-be2e4902e8f5@gmail.com>
Date:   Tue, 16 Oct 2018 14:57:30 +0200
Message-ID: <87zhvecamd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 16 2018, Derrick Stolee wrote:

> On 10/16/2018 12:45 AM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> 2. The filters are sized according to the number of changes in each
>>> commit, with a minimum of one 64-bit word.
>>> ...
>>> 6. When we compute the Bloom filters, we don't store a filter for
>>> commits whose first-parent diff has more than 512 paths.
>> Just being curious but was 512 taken out of thin air or is there
>> some math behind it, e.g. to limit false positive rate down to
>> certain threshold?  With a wide-enough bitset, you could store
>> arbitrary large number of paths with low enough false positive, I
>> guess, but is there a point where there is too many paths in the
>> change that gives us diminishing returns and not worth having a
>> filter in the first place?
> 512 is somewhat arbitrary, but having a maximum size is not.
>> In a normal source-code-control context, the set of paths modified
>> by any single commit ought to be a small subset of the entire paths,
>> and whole-tree changes ought to be fairly rare.  In a project for
>> which that assumption does not hold, it might help to have a
>> negative bloom filter (i.e. "git log -- A" asks "does the commit
>> modify A?" and the filter would say "we know it does not, because we
>> threw all the paths that are not touched to the bloom filter"), but
>> I think that would optimize for a wrong case.
>
> A commit with many changed paths is very rare. The 512 I picked above
> is enough to cover 99% of commits in each of the repos I sampled when
> first investigating Bloom filters.
>
> When a Bloom filter response says "maybe yes" (in our case, "maybe not
> TREESAME"), then we need to verify that it is correct. In the extreme
> case that every path is changed, then the Bloom filter does nothing
> but add extra work.
>
> These extreme cases are also not unprecedented: in our Azure Repos
> codebase, we were using core.autocrlf to smudge CRLFs to LFs, but
> when it was time to dogfood VFS for Git, we needed to turn off the
> smudge filter. So, there is one commit that converts every LF to a
> CRLF in every text file. Storing a Bloom filter for those ~250,000
> entries would take ~256KB for essentially no value. By not storing a
> filter for this commit, we go immediately to the regular TREESAME
> check, which would happen for most pathspecs.
>
> This is all to say: having a maximum size is good. 512 is big enough
> to cover _most_ commits, but not so big that we may store _really_ big
> filters.

Makes sense. 512 is good enough to hardcode initially, but I couldn't
tell from briefly skimming the patches if it was possible to make this
size dynamic per-repo when the graph/filter is written.

I.e. we might later add some discovery step where we look at N number of
commits at random, until we're satisfied that we've come up with some
average/median number of total (recursive) tree entries & how many tend
to be changed per-commit.

I.e. I can imagine repositories (with some automated changes) where we
have 10k files and tend to change 1k per commit, or ones with 10k files
where we tend to change just 1-10 per commit, which would mean a
larger/smaller filter would be needed / would do.
