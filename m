Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90A031F404
	for <e@80x24.org>; Mon, 19 Mar 2018 21:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971539AbeCSVfV (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 17:35:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53836 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965116AbeCSVfN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 17:35:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id e194so17768946wmd.3
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s0Pip5X4ianUzTZz+U8KxB9I1l5sPBhS15zVk86/Cfs=;
        b=GU3uyITqyZJCwihnsBh3Ch8j6qJDWyz8iCHn8vHyZJXGZX2vkVZPqTgLBF1X1NPRWm
         hymJoQI8kny8mQnZoxiLLb6p8qSm8MBASAvD0Sm9C7CjQE5e//IcLA3n/B+3OiZ0xmT4
         B8o0FDj02Jyy2VD5Wto0rJacU81ZaGO5Gr3R00lhOREExKsh0DGNuG3svjGfb2KDRfaK
         JL6IsOjoJejPLV/2DrGEqa1n1cfR1SJvtglO89IAsGyQasVj1XbgpR82gcflhVj+Z6vl
         JOwrRjyjgygAhBJ33tMKDYBAms+8HnYmYFH9kwnkdxmivGWUJS+xla2r/Fk0cjMbnMX7
         woaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s0Pip5X4ianUzTZz+U8KxB9I1l5sPBhS15zVk86/Cfs=;
        b=iy3gNKrrRz4Nap/jaVElxT8NSK7w7ysK6N1FQl+wCto4AXGM1GFpFX9NAX672KR+x1
         fEoHhskpePOBRCwWh/iqJpd2Q9hFKW6rtzuLVtUHmzvR3LGNPURwaUq+QeWp6cqRv3Kr
         5f109A0si6vP6ZMHhqP96m/ifPIBsYfLEtl7BId5yCBqZuaAbbIAuo+BA7k9Hd0Cmq3y
         hukzyk7KnJZe9G4VeeUYLcjZbN7luqUHIJ6+bqdg6MV/hzfsXHzA0Rk45w2sQ+DJRnQl
         DXV4v+gxB6hoAfJR69gvetu+iOx/oxWwR7cRNWS215lrUz7SvL03IeZf6hqfzyY5QGOZ
         F1ZQ==
X-Gm-Message-State: AElRT7FwBPZR/jNX6+d7DMbqaJ3X2zut2QIaU991Mrcklk7hoIWG6L52
        FAsp/rFQLY6IYPWdSZGYXLyVz01n
X-Google-Smtp-Source: AG47ELvkEe/xWP24zWNEtsYVj8Sv2jQ+lfAUTKhXHOl8QI06RFmJrVb2AMF2w2itlQZ8ca6fLNcuTg==
X-Received: by 10.28.140.11 with SMTP id o11mr197954wmd.82.1521495312255;
        Mon, 19 Mar 2018 14:35:12 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.177.153])
        by smtp.gmail.com with ESMTPSA id k18sm149806wmd.4.2018.03.19.14.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 14:35:11 -0700 (PDT)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
 <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <2749ce78-8917-c821-6116-0c8d67b5e16e@gmail.com> <87vadyd9az.fsf@javad.com>
 <d5e68db4-8006-2c0e-bc21-0b136503edd9@gmail.com>
 <d50a4099-9b3a-5aa9-c304-160c62330056@gmail.com> <87h8pc1uxr.fsf@javad.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <34e8d563-a035-b09e-e959-748f2b4f4b99@gmail.com>
Date:   Mon, 19 Mar 2018 22:35:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87h8pc1uxr.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On 19/03/2018 06:44, Sergey Organov wrote:
> 
> > > > > > Second side note: if we can fast-forward, currently we prefer
> > > > > > that, and I think we should keep that behavior with -R, too.
> > > > >
> > > > > I agree.
> > > >
> > > > I'm admittedly somewhat lost in the discussion, but are you
> > > > talking fast-forward on _rebasing_ existing merge? Where would it
> > > > go in any of the suggested algorithms of rebasing and why?
> > > >
> > > > I readily see how it can break merges. E.g., any "git merge
> > > > --ff-only --no-ff" merge will magically disappear. So, even if
> > > > somehow supported, fast-forward should not be performed by default
> > > > during _rebasing_ of a merge.
> > >
> > > Hmm, now that you brought this up, I can only agree, of course.
> > >
> > > What I had in my mind was more similar to "no-rebase-cousins", like 
> > > if we can get away without actually rebasing the merge but still 
> > > using the original one, do it. But I guess that`s not what Johannes 
> > > originally asked about.
> > >
> > > This is another definitive difference between rebasing (`pick`?) and 
> > > recreating (`merge`) a merge commit - in the case where we`re rebasing, 
> > > of course it doesn`t make sense to drop commit this time (due to 
> > > fast-forward). This does make sense in recreating the merge (only).
> >
> > Eh, I might take this back. I think my original interpretation (and 
> > agreement) to fast-forwarding is correct.
> >
> > But the confusion here comes from `--no-ff` as used for merging, as 
> > opposed to `--no-ff` as used for rebasing. I _think_ Johannes meant 
> > the latter one.
> >
> > In rebasing, `--no-ff` means that even if a commit inside todo list 
> > isn`t to be changed, do not reuse it but create a new one. Here`s 
> > excerpt from the docs[1]:
> >
> >   --no-ff
> >     With --interactive, cherry-pick all rebased commits instead of 
> >     fast-forwarding over the unchanged ones. This ensures that the 
> >     entire history of the rebased branch is composed of new commits.
> >
> >     Without --interactive, this is a synonym for --force-rebase.
> >
> >
> > So fast-forwarding in case of rebasing (merge commits as well) is 
> > something you would want by default, as it wouldn`t drop/lose 
> > anything, but merely reuse existing commit (if unchanged), instead of 
> > cherry-picking (rebasing) it into a new (merge) commit anyway.
> 
> This sounds like breakage. E.g., it seems to be breaking every "-x ours"
> merge out there.

Either you are not understanding how rebase fast-forward works, or 
I`m missing what you are pointing to... Mind explaining how can 
something that`s left unchanged suddenly become a breakage?

> Fast-forwarding existing merge, one way or another, still seems to be
> wrong idea to me, as merge commit is not only about content change, but
> also about joint point at particular place in the DAG.

Not sure what this has to do with rebase fast-forwarding, either - 
nothing changes for fast-forwarded (merge or non-merge) commit in 
question, both content, joint point and everything else stays exactly 
the same. If anything changed, then it can`t/won`t be fast-forwarded, 
being unchanged is a prerequisite.

Let me elaborate a bit. Here`s a starting diagram:

(1) ---X1---X2---X3 (master)
                 |\
                 | A1---A2---A3
                 |            \
                 |             M---C1---C2 (topic)
                 |            /
                 \-B1---B2---B3


With "topic" being active branch, we start interactive rebase with 
`git rebase -i master`. Generated todo list will hold commits A1 to 
A3, B1 to B3, M and C1 to C2.

Now, if we decide to `edit` commit C1, leaving everything else the 
same, fast-forward logic will make the new situation look like this:

(2) ---X1---X2---X3 (master)
                 |\
                 | A1---A2---A3
                 |            \
                 |             M---C1'--C2' (topic)
                 |            /
                 \-B1---B2---B3


Notice how only C1 and C2 changed to C1' and C2'? That`s rebase 
fast-forwarding, noticing earlier commits left unchanged, thus 
reusing original ones.

No matter what, no breakage can happen to M in this case, as it`s 
left (reused) exactly as it was - it`s fast-forward rebased.

If we `edit`-ed commit A2, we would have ended in a situation like this:

(3) ---X1---X2---X3 (master)
                 |\
                 | A1---A2'--A3'
                 |            \
                 |             M'--C1'--C2' (topic)
                 |            /
                 \-B1---B2---B3


This time we have new commits A2', A3', M', C1' and C2' - so 
everything influenced by the change that happened will be changed 
(merge commit as well), where all the rest can still be reused 
(fast-forwarded).

If we had started rebasing with `git rebase -i --no-ff master`, no 
matter which commits we `edit` (or none, even), we would end up with 
this instead:

(4) ---X1---X2---X3 (master)
                 |\
                 | A1'--A2'--A3'
                 |            \
                 |             M'--C1'--C2' (topic)
                 |            /
                 \-B1'--B2'--B3'


So even in case where nothing is changed, no rebase fast-forwarding 
is performed (as requested), and each and every commit is changed (old 
commit replaced with its rebased version, commit hash changed).

Now, if our starting position looked like this instead:

(5) ---X1---X2---X3---X4---X5 (master)
                 |\
                 | A1---A2---A3
                 |            \
                 |             M---C1---C2 (topic)
                 |            /
                 \-B1---B2---B3

... and we simply do `git rebase -i master` again, causing all side 
commits to be rebased onto X5, then no fast forwarding can be done, as 
all commits _are_ changed (by having their parent changed, no matter if 
we additionally edit them or not), so even without `--no-ff` option we 
end up with this:

(6) ---X1---X2---X3---X4---X5 (master)
                           |\
                           | A1'--A2'--A3'
                           |            \
                           |             M'--C1'--C2' (topic)
                           |            /
                           \-B1'--B2'--B3'


Does this settle your concerns, or I`m missing something?

> As for fast-forwarding re-merge, explicitly requested, I'm not sure. On
> one hand, it's inline with the default "git merge" behavior, on the
> other hand, it still feels wrong, somehow.

Regarding fast-forwarding in context of merging, in case where we are 
recreating merges (not rebasing them), following existing `git merge` 
logic might make sense, where I would expect rebasing todo list `merge` 
command to pick-up tricks from `git merge` as needed, like learning 
to accept `--no-ff` option, for example, thus not fast-forwarding 
merges (on request) even when possible.

Though, I do agree that in case you want to recreate an existing merge 
(instead of just rebasing it), `merge` command fast-forwarding might 
probably not be what you want for the most of the time, but I`m afraid 
having rebase todo list `merge` command default behavior different than 
`git merge` default one (in regards to fast-forwarding) would be 
confusing... or not?

From what I could grasp so far, usually Git commands` default 
behavior is (explained to be) chosen per "most common use case", so 
might be non fast-forwarding would be fine as default for rebase todo 
list `merge` command, even though different than `git merge` itself...?

Regards, Buga
