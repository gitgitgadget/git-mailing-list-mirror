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
	by dcvr.yhbt.net (Postfix) with ESMTP id B36921F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 10:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeJKSBS (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 14:01:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37004 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeJKSBS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 14:01:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id 185-v6so8873611wmt.2
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 03:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YxjhBnEYvxue5MCB1r1eamhhMHCbR7bS3xdUmAElG5E=;
        b=eSCnYIixxL4eW8oBgZ2OsY7Vs/LatftqHq2MtVFahKp9mUnBx4HRqi9gsiQ9QVwb1Q
         etk6sowFPMY5l+OISVycKQx6vwi4I8SodUPG+BVL/7gk7d8pU14SGhjHuZNFV2TTN58H
         nl5QtVk8fVXUlue46iWUN5C2Ttl0RgIH3midHKW9+l3/rsA4RI74hSyYdEysScgK6jTd
         ouHrRGLE3T3eMCYCXTzIe3h/9dn/NcwX9JT+NRJ7lJ1yQc9YEJR6WVPRW4vgVYSD9MhH
         mBQtpkwa6HtsUzjE6Drfvq2kuMIrPK5q3oxXP4JGbk81FgWsw0DWJ//requ/xzGdIt7w
         1+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=YxjhBnEYvxue5MCB1r1eamhhMHCbR7bS3xdUmAElG5E=;
        b=FHT/RcdfsNdq/NX4O9rkpDwGr1T8mTRSn83dp3d2WrV1oLpvjNJYHLfXAbcYzKpfXP
         aY8PE0enoiIRPRy6/PwM8jBvSNKgDUGaa4DQQ4dL0pVNAjCpnvFwuLi2v6UC6B9ma6xg
         /shZ2Z8XqZrYOr0rZMCXncZJK/YKg4cX+lKDYutVxA3BfS0QySTb6iD25QVBrO1AWc92
         FnS4jjCBqzCq2I+b1sQqpo4FrBfw8wA3z1mlixnu+hF3Oh8XkOYQqk7uzTtnJNL+cHuN
         ULyz0v4GO9SVDH8QmltK3d0C7dCV0Kc9mc6q11HcPfhl4ujhPnzn5MgUShpv/Ro25Fwe
         ssyw==
X-Gm-Message-State: ABuFfoj8FxVT5DJur4wjOm9CcOCXgBQQbIXi0T/hTjLFoudeMzpTYe0t
        pCG7OIAYl5JURyL+ejiGHs0c46zhb/E=
X-Google-Smtp-Source: ACcGV62UZF/jc/xZ9MGvtXljhsZpybGwLb8ASwrten8r+7pryS4UyeinnltKfJHtKRlG3RREEqf9hg==
X-Received: by 2002:a1c:c40a:: with SMTP id u10-v6mr1186685wmf.30.1539254077118;
        Thu, 11 Oct 2018 03:34:37 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id t198-v6sm15367634wmd.9.2018.10.11.03.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 03:34:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] revert & cherry-pick: run git gc --auto
References: <20181010193557.19052-1-avarab@gmail.com> <20f33df8-7ba8-af26-e0c8-16152345c85b@talktalk.net> <87ftxceqxc.fsf@evledraar.gmail.com> <20181011102525.GH23446@szeder.dev>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181011102525.GH23446@szeder.dev>
Date:   Thu, 11 Oct 2018 12:34:35 +0200
Message-ID: <87efcwepqc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 11 2018, SZEDER Gábor wrote:

> On Thu, Oct 11, 2018 at 12:08:47PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Thu, Oct 11 2018, Phillip Wood wrote:
>>
>> > Hi Ævar
>> >
>> > On 10/10/2018 20:35, Ævar Arnfjörð Bjarmason wrote:
>> >> Expand on the work started in 095c741edd ("commit: run git gc --auto
>> >> just before the post-commit hook", 2018-02-28) to run "gc --auto" in
>> >> more commands where new objects can be created.
>> >>
>> >> The notably missing commands are now "rebase" and "stash". Both are
>> >> being rewritten in C, so any use of "gc --auto" there can wait for
>> >> that.
>> >
>> > If cherry-pick, revert or 'rebase -i' edit the commit message then they
>> > fork 'git commit' so gc --auto will be run there anyway.
>>
>> Yeah it seems I totally screwed up the testing for this patch, first it
>> doesn't even compile because I'm not including run-command.h, I *did*
>> fix that, but while wrangling a few things didn't commit that *sigh*.
>>
>> And yeah, there's some invocations where we now run gc --auto twice,
>> i.e. if you do revert, but not revert --no-edit, and not on cherry-pick,
>> but on cherry-pick --edit.
>>
>> So yeah, this really needs to be re-thought.
>>
>> > I wonder if it would be better to call 'gc --auto' from sequencer.c at
>> > the end of a string of successful picks, that would cover cherry-pick,
>> > 'rebase -iu' and revert. With 'rebase -i' it might be nice to avoid
>> > calling 'gc --auto' until the very end, rather than every time we stop
>> > for an edit but that is probably more trouble than it is worth.
>>
>> That seems a lot better indeed. I.e. running it from the sequencer. I do
>> wonder if there should be some smarts about running it in the middle of
>> a sequence, i.e. think of a case where we're rebasing 10k commits, which
>> is a gc need similar to what happens in the middle of "git svn
>> clone". So maybe something where we gc --auto in the sequencer for every
>> Nth commit, and at the end.
>
> How would that affect setups with 'gc.autoDetach = false', or, more
> importantly, platforms, where 'git gc --auto' always runs in the
> foreground?

I see we define NO_POSIX_GOODIES on Windows/MinGW, so those don't
demonize "gc", but then I'm confused by this which seems to imply the
opposite: https://github.com/Microsoft/vscode/issues/29901

As far as the general UI question goes, I think if you define
gc.autoDetach=true you're already OK with having "git fetch" and various
commands that produce commits block, so I don't see a big difference in
doing this in the middle of a rebase.

But it seems (aside from the question of how this is done on Windows)
that we demonize by default everywhere now, so I think it's OK to be
less conservative about where we run gc.

We also run a GC every 1000th commit in "git svn clone/rebase" already.
