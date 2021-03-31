Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72865C433C1
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 11:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D66C61990
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 11:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhCaLJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 07:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbhCaLJa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 07:09:30 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED56C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 04:09:30 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z3so19654491ioc.8
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 04:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=H1FmYJkF7ETLI4bN3UAUt1pzXIrq+ZaWj68YrjfJSWI=;
        b=HLSqD64qIL7AeWjSp0Z8QdlhOYfx5Trt37pI/zEfZAeY7MAFeSpGExsA2rnxbb+kEH
         AP7NmdUBVfOtR6bdKayI/GSSV2gEv58WpcjpiVHA1J49YK53mKDa2lamdMnaUEjEHPYs
         2OApcMfPFkCLSph5VIQm7vRy9C7rMyuVJFm1mCSG4NiWsRjV7/GTm3yGLB+qBZWP1DV5
         zpdPDJbyGrn4R3D6hxImL58VpEG+I2nwXseWSp2Gis+MaV7STwBsqrnaa3G8nhv1j0ZG
         zC4xA3qhshtelknT5Z65nXtXbh2Il4M5Pql+EBnGq+gcD6jnTie5oJHKo1HXk4YipeMP
         kQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=H1FmYJkF7ETLI4bN3UAUt1pzXIrq+ZaWj68YrjfJSWI=;
        b=MOnUS1CS2whbZs5CHRuRc5boPVOMLqkciLCFrJAPSNlPhvtR/QOQv2MNEJUj0fUHj+
         c6L3R/kS2aszYcB+3+LxRjqoghTmUH/5Avkc52otaDHbVVLxrmJX0tpXLwHkghcfQVLO
         xgMxqG59TEG3Yvo2v2tu5ScbjvKwJhUWny8SvuerI9MRPVp3jwWU2Rk6+XUDgmSSYIVe
         I6PmlIlEDcf6SoWbDHC/kQycq81VklagJEoTyVMkfyMr/4VzvlrULbDS9am2QUtKGW3f
         H/sijkN3FXQ3PlQGJtHO3thd42LY/z7I03RWMbre0yCMgP51LrSx8Vl75leYzbelJyBT
         nvCg==
X-Gm-Message-State: AOAM531aDjoHKPRG9O//pNV0KdwF4cy/aSX+u3/NZ6vd+BGKdtH1dDzv
        Ws3decdwxvWZiED+wZ2TxYkor87jzmbTc/ZTFoRVuU82/GoOzG3W
X-Google-Smtp-Source: ABdhPJwdVrMmeAl7dO9sBaQ37/hkA5LEnHLEu347XNPi9FwtlySOJ0NBg+P7o80SDhTD6iCFA9dsJ6+wDh0dmhBFWaQ=
X-Received: by 2002:a02:6989:: with SMTP id e131mr2449455jac.105.1617188969485;
 Wed, 31 Mar 2021 04:09:29 -0700 (PDT)
MIME-Version: 1.0
From:   Gagandeep Bhatia <gagandeepbhatia2303@gmail.com>
Date:   Wed, 31 Mar 2021 16:39:18 +0530
Message-ID: <CAJqRXRgc1buSsG4pzr7G03BTfhf4AXWos7sfrwpdJbMMDcsG9A@mail.gmail.com>
Subject: Interested In finishing convert git submodule script to builtin
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Team Git, I'm Gagandeep Bhatia, currently pursuing the 2nd year at
Christ University, Bangalore, India. You can reach me at
gagandeepbhatia2303@gmail.com or +919466935025.
I went through your upcoming projects on Google Summer of Code, your
idea on mixing desk interface improvements is really impressive.
The best part about your project's quite likely that if you=E2=80=99re usin=
g
submodules, you=E2=80=99re doing so because you really want to work on the
code in the submodule at the same time as you=E2=80=99re working on the cod=
e
in the main project (or across several submodules).
I truly want to become part of this project for better mutual
achievement, in the past, I have done a few projects, which will help
me to contribute my best in this project.
It will be really kind if you can share some more details about your
project, so I learn more about your project.
with regards.
