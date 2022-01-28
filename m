Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A71C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 11:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiA1L10 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 06:27:26 -0500
Received: from mout.gmx.net ([212.227.15.19]:53091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235774AbiA1L1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 06:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643369241;
        bh=keordmJo4yADq1JKKLwwSehvDVBBwZYPwO9Is7Jf2PY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Iqxc2l1rRrTnChlrqv1GcJVJwAM/3aR2ovqnk+AUzxVq7scsc+gXrcu+dsaMBfFQR
         PHccC2vciYiU3JRafblrrIaCVCCYu3/MIUO1tSjzrW4DXBkR0EA4hFyfDyoGNeGzmB
         Vy5wjdiVssn0jr6vGZuFp809QVqnKWPOSFm9YV1s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1mpBWz2Mfo-00Sfdl; Fri, 28
 Jan 2022 12:27:21 +0100
Date:   Fri, 28 Jan 2022 12:27:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] scalar: accept -C and -c options before the subcommand
In-Reply-To: <0f8d5d04-e86c-48e2-fea0-32c25c3f9325@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201281148310.347@tvgsbejvaqbjf.bet>
References: <pull.1130.git.1643195729608.gitgitgadget@gmail.com> <220127.86v8y5dgus.gmgdl@evledraar.gmail.com> <0f8d5d04-e86c-48e2-fea0-32c25c3f9325@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aTl+cuG1J+62rKy5QGENU9tbe8g1LXJW8QqRyxcXDqYcYZzC8gL
 HZI8AM5tf3OupoS609qDE859KejSRlUNob0T5vOP9gRQ36jdFZynmtwo6pvJOLoJGXzgUq/
 go5r4JiXxsi3HvkOC98QmRoti95cTadBSBZXfW8GAopv8GYfOtun7zJG/nLDcfkqnWMOfYP
 ViXTkwZOJAw7O90a2pbhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oc8T4uic6MY=:9TDLHNZJt+WO0e64Xmfbwd
 z52TJDfuJ12Oyy1VwzBan32iOgApBvkNFdkmqolCrGSm0Ow8FAvawtTglUxdFgaHqcIaVXlZH
 CGrKa251tqTu1t/OrcSE5gJH0EiHn8OP6W6kV2fqGfvN+vRef0sH4W3acFoULJdxjzmNjlccd
 r8wAL3UntB8YK9Udln9j0HcUBRfnjaIasz9J+V4txcetyD/lOzlfK7JEqr8hQj4nbnADkAaca
 P3mp8M682oepnguA0eWC8EB9kwtynhZmh1LKgYkf1N44Eym8mn0gRFvZwtdkVaQTOCFHPlUtp
 G2kimoH8EPDXuQudQwao4DX8FMT2wsp7AfGBLu6zF3RrFXzyhcUStgVKIFNfIW4jMd5vvNsYR
 mmYiUpyfIMu44SuI688Q2y7LmtVZs5gI2B5pAeSUMTVlLHRGETD0v46GIS1sWWxV6s6L5a6i3
 nksFDmVv+QGBd1mYfypudmAdKQdbXaAK6dLVuRS7QRJ479g8M7UbTXwcGWstlpwbI0xscVTEx
 ZLqlTw30uZ6fHtYn6ODN7awNp5Mgc5rh2IUvWHGJ7nhP+L+t46DvYG7vMhdWHL4/JxXrRuVqm
 1v4kW3tpqa9LwGB8PdsFB+dpJFEFHKCE/ElLSKIlDjMUfRVN9kyjrIj3A5kJ6pQPd+dVoj7Rm
 KHJ4CzyiihnY/etc8XiNS8qRaY0iCZ3jg/Q7pRik7oByAPyvM7cl+rEvpcZMm/5CoZloYi+uM
 ORLq9L/+/V16cf68NpkMSbFzZtsoLZQHOefAHKnHjFYtvdPDQ3XDLsDOpeA8xY6X0eeTXjV+G
 Qj/ha5InhpJfqJ8GI1ZpMgtUXnvVsH5uRw4r/9//2XKt/RNITSeBIfsklze7NOf4PKrDklQ2S
 ZsupSFCv5byGNHoVg/G6kYdQdllUUMGFxcm4/cTUZIFN1/rrYPA0bWGv0nwC5rbAWPVRv3EoY
 uIPyTDxs3eFuxeKx0d+XDOrMMloyhXS8O1gwxNirhsDOlzRXlD0XDlVbbs5+7tDz0URSe8I+n
 aNj14XghsBsP40kp+ZJ2NP4XERkxSi9lSyPHEAu2JoeCh07+nbb7h/VmHVg6HcVpi2VEpt4dO
 nWGRKZabJV8ybE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Thu, 27 Jan 2022, Derrick Stolee wrote:

> The biggest benefits of using handle_options() is for other pre-command
> options such as --exec-path, which I use on a regular basis when testing
> new functionality.
>
> There are other options in handle_options() that might not be
> appropriate, or might be incorrect if we just make handle_options()
> non-static. For example, `scalar --list-cmds=3Dparseopt` wouldn't show t=
he
> scalar commands and would instead show the git commands.

Right, and since `handle_options()` lives in the same file as `git`'s
`cmd_main()` function, we would not only have to disentangle options that
work only for `git` from those that would also work for `scalar`, but we
would have to extract the `handle_options()` function into a separate
file.

And while at it, a tangent someone with infinite time on their hands might
suggest is: why not convert `handle_options()` to the `parse_options()`
machinery? Which would of course solve one issue by adding several new
ones. Don't get me wrong: I would find it useful to convert
`git.c:handle_options()` to a function in `libgit.a` which uses the
`parse_options()` machinery. It'll just require a lot of time, and I do
not see enough benefit that would make it worth embarking on that
particular journey.

But since I had a look at `handle_options()` anyway, I might just as well
summarize my insights about how applicable the supported options are for
`scalar` here:

# Beneficial

  -c <key>=3D<value>
  --config-env <key>=3D<value>
  -C <directory>

	Since I added support for these (except for the long form
	`--config-env` that I actually only learned while researching this
	email), it is obvious that I'd like `scalar` to support them.

# Won't hurt

  --html-path
  --man-path
  --info-path

	Sure, for `scalar help` (which I implement in a patch series I
	have not yet formally contributed to the Git mailing list), these
	options might even make some sense.

  --paginate
  --no-pager

	There are no Scalar commands that would benefit from using the
	pager. But if we parse those options, we also have to handle them.
	Which would mean extracting _even more_ code from `git.c` just so
	that we can reuse `handle_options()` in Scalar.

  --no-replace-objects
  --git-dir
  --work-tree

	These options would only be relevant to the `scalar run` command,
	no other Scalar command works on an existing Git worktree. And
	even for that command, I doubt that they are actually useful in
	Scalar's context.

  --namespace

	This option seems relevant mostly for repositories that are served
	up for cloning and fetching, which is not what the Scalar command
	supports directly.

  --super-prefix
  --bare

	These options do not make sense in Scalar's context (it's neither
	about bare repositories not about submodules). That is the case
	for most `git` commands, too, of course.

  --literal-pathspecs
  --no-literal-pathspecs
  --glob-pathspecs
  --noglob-pathspecs
  --icase-pathspecs
  --no-optional-locks

	None of Scalar's commands take pathspecs, so these options won't
	have any effect.

  --shallow-file

	This option (which I learned about today) is purposefully not
	documented, as it is merely an internal option for use e.g. by
	`receive-pack`.

# Detrimental

  --exec-path

	Since `scalar` is tightly coupled to a specific Git version, it
	would cause much more harm than benefit to encourage users to use
	a different Git version by offering them this option.

  --list-cmds

	As you pointed out, this option would produce misleading output.

Given that only the `-c` and `-C` options are _actually_ useful in the
context of the `scalar` command, I would argue that I chose the best
approach, as the benefit of the intrusive refactorings that would be
necessary to share code with `git.c` is rather small compared with the
amount of work.

> So my feeling is that we should continue to delay this functionality
> until Scalar is more stable, perhaps even until after it moves out of
> contrib/. The need to change handle_options() to work with a new
> top-level command is novel enough to be worth careful scrutiny, but that
> effort is only valuable if the Git community is more committed to having
> Scalar in the tree for the long term.

I am okay with holding off with this, for now.

On the other hand, as I pointed out above: I do not really see it worth
the effort to refactor `git.c:handle_options()` for the minimal benefit it
would give us over the approach I chose in the patch under discussion.

Ciao,
Dscho
