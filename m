Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1E5C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 15:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiJRPGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 11:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiJRPGg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 11:06:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46B5C3574
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666105591;
        bh=T5szwesnZOrcG31lZnd0Er3ug3oN8MuwwktLx5Xo8Ic=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R1aaT5dYSft4ypDaEjz/SO6MQqCAt8JWPeN84eMrl6GUOE64qFTZ+1bsg+v1V7Bpi
         VPdoyWNoGxvmMfjKesEMO+SOXsaCNfkQJ0ecxiu2mThJYhue7AfeiOTphqDZmU4In9
         FgPjPROrNaqo+/sE8l+u9oyZgoNv/UFqA+a/Sgd4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.67.214] ([213.196.212.100]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmKh-1oRE1W1gJF-00KCIs; Tue, 18
 Oct 2022 17:06:31 +0200
Date:   Tue, 18 Oct 2022 16:21:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH v3 4/5] cmake: avoid editing t/test-lib.sh
In-Reply-To: <221018.86sfjlgr54.gmgdl@evledraar.gmail.com>
Message-ID: <on2q3qos-sr0n-0p8p-606p-5pq39n46qq4q@tzk.qr>
References: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com> <pull.1320.v3.git.1666090745.gitgitgadget@gmail.com> <5b0c2a150e9fce1ca0284d65628b42ed5a7aad9a.1666090745.git.gitgitgadget@gmail.com> <221018.86sfjlgr54.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-128553218-1666102871=:174"
X-Provags-ID: V03:K1:GwpTmQY7K6QM5Koyy6Z7755I4NKE+khUAshNN+5Qc4tkq9OOs6R
 HMw5FyflOMybcdQY+43HHuVy4db/R0Aj5um8Bm7l5ksgoWt5TmWs7CS+s+bVZREWWs1+d6Z
 6rM8/+/r+FHuB0cUxps/44x9RuxarGoGciEZla7D3Ia9qw4NwGoCArMbsxhlZ52RAUGhV7O
 16qqGbnzh5r9ujGZQtG1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZYH1kF9glCo=:UpGDhbYM9ekKsqZspXMFAq
 TnyEcVGUpaZHxvlA1jmqbjJ4yjsA/sxKGYpH26vVBFWSG7wispRSODzqmaDUBxv9q9gX0cogd
 AitbynRjMABqGLSW9JJ5lwI0o58LpH4fYJQMQ674CpUpjJSyn6O34E3VHiDMSo58PfivZO7P4
 V/KR6qHMKc85jpOyUt94VG4eStSz6lUSUvqnkbRB7QnBBxdh2QAaOHdRQv3MNhwyfVKuWaB3P
 zN0wjiULDk+VBYWFPXkUL65DLhi50vAE2tvg4/ouvfm8xfwYECIVUOqCDb2wHW49lAmHo5F1D
 cjhUPoysO2/YZuSob7u9rXeRCn/+ElcldbhaQh25egl/qUD65mvQo1w4TuGdjiKxhxosxWMLg
 S9CJW+blIGucbsgV2tcrJdx0dhUAxDRH3Hn1S1ztFG3pC2ltx6gFcEf3eZZzE/Alrq+EQznbs
 4JoYkDOAfNa1W4yQgkAHblXUpgRKtMwgmy+Pa8JCq/wXkj6qvv8Wm8+Y6NYIdEv7I7Smkbx/W
 blbNQ6UXwm83WQwhuHeQzAUGQmAlRV384b90CJvVRp+6frS3XNhjbxNpm76I6O1wmnbYXJtGf
 5WZS30zDH0qw6TyLE5m6j/05KJdsxF8xfheS4npUHniWeShruj0maFbm2Q5kWeoG8TWXy9/kd
 O3EDgPw4G9D+xmQgt9H5D55EJXRap0MH1r85s+t3izYH9liNw3qf+vRyny+Lmv/61Mr547KMU
 avxt9XwT2cIpH06ornB69chWCPRNJgvBI7iQallc+M3LNdPg7PhX2FPUe9IM+GAKK5ZqFkpx9
 qWJ/RQSjDd+VWhFeE8Wx1udhh92EPjoUNpRDipB3WSOwX2EcfJr+5RRKwv3xKxdE6P3eYdKK7
 uh+nXhE4ioqc++vP8n8KkS6xxjSXN6ZbXO7m228gxHrBWvnSZQZCgBpbdGCXEdUygU0zYWH2+
 dUvJp+NoTS3inMnzOkkDU8FagCHAGvA8i87PSDITde4Z2OPtyauvNZX7z1aQnsOqT3PNWNv0O
 ZWCJkGeI4QBoI6KmSOEBj9+/08USB0Is1T3Oe7fuuW9iz1yShUSHFOP4mpTNwJ1+y+9GpWMf+
 MD47EzRmSLY5oHW4Rc0pMTyTZrK327/tCzEUF/hxOiCA06SUB3sf8FTOEzvQoEOB0Sy1zR3tc
 ZRlX/5m+e9dFGFUNJ1M9Ly/T4eopQqba2krJ4Zq5r9jyT0rxUQ1Tp4MjNV56F/GN63kU5stIB
 khxqf6OD1LxSKTWL9N3xMeCyn897j7q1LalNmrq8xkaTCwb2H7Hys6JH+q6/4hYE7YU/Iws4w
 mYmhcgGDJvPxVOUic/fUyBTgLfNq/6txP26+l9h+4t8z7R1+zHuM8NuLzyOwKB3c0FmeSiFiL
 YpmJbvoUIyC3Lb/yuDYFfAnuBMZc3kTXuABxOwQfg1QKpOnt7UCwGYrjXetSQ9djndNQRnztn
 hH18MRh7cVH0l1/iSmw9f58V9FkatyjVpIBm3OekyZyOJdcYEsfZVdtokFVtVntzAm53q0OR0
 awtVDivd23X9p5ctHzlDZUF7Qevua61gkfjw9fBQjkvNBSjOGCqsN3zai8yr+61UY3w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-128553218-1666102871=:174
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

you did not even give me a chance to send my reply to your original mail
;-)

On Tue, 18 Oct 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Tue, Oct 18 2022, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In 7f5397a07c6c (cmake: support for testing git when building out of t=
he
> > source tree, 2020-06-26), we implemented support for running Git's tes=
t
> > scripts even after building Git in a different directory than the sour=
ce
> > directory.
> >
> > The way we did this was to edit the file `t/test-lib.sh` to override
> > `GIT_BUILD_DIR` to point somewhere else than the parent of the `t/`
> > directory.
> >
> > This is unideal because it always leaves a tracked file marked as
> > modified, and it is all too easy to commit that change by mistake.
> >
> > Let's change the strategy by teaching `t/test-lib.sh` to detect the
> > presence of a file called `GIT-BUILD-DIR` in the source directory. If =
it
> > exists, the contents are interpreted as the location to the _actual_
> > build directory. We then write this file as part of the CTest
> > definition.
> >
> > To support building Git via a regular `make` invocation after building
> > it using CMake, we ensure that the `GIT-BUILD-DIR` file is deleted (fo=
r
> > convenience, this is done as part of the Makefile rule that is already
> > run with every `make` invocation to ensure that `GIT-BUILD-OPTIONS` is
> > up to date).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Re my earlier feedback, I came up with this as an alternative, which
> nicely allows us to have "cmake" and "make" play together, you can even
> run them concurrently!:
>
> 	https://github.com/avar/git/commit/30f2265fd07aee97ea66f6e84a824d85d241=
e245

This approach _still_ modifies the `test-lib.sh`, which is the entire
reason for the patch under review.

I hope you find an elegant, user-friendly alternative that leaves
`test-lib.sh` unmodified even when building via CMake. I would gladly take
that and drop my `GIT-BUILD-DIR` patch.

Ciao,
Johannes

--8323328-128553218-1666102871=:174--
