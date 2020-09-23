Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FC4C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 18:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FDEC235FD
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 18:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GkU1KTGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgIWStK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 14:49:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:33517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgIWStK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 14:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600886948;
        bh=Mx0975BsHYwnt4HZLjOnk4sOOm3HqRSb6o5nNCY5oxQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GkU1KTGiT5duvAvPtm0OL4LtFjBFjZXBRW/pIHqgtLemHwQN/QhydC42W+HJcNMOS
         Gb9eG0ocdplUtaq4g8tChWikdoKxcpTnV/gVnzsZgSNrXn0MdrGlfwgEwJOeLpxOfN
         zELzeow0BzNvad/flJoNd+cTRFFffaovC4dLdIqw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.22]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmjw-1js6e13hWM-00TH9j; Wed, 23
 Sep 2020 20:49:07 +0200
Date:   Wed, 23 Sep 2020 16:46:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 0/6] Finish converting git bisect to C part 2 subset
 1
In-Reply-To: <20200923072740.20772-1-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009231645380.5061@tvgsbejvaqbjf.bet>
References: <20200923072740.20772-1-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VXN1/5lYr+6Of/eEeTcExz2kzQ1km0a3/aLqlyPHon949cVzP0u
 7rWEnDkx6uQ87uMTqynLQZ+eMkUm6+ChyZcG+0X5OrZdtZn0c+ABSwWgfmF0EMp/3nyF3x2
 elrghZAWFi0B+cn+woUYuQWeLSlP0NmV6nAmMz21An9Wr3cACjE+T9PEuAiA/oluoVgbyh/
 aEGnophQX3qIMq60w5teQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Q2NZPAWwPk=:WwumbSOzcT/8F+kGOP8h01
 VOtW5hYbwc0HjrQcSwWYpLvQoExCZkVxA3btCR9ilCTWH0la4ov4iUF16s2iEaHBigXBLaS81
 w1cU7mOfolRQ7z6sEaWD/8WXWwpFA1r0mK37iLOeBroyulOtb0G8dNy9wiy/TDifgKVQjSfSn
 2gfapOYWqywbjJI4ocM9GKKNOloDaR8VZ6CfEqmRxOpm23bd2YrORMMlCoQZypeKNA3iKsEVP
 0o9tp06RF2RRazPBBpxgueXUvjMbKB/lIem45JfOFjJ8aDVcM3jnHbfMH2KJ3Dj9BH2MVnTXy
 Z6i1NWMMpMoZ61g9mhPsLgn6WMrVsaInaPdxFU4e4HcsZbkN1bU/RL5uHmqJblUoWd+Zv0X2o
 SUNMTSkUYsujzSelv5Yoj2dMDJ/kJ/wX4ZWQWI0xMEGn9BR3njOHY8GPRYEzURwe/NL/m6E+f
 blHUosEfTdoMgKQw80vVzcWrxBjlfYWfYECy59dG4PokJLWXR6TcAnbANqFqp2zM9UZmUQXx4
 t/g1Aha+n8rtySUwmrkvj4a4OsZxsB73eS3/jG8DxdSNKZ9Xs3Ny7m5vCDHYomvWNJd/NNvsK
 iy/qVCbwK+FR1GeGFe/lTsUjrSWvbtWLOPy0O3eHrbkKHXAW2dUb1g7pHT0VFIOk2Trygz6x8
 3UGde73JV1DYG+BiK53f1pEI1734S6XTRON1BNwSiIkSqQv8huo7/C81YRFqlLXd128lTYt1W
 Hkt1w5EqasKfdAsxs+NnAfx5rSTOlvWW5FszxzMZYlrqjPc5r+poHLqsy0UBUCZpW/X49xcZf
 zUDEVr7XQboLYz1nf/sb7hCgDzF95/xsSccl5mJTdhZK/ft+Ms8upBUsrMuQsphwVWN45ky2I
 yLN68AYM1TRvAVsJTr6ziBHEIt8Xw9EzmzXeQZzzLABZzpMOrtPrltan6kpczOIcPUz24Datr
 EeGVvKOwlgzYeQ5NozN8R2OYF9J+VfeENfmoPGtc7+VuROxfOpucNGe5fqcVMY8GYvqyrrMUP
 YBud/IWOkcbroASAb86XpBcnWS4ATcPudK4ZNptFDtRFY/bmVLnVlmou5pZULfZnhxPhSKJ2F
 HW+V2DGZoqmrTqC46qEwkAH507BOrt5yU7yqSwLVSAgrERePWeovEDO8kLW4PtHKfVLh63ZtW
 PdQPXY59sBSv1SGLoeu2JAh+uNVE6aiPNTmLwrqUocPjwLOpHxd38km/26Uug7ZZiGt8WLcN5
 LHIwt+LrqJAFkk5yeiv9MKdHYUJjbwhWFAmvFUA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Wed, 23 Sep 2020, Miriam Rubio wrote:

> General changes
> ---------------
>
> * Rebased on 385c171a01, (Fifteenth batch, 2020-09-18) to update command
> help messages.
>
>
> Specific changes
> ----------------
>
>
> [4/6] bisect--helper: reimplement `bisect_autostart` shell function in C
>
> * Amend commit message.
> * Change to `return -1` when we cannot autostart.
> * Add `|| exit` to bisect-autostart call in shell script.

I think the `bisect_next` function needs the same treatment. Other than
that, this iteration is ready to go from my side.

Thank you,
Dscho
