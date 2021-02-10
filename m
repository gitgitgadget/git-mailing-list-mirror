Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5380C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 19:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9366E64ED0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 19:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhBJTuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 14:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhBJTtt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 14:49:49 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA44C061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 11:49:08 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id c16so2993800otp.0
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 11:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=i58/7gt6f6tHmMcex+VVvRFhK0NeiOe4VNFXHz0804E=;
        b=GNLNpvES6ZnmlWt2rwbI69ZObUmcmuEw9zaReu6TZCkxdEJEsmGAtxThXunRzaHIiw
         VCAviYp3IHX0Udlph9Gw6fbwR7NA+x9+19hVBkhHGBuwEALrxaQNGFJQxUoBtDvkHk5w
         YU0xWWA+yFgf/QHza9kxnydwBHeGPMZuAuUNo4YUM3rPSAxobSn6awt+CGsIG5gAMI18
         DBemJOEnXRjYBqJXkB1wsSrgIO543WiMxqMYTHgom/sKGOyS2Xf1YRX+dVA4pMlrnkCs
         AeYGzr6RqhMBFD8+iomxDcU97ttqGDrLVTj+IXl91G8TxzahiklgFoIyDACH4uDuYvsF
         vOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=i58/7gt6f6tHmMcex+VVvRFhK0NeiOe4VNFXHz0804E=;
        b=tGodYhF6/zxGp1cDp3qeuGwwwYD78SfSx85gnRgRVy7hyCDUudhh6ZEDSQebvbVHOE
         Mmiz/GtflsLQmbq2Ehbpc8s2YH2qIwl+K7vudqAgRN06gVkpxVHx3XwUysIO/cdlfo4k
         VVoKOOHBAtohN0S+Tq7ihcCbIyoVcyG9BjgNfVYUBA8eYXb7hI9//y64raYN6ckeSDbQ
         ViMHQi2XKbY8vMZ21gUAG17aT504EANb7zGexwC9GcA0K4NDXYFin46TVraCx3vkLoNp
         32bvhabd/5o6NQOx0fAv5434xaQwuXlq1QfitDVlaGNKqQ5oZHarVrgF3jlko9k+mxAD
         j0FA==
X-Gm-Message-State: AOAM533u1IWNXaEfw+8zGS6rLIr96dNckVLljdfSx+QjWdp+Xy23ZJ5X
        dxU8mtgxjFAAlSy3JJbkj9uV5oknPXcU3jW8nOkF46cx41ARLQ==
X-Google-Smtp-Source: ABdhPJzDN2BJmX+t+c/DxytUG1Bnr0oBvtGixE8ReBjgA6uBA9lVT/fgqTLQL9zO0KpUGFBnrRPwL8rU0IPLrFl3cto=
X-Received: by 2002:a9d:7550:: with SMTP id b16mr3443872otl.184.1612986548259;
 Wed, 10 Feb 2021 11:49:08 -0800 (PST)
MIME-Version: 1.0
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 11 Feb 2021 01:18:57 +0530
Message-ID: <CAPSFM5fYNEFBVx4+wVSHt4MeX6cC1xPzrMmO=QXKa_XvEAkKFw@mail.gmail.com>
Subject: [Outreachy] Project blog -8
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone !

Here is the next blog post regarding updates on the project :
https://charvi-077.github.io/week9-progress/

I appreciate any suggestions and feedback.

Thanks and Regards,
Charvi
