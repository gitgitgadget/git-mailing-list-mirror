Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A42C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 13:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577143AbiAYN26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 08:28:58 -0500
Received: from mout.gmx.net ([212.227.17.20]:48251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1576915AbiAYN0q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 08:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643117197;
        bh=zcTFG8QNDKvqQKIHbAocSf6f0ZZKAJvaXAVEUZg+eVU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VQOwxVLb1aEa9Nn0Wq1A+HAlSzkF9PIz12U3i+mXQR28KuPkQS8A8nUlljlHfS7cc
         SuQu7XVAofFJMy9llJekxmOqmy1glCzji5FbmLarU4S0FsccDTFAxEA4U87wP0dSqZ
         LCUDA1s3I1t6nuMMQOB6mHA5NnMZR4XzgAu3dPNA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.213.181]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbzyJ-1mYsxG2ann-00daI8; Tue, 25
 Jan 2022 14:26:37 +0100
Date:   Tue, 25 Jan 2022 14:26:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Scalar vs JGit, was Re: [PATCH v7 0/2] Conditional config includes
 based on remote URL
In-Reply-To: <CABPp-BGtA1KwV8kdN52r5=XTCZrS_e3sPYfTxMnoEVyVV8Hc_w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201251424530.2121@tvgsbejvaqbjf.bet>
References: <CABPp-BFLNqLuJ8o_6YZDYgd=Ft+wc9EjBPX+RRzwAdASKSW2bw@mail.gmail.com> <20220110192246.1124991-1-jonathantanmy@google.com> <CABPp-BGtA1KwV8kdN52r5=XTCZrS_e3sPYfTxMnoEVyVV8Hc_w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:L+0lUi3pRG8VquDWLFX13BlFc6Ozn3KaL5n6m4LrWHWmcfASU8J
 uR11jPA9SCL2xzvwmV10P7/frK0JEe60WYBda7I7vJYES7DRtgsKGjqdWZVFPwfFuIO7u1+
 ITC66FzbmDc+QjzCPG2Ws9PahNKc8vMFOBZLQunRPt8+kkd8VrRHeWFD26jOfP/dUGzPr0w
 UNYHXO0abmbGn7vDhrs6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:adJJr8KeN7E=:I9WoyTbz5Hg6fsQ+/UlZMJ
 +SNYq9Tx36ooizVgNv/DR0HUaB4L9NDVuWQUhsbJyhkfKm1ErS4GECyU11npPlAoJ257DvwDK
 TjAsTGPg/Ur01ZN7dW0XlI6/DBV7Rz25UuGXiXAE1PaoKHBhELdY+kZ02Y4HxNKIusydwL4DK
 ifQ+p/w0kFcUZXjC1mqjfBLxkRM3yyn8s6tgGlXO6ugSN5r8+diEcyMZXRMBJjZarg0EWR/Ru
 9asp8pr7+QXZo6oBL6cfQD0Nstea2TMJGOuTxoGoVC1+KmW2ktAQ5MBFe984izWLd7lOVG0be
 YvMoE21hU/JfoJpaoSSPBSUF+MBALAlnZpwoPs+kt8ZVsMFgnQylHE69xVyt04/W7WdGBMxPI
 6E8OthVeTwAcSzkw2Qmm9RubPQyL1QIHT9Vh1RN3v3NOF2o2iX0NfEAW2WfUSCHHPmgaSNzuT
 XU9ab/ofbR5bKRUbyZD6hTTK9xENzJ9k3FxvgnJSgdVg6SrN/dvBHtemH1UGM92DhSzNHijSV
 /d5ozt0S7W6YIGG1Nw9RMvd5I4HKkYpvMvw8zH93fCxBOJXKI60C9y2+AN1TAb4QYnilJHUMy
 nIQ2wJgDK57QhafF6T3TLoRr37fTcYyWA9Kg1PjOiYu+I2L9hqDw8y93WzqmR1qAEajAP8vLs
 6KxeIbD+Fd2gpHukEs7glUkA0FKr1M8zgBF9uarzMRpXqez2W66DFmd0sbWtCyT9NkU9sU/iz
 cXZq+yn8InrHmwR9uEFbiri1iJi++LWQFq+X/lW/wvLyQAwucvbkiZ5cCOD6wdBAJGHpJUYLw
 C1pwUmmHH/9gp4f/owaG3l6HnJn+yXM4JaohRpGqbOdk3FkNcR9rftURsdQ+G4hRVFEidXG3b
 y99wZCH8cleGGd1ZgeoCnh0D2NmWfu5nlwRzbcZsVmJu9uXy17aHioYG4mdY1su2mAewSpJ27
 a8ZXK/r0DlCbKWyHC4+3Llac8UHhVYWMmsBceVvQA8XR/uBLUsPUAcw/8ZEUfyRveiS2Z7A/Z
 VmZkZSZfYA9bL579sFI1+/WeU86lFc3BODZSJCTTuTi1kdg2Ill9Qth/hAvee5Zg3gLFkfPYj
 cbfWO24rX81Xx4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 10 Jan 2022, Elijah Newren wrote:

> On Mon, Jan 10, 2022 at 11:22 AM Jonathan Tan <jonathantanmy@google.com>=
 wrote:
> >
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > Scalar also has a mechanism for providing potentially large blocks
> > > of pre-vetted configuration for users.  It does so as part of a new
> > > top-level command.  And it does so with a very opinionated set of
> > > values that are not configurable.  Thus, while I'd like to use it,
> > > they use a configuration option that would break things badly at my
> > > $DAYJOB.  (Too many gradle plugins using jgit, which doesn't
> > > understand index.version=3D4 and will blow up with a very suboptimal
> > > error message when they see it.)  And, it's very specific to scalar;
> > > we probably don't want to add a new toplevel command everytime
> > > someone wants common configuration to be easily grabbed by some
> > > user.
> >
> > Do you have more information on this? The closest thing I've seen is
> > "Scalar Config" under "Modifying Configuration Values" in [1], which
> > seems to be more about bundling additional tools (which may change
> > config, of course).
> >
> > Unless you're referring to the config bundled in the Scalar tool itsel=
f,
> > in which case this patch set seems orthogonal and potentially
> > complementary - I was envisioning config being provided by a package
> > manager package, but Scalar could provide some too for users to use at
> > their own discretion.
> >
> > [1] https://github.com/microsoft/git/blob/7a514b4c2d5df7fdd2f66f048010=
d8ddcb412d0b/contrib/scalar/docs/troubleshooting.md
>
> Yes, I was referring to the config hardcoded in the Scalar tool itself
> (see set_recommended_config() in
> https://lore.kernel.org/git/4439ab4de0bc3f48a6bdcf4b5165b16fad792ebd.163=
8538470.git.gitgitgadget@gmail.com/).

I was kind of thinking that such problems might be solved via introducing
e.g. `scalar.ensureJGitCompatibility =3D true` (which should be a relative=
ly
trivial patch to write).

What do you think?

Ciao,
Dscho
