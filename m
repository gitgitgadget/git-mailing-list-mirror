Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C83C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 16:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE0C61CC7
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 16:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhGGQts (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 12:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGGQtq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 12:49:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619CCC061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 09:47:05 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id v14so5494795lfb.4
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 09:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8JvTTeSpo+N6IqKNi4SwBmLDHKVcPryO0AQqZ0PCBpE=;
        b=D0Rb3QrAyHwT2no4CEK//Hwkg9G51tKbV68fkzt9hkrte8pdc+DUCHdBLkbvadP1Wq
         lAXkT1ItWKrkc03jiwu+/yEPDVMCf0jqPTJzIVxPOXO25Cw+0ysq/GGQ+ryNJIX1LKyn
         KeGqNhoDEM1c9TbO0rZbAbP2MaoblFku+e0/QkMbvgDE5TZR4Sqg9zvueVXyeFU8IUw7
         AEHqGJZ1Ci0yM9/8MPhje+hoynKxPR7xBLIlreYwqO1x6o20n/QGuI4pLz7gqqoXzW25
         Xh28uJurgG0qW20pZi2BxQRI+s+bq31MZz7U7pyrcj9dmzzHfSIBUpoxEIIRoXyWbvhQ
         WBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8JvTTeSpo+N6IqKNi4SwBmLDHKVcPryO0AQqZ0PCBpE=;
        b=Rc8ivENKqIdjeyzXZlsF8SErF4gJelJ0Hs0wOcA6DrTPBGQLyCNXeXmVnIRNOxZ2E4
         uS2siu/yAau2MHdpRis55r/XpfbCb4dc/LMxDQC5esGM30YgIO6XVRy2CVLH7UtTNAOG
         PlYIAEQnCSj7+k2585U83rzOScKDy07XRfl/n4isLt8cgAZVnrshaKAlt7upZFmJ5r4E
         pyAcMK+sCfg8DykKByvtVQKzdi7QSwCiSQbLXpBNiww/d5brWhfSUnEclPIxJeEbj1eB
         v4smxDuoFVot/9772ktJ+Tn7KFG/pZ+NSLgwNzEPBaqqHeAudFdP+YLNwoOWreKnykGl
         Jb8A==
X-Gm-Message-State: AOAM531dE5U+O8aFxQL4h274+18pd3/z48aSeyTNA5EKzVV0v3fbkhbq
        uhTu7MOZWuA6K98Unb6HL/M2ndxzHHJODzXxbGMrr2j10QnDnA==
X-Google-Smtp-Source: ABdhPJw29J/hqIlBkefb87cZDx1hOzwhlPAj56VDCuSUdDtdDA1fPBT41HzUaJhhcBVvpiW3/6i3geeuKXlM4P5TaUE=
X-Received: by 2002:a05:651c:516:: with SMTP id o22mr19635912ljp.255.1625676423656;
 Wed, 07 Jul 2021 09:47:03 -0700 (PDT)
MIME-Version: 1.0
From:   Professor Bloodstone <prof.bloodstone@gmail.com>
Date:   Wed, 7 Jul 2021 18:46:53 +0200
Message-ID: <CABHhMZHEL=0sU8JqwMb5Va7mjA4ZxM_WMaLMabbKS085RVbDzQ@mail.gmail.com>
Subject: git-am changes author if its short
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When applying a patch using git am test.patch, if author consists of 1
or 2 letters, then it is being replaced with author email instead.

For example take patch with such line:

From: AA <git@bloodstone.dev>

Upon applying such patch, the author is replaced with email:

Author: git@bloodstone.dev <git@bloodstone.dev>

I did try multiple different 1 or 2 letter names, they all seem to
have the same issue. 3 letter names work fine. This was tested by 3
people in our project, and happens in very different setups.

I'm having a hard time finding the exact cause of it. Tried searching
for issues, but didn't find anything. Maybe someone has an idea what
could it be caused by?

I hope I disabled the HTML mode properly and use this mailing list as
intended :)
