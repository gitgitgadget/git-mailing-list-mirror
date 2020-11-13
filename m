Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAF5C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 13:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2D520797
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 13:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JdRHOjyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgKMN6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 08:58:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:51089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgKMN6W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 08:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605275894;
        bh=ANCBCFp+viPH2qwBvtsUT6w3+T4qwlZWv7P6K+8HdTk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JdRHOjyiXQGhaSpyvTHfSv5Bkls6+DaVHDyJQs9C85vw+a2CMamAUurzJwDdqYztg
         /xiTynzoL9J3CY1ADMZyRa44dPXgCm4/JbdTAQ20XRLPH/cKS4KjYATVFKXjmy7REt
         zwXr7OLSn3Ilqrx1+G9WpWcDvrHKepmrMf3IgToQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6e4-1k4mjb3kCM-00hfdw; Fri, 13
 Nov 2020 14:58:13 +0100
Date:   Fri, 13 Nov 2020 14:57:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood123@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 07/11] add -p (built-in): do not color the progress
 indicator separately
In-Reply-To: <918a0a1d-6384-5615-c343-1f03046770f7@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011131455460.18437@tvgsbejvaqbjf.bet>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com> <pull.785.v2.git.1605097704.gitgitgadget@gmail.com> <73b6d60a801766605cde9403d7a9e8451ef99e11.1605097704.git.gitgitgadget@gmail.com> <918a0a1d-6384-5615-c343-1f03046770f7@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OK+W5gaDkmWVinnRibZebvW1QvTuaQdxGvFp98Vn5Z9XWHlXl4r
 B8T9F/PXD7NHcUbo1YEQqbxOLT91RQ/6dPJ/iA5AWfMGHdbGWgrQbmfOSOMNZj2WeJ+iLGg
 1r9+y6UAt5PG/PvTdHsHZHog55HATszQ/qrwurZF/SIJfvGwc9RojIMjUnBhm+Bvs8BLR/m
 hnT26w6psIKdxuJqGUVHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eIg9Woa5RfM=:eYA4E6pB84DWiPLKjozTOU
 HiDYqaYqceKX6scfavziyidJZyU6h56E0BBxx4GbIiMtDxJ4qTRzPJIPpiPqIy0aY5nsvRZHF
 IHkDSSDKETMvGrD/gSvFKeT7iiXvg0+mWH7oT623LjsKLB+UXFZvrxeCkqj7rxcZ63EvA3p/j
 BU4O3Z25HS8o/wsmFb/9DoVgKqesShKACZagpYJN812glZ79J2v1UHBLuhsaWd2Qzk4NyvXba
 UdVEzc4jNepa4jWIGh5FW0JxLBdWbhWTkAV42MTbbLx04add6slkPY2zv3DJBd+8pNRMBeWkX
 ndeQv+Zl3kSjDUClDTyN72EMBAQ8eKGzxJ/nAVuDjbVWqDdRrCsRnMUvPly3driEbOHbSEVS0
 ejA3oq/xUnxXtFT0YtWHazuelVs5aU5cVW5Me+nF+u0tglOlYkkFDhJJmJwROBcrNet85zglT
 JqAJtoSsahwBR7dOp0VRPmTFCL8W/GYQSTesDkZjzQPSxrw1ppwh0CFHOwzE0+V9IjbRbgunP
 yF/nOMhLI/+eTskYH+euxdHeiKbBZKCJbKlz7hUaMvpy5Tvs6k3u49wL4nnOVVlOfUvaLgna4
 JGIqkUGk5pp8UX9xbPaHBK1fESbUaSvh5fVGy6axqIKxAuxd3n6pqmpDtfknIg4WCEehEX0hK
 mrjp+welMNbmALkI0hEHaqVLgonqrue3DlJRj5oBmmuHFF+z5O3qj4HlL2suw+cHMss7YUdsQ
 GTyY6vDx59esu49sU6ERyHpcn0b3/zuG3F+lxws+gKVTQ3BZt7mmBIPJP3K7Spg9jc+J3xPJC
 sbJeJvXNiNNiRMw0zvckgLAbvl4pnHVHHgHTzKXx7xI4poT3T5qCT3m30WQmVIxon9Io8x92n
 Vwnr00+yYQ+ySWvDMhZv2YhfXB3ZdSTFDy24MuHug=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 13 Nov 2020, Phillip Wood wrote:

> On 11/11/2020 12:28, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The Perl version of this command colors the progress indicator and the
> > prompt message in one go, let's do the same in the built-in version.
>
> Why? the C version has access to an api that means we don't have to reme=
mber
> to print the reset string each time so why move away from that? I don't =
think
> it matters to the user that there are some extra escape codes in the pro=
mpt of
> the C version. The answer is probably "so we can use the same test as th=
e perl
> version" which might be a good reason - if it is I think it would be hel=
pful
> to say so in the commit message.

Honestly, the number one reason is so that the _same_ test passes using
the Perl version as well as with the built-in version, something that is
required by the `linux-clang` job in our CI build.

I am not really willing to change this, unless I hear a goooood reason to
complicate the test.

Ciao,
Dscho
