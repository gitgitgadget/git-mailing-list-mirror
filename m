Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C8EC4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 07:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiLIH5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 02:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiLIH5a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 02:57:30 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26A75288D
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 23:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1670572641; bh=lAeEmymMwBoKawHRoTDAP4mgrMy7i4NQuaVkchEH5Lw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ae6BFZlen1qywWH0aLLwNEUVE/cWV0VUt8cRr/QFRlBQLpkDDa1Rn6YOUZT1Sx2+3
         dKP750YypIG1xAKniAKwDxiaNXWgozwleo4QLkCaldqm1NIQGggDnHCMa/3PlfPYG1
         4zP2RbSt6Xy4FyLej9lQXr4cpaw2UmKcC9ovAJLXGLshah0mokBd8R9CJau571dk12
         8/c/zQ430g4VTXI9hRY0qe2bM7vwWv03iJr+f/9E38Bl7IT9+gVs+xeP3nX6dMsWhS
         sO2276xFR4nil7fVikQ6/nqJIXi8qjliHH0t3tT6zwh9JFpRbrij/0u2l4ze+65+MV
         xFeX3TOP18wOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.24.155.134] ([89.1.215.49]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmUHp-1odG2y2kKX-00iVj1; Fri, 09
 Dec 2022 08:57:21 +0100
Date:   Fri, 9 Dec 2022 08:57:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Andreas Schrell <as@schrell.de>
cc:     git@vger.kernel.org
Subject: Re: Program path added to sparse file specification if leading slash
 is used
In-Reply-To: <db69818f32a2723cb7ef9ddf79d3ae39@schrell.de>
Message-ID: <s53q2s3o-8nsr-0766-rr8p-6n7ro0o07p69@tzk.qr>
References: <db69818f32a2723cb7ef9ddf79d3ae39@schrell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cT5Db5tpkgw7Ffxo61/C7b8WDgmOjlri4QSCQq9aHzfuevzuqLQ
 Z7mDCyMpgUZ17TxUeEq0UZCKfuUzdWBKKKRHDRZHyJ2F6XyyR0NPd9HWptwBiPOF6TytgvV
 Hql2ZCsFUuHVWIHrlq86kFITvIX9Xhg1pnkY/tNpuszAY503Faa+ugZKi9k8A5hSd6Vbq6P
 +VrMe4jbc9cSYtRE6uOnA==
UI-OutboundReport: notjunk:1;M01:P0:oElpyJbFPqQ=;6O7nFfxTJXjPOTeYIV/hshKxhhV
 QHXbQCwQZiV0nN5GW0LVLbaVwl0SACrqEyZaUN8M+SKMKuOMEvickHIMzCPnHhVxady9/5lhL
 JmuqD0xSRj+B0Jf3kcAVcIWk6kszuoqZsy/w+cU21NdNf83HvdgSlOdJ2dp0+hPJyI97JipuU
 z318PUsM6BZXVtUpIGbCLSnhBI3AenQnNUUQJlE1mkrPkXTn4QiNVx63vPPsSJGO9XgULVHXa
 m4O17tNmLN/I+G4lOsYu5ImBJ0KeIIW+/FcqXmMfs8ADRjUtwz3bi8gw4FQcrdT5cyPssbcUR
 OApsDyHemBjBi/3QmNvedY+BZRJsBsmCj8v1UbT9cN80QOyoeprTOVcVCcUqUejtfgO9rOgiy
 D2dG7LMuY+2wujDzR6Z2nWO6qTlAB/0TLP+hv36O7dKE9imE+OMqPP6enTh5IE9A4QUKD5xP5
 IJ70GSWOLg45vSTnoj4vbyYjTuzn6W0r1LobSyHEhCxCCxIjsUmHBdQMzJIrQU6a9Bx6rVcKd
 9iqz2UqeqFu1OVsF2NXL5zB2JKAvP2yArWEJ1nLYSl4m9xxgGB3pmdyp8sVhvDeFUkxQBSw3s
 otVXdcIKMbY4pyHQp/gyssbxc8RppyAzI17Y5AJ47gte3MDL5ypbskCdeYrAB3vw8U6qEgFgz
 qUaeuvlRYPWyRi53gW5lHqQzZxH1sSHL0szBiR6cBJYR0SsVS6ijZb0t21SUFT7EFDfP8rE94
 aLY38ihx+pH99McvzaAhGUShp+ZDM+NyhuuufPWK9PbCTLX5f0tsC/X5zxSk79a3Ny2XqQ66L
 W1GvUD6Y8xlhWy1x9KAMUifbuk33WkQt6ME+5fe472Mua1NP1ZQj3384A54s+Tb/WgHgp22Gb
 dLv0J6tFTNz3SSG1zj+fYxhj/nhrRabQUtfgd8kzZ9v1b2mTNyvMIFuLDHKo+Sdbf+/nmD/4j
 GjhEcQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andreas,

On Mon, 28 Nov 2022, Andreas Schrell wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
>
> $ git sparse-checkout set /Workspace/Build/Pipeline
> $ git sparse-checkout list C:/Program Files/Git/Workspace/Build/Pipeline

=46rom Git for Windows' release notes, in the "Known Issues" section,
https://github.com/git-for-windows/build-extra/blob/main/ReleaseNotes.md#k=
nown-issues:


	If you specify command-line options starting with a slash,
	POSIX-to-Windows path conversion will kick in converting e.g.
	"/usr/bin/bash.exe" to "C:\Program Files\Git\usr\bin\bash.exe". When that
	is not desired -- e.g. "--upload-pack=3D/opt/git/bin/git-upload-pack" or
	"-L/regex/" -- you need to set the environment variable MSYS_NO_PATHCONV
	temporarily, like so:

	    MSYS_NO_PATHCONV=3D1 git blame -L/pathconv/ msys2_path_conv.cc

	    Alternatively, you can double the first slash to avoid
	    POSIX-to-Windows path conversion, e.g. "//usr/bin/bash.exe".

Ciao,
Johannes
