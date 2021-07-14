Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6694C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 09:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7BE161374
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 09:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbhGNJMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 05:12:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:48957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238123AbhGNJMa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 05:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626253774;
        bh=pN++tDtxEnXDD8yz7WveEc7SAxi9urTkOb/yyz+hiOM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Vd6AKtsdx/yGSWsiyr6kiXaI8YRtZzPAT3/cGb4LqiPik/ZY8AdcCS3DSjXFkmmeS
         xa2Ct1oFB9pocxGgafYhJX/2D1AVnkD8DhHEie8XSkwci1ppkxm1MqHkzwCYvw4oWW
         Om4UPWEBjeB5vSpNHY6EzgQ3AiLvqbYjS8wwxsjE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.219.153] ([89.1.215.141]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7i8O-1l7lOO0ex8-014kAM; Wed, 14
 Jul 2021 11:09:34 +0200
Date:   Wed, 14 Jul 2021 11:09:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] ci: run `make sparse` as a GitHub workflow
In-Reply-To: <f305f586-c3ac-a2ef-8769-5468a4c3e539@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107141052350.76@tvgsbejvaqbjf.bet>
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com> <f305f586-c3ac-a2ef-8769-5468a4c3e539@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-897848339-1626253774=:76"
X-Provags-ID: V03:K1:2GBxvYgyFJT6FhWl2FTO/yL1OtDw1+lg7PWGX2LyCth5TDLgv1C
 KGnICKxdahoqENP2ZRtfVWZmJLCV+yyOjZ1nZRHGSCCvser8bGnCNaqFKXXl1hpAoPZVmkj
 1/wHvN1xt8amvd/WsOMh67/G7IAI2nWuNtKL4GaZ5r+emYsOj1I/DANByYJ7IAb/AguIjeN
 fVIEGYb5hDzY5/fwMtG1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0weCnn5qUcY=:CzVRX+lZN1Z06BZ7DX14O0
 vw8AJy/PMAZoA2shx2HC48Df5pjYQ/+GRhgVOFsAb/59QXtGmMGz0Gdzizie9Wy5t0CEe+Flx
 4/TgLAKuXxfPXlAeVkvJ6EmTPBooUtjq+fTuAhW4a2U4eYlE4BUJi61CgdUEGdckDOnrZF0BJ
 /KCMRoUpDBdic5A9PzF/cMNUlKPeSrQXuR7oNPdWQFsOotK+yVloUbepTUx9hqkxklZKy2GYz
 mVvzLJxXCu/sxgMw7EGs0b4SMvh/9JW9xQdZfxWR6KSmPtngxxfXOD8LCtePl8O3zsiII4gG8
 G4vHLpXe9Pv/2ZUssc6EB+RCMow1Wb1qeLfTuejWXS+c+zvgcSR8sJXt/2M28Y7WctvbEeP/r
 YKG3goEJJg+UCiYvl0wbkbGylGYKWgHASMeXHmTOdcWk2O5btcBvNA0dVRuYffsXNfIcf7tyb
 AN/pVZf68Q93CyD7kY0j60Ay9xheeEbRRjjdk8X6hEQIIGXeMfcWU9w3k3EnIcRCxYfRmeUW7
 6imXcmq6cf48znN3ZctF5l9RtNOFQAQYY0VW4h3BUd/ckMrAvE9wVaGruIh/QvyMhhLKbeOQj
 Kz4eywRpPA2uGCX7u1f2BIP78HgKw+t1O4It36uRl3um4i/6qfqLfeekbAYw17HLf/5iJJv8B
 XNhOkq3U6e/O+620uxMPgA8b8uGDKJ0EEiXdLcfABYkfw5gtpbWKkieFNpDgknNoIy+Ifuy3E
 L1cev8ZMFOMadSYEssgbiqDNaXDwBdApbvH2UpIW8XaOc0sy54Gqi/+kGOjSdrnn2CtOH1qNq
 VG6zIjviH/+JpGYC50tMXpDsGM0wiyqJgNpX5qzQIcgWPY7x5fV+MkTZsg/5+Po3UiS1kcAgn
 FVLy6HxJrg+X+orKw4tIWSfcmh8Ii1QUqZ9oRYge9cNxKySMGpaxjShwWQKGZguueKlwG0fPl
 Tu2GgXBnUhuy/XoTXRnVNzowRg0S3d/iFh1vVYLr7e14KdoQ7FcId4GbQSu072NNAnjjlvuq3
 9Eja/SC0FsNIDcJdxkMrvXC962I15lv4xuRVgHh6IRNQilbAu1YyLHcDQpHbqfYYECYTBLDp2
 syKaAmw3L1tKhzc0EUsqrLnuN0hYKEvnG6lI/ieSKY89P+jkFQPJvLrQw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-897848339-1626253774=:76
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Tue, 13 Jul 2021, Philippe Blain wrote:

> Le 2021-07-13 =C3=A0 07:51, Johannes Schindelin via GitGitGadget a =C3=
=A9crit=C2=A0:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Occasionally we receive reviews after patches were integrated, where
> > `sparse` identified problems such as file-local variables or functions
> > being declared as global.
> >
> > By running `sparse`
>
> maybe here, we could add a link to https://sparse.docs.kernel.org/en/lat=
est/,
> so interested readers who do not know about "sparse" can go and learn
> about it ?

Good point.

> > as part of our Continuous Integration, we can catch
> > such things much earlier. Even better: developers who activated GitHub
> > Actions on their forks can catch such issues before even sending their
> > patches to the Git mailing list.
> >
> > This addresses https://github.com/gitgitgadget/git/issues/345
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> > +    - name: Download the `sparse` package
> > +      uses: git-for-windows/get-azure-pipelines-artifact@v0
> > +      with:
> > +        repository: git/git
> > +        definitionId: 10
> > +        artifact: sparse-20.04
> > +    - name: Install the `sparse` package
> > +      run: sudo dpkg -i sparse-20.04/sparse_*.deb
>
> Out of curiosity, why is this necessary (as opposed to using
> the Ubuntu package, i.e. 'sudo apt-get -q -y sparse') ?

This is actually a historical curiosity: years ago, I created an Azure
Pipeline that builds the `sparse` Debian package for the specific purpose
of using it in our CI builds (if you care to look at the issue 345 I
linked above, you will see how long ago that idea was in the making). Now,
the historical curiosity is that back then, there was no current `sparse`
package available for Ubuntu, and Ramsay mentioned that a newer version
would be required to run `make sparse`.

And when I implemented this patch yesterday, I did not even question this,
I was just happy that I had come up with the GitHub Action
`get-azure-pipelines-artifact` (to help with the `vcpkg` part of our CI
builds).

I was already writing a detailed paragraph in the commit message to
explain all that when it occurred to me that two years might make a big
difference and an up to date `sparse` might be available. And lo and
behold, this is the case!

Therefore, v2 will no longer jump through that hoop.

Ciao,
Dscho

--8323328-897848339-1626253774=:76--
