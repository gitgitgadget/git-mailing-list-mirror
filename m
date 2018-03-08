Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA7961F404
	for <e@80x24.org>; Thu,  8 Mar 2018 19:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751063AbeCHTrf (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 14:47:35 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35430 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbeCHTrd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 14:47:33 -0500
Received: by mail-wm0-f44.google.com with SMTP id x7so1497931wmc.0
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 11:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zochBtX1WV5vcZEzenLXsrd59H8GADBWv9t3Yym9I28=;
        b=qe79HSKyqjQXXXHUN3hAYdp8XX0XWidmQ71MJ1a+e5c6TEj4Whigo1Uu/ITpkb5W+T
         t4OUhcO+S0lv+41hcfgn6Km1RldteiSDx+d0x1JS5XPlPmt9kKf0ylUiZ6vtqsK/9IGQ
         4dFbewc6s7yOB52qzm8T8yJLIsle+5kJEC50ao+16b9muYTCByHu4ypKVwzgeOQrCozn
         WDWrR6xPl5o5nA6V+HtdvMelq6ByYmrMzFEGvQ4D7knZ93d+s4oz6qGZPrXhliaBeXVT
         jxFyoliytBrCI3fYvA68k0ZUzlVhxK9mD4E7o59luqspLSbd4Xxv4EICcOFzGTt/RS9Q
         ZsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zochBtX1WV5vcZEzenLXsrd59H8GADBWv9t3Yym9I28=;
        b=cBnBsIq4d+8ZAkdSRm4ebXnwbsK4jCjf89mJlB12EGPVu0LSkwjjR8Nk2Scv3Vuh3J
         ExB1rfFMuxwEzaAHUo3WJoiGltU8mNuzLl9KUPENxZyupjkR0p6dw03wpoqMZnL0Ymdq
         OSuaWXs9BiGgAzAgSK11m7hXfo/+SH8WzzX2zSCCB1R9cOQsxKghANRN206EDVG2YmL3
         HqU2HPvnzc8UVi3c9HRh6QcjpSe0GV0Z/oZpXQpyukppr2T6HQWFEdHfCveBH0AYqLvq
         W1C66NdP9okn5ISj8gRw9ShMS3UscQQZfUxBgrVl9lxPqTuzOSKyYuw3BG6AEqcDfSvi
         OXzA==
X-Gm-Message-State: AElRT7FP5k+xFfD1iHP6SPsW1fiCl8XBzGaAKI6D0z0FbRzj/j18aJQt
        8/ewPugGuuMvdxjPuAjMbqiRnI4u5xeKQhTTrjU=
X-Google-Smtp-Source: AG47ELtyQ6Dqs9GP8Ztng3gm3/Pmto0B0QojFBEevEL5dqzjy550Er+Lj8r2VNJ39H7M2lGwyrhGLULAfs4gyUbh0m0=
X-Received: by 10.28.173.198 with SMTP id w189mr19517864wme.139.1520538085025;
 Thu, 08 Mar 2018 11:41:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.169.206 with HTTP; Thu, 8 Mar 2018 11:41:24 -0800 (PST)
In-Reply-To: <CAK0XTWdY6rfKu_s8Am6dh9njcFHqSAz_54PhW6V09DuGwE-h0g@mail.gmail.com>
References: <1520366804-28233-1-git-send-email-eddy.petrisor@gmail.com>
 <20180306202149.GA160269@aiede.svl.corp.google.com> <CAK0XTWdY6rfKu_s8Am6dh9njcFHqSAz_54PhW6V09DuGwE-h0g@mail.gmail.com>
From:   =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@gmail.com>
Date:   Thu, 8 Mar 2018 21:41:24 +0200
Message-ID: <CAK0XTWepPHe__qO6foFrh8-5mVJgWFzUsSw_4GZ89MFOmTrXbA@mail.gmail.com>
Subject: Re: [RFC PATCH] git-submodule.sh:cmd_update: if submodule branch
 exists, fetch that instead of default
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-08 21:29 GMT+02:00 Eddy Petri=C8=99or <eddy.petrisor@gmail.com>:
> 2018-03-06 22:21 GMT+02:00 Jonathan Nieder <jrnieder@gmail.com>:
>>
>> (cc list snipped)
>> Hi,
>>
>> Eddy Petri=C8=99or wrote:
>>
>> > Cc: [a lot of people]
>>
>> Can you say a little about how this cc list was created?  E.g. should
>> "git send-email" get a feature to warn about long cc lists?
>
>
> I did it as advised by the  documentation, git blame:
>
> https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L2=
64
>
> I was suprised that there is no specialized script that does this, as
> it is for the kernel or u-boot, so I ran first
>
>     git log --pretty=3Dformat:'%an <%ae>' git-submodule.sh | sort -u >
> mail-list-submodule
>
> then configure git to use that custom output and ignore the patch
> since it was trying to convert every line of it into a email address:
>
>     git config sendemail.ccCmd 'cat mail-list-submodule # '
>
> Then "git send-email 0001..." did the rest.
>
>
>>
>> > Signed-off-by: Eddy Petri=C8=99or <eddy.petrisor@gmail.com>
>> > ---
>> >
>> > There are projects such as llvm/clang which use several repositories, =
and they
>> > might be forked for providing support for various features such as add=
ing Redox
>> > awareness to the toolchain. This typically means the superproject will=
 use
>> > another branch than master, occasionally even use an old commit from t=
hat
>> > non-master branch.
>> >
>> > Combined with the fact that when incorporating such a hierachy of repo=
sitories
>> > usually the user is interested in just the exact commit specified in t=
he
>> > submodule info, it follows that a desireable usecase is to be also abl=
e to
>> > provide '--depth 1' to avoid waiting for ages for the clone operation =
to
>> > finish.
>>
>> Some previous discussion is at
>> https://public-inbox.org/git/CAGZ79ka6UXKyVLmdLg_M5-sB1x96g8FRzRZy=3DENy=
5aJBQf9_QA@mail.gmail.com/.
>>
>> In theory this should be straightforward: Git protocol allows fetching
>> an arbitrary commit, so "git submodule update" and similar commands
>> could fetch the submodule commit by SHA-1 instead of by refname.  Poof!
>> Problem gone.
>>
>> In practice, some complications:
>>
>>  - some servers do not permit fetch-by-sha1.  For example, github does
>>    not permit it.  This is governed by the
>>    uploadpack.allowReachableSHA1InWant / uploadpack.allowAnySHA1InWant
>>    configuration items.
>
>
> That is the problem I have faced since I tried to clone this repo
> which has at lest 2 levels of submodules:
> https://github.com/redox-os/redox
>
> The problematic modules are:
> rust @ https://github.com/redox-os/rust/tree/81c2bf4e51647295d3d92952dbb0=
464b460df0c3
> - first level
>
> and
>
> rust/src/llvm @
> https://github.com/rust-lang/llvm/tree/ba2edd794c7def715007931fcd1b4ce62a=
a711c8
>
>
>>
>>    That should be surmountable by making the behavior conditional, but
>>    it's a complication.
>
>
> Which forced me to try to fetch a branch on which that commit exists,
> but also consider providing --depth for the submodule checkout,
> effectively minimizing the amount of brought in history.
>
>>
>>
>>  - When the user passes --depth=3D<num>, do they mean that to apply to
>>    the superproject, to the submodules, or both?  Documentation should
>>    make the behavior clear.
>
>
> The supermodule clone already exists and that works OK; I was after
> providing something like 'git submodule update --depth 20 --recursive'
> or evn providing that 'depth' info via the .gitmodules parameters
> since 'shallow' is already used somehow, yet that is a bool value, not
> an integer, like depth expects:
>
>
> eddy@feodora:~/usr/src/redox/rust-eddy$ git config -f .gitmodules
> --list | egrep '(depth|shallow)'
> submodule.src/llvm.shallow=3Dtrue
> submodule.src/rt/hoedown.shallow=3Dtrue
> submodule.src/jemalloc.shallow=3Dtrue
> submodule.src/liblibc.shallow=3Dtrue
> submodule.src/doc/nomicon.shallow=3Dtrue
> submodule.src/tools/cargo.shallow=3Dtrue
> submodule.src/doc/reference.shallow=3Dtrue
> submodule.src/doc/book.shallow=3Dtrue
> submodule.src/tools/rls.shallow=3Dtrue
> submodule.src/libcompiler_builtins.shallow=3Dtrue
> submodule.src/tools/clippy.shallow=3Dtrue
> submodule.src/tools/rustfmt.shallow=3Dtrue
> submodule.src/tools/miri.shallow=3Dtrue
> submodule.src/dlmalloc.shallow=3Dtrue
> submodule.src/binaryen.shallow=3Dtrue
> submodule.src/doc/rust-by-example.shallow=3Dtrue
> submodule.src/llvm-emscripten.shallow=3Dtrue
> submodule.src/tools/rust-installer.shallow=3Dtrue
>
>
>> > Git submodule seems to be very stubborn and cloning master, although t=
he
>> > wrapper script and the gitmodules-helper could work together to clone =
directly
>> > the branch specified in the .gitmodules file, if specified.
>>
>> This could make sense.  For the same reason as --depth in the
>> superproject gives ambiguous signals about what should happen in
>> submodules, --single-branch in the superproject gives ambiguous
>> signals about what branch to fetch in submodules.
>
>
> I never thought of providing the branch in the command line, since
> that's not versionable info, but to provide git-submodule a hint in
> the .gitsubmodule config about on which branch the hash in question
> should be found, like this:
>
> eddy@feodora:~/usr/src/redox/rust-eddy$ git config -f .gitmodules
> --list | egrep branch
> submodule.src/llvm.branch=3Drust-llvm-release-4-0-1
> submodule.src/rt/hoedown.branch=3Drust-2015-09-21-do-not-delete
>
>>
>> > Another wrinkle is that when the commit is not the tip of the branch, =
the depth
>> > parameter should somehow be stored in the .gitmodules info, but any ch=
ange in
>> > the submodule will break the supermodule submodule depth info sooner o=
r later,
>> > which is definitly frigile.
>>
>> Hm, this seems to go in another direction.  I don't think we should
>> store the depth parameter in the .gitmodules file, since different
>> users are likely to have different preferences about what to make
>> shallow.  If we make --depth easy enough to use at the superproject
>> level then the user can specify what they want there.
>
>
> Yes, but
> a) if the commit is not on the tip of that branch,
> b) the server does not support sha1 fetching and
> c) it is not expected to typically work in the submodules from the
> superproject checkout (e.g submodule is under another team's control)
>
> the typical usecase could be that the code is question is read-only
> and it should be OK to typically fetch a shallow clone of the
> submodule (by default). The only compromise at that point is to either
> choose a afe margin for the defalt depth in case the module branch is
> being modified.
>
> I solved a similar problem at work where having 2 shallow branches
> which had to be merged; since when trying to merge two branches
> without apprent common history git will do a merge commit, when a
> simple ff woudl wor, I wanted to find the merge-base.
> SInce the brances were shallow and they had to have a merge-base, the
> solution was to was to simply increase the --depth parameter in
> predifined steps (of 10 commits) and fetch both branches, check if the
> 'git merge-base'  command manged to find a commit; if not the depthc
> parameter woudl be increased and the whole process would be started
> until that merge-base was found.

Another optimization could be for submodule.<path>.shallow to imply
--single-branch, too.

> I wonder if the same couldn't be done for the submodules that have
> submodule.<dir>.shallow setting, making the depth parameter hardcoding
> unnecessary, and guranteeing the submodule could be cloned at any
> given time, as long as the branch specified by submodule.<dir>.branch
> is not removed from the submodule repo.
>
>>
>> > I tried digging into this section of the code and debugging with bashd=
b to see
>> > where --depth might fit, but I got stuck on the shell-to-helper intera=
ction and
>> > the details of the submodule implementation, so I want to lay out this=
 first
>> > patch as starting point for the discussion in the hope somebody else p=
icks it
>> > up or can provide some inputs. I have the feeling there are multiple c=
ode paths
>> > that are being ran, depending on the moment (initial clone, submodule
>> > recursive, post-clone update etc.) and I have a gut feeling there shou=
ldn't be
>> > any code duplication just because the operation is different.
>> >
>> > This first patch is only trying to use a non-master branch, I have som=
e changes
>> > for the --depth part, but I stopped working on it due to the "default =
depth"
>> > issue above.
>> >
>> > Does any of this sound reasonable?
>> > Is this patch idea usable or did I managed to touch the part of the co=
de that
>> > should not be touched?
>>
>> I agree with the goal.  As mentioned above, I'm not confident about
>> the particular mechanism --- e.g. something using fetch-by-sha1 seems
>> likely to be more intuitive.
>>
>> Today, the 'branch' setting in .gitmodules is only for "git submodule
>> update --remote".  This patch would be a significant expansion in
>> scope for it.  Hopefully others on the list can talk more about how
>> that fits into various workflows and whether it would work out well.
>
>
> Thanks for the input, it was helpful anyway.
>
> Now that I think of it, I think the "fetch more and more from the
> branch until we find the sha1" could work; in the worst case you would
> end up going to the beginning of the repo in case the submodule
> history was rewritten or if the branch specified in the supermodule
> submodule.<path>.branch was removed.

Actually, the branch removal in the submodule would lead to a failure
to fetch from the get go, so the worst case is if history is rewritten
because the sha1 would be missing fromt he branch.
Antoher non-fatal perfomance issue would be if the desired commit is
very close to the initial commit of the repo.

> I am aware this is not ellegant at all (what is the default "step"?),
> yet the submodule part of the code already struggles in that area
> because it clearly looks like an afterthought, anyway.


--=20
Eddy Petri=C8=99or
