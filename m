Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAE2720248
	for <e@80x24.org>; Wed, 13 Mar 2019 18:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfCMS2G (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 14:28:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54402 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfCMS2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 14:28:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id f3so300719wmj.4
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=yGz8xgUm1upLYrXRzPc4Egi4CooHjTNtDywq++chZfI=;
        b=R3dEMwy3XwDfP+5LAYTL1E68O5X3e82bQpxcpYFHb6YMpXC0YLwPDMRX9+6eLRD7s5
         90DztsQCmjB0lZxFdt0240uEZ+xL9P/L2PCm0II1JVRI2L9p4tT6QZGq/Y0vzAJzJ/6C
         KRlEBqqxhgx5xEiItZhJ8WT5lrxo7ccdeJJgtBwu/hB5N+q2lp3fAh3JSiuBo9r2EuZN
         ORv6bC1cqZfDsU8DobTrNNYne0qM2tiSCfhJ3tR39IFzu62fJK6S5jhiO8QEuyCk2QD+
         bBn013qYYg7DgnCVjNH0cLeUeo0UpyPQwO/tp8KhknIelBGWgcxvGB93j0sBDLt2X7p4
         +pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=yGz8xgUm1upLYrXRzPc4Egi4CooHjTNtDywq++chZfI=;
        b=DoTlkRTQVANS6wr0KBDOmby5Y4EsCccsOR15Y0ZDF5z6b7YT8cxnnXWw8QW2duo316
         rtWqnMlNu0h+3IHu15IAc2DJaSfJA/ZOFoOO34w4KRiV+eSsCtGqjA+x9xuOQXzKLYwE
         xQZT1/N5h779Dj1ukmgInhp1xSxOqVCUrO7AEmMTAk4IMGGLVrqIdQhF9Kw6HJOPoxuq
         lhD5fc8RXGYmyYWJeAY0Ueapvmj29/Gp96C+95boFA5z6ZzSjp9p09q5vv6wJrPqf+q8
         R2VS0PQgFikSS9NbpyvR3ld0w3pr9CUTblUdjIxabl3Vdi0SCqSJva8tJxYwRkDGyhRA
         ZmVA==
X-Gm-Message-State: APjAAAVHloBjch0tWMXR9FcvhFdYfdhl7Oo6TEq+CEJZcfqkdiGEG7I/
        LyztPZ3gXCZ/5G/o5zBLgqW17Sl0h8gs5g==
X-Google-Smtp-Source: APXvYqw6HsEMCHxDEKOZFva3/RauAhQOyZogYkvHfkZlGQmnTkS7lbetQYNG4MZfnEBVvgZR8j6FnA==
X-Received: by 2002:a1c:f707:: with SMTP id v7mr3228630wmh.109.1552501684382;
        Wed, 13 Mar 2019 11:28:04 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-186-210.as13285.net. [89.242.186.210])
        by smtp.gmail.com with ESMTPSA id b3sm2793929wmj.15.2019.03.13.11.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:28:03 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/4] rebase: document --rerere-autoupdate
Date:   Wed, 13 Mar 2019 18:27:53 +0000
Message-Id: <20190313182756.8076-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This option was missing from the man page.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-rebase.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 5629ba4c5d..fbf9a4d70a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -300,6 +300,11 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
+--rerere-autoupdate::
+--no-rerere-autoupdate::
+	Allow the rerere mechanism to update the index with the
+	result of auto-conflict resolution if possible.
+
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
 	GPG-sign commits. The `keyid` argument is optional and
-- 
2.21.0

