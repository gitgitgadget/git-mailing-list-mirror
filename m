Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5AAC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 05:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiBXFsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 00:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiBXFsB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 00:48:01 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A22A156C7A
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 21:47:33 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id bx5so1071993pjb.3
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 21:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AkbchjDHPkWzS6LLctdAJIRZx+cpqTHvh+Sw6PI2fzE=;
        b=gkGJktsPdjdODwxfy8XaTxQS/iK6cenU9ufr3VYeVNG1CjXw0gvv5FaxcvmLVcQhOM
         EWkb8XGPO7+Dcje3m7aLZzQuBuxHyKYXs/10YZxsd77sIgyDqd1fUdFd51jRvTgXBWHj
         Fc+Y2PSBbFnDH5J9BoKW8pk6VPfxqAEiVr7iNZ7FHu1BIiXLyzCQBoqZTC9ISidaJ7Hj
         ywA3lKJeLv9PP3DHeNkyRDX92t65FeUMtkxjSPJJgnneJcHMUth1y2f5+FVL8HBwgruF
         n8dx6rEyBvDOzwSnDV+8JoTFXcQE3adODFOGmK1NR64EQQ+AI4KubnZBSfAzJWFpsi0B
         +BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AkbchjDHPkWzS6LLctdAJIRZx+cpqTHvh+Sw6PI2fzE=;
        b=WSG1JAFgu3+CZF37psSi+X7mqGOmfOBkY3qUDt4h1TofUpPVwn8HFSi+zkY/fzt86P
         tRxx3UFxsxKr4BPEDoOJckVWZRjK3KS70nMNj2Of9WhV9cNASkeDNyMsQfVWDAfCp52Y
         mP3BTOQqu4DDROP1GkLIBKHgWJvqFXX99G1E6Sd7Lal/RdTmoY0HlydpSIhL8KNIa5BK
         ZconDWihhx2hdyYLiHk3IuY9ux4fWx5ndcDtky63qMhz+0aaRmghZXN1DsfZoyB67CSJ
         wggYKQq5OloL9u4XT8J9TaNBAisSuadGGvOtACw5qFCqxKbQ8icWrNG+etyCbXbmM5xm
         VLCg==
X-Gm-Message-State: AOAM531wT4hdd3MhADVHPrrxXrhljYIGDgAJaNugpaoRx2Xb660jhGc8
        psHm0tFIkT6NkzAesGCBNFqza2tphrVP8Jo/E+E=
X-Google-Smtp-Source: ABdhPJxGKswBfxyLXJJuHcT1J6FjcSrhkTke5HrZdFSXSisTlPhOKWIepzT01202HdTrbfcN8H8bYw==
X-Received: by 2002:a17:902:d2ca:b0:14f:cf98:54f6 with SMTP id n10-20020a170902d2ca00b0014fcf9854f6mr1024663plc.34.1645681652318;
        Wed, 23 Feb 2022 21:47:32 -0800 (PST)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.99])
        by smtp.gmail.com with ESMTPSA id f12sm1497817pfv.106.2022.02.23.21.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 21:47:31 -0800 (PST)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, Shubham Mishra <shivam828787@gmail.com>
Subject: [PATCH 0/2] Subject: [PATCH 0/2] [GSoC][PATCH 0/2] t0000-t0050: avoid pipes with Git on LHS
Date:   Thu, 24 Feb 2022 11:17:18 +0530
Message-Id: <20220224054720.23996-1-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a microproject, I remove all pipes with GIT on LHS from
files t0000 to t0050.

Shubham Mishra (2):
  t0001-t0028: avoid pipes with Git on LHS
  t0030-t0050: avoid pipes with Git on LHS

 t/t0000-basic.sh            | 10 +++--
 t/t0022-crlf-rename.sh      |  4 +-
 t/t0025-crlf-renormalize.sh |  4 +-
 t/t0027-auto-crlf.sh        | 12 +++---
 t/t0030-stripspace.sh       | 81 ++++++++++++++++++++++++-------------
 t/t0050-filesystem.sh       |  3 +-
 6 files changed, 72 insertions(+), 42 deletions(-)


base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
-- 
2.25.1

