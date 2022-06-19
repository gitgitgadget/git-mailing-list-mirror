Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60C7C43334
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 08:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiFSICh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jun 2022 04:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiFSICe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jun 2022 04:02:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB099B875
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 01:02:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i29so12814041lfp.3
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=47L746mEfevjQixjxaaVh7E5MAXsflEzQJEAdO7mrgc=;
        b=mgSA9SAMCDpBosevD30lO51i1t4ZosMyhW6XmCSTHZ62IezSxlcr6X0JriKZwjQBEL
         PtSFaUdB5Vg3ve28lFK2j3EtgZXAsy8Fex4WWQYvhVSxQ2RRIvh2NCotx/CkVWcFe62w
         T4/qKTpOvoSYiCw6azfS54aYDFeb4WbPX2fTSVm/9egt/wkFK6egeVTq10k48vWLpQh/
         QO84AESdSU8MYlf6AFoBrbD7fojgWFbeGmHxEzlvrFGmyf0kCJj7IR1GbCfPvOSyuJ7b
         KIW05f8CcMf4N7kCdPyUeBJ/QpBGgvpLKsksVsusiqyo4XbKtFMcdn+mql9nZ3adh9Jj
         9amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=47L746mEfevjQixjxaaVh7E5MAXsflEzQJEAdO7mrgc=;
        b=TOmzeOla1/TO1yNO7UCzg8lPb6AlfcFnd0yWNKLTUWm1QgLapVND/CxA8PntO5/o53
         5kxRaazK62NK9kCHBiQzChw8DhdqjuXUNZSLY61mhAg76UzSGW987/4+wjQRPotMF7Ud
         BdBlQy/ybx8RiO5UJmTy0jyh0cBU2WbsDrl3Rg43iJ/fA+TbIG8N28vqsFKZKHM9BfHj
         Lvgog/fwmwf9NcRGXXghKvLUyRrSCAhXgB1250klnHDnOzPJ+R5W6kPEox8CLk6kdvZK
         rdV/mKtRVgcXainWzonXxqtkp8r+SdwXJBRYD3047bjGyY0mrT/ixYIFDivo6xyMzlFO
         fiBg==
X-Gm-Message-State: AJIora8q/Xv8taNFA03iCTBnnsrNLd2XVJsRVqr2ujI0oKKCFdam+C58
        6/rVzg/3wI6X5IbsBvfSEDwcbZlTOWywR2yfoEw=
X-Google-Smtp-Source: AGRyM1v4y+lC1TO4QALscujq7KoE4gCsb8ibgrjUEDyyu8QcUjq4x+7MAXxEDe98hST9MAH79JeVdix3xO4WU0uz6iw=
X-Received: by 2002:a19:7916:0:b0:479:2c32:7bad with SMTP id
 u22-20020a197916000000b004792c327badmr10673332lfc.519.1655625751752; Sun, 19
 Jun 2022 01:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220614112858.16576-1-worldhello.net@gmail.com>
In-Reply-To: <20220614112858.16576-1-worldhello.net@gmail.com>
From:   =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Date:   Sun, 19 Jun 2022 15:02:20 +0700
Message-ID: <CAPv0VGvKFEbVzZEdn+eb-4Bb9KfQWCa=pM3iC_Dyu-6AKGCcug@mail.gmail.com>
Subject: Re: [L10N] Kickoff for Git 2.37.0 round #1
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git l10n discussion group <git-l10n@googlegroups.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 6:29 PM Jiang Xin <worldhello.net@gmail.com> wrote:
>
> Hi,
>
> Git v2.37.0-rc0 has been released, and it's time to start new round of
> git l10n.  This time there are 92 updated messages need to be translated
> since last release. Please send your pull request to the l10n coordinator=
's
> repository below before this update window closes on Sun, June 26, 2022.
>
>     https://github.com/git-l10n/git-po/
>
Done, please pull!

$ git log -n1 --stat
commit 22262d3c1947626e296418ffa3543d3584995653 (HEAD -> master, origin/mas=
ter,
origin/HEAD)
Author: Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com>
Date:   Sun Jun 19 07:48:40 2022 +0700

    l10n: vi(5367t): Updated Vietnamese translation v2.37

    Signed-off-by: Tran Ngoc Quan <vnwildman@gmail.com>

 po/vi.po | 37548 +++++++++++++++++++++++++++++++--------------------------=
----
 1 file changed, 19003 insertions(+), 18545 deletions(-)



--=20
Regards,
Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n
