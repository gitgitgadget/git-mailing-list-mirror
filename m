Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B64F1F89C
	for <e@80x24.org>; Sun, 15 Jan 2017 22:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbdAOWRG (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 17:17:06 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33701 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdAOWRF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 17:17:05 -0500
Received: by mail-qk0-f171.google.com with SMTP id s140so103563123qke.0
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 14:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y4Na0a3i/9u/tQLQzA2/T7hNvFSLtDLE7i1m03579Lw=;
        b=H2/hmwIDvlTs957Q07NxvtZlp4sstb3xttSthcZS6CyCcq30h0FM3wb3k0EUG4U+kD
         c6D4MEn214QQi512u+oPOeOUo1phLEYPkxHGg38b2IQOBdC6+Wff6NiC46bObM0VkKra
         A4+nbyWHPCMyPbocFDgY6yenTrMrk23rIBlJFx8m81K4fTG9GbyjWQjPEeLNdqWiaqOA
         Idlc/qmafRFP6I6PTAbyf08baHOZv1yhELIKiGBtnklNUYSvy/5zNLbSt8wUvl66d2Ka
         KqSIFTe0pn4LyIOq9f3bnKFXM6fqSvymlEGmlDB1W9An7RC+boBAaPoDX7kCVS1ZzZjw
         F2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y4Na0a3i/9u/tQLQzA2/T7hNvFSLtDLE7i1m03579Lw=;
        b=cVGO3ui9ffqDZVZKs4kIqXnz/UdZJ2iu/FZ3iCguuXuivJJvCtmx31LmfKEfBYCOgU
         DIfdbmjiOaHQFMrJ2D8yGq53mOeAlHjip7cB3oKLb/SqPKx4xv5zJ7Scb1zxq1geuFfr
         FhzWTQ4JCXmOmnHvVvcdDhuEug8ouuqnrdHy4hWU9c/jIIffF4XfqH7bwCc8XnVKmwwe
         QQaSYlCTJ8c42yLFgXzI2qn8p/yjU4JvvCwXBOCpdbC9JSSql41dtzyX/4plYlVCfoxd
         mDevknQgGRac+4XQFkNq3zgnMlXuPEXEkT0Vl2INGsJWFWw2xl+lQsLZhluE9xv6jYZE
         ESwg==
X-Gm-Message-State: AIkVDXLs1OQESvSqKEgBaB5XND5e6Goz+7MveV46T5W3m3TOywei44a19ZvnzQ5Rj0C8KiQb
X-Received: by 10.55.18.76 with SMTP id c73mr27264678qkh.119.1484518623852;
        Sun, 15 Jan 2017 14:17:03 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id o7sm1374511qte.30.2017.01.15.14.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Jan 2017 14:17:03 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v3 1/2] diff: document behavior of relative diff.orderFile
Date:   Sun, 15 Jan 2017 17:16:30 -0500
Message-Id: <20170115221631.78838-2-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170115221631.78838-1-hansenr@google.com>
References: <20170111015720.111223-1-hansenr@google.com>
 <20170115221631.78838-1-hansenr@google.com>
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
2.11.0.483.g087da7b7c-goog

