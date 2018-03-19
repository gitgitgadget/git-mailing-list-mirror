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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AC181F404
	for <e@80x24.org>; Mon, 19 Mar 2018 06:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755169AbeCSGBX (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 02:01:23 -0400
Received: from mail.javad.com ([54.86.164.124]:33381 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752285AbeCSGBW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 02:01:22 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 33D083E89E;
        Mon, 19 Mar 2018 06:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521439281;
        bh=YPvYhKiFBjOsiV+ctvdi8JHrPJjCEcovTEhjdraDx30=; l=4156;
        h=Received:From:To:Subject;
        b=gmrq1PO8eG/Dk7zlkbcwrSzmSbkbxoDxFPUfWl51Y8lbLwmLRfS6R+NqxCzfNysri
         Hw/tWNygLthSwZ9ZfxtirhJL9pDAlxpBdzXQegNj+KnDGkxlULa5EazySuTgr51Ib8
         HgBn5YfUxTk3ySDPyrWRrjgabqMEByJh+sOs+M2g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521439281;
        bh=YPvYhKiFBjOsiV+ctvdi8JHrPJjCEcovTEhjdraDx30=; l=4156;
        h=Received:From:To:Subject;
        b=gmrq1PO8eG/Dk7zlkbcwrSzmSbkbxoDxFPUfWl51Y8lbLwmLRfS6R+NqxCzfNysri
         Hw/tWNygLthSwZ9ZfxtirhJL9pDAlxpBdzXQegNj+KnDGkxlULa5EazySuTgr51Ib8
         HgBn5YfUxTk3ySDPyrWRrjgabqMEByJh+sOs+M2g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521439281;
        bh=YPvYhKiFBjOsiV+ctvdi8JHrPJjCEcovTEhjdraDx30=; l=4156;
        h=Received:From:To:Subject;
        b=gmrq1PO8eG/Dk7zlkbcwrSzmSbkbxoDxFPUfWl51Y8lbLwmLRfS6R+NqxCzfNysri
         Hw/tWNygLthSwZ9ZfxtirhJL9pDAlxpBdzXQegNj+KnDGkxlULa5EazySuTgr51Ib8
         HgBn5YfUxTk3ySDPyrWRrjgabqMEByJh+sOs+M2g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521439281;
        bh=YPvYhKiFBjOsiV+ctvdi8JHrPJjCEcovTEhjdraDx30=; l=4156;
        h=Received:From:To:Subject;
        b=gmrq1PO8eG/Dk7zlkbcwrSzmSbkbxoDxFPUfWl51Y8lbLwmLRfS6R+NqxCzfNysri
         Hw/tWNygLthSwZ9ZfxtirhJL9pDAlxpBdzXQegNj+KnDGkxlULa5EazySuTgr51Ib8
         HgBn5YfUxTk3ySDPyrWRrjgabqMEByJh+sOs+M2g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521439281;
        bh=YPvYhKiFBjOsiV+ctvdi8JHrPJjCEcovTEhjdraDx30=; l=4156;
        h=Received:From:To:Subject;
        b=gmrq1PO8eG/Dk7zlkbcwrSzmSbkbxoDxFPUfWl51Y8lbLwmLRfS6R+NqxCzfNysri
         Hw/tWNygLthSwZ9ZfxtirhJL9pDAlxpBdzXQegNj+KnDGkxlULa5EazySuTgr51Ib8
         HgBn5YfUxTk3ySDPyrWRrjgabqMEByJh+sOs+M2g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521439281;
        bh=YPvYhKiFBjOsiV+ctvdi8JHrPJjCEcovTEhjdraDx30=; l=4156;
        h=Received:From:To:Subject;
        b=gmrq1PO8eG/Dk7zlkbcwrSzmSbkbxoDxFPUfWl51Y8lbLwmLRfS6R+NqxCzfNysri
         Hw/tWNygLthSwZ9ZfxtirhJL9pDAlxpBdzXQegNj+KnDGkxlULa5EazySuTgr51Ib8
         HgBn5YfUxTk3ySDPyrWRrjgabqMEByJh+sOs+M2g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521439281;
        bh=YPvYhKiFBjOsiV+ctvdi8JHrPJjCEcovTEhjdraDx30=; l=4156;
        h=Received:From:To:Subject;
        b=gmrq1PO8eG/Dk7zlkbcwrSzmSbkbxoDxFPUfWl51Y8lbLwmLRfS6R+NqxCzfNysri
         Hw/tWNygLthSwZ9ZfxtirhJL9pDAlxpBdzXQegNj+KnDGkxlULa5EazySuTgr51Ib8
         HgBn5YfUxTk3ySDPyrWRrjgabqMEByJh+sOs+M2g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521439281;
        bh=YPvYhKiFBjOsiV+ctvdi8JHrPJjCEcovTEhjdraDx30=; l=4156;
        h=Received:From:To:Subject;
        b=gmrq1PO8eG/Dk7zlkbcwrSzmSbkbxoDxFPUfWl51Y8lbLwmLRfS6R+NqxCzfNysri
         Hw/tWNygLthSwZ9ZfxtirhJL9pDAlxpBdzXQegNj+KnDGkxlULa5EazySuTgr51Ib8
         HgBn5YfUxTk3ySDPyrWRrjgabqMEByJh+sOs+M2g=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1exnrD-0003Lb-2H; Mon, 19 Mar 2018 09:01:19 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
        <877eqgardi.fsf@javad.com>
        <3f2209e0-c560-5384-c589-3aa83615d688@gmail.com>
        <87efkn6s1h.fsf@javad.com>
        <de063fba-2882-6194-a889-ad3e9b6b02b9@gmail.com>
        <87lget7p2g.fsf@javad.com>
        <3dbf86bc-cae9-8d6c-a206-cac685938f3d@gmail.com>
        <87vadw3297.fsf@javad.com>
        <095bbfe2-e095-a4b6-d337-740553acd9ec@gmail.com>
Date:   Mon, 19 Mar 2018 09:01:19 +0300
In-Reply-To: <095bbfe2-e095-a4b6-d337-740553acd9ec@gmail.com> (Igor
        Djordjevic's message of "Sat, 17 Mar 2018 04:04:27 +0100")
Message-ID: <87a7v41u4w.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> Hi Sergey,
>
> On 16/03/2018 08:31, Sergey Organov wrote:
>> 
>> > > As I said, putting myself on the user side, I'd prefer entirely
>> > > separate first step of the algorithm, exactly as written, with
>> > > its own conflict resolution, all running entirely the same way as
>> > > it does with non-merge commits. I'm used to it and don't want to
>> > > learn something new without necessity. I.e., I'd prefer to
>> > > actually see it in two separate stages, like this:
>> > >
>> > > Rebasing mainline of the merge...
>> > > [.. possible conflicts resolution ..]
>> > > Merging in changes to side branch(es)...
>> > > [.. possible conflicts resolution ..]
>> > >
>> > > And if the second stage gives non-trivial conflicts, I'd like to
>> > > have a simple way to just do "merge -s ours <heads>" on top of
>> > > already rebased mainline of the merge and go with it. Note that
>> > > the latter is significantly different than re-merging everything
>> > > from scratch, that would be the only choice with "all-in-one"
>> > > approach, and it essentially gives me back those simple "rebase
>> > > first parent and just record other parents" semantics when
>> > > needed.
>> > 
>> > [...]
>> > 
>> > Also note that, for example, in case side branch(es) dropped some 
>> > commits (interactively or otherwise), first step alone would still 
>> > reintroduce those dropped changes, thus later possible `merge -s ours 
>> > <heads>` would be a pretty bad "evil merge" case and a wrong thing to 
>> > do in general.
>> 
>> Except that my presumption is that the second step has been run already
>> and has stopped due to conflicts, so I see the conflicting result of
>> dropping those commits on side branch(es), check the previous state of
>> the right side of the conflicting merge, and decide those state, being
>> the result of the fist step after possibly demanding conflicts
>> resolution, is fine after all. Thus I just re-merge -x ours the
>> branch(es), instead of re-merging everythig from scratch only to finally
>> get back to the same result, be it evil or not, the hard way.
>
> Might be my comment missed the point here, it should have been more 
> about what you said regarding "first step having its own conflict 
> resolution" - in case of dropped commits on side branch(es), you would 
> be trying to resolve conflicts using one tree that doesn`t/shouldn`t 
> even exist anymore (rebased merge commit first parent changes), which 
> might be pretty confusing, only to find the "second stage" later 
> removing changes that you might have actually picked as "first stage" 
> conflict resolution, making it all even worse.
>
> Only once "huge merge" is done completely (meaning all steps involved 
> in merge commit rebasing), user can have a more realistic overview of 
> (possibly nested, even) conflicts to resolve (and knowing his resolution 
> will actually stick).
>
> Regarding `merge -s ours <heads>` you mention, as you say it would 
> happen only after "huge merge" is complete (with possible conflicts), 
> I guess it`s unrelated to having "merge commit rebasing" happen in 
> one go ("huge merge"), or iteratively, in stages (from user`s 
> perspective, unrelated to underlying implementation)...?
>
> Thus I`m questioning use-case for step-by-step merge commit rebasing 
> where each stage has its own conflict resolution, in the face of it 
> possibly being more confusing than helpful.
>
> Otherwise, I see the point in what you would like to accomplish with 
> that `merge -s ours <heads>` (not from scratch), but I`m not sure 
> what would be the most sane way to allow it, and if it would be worth 
> it in the first place, seeming to be a pretty exotic use case.

I find your arguments sound, except that I somehow feel that "exotic use
case" will solve 90% of conflicting merge rebases, as merges are about
the mainline in the first place. It's likely nothing more than personal
feeling though, so I'd simply agree to disagree at this point, at least
until some actual experience is gained.

-- Sergey
