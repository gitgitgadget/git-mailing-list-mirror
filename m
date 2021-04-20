Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02E0C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 15:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF8CA613AE
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 15:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhDTP2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 11:28:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:47907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232303AbhDTP2j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 11:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618932482;
        bh=HWRamy2VOdAKWSwXNoQeQT42q+b4tlL8NQPd4i4zNGI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Y1hmTi09FkkuHKkGCueHzPpI6WZgA6SLKVuQ9Vn/I3+sz2s2baD5kvawcCMGb1U3R
         JFmICQ7ruK9nHemhJFCsx5knobKwoMBb9dGV8fB+Nta+GA1NYro5XEs8jpOS31/f+m
         HZQbbarYg9T6WDtnWZEtuy5oDSaYEXcCVzam1gXc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.111.181] ([89.1.215.94]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6siz-1lZS7Z2Vln-018IEQ; Tue, 20
 Apr 2021 17:28:02 +0200
Date:   Tue, 20 Apr 2021 17:27:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/23] [RFC] Builtin FSMonitor Feature
In-Reply-To: <xmqq8s5hkfxm.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2104201646210.54@tvgsbejvaqbjf.bet>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com> <xmqq8s5hkfxm.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:apS5VPDcyZkb1yRyE1CF1PV9FygpODIZ1D1MSSK5k4NnLBOPGOX
 cQeDm63dpSkrVUqkYltTE3cl4ocomcOcSqbLY8F4VFIetbEdx5jzRCDe/2f9odUru2KHFNA
 cDxapq8EqkCk4OU02ohgloo3XwQHzTcZ3syfJ6PxYhj5Vr6wL0GQ2+IKwZNciZzrFJibtsH
 FahPb2dntEmL9LwadtHQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PatRRvmk1nw=:4qRtLc/4d+EoMCq52V6h9m
 gjWlJDpdFYXeG5iBVZwGZRNpl7hK3eXD3iVT5VYj5jlruno6COY4z0CJq7jDv9qnozKjldaeL
 g1Is8hf1TynHtzOyWpceQqP/vzMDeNCNPvs6Pw02T1y/IzkBHhm2iJW1xrD4/rqeXkXs4DL1F
 WzKO9ECV4JP47PCB96FAB7Iy8Kf1dstkS8ZKp4p6sjshx7lgAqDS55gAysHTA1rtuYzXbSnhv
 ruC9TWGqjAF4lUFH78SG8YVW3k5AcpeqfvNhuK6tl6q9GMpZlRNjAlYsu/DOBNVefJ+0nwVK5
 yYupYMPqYHAZ469dgNXI7eLCF+uDzUqliAyOD79M1b07D3YZLChF/zaimUFKIrr4QtiTXtQVv
 5eRBcJpDg45Pv84Oys+uo90h+l5ERnMxC/PaRnhfQQYCZHgmkb51KYfyTSVr2iGOl6LlEjFAv
 FrlLXHi0KW+W9CbcLqWmlNncZon2yl/zIgTLpweUw+R2/ZLJFnDKSl33q7ZkjXbqb74aoXo3Q
 20+BGKcrb9MXbQmsQ46yuMlYoDlj/I3lZGZwiFkFNxh39DrjAppiUiFCybWtL+mKsWKLUVkHE
 rWWT+nCtu8lpecSNMDoifFSeF029mkrGscaBKEcq96pjSQYbLE+BieBKWa/sxwm97A2zyZRtT
 8a9EQHX31li/wSm86rIEjj0HLWscNkhhB5GWli2CgHOQlWPXFct+soEl3LP7q3f73IE0bC25v
 ydj5TPeXrjJP5Fkok04d8X9RjSNNzNQAaXoU19/0PX3nG61mgD2XrYt3ug8IoCdz0/SEhr0ih
 zOfLLLtNFBoyr4tIzIs1B7BMGtd3wn4JTgxwv+za/9o21+iSeyY1sR/b9AZtbJ29D3IZJwQkm
 NRmyA4zQMjaglMecdwruitL58BiLBn9DYOOty1yKAWH5v4Lw0lopK/AMtEPM2JL0TZS2ApF1U
 7+Wj29b68lti/gtB8eOHjWJiNtUyphcePPxTvpVhcleKLDdeFGmwgTexM9zBo+JHYb/g37bzE
 LHgu4o5FMVmRYkgkEfFZnhE+BgjYDrrCaUioIUi2bxgmL6EoAjkbsRwuMp2yp/y4RJpZey9oL
 ZD9aPfyHDlHKXR8YXSWDIc/3vPlhnVHWT4ytwZjZBjPJNZZ8i4Y4hF4RCVzT4BloB+qbb+14d
 NyEdv80mIQuhOZ45AGAM1apWT8stWiYrDQvdyoq04UQXyvVKKAR34jugtrLdYBcby0clYK1gh
 mhD9OcbpYAv9Rkjxk
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 16 Apr 2021, Junio C Hamano wrote:

> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This patch series adds a builtin FSMonitor daemon to Git.
>
> This hasn't seen much (if any) activity for a few weeks.

It actually is a good sign: I integrated this into Git for Windows (as an
experimental feature) and am running with it for a couple of weeks already
(in _all_ worktrees, not just the massively large ones).

At first, I ran into a handful Blue Screens of Death, and I was worried
that they should be attributed to FSMonitor. But it turns out that this
issue was most likely caused by a Windows update, and semi-resolved with
another Windows update (and only happens because I use WSL extensively).
In other words, those crashes are not related to FSMonitor.

So yeah, I find the lack of activity pretty good news.

However, I would have hoped that this patch series would see a couple of
reviews in the meantime. Since I was involved in the development of this
patch series (I started it just before I got dragged into all that
security work that led to v2.24.1, and never quite got back to it after
that), I wondered whether it would be "self review" if I reviewed those
patches, which is something I'd rather avoid.

But if nobody else reviews the patches, I will.

> Does that mean nobody (other than obviously the author and whoever
> wanted to have this feature) is interested?

The most likely reason why this does not see more reviews is that it
matters most for massive worktrees, and I don't think anybody here works
with those. The closest to a massive worktree I have is the `git-sdk-64`
repository (which has pretty much nothing to do with source code at all,
it is just a matter of convenience that this is a Git repository; Think of
it as if somebody mirrored their Ubuntu installation by tracking it in a
Git repository and cloning it onto all of their machines). And that is not
really all that massive:

	$ git -C / ls-files | wc -l
	162975

That's tiny compared to some worktrees I saw.

But we should not mistake the needs of those on the Git mailing list (`git
ls-tree -r v2.31.1 | wc -l` says we have only 3901 files/symlinks) for the
needs of some of our biggest users.

So I would like to respectfully ask for this patch series to be kept under
consideration for `next`.

> What does it need to get this topic unstuck?

The same resource that you keep complaining about, and that seems to be
drained more quickly than it can be replenished: reviewers.

I am as guilty as the next person, of course, and it does not help that I
get Cc:ed on several dozen patches seemingly every couple of days: this is
just too much, and I cannot do it, so I admittedly neglect too many patch
series (even the ones that I _do_ want to review, such as the
`bisect-in-c` one). My inbox is seriously no fun place to visit right now.

> > Finally, having a builtin daemon eliminates the need for user to downl=
oad
> > and install a third-party tool. This makes enterprise deployments simp=
ler
> > since there are fewer parts to install, maintain, and updates to track=
.
> >
> > This RFC version includes support for Windows and MacOS file system ev=
ents.
> > A Linux version will be submitted in a later patch series.

I guess this is another reason why this patch series did not see many
reviews: the lack of a Linux backend. And I fear that the statement "A
Linux version will be submitted in a later patch series" is a bit strong,
given that my original implementation of that backend does not really do
its job well: it uses `inotify` and therefore requires one handle _per
directory_, which in turn drains the number of file handles rather quickly
when your worktree has many directories. Meaning: It fails todoes not work=
 in the
massive worktrees for which it was intended.

Now, I heard rumors that there is a saner way to monitor directory trees
in recent Linux kernel versions (Jeff, can you fill in where I am
blanking?) and it might be a good idea to solicit volunteers to tackle
this backend, so that the Linux-leaning crowd on this here mailing list
is interested a bit more?

Ciao,
Dscho
