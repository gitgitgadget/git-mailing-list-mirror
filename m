Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AA9C46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 23:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbjAKXcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 18:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjAKXct (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 18:32:49 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABC73632F
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 15:32:47 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r2so16536343wrv.7
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 15:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k7N7ohS0gxiDug/lRh3vyxraxcvAVKVNR9vUKBU/AA=;
        b=TsQy8ItNABDA7hgG3R5INGtAU5h1LjoJfVH1XRDfKHU/wQ8H0ZgEoSHGvWzZu77GbC
         hCqIY95mBFus7JgHaA7lUwwRzD0QMMGPMn2pRA3FRheClN/YccpzxoEwk007F+DHcriz
         g+Clg9ya6HlyU1bVHN+9M8EO0PgyX/DOo1vbEcWeFifUyqexuxsl11nh8pkTc46sDuOC
         OPC6NCpX7aeGoq/SriHrPLxb3Qs51mtwIWhRrmPK9sUj5N8bQ16x3ufXZ+pyBWfOE+0X
         Uxe9eL4gX15j/sisoDANGnTvRU9CKj/U0c7xL9xx/9IeMAJASxC730n+FRaDrudX4EeB
         TsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0k7N7ohS0gxiDug/lRh3vyxraxcvAVKVNR9vUKBU/AA=;
        b=LC6UIqenT/+PAMNNgjkZUE6YdnaO4FZIQyEP+YPw3VbQzlfaO5q2IWxvegTXkQJNWd
         WHtNyxkuHUuA+y13Ts8DEikxMBGQcKIJJk3BaFgQf7CPyMnfs0zrLidFbUv2Pl1yy4ZQ
         CC4vSFVVWCEr2aJQDNEaTGW8sFn4X7mog1HMD2jnolCNh9si/3Q2cLnFOEzWTSnrRgPW
         mDyy0NbjTjJjmWBN5va0c1ykt2TyJiRxLlATVjupauSWFeJiL+KLzKyHq/+aRtRQQIuU
         r2MAx7iYVKcvZYGTwvHsEKYgATj2UToAMaCk9qc/CkXVjoU//imXT/J+63DCukXmYQ6g
         tu6g==
X-Gm-Message-State: AFqh2kolyOQRmN3fUbtT1vqkCBN8rcHNetF8Lq4xSKVHoQqf6sKuoFJh
        Ybl34JmAzSmKoZfjv1zYLtRLcfv1H2imwDYZ+Dw=
X-Google-Smtp-Source: AMrXdXsWcdKN2JlYiiCLFTEdpsq49f0SABxQ4vG6DeNEbbfm8JUToOfv2JAsRMf4Sjnjz1Svm7IGbA==
X-Received: by 2002:a05:6000:1e11:b0:2bb:366b:d5e1 with SMTP id bj17-20020a0560001e1100b002bb366bd5e1mr16066247wrb.30.1673479965927;
        Wed, 11 Jan 2023 15:32:45 -0800 (PST)
Received: from titov.fritz.box ([212.102.57.19])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm7679308wrw.29.2023.01.11.15.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 15:32:45 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v1 1/3] t6003: uncomment test '--max-age=c3, --topo-order'
Date:   Thu, 12 Jan 2023 00:32:40 +0100
Message-Id: <20230111233242.16870-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111233242.16870-1-rybak.a.v@gmail.com>
References: <20230111233242.16870-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test '--max-age=c3, --topo-order' in t6003-rev-list-topo-order.sh has
been commented out as failing since its introduction in [1].  However,
the test is successful at least since commit [2] -- bisecting further is
harder because of incompatibility of such old Git code with modern
header file <openssl/bn.h> [3].

Uncomment this test to gain test coverage.

[1] f573571a21 ([PATCH] Add t/t6003 with some --topo-order tests,
    2005-07-07)
[2] 765ac8ec46 (Rip out merge-order and make "git log <paths>..." work
    again., 2006-02-28)
[3] BIGNUM used in git's `epoch.c` which was removed in [2] changed
    significantly between OpenSSL 1.0.2 and OpenSSL 1.1.0
    See also https://stackoverflow.com/a/42295243/1083697 and
    https://lore.kernel.org/git/Y71qiCs+oAS2OegH@coredump.intra.peff.net/

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t6003-rev-list-topo-order.sh | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
index 1f7d7dd20c..5cf2cee74d 100755
--- a/t/t6003-rev-list-topo-order.sh
+++ b/t/t6003-rev-list-topo-order.sh
@@ -326,19 +326,16 @@ a2
 c3
 EOF
 
-#
-# this test fails on --topo-order - a fix is required
-#
-#test_output_expect_success '--max-age=c3, --topo-order' "git rev-list --topo-order --max-age=$(commit_date c3) l5" <<EOF
-#l5
-#l4
-#l3
-#a4
-#c3
-#b4
-#a3
-#a2
-#EOF
+test_output_expect_success '--max-age=c3, --topo-order' "git rev-list --topo-order --max-age=$(commit_date c3) l5" <<EOF
+l5
+l4
+l3
+a4
+c3
+b4
+a3
+a2
+EOF
 
 test_output_expect_success 'one specified head reachable from another a4, c3, --topo-order' "list_duplicates git rev-list --topo-order a4 c3" <<EOF
 EOF
-- 
2.39.0

