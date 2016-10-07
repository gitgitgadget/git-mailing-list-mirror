Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC26220986
	for <e@80x24.org>; Fri,  7 Oct 2016 18:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753684AbcJGSGW (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 14:06:22 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34849 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbcJGSGV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 14:06:21 -0400
Received: by mail-wm0-f42.google.com with SMTP id f193so46975208wmg.0
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PTioGcv6JiMhqDyNt6hOY3STQ5LAw82XEeA5PFAVWLw=;
        b=NtbGdcbubthb/xKswWqMcf43MC+gzs+Jj/dbNFnx5cSxK7HSguuL3pSrjPn7HDneIT
         ok5nrHDLVstOhSdlBe/bfzz1NTTjepKnCK/oF6xd9ezmQY72LzZ4UXi1mhZVK+Gitl5/
         nJq1JLTkb3OctqPOn5mlAVCK6r51T2UswfgeURs+qYfCzLHDxhTNZiDqDvhSKuk1mZ39
         2pLZm0/PDMDvFAH/3R8xauVlY58jcrpNNP9uBHcGg0ESEQXxnBTCcJECO+FjdGluKDIv
         MR9yjHDiIrk4htkjxhhRipurrcyxsxHuFeHD/5BFlUiS9Iu2PjnOEfyWmgT+xwRYjTpP
         GzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PTioGcv6JiMhqDyNt6hOY3STQ5LAw82XEeA5PFAVWLw=;
        b=a0qnA90DWgoId+JxLKzYeWG3V/WLshkne961dDtWT6DNJ4tKnqVKEI5SvEZiMmIyyw
         bLLcy40cfiXIAVXgYgU07VLyICvxDcWj4oa+RrEenTEzGfmI/sih70jKvr7AbvygfsCb
         QDhiCvctFdSxIZJXy2S3Zne+pAKHSJRhsHsqDuamrF+dlNlvZO8uzLLsGB5ChEDaOdkD
         ilMgHGyBrbWmrWNbRpoz52EpRxcTQkK5VD5TgjLW7HrdXFcmm/g5/LhTkRLsVZme4Ft1
         23/YiBN4bOp1bAv/GqtAa6h9h5tbTMVAEhfkYtrCeLeN03rswCReApYJujr5BMkVOoAW
         8D6Q==
X-Gm-Message-State: AA6/9RlOGTXmnupksoTj6MWnWyj+Ka3++bScE390RsxuJxrZWbH8vPlZfc/TXxudAWP9AMgy8BCFpP5/6VoGGA==
X-Received: by 10.28.196.200 with SMTP id u191mr29642973wmf.67.1475863580249;
 Fri, 07 Oct 2016 11:06:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.136.149 with HTTP; Fri, 7 Oct 2016 11:05:39 -0700 (PDT)
In-Reply-To: <CAKbZu+CTobJ9omSDtK5WQxUZuq=b0g0r59k+9MFFy247YijgUw@mail.gmail.com>
References: <20160930191413.002049b94b3908b15881b77f@domain007.com>
 <481910fd-5a5f-ffc6-b98c-61d48b4a2e49@gmail.com> <CAKbZu+BUOAjixTmEC4octseyJbMnFuaCTtLT9hx3H10=AECeKw@mail.gmail.com>
 <CANQwDwcj15bk3uvjqnOwqqLFN_qOZCoWATssNBwD4kDTDfS6Hw@mail.gmail.com> <CAKbZu+CTobJ9omSDtK5WQxUZuq=b0g0r59k+9MFFy247YijgUw@mail.gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Fri, 7 Oct 2016 20:05:39 +0200
Message-ID: <CANQwDwcCGcgnGGrLM4OWq+W6CNepLUX-vy7tv4ai_CpH=-MUcQ@mail.gmail.com>
Subject: Re: "Purposes, Concepts,Misfits, and a Redesign of Git" (a research paper)
To:     Santiago Perez De Rosso <sperezde@csail.mit.edu>
Cc:     Konstantin Khomoutov <kostix+git@007spb.ru>,
        git <git@vger.kernel.org>, Daniel Jackson <dnj@mit.edu>,
        Greg Wilson <gvwilson@third-bit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 October 2016 at 18:55, Santiago Perez De Rosso
<sperezde@csail.mit.edu> wrote:
> On Wed, Oct 5, 2016 at 6:15 AM Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
>> On 5 October 2016 at 04:55, Santiago Perez De Rosso
>> <sperezde@csail.mit.edu> wrote:
>>> On Fri, Sep 30, 2016 at 6:25 PM Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>>>> W dniu 30.09.2016 o 18:14, Konstantin Khomoutov pisze:
>>>>
>>>>> The "It Will Never Work in Theory" blog has just posted a summary of =
a
>>>>> study which tried to identify shortcomings in the design of Git.
>>>>>
>>>>> In the hope it might be interesting, I post this summary here.
>>>>> URL: http://neverworkintheory.org/2016/09/30/rethinking-git.html
>>>>
>>>> I will comment on the article itself, not just on the summary.
>>>>
>>>> | 2.2 Git
>>>> [...]
>>>> | But tracked files cannot be ignored; to ignore a tracked file
>>>> | one has to mark it as =E2=80=9Cassume unchanged.=E2=80=9D This =E2=
=80=9Cassume
>>>> | unchanged=E2=80=9D file will not be recognized by add; to make it
>>>> | tracked again this marking has to be removed.
[...]
>> Yes, this is true that users may want to be able to ignore changes to
>> tracked files (commit with dirty tree), but using `assume-unchanged` is
>> wrong and dangerous solution.  Unfortunately the advice to use it is
>> surprisingly pervasive.  I would thank you to not further this error.
>
> Ok, I added a footnote in the paper when we first mention assume unchange=
d
> that says:
>
> Assume unchanged was intended to be used as a performance optimization bu=
t
> has since been appropriated by users as a way to ignore tracked files. Th=
e
> current advice is to use the =E2=80=9Cskip worktree=E2=80=9D marking inst=
ead
>
> This should prompt readers to look into skip worktree next time they want=
 to
> ignore tracked files. I don't think people reading the paper are doing so=
 to
> learn Git but at least it should contribute to not furthering the error.

Thank you very much.

The problem with "assume-unchanged" is that by using it to ignore
changes to tracked files you are lying to Git (telling it 'assume this
is unchanged' while changing it), and can lead to DATA LOSS, that
is to losing those changes.

[...]
>>>> [...]
>>>> | The problem
>>>> | is the lack of connection between this purpose and the highlevel
>>>> | purposes for version control, which suggests that the
>>>> | introduction of stashing might be to patch flaws in the design
>>>> | of Git and not to satisfy a requirement of version control.
>>>>
>>>> Or the problem might be that you are missing some (maybe minor)
>>>> requirement of version control system. Just saying...
>>>
>>> What would that purpose be? and why would you say that's a
>>> high-level purpose for version control and not one that's
>>> git-specific?
>>
>> The stash (or rather its equivalent) is not something Git specific.
>> It is present also in other version control systems, among others:
>>
>> * Mercurial: as 'shelve' extension (in core since 1.8)
>> * Bazaar: as 'bzr shelve' command
>> * Fossil: as 'fossil stash' command (with subcommands)
>> * Subversion: Shelve planned for 1.10 (2017?)
>
> Do these other VCSs have the same "Switching branches" misfit? Do you
> usually need to stash if you want to switch with uncommitted changes? I k=
now
> Mercurial has the same problem since ``bookmarks'' are like Git branches,=
 so
> it makes sense for them to have added something like stashing (if otherwi=
se
> switching with uncommitted changes would be very difficult).

I suspect that all those are inspired by each other, and that
they all use 'uncommitted changes are not tied to a branch'
paradigm, which allows for creating a branch for changes
after a fact (when it turns out that it would take more than
one commit to implement the feature) quite easy.

>> I would say that 'stash' could be considered about isolating work on
>> different features, different sub-branch sized parallel work.

Note that 'isolating work' is missing from your list of purposes
of a version control system; though it is fairly obvious.

>
> That sounds a lot like having independent lines of development, which is
> what branches are supposed to be for

Those are sub-commit changes. Branches are composed of
commits. But I agree that this may be a bit of a stretch in
trying to find a high-level purpose for stash (rather than it being
a convenience feature). As I said below...

>> But it might be that stash doesn't have connection with highlevel
>> purposes for version control, and that it is purely convenience
>> feature.  Just playing the role of Advocatus Diaboli (important in
>> scientific works, isn' it?)...

[...]

>>>> | 7. Gitless
[...]
>>>> |  Also, there
>>>> | is no possible way of getting in a =E2=80=9Cdetached head=E2=80=9D s=
tate; at
>>>> | any time, the user is always working on some branch (the
>>>> | =E2=80=9Ccurrent=E2=80=9D branch). Head is a per-branch reference to=
 the last
>>>> | commit of the branch.
[...]
>>>> [...] during some long lived multi-step operations, like bisect
>>>> or interactive rebase, you are not really on any branch,
>>>
>>> In Gitless we don't have bisect but for rebase (fuse in Gitless) we
>>> record the current branch.
>>
>> No bisect?  This is very useful feature.  Though it might be done
>> without detached HEAD, but with specialized pseudo-branch 'bisect' (as
>> it was done in earlier versions of Git, or maybe even now).
>>
>> Anyway, for [interactive] rebase / transplant / graft / fuse you need
>> to be able to abort an operation and return to the state before
>> staring rebase.  Though you can or do solve this by remembering
>> the starting position.
>
> Yes, Gitless remembers the starting position. We should be able to get
> bisect working too in the same way. Internally, the head is detached but
> that's irrelevant to the user. As far as the user is concerned she's stil=
l
> working on the current branch.

There are quite a few problems with "remember the starting position"
approach. For one, the rebase / fuse operation should be recorded as
whole in the branch reflog (assuming that you implement this feature).
Working on a branch would ordinarily mean that all those intermediate
steps would be recorded (well, they are, but in separate reflog, namely
HEAD reflog).

The second issue is that you wouldn't want for your partially done rebase
to be visible; for example, you would want for 'git push' to not include
partial work (which might get abandoned).

I suppose all this can be solved without user-visible detached HEAD...


I have one more comment and one more issue about the article in
general.

First, while the entry into a list of version control systems (or even
interfaces to them) is hard, among others because of network effects,
it should be much easier to try to come up with a GUI or IDE plugin
starting from the same principles. Also with GUI there is not much
problem if you don;t implement everything; users would just fall back
on command line of underlying version control system.

Second, I think at least some of the concepts phase would not be
possible when Git was starting to be created. At the beginning, we
didn't know much about how distributed version control systems would
be used. For example, the very useful "topic branch" workflow was
not even imagined. Mercurial, which was created in parallel and at
the same time as Git, started with "clone to create a new branch"
paradigm!  Unfortunately the curse of "worse is better" is often many
misfits in paid for lots of power.

Best regards,
--=20
Jakub Nar=C4=99bski
