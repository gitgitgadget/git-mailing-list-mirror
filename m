Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3068CC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 19:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiAGTg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 14:36:26 -0500
Received: from mout.gmx.net ([212.227.15.15]:35301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232622AbiAGTg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 14:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641584182;
        bh=867Q5kmrLt5etKKlGpUTjnPYYf4KFe5TATEPXSSBS6o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MVBZZP4nFC4fcC8dTMJPkD3VrsxY/raMEZrOEwkekjER10y71qf1YT4dnX2Fl/dNo
         L5+xkDGlSUeaPod09lUwv/XAk2gwqOicl0/W8L/NiAjSQECHKilABCrFvTkOjZHa63
         y+f5OJHkfQkzZ+jLbW72gEzyM5If9Af5DwGXaJGs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.133.218] ([89.1.215.56]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt75H-1mD8gx1fD7-00tWbC; Fri, 07
 Jan 2022 20:36:22 +0100
Date:   Fri, 7 Jan 2022 20:36:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 8/8] merge-tree: provide an easy way to access which
 files have conflicts
In-Reply-To: <01364bb020ee2836016ec0e8eafa2261fb7800ab.1641403655.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201071908580.339@tvgsbejvaqbjf.bet>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>        <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <01364bb020ee2836016ec0e8eafa2261fb7800ab.1641403655.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iBqq0mh1HvLG8j8VdzPlQDp4vtnZLcF0H9oAhi3/UaSo5AOJlgM
 K5JPofrP7lMsK0ZZEBwoVGUyR54qZSdFBupk/iHAp9SqxuSJIL7WmY8gwIkOSBDla+oCeU5
 ZPD8nWRhjiBf+MLFT5OY1wE8knsleFUtuOhkJWsD8h6hPKOP7J3TsZ98AbONgpNEcOxqy2n
 kbu7M4C0cvOio69tKxNfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ad+iv5V4LXQ=:F8tVGR2eLERCSAofJa2vky
 Sm+LF4YCEwTGRKeYbmxQT/a9ymUZHHv75YaCI0zSblVMYZQ8oXa0rv4LnEPXtQesoovA4buIq
 xhBx82f/Ykb1jRTXFReb6D8TOe/4hV1L9QcpbqoHuL4NhWqovIGSySpPkdypQrvbR9BKCaF+n
 PS1bWtIzr6PdJZDFAW3rixAYA4iThS6OwUIqZEZ4SPIjL36Y/pmJSHAlRiC/3HN0uTuUfqvzD
 38uS7OxQjD/sX8TKHeD8Kd9c5EdBD3FruAwkM8HfL6tiJU9e5NniexKVbLJXTEmoR6cA3BBIN
 RTiCxUUAsPjNzs8Y4vj1zsmMU7ySs2haGlPCCoIcGe50SFdKDn3H53vQugvTYkF+PGY4mEnzG
 U42UY+ddukXGG2Xadp7oBDRxZVTh1RLBmK2CKv1SP/N/SxpQXAnLTPLtablXx2Btl0SRoZRD5
 6pFYF2XkUe+JDfbr0r3w439rvwQIprrl4zetX5tvLp8mUJ77tXt4vXIsgYDUDSJFNWf3FCg8E
 H882k9f6gbhN6DMI4Jeaf/DBxOfdPGNRp22/NnjUMPzwLO/pwdLIj997ciJrMiotTYGNF0oSU
 p5au+tb3sD6/pWzQXnafSmVSv95tOv43dYm4+kFlWKBKB+BcPA+A2A8GGtmcmbOCmOU91Xk3q
 GBqU+mKi3MoTFqsAof3eL8vdmb5rOrteU1eZI9VkJ5HMAAqIFjWLKThBDX/Qho71/Elis7NYR
 tBQEbGrT3+dBKb4inKQP22Aw2EywrnQzTtsuJmGe2YZs33OCtClXVqWB2uraZKDTnzizoFKEg
 eADnTjrJ0mNX4YODf3QwDlfafEU4ajT7dIh9tl7Y+FqixjKM5kaS24rMcNE/MiqZ2AyjU/F4N
 YYxDm+ipifLSBVncTZAZ5KuzQVbQZtWG1wZYZF3wqoO1fVPX+R94LtIvyYc8MophbZHv4gFU9
 9Xq+gRJQfAS7DxjhKn9Sv4liGrEngV60ebdZQA3fnr9nsYpKVJ6BcWnpi3kjBB2tLFg1oZD0Z
 MsaZgZs4gEDv1iGcUySIQORvfRXIZiEEZZpnTvniE4MdXA7egBIApE71eM1t3fKEeDJ+xC3v5
 yPnR/W+wWxlAn4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 5 Jan 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Callers of `git merge-tree --real` might want an easy way to determine
> which files conflicted.  While they could potentially use the --messages
> option and parse the resulting messages written to that file, those
> messages are not meant to be machine readable.  Provide a simpler
> mechanism of having the user specify --unmerged-list=3D$FILENAME, and th=
en
> write a NUL-separated list of unmerged filenames to the specified file.

This patch does what the commit message says, and it looks quite
plausible. However, in practice it seems that you need either a tree (if
the merge succeeded) or the list of conflicted files (if the merge
succeeded).

So while it looks relatively clean from the implementation's point of
view, the design itself could probably withstand a bit of consideration.

As I hinted earlier (to be precise, in
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2201071602110.339@tvgsbejvaq=
bjf.bet/),
I had the chance in December to work on the server-side, using `merge-ort`
for a bit. In the following, I will talk about this a bit more than about
this particular patch, but I think it is highly relevant (not a tangent).

One of the things that became clear to me is that we really have an
either/or situation here. Either the merge succeeds, and we _need_ that
tree, or it fails, and we could not care less about the tree at all.

In fact, if the merge fails, we completely ignore the tree, and it would
be better if we would not even write out any Git objects in that case at
all: even just writing the objects would be quite costly at the
server-side scale.

So my (somewhat hacky) patches for a proof-of-concept produced _either_
the hash of the tree on `stdout`, _or_ a header saying that there were
conflicts followed by a NUL-separated list of file names.

Mind you, I did not even get to the point of analyzing things even more
deeply. My partner in crime and I only got to comparing the `merge-ort`
way to the libgit2-based way, trying to get them to compare as much
apples-to-apples as possible [*1*], and we found that even the time to
spawn the Git process (~1-3ms, with all overhead counted in) is _quite_
noticeable, at server-side scale.

Of course, the `merge-ort` performance was _really_ nice when doing
anything remotely complex, then `merge-ort` really blew the libgit2-based
merge out of the water. But that's not the common case. The common case
are merges that involve very few modified files, a single merge base, and
they don't conflict. And those can be processed by the libgit2-based
method within a fraction of the time it takes to even only so much as
spawn `git` (libgit2-based merges can complete in less than a fifth
millisecond, that's at most a fifth of the time it takes to merely run
`git merge-tree`).

The difference between 0.2-0.5ms for libgit2-based merges on the one hand,
and 1-3ms for `merge-ort`-based merges on the other hand, might not seem
like much, but you have to multiply it by the times such a merge is
performed on the server. Which is a _lot_. Way more often than I thought.

In this particular instance, there is a silver-lining: the libgit2-based
merge is not actually recursive. It is a three-way merge. Which means that
we first have to determine a merge base. In our case, this is done by
spawning a Git process anyway, so one of my ideas to move forward is to fo=
ld
that merge-base logic into `git merge-tree`, too.

Anyway, the short short is: whenever we can avoid unnecessary work, we
should do so. In the context of this patch, I would say that we should
avoid writing out a tree (and avoid printing its hash to `stdout`) if
there are merge conflicts. And we should avoid writing (and later reading)
a file, if we can get away with avoiding it.

At least in the default case, that is. We still might need a flag to
produce some more information about those merge conflicts. But even in
that case, it would be better to have a list of file names with the three
associated stages than to output the hash of a tree that contains
conflicts (and tons of files _without_ conflicts). The UI needs to
re-generate those conflicts anyway. And remember: a tree can contain
millions of files even if there is but a single conflict. It makes more
sense for `merge-tree --real` to output a concrete list of files that
conflicted, rather than expecting the caller to discern between conflicts
and non-conflicts by processing a tree object.

Maybe you agree with this rationale and re-design the `--real` mode to try
to avoid writing out files in the common case?

About the form of the patch itself: I was tempted to go with the
nitpicking spirit I see on the Git mailing list these days, especially
about the shell script code in the test scripts. But then I realized that
I find such nitpicking pretty unhelpful, myself. The code is good as-is,
even if I would write it differently. It is clear, and it does exactly
what it is supposed to do.

Thank you,
Dscho

Footnote *1*: I did not _quite_ get to the point of comparing the
`merge-ort` merges to the libgit2 ones, unfortunately. I was on my way to
add code to respect `merge.renames =3D false` so that we could _truly_
compare the `merge-ort` merges to the libgit2 merges (we really will want
to verify that the output is identical, before even considering to enable
recursive merges on the server side, and then only after studying the time
difference), and then had to take off due to the holidays. If you already
have that need to be able to turn off rename-detection on your radar, even
if only for a transitional period, I would be _so_ delighted.
