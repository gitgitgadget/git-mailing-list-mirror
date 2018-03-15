Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C1A1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 23:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932863AbeCOXJL (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 19:09:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51493 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933085AbeCOXI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 19:08:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id h21so13363108wmd.1
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TkeZkgRiGbqG+FKjvOXNfIkaJZljSJWQqqDD8jQJpGM=;
        b=RILquKGIEPJMwS7xkaZgVyxagGzEpTaobacBvws2sxZ49f+EFKHipsraUL6i1WWVjQ
         XZbXu0AdRA+KYhs7hDThVybyIMc/KZZLQ61O2Q40RgWVZusXLBdmCBUxi/9mzAQ/9k/f
         hj8+3r2n3F+AiFW9IWKsX2Yu2oYrKoQWevWJ26yzLjmUXh7rNL0YA/CEcGRnOFpLShS/
         uOXYRCmjG1cUhnvusEdC/fUUJYr2RNwCEy1Nh4WF4LBkTi/qE24vrC4Ypy0vYsQbU5ro
         P6GLaORtnlr5ezXu5RuKDsy0pQ+fCrQZKvh1yZX/z30Y+sPipjJKnj+0TEJXKCqWZyO5
         qAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TkeZkgRiGbqG+FKjvOXNfIkaJZljSJWQqqDD8jQJpGM=;
        b=n4votlfnVaUzref6KdSFPLnsItmGN6kMm9PuKd0W4CKOgprDKZrbY+0/SJscfEWxR6
         rSbRRopqknQr9XJEisDcgTBfqpvdkkPqwNz+wI5D3TnC5dPlodDhj2iCHSefcnei48yu
         6SE1EuoRZa6AkxHceiPOjGGl6hDmHxG11QUwBJQvyXM1m3U4Nrh5vwkE/8yk7re+qUj4
         ziWu6VrGzmnCvr9XR9a6p/JNafMA6kf218AjlyfEFybPw2qRDmjrepJzDo5qEvBENcJt
         tJ8j3TLSG3i5WzZp8CNHSseeTsstPVQM1vd5fXLjuu4rT/yiNjD0YSfV/cd04rfcN+Hg
         PDGQ==
X-Gm-Message-State: AElRT7EPuQx5v2FO3Hx+JiEuH4YGZPZwBG9i9Kzyl5Q837jS/0N29YEN
        vGbOuwG4l9+hh0SoiFljz3o=
X-Google-Smtp-Source: AG47ELtmzDjAnYcqB61M6oXIf8w0zptyBdOsPODohCCKra3gtHhYbmpwQr3cma9luowd8PR5CiwQEA==
X-Received: by 10.28.230.79 with SMTP id d76mr40920wmh.161.1521155307048;
        Thu, 15 Mar 2018 16:08:27 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id n49sm10109981wrn.90.2018.03.15.16.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Mar 2018 16:08:26 -0700 (PDT)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
 <877eqgardi.fsf@javad.com> <3f2209e0-c560-5384-c589-3aa83615d688@gmail.com>
 <87efkn6s1h.fsf@javad.com> <de063fba-2882-6194-a889-ad3e9b6b02b9@gmail.com>
 <87lget7p2g.fsf@javad.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <3dbf86bc-cae9-8d6c-a206-cac685938f3d@gmail.com>
Date:   Fri, 16 Mar 2018 00:08:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87lget7p2g.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On 15/03/2018 08:52, Sergey Organov wrote:
> 
> > > 2. The U1' == U2' consistency check in RFC that I still think is worth
> > > to be implemented.
> >
> > At the moment, I think we`d appreciate test cases where it actually 
> > proves useful, as the general consensus seems to be leaning towards 
> > it possibly being annoying (over-paranoid).
> 
> As we now have a simple way to actually check it even in this algorithm,
> I'd suggest command-line option to either relax or enforce the check,
> whatever the default is. For the default, I'd still opt for safety, as
> without it we will gather little experience with this new matter.
> 
> Honestly, without this check available, I'd likely vote for at least an
> option for stopping on every rebased merge, on the ground that if
> rebasing a non-merge could be a trouble, rebasing a merge is at least
> double-trouble, and it's not that frequent anyway. So the check we
> discuss is actually a way to make all the process much less paranoid,
> not more.
> 
> By the way, nobody yet commented about "rerere" behavior that basically
> stops rebasing every time it fires. Do you consider it over-paranoid?

I wouldn`t really know, my workflows are usually/still rather simple, I 
don`t think I`ve ever used it on purpose, and I don`t really remember 
I`ve triggered it by accident, not having it stop for amendment, at least.

You did say you find it annoying yourself, though ;) But also accepting 
it as something that probably has a good reason, though (thus not 
considering it over-paranoid, even if annoying).

> As for test cases, I have none myself, but "-s ours" merge may be an
> example of an actual trouble.
> 
> If we don't treat it specially, then changes to side branch will be
> silently propagated over the merge, that's obviously not what is needed,
> provided user keeps his intention to leave the merge "-s ours".
> 
> If we do treat it specially, it could be the case that the merge in
> question only looks like "-s ours" by pure accident, and thus changes to
> the side branch should be propagated.
> 
> I don't see how we can safely proceed without stop for user assistance.
> Had we already achieved some consensus on this issue?

I don`t know, from what Johannes said in the past, I got an 
impression that this is to be expected ("by design"), and not worth 
bothering to stop for. And he is one of the heaviest users of (merge) 
rebasing I know.

Personally, I still feel it would make sense to stop in case like 
this, indeed, but it`s just my humble (and not necessarily much 
educated) opinion.

> > > Finally, here is a sketch of the implementation that I'd suggest to
> > > use:
> > >
> > > git-rebase-first-parent --onto A' M
> > > tree_U1'=$(git write-tree)
> > > git merge-recursive B -- $tree_U1' B'
> > > tree=$(git write-tree)
> > > M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB')
> > > [ $conflicted_last_merge = "yes" ] ||
> > >   trees-match $tree_U1' $tree || 
> > >   stop-for-user-amendment
> >
> > Yes, in case where we would want the "no-op merge" check (equivalent 
> > to U1' == U2' with original approach), this aligns with something I 
> > would expect.
> >
> > Note that all the "rebase merge commit" steps leading to the check 
> > will/should probably be observed as a single one from user`s perspective 
> > (in worst case ending with nested conflicts we discussed), thus 
> > `$conflicted_last_merge` is not related to `merge-recursive` step(s) 
> > only, but `rebase-first-parent`, too (just in case this isn`t implied).
> >
> > Might be easier to reason about simply as `[ $conflicts = "yes" ] || `
> 
> No. For this check it's essential to ensure that no tweaking of the
> content has been performed under the hood after the user has resolved
> conflicts, i.e., after he has been involved last time.
> 
> If all this is done in one "huge merge" step from user point of view,
> then the check belongs to this merge, as this is the last (and the only)
> one. If it's done in steps (and I vote for it), only the last merge
> status is essential for the check, preceding merges don't matter.

"Huge merge" step (from user point of view) is exactly how I perceived 
Johannes` opinion on it, describing it`s already part of Git user 
experience (with possible nested conflicts), while otherwise possibly 
hard to explain where we are precisely at in the moment of stopping for 
(intermediate) conflict resolution.

Thus only `$conflicts`, meaning anything in the "huge merge", as no user 
action/tweaking/involvement can happen until the "huge merge" is done.

> As I said, putting myself on the user side, I'd prefer entirely separate
> first step of the algorithm, exactly as written, with its own conflict
> resolution, all running entirely the same way as it does with non-merge
> commits. I'm used to it and don't want to learn something new without
> necessity. I.e., I'd prefer to actually see it in two separate stages,
> like this:
> 
> Rebasing mainline of the merge...
> [.. possible conflicts resolution ..]
> Merging in changes to side branch(es)...
> [.. possible conflicts resolution ..]
> 
> And if the second stage gives non-trivial conflicts, I'd like to have a
> simple way to just do "merge -s ours <heads>" on top of already rebased
> mainline of the merge and go with it. Note that the latter is
> significantly different than re-merging everything from scratch, that
> would be the only choice with "all-in-one" approach, and it essentially
> gives me back those simple "rebase first parent and just record other
> parents" semantics when needed.

I`m undecided here, and while I do see a point in what you`re saying, 
this being new to general public I dont`t think you being accustomed 
to it is a very strong argument :)

Yes, having more steps would mean more power/options to the user, but 
more complexity to explain to and guide him through as well, not really 
sure where the line should be drawn - for the first time, at least.

Also note that, for example, in case side branch(es) dropped some 
commits (interactively or otherwise), first step alone would still 
reintroduce those dropped changes, thus later possible `merge -s ours 
<heads>` would be a pretty bad "evil merge" case and a wrong thing to 
do in general.

Regards, Buga
