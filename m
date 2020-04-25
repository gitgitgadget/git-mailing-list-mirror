Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC6EC54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 13:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF2C20724
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 13:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KruF43e1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDYNee (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 09:34:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:52217 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgDYNed (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 09:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587821670;
        bh=sPrmqerY6YYWMfkcHbaZNU0Lf5hnj7Vr3QPPBxnYxOI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KruF43e1JeJR7pFg/QYh7mdUWUoyWdIJ6UqZQkyFNNLH52cpTZCqTPTH0R3vHn7md
         l6m1iffS5wbSS2P+GAUQWgOYQyVQjIxGf4geQrp638qykU7489JUTdVAIzLWB60LWM
         MCzjNmNWjWyskV0lxp4DY1I80ovbTwIJhpuaYPHI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.117]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MWASe-1jiIQu25hC-00XZnh; Sat, 25 Apr 2020 15:34:30 +0200
Date:   Sat, 25 Apr 2020 15:34:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Danh Doan <congdanhqx@gmail.com>
cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH 1/8] Introduce CMake support for configuring Git on
 Linux
In-Reply-To: <20200424170540.GH1949@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2004251530210.18039@tvgsbejvaqbjf.bet>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com> <70ab1f03dd5413256166bf9db47be47b746ea6b1.1587700897.git.gitgitgadget@gmail.com> <20200424170540.GH1949@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:15x8UweZKrvnM7OofbUYqof2P6aGyeBOPD51xLGX3ZywXI7la1p
 WtBkPHfUX2J3LsfnfahJV4A/2CBLoC2sjxfEPNYS0ceh1t0S3zAXVeOhENabPFzTY5RguvW
 826NCb0psn0o7qEY8V3sfxKWLz0csI0aNufo2TJjVFVAAbAuWRlUU8skaVPnF5C3XI7QhS5
 mJC56k3uj8g1KfzHPkqGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nBo/W52d21c=:MEjTPrTISGuGBhRHDT0l7j
 CdTxzODminp7jeNWIo2qL+r1fMc0OoIunpccmOt0xCMVtxoRggl3q3qvG6zJ6nUBAjidIfjcn
 esENEFJjyyR9L+pQEp4+OZ6Ew+HRf8OX8Ped3U77E2cyCeQQ/OrhRBSKP5mlqQZbytuEq7LEz
 xM2BJlhO8P8YoY614dhobWFp9zUyDKiFW5tBuEYzcZJESUUQfF30K8ENRC27D4h23uBo2jaqN
 HpzKPlN5SFGYXHauBgWwe9cPMBwEIepUbIsZcNl+Cqgh5X3BOWROsjdcpz4kGHudU/k4gm9CJ
 6vM1hnlGWbEGZ3KmkF8ilM8xh8nFgmtymDafhjrRFJP4K7aiXZf/UVrYmVkX6X+iyVbu9ws8y
 VczeSZk2rFrNKL3sak8vTeTRktF1arhHDXlVGndkRN8gfks6P06oXEa1QrTdsz1KdI2Jcu+s3
 Bp7Rz4i/anVCp2713VzdS0I0dRl42/3SihNJNcUGcDW/GB/K0ZJj/iCJeeoTbh1yL6uTBbkzl
 SB7DTcO0HKlnrrucufei+49N0EJjhJ4+lEHq9T/Ac3Dn1d3FGCDxI7dmY6SU7PrUxmVwVtd/P
 XqjVbwHfhteMRSzfwTW1A8lWUNnYAMljIoBxrntB+7cE7T1C57/6+/kjzg4dX0tGFqeWLnag2
 RvJozwrBEpHXsAg2h2fDIDXkJlnhtn+oDO6+jOnmj+b+DsNG0bqvR9q+iS4/qRc+2eOnOwcV4
 3kHMHOVJpGcfb+BnfzSdUhbK6oXiFofk1V3Kmmmw2KGU/JtN9llMAB2IBJV69FsSKZNg2Z+bU
 p79JVb/Qmhu+rXtZXZUcKVasyTzWhAOZWXIsMfz8z8GW+j+siTZlhHJdcNZlOwYnNdOiYfzac
 lOBWSs+M30hzyAIQYfdcBIlRfcQm66IVVRYuxeOswQMfDkDjYHhDGl+HIhGjmkWNHLAC9y0la
 w7Y3TfnGMOniQ37fbX0VQLJJ7+1nWgv26aRF0JYqasGlzAZwqXLQVkxVm4Cw5mJNHNeDTtvyV
 2fCsoIag0b8LsR+I9QMgR8qYbuDcGiQ+FBO6J67CfMteMSodRbcHNQ1d6Db72wOgkubhpTSWZ
 jVSg9skncPyjAhNo4AeeGEduXhfftdjYkTJwRQvXfnzoUQuo20bNeir1wGG8VRMH7iy5GazUj
 GxZO0TNebWRI7aHHVbl8UuB80+6Qol9qWhnJPMaLlVQHebpZLHdcMRl4RpZGwbgHGn+f0Yrwi
 P4MtAPvsX+WVyS+IS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh,

On Sat, 25 Apr 2020, Danh Doan wrote:

> Please excuse my hatred for CMake.

I share that distaste. However, is it really productive to bring that up
here?

You know what I also hate? I also hate vulnerabilities, and find it
_really_ taxing and tiring to work on them. Yet I frequently find myself
focusing on security bug fixes. Why? Because it's important.

In this instance, while there's no love lost on CMake from my side, I do
see tremendous benefits in having support for it in Git, in particular in
supporting Windows-based developers instead of treating them like
third-class citizens.

You had so many good and helpful comments and suggestions how to improve
the CMake patches, maybe we can have more of those?

Thank you,
Dscho
