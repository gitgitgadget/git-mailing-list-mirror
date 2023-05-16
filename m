Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D88AC77B7D
	for <git@archiver.kernel.org>; Tue, 16 May 2023 00:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343586AbjEPACx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 20:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245306AbjEPACp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 20:02:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FE88A62
        for <git@vger.kernel.org>; Mon, 15 May 2023 17:02:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54c2999fdc7so255740567b3.2
        for <git@vger.kernel.org>; Mon, 15 May 2023 17:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684195363; x=1686787363;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G6ugncrH1zPzI5hTq36DY4Enju/K+x5EoEuq8Jcvhyo=;
        b=TefBRo/ZcrG1LwIX1Mg5+954Fy2fJCr+DK6DypfFoTKb3IUFlJV6AnHcVeqnTBpr5M
         eiBTrBomhXVAyutcv0i+/TA1ToYrnMM3oyiTC8zJOHXRLhugeyPKqhiN7BFv3LKuo3mI
         QvD6jttf2Hsf8wSaVmsUsQS/0yUx7kYczWqwlgvjP/Cs6WxIaK8ed7dZAAud3RmcYPeN
         LCgPv687bgRNGMYYWtLkoGa9p4O3FzAKbPuBNJNJ2gGGYYeOL0qgkOUbXHd6yw28ZKq5
         q+zUW8TzoTMFkwCf6G2+uK1AB7QwMHFOj8iX9wnsgE3mUM0y/IbUZBikCJF9WuF3Q10T
         cLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684195363; x=1686787363;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6ugncrH1zPzI5hTq36DY4Enju/K+x5EoEuq8Jcvhyo=;
        b=jr9TxRTtJ3zZfkm5d0vZWwwGVMkOa1ITW7fT1WxKgRXx3kJR4s5kzgX0BySvU9Nb2g
         rQl/DTm5YjA6Enp91pVCqwnp22EIdPSEhw/zogbIEihWsOL/X6gzahk8b0f+oIYmLEB8
         YJ2AsM8cgXemrcwm3QycUwGTdUftW7svk+R/Zi/YXmwRxcZA1OliUwF1fOPX+BNBlnat
         E5FkAwCgTaiAEZUjycMqNzwQqdi1H0VKQ3etqPyxJA6nv10dfhvFchGz0bS70FHR7qeL
         nX1vW1E/27DxRtq0QWLqdS4AUDtcAeeb3D53b9OIId4cNsps3LnFoUUyGe0c4w4S4C0H
         Ahuw==
X-Gm-Message-State: AC+VfDzdZOM4bd+ceBhskY6tUkAasE7woCVPBPhUklQkZUCspTI5jLQb
        W14ZeEy/J2X7j8aMwyWGGk/xxChmw0bFkgBBsi2Z
X-Google-Smtp-Source: ACHHUZ4Ng+DyoEzUcHDI6OIeLXFI2mWg10SxXiOmVSt+TGiUtivUh8K2QaVeAj758sL1CU6KBppiFvnCScgExGc7yM7f
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:3aab:56bd:1f4b:d239])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b61d:0:b0:561:8c16:2b65 with
 SMTP id u29-20020a81b61d000000b005618c162b65mr184474ywh.3.1684195362994; Mon,
 15 May 2023 17:02:42 -0700 (PDT)
Date:   Mon, 15 May 2023 17:02:41 -0700
In-Reply-To: <8f021be54e0795f56ab67e1d269abfcdac587f9c.1683875071.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516000241.1459276-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 17/27] cache.h: remove this no-longer-used header
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Elijah Newren <newren@gmail.com>
> 
> Since this header showed up in some places besides just #include
> statements, update/clean-up/remove those other places as well.
> 
> Note that compat/fsmonitor/fsm-path-utils-darwin.c previously got
> away with violating the rule that all files must start with an include
> of git-compat-util.h (or a short-list of alternate headers that happen
> to include it first).  This change exposed the violation and caused it
> to stop building correctly; fix it by having it include
> git-compat-util.h first, as per policy.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>

Ah, a monumental effort indeed (to finally remove cache.h). This patch
was one of a few called out in the cover letter [1] as needing reviewer
focus, but this patch seemed straightforward to me (changing the text
wherever cache.h is mentioned in relatively obvious ways) so hopefully
I'm not missing anything.
 
