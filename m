Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9FAF1F42D
	for <e@80x24.org>; Thu, 24 May 2018 19:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161221AbeEXTfi (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 15:35:38 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41314 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161213AbeEXTfd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 15:35:33 -0400
Received: by mail-wr0-f193.google.com with SMTP id u12-v6so5139890wrn.8
        for <git@vger.kernel.org>; Thu, 24 May 2018 12:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NBlrmzgclq+NpUsjWnJyxe6trwLGceFG3yoh36BC+94=;
        b=JHhyITx3CdOb51P/QphY+yVq57OEqBtXUK2A06r6h+l3VkoD0LbkNFwXVOMqR6qSPs
         i5wLVXoZO1d+9cws4Td3ANo0hR2OvT9dj2Lwd0WASVVRZJsAocQ55pyeGsmFlwqdil1B
         Cc10VbBozV/1bKVBazwyRl2pRXI2M5fJGN/DhSikSZgxXGS+8LCBLQC++ggT11MxEO7g
         xDJmKxtQEqNrae4JKfO/w0zARo8cRC1miYkBZ6HBxXhI+Sfj/ASj20c2cwhurECGfEK5
         QkLsi0GgtU0kEdrdN7s7p0825nrAsEhdg7jq+3sieIAMcUOIxgnFB1ZLm/EXY0JunJ/p
         MUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NBlrmzgclq+NpUsjWnJyxe6trwLGceFG3yoh36BC+94=;
        b=pp/r4CyPHIZNcZsCU5oKd2FdO3XYTZqQWN6458K2yoy4oICo30h1LYK2kl2AD+NOD9
         7c1fR8LH256ocmehcOLoSa9tqnCrvTX9UiFnYrG+Fy7uH4qc24kZefDo+KWQOVdTMpvL
         HiFt07e9r92UbVjaJbm9frCC5Gk4C5UIB+KktmXS9yCASGxXgQObvTZAqyuOEdPiwSf/
         7dEurLp4JvyPyo+j/2mr4Er3yH3nPJxv0F1Ivs912+mb/gFb7KSjf+1KA4PW6G/fWgWG
         Z9BtuPnWhWyQtdNvoPxGoZODAm35/VYrggqd61FjbMjZzes5/IaRx+RbrNzw10F9o+sa
         8BAA==
X-Gm-Message-State: ALKqPwcTr3fuZBnhRBhzIG/cf3Vsv2C6ULjsr8Bg1tg+QQXolt+b8GdB
        eNGBmXnG2wCr3zGoXyt6Vg029RUk
X-Google-Smtp-Source: AB8JxZrBHrBsqYL7/XnrYr7TWZkBvwOwfX36UTzmLOZ51rAusxWtIDaCLiXYF1KI8auk9W8vOeYN9g==
X-Received: by 2002:adf:b201:: with SMTP id u1-v6mr8269848wra.2.1527190531379;
        Thu, 24 May 2018 12:35:31 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 136-v6sm7056887wmo.12.2018.05.24.12.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 May 2018 12:35:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] config doc: elaborate on what transfer.fsckObjects does
Date:   Thu, 24 May 2018 19:35:15 +0000
Message-Id: <20180524193516.28713-4-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180524193516.28713-1-avarab@gmail.com>
References: <20180524193516.28713-1-avarab@gmail.com>
In-Reply-To: <20180524190214.GA21354@sigill.intra.peff.net>
References: <20180524190214.GA21354@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing documentation led the user to believe that all we were
doing were basic readability sanity checks, but that hasn't been true
for a very long time. Update the description to match reality, and
note the caveat that there's a quarantine for accepting pushes, but
not for fetching.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 351c541ab8..124f7a187c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3339,9 +3339,19 @@ transfer.fsckObjects::
 	not set, the value of this variable is used instead.
 	Defaults to false.
 +
-When set, the fetch or receive will abort in the case of a malformed
-object or a broken link. The result of an abort are only dangling
-objects.
+When set, the fetch receive will abort in the case of a malformed
+object or a link to a nonexisting object. In addition, various other
+issues are checked for, including legacy issues (see `fsck.<msg-id>`),
+and potential security issues like there being a `.GIT` directory (see
+the release notes for v2.2.1 for details). Other sanity and security
+checks may be added in future releases.
++
+On the receiving side failing fsckObjects will make those objects
+unreachable, see "QUARANTINE ENVIRONMENT" in
+linkgit:git-receive-pack[1]. On the fetch side the malformed objects
+will instead be left unreferenced in the repository. That's considered
+a bug, and hopefully future git release will implement a quarantine
+for the "fetch" side as well.
 
 transfer.hideRefs::
 	String(s) `receive-pack` and `upload-pack` use to decide which
-- 
2.17.0.290.gded63e768a

