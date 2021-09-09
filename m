Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D89C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 11:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A3A60E94
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 11:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhIILQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 07:16:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:52789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234216AbhIILQa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 07:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631186116;
        bh=u3MKC/k4n138DYJQ/KaY1xE70RL49Gh2LWAC11/KhKk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Tm7yDlUmNjXQR8zLhL3AVlf3h/f1AcU0dqZ2jzZwDTRoPYOtOMP4lbHw18LY9Q+jh
         5oPJbs/1f74ZnFlaWgDTsRDBY1FX3PfYwPiskjdBOs3XItVLcFSh6xvdXz77tr1cCk
         0riAPzuY+Kx80KMspuIVv+VhO1Lbc2YsthJ6O/XM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGRK-1mhT2A3ED0-00JISN; Thu, 09
 Sep 2021 13:15:16 +0200
Date:   Thu, 9 Sep 2021 13:15:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: ar/submodule-add-more, was Re: What's cooking in git.git (Sep 2021,
 #02; Wed, 8)
In-Reply-To: <xmqqsfyf5b74.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2109091314350.59@tvgsbejvaqbjf.bet>
References: <xmqqsfyf5b74.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3/WdOudmyPTE/wpsWr2ByDyD0PTGs4KqqfnDEgea4rOJVJIv3CI
 4sP93eQjWz3z0XEnNilzS6iBWayXFUEcHMPmnCt0lxMIH7tXVB7FZmaB7FohJCdGm2vx63I
 7+L6SPSmBf37oxrj3wNIAdkXLopUv+FwUAje8dbSHEB1bpxEybY6kvzUnPn2kc8zsy2vGsk
 w/h6iSgzE0YSbRUbuumGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5vYdFoUFpFo=:SZikjMPdzkZkPJTLR6z+iB
 BIGJ5dDLkZnFiquJdsN0ZzWroEnR1wEUy4lPEtGdHEMqiYVsAx8SbHo4RTHNMHxg+lrsM5zYu
 NUPJW9wbxnwePVds8oOqh3ZZ+1jLER99uFV/O7DxSkFvEMoI50ysP7pnYE/L1zRzmkpoOxbMX
 aI+DUENQRt/u8L4NGhDfsYEJK7Xp2vJNih0lZJHoy/AGdXXvA0bp3ZxRNiikRtWPTjfbnQgdE
 u9EqYM1mH+mKD4hraaNtcJnO8d+CWr3L5iesSkNk5PrU/8N4kWmT++rimxjb3D7bnKYwKoIR7
 7OUrROO7E5F3clDBqHWqpXl3OHh+IormLA0lJzU4myu6gPvGTfTtVtmMZmv+OdmVbSOM4BAL6
 Bt6nlUz2aIiIIQAqa50K2muUaKaS8g8oBH7uII8pGepJDpI9mGjhldKOweUPeh5CTfIm3Gdn2
 qTnnHxl/HSGompgtQvDGc3tZsc779H9oOCA9eFrSjLosMljIUehk+qkBueGP4kc5zsFF3Uie0
 DWiZP11bh+K42dWEZb5oCx/EO4I1x6XqrjUjvJ2eDBq/S2RFERVJUYfMq2f8xRLVpqt4gvTUP
 5qF98nX7zAnjC7a+aUd/RA5/M5C9xIzBgN0EBf5tN0w7VQInLWO8+zr2gWFZ3SDP0gvBAbMCp
 KLCpzvGEFS++dHD7RVoVispJ7I0Qe8UKEJ4s60X8ZmLojWNz0OsYXe7vufp7NLCE5+unC8nN/
 /pNHFAJfQx05vVwgas4ti3YkY/uXqfZoVAgoSGAd0dRgaP9flaLSFxOGsVYFu6/jR4JPZlFYH
 54N/yeF5EtL1igp7La4e/8uk1G9/e4WoAAuDqROJ95ypQZCez+LFNwQC5I9kz2NLiCMIah3N+
 Jtdg7DrY5euCnfuuoLJR40yL/Yk/PDdeerTOe6V2aR+Q890ABrcFNhLAEqqE4xzcYQwOgrcxe
 TWB2SY0SIAaZ4tncO58FaBjcfITnCIHRGxUhPWHNcBDEU1XSbYbK6PvdqU/OekreRCK+TLl4s
 64eGLDb932T7pyFSxnsMp+w5ZqK3bHFs8mprZmUd9VrI9hsh65IJeMENR+AWxafyq8/NdUC03
 qa0wwjEINnGluw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 8 Sep 2021, Junio C Hamano wrote:

> * ar/submodule-add-more (2021-08-10) 10 commits
>  - submodule--helper: rename compute_submodule_clone_url()
>  - submodule--helper: remove resolve-relative-url subcommand
>  - submodule--helper: remove add-config subcommand
>  - submodule--helper: remove add-clone subcommand
>  - submodule--helper: convert the bulk of cmd_add() to C
>  - dir: libify and export helper functions from clone.c
>  - submodule--helper: remove repeated code in sync_submodule()
>  - submodule--helper: refactor resolve_relative_url() helper
>  - submodule--helper: add options for compute_submodule_clone_url()
>  - Merge branch 'ar/submodule-add-config' into ar/submodule-add
>  (this branch uses ar/submodule-add-config.)
>
>  More parts of "git submoudle add" has been rewritten in C.
>
>  Will merge to 'next'.

If you use the description in the release notes, please
`s/submoudle/submodule/` first.

Thanks,
Dscho
