Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 449B2203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 18:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757945AbcGZSVK (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 14:21:10 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:35049 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbcGZSVH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 14:21:07 -0400
Received: by mail-io0-f172.google.com with SMTP id m101so34730468ioi.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 11:21:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CdyTlB4JxfQDGevnWTdCopzpTFdOpsPblTxCmbUyMgM=;
        b=PwD+PWSl5qzyWvFIPVTJ+Qn3yq/q2exb2ww81cjBFMFnNHgGD3hDNkPQHUR7Ye1NaE
         ighLltkBj0sELAz5JxMEOjGVklR5+kYdRmIWK3iVVuZ5RIEo6YStHQgmx/59z6RGYwh6
         bM2TSGBT4iDU7XcohN3yF0GmJP5d1D/4uVSQMKT3rC+BmhboEktktT9d5c+t0TFnB0th
         BAG3mT5Y4cqLE0rFcMQc+SFqOUvSje8UCudAjikTnNaAaIB7iTHUC0H1LGVfTkhaPDr7
         HNI1rAjsztkZJSflc+YVZY4MhJWPqpfuyK3QJpKBESRetNwOmmQudmXWE62rItAkLWvM
         e1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CdyTlB4JxfQDGevnWTdCopzpTFdOpsPblTxCmbUyMgM=;
        b=P8zO/4S8h9UqbgQ1PSEDWS3c+3f3t/SqToOifaBXjnrh3mX6l1AphVwzXeVasjJGqj
         D1CrHXTM7Re5jWJvYJTFI4OmlfZyERPLYhaqOv8oSo7G+0GCBEpsQ6Dg4F+LJs2r4IMq
         33j0Wb0H27CXaHTELlb6RcAlAva9iHYkpvnZntJIhAOCNcSPESewi1vLkj7pjMQd8OCw
         x298nYTQPTwLg0CH2nZNM7HYKdTPWvWhlc9EfrFE1gXS89lvT56/+VOJ9fXilhaoNNUb
         yfMH37UgpIH+5qT+88Tr9RJsdEuhDo4JDU9UkmQrqiU22jYP9Mnh0hsnch8qdld/61Zq
         OUmw==
X-Gm-Message-State: AEkoouvGBL4b7W04zJijuzOKY9jhalzuW8tMFu9ZnaThJYfSqyRomxXr9b4M4nPsOwvJ8jsg3wAEelJVwap9kxL8
X-Received: by 10.107.178.129 with SMTP id b123mr27196139iof.83.1469556911595;
 Tue, 26 Jul 2016 11:15:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 26 Jul 2016 11:15:10 -0700 (PDT)
In-Reply-To: <CACsJy8DgeSOh-RScmcrSwy7PgeQXwA2R6w9mRmHzuWR4djg=4w@mail.gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-4-pclouds@gmail.com>
 <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
 <CACsJy8CSnmnzDMGpMvvkhWRfJvp1L+pfOZ=eYp5JF0GWNH6D0Q@mail.gmail.com>
 <CAGZ79ka-isR4DL7ZqOp8cXE1bmUOnd33yu=pZZHaqNmPWH3PYQ@mail.gmail.com>
 <CACsJy8DKEV3FNmb1vWinRvb-FHSO_VftG7RevQ3TOFhP-Dm0cw@mail.gmail.com>
 <CAGZ79kYbmoKPAPMVkTUycSKVtT6HLK-Y_eGXSX+z69G3+udR8Q@mail.gmail.com> <CACsJy8DgeSOh-RScmcrSwy7PgeQXwA2R6w9mRmHzuWR4djg=4w@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 26 Jul 2016 11:15:10 -0700
Message-ID: <CAGZ79kYGj7q=SQyHvFdmXasJppTVw56xSBMiSERdx22B+A68gQ@mail.gmail.com>
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

On Tue, Jul 26, 2016 at 10:20 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Jul 26, 2016 at 1:25 AM, Stefan Beller <sbeller@google.com> wrote:
>> So what is the design philosophy in worktrees? How much independence does
>> one working tree have?
>
> git-worktree started out as an alternative for git-stash: hmm.. i need
> to make some changes in another branch, okay let's leave this worktree
> (with all its messy stuff) as-is, create another worktree, make those
> changes, then delete the worktree and go back here. There's already
> another way of doing that without git-stash: you clone the repo, fix
> your stuff, push back and delete the new repo.
>
> I know I have not really answered your questions. But I think it gives
> an idea what are the typical use cases for multiple worktrees. How
> much independence would need to be decided case-by-case, I think.

Thanks!


>
>> So here is what I did:
>>  *  s/git submodule init/git submodule update --init/
>>  * added a test_pause to the last test on the last line
>>  * Then:
>>
>> $ find . |grep da5e6058
>> ./addtest/.git/modules/submod/objects/08/da5e6058267d6be703ae058d173ce38ed53066
>> ./addtest/.git/worktrees/super-elsewhere/modules/submod/objects/08/da5e6058267d6be703ae058d173ce38ed53066
>> ./addtest/.git/worktrees/super-elsewhere/modules/submod2/objects/08/da5e6058267d6be703ae058d173ce38ed53066
>> ./.git/objects/08/da5e6058267d6be703ae058d173ce38ed53066
>>
>> The last entry is the "upstream" for the addtest clone, so that is fine.
>> However inside the ./addtest/ (and its worktrees, which currently are
>> embedded in there?) we only want to have one object store for a given
>> submodule?
>
> How to store stuff in .git is the implementation details that the user
> does not care about.

They do unfortunately. :(
Some teams here are trying to migrate from the repo[1] tool to submodules,
and they usually have large code bases. (e.g. The Android Open Source
Project[2], put into a superproject has a .git dir size of 17G. The
17G are partitioned as follows:

.../.git$ du --max-depth=1 -h
    44K ./hooks
    32K ./refs
    36K ./logs
    17G ./modules
    4.0K ./branches
    8.0K ./info
    4.7M ./objects
    17G .

i.e. roughly all in submodules.

So our users do care about both what is on disk, as well
as what goes over the wire (network traffic).

My sudden interest in worktrees came up when I learned the
`--reference` flag for submodule operations is broken for
our use case, and instead of fixing the `--reference` flag,
I think the worktree approach is generally saner (i.e. with the
references you may have nasty gc issues IIUC, but in the
worktree world gc knows about all the working trees, detached
heads and branches.)

[1] https://source.android.com/source/developing.html
[2] https://android.googlesource.com/

> As long as we keep the behavior the same (they
> can still "git submodule init" and stuff in the new worktree), sharing
> the same object store makes sense (pros: lower disk consumption, cons:
> none).

So I think the current workflow for submodules
may need some redesign anyway as the submodule
commands were designed with a strict "one working
tree only" assumption.

Submodule URLs  are stored in 3 places:
 A) In the .gitmodules file of the superproject
 B) In the option submodule.<name>.URL in the superproject
 C) In the remote.origin.URL in the submodule

A) is a recommendation from the superproject to make life
of downstream easier to find and setup the whole thing.
You can ignore that if you want, though generally a caring
upstream provides good URLs here.

C) is where we actually fetch from (and hope it has all
the sha1s that are recorded as gitlinks in the superproejct)

B) seems like a hack to enable the workflow as below:

Current workflow for handling submodule URLs:
 1) Clone the superproject
 2) Run git submodule init on desired submodules
 3) Inspect .git/config to see if any submodule URL needs adaption
 4) Run git submodule update to obtain the submodules from
    the configured place
 5) In case of superproject adapting the URL
    -> git submodule sync, which overwrites the submodule.<name>.URL in the
    superprojects .git/config as well as configuring the
remote."$remote".url in the submodule
 6) In case of users desire to change the URL
    -> No one command to solve it; possible workaround: edit
    .gitmodules and git submodule sync, or configure  the submodule.<name>.URL
    in the superprojects .git/config as well as configuring the
remote."$remote".url in
    the submodule separately. Although just changing the submodules remote works
    just as well (until you remove and re-clone the submodule)

One could imagine another workflow:
 1) clone the superproject, which creates empty repositories for the
    submodules
 (2) from the prior workflow is gone
 3) instead of inspecting .git/config you can directly manipulate the
    remote.$remote.url configuration in the submodule.
 4) Run git submodule update to obtain the submodules from
    the configured place

The current workflow is setup that way because historically you had
the submodules .git dir inside the submodule, which would be gone
if you deleted a submodule. So if you later checkout an earlier version'
that had a submodule, you are missing the objects and more importantly
configuration where to get them from.

This is now fixed by keeping the actual submodules git dir inside
the superprojects git dir.


>
>
>> After playing with this series a bit more, I actually like the UI as it is an
>> easy mental model "submodules behave completely independent".
>>
>> However in 3/4 you said:
>>
>> + - `submodule.*` in current state should not be shared because the
>> +   information is tied to a particular version of .gitmodules in a
>> +   working directory.
>>
>> This is already a problem with say different branches/versions.
>> That has been solved by duplicating that information to .git/config
>> as a required step. (I don't like that approach, as it is super confusing
>> IMHO)
>
> Hmm.. I didn't realize this. But then I have never given much thought
> about submodules, probably because I have an alternative solution for
> it (or some of its use cases) anyway :)

What is that?

>
> OK so it's already a problem. But if we keep sharing submodule stuff
> in .git/config, there's a _new_ problem: when you "submodule init" a
> worktree, .git/config is now tailored for the current worktree, when
> you move back to the previous worktree, you need to "submodule init"
> again.

"Moving back" sounds like you use the worktree feature for short lived
things only. (e.g. in the man page you refer to the hot fix your boss wants
you to make urgently).

I thought the worktree feature is more useful for long term "branches",
e.g. I have one worktree of git now that tracks origin/master so I can
use that to "make install" to repair my local broken version of git.

(I could have a worktree "continuous integration", where I only run tests
in. I could have one worktree for Documentation changes only.)

This long lived stuff probably doesn't make sense for the a single
repository, but in combination with submodules (which is another way
to approach the "sparse/narrow" desire of a large project), I think
that makes sense, because the "continuous integration" shares a lot
of submodules with my "regular everyday hacking" or the "I need to
test my colleague work now" worktree.

> So moving to multiple worktrees setup changes how the user uses
> submodule, not good in my opinion.

Because the submodule user API is built on the strong assumption
of "one working tree only", we have to at least slightly adapt.

So instead of cloning a submodule in a worktree we could just
setup a submodule worktree as well there?
(i.e. that saves us network as well as disk)

>
> If you have a grand plan to make submodule work at switching branches
> (without reinit) and if it happens to work the same way when we have
> multiple worktrees, great.

Eh, I am still working on the master plan. ;)
The insights on how worktrees handles stuff helps me shape it though. :)

If you switch a branch (or to any sha1), the submodule currently stays
"as-is" and may be updated using "submodule update", which goes through
the list of existing (checked out) submodules and checks them out to the
sha1 pointed to by the superprojects gitlink.

>
>> I am back to the drawing board for the submodule side of things,
>> but I guess this series could be used once we figure out how to
>> have just one object database for a submodule.
>
> I would leave this out for now. Let's make submodule work with
> multiple worktrees first (and see how the users react to this). Then
> we can try to share object database. Object database and refs are tied
> closely together so you may run into other problems soon.

I see. The normal for submodules is to be in detached HEAD though.

The user can of course checkout branches or things in there, but
the "submodule update" operations do not go to a branch for you.


----
Another (slightly offtopic) observation on the similarity of worktree
and submodules: There is no good way implemented to remove one.

For submodules there is deinit both removes the working tree as well
as the configuration indicating the existence (Note: the git dir still exists
for the submodule). Though that sounds like what we need to save us
network traffic the next time we need the submodule. Although going
through the code I need to test that a bit more later today to see how
fail safe it is.
On the submodule side, it often gets confusing what you want to remove
(local checkout of the submodule, or the gitlink or both).

For worktrees there is no "worktree rm" as it would probably promise
a bit more than the man pages suggestion of rm -rf $worktree && git
worktree prune.

Thanks,
Stefan

> --
> Duy
