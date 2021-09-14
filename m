Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D6FC433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 15:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D501160FD7
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 15:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhINPLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:11:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:39717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233366AbhINPLp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 11:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631632218;
        bh=YpWhl7jSz+c8w8ssEnEC90jT0xtUgyDiLk/V13a6Ssc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=C217yoQiSOYzGzBqe5R3JVPt7u80Wm3+1RLvG8VJhorxlDOLU5mC/sFB/F/FTYipE
         dsmjKJzxTyMDwP0sHvMA77yDxNICjgiUxefTQAeN3FO22c7TgXVJXRSIpkcZadm05S
         fDCEZ4Zt2feG2gHpAEDn4RJ47z/5aLPJg03q+URA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.31.53.103] ([89.1.214.165]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mxm3Q-1mpuxI0lCw-00zCAh; Tue, 14
 Sep 2021 17:10:18 +0200
Date:   Tue, 14 Sep 2021 17:10:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v4 00/15] Upstreaming the Scalar command
In-Reply-To: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109141709330.59@tvgsbejvaqbjf.bet>
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com> <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rH4bFLn1fYKpmSJ9It3sGIt4i58h3WAuRu+hUmwKpJ2/qAXc3fq
 nBUj5W2c/h4BXV0YFlpLJqCSbLFhzyPEfC/gsT07aCq5zIntx9g66/qV8uFG8NFVSmi3C9f
 lxQ5ML/e0RvrdTa/1jM1zCa44SjC6JE+zvecQAu/7yImDobxNhLR7UsBfaWZ6CR0kVU5ajA
 9O5idj7YZPN4XZXFzzRqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iPVItzDKSr8=:9GdfytnFD6DFAq5zbtTK62
 9qVSiUjs3AtE89cYlobG3brxQCo26x+bn4B3uKkZqb6O7m91WDnp5/u8KNTNjJFq3nvs2Gg4T
 0PN/ggEFwr9WX0wUTFzbhdT/0hDi/4TSaIEVwHZshvKZnKZdrJDB3hBYg+mq7xGTvB5mCQeu4
 l1RLqbL0XQ4yBhZdQBrDsHAVssbgr7B9QZtdkGh9keLsih3k2G5wo3q/60mALPJdtTvUp4YvM
 lGn+ZxUvBVxDoAFSR72akNtCMruuMER2IJt9tEGrOuUuCGVpXR7y/3DUUtbVfJ/ylRxeYKo9k
 Bg5c1GCFzTaImT9KN75xqsvsSSOOVftgInfBCDXMsdT4WBvX5oxzKrXYYIWONyRB4ByjRqxKX
 zxxjXE3PncMpSZXSgw+t7p78XXCIqMi79ESvkqQTodHAGzqf7HMITNzeFpPzhEFqb64CKWjeS
 sl09LtdugBA04N68y6PzhrPsRRZYapJSerOgH98xd7+l2PQiL03HulBxEGZ3RzZtyh/1mNsTG
 /x27VgGAbqVkjoeicmYD3hw7f3l/BW+3ZB6+rSPJMDM8yih1OtqhBTyaNOeR4x5QLtLTIu4si
 CKhr4cPdOnu9FHYTJYDQfrytnmVlh2O1mZ6SJ5ElnCZr3t7zVbjBKTKMSw3fdRmidqJltKoNX
 XyWr6JpmGgY1mlXo43cwt6IsFxkl0LZfWMIlffwpE/tGSMqK7n893kvMxNK0+XKPcc6LChrmD
 x6hNaci/bApCkvTl88hRcIjsD+FAXhnda5auAVXbDRsKJ+l2HFCOl8gjF/VGM3eNt2egSgAxU
 2vgblTCdhUSj7RyRXlpF2VDahNW5Dw8umDT/m766U9FO8LtInde4SRbqrWD4CjNuDGgwO6SWT
 wLXmTHGc0frsSPacLEazh++HqtaUcljfCV8OzreCPA+vCnHC/Pmws81CQcHFb65C/dDk/MSi1
 eUm2eFwObMC2zQjA0Nc5cwEek7BfbtMgyeGAMSs4/HOtSyZ6dqOAFevF0GywVELGbUCGgUOqf
 2MGXbYpCmvFSZimV9t0ilxZ/civBDz2MGhMTVF+CYefHmX8WvHlcfrRvn+dGGpn/g3tGLCFna
 l07cvm357RFkes=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 14 Sep 2021, Johannes Schindelin via GitGitGadget wrote:

> tl;dr: This series contributes the Scalar command to the Git project. Th=
is
> command provides an opinionated way to create and configure repositories
> with a focus on very large repositories.
>
> Changes since v3:
>
>  * Moved the "Changes since" section to the top, to make it easier to se=
e
>    what changed.
>  * Reworded the commit message of the first patch.
>  * Removed the [RFC] prefix because I did not hear any objections agains=
t
>    putting this into contrib/.

Forgot to say:

  * Sent this out to reflect my latest state before taking off for two
    weeks.

Ciao,
Dscho
