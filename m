Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9176C43219
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 13:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241489AbiBQNzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:55:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241126AbiBQNzn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 08:55:43 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF2F2731CB
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:55:29 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k127-20020a1ca185000000b0037bc4be8713so6253147wme.3
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W5Yj2jthDENAX/pjHPe/3jF4bTw09ifuA6lPu72S2Y4=;
        b=d+zqP5JpXU3b2S6IZycsthQ/BsrBt9JgY8IkKb1IUPibVct2paNEpBowCALNNcP7p7
         n4hWXpH3lt/7Za9XAeFlZbk9qG0L7OyFzUjaqK5VLcwcojT9vZpfIbKUdYs/tm6Rslj5
         SaVHaARZcPIWQYyVG4kImDuv3C5axRJj2ZF7Lw1p+xWmtI9ACSKdXM57XTrCEbt8z0W4
         9To3j22Uzl4XffoZYrLp1ozmIBLeJbWwCujenPNfvQ7u/2rbV0khVcCa3BLdJLBRORfo
         Nd3Iejt+/vHWjGMJcy3Hk7yrgSzSXtWvO14j3qFOQjb4NBfnXbdJ19cK7D+3BUHNCzBW
         N3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W5Yj2jthDENAX/pjHPe/3jF4bTw09ifuA6lPu72S2Y4=;
        b=VCVH3U8KcM9HR6fQ9Iu4FYz+LkjwjaIBAEu4DjphEOvP8m1c+aLu4UtLE4fIQ7mZXp
         ijQNWbr0A8bE4VJKs1445iWWzuwV5zFc0FA8ZFw0yoMpzA2J5OzsR8WenCPHCdshLbrQ
         awqlVlS37eSiQEV2nPB129VWXDgY7Id9KkZZGehxtQtsTRFTa/gEe20SuDuDrr/alzvA
         DUQebLkEwWCuHVfnPnkxCnrK4SonZqJijVQZsbMQsXGnaFCL1/N2IuhT7k1xkmZm+fM2
         Q5Co1DAB63T4bo9VxVAUBJWww69MTzoOJxKzsSGcvYm5RoIWm0TcawRMWbiaPRpf2Auf
         RLdQ==
X-Gm-Message-State: AOAM5315e1ljGkk2o7vRjBal888eiJZt6WegCVj76HumDVVE8FtGsG8k
        HeB/9D+kepOqVbbdkMGDqSIGTBqxqMY=
X-Google-Smtp-Source: ABdhPJwnjhk8V/z8/s5GaMvdQ6htIrBbdfpseht4j5WjyGmVlGUwcXIVJlMUyqJjZeo53D3yW4xBLQ==
X-Received: by 2002:a05:600c:154f:b0:37d:f2e5:d89b with SMTP id f15-20020a05600c154f00b0037df2e5d89bmr2841261wmg.92.1645106126659;
        Thu, 17 Feb 2022 05:55:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16sm1314707wmc.25.2022.02.17.05.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 05:55:26 -0800 (PST)
Message-Id: <80d29e8f269bf0888d5b1db5f941d1a9bf89c86a.1645106124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
        <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 13:55:18 +0000
Subject: [PATCH v2 1/7] Documentation: object_id_len goes up to 31
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The value is stored in a 5-bit field, so we can't support more without
a format version upgrade.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Documentation/technical/reftable.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index d7c3b645cfb..6a67cc4174f 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -443,7 +443,7 @@ Obj block format
 Object blocks are optional. Writers may choose to omit object blocks,
 especially if readers will not use the object name to ref mapping.
 
-Object blocks use unique, abbreviated 2-32 object name keys, mapping to
+Object blocks use unique, abbreviated 2-31 byte object name keys, mapping to
 ref blocks containing references pointing to that object directly, or as
 the peeled value of an annotated tag. Like ref blocks, object blocks use
 the file's standard block size. The abbreviation length is available in
-- 
gitgitgadget

