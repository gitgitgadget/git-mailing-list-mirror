Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E216C43219
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383687AbiDEVpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449921AbiDEPuz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 11:50:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5830C16BF40
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649169373;
        bh=cM+yFhNylxvwIUuuDyXshDYg+DE3KOIZoC01wtj+fJQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DQHbNLjqhKwUtdWHf0JA7NrkTVVg8Hh10fjOLmu8ACOYpwIiJubiFFmAChb2LWBiF
         LXVN68wMBhx/cRpZRpyn2UxmvK4FWLE4xk/hSXv1rWBs28LLYuN/FMg18t0KgCC5Wr
         N2P2DlaOxjgXKUALMS9tQ0m7WpCU/3zRF7icjOhk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.56.235] ([89.1.212.158]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7i8O-1o7B0x2VMo-014l6U; Tue, 05
 Apr 2022 16:36:13 +0200
Date:   Tue, 5 Apr 2022 16:36:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 00/25] CI: run "make [test]" directly, use
 $GITHUB_ENV
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203301430540.379@tvgsbejvaqbjf.bet>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1880103203-1648643861=:379"
Content-ID: <nycvar.QRO.7.76.6.2204051623010.379@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:4LBZZvi6x4jpJXLPqJaoHSI96WiKLUH/m09Zf/3E2npk6uwcIhy
 iiRa8QXGli0aW37wHMsfBIQkske/gc2NJTdWIT7H0WoLuUbcEFrV27qPD9n7v3e+R9SRJfi
 QhgwcUrzahq4i63NX9C3sZscRLvVG2HZA0kAfJgo8xXs6epziMZNlyZO6AmIbCw/FfyWzXp
 SQ9BH3Dc06oK1YxshhTaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uxP4Eg1FNIY=:lHySliO02yZhOPOceJKudi
 BFRvYHe9zW8d7NqyCQLONBdP3UdwoG11id7Wudjyj6goiuA3xjVa1P2qoZDnlnYcOpYVjQqDV
 hsNa/BWbp58aAySKYRi69tp/4gpE6K9jEh1SWnSbI9BUfTM+O1/hgJpXaQAy3za1q4UWCX8kf
 /9DDQp+BcTkq6Xn+ltx3mjlqX8DsjJ71zKp26JI1OoY/geCpg3xo1n4wNmF7FJt6RoEuR5znu
 yQOBxMVgBuzUGfPkNXcOPcyvhvzVA1VPhrAH7Jruzm45wMrBwSKk1abvzBqStsfaX7bKKo/uH
 4anSPI56EWgCFABtegwtKakbeT3vd27ISuPhuaTQV0UVzpselKTMoHjUA4z1Bl+sbDSI/DGfb
 ViGxKnEoe9EI0ILFlUKTb5zr0Imfc7PJ974bZ3UCXvAzJFaAd8Lw5kmDiSTXIvqpTlvVJq3Xl
 IqzcHsD2IPe3q03PkyT4K8qnjOPdEi7u1UKiTlj+af7KZIYnZDuE3vZ9MI4MWoceFS49yJ4xs
 5f9iZgIfWs0YabgqnU1vVBp8+XhQeosbYR8F9+Euj1KWPs35K8r+VcvDu/tjJQngtP1AYsrvB
 kpSCAh6W8k4DL6thsH1iUpzu5MEGHikQHF1vnMrs7gHNGHIhbBR/TJcX9cddWCcD6kQmMIgd9
 VY6RlI6sexgoe6ahVUGW+1XjI83udoIzv5AFWUykymzQkxqdKkjJgUAIrdhi7K4zT8Eize2B1
 gHOOlqdMVOtGDSqE8DRAopsswY7Xlu/vuGUK4X4bQQ4gBGXIAmhQ1KVhpvH6OcWyTaG3sez+T
 LhuK5qqkSQ+RD8FfEJgUBbX4aLuCQT623HaRrUEudDuO6MWj9qkjbd73euN+8HXyFCrb+Ye+S
 H12KvxMnbKahSJpDfYJ3nc45lf/lh2yZJa3H/BDzKZxLWEw5XkmxSo0596S5QBUf65p0pwTo/
 bjRhsVLRczOBAp0G4QUQLbQ4ECDNVjFJvR4cuDpoQ+pjguLxWnclPZZmlzAXDAP4aXDoSE5p8
 K4QRxNtCFoK63Ym9jCu80sDYAiYPtKiTb9QxuxqaWruraIosSVoC8YAVUiW5oC7u8Tk157Nsd
 olBqMzfQcE0sk8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1880103203-1648643861=:379
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2204051623011.379@tvgsbejvaqbjf.bet>

Hi =C3=86var,

On Fri, 25 Mar 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> A re-roll of my improvements my series to simplify the CI setup a lot
> (see diffstat), much of it was dealing with constraints that went away
> with Travis et al.

This type of work causes me a lot of follow-up work e.g. many merge
conflicts in the latest Git for Windows rebases.

Perhaps it is worth taking a step back and evaluating the return on this
investment in the CI setup. While this can be characterized as a
simplification taking the diffstat as proof, one could challenge that the
diffstat does not actually measure whether the code is simple or not, it
just measures whether there are less lines in the end.

If the diffstat was a good measure, then the optimum would be one 0-byte
`.c` file (which some C compilers compile without error). Another obvious
way to optimize the diffstat would be to remove all code comments. Would I
suggest to do either? Of course not.

The reduction in code size of this patch series also comes at quite a
steep cost: After all, the way Lars and G=C3=A1bor set things up was alrea=
dy
easy to reuse with Azure Pipeline and GitHub Actions.

Removing this type of generic, easily-to-adapt code can remove a lot of
lines at the expense of making the code less generic and harder to adapt,
and leads us directly to CI lock-in.

A better approach would be to use the already-generic code and adapt it
e.g. to extend to the CirrusCI definition we have.

Even if you do not care about extending our FreeBSD coverage, I would like
to ask to slow down on refactoring as it is done in this patch series. As
indicated in my comment above, these types of refactorings lead to a lot
of complications in Git for Windows's processes, which are time-consuming
to resolve. I understand your motivation, but if you wouldn't mind taking
some time to weigh the criticality of these changes against the overhead
incurred for maintainers, it would be appreciated.

> I think just removing it is OK, we can always bring it back if needed,
> and doing so is actually going to be simpler on top of this since the CI
> is now less special, and leans more heavily on the logic of our normal
> build process.

Removing and re-adding things does take time, though. Again, I think it
would be helpful to step back and try to understand the value of this
removal versus the projected time it would take (from all involved) to
re-add.

Besides, given how much is shuffled around in this patch series (e.g. some
files in ci/ are removed altogether and their equivalent code is moved
into various other places), doubt must be cast on the idea that it would
be simple to bring back anything here.

Ciao,
Johannes

--8323328-1880103203-1648643861=:379--
