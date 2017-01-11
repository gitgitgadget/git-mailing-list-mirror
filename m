Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EB6720756
	for <e@80x24.org>; Wed, 11 Jan 2017 01:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756043AbdAKB5u (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 20:57:50 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34881 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754840AbdAKB5t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 20:57:49 -0500
Received: by mail-qk0-f172.google.com with SMTP id u25so578618264qki.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 17:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lFlEBY9M3+vK8dS/VGBGtb1NQCEYqOvkcvWpXL2SaOU=;
        b=aTBDgsliOnZ3LvcgGkblC94L+7e+WiVN35N6miHaJMzsiTNranjTgp7d4XhMc5xYn1
         9uz8tczKIyzi7aRDrVIetVpRNP3BjHVr3OKWqQ8W5JF9sjPV3jBGKK1Omryi0n8gmkCy
         yCnznPwbactV+2fU3NMjJd/PlbJMuMPIrSg7dxw9YNUv/QJGsycguPwBrEyVaC1mkb+Q
         nmpH3HHKcGtS+zvP0mifL3QEetVXoHJEJwFYM0gdFxZtoSYgIczz5ju6Q09Hd/qWKg4H
         NmkW339YU3UfrqlpNwDg5LcT/HchUWe3aSYI8YGXti8Vh04e5kxz3qsqgImCN4X1kWcK
         mKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lFlEBY9M3+vK8dS/VGBGtb1NQCEYqOvkcvWpXL2SaOU=;
        b=OJ1RuhR/JbDlxndXJ+WJks4CRSIbtZZ/MP3DOvf9DV0f30rvgNNx+WEITJLNiIeGNj
         31BsNuDZogTeZgAcsgYP21CFhPPTU4R1nLObGyHyWQCSCShcu7ViOGS3KGS63F2bW1Km
         k/ARNLgY/2SMpi3uo25eUMp6c4mH9Q5Xrz4OcQiLR80V9PvTyVr9ZsVBzbD91RXkh12J
         XlB9toJnvSKAHdbClbWVp4iE5SzitIoCv32sD1wmiEIWOGCBc7v4xOXh33M7u4iW/GWU
         QE7G1JhHrLwfmRHWitdGnENleTxhEgqCNzO2ElazkEYURzuwvjheEusNgZbhCdfUdVW7
         k45w==
X-Gm-Message-State: AIkVDXJs54IsA6SH/eYM7OnwwAcsWtLMaQsN+KGqXWi/BKyqqtxaYZyZbbvsJ2J5Sa/+uS2y
X-Received: by 10.55.73.216 with SMTP id w207mr6243736qka.295.1484099868339;
        Tue, 10 Jan 2017 17:57:48 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id d15sm2938570qtg.22.2017.01.10.17.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 17:57:47 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 1/2] diff: document behavior of relative diff.orderFile
Date:   Tue, 10 Jan 2017 20:57:19 -0500
Message-Id: <20170111015720.111223-2-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170111015720.111223-1-hansenr@google.com>
References: <20170110004031.57985-1-hansenr@google.com>
 <20170111015720.111223-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document that a relative pathname for diff.orderFile is interpreted as
relative to the top-level work directory.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 Documentation/diff-config.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 58f4bd6af..875212045 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -101,6 +101,8 @@ diff.noprefix::
 diff.orderFile::
 	File indicating how to order files within a diff, using
 	one shell glob pattern per line.
+	If `diff.orderFile` is a relative pathname, it is treated as
+	relative to the top of the work tree.
 	Can be overridden by the '-O' option to linkgit:git-diff[1].
 
 diff.renameLimit::
-- 
2.11.0.390.gc69c2f50cf-goog

