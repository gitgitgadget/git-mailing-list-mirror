Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C69C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A21142074D
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EnBr0KKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgHNOZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:25:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:44549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgHNOZU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 10:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597415106;
        bh=HLzSU4UGaGrgZ/ws2JpV+4D8EQ/C995mxfuPLLa8QfA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EnBr0KKyYcQIWjKd1b9o+z96qOx5g/mceqwtY4Zd5EbjA5jX0m12ExB2Z51XwIZt3
         i+m2VUpn3bXl0CXPbmWdPplZWDetd2DvdZJZDNdJTXcAE4O6o9U7f7XqeBRWcoSory
         DxTaWPQ1Wad1wHixP/UGrc7g+7qEPTUkYHnzBAUo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.231.116] ([89.1.215.129]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8ofO-1kiTky2Yxq-015p4C; Fri, 14
 Aug 2020 16:25:06 +0200
Date:   Fri, 14 Aug 2020 16:25:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 3/5] make git-bugreport a builtin
In-Reply-To: <xmqqr1sa1iym.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2008141623530.54@tvgsbejvaqbjf.bet>
References: <20200813145515.GA891139@coredump.intra.peff.net> <20200813145936.GC891370@coredump.intra.peff.net> <f576fdce-9005-4653-3f91-0ddd2fff125d@gmail.com> <20200813173845.GA1598703@coredump.intra.peff.net> <xmqqa6yy2yjb.fsf@gitster.c.googlers.com>
 <xmqqr1sa1iym.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:K/wrDIWBPcq+BpcbCNQH/6D/Wyl4sgA0ZouEpGdBuqjlhfqsLTL
 HkS7lbJ8CZdYnc/VAelrSf8sWPLIKyXVHrQi1n0mWWa0sRJKisWI6c9ypagXDUx2Jd+KMSK
 olINUZgVTowWeiMwIT4ALIImAPq6EPTEW7qpQRr6kXy3ZJYP0artDcfNfzY33Av9HSdQMAc
 FotUPtdQTfg8SBbr9a64Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SeR/qQey4dM=:j3KAzyjGKC9RH5wKwd5nBh
 DgJ33P2R/6vI2vuZLiB0njIKpVx3SleXVFe3+N8QKVDj4O6d3Nr4P5X3hj0HSyJ4xWQRwIJ5p
 jbunQusehJ0QfDBMyagjpadrarwLgSMNy09NRsT22rBGDTW5f/MPZBWT1JdH1pR7irgOIkh+H
 kWnesSIPKk2RCdh3+bAee+t6kX3b+ijTeVHOZ1Y8fHrR1tO0D4Yt21N/ER1+9+r4A+QXsFleD
 4iczLXX5M/YC8+NUFOx+1Gv8kmlYGAEuloSEyEsD4RxPWewsGbCWJT2xa3XosmrKLk/+Ii+A/
 C0Ry29wW1Tw+wpW6XzwlyxjrmKkRNFXZozDNCvYTL9DIEECObbYBbPVfQLv2CeK+VRnJDOtZr
 W5nDslzqmZKHv7BGDxI83t99VLbiSgdFX3BXwFN5J3B4fXDImA8eYa0NV5V/YNIl22/EEzj4w
 GRHgxXAC8hxglfFqIYjEJXJanvK6d1Bc5pHjSq0N5xg8JP+EeNnqDr7wVU7ui7TCgm+2AhO3o
 ozdstqzJakm8j3HovEo9gTyHV+QYDxAhxMeEg+wOnoPEQexrKjrxRf9KJsL1FlwT97XcbRXCl
 16muVo7jNesDTMXSjvc63j6Oe5eSJljFao5w8smDHjl8WIQIb+ImVAklEjLuR1WyWxn9C2n7f
 9gViPmpAauACEO7v/fOLA/Gb76VRCQxceioxz6h6mjUhwZ4sl4wgfBVJoIIw+P4oTkPr3smjX
 Ut/vKl69LMtFeXFa22l9LNX23iWVRpmvcBzjm0g0z5F9apO5q1nHTsUiBuWZluFvsvnk7IZml
 QI/VAl5iiALbicuGFw9URMDJJv8VratjU8vx/V1Is6vWTHM2B2pL042B6fXWagqNJAnomJQwb
 AeN+NqJcMIRCvSxisku/HorZ5FHL2o7zsWl/nMwij3yvC/yYz3+oTBHFfax/shq6W7jc0ANWh
 DTEerx9CBmxDo3fiHBp1HElgV6NsXjXFicukJvr1SmgXTJIQbYNMeOez5K/p1UoivIEaiqUJG
 Au9iYJ+qov/GGGM6Z37qoQsKCln322OoGhwP0QOADl02ip/TU5UqtLcAmVCerEIZglnvkPkzH
 rPuqULsVfzmStvHMwCWkRJbqHA6deEcuemZTEBlAinVO9Hnc0XvM/h/Z9QRkllbSKP0VNtnGw
 gWugbDFfsA1J5Zxg4m7VS5/6sdGN1TIs4Q0J2nW0zeEwuAU41mhKMbZL1oHxdaTS7WJS7p5pn
 dOa/MEpW8NNlNMxkKeyj97jgae/whhgqUFTOVsw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 13 Aug 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Jeff King <peff@peff.net> writes:
> >
> >>     macros). That could change eventually of course, but it's not lik=
e
> >>     switching back to a stand-alone at that point is a big deal.
> >
> > If it is not a big deal, then I am fine, but at the same time it
> > becomes unclear why we can say "we can use X and Y niceties only
> > available for builtins".
>
> Actually, there is another issue that is potentially a lot worse.
>
> "git bugreport" not being built-in would mean that the compiled-in
> git-version MUST not be relied upon (it merely is a version of the
> source "git bugreport" came from, it does not necessarily match the
> main "git" binary when we are dealing with a confused user with
> GIT_EXEC_PATH problem), but has to be asked to "git" binary on the
> $PATH externally.  That needs to be done for any non-builtin
> binaries (e.g. when user is having issue with git-remote--curl")
> anyway, keeping "git bugreport" out of builtin would force us the
> necessary discipline from early on.

Since `git bugreport` requires specific functionality from, say,
`git-remote--curl` we would already have a bit of trouble in case of
version skew there.

But yes, I am glad that we finally can at least rely on the Git version
`git bugreport` reports.

Ciao,
Dscho
