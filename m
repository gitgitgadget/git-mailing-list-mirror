Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F31F91F404
	for <e@80x24.org>; Tue, 27 Mar 2018 05:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750873AbeC0Fvz (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 01:51:55 -0400
Received: from mail.javad.com ([54.86.164.124]:37893 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750742AbeC0Fvy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 01:51:54 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 0A1A63EA25;
        Tue, 27 Mar 2018 05:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522129913;
        bh=P46CYz7zThpKL4JY0yFA1rynJ5IBh3FZkavfupJ5R1Y=; l=4229;
        h=Received:From:To:Subject;
        b=eGEPVJdTqFsOTsbDYn+OxyUUgkhnEwufsModksUIXiUXWYVhk4F8NOSeCjN1/BMZg
         UaAWBDfPDdSkyLLQ+Irg2yqQXa75SWlJVTbJQkzRu6DRMCGpmfbB8g4dhWIlT/riPA
         pcU0uH6A2x6NQYbAdgAkL3ZXr/V+tGnBT9gmbvbI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522129913;
        bh=P46CYz7zThpKL4JY0yFA1rynJ5IBh3FZkavfupJ5R1Y=; l=4229;
        h=Received:From:To:Subject;
        b=eGEPVJdTqFsOTsbDYn+OxyUUgkhnEwufsModksUIXiUXWYVhk4F8NOSeCjN1/BMZg
         UaAWBDfPDdSkyLLQ+Irg2yqQXa75SWlJVTbJQkzRu6DRMCGpmfbB8g4dhWIlT/riPA
         pcU0uH6A2x6NQYbAdgAkL3ZXr/V+tGnBT9gmbvbI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522129913;
        bh=P46CYz7zThpKL4JY0yFA1rynJ5IBh3FZkavfupJ5R1Y=; l=4229;
        h=Received:From:To:Subject;
        b=eGEPVJdTqFsOTsbDYn+OxyUUgkhnEwufsModksUIXiUXWYVhk4F8NOSeCjN1/BMZg
         UaAWBDfPDdSkyLLQ+Irg2yqQXa75SWlJVTbJQkzRu6DRMCGpmfbB8g4dhWIlT/riPA
         pcU0uH6A2x6NQYbAdgAkL3ZXr/V+tGnBT9gmbvbI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522129913;
        bh=P46CYz7zThpKL4JY0yFA1rynJ5IBh3FZkavfupJ5R1Y=; l=4229;
        h=Received:From:To:Subject;
        b=eGEPVJdTqFsOTsbDYn+OxyUUgkhnEwufsModksUIXiUXWYVhk4F8NOSeCjN1/BMZg
         UaAWBDfPDdSkyLLQ+Irg2yqQXa75SWlJVTbJQkzRu6DRMCGpmfbB8g4dhWIlT/riPA
         pcU0uH6A2x6NQYbAdgAkL3ZXr/V+tGnBT9gmbvbI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522129913;
        bh=P46CYz7zThpKL4JY0yFA1rynJ5IBh3FZkavfupJ5R1Y=; l=4229;
        h=Received:From:To:Subject;
        b=eGEPVJdTqFsOTsbDYn+OxyUUgkhnEwufsModksUIXiUXWYVhk4F8NOSeCjN1/BMZg
         UaAWBDfPDdSkyLLQ+Irg2yqQXa75SWlJVTbJQkzRu6DRMCGpmfbB8g4dhWIlT/riPA
         pcU0uH6A2x6NQYbAdgAkL3ZXr/V+tGnBT9gmbvbI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522129913;
        bh=P46CYz7zThpKL4JY0yFA1rynJ5IBh3FZkavfupJ5R1Y=; l=4229;
        h=Received:From:To:Subject;
        b=eGEPVJdTqFsOTsbDYn+OxyUUgkhnEwufsModksUIXiUXWYVhk4F8NOSeCjN1/BMZg
         UaAWBDfPDdSkyLLQ+Irg2yqQXa75SWlJVTbJQkzRu6DRMCGpmfbB8g4dhWIlT/riPA
         pcU0uH6A2x6NQYbAdgAkL3ZXr/V+tGnBT9gmbvbI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522129913;
        bh=P46CYz7zThpKL4JY0yFA1rynJ5IBh3FZkavfupJ5R1Y=; l=4229;
        h=Received:From:To:Subject;
        b=eGEPVJdTqFsOTsbDYn+OxyUUgkhnEwufsModksUIXiUXWYVhk4F8NOSeCjN1/BMZg
         UaAWBDfPDdSkyLLQ+Irg2yqQXa75SWlJVTbJQkzRu6DRMCGpmfbB8g4dhWIlT/riPA
         pcU0uH6A2x6NQYbAdgAkL3ZXr/V+tGnBT9gmbvbI=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f0hWR-0000E8-Cd; Tue, 27 Mar 2018 08:51:51 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com> <87a7vss6ax.fsf@javad.com>
        <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
        <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
        <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
        <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
        <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
        <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
        <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
        <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
        <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com>
        <nycvar.QRO.7.76.6.1803111301340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com>
        <nycvar.QRO.7.76.6.1803121142550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <243ca23d-77a9-4ae1-a120-de6c6b195cdc@gmail.com>
        <nycvar.QRO.7.76.6.1803261455130.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Tue, 27 Mar 2018 08:51:51 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803261455130.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Mon, 26 Mar 2018 15:07:32 +0200
        (DST)")
Message-ID: <87woxyf4lk.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Buga,
>
> On Tue, 13 Mar 2018, Igor Djordjevic wrote:
>
>> On 12/03/2018 11:46, Johannes Schindelin wrote:
>> > 
>> > > Sometimes one just needs to read the manual, and I don`t really
>> > > think this is a ton complicated, but just something we didn`t really
>> > > have before (real merge rebasing), so it requires a moment to grasp
>> > > the concept.
>> > 
>> > If that were the case, we would not keep getting bug reports about
>> > --preserve-merges failing to reorder patches.
>> 
>> Not sure where that is heading to, but what I`m arguing about is that 
>> introducing new commands and concepts (`merge`, and with `-R`) just 
>> makes the situation even worse (more stuff to grasp).
>
> The problem with re-using `pick` is that its concept does not apply to
> merges. The cherry-pick of a non-merge commit is well-defined: the current
> HEAD is implicitly chosen as the cherry-picked commit's (single) parent
> commit. There is no ambiguity here.
>
> But for merge commits, we need to specify the parent commits (apart from
> the first one) *explicitly*. There was no need for that in the `pick`
> command, nor in the concept of a cherry-pick.
>
>> Reusing existing concepts where possible doesn`t have this problem.
>
> Existing concepts are great. As long as they fit the requirements of the
> new scenarios. In this case, `pick` does *not* fit the requirement of
> "rebase a merge commit".

It does, provided you use suitable syntax.

> If you really want to force the `pick` concept onto the use case where
> you need to "reapply" merges, then the closest you get really is
> Sergey's idea, which I came to reject when considering its practical
> implications.

Which one, and what are the implications that are bad, I wonder?

> Even so, you would have to make the `pick` command more complicated to
> support merge commits. And whatever you would do to extend the `pick`
> command would *not make any sense* to the current use case of the `pick`
> command.

It would rather make a lot of sense. Please don't use 'merge' to pick
commits, merge ones or not!

> The real problem, of course, is that a non-merge commit, when viewed from
> the perspective of the changes it introduced, is a very different beast
> than a merge commit: it does not need to reconcile changes, ever, because
> there is really only one "patch" to one revision. That is very different
> from a merge commit, whose changes can even disagree with one another (and
> in fact be resolved with changes disagreeing *yet again*)!

You'd still 'pick' it though, not 'merge'. You don't merge "merge
commit", it makes no sense. It only makes perfect sense when you get rid
of original "merge commit" and re-merge from scratch, as you were doing
till now.

>> > > Saying in favor of `--rebase-merges`, you mean as a separate option,
>> > > alongside `--recreate-merges` (once that series lands)?
>> > 
>> > No. I am against yet another option. The only reason I pollute the
>> > option name space further with --recreate-merges is that it would be
>> > confusing to users if the new mode was called --preserve-merges=v2
>> > (but work *totally differently*).
>> 
>> I see. So I take you`re thinking about renaming `--recreate-merges` to
>> `--rebase-merges` instead?
>
> Thinking about it. Nothing will happen before v2.17.0 on that front,
> though, because -- unlike you gentle people -- I have to focus on
> stabilizing Git's code base now.
>
>> That would seem sensible, too, I think, being the default usage mode in
>> the first place. Being able to actually (re)create merges, too, once
>> user goes interactive, would be "just" an additional (nice and powerful)
>> feature on top of it.
>
> The implementation detail is, of course, that I will introduce this with
> the technically-simpler strategy: always recreating merge commits with the
> recursive strategy. A follow-up patch series will add support for rebasing
> merge commits, and then use it by default.

Switching to use it by default would be backward incompatible again? Yet
another option to obsolete? Sigh. 

-- Sergey
