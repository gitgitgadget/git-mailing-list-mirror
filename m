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
	by dcvr.yhbt.net (Postfix) with ESMTP id 940721F424
	for <e@80x24.org>; Wed, 18 Apr 2018 11:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeDRL1S (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 07:27:18 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45711 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeDRL1R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 07:27:17 -0400
Received: by mail-wr0-f194.google.com with SMTP id u11-v6so3801603wri.12
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 04:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=P34c9mTrU0iKpsYM2Ki95ayPxi7l9r/NLbVnWIij6x8=;
        b=g9yQnDJbabIqRtPeSkuXqxds2sM6VhxBf/Vcp1Wyxog6fLg+za7Kee2dexC3AhwE/T
         qo8VrXOplP8mSBjIZRO5f/4NUa4lURJG4BqLR1icJwrJC2bgH7jkpkR9CvNxaKoRdMIz
         QqduNGSnX+blG8wqSyXPplu8aaGTCrG0N/4wlvAYRnIeiEESDgmkSOGSFZF8eTSBrZsn
         6o0X69LoymWQTSgfxzI1HKhrubNk6PoL+3auh7ZDp9AzzqzJPX3s/lXXrj8i1/znLQ3u
         K1MpHoe0P9K/E4Ycs8vr9RvCJtWhosBFVT6SydxtSajIKmnbikq/H51zIS8nxLLV8QdU
         m7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=P34c9mTrU0iKpsYM2Ki95ayPxi7l9r/NLbVnWIij6x8=;
        b=sAHafNuUNKRNywXY8tfZBbzQgKYP6Wu4UbBPwYx2qh2Onfhg1Yi1xLduHPnqCpcqXO
         PL9hNW+HaCf+2K6XF6mD1YuhygT8XO5BMhwFqmLaENJq2UYESsUc5BvRXv0ryoePHSEx
         /E6KHwq4leM+on0XXlYY+i/mAICt4tXHgLE2hgD02KxIHKorypGD1Ikl5ska3HzxSWwy
         DPulEgW9YrTYbS+pyGzfM419eeSCdqAxgK3eD/+mBkDd6bxM5UDtlUOM2uJ2blGWw9co
         pqpnblveqymo8ZK0bZRv2AiczK857AQ4p00k1p5eGuKG6UBlMokLqAQuzskUw9x56I4H
         Qcgw==
X-Gm-Message-State: ALQs6tBjBoQ2ZrwJv1Ir/1vfFele0MU6dQM950nn2/rCirNYUa4I/OjZ
        pYnbMH3QS9gBRlD/kMU6fmzCx9HT
X-Google-Smtp-Source: AIpwx4+DC2g6qs6R48fSCUfF4g8BOVzTjB6hjNnp5+Q/GarNhHAyg0HaTQ+wrVZVAifNk4oswg7WBw==
X-Received: by 10.80.235.11 with SMTP id y11mr2710294edp.295.1524050836294;
        Wed, 18 Apr 2018 04:27:16 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id w1sm881247edf.57.2018.04.18.04.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 04:27:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] ident: don't cache default date
References: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org> <20180418102236.7183-1-phillip.wood@talktalk.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180418102236.7183-1-phillip.wood@talktalk.net>
Date:   Wed, 18 Apr 2018 13:27:14 +0200
Message-ID: <87vacoeovh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 18 2018, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Now that the sequencer commits without forking when the commit message
> isn't edited all the commits that are picked have the same committer
> date. If a commit is reworded it's committer date will be a later time

s/it's/its/

> as it is created by running an separate instance of 'git commit'.  If
> the reworded commit is follow by further picks, those later commits
> will have an earlier committer date than the reworded one. This is
> caused by git caching the default date used when GIT_COMMITTER_DATE is
> not set. Fix this by not caching the date.
>
> Users expect commits to have the same author and committer dates when
> the don't explicitly set them. As the date is now updated each time
> git_author_info() or git_committer_info() is run it is possible to end
> up with different author and committer dates. Fix this for
> 'commit-tree', 'notes' and 'merge' by using a single date in
> commit_tree_extended() and passing it explicitly to the new functions
> git_author_info_with_date() and git_committer_info_with_date() when
> neither the author date nor the committer date are explicitly
> set. 'commit' always passes the author date to commit_tree_extended()
> and relied on the date caching to have the same committer and author
> dates when neither was specified. Fix this by setting
> GIT_COMMITTER_DATE to be the same as the author date passed to
> commit_tree_extended().
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Reported-by: Johannes Sixt <j6t@kdbg.org>
> ---
>
> I'm slightly nervous that setting GIT_COMMITTER_DATE in
> builtin/commit.c will break someone's hook script. Maybe it would be
> better to add a committer parameter to commit_tree() and
> commit_tree_extended().
>
> This needs some tests. I think we could test that the sequencer gives
> each commit a new date with 'git rebase -i --exec="sleep 2"
> --force-rebase @~2' and test the committer dates of the rebased
> commits. I'm not sure if test -gt can cope with numbers that big
> though, maybe we'll have to be content with test !=. For 'git commit'
> I think doing GIT_EDITOR='sleep 2; echo message >"$1"' and checking
> the committer date and author date will work as the author date is set
> before the user edits the commit message. I'm not sure how to test
> callers of commit_tree() though (that's commit-tree, notes and merge)
> as I've not been able to come up with anything that will guarantee the
> author and committer dates are different if the code in
> commit_tree_extended() that ensures they are the same gets broken.

The behavior you're describing where we end up with later commits in the
rebase with earlier CommitDate's definitely sounds like a minor
regression, and yeah we should have tests for this.

My mental model of this is that we shouldn't be trying at all to adjust
the CommitDate in a sequence to be the same, and just make it be
whatever time() returns, except in the case where a date is passed
explicitly.

My cursory reading of this RFC patch is that it's definitely an
improvement because we don't end up with things out of order, but is
there any reason for why we should be trying to aim to keep this
"consistent" within a single "git rebase" command by default, as opposed
to always just writing the current CommitDate at the time we make the
commit, that sounds like the most intuitive thing to me, and I can't see
any downsides with that.

It leaks info about how long it took someone to do the rebase, but so
what?
