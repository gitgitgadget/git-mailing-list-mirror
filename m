Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EB1C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 10:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94046206DB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 10:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfL3Kd1 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 30 Dec 2019 05:33:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38875 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfL3Kd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 05:33:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id k6so25962891qki.5
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 02:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=8dTCajydIE6Q35x1dM8mlQ03ao50OGlC3Tuy8W9Jk/c=;
        b=mRxpJNpvDTK1h03nmf8AnuAKh1qm10Lfyz5n04MVJFMj/BkGl8SSyPbXvGeb+QZuYL
         8PTXJA/knziTD4nTp81hIrs3l3xpcf+YQK3L/Fls7zLEP5jb7GmUuiNVdd8sLJNJ2VCc
         e8WoOHnRdnJe2lDfdNxzxxTOJ1wYoI+BMSRTKgdoZZIKVIzKMkxw3/hF/bUoq08Xsz25
         xD3oOmYBh7GQ/k4ez2dufbYmX5JykW3D+7n7mGAylNPthICUqJRgKCFMdqPUPJmApJk4
         SsKZjn3QGJrq1IurTSLnju4LSweDNYqhZgDrMGPk+HGXLvZVCnhJmqqxzzrPshPTERjT
         8kZA==
X-Gm-Message-State: APjAAAUzGGcwjm5qNLfUTCro7UGRhD+MmohFJAk+I8IhuxS8GwzDUeJW
        Q2I8gaSKOpff1Bn81eePUvy+8GBE3Qrj4/m/Zu3B+z+GXY4=
X-Google-Smtp-Source: APXvYqxKjE4GYJguQk/dZC9kgvPhJatE0DHal4j1QFpT2l6ygt91AE/1EupQNCUNGg1bKU/qCZaA5rhyFT1m4gcJ/wo=
X-Received: by 2002:a05:620a:91c:: with SMTP id v28mr53954655qkv.248.1577702005262;
 Mon, 30 Dec 2019 02:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20191229222633.23815-1-arnaud.bertrand@abalgo.com> <20191230023250.GC6570@camp.crustytoothpaste.net>
In-Reply-To: <20191230023250.GC6570@camp.crustytoothpaste.net>
From:   Arnaud Bertrand <arnaud.bertrand@abalgo.com>
Date:   Mon, 30 Dec 2019 11:33:13 +0100
Message-ID: <CAEW0o+jxm+2vC2zhUtz8GgaZeYtXMt2LXgNk8kk7VhQX5Z4arA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] *** Add branchname in commit header ***
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Arnaud Bertrand <arnaud.bertrand@abalgo.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Arnaud Bertrand <xda@abalgo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Brian,

Le lun. 30 déc. 2019 à 03:33, brian m. carlson
<sandals@crustytoothpaste.net> a écrit :
>
> On 2019-12-29 at 22:26:32, Arnaud Bertrand wrote:
> > From: Arnaud Bertrand <xda@abalgo.com>
> >
> > For tracability purpose it is often necessary to know which
> > commit is envolved in a branch
> > Keeping track of the branchname in the commit header
> > will make this traceability easy and will facilitate
> > the graphical toolis that represent the branches and
> > that have today to use complex algorithm to try to
> > determine the branch of a commit that was known at
> > the commit time.
> >
> > no big change in the code, today rebase is not considered yet
> > I'm waiting feedback about that before touching
> > the rebase code.
>
> I encourage you to read back in the history of the list as to why we
> haven't done this and why it's not likely to be accepted now, but let me
> provide a few reasons of my own.
>
> First, as any contributor to the mailing list can tell you, I am
> absolutely terrible at naming things.  I frequently name my branches
> something that makes sense to me at the time without regard to whether
> that will make sense in the future.  I don't want to memorialize my
> momentary thoughtlessness in the history of the repository forever.
>

I think you got the point! Git is written by software people for
software people and we know that we don't like to keep track of our
mistakes... Git allows you to to work like this because you can have
your own local branches with the name you want, just use a git merge
--no-ff at the end and only the commits that make senses will be in
the repository forever.
For CMM compliance, the branch type and the branch name must be
described in a SCM plan. In big open source project, I understand it
is not the so important because, at the end, we will only integrate
one patch on the master trunk, it is not like this for most of the
projects in companies.

> Second, one workflow I commonly use is creating a branch with many
> commits and then breaking them down into small series that are logical
> and easy for review.  If I have a branch called "test-fixes-part7" with
> 50 commits and then I decide to split that into two branches,
> test-fixes-part7 and test-fixes-part8, by copying the branch and using
> git reset --hard to truncate the old one, I don't want the old branch
> name in my new branch.  A lot of Git workflows assume you can reset and
> rename branches this way and having the branch name in the commit header
> breaks those workflows.

I understand but it will not break the workflow. .. the fact to have
the branchname as information in the commit header could be no more
than an "additional information". Exactly as you name and email is in
the commit header too It is simply an additional information for those
who want it, who need it. If you don't want to use is, that's right,
this information is even not visible in a normal git log command.It is
only visible with a dedicated placeholder.

>
> Third, people reuse branch names.  Right now, I have eight branches with
> test fixes all starting with "test-fixes-part" because I'm working on
> one major project with all of those test fixes.  However, if a developer
> working on another major project also has a lot of changes to the test
> suite, they may have lots of identically named branches, which would be
> confusing, since our identically named test fix branches would relate to
> different projects.  (See my first point.)

If it is different projects... it will not be confusing. And again,
you have 2 situations:
1. People working with SCM plan and hard branch naming convention. In
this case, they will never get this kind of problem, duplicated name
are impossible "by construction"
2. People that are working with temporary branch will not use the
branchname in the header and having duplicate branchname will no be
confusing.

>
> However, despite the fact that we aren't likely to add this in the
> commit header, there are definitely ways to achieve this.
>

I agree with the exception of the fact that it will depend on the
thoroughness of the developers themselves. And it will be more risky
to develop new features that has to be confident in the commit
message.

> If you want to include the branch name in the commit, you can do so with
> a trailer.  git interpret-trailers can then be used to manipulate and
> extract these, and along with a hook, add them automatically if they're
> missing.

Unfortunately, hooks are (can be) personal and there no way I know to
force a hook to be used. That exactly what I was using today but a lot
of developer that start on the project, clone it but does not use the
correct hook. So, finally, It is impossible to be confident in the
commit message content to get the name of the branch.

Let me explain our workflow (which is a really common one):
Everyday, for backup reasons, all developers have to push their work
on the central repository (at least their major development branch,
not the experimental). In this context, the rebase is not used (should
even be forbidden) but we are using the "merge back" instead (merge
master to localdev) very often to guarantee the coherence between the
current master state and the development..
At the end of each "small development" (bug fix or feature request),
the branch is merged with no fast-forward.
So we have this kind of graph:

*   d122671 (HEAD -> master) master: Merge branch 'dev_feature1'
|\
| * 7a6a93d (dev_feature1) dev_feauture1: some new changes
| *   9e498de Merge branch 'master' into dev_feature1
| |\
| |/
|/|
* | 2fca855 master: feature x merged
| * 3610279 dev_feauture1: some other changes
| * ae69fa8 dev_feauture1: some changes
|/
* 8bfee18 master:current status

As you can see, to explain the flow I had to add the branchname on
each commit ;-)

So, each new version in the master branch is the result of merge
(exactly what you are doing when you integrate patch) but with
difference that we want to keep track of feature history and we want
to be confident in the tool, not in the rigor of our developers. And
we don't want to see the development commits as history of the master
version:
To be more clear, the master previous version is 2fca, not 7a6a nor 9e49.
And it is important to have that view to answer a lot of question
(why, when, what, who, which effort, how long, how many, ... )

>
> If you're working on a more centralized project and you want to require
> the branch name in your commit trailers, you can set your CI system to
> fail or reject commits that don't contain them.  This is the approach
> that systems like Gerrit use when the required trailers are missing and
> it seems to work reasonably well.

I don't know gerrit but I think it is an something that use git as
kernel but I don't know if developers have directly access to the git
repository. or has to use the web interface.
of course, with a upper layer, everything is still possible.

>
> Hopefully these suggestions are helpful in getting you the traceability
> you desire without requiring fundamental changes to the way Git works.

Again, what I propose is certainly not a fundamental change but just
an additional metadata to help those who need it.
I even propose to configure a variable to activate it (even if I
prefer it is activated by default to be sure it is done by new users).
I will publish the patch with the variable but I've seen a small bug
to fix before ;-)

Thanks for your feedback,

Arnaud

> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204
