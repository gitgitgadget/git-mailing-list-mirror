Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 053AC203EB
	for <e@80x24.org>; Wed, 27 Jul 2016 15:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbcG0PlT (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 11:41:19 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:35451 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597AbcG0PlT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 11:41:19 -0400
Received: by mail-io0-f176.google.com with SMTP id m101so73760449ioi.2
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 08:41:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w2JzGgfRe/eucU19vriQ7yzenmL53tNFhPbxmE8Piao=;
        b=jdNiOzStW8WhXbUWBKaq1OWE0BQHLXxZRnhqd3o9VaYV+Ae84ZqXwySD9T08+aakC9
         m5qJ0k/N8417+ZpBElDT7zPrTHBW4GOcaD4s6KU7NDyI8pxeET1PvuozlYFk2+bfTpnM
         Ozu2aDK0U7ykBzhLsbSIdNFUCCqEyLCn+hhk5o4ziJzjqRScm4QK+FrJo1CGgauUD6iZ
         QXkMcO+QJPFoDEwojud9povws8IcZw0VnFQmTJ9WMTKZbFc8k3lTp9mkXQKpU6XGKRt5
         f2PrTHly2ShcHKMoY6wo0RrP5cBYkqlnXDHRiTOU6hn8JO5cpiC9Vm0aJeafYKmYj+GF
         kRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w2JzGgfRe/eucU19vriQ7yzenmL53tNFhPbxmE8Piao=;
        b=GaPIk38H3UG9yftnO9LTfD5jKlB/FGboft96GWtLZzU6guYj7DNkM21P41VDBhlDg+
         GOCVvO2daB29etRt9aJ02Y64RqQ5z/nNtrHtUP0mA2AAe06IgcmSD1CUp3IJ6gOQ+N+S
         Ml7lqOx7bVYSkQM4VwM76QCxVESwxn6yo9OqYYfozNQR4ISiwJjJcLcuWs1oBGnQQerA
         aAAiPrmzP2UrLKPLmkfKOjPTXPgpgdjrFGg3EKFIwFPTNB5cPpgPqjbQZJXS+RF09nbh
         HYVkOlQ02gaPNGhqvEhJet7n0KdtbbMevtVMsgryV6SY5xKvdoRZcFsHcepYsEuaa15o
         M+Ug==
X-Gm-Message-State: AEkooutH/qINXqoizURzQjYm6YFBIVeqKovWRruurqNR+VRnxkkxabvU1zxos3r5YuKiT7xEx/KgEk/bO+B2AA==
X-Received: by 10.107.8.140 with SMTP id h12mr34507161ioi.95.1469634078087;
 Wed, 27 Jul 2016 08:41:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 27 Jul 2016 08:40:48 -0700 (PDT)
In-Reply-To: <CAGZ79kYGj7q=SQyHvFdmXasJppTVw56xSBMiSERdx22B+A68gQ@mail.gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-4-pclouds@gmail.com>
 <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
 <CACsJy8CSnmnzDMGpMvvkhWRfJvp1L+pfOZ=eYp5JF0GWNH6D0Q@mail.gmail.com>
 <CAGZ79ka-isR4DL7ZqOp8cXE1bmUOnd33yu=pZZHaqNmPWH3PYQ@mail.gmail.com>
 <CACsJy8DKEV3FNmb1vWinRvb-FHSO_VftG7RevQ3TOFhP-Dm0cw@mail.gmail.com>
 <CAGZ79kYbmoKPAPMVkTUycSKVtT6HLK-Y_eGXSX+z69G3+udR8Q@mail.gmail.com>
 <CACsJy8DgeSOh-RScmcrSwy7PgeQXwA2R6w9mRmHzuWR4djg=4w@mail.gmail.com> <CAGZ79kYGj7q=SQyHvFdmXasJppTVw56xSBMiSERdx22B+A68gQ@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 27 Jul 2016 17:40:48 +0200
Message-ID: <CACsJy8Dhd2YLmNoRN=j0PQeyG+8=8MALsiw611HMhi2zk_8ouQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree setup
To:	Stefan Beller <sbeller@google.com>
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

On Tue, Jul 26, 2016 at 8:15 PM, Stefan Beller <sbeller@google.com> wrote:
>> How to store stuff in .git is the implementation details that the user
>> does not care about.
>
> They do unfortunately. :(

Well.. i mean the structure of .git. If .git gets big, yeah many
people will get pissed.

> My sudden interest in worktrees came up when I learned the
> `--reference` flag for submodule operations is broken for
> our use case, and instead of fixing the `--reference` flag,
> I think the worktree approach is generally saner (i.e. with the

I don't know exactly what that --reference problem is, but keep in
mind you still have to support single-worktree use case. If it's
broken in single-worktree, somebody still has to fix it.

> references you may have nasty gc issues IIUC, but in the
> worktree world gc knows about all the working trees, detached
> heads and branches.)

True, but not yet. git-gc now does not know about all detached heads
and reflogs and have cause grief for some people. This should be fixed
soon.

>> As long as we keep the behavior the same (they
>> can still "git submodule init" and stuff in the new worktree), sharing
>> the same object store makes sense (pros: lower disk consumption, cons:
>> none).
>
> So I think the current workflow for submodules
> may need some redesign anyway as the submodule
> commands were designed with a strict "one working
> tree only" assumption.
>
> Submodule URLs  are stored in 3 places:
>  A) In the .gitmodules file of the superproject
>  B) In the option submodule.<name>.URL in the superproject
>  C) In the remote.origin.URL in the submodule
>
> A) is a recommendation from the superproject to make life
> of downstream easier to find and setup the whole thing.
> You can ignore that if you want, though generally a caring
> upstream provides good URLs here.
>
> C) is where we actually fetch from (and hope it has all
> the sha1s that are recorded as gitlinks in the superproejct)
>
> B) seems like a hack to enable the workflow as below:
>
> Current workflow for handling submodule URLs:
>  1) Clone the superproject
>  2) Run git submodule init on desired submodules
>  3) Inspect .git/config to see if any submodule URL needs adaption
>  4) Run git submodule update to obtain the submodules from
>     the configured place
>  5) In case of superproject adapting the URL
>     -> git submodule sync, which overwrites the submodule.<name>.URL in the
>     superprojects .git/config as well as configuring the
> remote."$remote".url in the submodule
>  6) In case of users desire to change the URL
>     -> No one command to solve it; possible workaround: edit
>     .gitmodules and git submodule sync, or configure  the submodule.<name>.URL
>     in the superprojects .git/config as well as configuring the
> remote."$remote".url in
>     the submodule separately. Although just changing the submodules remote works
>     just as well (until you remove and re-clone the submodule)
>
> One could imagine another workflow:
>  1) clone the superproject, which creates empty repositories for the
>     submodules
>  (2) from the prior workflow is gone
>  3) instead of inspecting .git/config you can directly manipulate the
>     remote.$remote.url configuration in the submodule.
>  4) Run git submodule update to obtain the submodules from
>     the configured place
>
> The current workflow is setup that way because historically you had
> the submodules .git dir inside the submodule, which would be gone
> if you deleted a submodule. So if you later checkout an earlier version'
> that had a submodule, you are missing the objects and more importantly
> configuration where to get them from.
>
> This is now fixed by keeping the actual submodules git dir inside
> the superprojects git dir.

Hmm.. sounds good, but I'm no judge when it comes to submodules :)

>> Hmm.. I didn't realize this. But then I have never given much thought
>> about submodules, probably because I have an alternative solution for
>> it (or some of its use cases) anyway :)
>
> What is that?

Narrow clone (making progress but not there yet). I know it does not
cover all cases (e.g. submodule can provide separate access control,
and even using different dvcs system in theory).

>> OK so it's already a problem. But if we keep sharing submodule stuff
>> in .git/config, there's a _new_ problem: when you "submodule init" a
>> worktree, .git/config is now tailored for the current worktree, when
>> you move back to the previous worktree, you need to "submodule init"
>> again.
>
> "Moving back" sounds like you use the worktree feature for short lived
> things only. (e.g. in the man page you refer to the hot fix your boss wants
> you to make urgently).
>
> I thought the worktree feature is more useful for long term "branches",
> e.g. I have one worktree of git now that tracks origin/master so I can
> use that to "make install" to repair my local broken version of git.

I use it for both. Sometimes you just want to fix something and not
mess up your current worktree.

> (I could have a worktree "continuous integration", where I only run tests
> in. I could have one worktree for Documentation changes only.)
>
> This long lived stuff probably doesn't make sense for the a single
> repository,

It does. You can switch branches in all worktrees. I have a worktree
specifically for building mingw32 stuff (separate config.mak and
stuff). When I'm done with a branch on my normal worktree, I could
move over there, check out the same branch then try mingw32 build. If
it fails I can fix it right right there and update the branch. When
everything is ok, I just move back to my normal worktree and continue.

You can achieve the same thing with multiple clones, but it's
inconvenient (you need to fetch and push...) and multiple clones take
up more space.

>> So moving to multiple worktrees setup changes how the user uses
>> submodule, not good in my opinion.
>
> Because the submodule user API is built on the strong assumption
> of "one working tree only", we have to at least slightly adapt.
>
> So instead of cloning a submodule in a worktree we could just
> setup a submodule worktree as well there?
> (i.e. that saves us network as well as disk)

You still need to clone once then somehow associate the clone with a
submodule, I think.

> For worktrees there is no "worktree rm" as it would probably promise
> a bit more than the man pages suggestion of rm -rf $worktree && git
> worktree prune.

Oh there will be, sooooon :D I prefer not to do that command sequence
manually, especially when "rm -rf" is involved. "git worktree remove"
can refuse to delete when your worktree is dirty so you don't
accidentally rm and cry later.
-- 
Duy
