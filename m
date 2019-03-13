Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4C620248
	for <e@80x24.org>; Wed, 13 Mar 2019 18:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfCMS2J (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 14:28:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38359 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfCMS2H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 14:28:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so3115452wrm.5
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=STD/M3JSOnWm4PTl3m7wULjwzIdQGJVvvThd46HF2qw=;
        b=hEBkV3JACtcRxy82WNUVo9e+4NQ+tp4h+bjv+zArN0lwh4y0jG4/WbIdumxPzJde82
         hqkR1PWFlua76GRBEstV2zZzeddfPk8dfTLU2aCUbQsFo/wM4caoajqJand3fepabYSh
         oQTMhlpaesl8AXZ7725PWzzZee4DBN0ejm3BWWHvYyV5phFE2M9L50pKk8rMpnu06kQi
         5TBn35IFMwWu4j0fTM8BqV0qJTAfW4jR7wP4aqT9ExSIG3TzqBvvUaw3KmcEphst3DR+
         bZ4J/PR3QWKYH7rMpRjRvU2TJFMKVghlSV3orA10RehZRtXSHXteLD4yniny6YSxzb7O
         s7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=STD/M3JSOnWm4PTl3m7wULjwzIdQGJVvvThd46HF2qw=;
        b=ULOsTuSsh6AROztnZcILUjJ4yvcOf4xdMhavxA+e/yMki1dljIUbvh9N0mtwc0Cs1V
         R52FJzpwKTO21VyntbmC2WggEyXGGput/F8fPMhaut5FO717Xh8phQ/aGgBC025sCncO
         6rWp3pkooJSGKhQqqzlYuIZUcv1+7nQQ+udDomYIZXwy5sR0p1IoG8FkS5G3KPgKvAuU
         m1AgNL/DwRJbc9Arb8uHAM7bZ98/FBGGofmrR6CCf+6pxrWnLzerl6Wq1Mid/XjO3cw6
         koEjG/2T3XfZVXfQEg6JJT06qyRSS33I/Bu+LoX2d7hpgBTSUQqxPA1SGjBmFVGNMtCS
         hR4Q==
X-Gm-Message-State: APjAAAXOpJmpBE5CamGtbxAtEA3xAtNxy4cxsC2JaDkiyQDW2CWYRjDh
        z8X9Uz9JOlgP0wQ0+S8H09YJdfFkQ8WDyA==
X-Google-Smtp-Source: APXvYqxnAP+Y8k9UrhDRFmoqChxXzY7G77JPPpcxaV1o12NeuLgBmjkxVLyh2fr+9EthJ4i0rJsLGw==
X-Received: by 2002:adf:efc8:: with SMTP id i8mr30173164wrp.164.1552501685667;
        Wed, 13 Mar 2019 11:28:05 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-186-210.as13285.net. [89.242.186.210])
        by smtp.gmail.com with ESMTPSA id b3sm2793929wmj.15.2019.03.13.11.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:28:05 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/4] cherry-pick/revert: document --rerere-autoupdate
Date:   Wed, 13 Mar 2019 18:27:54 +0000
Message-Id: <20190313182756.8076-2-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313182756.8076-1-phillip.wood123@gmail.com>
References: <20190313182756.8076-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This option was missing from the man pages.
---
 Documentation/git-cherry-pick.txt | 5 +++++
 Documentation/git-revert.txt      | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index b8cfeec67e..d64e72462f 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -148,6 +148,11 @@ effect to your index in a row.
 	Pass the merge strategy-specific option through to the
 	merge strategy.  See linkgit:git-merge[1] for details.
 
+--rerere-autoupdate::
+--no-rerere-autoupdate::
+	Allow the rerere mechanism to update the index with the
+	result of auto-conflict resolution if possible.
+
 SEQUENCER SUBCOMMANDS
 ---------------------
 include::sequencer.txt[]
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 837707a8fd..6afccb2f1e 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -101,6 +101,11 @@ effect to your index in a row.
 	Pass the merge strategy-specific option through to the
 	merge strategy.  See linkgit:git-merge[1] for details.
 
+--rerere-autoupdate::
+--no-rerere-autoupdate::
+	Allow the rerere mechanism to update the index with the
+	result of auto-conflict resolution if possible.
+
 SEQUENCER SUBCOMMANDS
 ---------------------
 include::sequencer.txt[]
-- 
2.21.0

