Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C049203EA
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758566AbcLQO4y (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:54 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34613 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757113AbcLQO4M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:12 -0500
Received: by mail-wm0-f68.google.com with SMTP id g23so10603319wme.1
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nM100pZrGI49QkYS+GnyAtd0skz2HHOgOuMPXcmch7k=;
        b=JIkToc1/tLK0ZgW9puRkB7ki8C4PH+dChadvB4xmYbmGvoOuKzaEvnONyNvsHtmkv3
         MPQgSUlRL99KIBHmuh46czpb5m+0x3r24tkKy6xU7RI+r8WSXZAxfgcTe+54qdGJLGwV
         G9P/cz2wasp2a1qpQmZS4SGYFNIkzyq83e9azvvkcwx2ultrHnpQpxYOOtmAWW9eT+yb
         HwpR4JYmLSj+9PmyDSQTnbKEmU6/g51+FgjRl3d+ls5JXDy4q0A1Jaxx/Sdk/q7x+dQ6
         UZJRTyqDKxI6erh4eoiq+n+Bx3VQS2lJviBmpjDCcjqI4QoAHw5OjXkyQbGHyN3Dk4N9
         jyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nM100pZrGI49QkYS+GnyAtd0skz2HHOgOuMPXcmch7k=;
        b=qC9IGPbqpehCU4yPe2MnDlQEIqOnh+ZECRlXlkF005qUbc52vp87yY/DUvzWbNkSRd
         TCi9zIvHtoA/ZpelP+0D259OVcwf0vcCY5hg8alA0hdN3wRPZa+5IjntMMvWW1SdHZSS
         T9XEKrwuKsvBnSQ0ZnUZFN+YctVlCOxQw8jPVR2FIkNQHA3f4KS4IZgk5/m4P2fZHQvT
         QwYHme4yuUddC4snB/1/r1N0Jx6BcJSEOBz+/BplwqrNkxy2wJRsxWSv46TBfPep6pAx
         h2Q5QsQ+Yw8+Pliuq1MuE7LQYQivWWsz+zvuexmSBUw4F+MbQsY3sb39RcrRjhvRcc6K
         sYEA==
X-Gm-Message-State: AIkVDXLQTqJKK15Mfhwb8spXJN9v3kT9RTrHximw2EcyEFZIdEHUuB+0Sg5oZd/xp178dg==
X-Received: by 10.28.191.130 with SMTP id o2mr7671363wmi.97.1481986571065;
        Sat, 17 Dec 2016 06:56:11 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:10 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 07/21] Documentation/config: add information for core.splitIndex
Date:   Sat, 17 Dec 2016 15:55:33 +0100
Message-Id: <20161217145547.11748-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a0ab66aae7..dc44d8a417 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -331,6 +331,10 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
 
+core.splitIndex::
+	If true, the split-index feature of the index will be used.
+	See linkgit:git-update-index[1]. False by default.
+
 core.untrackedCache::
 	Determines what to do about the untracked cache feature of the
 	index. It will be kept, if this variable is unset or set to
-- 
2.11.0.49.g2414764.dirty

