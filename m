Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D501F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 21:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbcHCVsF (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 17:48:05 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:33143 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758378AbcHCVsE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 17:48:04 -0400
Received: by mail-io0-f174.google.com with SMTP id 38so256170868iol.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 14:47:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ad/tMshN8IatcqmyI7i6ALdMxOw0ZSS+pveywAs/onQ=;
        b=o1PrCYtG0vX5czHIIoT9OcrFLpc83yYy1pS67E1sGDLpfoQRYrdAqNN75yAfacAYmY
         tEHHRY1H8fABV7dtfGO62cTQM4bj35Y3rzdHmjKQUvXwoJm+TS/GkwZMXZTXkcWn+MvT
         quUJ4Akm6PHedI5P6qe06JdaTNQ8CM360Vv/Btl1nGsGz4cZ3SxoJuXZ1HmyQmSdqHOj
         vBd2lCv8J3bUkbwBPjzm09LKan3Lhhet4FDLwUllfq38gyhz9k4nqF+f19uxppH4DtGP
         eXgDul6dZZgpWm8mDKOGmWNo7BTKZ4IqlS9Rf8+lmqiLyB5uV7A36nr6zTGsFbZiX+SJ
         +lUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ad/tMshN8IatcqmyI7i6ALdMxOw0ZSS+pveywAs/onQ=;
        b=DbZgdVdTdrWh0yNEzLTuaSLJrHZ4eSsoKrsTTvHILxp5j91jbiga+dLeokvVi2mE2l
         wwopeFmmwj54lEBPTOxX4URx6ftr0wUkOXPAbu1R+oAsdG0bczC/3op+WfPk2hRnyacL
         R0x4cx7BNYcH983B4vtBHJc8fiuT1If9Acn7qQIfVKbCUTW5ThrewH0kaFcfVQXU8Ib8
         Wd9ZMYXP/s5aZfg0gY2L+pjHp8bA+3QscZ1LvsE8TaBGtXaV7P4WWWwdJcX16YSaWgxR
         7AhXXCcZlYI0TRyRFQda5LH6ZJj4k1eVejZTHGkF85bzIKvomB2XPvVQ2GPcxLMWxF40
         U1Pg==
X-Gm-Message-State: AEkooutzvHrd05qjwAjs0kJD9L6apcjO3slorRza/VVfSNT3ri53roHpC9OvFVviQKh4XreWBM3NZ2G/HGw0Cr8r
X-Received: by 10.107.131.38 with SMTP id f38mr73047940iod.173.1470260874752;
 Wed, 03 Aug 2016 14:47:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 3 Aug 2016 14:47:53 -0700 (PDT)
In-Reply-To: <CACsJy8Dhd2YLmNoRN=j0PQeyG+8=8MALsiw611HMhi2zk_8ouQ@mail.gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-4-pclouds@gmail.com>
 <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
 <CACsJy8CSnmnzDMGpMvvkhWRfJvp1L+pfOZ=eYp5JF0GWNH6D0Q@mail.gmail.com>
 <CAGZ79ka-isR4DL7ZqOp8cXE1bmUOnd33yu=pZZHaqNmPWH3PYQ@mail.gmail.com>
 <CACsJy8DKEV3FNmb1vWinRvb-FHSO_VftG7RevQ3TOFhP-Dm0cw@mail.gmail.com>
 <CAGZ79kYbmoKPAPMVkTUycSKVtT6HLK-Y_eGXSX+z69G3+udR8Q@mail.gmail.com>
 <CACsJy8DgeSOh-RScmcrSwy7PgeQXwA2R6w9mRmHzuWR4djg=4w@mail.gmail.com>
 <CAGZ79kYGj7q=SQyHvFdmXasJppTVw56xSBMiSERdx22B+A68gQ@mail.gmail.com> <CACsJy8Dhd2YLmNoRN=j0PQeyG+8=8MALsiw611HMhi2zk_8ouQ@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 3 Aug 2016 14:47:53 -0700
Message-ID: <CAGZ79kZAwV+w0XTgacnAT-iPO3bzYapt2DdR22JJCBz_up6FJw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree setup
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 8:40 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Jul 26, 2016 at 8:15 PM, Stefan Beller <sbeller@google.com> wrote:
>>> How to store stuff in .git is the implementation details that the user
>>> does not care about.
>>
>> They do unfortunately. :(
>
> Well.. i mean the structure of .git. If .git gets big, yeah many
> people will get pissed.
>
>> My sudden interest in worktrees came up when I learned the
>> `--reference` flag for submodule operations is broken for
>> our use case, and instead of fixing the `--reference` flag,
>> I think the worktree approach is generally saner (i.e. with the
>
> I don't know exactly what that --reference problem is, but keep in
> mind you still have to support single-worktree use case. If it's
> broken in single-worktree, somebody still has to fix it.

So --reference let's you point to a directory such that you can clone
with less data transmission (borrow objects from the local reference).

For submodules this is not per submodule, i.e.

  git clone --recursive --reference <path>

will only look at that <path> to borrow for the superproject and all submodules.
But submodules are usually different projects, so you don't find their objects
in the superprojects reference path.

One way out would be to extend the path appropriately (assuming the same
submodule structure in the reference repository).

Another way would be to extend the reference mechanism to look for
objects in the given path and any submodule of that path. Then the submodule
layout can change and --reference is still super effective.

My chose way was to look at the submodule support for worktrees, as that
will hopefully be less brittle w.r.t. gc eventually.

>
>> The current workflow is setup that way because historically you had
>> the submodules .git dir inside the submodule, which would be gone
>> if you deleted a submodule. So if you later checkout an earlier version'
>> that had a submodule, you are missing the objects and more importantly
>> configuration where to get them from.
>>
>> This is now fixed by keeping the actual submodules git dir inside
>> the superprojects git dir.
>
> Hmm.. sounds good, but I'm no judge when it comes to submodules :)

yeah I'll try to get feedback from the submodule people. :)

>
>>> Hmm.. I didn't realize this. But then I have never given much thought
>>> about submodules, probably because I have an alternative solution for
>>> it (or some of its use cases) anyway :)
>>
>> What is that?
>
> Narrow clone (making progress but not there yet). I know it does not
> cover all cases (e.g. submodule can provide separate access control,
> and even using different dvcs system in theory).

heh, ok. Yeah ACLs are the big thing here, so we'd rather go with submodules.

>
>>> OK so it's already a problem. But if we keep sharing submodule stuff
>>> in .git/config, there's a _new_ problem: when you "submodule init" a
>>> worktree, .git/config is now tailored for the current worktree, when
>>> you move back to the previous worktree, you need to "submodule init"
>>> again.
>>
>> "Moving back" sounds like you use the worktree feature for short lived
>> things only. (e.g. in the man page you refer to the hot fix your boss wants
>> you to make urgently).
>>
>> I thought the worktree feature is more useful for long term "branches",
>> e.g. I have one worktree of git now that tracks origin/master so I can
>> use that to "make install" to repair my local broken version of git.
>
> I use it for both. Sometimes you just want to fix something and not
> mess up your current worktree.

I tried worktrees in my daily workflow and the issue for me is my editor
that is worktree agnostic.  As I tried using worktree for different git related
patch series', the set of files I need to look at are the same in the
different work trees

When switching branches the files are still at the same place, such that
the editor, that has a bunch of files open, will just reload the files and you
don't need to open/close files in the editor.
With worktrees you need to open/close all files that you intend to touch in
that worktree, which I dislike as an extra step.

>
>> (I could have a worktree "continuous integration", where I only run tests
>> in. I could have one worktree for Documentation changes only.)
>>
>> This long lived stuff probably doesn't make sense for the a single
>> repository,
>
> It does. You can switch branches in all worktrees. I have a worktree
> specifically for building mingw32 stuff (separate config.mak and
> stuff). When I'm done with a branch on my normal worktree, I could
> move over there, check out the same branch then try mingw32 build. If
> it fails I can fix it right right there and update the branch. When
> everything is ok, I just move back to my normal worktree and continue.

So you use different worktrees for different purposes i.e. editing always
happens in the same, but testing or real hot fixes go into a separate
worktree?


>> So instead of cloning a submodule in a worktree we could just
>> setup a submodule worktree as well there?
>> (i.e. that saves us network as well as disk)
>
> You still need to clone once then somehow associate the clone with a
> submodule, I think.

(In the single worktree case) if you already have the submodule cloned,
but delete it from the working tree, you still keep the repo in .git. Later
when you decide to checkout the submodule again, you don't have to clone
it again, but just checkout.

I imagine the same is in multiple worktrees. Although you may want to fetch
a different remote first for a different worktree (as it may have configured a
different remote URL for the worktree)

>
>> For worktrees there is no "worktree rm" as it would probably promise
>> a bit more than the man pages suggestion of rm -rf $worktree && git
>> worktree prune.
>
> Oh there will be, sooooon :D I prefer not to do that command sequence
> manually, especially when "rm -rf" is involved. "git worktree remove"
> can refuse to delete when your worktree is dirty so you don't
> accidentally rm and cry later.

yeah that was my line of thinking :)

Thanks,
Stefan

> --
> Duy
