Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68400C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 13:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282D2207ED
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 13:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kBFRr28a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFKNoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:44:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:36521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgFKNoY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 09:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591883051;
        bh=A8+RhWwaZBxjvvSWYPTlN8O7Yt+hQxGmDL6ZhU3jf3o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kBFRr28aJHQjgQ5V6qMR4RzIKhHkVODqmw/J953FEk9qN1lyeaNk4XfXL+izzJhCI
         ltUNSGLJueNtEXzHfWX2Sg5A5qhC1r/i4IbbFU+rvPSHzHd0QWKwGhIRIEidf7fdjO
         R6Lh3ml69Rl6Bs1Ht0eIIWtjm/eZLhFzGKvPEsNI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.212.132]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQgC-1ixAfT2Hq4-00vN0H; Thu, 11
 Jun 2020 15:44:11 +0200
Date:   Thu, 11 Jun 2020 15:44:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default
 branch
In-Reply-To: <xmqqk10eecsg.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006111533140.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <xmqqk10eecsg.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:H9wi9Sb86nLNQt7xUMFDXEOxC2f8TO0XDIgz47CR8AlmjHQDQWn
 T36fjv1XkEk6ufq2tMOyV1WgpX1N3AIsLYnjSJhMKwEx615roRHQnMghYau9UImedhdmukt
 6N74noXFMxh5l5g9ZFhNUIaQ9XSYz0y38Or+GHKaVAABXQpKlS+wQZEpYFqvmo4VUux2jXt
 7+5SmAjeqj6HfM81k3dpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f2mZhFgngYQ=:mbFUOXFKOWUEsEAzY9A/Z1
 +Mm39SzNuc4DvO80hZKFOIbokyhmMfDnGLlhAl5n9OyTS2z39puOr0p7Plq+1GgcQHrRFIpaE
 l5k+mjL6UQZdZGxzqiEsfcWgXnEQ3WFH/OMyleAv7IGw3sxfTQsEYFbghQuFX2ixqTrnDtl0J
 PSOJ8r/ip8Khdh08/DzQ7EFKoWTXHOFqyM2RdV/eMIQg4BHs2l+on4lk4zVUuWhsZBNP5ugCx
 /lvnwUAKylbhVraxfN7uCCg17jAPLYGJhITQp3+WZDM1H9wSml48qT04tTqtV6msOAU8/IHkX
 AsyL7cx+TFoghgDutAFpajTzgFIVUZVKgB71Mdj+94mFy7WECU7jSF2XigMSR1Df031zBdAwr
 2z+rg657sBtlagcDKktFf5c3iFA3X2zMlmgInBanQrLb2VMm+4WeISp2c50iyMTGTAZ8hiyy9
 sBnMhmrxnMUWoiXB9B5jiw/aIpXcohYI9D0+CSfbffXzqpkGU5it5y6KVO48uTC5OAQ6qduQf
 Kv552Q7YjEAix22OtylgUOPqgK/Y9u5ozxcuJCIiYG7X1tPjKaJfvWGbz0qQaryJiCE7zbWo4
 iatr8bjjHxaOEwDe3PgCthJV+LMcDBwPV9+CxDlrRoy69o3pOZ9MXXfXRmTY5x2TeRY6keUrR
 7QolDoJtPXKjl0Jk3roUEFRVIQxaWev9+eu3/caMUKWIJAg7OYjhRFuQkSdH0ZZYOIfDaQy5K
 Qc5rfFXjDuQI9eoZqe0skC8pNQtptuSgWQn0+0ga+r3ZJBobqq7C6q1vY9aSJSJOP8XrqcRlp
 KsbXMikd/f0zXtT33/rkI7do6sjO4YxuY/YU7+rGqf2RqArHniTQtC904PCgBOxdwS9vlE9ez
 JHg8E4Y2/xLBkMGehuAXt5lNyPxc98BtURkVvteApnh/mK6pHxMZ1+5LkPbUjyzCJZ/wvei82
 ZxXGbbBMvaCf0DzfRK+WRwvE+YCt/Vqm9l1pnUJ1dfWwoI2bgB2WXWrjNgbCYDxM28Ny9Ud6L
 0vzrGAlrJDy7dlZ1b8KcwqoN9Er4lWENgUHWYBt6yybXLWFcyvKDe9SkqBU9nX/IC67wrgsq8
 DlZgLpXkeBnOAmpDWclMtE9su0Uao5FPm3IKr10aYpwHQV4zWgDN0JsijgYW1rkl/3gvMU6O3
 5/0DERVduhGfpz/3jyrL5Zv7+b1FzZRISQJjE2PRRuFKDljMZ/gtZCGn7D4YTvukp6rzbjrbp
 bsZBkHxZjPNHh5vzs
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 10 Jun 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > A growing number of open source projects aims to avoid the branch name
> > master due to its negative connotation. See [1] for an existing discus=
sion
> > on this. The links [2], [3], and [4] describe community-driven ways fo=
r
> > users to rename their default branches or use template edits to set a =
new
> > default branch name.
>
> I scanned the series quickly and the patches seem to cover all the
> places I was aware of that has the hard-coded knowledge of the
> default branch name being 'master'.  Looking good.

Thanks!

> > This series DOES NOT change the default automatically, but only
> > provides an opt-in mechanism for interested users. It also presents a
> > way forward for such a transition, if and when we decide to do so.
> > Specifically, the new GIT_TEST_DEFAULT_BRANCH_NAME environment
> > variable could be used to update test scripts on an individual basis
> > instead of all-at-once.
>
> Yes.  I've been thinking about a way that does not hurt workflows
> used in existing projects while allowing a "git init" that is run to
> create a new repository by a new user who does not have any special
> customization in ~/.gitconfig to use the branch name that replaces
> the 'master' (I do not mind changing away from 'master', but I am
> not yet convinced it should be 'main', by the way---the actual
> choice of the final name does not matter at this point of the design
> of backward compatibility plan).
>
> I think "git init" that is creating a new repository (iow, do not do
> anything when reinitializing an existing repostiory) can
>
>  - look at config.defaultBranchName in /etc/gitconfig or
>    ~/.gitconfig before initializing the per-repository config in
>    $GIT_DIR/config it just created (or it is about to create).
>
>  - if there is no config.defaultBranchName configured, then set the
>    per-repository configuration to 'main' in the per-repository
>    configuration.  Otherwise do not do anything.
>
> And then we make sure Don's git_default_branch_name() works this
> way:
>
>  (0) if there is config.defaultBranchName in relevant config file
>      (i.e. /etc/gitconfig, ~/.gitconfig or per-repo config), use the
>      specified name.
>
>  (1) otherwise use 'master' (not 'main').
>
> That way, an existing repository will keep using 'master' unless the
> user shows the preference (and accepts responsibilities for possible
> fallouts) in ~/.gitconfig or the repository's .git/config, while a
> new repository created by a user who does not show any particular
> preference will use 'main'.

I read this (way too late) last night and slept over it. Together with
your comment on the `fmt-merge-msg` patch, I think you are really on to
something: we need _two_ config settings, as there are two distinct
concepts at play here:

- One setting to specify the default branch name for newly-initialized
  repositories (such as `git init`, unless it re-initializes, and `git
  clone` when the cloned repository does not yet contain any branches).

  This should probably be called `init.defaultBranchName` (even if `git
  clone` picks it up, too), and be overrideable by
  `GIT_TEST_DEFAULT_BRANCH_NAME`.

- And another one, to define the default branch name for the _current_
  repository. This setting would be configured implicitly upon `git init`
  and `git clone`. For repositories where it is not set, we would assume
  `master` for backwards-compatibility.

  Technically, this should probably not even be a config option because it
  is _strictly_ per-repo. But maybe it is not _so_ much per-repo: if I
  want to rename all my main branches in all of my local repositories, I
  might opt to configure this in `~/.gitconfig`.

  Maybe a good name for this would be `repo.mainBranch` (and it would
  contain the full ref name, e.g. `refs/heads/main`, not just `main`).

And then `git fmt-merge-msg` (and your proposed `git var` addition, which
I like a lot, maybe `git var mainBranch`?) will pick up the latter.

That way, existing repositories would not be affected by
`GIT_TEST_DEFAULT_BRANCH_NAME` or `init.defaultBranchName` at all. Only
new repositories would pick it up.

Does that sound like a plan?

Ciao,
Dscho
