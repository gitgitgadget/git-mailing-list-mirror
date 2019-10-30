Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A15181F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 21:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfJ3V7B (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 17:59:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:51855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbfJ3V7A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 17:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572472735;
        bh=DMFtNAKvF5vEhXOXLpk5B05SC+Z3QmI0LThZBCsYHqY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=h2t6/66rkwL8y7YxCAifV7pPjveGrFcLJKL7sjkiVOFhbqC38VuTAdBMeiVbVHhpg
         XIYxxhBPuTYIhxHnY5hOgXRUeC+W0se5pb3ZTDZD02PD8tLCLGFOIJaq5Er8G/nxf0
         OpAJVLwF+yPO+F5tDgnpcyZ4w95FRGNRNP+ts/c8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbEp-1iGtJd41Y3-009dQI; Wed, 30
 Oct 2019 22:58:55 +0100
Date:   Wed, 30 Oct 2019 22:58:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     george espinoza via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, George Espinoza <gespinoz2019@gmail.com>
Subject: Re: [PATCH 1/1] [Outreachy] merge-ours: include parse-options
In-Reply-To: <xmqqk18n3s3i.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910302257480.46@tvgsbejvaqbjf.bet>
References: <pull.425.git.1572306149.gitgitgadget@gmail.com>        <8c088194f604eac3a6b00c48a7fddfdf807571fc.1572306149.git.gitgitgadget@gmail.com> <xmqqk18n3s3i.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0FNwER2DZWfTx9Y3mU10fuHT6/tCnrC62XZthOKghIsUnQ59yLf
 u7wNiBEGA+VJagaxODlVwjbr55aOSky/gsOg8B/FUcm4zZzSAdrAjq63CdHgEGDI9iqABJp
 Vs+QeBc3QyM9LJZKUbSOyT4ZQeTMCPuDfdCBL2wkaHVFKV9WPk71K+sbw6TWvCZsJXS2xi3
 9Xb63EUmG8Kcz6/dgdfHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ABS9UCmg5Sc=:WgiIyXs8QTWAtY8w8KYGBG
 gAzC0ffVqmOxw40iz+cMO7gvwsF8LiwTTbz2rG4WCFSEMHIEhfqgI3sHZLfeLs18HhNwLKQcF
 uRhSQ6HHzDou6QDnxRzemHUVbDVkgr90KLV3KWrN+ouuI1SWE3nFyJZOIn/Iy8xgd57VnsfvV
 sO4URdss0QJD7zh/NksHU97ZcpAsens+hzFzfZWfcrVwxTRnbZEIv8Mk9WOncYJQz4Qy2LD+1
 ee5AjmfuYtBUswo8W3nhzeSSih3ga6BNOu4DUTwnhAmNjvq4t6CVLMdyiS60b5uEq9ZYm7sv1
 13wpUGrikRRxY0nD8Fe5QrqtxZejwYPBX7mRYUOGUWDAnlZKNS+Twzv0uyATne7rD3GZzz08s
 aiUgwE7W1tbtN7kUoIN04CC5X5VBS+8NlRjuIcs1E858Nqf5uvFSRswAlj4zd8hCvOXEqt105
 bW3zRlE3J2HPsp/j9ECr6m4zIDYAB3GuOA6VsiI/xbYiJDtJiuKch6UBC++nWC5Ws9+yHCJiP
 mllxzHwPYH+ZB7o4b3jU0roTWczPHyOpxFiWeLmJFdMxRMTCLWQnV1smdPryH8jedy40S2lS8
 vtdFCXWVoG7I5GLGUJq84EyuqtDHyRHcTjDuKQadE6+58nDjHP58WJyrgvMwk4O7a9Ubg/q6D
 W7ILPpr4ETKNqCHkVWZ4syLep/oGIf2Kd2iyhJ2SxPU5FrL4Q+FUPxajT3h/LTDrG9mNMyDOj
 5dMSNF8Id3zEVI263nrNdx3mGAmDMYphVPblGGEXdDK1VuOHFdb06DWG+QTYdjcei1XWi+qmj
 Y2/+8cLe9UPXArjWaxQkjdp4BrAf8xr5pDSL0EugL46Rv2PjItsi1JNqfiUysk/ARpWHid26X
 gr64zpJVncdMoL0ljtMmiE12u23hg6oE3QWAjwmyFgc+mzrLws/K7UGKwgbTv1dWhB50LiRPZ
 cPxbI2864E5Pcu6rhySG6n5B/M4FSu5NfgTKSpyTP69I+oC9uhRn/2uUh2vLHF13ll9mOOu0D
 m/6LQRjCpLwqNJel2C0hsj9Ohs6NgKMiKRqc3Kxm885QHCe2gA39GgfcKfkM95s5THarqHWtc
 ETMGSh1X64QmLbSRl1RElb9hagPecZ/KFoeE745sjly4CXowb6TWPoNKzAMp1VIzJ/VTUKPUw
 b1Mnwydm/JdWuhOB9TO0+MlVjb2wU//MYyL3EwAH+bIwb1vLkXCG6M9WBiJx0gx8WszqjXNc+
 pmdcxVPMAgYb5mDsXWVIFn/47iXBwaNlvPGDP9L4PSTW+znCP+SZRHy4r/Yo=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 30 Oct 2019, Junio C Hamano wrote:

> "george espinoza via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: george espinoza <gespinoz2019@gmail.com>
> >
> > Teach this command which currently handles its own argv to use
> > parse-options instead because parse-options helps make sure we handle
> > user input like -h in a standardized way across the project.
>
> Sorry, but why do we even want to do this?

It _is_ a command you can run via `git merge-ours` by mistake. Don't you
think it would be nice for users to at least get a synopsis?

Ciao,
Dscho
