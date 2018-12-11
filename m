Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3F2211B5
	for <e@80x24.org>; Tue, 11 Dec 2018 05:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbeLKF2N (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 00:28:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41134 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbeLKF2M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 00:28:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so12695106wrs.8
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 21:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+d5y56ev8WnX7X+cfbB2ub0R7dcx2j47G1GyXuBv+Cg=;
        b=kZCHJSe0otv8EUI1gE7uZ/eGcaoTnsZwNePBUs+q4wIdItuYvpSfklzL8K4WOKSGXg
         ETzAL5F/HWvMzc2fd2PcwctDT6J0UsB4hjepR9XBnuxkkyHgNpFAasRa6U11u6X9FuFG
         okmOL3s8kljj8zYT7JZCaulVxQZu6ineYUQBapv5+yCMZUmXRZL7lCxaMTSCr29Kdrli
         lMD1iqy3DJ/rd5forVy1Z7DpN6iSs+5oAsFsTgztRKsPogVgorO1hedfzSiXg9fBHgXd
         M9uzDeTiYe7zF7z9DFvOFjsOjzf8SOWK61ObO0ZvjqDLg0h8psyGGSOd7WM8dLI4R7WP
         Nqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+d5y56ev8WnX7X+cfbB2ub0R7dcx2j47G1GyXuBv+Cg=;
        b=rCPbcf1BrHFF88mTglmibzW7lARCM4TMl1ASv2G6cDzPn832/JlkEvWKwFYBW9Wk5y
         qny3qr/hPfRFkDWEAybsI9sR3DeCN2q+bIxQamhQPlLodpjzYmrBlFCdNLPrzDh3zEEH
         qvSLoaWJYqiMzJRfIavY6TeNcUu6gIcouncJ2Kw+4m3lqAzPZ3GNtdBrFqz4nlF9zOQd
         9IRkYqgr6TinbfitZazRwmIjiZwmzWz/fTfZwfm+7x7uYg0NpdmdxM89jZPZtOBg/EZv
         6bBQg3ppCIVqs5JamZy8luDEj4BjQW9HctrrGNBC39k+H0i0k2Zww6ar1T6hCho3AdIP
         SX1A==
X-Gm-Message-State: AA+aEWbKO3DLiZJb5mMWx7v7QW49KyRblFQ1FA7OqYwpge1K2ABeKpp/
        geJ/kWSBSW+Lszxc1v9onOCoagT5
X-Google-Smtp-Source: AFSGD/VVrKv6Rotk7uANAyw66XZ3eUHu3GkO2QMlsIRPJvfPSWnWWm7GJc9w/izM5NIj3rSkSUE5nQ==
X-Received: by 2002:adf:9d85:: with SMTP id p5mr11390937wre.41.1544506090435;
        Mon, 10 Dec 2018 21:28:10 -0800 (PST)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l197sm3708185wma.44.2018.12.10.21.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 21:28:09 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v1 4/8] promisor-remote: add promisor_remote_reinit()
Date:   Tue, 11 Dec 2018 06:27:42 +0100
Message-Id: <20181211052746.16218-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.0.rc2.14.g1379de12fa.dirty
In-Reply-To: <20181211052746.16218-1-chriscool@tuxfamily.org>
References: <20181211052746.16218-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

We will need to reinitialize the promisor remote configuration
as we will make some changes to it in a later commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 14 ++++++++++++--
 promisor-remote.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index e0724bdc20..ca2b8bf6bb 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -64,17 +64,27 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 	return 0;
 }
 
-static void promisor_remote_init(void)
+static void promisor_remote_do_init(int force)
 {
 	static int initialized;
 
-	if (initialized)
+	if (!force && initialized)
 		return;
 	initialized = 1;
 
 	git_config(promisor_remote_config, NULL);
 }
 
+static inline void promisor_remote_init(void)
+{
+	promisor_remote_do_init(0);
+}
+
+void promisor_remote_reinit(void)
+{
+	promisor_remote_do_init(1);
+}
+
 struct promisor_remote *find_promisor_remote(const char *remote_name)
 {
 	promisor_remote_init();
diff --git a/promisor-remote.h b/promisor-remote.h
index 8b89221b33..873ddfb5ed 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -10,6 +10,7 @@ struct promisor_remote {
 	struct promisor_remote *next;
 };
 
+extern void promisor_remote_reinit(void);
 extern struct promisor_remote *promisor_remote_new(const char *remote_name);
 extern struct promisor_remote *find_promisor_remote(const char *remote_name);
 extern int has_promisor_remote(void);
-- 
2.20.0.rc2.14.g1379de12fa.dirty

