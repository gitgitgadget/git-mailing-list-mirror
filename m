Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB76F1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 16:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753055AbeDKQH7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 12:07:59 -0400
Received: from mail.javad.com ([54.86.164.124]:48738 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752804AbeDKQH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 12:07:58 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 8F13C3EB38;
        Wed, 11 Apr 2018 16:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523462877;
        bh=MGS0pqklhUCK7DRh3GoW26ivDZ2rS56KbMR6KaYogHE=; l=3330;
        h=Received:From:To:Subject;
        b=fzCUZaCecvlInBWbM2nCdMS5/l8HadejVzBIoc1NXgkvj97R0QuO7KDdg6foIJ3P0
         tbndU5kcO0BaixWT2dPvqMhxjxgeSFyQ13PIXvYPEBonJxoOwcJZmQPN293iq85UaA
         GQNfdkCe6ELw2R9s7YVGjeuXuVXdfoB2e8u0qSZs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523462877;
        bh=MGS0pqklhUCK7DRh3GoW26ivDZ2rS56KbMR6KaYogHE=; l=3330;
        h=Received:From:To:Subject;
        b=fzCUZaCecvlInBWbM2nCdMS5/l8HadejVzBIoc1NXgkvj97R0QuO7KDdg6foIJ3P0
         tbndU5kcO0BaixWT2dPvqMhxjxgeSFyQ13PIXvYPEBonJxoOwcJZmQPN293iq85UaA
         GQNfdkCe6ELw2R9s7YVGjeuXuVXdfoB2e8u0qSZs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523462877;
        bh=MGS0pqklhUCK7DRh3GoW26ivDZ2rS56KbMR6KaYogHE=; l=3330;
        h=Received:From:To:Subject;
        b=fzCUZaCecvlInBWbM2nCdMS5/l8HadejVzBIoc1NXgkvj97R0QuO7KDdg6foIJ3P0
         tbndU5kcO0BaixWT2dPvqMhxjxgeSFyQ13PIXvYPEBonJxoOwcJZmQPN293iq85UaA
         GQNfdkCe6ELw2R9s7YVGjeuXuVXdfoB2e8u0qSZs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523462877;
        bh=MGS0pqklhUCK7DRh3GoW26ivDZ2rS56KbMR6KaYogHE=; l=3330;
        h=Received:From:To:Subject;
        b=fzCUZaCecvlInBWbM2nCdMS5/l8HadejVzBIoc1NXgkvj97R0QuO7KDdg6foIJ3P0
         tbndU5kcO0BaixWT2dPvqMhxjxgeSFyQ13PIXvYPEBonJxoOwcJZmQPN293iq85UaA
         GQNfdkCe6ELw2R9s7YVGjeuXuVXdfoB2e8u0qSZs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523462877;
        bh=MGS0pqklhUCK7DRh3GoW26ivDZ2rS56KbMR6KaYogHE=; l=3330;
        h=Received:From:To:Subject;
        b=fzCUZaCecvlInBWbM2nCdMS5/l8HadejVzBIoc1NXgkvj97R0QuO7KDdg6foIJ3P0
         tbndU5kcO0BaixWT2dPvqMhxjxgeSFyQ13PIXvYPEBonJxoOwcJZmQPN293iq85UaA
         GQNfdkCe6ELw2R9s7YVGjeuXuVXdfoB2e8u0qSZs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523462877;
        bh=MGS0pqklhUCK7DRh3GoW26ivDZ2rS56KbMR6KaYogHE=; l=3330;
        h=Received:From:To:Subject;
        b=fzCUZaCecvlInBWbM2nCdMS5/l8HadejVzBIoc1NXgkvj97R0QuO7KDdg6foIJ3P0
         tbndU5kcO0BaixWT2dPvqMhxjxgeSFyQ13PIXvYPEBonJxoOwcJZmQPN293iq85UaA
         GQNfdkCe6ELw2R9s7YVGjeuXuVXdfoB2e8u0qSZs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523462877;
        bh=MGS0pqklhUCK7DRh3GoW26ivDZ2rS56KbMR6KaYogHE=; l=3330;
        h=Received:From:To:Subject;
        b=fzCUZaCecvlInBWbM2nCdMS5/l8HadejVzBIoc1NXgkvj97R0QuO7KDdg6foIJ3P0
         tbndU5kcO0BaixWT2dPvqMhxjxgeSFyQ13PIXvYPEBonJxoOwcJZmQPN293iq85UaA
         GQNfdkCe6ELw2R9s7YVGjeuXuVXdfoB2e8u0qSZs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523462877;
        bh=MGS0pqklhUCK7DRh3GoW26ivDZ2rS56KbMR6KaYogHE=; l=3330;
        h=Received:From:To:Subject;
        b=fzCUZaCecvlInBWbM2nCdMS5/l8HadejVzBIoc1NXgkvj97R0QuO7KDdg6foIJ3P0
         tbndU5kcO0BaixWT2dPvqMhxjxgeSFyQ13PIXvYPEBonJxoOwcJZmQPN293iq85UaA
         GQNfdkCe6ELw2R9s7YVGjeuXuVXdfoB2e8u0qSZs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523462877;
        bh=MGS0pqklhUCK7DRh3GoW26ivDZ2rS56KbMR6KaYogHE=; l=3330;
        h=Received:From:To:Subject;
        b=fzCUZaCecvlInBWbM2nCdMS5/l8HadejVzBIoc1NXgkvj97R0QuO7KDdg6foIJ3P0
         tbndU5kcO0BaixWT2dPvqMhxjxgeSFyQ13PIXvYPEBonJxoOwcJZmQPN293iq85UaA
         GQNfdkCe6ELw2R9s7YVGjeuXuVXdfoB2e8u0qSZs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523462877;
        bh=MGS0pqklhUCK7DRh3GoW26ivDZ2rS56KbMR6KaYogHE=; l=3330;
        h=Received:From:To:Subject;
        b=fzCUZaCecvlInBWbM2nCdMS5/l8HadejVzBIoc1NXgkvj97R0QuO7KDdg6foIJ3P0
         tbndU5kcO0BaixWT2dPvqMhxjxgeSFyQ13PIXvYPEBonJxoOwcJZmQPN293iq85UaA
         GQNfdkCe6ELw2R9s7YVGjeuXuVXdfoB2e8u0qSZs=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f6IHr-0000Is-VJ; Wed, 11 Apr 2018 19:07:55 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 04/15] sequencer: introduce new commands to reset the revision
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
        <cover.1523362469.git.johannes.schindelin@gmx.de>
        <fb797f32b7385317b9dc18524e3863ba627f6c98.1523362469.git.johannes.schindelin@gmx.de>
        <878t9u5ksw.fsf@javad.com>
        <nycvar.QRO.7.76.6.1804111329270.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 11 Apr 2018 19:07:55 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1804111329270.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Wed, 11 Apr 2018 13:36:48 +0200
        (DST)")
Message-ID: <87zi293ew4.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Sergey,
>
> On Wed, 11 Apr 2018, Sergey Organov wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> [...]
>> 
>> > We disallow '#' as label because that character will be used as
>> > separator in the upcoming `merge` command.
>> 
>> Please consider to use # not only in `merge` and `reset`, but in the
>> rest of the commands as well, to unify this new syntax. I.e., right now
>> it seems to be:
>> 
>> pick  abcd A commit message
>> merge beaf # B commit message
>> 
>> I suggest to turn it to:
>> 
>> pick  abcd # A commit message
>> merge beaf # B commit message
>
> First of all, that alignment of pick's and merge's first arguments?

As if it has anything to do with the topic of the issue!

Just a nice look. Let it be:

pick abcd # A commit message
merge beaf # B commit message

if it's that essential indeed.

> That does not exist. If you want aligned arguments, you have to use the
> rebase.abbreviateCommands feature.

It's changing the subject.

> Second: this change would break backwards-compatibility. For almost eleven
> years, we generated `pick abcdef0123 A commit message`.

I thought we already agreed that you have no backward compatibility
issues with this new feature, as it's a new feature, complete re-design,
as you put it yourself:

"This design flaw cannot be fixed. Not without a complete re-design, at
least. This patch series offers such a re-design."

At least could you please answer plain yes/no to this simple question: is
this feature a complete re-design or not? yes/no, please!

> Even if there are no scripts that rely on this form, power users have
> gotten used to it, and I can tell you from experience how unsettling
> even minor visual changes are in everyday operations.
> In short: no, we cannot do that.

You can do that, provided it's complete re-design indeed. You don't wish
to, but you can. Nothing will break and things will be at least a little
bit cleaner.

Each directive having its own dedicated syntax... gosh! No luck getting
syntax description, I'm afraid.

> Just like your proposal to conflate the `merge` and `pick` commands

There was never such proposal. The proposal was not to introduce new
`merge` command when there is already `pick` that could simply be
extended to pick any commit, whatever number of parents it happens to
have.

But provided you decline to even put a # before the commit message...
that proposal is simply a pie in the sky.

> for some perception of consistency: The user experience is more
> important than individual persons' sense of elegance (that might not
> even be shared with the majority).

It's about consistency indeed. Consistent handling of commits is
essential. Consistency is one of the things that bring positive user
experience. You disagree?

Besides, it was bad user experience that forced you to re-design, isn't
it? I'm afraid you miss good opportunity to fix some of your former
mistakes and you make some new. As the discussion goes, it seems you'd
never admit it, the design is set in stone, and my attempts are in fact
pointless.

Overall, I hereby withdraw all my pending suggestions to improve this
patch series.

-- Sergey
