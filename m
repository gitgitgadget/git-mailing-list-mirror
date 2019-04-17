Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90DC820248
	for <e@80x24.org>; Wed, 17 Apr 2019 11:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbfDQLs0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 07:48:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:34373 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbfDQLs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 07:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555501699;
        bh=mFzPBbjwKrtnogyCVLf8YuXUW0xAZBLytR+U0q7JFMk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GSGPMAgCslhzd3M8pqVlb+Jh1ajav3o8T+cj1APEq4gagrwpZuXv+tzxKxHHM7KA7
         hgV5GefX/v6n8x1tjFVQSyERbydX4nq483pTYNmOwMffKdIm7mLOC9E95P3tDx0gP/
         A9xsjVnWHOk85sQHHDb3RwURjGJmOlJMUjwi8xOk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MI5Ve-1hHHoa3EC6-003yJN; Wed, 17
 Apr 2019 13:48:18 +0200
Date:   Wed, 17 Apr 2019 13:48:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 1/2] t9822: skip tests if file names cannot be ISO-8859-1
 encoded
In-Reply-To: <CAPc5daVRq+tisZqpGVXTwHo7kgKUSfjB6dmjLTUQKqQ+Xh_5eg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904171346550.46@tvgsbejvaqbjf.bet>
References: <pull.179.git.gitgitgadget@gmail.com> <pull.179.v2.git.gitgitgadget@gmail.com> <6161c76702246ab34a520dae8104ad489b89b6a1.1555276767.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1904151434520.44@tvgsbejvaqbjf.bet>
 <CAPc5daVRq+tisZqpGVXTwHo7kgKUSfjB6dmjLTUQKqQ+Xh_5eg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:saFDhhHg+O7O7jBYHilE/ENHrI70NJUY2gLVhJEFV+KYinLMQoN
 T4BjC/uhUpPS6BxXEegHD1IRNmyOmqJ4pl5iQQPe8e/maETDWIQSNczRey/KSKEvr/LL3am
 KQRYsOnK83KIBwkRQjcoP5boEUY99zD+v6jSIhwC3J/ZHK8i048jB60lQfnwz2xjt8ZIm2m
 g3tLAW1E1O173ihKvIRoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1DEbn8vYeoc=:zhlPH/aKlQr6jRZ4fs6MdN
 BnUfZjBbeGZ4d0lQSdPlP70n5xGKXnemN6HeheGDdkKpwN7mF9STLsSN6zp7VK3CM/rZAy8mg
 62Pkz/umWk4uJcqNJPFPUoxAnQpvrx8UIUR5nyvpbEeBVLHmczTbaWl2jd3Z0O0xV3iZgq0tJ
 tb1Y3Gp9V8ruutCf34077g+odcXgpPkgfcrb5PELvvt6kJ5UgCWeGDVvQbya7pYYFAVukCGQB
 0oVHCL/qOgYh0Zduzd40yF5Wh7n6JL36D0cU4oiF1L9WyM1K/NSyeiYPk28Pr6gfRyjuwnVUp
 FoXKeI6mWJ86J7vf3KmiTzDZ3eiKLmf5WnVubaFunKUoicQgA6kqcPLf7OcvebcL+LpdfBi4N
 h0kJ73GVfrpBA6rvv8fkq7XIAT5Ay/jxibEBbl+eNEsWvdtqWpA8wDocQor0ll46yi4PTN/xI
 UGrMKA3uzySt6cihR4xmNiTs0+C59O/5Hte44MjCBCvnnswSPgw/JFdJbmEABAYIAjrPrRtzA
 QsjTvPA2GBKL4+8cLMHfLtAOK2Ky6jcmmVGmegpw2V1JkM1vHivwIhodsaIESEk+by3t8X6nw
 Iv89VFq71693k87eWLk+Xhfo4jIDzcwmls/Ix/pJeJOf/JU3k6BZgCHDloUvjxDOP44FM1J0h
 3dXY5h1FgDKonQoMdBBKNbxmekmC0GTHNzH2bUnUr1068xhZNmmAhLTSEaezSieGRPiGfcziw
 U0+bThs44rqMB3DR6xG0F/werQWXqSG6Rj6ExjoyfWkx+vV1L5NX8pT8exejdfVZeRPSDl88i
 7izNEHFP2lFTa3U6wAmPXpeJMeUYtq8lKqrc+VQ1E6kHKovCVgB91EFceLzm70P8cx08QSc3w
 KBzcU6ILy2y8GshEzDFcJEAfPG+H7TB/7baiUHjz7giKwIYQK0OpGzeD5LxCR684BuU9wbCl8
 mzWPntXDHLQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 15 Apr 2019, Junio C Hamano wrote:

> On Mon, Apr 15, 2019 at 9:37 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > It seems not to have made it into the js/macos-gettext-build branch,
> > though. Would you terribly mind picking it up, please?
>
> I think they are separately queued, so that they can graduate in any ord=
er,
> even if/when one of them turns out to need rerolling.

Okay.

Please note, though, that I had packaged them together because they *both*
need to advance to any branch in order to make it pass on Azure Pipelines
again. (And to be sure, they both fix real bugs in Git, they are not mere
workarounds necessary to make the CI builds "green" again.)

Ciao,
Dscho
