Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C673C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiBXQZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiBXQZn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:25:43 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15EE270273
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:25:03 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id m13-20020a7bca4d000000b00380e379bae2so111343wml.3
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qyckDC2D1Ts3yDr7xc7EKizmpKG9HeGjHuIw+CykXEM=;
        b=SdpiMZJnTUkdMUsFOjINSex2bCSPZ9PtCN+Npqz7saihxbkUQt2uuPDzmsitK4zBNO
         jwdjrI2/wsJRDIOaRg0UYtwjsws1GU2oJwYwVj1qM7iTnwEqFdxJZ0wwWg4FfhSyjq20
         /UipAueo01kAXApfgvxtADAnSa+jrvPUTDQVpfPvV4BozmBrZ/8Hh+hVm6LFKuu0HmmK
         B8uXDMlPBDy90aalVVSORD1JYt0QAU5XUHqbw0Jk6NjQ+wpfeMf7T9HN2OLoiviK9soL
         3msyF4DODTAUOWsTsXDLy6ZCpiRnCdXKQRddKNIse9nVH3TZGUvge1b4XCYmokK6Y5pj
         412A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qyckDC2D1Ts3yDr7xc7EKizmpKG9HeGjHuIw+CykXEM=;
        b=QY5VfeHnd+X7iVNVFpqZJvIrLUHMNw7ZNSvgILjyWhUj08KFYPYSxUIB1wW/jKIzoK
         1yTjriveCBGxILeruXVfMXkN7E2MbC4FbDFSdGi/P1DRpqi9PNuJQ4LqgocIJRLmgHIM
         DVHnucLZzKy+ssiPfzW3ILtHB/CrWeUJUVRDKCyGYm5mNyZfKajJJYI8/Fsgkd9QV3tw
         KBjdSU9J5MMzRYOJPhxR9oLl096OtShBGOmyUv6ArhPY0lFlt1c+qLhp80niSc0t0z3q
         Xu1xhVf8NTUSnAEoNO6Ht1l08e1ksKYZ3L5Wy3qfqfTJLY3H8lBppjLWQqafMiAB5ixG
         QoPg==
X-Gm-Message-State: AOAM5314FFHp1VOD4ZPKlOcO5w0O20WVwzge0zjpgwSaWfKDSiJo6ERV
        ZkB4SZ3ppDHsB2FZPHqsO9bfwPvGORI=
X-Google-Smtp-Source: ABdhPJzVsaeksPXT48tzaK6lAKQG6+NkKDjwLrCZZqvUMUA7YI+RyPdTY2UCt2MnZHpZ+M1r3MjtDA==
X-Received: by 2002:a05:600c:3d88:b0:380:f6d9:9461 with SMTP id bi8-20020a05600c3d8800b00380f6d99461mr6819068wmb.137.1645719227333;
        Thu, 24 Feb 2022 08:13:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3sm3787758wmp.42.2022.02.24.08.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:13:46 -0800 (PST)
Message-Id: <20942562a66bd1dcc6966a1d9150cff9a9ad11e3.1645719219.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
        <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 16:13:38 +0000
Subject: [PATCH v2 8/8] doc/partial-clone: mention --repair fetch option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Document it for partial clones as a means to refetch with a new filter.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 Documentation/technical/partial-clone.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index a0dd7c66f24..268939f781d 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -181,6 +181,9 @@ Fetching Missing Objects
   currently fetches all objects referred to by the requested objects, even
   though they are not necessary.
 
+- Fetching with `--repair` will request a complete new filtered packfile from
+  the remote, which can be used to change a filter without needing to
+  dynamically fetch missing objects.
 
 Using many promisor remotes
 ---------------------------
-- 
gitgitgadget
