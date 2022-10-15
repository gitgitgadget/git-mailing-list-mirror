Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93326C4332F
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 18:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJOSKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 14:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJOSKM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 14:10:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB1F2CC8F
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 11:10:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h2so111037plb.2
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 11:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gX7syoNZJq96u2ksmOxc77YRUvKtVuKXGk0tQG+JIrI=;
        b=OzaSb/hkCSgf2V2YKBuqpbIn7HWgLh8YxnouAcLcqaCLE2J0wJ4n16F0J0yi1uKhEB
         45o96Jrnz7pXrntxwRsdeVfjmV0a7SGdUPoiZAa2EgiOkwJZRvJz57XJm/XVXTJWKoVi
         QFnxFxRPYAjR9rEcFRWv1OXI68K4B/DNlTY0mhayJP/kqAQtABo5qIvvGoAWMlIyyULX
         0YMyjWcZms5//hGOkCtu0nibHxpgdII8RaJL5ZWQm49HOcSN6KZUTFJJ0+fojTSwd9x4
         j7iNKlLVvjie6VvMBiYOzKXvb5n4QDncB1KW2zFBrcEVJzx2f4t1NHhZEiW8x4vfd6hN
         UMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gX7syoNZJq96u2ksmOxc77YRUvKtVuKXGk0tQG+JIrI=;
        b=itSMglIV0nrdVGzCp0w7hAP0QdSXh5SlSko0406IamNrEJzEyTYbgnJqmOd+1jWqdz
         wPzAADHLAd6v+u2BEkzsDmy2+W+BEwpB9+4lJXbyG8+m3wL1d6ZFcU/qpS/KbwlrM2Ye
         cS9+mFiwDtWxlGOWxbRYnX/UdyycllcTMTkGbLBQVukLPtDyWbCTsnF+vahvZ0b7EdJe
         mOnAiETa1aWf9oXtSjjchTpx3OEozdthpZLRhbnaaXQ/9ruAQvABC6SbErFgbyY8Rks2
         IYOIeRXxdutmmZWpvdq8clSiDObumE+90tyTRliWK3L1FMFFRX8mZPdkpxXyTXivyYyc
         Wong==
X-Gm-Message-State: ACrzQf1HL654sKYyaZrPgrTja/sXFOpd+FeovO3r2+LnoWLMEZpExWYa
        weRxI/H2R6h7HPohzGCjadN13xemfgV0L+sSFIwUKE0koj8j9A==
X-Google-Smtp-Source: AMsMyM47C/W//pbYN9XHD/8AgupW37GLhxtaxEg3Ur328HOcJJSxI2I0Cy43WnB1mvCU8mGcizCypvp0rpeIZ0hX0H8=
X-Received: by 2002:a17:902:c40b:b0:17f:9636:9014 with SMTP id
 k11-20020a170902c40b00b0017f96369014mr3844618plk.150.1665857410399; Sat, 15
 Oct 2022 11:10:10 -0700 (PDT)
MIME-Version: 1.0
From:   Rupinderjeet Singh <rupinderjeet47@gmail.com>
Date:   Sat, 15 Oct 2022 23:39:34 +0530
Message-ID: <CAAheMRzYX6PdWMtcB=px_kD=-gnGGHvDgvR6Jxy94JH2DpYpJw@mail.gmail.com>
Subject: [suggestion] Fail cherry-pick if it overwrites untracked files with
 the matching file names
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

I have filled a bug-report and it is available at
https://github.com/rupinderjeet/git-cherry-pick-removes-untracked-files

Since your email only receives plain-text, I assume I can't send the
report by uploading it in this email. If there's something I can do
from my end, or if you need some more information, please let me know.

From,
Rupinderjeet Singh Hans.
