Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960AFCE7A89
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 09:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjIYJGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 05:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjIYJGW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 05:06:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF16101
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 02:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695632769; x=1696237569; i=johannes.schindelin@gmx.de;
 bh=hYOHuK7xArREu6ardvDVeZIjNhCX7Sw654bvkJ02jm8=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=eZ7xi84xNhSnOl7gUyTAjrm+bbJ/JGHGzCKgFJ7SghJ8CqSlX5yUR8rxOw30wWxUatqtaFE0zVX
 PKJuWVDgD19D5fdz2wC7zCj5NRajev3arTYQNZpHjhJw6kYMTFl1vXjFLuHx0wegdKVmys+xGZI3Y
 +F1VzPFAobSmX7aG85rY1Nh83+TZzQdocYF/n5E1uIq9Qond/D5k2wLGcQoTt9UVYjTyRh+FI1tjB
 8fhaXT//sC66teV0nZ4D3lb8fgZLei4g/8yuzuE2fBVYJveTvGoMvFLWxxu6i4eJeUQ4dRA501w8M
 1RpbhHf9qyGmDFhWVDp0FHvgYGx0bxK4YvUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.206]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOKi-1rfPCR2OUw-00ur6P; Mon, 25
 Sep 2023 11:06:09 +0200
Date:   Mon, 25 Sep 2023 11:06:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 6/7] cmake: use test names instead of full paths
In-Reply-To: <7d1d78c5-5781-4f5e-90f3-c02e74af31b2@gmail.com>
Message-ID: <fabf28b2-7579-c214-34d3-2718b158ac13@gmx.de>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com> <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com> <41228df1b469d9a79f3278fe8c1ca37082600669.1695070468.git.gitgitgadget@gmail.com> <7d1d78c5-5781-4f5e-90f3-c02e74af31b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Nc3OU0+bNMDGuxykPWGTDeLiElxPvGWhQ3uTInTD5bDMIVe8w3O
 G1FHoOwD4eqGcp+EoP/kpToBnUU1Xk/Cx46g8OYLpHIQLB+kEg3wNyavHGqvPuZCPB6CsKr
 HXdEQHU/b0o1FcaRfdXJVreiNN0jlP1c8eetKQrasegDckg9j5cBioV6rsBYB2FCMukAg7x
 RJHBLlPFx/N/HeRdRaGjw==
UI-OutboundReport: notjunk:1;M01:P0:07Sd3cMTmuo=;Mgnc+r8pf/iYaBkmGaoy0jPELfX
 l5I0Q1LXaAwFfUij4mQvHFXzl/fflNeb8hZK+0htq5HDY7Y9gIdSeYsv58MBPSmZQhIk4gHBB
 BkV7QN0H68WNFIzI8fDvDgIO4iI3Simdo/E5hieO9xHt6jjX5HwCkS2JuuD9C1RS1Gr0FRLjN
 Tw6lYqz/lvOFahZYCTBtxJ3neDw4qEhT7U73MNVtNRLbWFqroOQdyo68K6jxo9a9/zInLJg6l
 OOeaQnpQ9e+VUo57o2BXrosGPKg2tnvT9blYUHt9qetlK8x/ZkMUFZDBsTF4i9Z9xLHXc6SMZ
 rJbYCpCfoR3zC6XC3uE6GN6vMfj0I1O2wm34WXJNNCJ/4pcBdv/R3RrczTCiv689kG5sDkX/v
 8Va/PFv6fC5Gw2la+UQfdv1uUbEy9cZ50FudQiaLd1yipUV6Hh34RlFwUCSMoPHhNykYmVsSF
 pdNWXGRJg6Rbc/0zGOdWhfPtstSI+A1FgXJkXz2l8XyPRYM16np+Rlhhv3XL5WsrMiDio6v6l
 wqVavXON8VOxc8WVQdpeQk4AMQ78q/YP29Xe0z7TaRxM6HGqkPXQNevWJZQ/emlwpGidrfr1K
 R1ztR3RlatIKO/63H5IeJEOs2DEOLSWTFUumOvduXJK4s1hth8ZTlG58atqDadwiXGGrsZsfK
 Zt8fGmeBtIeCGvxpSW80xEKRe6UZa8cCAVkganYGT1E/4zba19gwBe+HcWwMS1jNZK+YqSujB
 rWt0/LYiU3HGWMvNTw8fGQS31uyWFv547Cgd4YpR+f2cMnptHP6DzxXM1NTGqgoWBhOpX+g15
 WoVtLaCb+BvBijf8O56jiMlW3Eb8MXfJ0fkn08wmgNmgfiVqoKTynXH/l6jbE4ROWzok06nPG
 nocY6STWIBdczAO8LXy8tfsh2ZdUaJEOSb1K7lcz2j91kc/uI3CtSHmO3syA+b2+IkxHQ8c8i
 +n7m6UCCe9us/ZnucJaTVhJ22+M=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 22 Sep 2023, Phillip Wood wrote:

> On 18/09/2023 21:54, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The primary purpose of Git's CMake definition is to allow developing G=
it
> > in Visual Studio. As part of that, the CTest feature allows running
> > individual test scripts conveniently in Visual Studio's Test Explorer.
> >
> > However, this Test Explorer's design targets object-oriented languages
> > and therefore expects the test names in the form
> > `<namespace>.<class>.<testname>`. And since we specify the full path
> > of the test scripts instead, including the ugly `/.././t/` part, these
> > dots confuse the Test Explorer and it uses a large part of the path as
> > "namespace".
> >
> > Let's just use `t.<name>` instead. This still adds an ugly "Empty
> > Namespace" layer by default, but at least the ugly absolute path is no=
w
> > gone.
>
> That does sound like a worthwhile improvement. If we used `git.t.<name>`=
 would
> that fix the "Empty Namespace" problem? (probably not worth a re-roll on=
 its
> own)

Turns out I did not play around with this enough. If I use `t.suite.` as a
prefix, it makes the empty name space go away.

I'll do that, then.

Ciao,
Johannes
