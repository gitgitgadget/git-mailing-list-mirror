Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D352C433F5
	for <git@archiver.kernel.org>; Sun,  1 May 2022 20:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354661AbiEAU4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 May 2022 16:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238355AbiEAU4d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 May 2022 16:56:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C070FFD2D
        for <git@vger.kernel.org>; Sun,  1 May 2022 13:53:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id r9so11213374pjo.5
        for <git@vger.kernel.org>; Sun, 01 May 2022 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fIopAsmX7S0OYDWMPHFg4V0XAIlKPKCtWWq84vuFRzs=;
        b=Q9p2yNxnN/1qwHUARKkfiezOwKelPRGhfQdxW8FTBlfMsecKXbi0VuIIfiW9XN1AoY
         xJCMDxqFJ156WY5AcRmG9V6hheBx9tDw4a1NnzsOu0n7T/rxW1Nsja5rf1NUnNfrY2yv
         e2QDw+mqhIAZsDRTdXJNviAgK3r6uba6f6EqAmrLCVEsC8xkHV6RuJEmNPO1Hct3/dzD
         fTIz7r3punNQSr71fuz8cQNNA1AVemQ3XtM1EOf5qi0VIM/2a7empqvz6JShmWE9yRjv
         /o3wbqD7UfGC2w20FHLtmuaXlkkNx8sVo4yZxVrwgH+TLVxdzzUtQetT0BemLbO8SpVQ
         IFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fIopAsmX7S0OYDWMPHFg4V0XAIlKPKCtWWq84vuFRzs=;
        b=6HHVVFq0oml7fEgG/HY+fWWOMqA2/+m2HNnWAlTidgtj6kJ6jxQbWAN5alkSvcLwVu
         AJn1FoqF1WgtHT8JHZjPuyMQuVwrn1V8E6BKBiFcOhXiR6CHDOBMzKLa14mGsQFCXLH+
         5qnEyP6h3eORKNY99fFwwS2I0oPVZ7Y5EokL1d+TNft7FGe9GNlIRrBbXyRBclbZRd1A
         4hjDyZjVTXiUevEaLrwQAxwtT9vt/bOQCzAkzA1yc4ktRQU+iX8e6aYE1/utU8xTcdqk
         /U/02UPLg1MRdV1vCADDX5bDBspDbwo5ICtnFlxA1KSs5T8PSXui+P4aMcm22xJ+QGNm
         JXRA==
X-Gm-Message-State: AOAM532iv3jCvBK/YB9AflEI6lgptG6FfpH8J/S5XuiOL/UjVb1D6/UT
        8sjQ4rvRz9Bc9HwdMP+H/AakEmd1NEtBnobaB9cHPf2cyPM=
X-Google-Smtp-Source: ABdhPJxTSgrw7udv907pXbQdZtu9qmQZi2rHLo9J7KICosBd68hLublPaP6ySZGQ2Ll8W/fZ3hj9E3hJhZH/BmIU7Lc=
X-Received: by 2002:a17:90a:e7d1:b0:1da:30d0:9327 with SMTP id
 kb17-20020a17090ae7d100b001da30d09327mr9902021pjb.144.1651438384874; Sun, 01
 May 2022 13:53:04 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 1 May 2022 22:52:53 +0200
Message-ID: <CAP8UFD08-6XpDSXYMShLFOiHfwbaqbus9axgmGG1+SAP9RgXOw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 86
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Bruno Brito <bruno@git-tower.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Brandon Pugh <bp@brandonpugh.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 86th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2022/04/30/edition-86/

Thanks a lot to Bruno Brito, Brandon Pugh, Carlo Marcelo Arenas Bel=C3=B3n
and Philip Oakley who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/577
