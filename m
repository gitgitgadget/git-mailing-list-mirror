Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FCAC43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 13:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiGPNu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 09:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGPNu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 09:50:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD5E12AE6
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 06:50:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sz17so13461928ejc.9
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 06:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=8RalYYutDZdipTsowHwZYfSokwAaB0QzIQclMRnzPcE=;
        b=Amdy2iLyhc9FYaTmH4efJW3gT5bIVHFyxFNWpgjJNyUdX6zGL2jyr46voXS1HWgFx3
         oUvNKmzKmozayFjIAHarn/xo4meVFq+/8hQM6nhQRuUGqXGL4Uuy+Np9db46xuhLwb+9
         3QsXdMtqaOXh+bGMtq+ygebdLmrF3alDaPJ83Z21K9Rj2Vp+mTOUjY0EcSnFXjhill4S
         gMZZCUiFyRNjKqHPLtnLVr7Jl5w/jTOqbTsE7i8H5FmFXFsOMkqXEnUVIRUEaFDBTTm/
         cLwUm93chthHTvMR1LPh2XI7dTX06WoXuZ5+DvXQNNzN0Mpkmnla3uDPtnfhLoymbnT+
         ocyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8RalYYutDZdipTsowHwZYfSokwAaB0QzIQclMRnzPcE=;
        b=ATho3G71PxR+n+wDiGZbLDCv8x2g/4PNaNvsH5LE0kAYdL0QKx3uzIIR/WVRzMMOsm
         jSLR9xTM/+Rk3rLiiPIqcT7lvrGKk8UtmaJb6Jh9xDWUC5sckDuSJUeV8uzTziylfFxE
         5R4ahpUlqv3ken0lAuqYeJPMzLC/JKou6OyuBnz4Gg87lC45VHp7SMcIdoJzRfk6WBj3
         cLS4ceWW9nqaeF3PRjRZYisAX1OWyBC0b0gJTCo26VHX34lSqBh+tm3ET80JSRO3/R/Y
         olrg6pK7G2nPldczF8DJgDzEviH6tkHRCN0teiyboiXnmSplWq6E7ay7i7lmhhnL0GLs
         TreQ==
X-Gm-Message-State: AJIora+XUy1qPtBg+J+QQKQyiI/dWTdo4RheIuGEe8vkrAU8Vhsjv12K
        2UECg64gKbZGOI25seskkM1RFt9XDtN2/aUgesQWrbjbavIc1w==
X-Google-Smtp-Source: AGRyM1uq4XtWskhw3hfnCTFiBn1WgpP9te7fZ0bfo6a71pE18LdkP9Bsn+Rci6V0SGDgWzKa7mZv6Y+3FTuMdfddMq8=
X-Received: by 2002:a17:907:6890:b0:72e:e404:46d2 with SMTP id
 qy16-20020a170907689000b0072ee40446d2mr10976516ejc.578.1657979426067; Sat, 16
 Jul 2022 06:50:26 -0700 (PDT)
MIME-Version: 1.0
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Sat, 16 Jul 2022 19:20:14 +0530
Message-ID: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
Subject: Can I use CRoaring library in Git?
To:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I need the CRoaring[1] library to use roaring bitmaps. But it has
Apache license v2 which is not compatible with GPLv2[2].

Is there a way to use the CRoaring library in Git? Taylor told me that
contrib/persistent-https tree is also licensed under Apache License
version 2.

[1] https://github.com/RoaringBitmap/CRoaring
[2] https://www.apache.org/licenses/GPL-compatibility.html
