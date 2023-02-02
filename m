Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60A0C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 13:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjBBN7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 08:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjBBN7o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 08:59:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156C243447
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 05:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675346381; bh=MjLd3dSA31gYutsetjnM77n5rQ+ijgOBjUG+ngvYoqM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Hdpnm6ynshzm57i5Y3+F658ex68TDm+h0JD9ykDDoVAe8nCJzdPVaekkOuqQ76bUd
         Jf8ugvJ6A6FMt6afMtq+O5RwpXg3e/fNLlRhbw6sKeMJP3v8v44RSm9eUDPPkFf3uL
         OhdMMKkWMvBRsdanuOnvPYX4ZzoYFA9sr41BUGLw4Pbz0Pvy99PHIvYZWh3y6DoX3U
         JbPHdW//jDTS/mThUFDi3woqJW4iW2O0TgzuwJTpGONJHSpuFkzzJX45ShSGSUSEoy
         nv5Iyv3SOU79lJV2wCmAJgLSE/wyucZNicL3R7FNqmKjRfVKCyY2Sr78/d//+B10xL
         IHZQrEwzPBcsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.128.75] ([89.1.215.7]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQjH-1pQfbN3aur-00Gs0T; Thu, 02
 Feb 2023 14:59:40 +0100
Date:   Thu, 2 Feb 2023 14:59:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Harshil Jani via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Harshil Jani <harshiljani2002@gmail.com>
Subject: Re: [PATCH v2 0/2] Remove MSys Support
In-Reply-To: <pull.1433.v2.git.1675309898.gitgitgadget@gmail.com>
Message-ID: <a4ce7778-c108-99ff-f97e-2ebb8cb605aa@gmx.de>
References: <pull.1433.git.1670274213.gitgitgadget@gmail.com> <pull.1433.v2.git.1675309898.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7OiYCSO5XeVo7rsXzh7SrN9O0vUrkdDZGgVoMzAVU5eMU++oIQt
 SaYudzuSCKJkNV0xO21Sw86VmsEZ67multgTvXyE6ptehkTaTclTqs9Kj2nGbaV7vmPA4oB
 gDw++gthJz8spsAcEJmZJMhkAybTIxRBoa1S9UiBGKBq11n6PVJIzBb4zBVOTHTUDG0KHFt
 /h/UJSdg3wCcDCyklz27g==
UI-OutboundReport: notjunk:1;M01:P0:8hutY3z+iTQ=;QSWPV7jhlKKO3Sqqt+RTWEsRf0X
 QJhuBemu4ap2MNjGNXp4e+C8jC3edwgywR1OLF9+DpFdrWnv67GluA0zAufV9BckbJMrMbn5F
 pOa7rVUMgpHrSOYW970//HUnwWKhZIGFh2SF/04BxpY33DwfFMl27L1aIMhIXRoQah/NkROg3
 WZqpO85VWYQ3523/0sB3AOj5VSffq2cP/pr4Lv+d8E5NI382DcPHgBHA/OddK9asUu8kaasPi
 xk+2fxUGo9c+hpzA0XdX01Mt3MO6PvuTf3CIPQ65FrLtwWX2YL6HnVsJyytaDByCY2WgEAuRf
 NNGlQ9l4nykdoxVNrD/pEjywREfFkGos1yNd7H38evYhNkCGlSdS50clqSu1LDU04InZt8+rB
 da/by1zyYQf4xcag7wQCw/Yk+/yEWv0HSf6zVnncTYqY/olLY35L/2Y8yyaWHUptnETCvDjdG
 5frcM35MKfzYsF21bfgMR/WFlmKMM5mgWd02uimrBhXH1wDdZfVIN+XuVWOyReiRGPp2AJlYz
 z0GZvI8/gLeGszqwdMtKVuQ3ADMb1M7yncsaOrOl8nKjhcBeXTqBrFn/NLTRxzKCC7C5HCnsU
 //LgRJuw+FR4x8K8nDmYYyFyJMlpGpSBHOOtqpWTKjhX1s6Em2hWI5CsPgo5fMre3I8wqWFgW
 T4IxfzxJ9El40+dW8+pUvlRVRSdin9zrMH1LxvluKhythl8Vv2ARvOM5ZZ3TH2LhW1WztWLyn
 Sg030zEQFpJBeaL27dPrj2aolysqiJ5g5qq0Gy+J552l51ULh6r0qc8ljIcTD5q/P28JysaXp
 kQ++S11sQO2siDaXO4h5/w9w2YOID115cgV451iVya4L0wDCK7irlxOx2DoXkWrbu9QDHgB/y
 CSBvuRXOoEPMdksHRoe7hGx7eRqCeaU5D1L/fDeQQ+CMOfQqqHMSd+G7sr6rHzoiugnnsmkVU
 Z8/R5tR9D1Vacr/kk2XAhhkMxYU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Harshil,

On Thu, 2 Feb 2023, Harshil Jani via GitGitGadget wrote:

> Range-diff vs v1:
>
>  1:  bc79dfcc4d4 =3D 1:  bc79dfcc4d4 mingw: remove duplicate `USE_NED_AL=
LOCATOR` directive
>  2:  e6d3d280a4f ! 2:  0c0289343fb mingw: remove msysGit/MSYS1 support
>      @@ Metadata
>        ## Commit message ##
>           mingw: remove msysGit/MSYS1 support
>
>      -    The msysGit (i.e. Git for Windows 1.x' SDK) is no longer used =
and the
>      -    last known user for MSys1 + MinGW has switched to MSys2. So th=
ere was no
>      -    reason to keep the msysGit/MSys1 config section. This Patch in=
tends to
>      -    remove the support of both the builds and throw an error on
>      -    execution.
>      -
>      -    The output of `uname -r` if returns us with '1.' then it relat=
es with MSys1
>      -    build environment and msysGit which we don't want to continue =
ahead and thus
>      -    an error can be expected.
>      -
>      -    The MSYS2 is currently used into the MinGW so we can get that =
part
>      -    running directly without any conditionals required.
>      +    MSys has long fallen behind MSYS2 in features like Unicode or
>      +    x86_64 support or even security bug fixes, and is therefore no
>      +    longer used by anyone in the Git developer community. The Git =
for
>      +    Windows project itself started switching from MSys to MSYS2 ea=
rly
>      +    in 2015, i.e. about eight years ago. Let's drop supporting MSy=
s as
>      +    a development platform.
>
>           Signed-off-by: Harshil-Jani <harshiljani2002@gmail.com>

This seems to address Junio's concern.

I'm fine with these patches, too. Here's my ACK.

Ciao,
Johannes
