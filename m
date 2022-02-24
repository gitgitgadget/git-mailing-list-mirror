Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909EDC433FE
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiBXQ2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiBXQ2I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:28:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00F5B0C67
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645720056;
        bh=9qPLG+oiwyMPpkZDmq36kS83MB3s4rECUInEcci+Hzw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d7EmHxaT3B8T2/Phd6Uq1p9xBiNpvYRkGqJEkcHyP1xJyFFjGLJbhTszu2nkG3BLD
         N8kaFmSIlAC551IhNd1vwz4SCVFJtcRrOGWtWdPCd+vkayWFsLsvYKNC7O+HlX9q+o
         T5DSoIQUByRlr4LS4gc63Y6s3yhF3LN87Fh2vuk4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJlW-1o404u2By0-00jEsy; Thu, 24
 Feb 2022 17:22:12 +0100
Date:   Thu, 24 Feb 2022 17:22:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler <git@jeffhostetler.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 00/30] Builtin FSMonitor Part 2
In-Reply-To: <37f54cd9-3e53-7d38-2c23-2fc245dc1132@jeffhostetler.com>
Message-ID: <nycvar.QRO.7.76.6.2202241650200.11118@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com> <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202171655390.348@tvgsbejvaqbjf.bet> <37f54cd9-3e53-7d38-2c23-2fc245dc1132@jeffhostetler.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:q0Cje10uA0A4aWjCzNQ4ry6a8qNybYFD7b20ipUxJH5L8lVIkN0
 5FE5LgC2Z56eKRjY4DfcM+sJOD83EKcKtGU1FcyR19jdzNCA1kk7UkibxjEmXdQ9RK0VQQS
 7zaUPPvdAHv3GdvJZWSVAxOB7SjKRkGumUBxyiDmch5YLWaWB0RModn1cWfkFJoLp+GdAFP
 BQTgsrb4/j6yNgIw2Iouw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iC8bh4geZ74=:vQ0N/fKT/gEUJEMIVVj+Kg
 Yd7dnPyL4NNv+IIx1YKALqKTxoIkQoppa21sbSgOCKgTdomQbJaEu3CdDOefU6TR10Iv76WLm
 X/zp6ahRJMiRiX5QJWcGuQyoMArBFtOtvJOMYmMaXiIvM4B2PfE5pos8Ii5hEfTGFuJGQ52Ef
 YUpwiDUTfb7wFAR9heSJNK6SFi1Y6qgUFIk8H1DbWmQlwgTmwqdGK4xAuSPOULnIsWA+z+XMT
 JLNmRj4dXuFN0iU33O3wCLfNhtxpEzu8LMKOv/958v7Rc6k/3q4almZFwT/GlXFZQo8Ys1oW7
 Jy7L30vuh+Urf/7BmHEQ/6s80M42kqLlCjbt/wDFjzYgvzVpzXcyD4hQl2zS9qhY9kx03ziBv
 fKFy12jbHJzdqK9TBw88xAOOEsWzwCeBWNMPGYMYB3CWplmbWQ83S1YQFvYN0W9qfzVWBY1nf
 7Cx3lVrf0GuYDWKLUFUe27TEsWqE/F/+j6XqCRVQD0n3nB4sE87L1hDQXj+TaVZ6TSLWjkCW7
 anDk/G+ows9AKsG0GerXzinQS+9VTZoInK1eQlLzJyluTyAdQJCZySvw7CiT9ty8Pm6/A6gw0
 y3gEJh3FG14Qx5/fSLJKfBXVhGFGOBxL/YiPtfZSdNYW6A3eH6ATp7UTsgGDvCIQHEJg4yjdP
 NSolobd7l8wKMk2gEpHrvUB0vAl1nlReppASZyJ9Al9KykmaIddjaB940fxwtAD7/+857mJoP
 ONF//Bc0IBGL+JPeQ9jFl0CqKqJmpVAl2MN7O2uSVTSX2ZzhQ3KoUPZddToogO97KXGvk8gG/
 eSkZCM7cAa7i+6tvtr4WKvCBNDR1qslfgZeCOHPnIdnxrY7xivjVZpmbbotDKdaymiUHfVLMJ
 iRnCWgbhvyeOHVkEiyU+Dpw1/+CDw2t44Fi+EgPo9DMXEGotjCqs3guLbp0Xwk6gQ7De94dCu
 pGzoC3VvwbwSvt6hKqM2pUpr5jb6H106vL2k7yu1vumNVFouGZhEYbNvJS6iRuP+x8JliTnBK
 mWw87m1mXfoSdjRxCOtNlZjjFzKgBiZq7UsCvDTK0E6BOn8D2tE4souG5rjHEGiOwUHTVZ3FZ
 o81kpJjwIk0NNI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Tue, 22 Feb 2022, Jeff Hostetler wrote:

> On 2/17/22 11:06 AM, Johannes Schindelin wrote:
>
> > On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:
> >
> > > In this version I removed the core.useBuiltinFSMonitor config
> > > setting and instead extended the existing core.fsmonitor.
> >
> > I am somewhat surprised that a reviewer suggested this, as it breaks
> > the common paradigm we use to allow using several Git versions on the
> > same worktree.
> >
> > Imagine, for example, that you run a Git version that understands
> > `core.fsmonitor=3Dtrue` to imply the built-in FSMonitor, while you
> > _also_ use an IDE that bundles a slightly older Git version that
> > mistakes the `true` for meaning the executable `true` (which is not a
> > FSMonitor at all, but its exit code suggests that everything's fine
> > and dandy). The result would be that the IDE does not see _any_
> > updates anymore, but nothing would suggest that anything is wrong.
> >
> > We can probably warn users about this, and we can also work around the
> > fact that Git for Windows already uses `core.useBuiltinFSMonitor`, but
> > it makes me somewhat uneasy nevertheless.
>
> This is a valid concern and I should have thought to mention it when
> the suggestion came up on the list.  Yes, extending `core.fsmonitor` to
> take a boolean or a path could confuse older clients (like ones bundled
> with an IDE, like VS).
>
> My assumption was that since we shipped `core.useBuiltinFSMonitor`
> in GFW with an experimental label, that normal users would not be
> using it at all and especially not from their IDEs, so it wouldn't
> matter.  And experimental features are just that -- experimental
> and subject to change.
>
> But your point is valid -- if someone does have the odd hook called
> "true" or "1", they'll get an unexpected result.

I wondered about that for a while, and put that to a test last night. I
set `core.fsmonitor =3D true` and then modified a file and ran `git status=
`.
Something I did not expect happened: it picked up on the modified file!

It also printed out a warning:

	warning: Empty last update token.

This is the reason why it works: by default, current Git versions assume
that the FSMonitor hook understands the FSMonitor protocol v2, which
starts by the client sending out a token, receiving a new token and then
the paths of the files/directories/symlinks to inspect. Since the program
`true` does _not_ write that token, Git warns that it did not receive a
token and continues as if no FSMonitor had been configured.

So that's good news!

The less good news is that prior to v2.26.0, Git did not support v2 of the
FSMonitor protocol, but only v1. And v1 does not expect such a token. Git
versions between v2.16.0 and v2.26.0 will interpret a successful run of
the `true` executable with an empty output to mean that no files have been
modified.

And indeed, in my tests, after making sure that the Git index had been
refreshed explicitly and then modifying a file and then running `git
status` with v2.16.0, Git did not pick up on the modification.

That's the less good news.

At first I thought that we're pretty safe because nobody should use older
Git versions and enable FSMonitor because FSMonitor protocol v1 is known
to be subject to racy behavior. But then, Git users sometimes do not
completely control which Git versions they use. Take for example Visual
Studio users who also use the Git Bash to work on their worktree. While
their Git Bash might be reasonably recent, Visual Studio comes with its
own embedded Git version. Therefore, a user might want to play with the
built-in FSMonitor in Git Bash, find that it dramatically speeds up
everything (as it does for me, thank you so much!), and not realize that
the Git executable used by Visual Studio totally misinterprets
`core.fsmonitor` to refer to `/usr/bin/true.exe` and then miss any
modifications.

As long as the embedded Git version is at least v2.26.0, Visual Studio
will at least work correctly (because it ignores `true.exe`'s output and
continue as if no FSMonitor had been configured). But as soon as an older
version is used, Git would work incorrectly, without any indication what
is going wrong.

I tried to come up with alternatives (because I _really_ dislike being a
reviewer who only points out what's wrong without any constructive
suggestion how to do it better), and the best alternatives I came up were:

- stick with `core.useBuiltinFSMonitor` as before, or

- use a special value of `core.fsmonitor` that simply is not a valid
  executable name. In 2019, when I worked on the original precursor of the
  built-in FSMonitor (before I had to drop working on FSMonitor
  because of all the security work that went into v2.24.1), I had picked
  `:builtin:` because colons are illegal on Windows, but of _course_ they
  are legal everywhere else. But one thing is not possible, even on Linux:
  to have a trailing slash in an executable name. So something like
  `/builtin-fsmonitor/` would work.

However, after seeing how nicely your latest iteration cleans up the code
by simply interpreting a Boolean value to refer to the built-in FSMonitor,
I _really_ would like to make it work.

Maybe we can declare that it is "safe enough" to rely on new enough Git
versions to be used by users who use multiple Git versions on the same
worktree? They should use _at least_ v2.26.1 anyway, because that one
fixed a rather important vulnerability (CVE-2020-5260)? At least for
Visual Studio, this is true: it ships with Git version 2.33.0.windows.2.

What do you think? Can we somehow make `core.fsmonitor =3D true` work?

Ciao,
Dscho
