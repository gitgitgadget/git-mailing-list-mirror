Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643E6C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 13:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbiBYNkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 08:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241562AbiBYNkk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 08:40:40 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FE221046D
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 05:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645796401;
        bh=Fs624ReXDLmmgv2tasEYaYVZewtatqGvH8RvK7axcUU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QNZVRRcoR9q40pxUSQy/PgSGbRmPeHifOltGzlZOqDZBhmTgsbCmEzrjObNUQgjRW
         FBs25Kw8YREcfITVPGmieAb6c0ZabEg7Hxwp6IBJuXGndOm+GlK1wOAWNPJK4KE641
         chd4JQDIuHfN9IAqBMxYyuUkjnoQzuMljGXcPQqc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsYx-1nRj142WNz-00HO8m; Fri, 25
 Feb 2022 14:40:01 +0100
Date:   Fri, 25 Feb 2022 14:40:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/9] ci/run-build-and-tests: add some structure to the
 GitHub workflow output
In-Reply-To: <f73586a9-e9f1-aa1d-ac22-8102e6583e2b@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202251439160.11118@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com> <9333ba781b8240f704e739b00d274f8c3d887e39.1643050574.git.gitgitgadget@gmail.com> <f73586a9-e9f1-aa1d-ac22-8102e6583e2b@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mKKPMNCzZJep8SAlugGVuIfMqa8aSwl92FzhZpmPlCHrsB9T1Np
 V9GIqNQR3l+ibW/k2R0DEdMCqlWR25AQYiBRzpASLZon7QgeH7UeW1x1d68VPv3npDy3zxa
 0LJDvjQF8HAeWdx61XgYu7/FHlZXEPQc1kn7kmHq5Lmlsd9XnkduooAiSBmJX+dgS/oU8Kt
 9moMNeV4ek5WGF2c9xhoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eeUH4jTa/QQ=:6QikgLpwEl681iAsPJRdUn
 6b8wFdGKnvfWSy8lVVvl/GKpcbNw6dhCLWLIpKtIMMF21lQar4Ij7U6pjMHwVO/B05V5GRbA9
 HS2TD7pk+LeKHaUj8jhgO2tKlYGlikwBb6LrNF00TLOGwnSAIJiOGSucyujpD7oRTWP/lpRQg
 RUvbfeUCBf1PimFQ264DgCyXa1EI19EYo4JwaAzz7JxKE51bp5Ma0CYa6qnfk+lCLsrbmVsP2
 5q+5Z83u/HvYNL9UnQcX+vivv/GTe5/oh+ocm262PjhHKzymEaeiune8nyPM0XBP5JXtEKnYu
 rH8yPH1ti7WTz7tKPz9H00ZurXt5GJ61+rSEGko/wtlBJI26F1p3ahW8Wo2Bk8VcKZLZnDmha
 WV60bMo+iEQOh2rarnCM8nca9gdZHnohFRCA+TTzX2jHO26qrPkR6ke4bYf6xk0q+jhiXrK03
 xgErmtJJLreJygPup8RVhcWJ5IvzGc5UufOsRdVl+lJ9tOZM7kaDSIEV45UPhuNn547d6ixT/
 sAEkmgqDE+iPYzgvkRkJXY4GyZ7Uv9A56KfSoQrEz93P90wEAdiogVgVU4R2N+k37pj/DYVXR
 J6AdcdhLozn7lRFVDEjfwqs3qzrmgXGqolWwU9MmlS3KYaca9+mTsZRGLicCQzebnyQLWN6ov
 LVylGQFxQ0HDrxLQFvVN2tKnYtOE+F0xl3B2csYjCHPBgmrDtaaeGbMXf1ZFBtq9Azc26GAEe
 DLZERxN5MqqebnOkLzAaX+2wcm9IQhlPYm77f0PWqxBAOcmxPRwJgq7ZRj/s/hKu4/PGV9G2K
 csd6gcWug2SxrRmScUeitm/i7512J1HkJH3WftuFGrjsiNzB41fg1PjA9CE6NsPMfgIeSYqPh
 B+klzZEDfptSHuM0G8sz8WPOotbz3JP5rzASY3yBkzUOKs7teFxYwd4i2vbwMz9WLdRHly1y2
 dowGbTxED8RThQVFsYjisfV42ughacV9S+lguGj71c3u6Achz2iIrbk451LU1xe+AZJIgJgcX
 AuT6WM0HTHGh6jgNdd/wJrZyNwCw0oM4KnsibMIeqbfx+qOpkWVoVisvMTXkffeX0wgALzFZZ
 +8jTA0mG4dInjU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 23 Feb 2022, Phillip Wood wrote:

> On 24/01/2022 18:56, Johannes Schindelin via GitGitGadget wrote:
>
> > +# Set 'exit on error' for all CI scripts to let the caller know that
> > +# something went wrong.
> > +# Set tracing executed commands, primarily setting environment variab=
les
> > +# and installing dependencies.
> > +set -e
>
> The comment is moved unchanged but the set command has lost the "-x". We=
 now
> have several "set -x" commands in the functions above and one below
> "end_group" lower down. Does the comment need updating as we are not ena=
bling
> the tracing of executed commands here anymore?

Oh yes, the comment needs to be updated. Thank you for pointing that out.

Ciao,
Dscho
