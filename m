Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2F8A1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 06:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750890AbeBIGL3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 01:11:29 -0500
Received: from mail.javad.com ([54.86.164.124]:41237 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbeBIGL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 01:11:28 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 6B9C63E8DB;
        Fri,  9 Feb 2018 06:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518156687;
        bh=pddRqS6ksf95FobqqvYB29lWzTr+c68iTerkO0nPhUA=; l=9440;
        h=Received:From:To:Subject;
        b=BcKDXmg6hhk2+0tfsv4P4mvxDulEeuKyIc4r/JAyuDq+WBIQRYleALw/sX5i5X2cM
         JOvt3kHCmx/FAeibsPhaEmmsN2B9aMIg2Hue4NnfU3MDUHVJbUIeNlRk10/3suOgDP
         0AAR1asprd/Xw77unrWj5icX2Fa7atIfTpBFR35c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518156687;
        bh=pddRqS6ksf95FobqqvYB29lWzTr+c68iTerkO0nPhUA=; l=9440;
        h=Received:From:To:Subject;
        b=BcKDXmg6hhk2+0tfsv4P4mvxDulEeuKyIc4r/JAyuDq+WBIQRYleALw/sX5i5X2cM
         JOvt3kHCmx/FAeibsPhaEmmsN2B9aMIg2Hue4NnfU3MDUHVJbUIeNlRk10/3suOgDP
         0AAR1asprd/Xw77unrWj5icX2Fa7atIfTpBFR35c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518156687;
        bh=pddRqS6ksf95FobqqvYB29lWzTr+c68iTerkO0nPhUA=; l=9440;
        h=Received:From:To:Subject;
        b=BcKDXmg6hhk2+0tfsv4P4mvxDulEeuKyIc4r/JAyuDq+WBIQRYleALw/sX5i5X2cM
         JOvt3kHCmx/FAeibsPhaEmmsN2B9aMIg2Hue4NnfU3MDUHVJbUIeNlRk10/3suOgDP
         0AAR1asprd/Xw77unrWj5icX2Fa7atIfTpBFR35c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518156687;
        bh=pddRqS6ksf95FobqqvYB29lWzTr+c68iTerkO0nPhUA=; l=9440;
        h=Received:From:To:Subject;
        b=BcKDXmg6hhk2+0tfsv4P4mvxDulEeuKyIc4r/JAyuDq+WBIQRYleALw/sX5i5X2cM
         JOvt3kHCmx/FAeibsPhaEmmsN2B9aMIg2Hue4NnfU3MDUHVJbUIeNlRk10/3suOgDP
         0AAR1asprd/Xw77unrWj5icX2Fa7atIfTpBFR35c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518156687;
        bh=pddRqS6ksf95FobqqvYB29lWzTr+c68iTerkO0nPhUA=; l=9440;
        h=Received:From:To:Subject;
        b=BcKDXmg6hhk2+0tfsv4P4mvxDulEeuKyIc4r/JAyuDq+WBIQRYleALw/sX5i5X2cM
         JOvt3kHCmx/FAeibsPhaEmmsN2B9aMIg2Hue4NnfU3MDUHVJbUIeNlRk10/3suOgDP
         0AAR1asprd/Xw77unrWj5icX2Fa7atIfTpBFR35c=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1ek1u8-0004HI-Vs; Fri, 09 Feb 2018 09:11:25 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
        <87k1vpqq85.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802071818240.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Fri, 09 Feb 2018 09:11:24 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1802071818240.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Wed, 7 Feb 2018 18:36:06 +0100
        (STD)")
Message-ID: <87o9kyitf7.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> On Wed, 7 Feb 2018, Sergey Organov wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> > +--recreate-merges::
>> > +	Recreate merge commits instead of flattening the history by replaying
>> > +	merges. Merge conflict resolutions or manual amendments to merge
>> > +	commits are not preserved.
>> 
>> I wonder why you guys still hold on replaying "merge-the-operation"
>> instead of replaying "merge-the-result"?
>
> This misses the point of rebasing: you want to replay the changes.

What this comment has to do with the statement to which it's supposed to
be a reply? Sounds like topic change to me. Please clarify if it isn't.

>
>> The latter, the merge commit itself, no matter how exactly it was
>> created in the first place, is the most valuable thing git keeps about
>> the merge, and you silently drop it entirely!
>
> You miss another very crucial point.

What was the first crucial point I miss? Do you rather agree that the
point you are replying to with this is very crucial one as well?

> I don't blame you, as you certainly have not used the Git garden
> shears for years.

Thanks a lot!

> Let me explain the scenario which comes up plenty of times in my work with
> Git for Windows. We have a thicket of some 70 branches on top of git.git's
> latest release. These branches often include fixup! and squash! commits
> and even more complicated constructs that rebase cannot handle at all at
> the moment, such as reorder-before! and reorder-after! (for commits that
> really need to go into a different branch).

I sympathize, but a solution that breaks even in simple cases can't be
used reliably to solve more complex problems, sorry. Being so deep
into your problems, I think you maybe just aren't seeing forest for the
trees [1].

> Even if you do not have such a complicated setup, it is quite possible
> that you need to include a commit in your development that needs to be
> dropped before contributing your work. Think e.g. removing the `-O2` flag
> when compiling with GCC because GDB gets utterly confused with executables
> compiled with `-O2` while single-stepping. This could be an initial commit
> called `TO-DROP` or some such.
>
> And guess what happens if you drop that `pick` line in your todo list and
> then the `merge` command simply tries to re-create the original merge
> commit's changes?
>
> Exactly. The merge will become an evil merge, and will introduce that very
> much not-wanted and therefore-dropped changes.

Okay, Houston, we've had a problem here.

I'm sure you'll be able to come-up with suitable solution once you start
to think about it positively, but automatic unguided silent re-merge is
still not the right answer, for the same reason of distortion of user
changes.

As for "evil merges"... I don't want to get too far from original
subject to even start discussing this.

>> OTOH, git keeps almost no information about "merge-the-operation", so
>> it's virtually impossible to reliably replay the operation
>> automatically, and yet you try to.
>
> That is true. However, the intended use case is not to allow you to
> recreate funny merges. Its use case is to allow you to recreate
> merges.

Then it at least should behave accordingly, e.g., stop after every such
occurrence, for user assistance. As an example, see what rerere does
when it fires, even though it's much more reliable than this blind
re-merge.

But the actual problem here is that almost any merge but those made with
pure "git merge", no options, no conflicts, no edits, no nothing,
becomes "funny" and is being destroyed, sometimes in a weird way, by
silently creating something different instead of original.

> At a later stage, I might introduce support to detect `-s ours` merges,
> because they are easy to detect. But even then, it will be an opt-in.

So you are going to fix one particular case that is "easy to detect"
(and fix). Does it mean you do realize it's a problem, but fail to see that
it's _fundamental_ problem with current approach?

I think you start from the wrong end. I think that any merge should be
made reproducible first (with possible guidance from the user when
required, as usual), and then advanced features for complex history
tweaking should come, not the other way around.

I feel that any solution that fails to exactly reproduce original
history, unless it is to be actually changed, is flawed, and we will
continue to hit our heads on sharp corners like "merge -s ours", most of
which will be not that simple to detect and fix, for an unforeseeable
future.

>
>> IMHO that was severe mistake in the original --preserve-merges, and you
>> bring with you to this new --recreate-merges... It's sad.
>
> Please refrain from drawing this discussion into an emotional direction.
> That is definitely not helpful.

I don't actually blame anybody for that original implementation in the
first place. It was made based on the actual needs, and that's perfectly
fine with me, however quick-and-dirty it was. Keeping it quick-and-dirty
for years isn't that fine though.

And I do get somewhat emotional seeing this, all right. Look what you
did. We had one pet that strikes badly (with corresponding warning label
put on it in the manual), and now we have another one that would strike
as bad! I'm even afraid that I'm unfortunately not that young anymore to
get /properly/ emotional about it.

>> Even more sad as solution is already known for years:
>> 
>>     bc00341838a8faddcd101da9e746902994eef38a
>>     Author: Johannes Sixt <j6t@kdbg.org>
>>     Date:   Sun Jun 16 15:50:42 2013 +0200
>>     
>>         rebase -p --first-parent: redo merge by cherry-picking first-parent change
>> 
>> and it works like a charm.
>
> It might work for you, as you probably used --preserve-merges, and dealt
> with the fact that you could neither drop nor reorder commits.
>
> So --preserve-merges --first-parent is probably what you were looking
> for.

No. What I'm looking for is for my history to be kept as intact as
possible during rebase, unless I explicitly ask to change it, be it
--preserve-merges, or --recreate-merges, interactive or not. Is it too
much to ask for?

And no, I don't think --preserve-merges --first-parent is the right
answer either, in general, even though it did suit most of my purposes
indeed (in fact I simply patched --preserve-merges in my local git).

> Instead, --recreate-merges is all about allowing the same level of
> freedom as with regular interactive rebases, but recreating the
> original commit topology (and allowing to change it, too).

That's a very good thing and a very nice job as a whole, sure! If it
weren't I'd not even bother to raise this topic. But provided you
realize what problem "--preserve-merges --first-parent" would solve for
non-interactive use, you should realize that you have exactly the same
problem unsolved with the new --recreate-merges.

> Therefore, I think that it would be even harmful to allow
> --recreate-merges --first-parent *because it would cause evil merges*!

Once again, for me it seems you are thinking about it from the wrong
end, and this indeed won't work, but for different reasons than you
think.

[And please, stop frightening us with those "evil merge" thingy!]

> And I totally could see myself being vexed again about options that worked
> perfectly well (just like --preserve-merges) being completely messed up by
> allowing it to be combined with options *that they cannot work with* (just
> like --preserve-merges --interactive, a *huge* mistake causing so many
> annoying "bug" reports: I *never intended it that way because I knew it
> would not work as users expect*).

IMHO it's a minor problem. At least there was a warning there in the
manual, and nobody actually claimed reliable support for the feature.

> So no, I do not think that --recreate-merges --first-parent is a good idea
> at all. Unless you try to do that non-interactively only, *and disallow it
> in interactive mode*. Because the entire point of the interactive rebase
> is to allow reordering and dropping commits, in --recreate-merges even
> moving, introducing and dropping merge commits. The --first-parent option
> flies in the face of this idea.

Forget about --first-parent, please! The patch that introduced it was
only meant to show the general way of replaying a merge. Actual
suggestion is to implement proper support right with --preserve-merges,
or call it --recreate-merges, or --keep-topology, or
--no-flatten-history, whatever [2].

-- Sergey

[1] Actually I wonder how, with such a complex setup, you seem to never
step onto the problem I regularly have? Don't you ever have sub-topic
branches on top of those 70? How do you ensure none of the merges you
are rebasing are "funny", as you call them?

[2] Proper implementation of this will likely need some tweaks to the
todo list, such as "rm" command for a commit to be removed, explicit
distinguish between "merge-redo" and "merge-pick" (or even "merge-dwim")
in the list, or something like that. But to start actually thinking
about implementation, we need to agree that silent dropping user changes
is a huge problem, be it "evil merge" or something else that sounds even
more "dangerous".
