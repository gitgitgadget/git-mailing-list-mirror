Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C15C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345214AbiEZSM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345081AbiEZSM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:12:26 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD29B0D04
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:12:26 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2ec42eae76bso23931687b3.10
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=m2hm4DCCFNmiE2HWuDKUAMGCEiXlPR0Bu3U/27DqCNE=;
        b=OwOIu77QIWf44h65VF3hw4Hy1WlduK2SPwzuBSDNnMEfWUPGM5006OJcOXZtH8/bHB
         +la7Icjs2Puat9vsLQg4ecm0nPZROHaedxHLdGSZjpHCuCtYdfFWT/8MEv3ZsrLAIHuz
         n+PeBXPUfGXfxPQJguOpdtfP1yOdLeSWOjgXtzzH6MzkEeLa585wtXKqWXjiq/7PfGuv
         ERELLk6F1TmuYnyCVz1z46PR/o8ihGsx1cYAvRKjkjAOnOaL636xPeUlXL02CEfH7Dp+
         XDuwFv6jJuYI7qY4Rph/nxgPOI5pYJCp5TN2xZ1GNwJpwpFVKweNg7DJxRL1pHBwnwlI
         MdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=m2hm4DCCFNmiE2HWuDKUAMGCEiXlPR0Bu3U/27DqCNE=;
        b=4ha1/xfVQH6vetll/HI0OesAoSKNwwF2i8bclyYKCu7bMjAzD1CrGoX/FsU0L8iDLW
         JUZgEP8tPQvVKxSJG/kHD4s0UxgHVsFSSwD8qkia5dwcTjllbdKo0AY6xhZSfJBlR46E
         CJ/Dy4aOz1G4FoQ7shCPz84fp7JUX+dG9imrCHVC4tdNbo6eV3zRgkNuEX+giSPp9fT0
         LaaWg4+HPBvOQIVeOo2a2vRet4mPZHUToiOd1/LcApG6uWPt1zkFNYXIyiXzeamtzOvl
         FMEFf8W7/HJo9hkDxpE3Z7hdyPiZ4b5wigpNNQv0B2m6rMD/LhOBxBpvwBM+Swq9A/E3
         IwJQ==
X-Gm-Message-State: AOAM533R+k/3j/oRaNdCg9+bkoTqQU0+a56lTsAglVbakdq40HY58Tzf
        CvoZrBy6av2V8pC6kP5NOEFy8iDTN6HMFkqzmhfw/E1IwSo=
X-Google-Smtp-Source: ABdhPJxbhGiILpIE5a8SdhCruq8ZoEmAvfMae/9NFsLtyzfn1OoaI+VlgZP7wsdd8Gnpo90DJzO+KQsDjVeus34y/T0=
X-Received: by 2002:a05:690c:102:b0:2ef:48d8:24c3 with SMTP id
 bd2-20020a05690c010200b002ef48d824c3mr40313519ywb.153.1653588745005; Thu, 26
 May 2022 11:12:25 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 26 May 2022 20:12:13 +0200
Message-ID: <CAP8UFD3OtvJ8bZsb+qRr+=XNTXw4K5r5wJq7VJHd-vMbjT=JXg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 87
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
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
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Dan Moore <dan@fusionauth.io>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Hariom verma <hariom18599@gmail.com>, lwn@lwn.net,
        Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 87th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2022/05/26/edition-87/

Thanks a lot to Carlo Marcelo Arenas Bel=C3=B3n, Bruno Brito and Luca
Milanesio who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/582
