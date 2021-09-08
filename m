Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8FDC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 08:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 289B761104
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 08:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347414AbhIHIJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 04:09:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:51015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235106AbhIHIJr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 04:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631088515;
        bh=J+ctsRBiwEshAAekr6+ZC9KTVpsBNnHFNRbhrRvbANc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iqWZtRCJulMpyFFqpc5QFvRXO0kY1UWWyfuvgdEONlKMr0hbmB2naXWtCy0yVloQR
         M8DOf/eH4Gl1Ckf8aioRr2jcTagmlDze79GOTYzP67tJl0jkHW7YGv423eV59xywK6
         SP81n+M0Fk1f+NSj2WolXOn1fhuV6McKrNqDn9zM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY6Cb-1mRM6g1LHJ-00YRRE; Wed, 08
 Sep 2021 10:08:35 +0200
Date:   Wed, 8 Sep 2021 10:08:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/2] A pair of git am --abort issues
In-Reply-To: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109081007230.55@tvgsbejvaqbjf.bet>
References: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PT1+6yCj3R9ht8ty1CI49BuE0hXvwzrOTAJg0ap0a6sZtvt/EPJ
 8MyCuh3TDkRaYxXShJmKPDmCv2CY4q1aPimMrQl5qeMaBBK0dRrN4Lv40Nt4oeFv4RjuH1Q
 7dLF5VOpNksL60c6C3jmxbduo4PtkRNbNj/TcGRFaYBdPmL/tHV6uREJJ97vCWWoZUJiDrI
 KrOigzxruLdQ1GFZMWs5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IuX9/d7tXis=:Levj2sy0sXtEAn+kNd6v1t
 bbD9nUzmHWmNKYMK6IEOsksUGyz1Mt4bFqjQnW/jJKfjkV/TqYoxA1HI0I8J/AD93rhT9bLnf
 ILVR9Un9WuqP5QB90/XKIwuiRNPeN/vFrhmp8rXsIVlIiPXesG1CbTDnnR3FqQC/3Tgo3EE5Z
 UEtB0zw5jxUkH1o0laq4VlVPNW7Efp4Nm1CHDqKnMpBrYmVNF0kUAd7WaQN7+/ls1+tHfn0Qx
 kZcHtUVIA0Z+doAFFLcd4HhoekRPFH+xE/V13EILn8Ev8L9RgOeo3PwvFhCcSebJ8WeWkE7N5
 cQ/mk21muh7gz6/W9sno/3lm4z6CiCTklkPBow9QnhwAclrVhlvzlUNOmGxkgMK7AKpOGKrTv
 4zN9MGMrouvLKesB4pXR6MuP3+wX2TfVOxQzYG6l+tJtFafCNgQFPMVMlt8Ms/5TIkNFkGl5d
 m39saUO5rNBrnnZjk0mmV/yUSWFmCpz8ZJC1iqOdEWt4NhnrjFMYt0sAu0dTHVx+nYPrB0PDK
 3urlt50HSuKAyF3vpk550XSLyTUlUO8dIscbYrC+3f/A/3sPJOktSP6uDys79KmEuEHeAAr8K
 A5UAltOSXECf1kSOZ04u/KiX78eKYIVRUcdTELrSqXckA7fcyTE9K5HnUKJKsr546jG3+QZcw
 P4oczhepxUKtlAWultnjT+Qd5Pwr1Bn2d2Sn3DWoyx4QVFgUq4YOzsl6ZkWhyrOlTrPdFsLzy
 kdefrQpfRr87jAdcadl6sHDPMk89lcJnLA2QZF23BELXZREZty5SDGKDkRZ6ozGDQUV4z0FM1
 RPEiSIb9JZ3OtY9z3wn1gAYmljJBtwF3hX0sXI1k6rpgeUBIP6oDJoKLpmrPdG8R/ad5b0M2f
 eElhan4ut9z2mzSkdLEuDAy5NC9Lf/WY9rMKfsJEAAoY4eygvlEcZBmJrVa4wE0tbKvKc1+1C
 Jehig+zv0meKalFQ8mWcAu4Y4Wm7t9GBi6gd5LDFsKaxoEqZxVHi86GygrSRVuLCddpR20WVY
 c1xR6tC8C7otu+BMBEHCQ2J7R22AhbbJGCPwQRgpvLFqgvPwOfn4XesLJ9EIiLlOqh2KfEsIB
 S2iEXlmEMDAM1o=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 8 Sep 2021, Elijah Newren via GitGitGadget wrote:

> This series documents a few issues with git am --abort in the form of ne=
w
> testcases, and fixes one of them. However, while I was surprised the abo=
rt
> left the working directory dirty, I couldn't find any documentation to
> confirm it should or shouldn't be, and reading the code led me to questi=
on
> if perhaps it was intentional. Anyway, if it's intended, let me know and
> I'll drop that testcase.

As far as I understand, `git am --abort` should indeed clean up. The
behavior you described is what I would expect more of `git am --quit`.

The patches look good to me.

Thanks!
Dscho

>
> For frame of reference, these were some issues I found while working on
> unintentional removal of untracked files/directories and the current wor=
king
> directory, and I'm just submitting them separately.
>
> Elijah Newren (2):
>   t4151: document a pair of am --abort bugs
>   am: fix incorrect exit status on am fail to abort
>
>  builtin/am.c        |  3 ++-
>  t/t4151-am-abort.sh | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
>
>
> base-commit: e0a2f5cbc585657e757385ad918f167f519cfb96
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-10=
87%2Fnewren%2Fam-issues-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1087/=
newren/am-issues-v1
> Pull-Request: https://github.com/git/git/pull/1087
> --
> gitgitgadget
>
