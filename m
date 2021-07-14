Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EC7C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF5161289
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbhGNIuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 04:50:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:36633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238432AbhGNIuP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 04:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626252437;
        bh=Syc862oKxxAMBK3/D5341S2u682IS/0T25s+rAZ/oUc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gY1TMVkUDevVgZzYk9tIHVEmal3QjIclxp9lb37KK7aFH1XRkSHoeG8x2ZYD1jo5L
         tnkenQVucnTpyNaRHBjnu6BXjCrPkZjRlEUuQdIGInpqVUbqaXVjifKmR9W+7z9rQ9
         3cwWoR5FUb9iVzhX+wkeVZk3PC0gSucdoQbUntso=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.219.153] ([89.1.215.141]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hvb-1l2VsY0LVH-011mbx; Wed, 14
 Jul 2021 10:47:17 +0200
Date:   Wed, 14 Jul 2021 10:47:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Dennis Ameling via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Dennis Ameling <dennis@dennisameling.com>
Subject: Re: [PATCH v3 6/7] ci(vs-build): build with NO_GETTEXT
In-Reply-To: <xmqqsg0rjlm6.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2107141046130.76@tvgsbejvaqbjf.bet>
References: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com> <pull.878.v3.git.1625439315.gitgitgadget@gmail.com> <2c4cd9dd1c8d966c8df0349bb820449ae1290793.1625439315.git.gitgitgadget@gmail.com> <xmqqsg0rjlm6.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dMatzKbTypA5V2n9DnkeMrCI8B8yGD1LHD8GBSDKHSiC1sdaltt
 +GIQt0RBD3cjrAeP07eYN9HVkCt0W1I36cOgdjU0ZjYwvA/CYLrX3sP+zrPDrPwNI+b/NRR
 atkOyS1iPHdHcfyIS+E0PDWI3Yc+lppAgCiwhVS5XbEXSwJwuiBB8mzGGjfxMOurvTNjs7f
 d0Y08NUMa3roKfNJ0Cdcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S6+InkRcIY4=:Vre2kGouF3v+8Yz5WOdarL
 9FFfM0yHrYFXct/WZZq+vCvztHfLy/QE1aqPibe5OaKQQUx/t7dvykzQajDa7Sc0Z3jHc3XOT
 d6sX7NWjf69Uiyq8VYulFeAwOs4j3XFNZkdA67+YAfN5EiijgzulWPJMX3Zi6Y4lWXleCTOsk
 lcuiA56xlZugCLSd05dnuSfGCejhOOsGpsbK3FIfAwmYRJmIgFVloyQsLO4k/Hh+w/K/ozQsO
 jF7jgaiP0vgH+yiIFI8zi/olpvfhlpVaPXUujO4NBHBbp0Z51AbtM9xqZdAB94bIi60Nq36LU
 +SHY3lvb8yYzHWIw3gZacNzSPHJkFKkTGePJdvPQqMXSwtilyv/O2oCq//uV/gSerpkjNs2M9
 0T9HJWDO7uIv4NqAsW48g8ErxL8D7JanYz1Q/czUx77dHEOGjY03qAyeKbaPpWpmeYYbQlU8T
 erxDlC3WeD4aYWee39fxbEwzcNEMlz9BbtiomXpF2ZA4Yk/Vww5kFPqlnooTLgYbe2Y98/xu0
 GwHduzRE1AfiuD0g8taF9mXEW5D+iEySIGo69FkS7arh71fHJPjJJGXqSdP1qKVOs4DOXJyMn
 brmNtOkln5m+N36hjEA0aTi3v7XM2vE5MnU4SqPYaJ/6o+WOV1ELCOcIjDcdMLqa37U8fMLmK
 uMPe0Xia5Wah1tF7vvSVWRPJp0EjfxjZ0bQy1nq4zWdHYGJUivQ4qAwtGH+arNtfeV3RSek5P
 vb+29hsdS2Laqwn3zc3xn1oKKTesA4BS4EEHwaZQdNOFttisPtPkcgThRLox5gSVOLmpgDqIy
 +OCor4XuSuqKj3Mk8Q51sp4jP3SRAlONo/GJ0JyQs+bFpxDY4zEFtzw0LhMAE5ed3ITSFTUUj
 pR8iWRNw7w9pI9tbBPaHVePXgh5PVc7QUFVgge4FnA5+3MWqejvoQDjIKSbuBpY8h0JzRsA0j
 L3ACrUHvP6dfupnq/CCdorvSBlj7DAKDz82PbN/YNJZCc7PFpbAIEKT3/zlEJqmxE40yGfth3
 9CScezgncGnWTyNQC6Z0lKsX/Nazk0rcwSLRJ95LTOMO6nat24+zIn5edh2Z+9jR3tL8o69+h
 03IqX54U+y3fjLZ8Nrv2/aOvRwZe/NsGMUJvrdCOmex95CUuOB1kdSutA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 6 Jul 2021, Junio C Hamano wrote:

> "Dennis Ameling via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Dennis Ameling <dennis@dennisameling.com>
> >
> > We already build Git for Windows with `NO_GETTEXT` when compiling with
> > GCC. Let's do the same with Visual C, too.
> >
> > Note that we do not technically _need_ to pass `NO_GETTEXT` explicitly
> > in that `make artifacts-tar` invocation because we do this while `MSVC=
`
> > is set (which will set `uname_S :=3D Windows`, which in turn will set
> > `NO_GETTEXT =3D YesPlease`). But it is definitely nicer to be explicit
> > here.
>
> In other words, is this a no-op but makes the recipe more readable?

Yes. And it also removes some puzzlement from the thorough reviewer
(Matthias stumbled over it and was wondering why this even works without
`NO_GETTEXT`).

Thanks,
Dscho
