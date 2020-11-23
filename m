Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40281C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 12:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB1C1208FE
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 12:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="V6CY0sVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgKWMIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 07:08:01 -0500
Received: from mout.gmx.net ([212.227.15.15]:49799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbgKWMIB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 07:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606133276;
        bh=aHy+Man78r0UUcmSmErZKy18iEUQuIFjQTk5z6qBYBA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=V6CY0sVbJo2uXkpxIgsZHSHaBu39ruSyuNKCU5AeRDFZPXLM7sSOP2A2wHtWZO7Pm
         EdN++lj0RtiKdMdvMmIYSKowZqxjQGrZoi/mYFvmMFblwKu+gifQdUU+B6e0YZdVXR
         qpZw1lO4NRWfFOVPBxPtfauEMWDGeFVGDVPYD5uM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([89.1.213.133]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU4s-1k8voO2fOW-00aVLJ; Mon, 23
 Nov 2020 13:07:56 +0100
Date:   Mon, 23 Nov 2020 13:07:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] init: document `init.defaultBranch` better
In-Reply-To: <xmqqk0udot9p.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011231209470.56@tvgsbejvaqbjf.bet>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com> <1518387eaa95098707878459bc74bd5ef2179386.1606087406.git.gitgitgadget@gmail.com> <xmqqk0udot9p.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MZYV6+Gsr1sFmjo2balVfIrQJqPpR4vPUTuLKtVjKBGzIHCrdw/
 hGLP4cY7S5iRGsZacP9h51HYKwBokqQzruDJenJMriVa8Bs0S3Yeg3btVD3nofHsnMurb2E
 ANI95Sap6VIGuz1uGnNPVn3v4Gn+c+3UNqErtorYZ3MhS/AkZiLPdEm99vm5AvtPympf8kG
 BkT45DJTl3EDt8dOhKE2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cNQ1fIMwEeU=:jDtNNflhWJfcnMdVqH+Per
 0lB5Kp25bCSILzYhXc09Kz89XL443miqF7mn2F2SFmjn5idcu8feAedHHw0ToVQcdTmlMSAE9
 Xx9LVh13xQLU0zXzk2wFf9gLPtu8YZ+6N7ww7rNL5WO9ziwFlV483eq8WLr5CXvuLrMotbS4M
 Qd2zn0N3gt8/DpPlxrs/a7K3oDz42OQ2YTsTqPSXp1r80RAiVzO5CsZkFcS5mR1TlD4IvLYI3
 UFfIJ15Cfyix05eBdSqMp7bSNeG5W4mtFmW3dA1jkZdvAQVJqhehyce5wLFHqSZlvf5K33ofh
 DVzr3RDTBfiOiKwUDNsLhKbMg2C7YjyhACpzcn/IHmNDpBXfD7TNhwSq0Trui3Tn0eTYOp2p3
 8QY0IgNLV8qVLdazXPWbQk3IeJVwU/xL5s1ctEQumrc+48PweqfF8QJn4Ra+JLQH4IiIe09Fm
 AWx13cRhEJhKVNXtQ/NnRJxNvxxxFzUy29a2eE5jWJKynAns3dxoxdyI6iDn04skYIRqQ6zE9
 Jv7dY1IRL0rCsh094mEvJ3VRlrycrxWzOiJOYJcDONe+dTm77sLYncrBTyNGrOWs3LP71Zmgp
 Cjv2zYxShHHpj6GbOEuvtz8hZQIKxT11sJjlDuz3SxAP9IkP4SUvOnuK7uL5R5BFmz6urIFGq
 7eunp5cRHtXmTmPN41n3kAQw1yl2VuHL9RpiHTG/nWkQVVfuIZrnzAFLI3RqY70Q8ythVp63i
 GUl8dcTj0XhVtME2WqdowTAyyGAYNw6pVBZAOLortMJqXk+jEmWjUIhjVupeDPq5OxvCGqzWL
 AQp2On7wlZmMO66drB21NNyFHYQNs1GtDS59tLSSRcAgLxMEdPzqowH+R15be8JCELNYx2fDp
 XJdHEvWqJ1zyTiTpNKC2jBjhnvwOfCJ1dGKzJbzv0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 22 Nov 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Our documentation does not mention any future plan to change 'master' =
to
> > other value. It is a good idea to document this, though.
> >
> > Initial-patch-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
>
> It would have been nicer to have a reference to the original patch
> <xmqqd00a36wc.fsf@gitster.c.googlers.com> here after the three-dash
> lines, which would have made it easier for me to say that the
> updated phrasing is much better.

This is unfortunately not possible with GitGitGadget, which I use because
it takes away so much of my burden when contributing patches.

> I do not think I deserve credit for this step in the series.  Please
> drop "initial-patch-by" when you do a v2.

This is not about "deserving". More than half of the patch is still
identical to what you wrote, I only pasted it. This is yours, not mine.

> > diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> > index 59ecda6c17..19f9f16e6b 100644
> > --- a/Documentation/git-init.txt
> > +++ b/Documentation/git-init.txt
> > @@ -20,8 +20,9 @@ DESCRIPTION
> >
> >  This command creates an empty Git repository - basically a `.git`
> >  directory with subdirectories for `objects`, `refs/heads`,
> > -`refs/tags`, and template files.  An initial `HEAD` file that
> > -references the HEAD of the master branch is also created.
> > +`refs/tags`, and template files.  An initial branch without any
> > +commits will be created (see the `--initial-branch` option below
> > +for its name).
>
> "branch without any commits" is certainly easier to understand than
> "unborn branch", which was in my weatherballoon patch.
>
> Stepping back a bit more, I wonder if we want to make reference to
> implementation details even less, e.g.
>
>     ... an empty Git repository---a `.git` directory to store
>     objects, branches and tags, hooks, and template files.
>
> which would be in the same spirit as not mentioning 'HEAD file'.

Hmm. I'm of two minds there. On the one hand, it is nice to have a
conciser description. On the other hand, it is nice to have a little bit
depth in the description.

For the time being, I'll leave it as-is.

> > @@ -73,8 +74,10 @@ If this is reinitialization, the repository will be=
 moved to the specified path.
> >  -b <branch-name>::
> >  --initial-branch=3D<branch-name>::
> >
> > -Use the specified name for the initial branch in the newly created re=
pository.
> > -If not specified, fall back to the default name: `master`.
> > +Use the specified name for the initial branch in the newly created
> > +repository.  If not specified, fall back to the default name (current=
ly
> > +`master`, but that will be changed in the future; The name can be cus=
tomized
> > +via the `init.defaultBranch` configuration variable).
>
> s/The/the/ after semicolon that ends a half-sentence.  Or
> alternatively, s/in the future;/in the future./

Okay.

> >  --shared[=3D(false|true|umask|group|all|world|everybody|0xxx)]::

Thanks for the thorough review,
Dscho
