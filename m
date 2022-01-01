Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C166BC433FE
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 23:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiAAXRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 18:17:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:56459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231582AbiAAXRo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 18:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641079062;
        bh=yAivFu6UYZHDzPK6nc+WEB8SrB5ly1IeRalrV9Hi67k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HYYRw6JVrCl8cvO5VWFKRN+BGi8xz0MqqmruqFEWVJXcEqoPxepcyKstrnN0czEy5
         r09z7qE1oiHs8gCNqpD17hIB1eAoXNDLuuJZg16iKPslofYN517PZuc8I1CAFJozG3
         hJANSVJ58cjhnH4mM233NHTDyvCMJJW9ZMmG0I68=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.212.167]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsjH-1mpicl0x1Z-00LHQO; Sun, 02
 Jan 2022 00:17:42 +0100
Date:   Sun, 2 Jan 2022 00:17:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] t4126: this test does not pass SANITIZE_LEAK; quit
 claiming it does
In-Reply-To: <pull.1177.git.git.1640927702745.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201020012010.7076@tvgsbejvaqbjf.bet>
References: <pull.1177.git.git.1640927702745.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eCt96r8KKfKJPIG/583YH5HUhj93GMTnDLRGEo7CnFU88rTS3QB
 c5/uFhgqhqUM9AF/33zmrXbf7W2jvqwRRu4hRNeZBm+/zXIlXUfIEDjUnZvi9P6/ey1ymPG
 HblMZvVWGsaEvUCRJJYrwCmgubBudUa+WpzZCnOMouKPGpoNEpr5O7eEd2dnpFcqk76HbBY
 HELsoDtwebsNwk4KtcIlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Un54623InVk=:SIYZkMF52y8nVgaMBXDlyx
 sYuYSiC1oOvDj0C/qjFmRMBYYIWWFsGJiYdAjfq/e8Ie7wGDHyM3PNGcAbuPKQN/rNy28ylpf
 VB1ixTjy7OMan8swMCOjGPGHBJxvM2Nbqq17P3tajxR26VwRcZ1w7MX+BWG8BtpG82Y+ARUBk
 N8p3BLrLyMftOB9RtkcGo7ApmY/CtdKtlxuNM92oLLm/tmnS43N4iTgQIkn7QZnqWn5mRz3gs
 eagNK1pEa8xdIClFUGfayrMpnReNtiMza4jKt1pbeJ0NG9S7n73FUfSIImFp67xItiCsVfbtn
 UfHD646x1oSqWUt0QoFA2DWoAOvyGa5IsyVQ/j+Qzp+RVCHCjBxZelOXPAD06FB6SWixvFy4N
 FTzLOOYglSVcQ90ZDRH3AtVxxYKODClTJVE/4oLhvbjz56hmiwKceRkSgZcjcOhnxYS7dASdb
 46N/g7VNkOB+BiAqbBPWMzhj++OXFFk159BoBxpUEaO+4Q/O9d7ONqnIV2qj0vLBC0h17xmDu
 Yvfj8/Y3EXhD8FsSDp5aCL/gXn9pmDvNziphrrCvWUZfRV/IGx9a9DNrnUSizeQZhSqKueOUo
 JAu0oEigavjIpEhstndCh/Zkv4vZgsOmf1yrL/sAdwVCyzgMo/iRBlEWUewPkA1FN6NBtMj9h
 prglzGIHlIKFlyH2SbwoMvF5eSwM2fM9lUyn/eKxSSLJH3DCTB2XaHIqfePmcTpdS7fpCrj8f
 /PMMkcOGo4HXLgG+eOwcMk4BdjARGFxl3EUzHWmexZp3Yuwteu9XO5yqyxAs00YX1K8BpGQa/
 4I+7YiLl5YTsJabkharRoBiGY2e0srJSYjjy9Sho3CcBKhR3Nf0ZZHLkgdX4vyqjF7jJWeB8I
 wnjUWLzB0IYDB13rNg+zFIm5uuZZey5xXumbQ4Db1EcR8Qy6g3hQ8xEIkN3T094x2BNDqqvU5
 7LlDJ/357tqkPxZHaXHFlajybP8LNtFBbBXPkXgybVZcwEkrhdCqW4cDDDvDCKXlVTw1UlQU7
 ZgSC5Q4E2PecqWr0KhMPuqRFhyXu2htwOrBKa/dh/wca7ZXbobLHIBP96+dqBmfuw4NNDSUUk
 luUx+05EGmg64U=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 31 Dec 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     t4126: this test does not pass SANITIZE_LEAK; quit claiming it does
>
>     My builds in several different topics keep running into this, and I'=
m
>     sure it's a false positive -- I didn't change anything affecting thi=
s
>     test. I've just been ignoring it and submitting anyway, and I suspec=
t
>     others are too.

So that's what is causing this. Thank you for chasing it down, it has been
on my TO-DO list e.g. due to
https://github.com/git-for-windows/git/runs/4622790431?check_suite_focus=
=3Dtrue#step:5:146

Given that it points to a leak in `cmd_format_patch()` (oh no, we're
_LEAKING_ some _MEMORY_ in a built-in, how did that ever happen, we must
free it before... *checks notes* ... wait, we're quitting immediately
after this function anyway? </sarcasm>) I wonder whether the disruption
caused by `linux-leaks` should really be considered worth the benefit.

Anyway. Thank you for the patch!

Ciao,
Dscho
