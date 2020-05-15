Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C515C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 14:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6867120759
	for <git@archiver.kernel.org>; Fri, 15 May 2020 14:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cdU7bHNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgEOOBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 10:01:22 -0400
Received: from mout.gmx.net ([212.227.17.20]:51467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgEOOBW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 10:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589551278;
        bh=ZhymblsjrgNqbBrOfPkeAyakbMyg0xvazIKdKx2S2HE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cdU7bHNNp+tChc7ZlAfK0s4f2IVY8oHFW0cwd5qwsBhNW8/CpzgjdoMT4cdXRrK26
         xpZ9lRLSPoUU0xtu3QEi8zknJ2x7HdVOkPtl5IKfY3tlzN7TqpzZtS8mjMZLm43mwo
         7Fz3XqSFYRpaSrkiuv1i6KQc8JY1Mew0AFR3IOQA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.131.160] ([89.1.214.237]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvcG-1je2tK1Lbk-00Uq4K; Fri, 15
 May 2020 16:01:18 +0200
Date:   Fri, 15 May 2020 16:01:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: avoid pounding on the poor ci-artifacts container
In-Reply-To: <20200513124406.GB1982@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2005151600010.55@tvgsbejvaqbjf.bet>
References: <pull.632.git.1589316430595.gitgitgadget@gmail.com> <20200513124406.GB1982@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-679115121-1589551277=:55"
X-Provags-ID: V03:K1:Sz+2ZWCK1s4uUuX72cHHfiTj1jTXFwAbE65nyJvir0a03Ed3LP6
 3vsI1shK1eUbkQ4hlmgw/YGWp0JwWN4eN0261lTgRNNgwgujzFgWzfS8nCWi0mDRyF6ZUUE
 ruFxhu0o+WxEtmUgLavzFJ2Z5ul9lrwWIBYzX+YlFVxLVazpJkdjI/wTJE0zMchlY2HCGNu
 FHBVZo+aQV4cAmvO0+tEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YZ6bFteDMRI=:j5zOssrEDT02t7Db7NvNOW
 aJTHIjYdbBSiVR9/kR0D0xMPTY4zXsw9U67Hw98AdfLk3AmW8OpE5sl8JZGvZycj0Z9OdMPim
 QqCChbMNxMqTXA2NZZxExadtDsFPbzaz9ARmOg+/jd8P0d53D0OmMzt+8RF+t46qvjnZ+6IGy
 ZEu6O1aXYMAw0jDPs2fIW5sIKiCLFsTnmAeZqXu6cZK9ZAk1VYndrl6nXDWZa0sdgePGs0gGt
 n82YhqGJUPHp05zV6Kyr/oIiZXyhSroeMZ8p5+abV92puSwC82ApeIPUapHHsQwQ85CIizZ0D
 JNWFrURSm9k6E2ybUgAtYHQK48sE2t77rBt15H18lGN6dIvSzo2obAD3v2vvMB8F/UGdQER3I
 5AxMztORo7lQ/D+S8e0jhgvdwr8TeeZwCJNZASAIx/5sQUC4Nodc6ec0KRldwX7CmZYmDfJY5
 TRgqmudKn5kevxl+LeunzS/X06HjPJo/NY1szkej6tdPAvLcB7vWGCGtXTl3Z/BGrxjaRHmot
 nJyWCVx+QGhdx4RXW2GFA+zOrvJUGAwdSIgU5bD0mLpSAdC66Quzh7PoUdS9n75gZLcmgveVP
 7pmsdQV3jvkKyQW7ZMvKowyto6ZJGDLgUkCQkA+AyYZH/2V/4WYp6l5BzJp3vc5Z+W0IPrFGJ
 clM+6WyP5yJUHyJWYnkvrK4h9DulQzB9m/q9nZZeuUGS1OVdMhQW5uX90DNE9Ipd+v+gEX2KA
 CRHqD5lyF/EgRyt7yPTaLFpOlBypOQ9LrqA48wNJoBoVjmvoDJTR1dUH7svBYEPuTVojBG1I8
 j/sAZzSveMFEmeIR0RthiPMkaN6EYkT0E7C6Ojl7/R7XIhFaHIGMwscKzhGN4yCzGvJa3QL0l
 tNf6Fj7mq/fIT2nb+qDxeoTs4u3vBrSpFhVW2Spo5MedKTDBkPaZ16QJByFu4fcrqGeJlslgW
 ugOVwnv7rcdMh8uo+m7C5J7Vbg5v3o4rjNk5Xf2AbyfpgUGxqjdCaiNOvjPGgNzJlfJb8HAwk
 McYlXSVpXNfzyKZdoTXZx4G76i6mQQuA/RsNjtFLK0DpWV0UCkiwPy1c9TmMkiEBo5JTMxua0
 /Tii2+6ruHSYsPk2xMr6BzfI/kUGrU8KLlMuyt1Pe8RcIPzksWxhGwp68woLv7mFz0xTnqxMZ
 SRJ9LBMFOrd/hZdiM9SIPHBMlKiWrABTbpQiJthrXBIJEE8RLobLIfdjE6K7rgOjyDIuwRsUO
 C85TYZN0TcUXGvzE1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-679115121-1589551277=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Danh,

On Wed, 13 May 2020, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2020-05-12 20:47:10+0000, Johannes Schindelin via GitGitGadget <gitgi=
tgadget@gmail.com> wrote:
> > -      run: a=3Dgit-sdk-64-minimal && mkdir -p $a && curl -# https://w=
ingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
> > +      run: |
> > +        ## Add `json_pp` to the search path
> > +        PATH=3D$PATH:/usr/bin/core_perl
> > +
> > +        ## Get artifact
> > +        urlbase=3Dhttps://dev.azure.com/git-for-windows/git/_apis/bui=
ld/builds
> > +        id=3D$(curl "$urlbase?definitions=3D22&statusFilter=3Dcomplet=
ed&resultFilter=3Dsucceeded&\$top=3D1" |
> > +          json_pp |
> > +          sed -n 's/^         "id" : \([1-9][0-9]*\).*/\1/p')
> > +        download_url=3D"$(curl "$urlbase/$id/artifacts" |
> > +          json_pp |
> > +          sed -n '/^      {/{:1;N;/\n      }/b2;b1;:2;/"name" : "git-=
sdk-64-minimal"/{s/.*"downloadUrl" : "\([^\"]*\).*/\1/p}}')"
>
> Hi Dscho,
>
> I wonder if it's acceptable to introduce jq (already installed in
> GitHub Actions and Travis) into our codebase (only in GitHub Actions).
>
> If yes, I think this will be easier to follow than depending on static
> number of space and sed branching.
> ---------------------8<-----------------
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index e2e1611aa2..482df46651 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -13,17 +13,12 @@ jobs:
>      - name: download git-sdk-64-minimal
>        shell: bash
>        run: |
> -        ## Add `json_pp` to the search path
> -        PATH=3D$PATH:/usr/bin/core_perl
> -
>          ## Get artifact
>          urlbase=3Dhttps://dev.azure.com/git-for-windows/git/_apis/build=
/builds
>          id=3D$(curl "$urlbase?definitions=3D22&statusFilter=3Dcompleted=
&resultFilter=3Dsucceeded&\$top=3D1" |
> -          json_pp |
> -          sed -n 's/^         "id" : \([1-9][0-9]*\).*/\1/p')
> +          jq -r ".value[] | .id")
>          download_url=3D"$(curl "$urlbase/$id/artifacts" |
> -          json_pp |
> -          sed -n '/^      {/{:1;N;/\n      }/b2;b1;:2;/"name" : "git-sd=
k-64-minimal"/{s/.*"downloadUrl" : "\([^\"]*\).*/\1/p}}')"
> +          jq -r '.value[] | select(.name =3D=3D "git-sdk-64-minimal").r=
esource.downloadUrl')"
>          curl --connect-timeout 10 --retry 5 --retry-delay 0 --retry-max=
-time 240 \
>            -o artifacts.zip "$download_url"
>
> @@ -104,17 +99,12 @@ jobs:
>      - name: download git-sdk-64-minimal
>        shell: bash
>        run: |
> -        ## Add `json_pp` to the search path
> -        PATH=3D$PATH:/usr/bin/core_perl
> -
>          ## Get artifact
>          urlbase=3Dhttps://dev.azure.com/git-for-windows/git/_apis/build=
/builds
>          id=3D$(curl "$urlbase?definitions=3D22&statusFilter=3Dcompleted=
&resultFilter=3Dsucceeded&\$top=3D1" |
> -          json_pp |
> -          sed -n 's/^         "id" : \([1-9][0-9]*\).*/\1/p')
> +          jq -r ".value[] | .id")
>          download_url=3D"$(curl "$urlbase/$id/artifacts" |
> -          json_pp |
> -          sed -n '/^      {/{:1;N;/\n      }/b2;b1;:2;/"name" : "git-sd=
k-64-minimal"/{s/.*"downloadUrl" : "\([^\"]*\).*/\1/p}}')"
> +          jq -r '.value[] | select(.name =3D=3D "git-sdk-64-minimal").r=
esource.downloadUrl')"
>          curl --connect-timeout 10 --retry 5 --retry-delay 0 --retry-max=
-time 240 \
>            -o artifacts.zip "$download_url"
>
> ----------->8------------

Thank you for that. Indeed, I should have checked whether `jq` is
available on the Windows build agents (and then I should have learned how
to hold that tool right).

I sent out a v2 with this change, and I already merged that version into
Git for Windows' `master` branch in preparation for v2.27.0-rc0.

Thanks,
Dscho

--8323328-679115121-1589551277=:55--
