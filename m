Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45E4C211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 16:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeK3DPd (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 22:15:33 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:40453 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbeK3DPd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 22:15:33 -0500
Received: by mail-wm1-f41.google.com with SMTP id q26so2787801wmf.5
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 08:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QENcK1R6+3yeaXBWBNXTKjUdFdN/+6AgzDcVIADPC8c=;
        b=A2U6COvAAKr7MW0wcH6z+Q+B7eBVbFdv5xWwyq/e0HBwJ2jvlRjD/J7OZwzEsP+rGK
         w5HFjShUL78leiLeOOVtfdo9WjZaZyCAIN6AS6RV1HkV8jcwx702Uzc3iSpP/9sZgkKd
         bdu/9b/nm5zNGMhHuv0z28kRX+1dv8b6DnT9cDBoqEBXHFybevk1Qe5EQc2lF2Oa13xR
         Dy+FaOUVxFozBRmn1HdihPdCQT7Anwmaj8V5seYpt0n18eSftrQghJ9l3rbNwN61q0QS
         cI/DEKzjAXxGPqvEUmMxnRxy5ZCNdpKxJz2H1SztAQj9KS05WID+mb90RI2piEhOL1/v
         dxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=QENcK1R6+3yeaXBWBNXTKjUdFdN/+6AgzDcVIADPC8c=;
        b=chcqaeGJ0zu1iI4QmU3jqSXyVRP84UhucIX7a+Yj6MyYCLUX38NswFJORbIrZSdrbZ
         YpbxTcJmhtzhc2D8GnI+x/npO8ozhiy1r391w0/gjNTRNcgbpDK31CQLsbPybGbNByW7
         nrvpFZXp7cpbqQ6OjxcLN96c34VvVBsSm7zb++uLWE83s2EyybjcgDbLl5Nc+Sob86/c
         VL+hhd6gh2tUMg6jggpLX+FBorzvN7Nf1Ij+5+UUjku7ltrZMnxD6hpjGD86SsafEwHV
         rVsSQX8N+A71h1tHBph+c5S+qRc4JVUrUQKljF23ADJdpgqV3nhuhsBxiX4pTwFfBgb+
         pe9Q==
X-Gm-Message-State: AA+aEWYrKshDAk9l0FHm3rsIIScWzI7gPVgihP+Qm+VgZRARP9odMBpg
        0b1I3o+tQNN2Bqg9gq13Fh/CdpdX
X-Google-Smtp-Source: AFSGD/Ut10UI7RPLfCU+NDUAAjxXGGq/6BhFGc5SRngH94KplRjTpFnJVlaezevTTyKsbOaKv4NPZw==
X-Received: by 2002:a7b:c1d7:: with SMTP id a23mr2220935wmj.48.1543507778982;
        Thu, 29 Nov 2018 08:09:38 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id d8sm1719717wrw.70.2018.11.29.08.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 08:09:38 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git <git@vger.kernel.org>,
        Git for human beings <git-users@googlegroups.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: How de-duplicate similar repositories with alternates
References: <87zhtsx73l.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87zhtsx73l.fsf@evledraar.gmail.com>
Date:   Thu, 29 Nov 2018 17:09:37 +0100
Message-ID: <87sgzjyif2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 29 2018, Ævar Arnfjörð Bjarmason wrote:

> A co-worker asked me today how space could be saved when you have
> multiple checkouts of the same repository (at different revs) on the
> same machine. I said since these won't block-level de-duplicate well[1]
> one way to do this is with alternates.
>
> However, once you have an existing clone I didn't know how to get the
> gains without a full re-clone, but I hadn't looked deeply into it. As it
> turns out I'm wrong about that, which I found when writing the following
> test-case which shows that it works:
>
>     (
>         cd /tmp &&
>         rm -rf /tmp/git-{master,pu,pu-alt}.git &&
>
>         # Normal clones
>         git clone --bare --no-tags --single-branch --branch master https://github.com/git/git.git /tmp/git-master.git &&
>         git clone --bare --no-tags --single-branch --branch pu https://github.com/git/git.git /tmp/git-pu.git &&
>
>         # An 'alternate' clone using 'master' objects from another repo
>         git --bare init /tmp/git-pu-alt.git &&
>         for git in git-pu.git git-pu-alt.git
>         do
>             echo /tmp/git-master.git/objects >/tmp/$git/objects/info/alternates
>         done &&
>         git -C git-pu-alt.git fetch --no-tags https://github.com/git/git.git pu:pu
>
>         # Respective sizes, 'alternate' clone much smaller
>         du -shc /tmp/git-*.git &&
>
>         # GC them all. Compacts the git-pu.git to git-pu-alt.git's size
>         for repo in git-*.git
>         do
>             git -C $repo gc
>         done &&
>         du -shc /tmp/git-*.git
>
>         # Add another big history (GFW) to git-{pu,master}.git (in that order!)
>         for repo in $(ls -d /tmp/git-*.git | sort -r)
>         do
>             git -C $repo fetch --no-tags https://github.com/git-for-windows/git master:master-gfw
>         done &&
>         du -shc /tmp/git-*.git &&
>
>         # Another GC. The objects now in git-master.git will be de-duped by all
>         for repo in git-*.git
>         do
>             git -C $repo gc
>         done &&
>         du -shc /tmp/git-*.git
>     )
>
> This shows a scenario where we clone git.git at "master" and "pu" in
> different places. After clone the relevant sizes are:
>
>     108M    /tmp/git-master.git
>     3.2M    /tmp/git-pu-alt.git
>     109M    /tmp/git-pu.git
>     219M    total
>
> I.e. git-pu-alt.git is much smaller since it points via alternates to
> git-master.git, and the history of "pu" shares most of the objects with
> "master". But then how do you get those gains for git-pu.git? Turns out
> you just "git gc"
>
>     111M    /tmp/git-master.git
>     2.1M    /tmp/git-pu-alt.git
>     2.1M    /tmp/git-pu.git
>     115M    total
>
> This is the thing I was wrong about, in retrospect probably because I'd
> been putting PATH_TO_REPO in objects/info/alternates, but we actually
> need PATH_TO_REPO/objects, and "git gc" won't warn about this (or "git
> fsck"). Probably a good idea to patch that at some point, i.e. whine
> about paths in alternates that don't have objects, or at the very least
> those that don't exist. #leftoverbits

Actually looking at this again the thing that may have stumped me last
time is that this has a bad interaction with gc.bigPackThreshold. If you
have an alternate that would otherwise house most of your objects *and*
you have a pack that's larger than the gc.bigPackThreshold your mostly
redundant pack won't be removed.

That's understandable in terms of implementation, but unfortunate. It
would be nice if we learned some way to detect this, i.e. "I have this
10GB pack, but with this alternate I can extract this 100MB out of it
and throw it away". Now we just keep the 10GB pack even if it's mostly
redundant to what's in the alternate.

> Then when we fetch git-for-windows:master to all the repos they all grow
> by the amount git-for-windows has diverged:
>
>     144M    /tmp/git-master.git
>     36M     /tmp/git-pu-alt.git
>     36M     /tmp/git-pu.git
>     214M    total
>
> Note that the "sort -r" is critical here. If we fetched git-master.git
> first (at this point the alternate for git-pu*.git) we wouldn't get the
> duplication in the first place, but instead:
>
>     144M    /tmp/git-master.git
>     2.1M    /tmp/git-pu-alt.git
>     2.1M    /tmp/git-pu.git
>     148M    total
>
> This shows the importance of keeping such an 'alternate' repo
> up-to-date, i.e. we don't get the duplication in the first place, but
> regardless (this from a run with sort -r) a "git gc" will coalesce them:
>
>     131M    /tmp/git-master.git
>     2.1M    /tmp/git-pu-alt.git
>     2.2M    /tmp/git-pu.git
>     135M    total
>
> If you find this interesting make sure to read my
> https://public-inbox.org/git/87k1s3bomt.fsf@evledraar.gmail.com/ and
> https://public-inbox.org/git/87in7nbi5b.fsf@evledraar.gmail.com/ for the
> caveats, i.e. if this is something intended for users then no ref in the
> alternate can ever be rewound, that'll potentially result in repository
> corruption.
>
> 1. https://public-inbox.org/git/87bmhiykvw.fsf@evledraar.gmail.com/
