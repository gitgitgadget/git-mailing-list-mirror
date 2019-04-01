Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BEA32037F
	for <e@80x24.org>; Mon,  1 Apr 2019 16:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfDAQlS (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:41:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50292 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbfDAQlS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 12:41:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so113618wmi.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 09:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lNgQHRwwRhSPGUvpTQ6SpDXPfZtJY7PSnNgcTAQb6Uk=;
        b=u1HGragltT2G5dfZVVtTFsAWO79WLzUun9VWxTEx38GPukaPGkYDpfqdqCZnXrKY4I
         Dg+AtxzbjUnkg/4OKgkMHggCn/u45NDkHvhWD7xr5zL16KYDkBs/QB4RSjTxdxA+vERL
         g1cjymZd12JIjL2byvfGnJoTLCrIjm2FHYvsv5WACLC8TRkfBNqalnPyWoZKBWv9py41
         4ggLKGAFDXimWXrvQyVwFAaH/5GeaQf2Mx4Gvp1PTKlH37h4jTjDUb1KC0FTFYZQlcxP
         iVzAXj9u9lMpji7gJ4D+ejlM2ae5X2eg9TZjdE93pvejK+ilZluVG5imqIQQb2tlMAdv
         dgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lNgQHRwwRhSPGUvpTQ6SpDXPfZtJY7PSnNgcTAQb6Uk=;
        b=AAS5Lb4XsRU/0hoiz+OGXn1Y4KAzzHWDJIEAOOceuGGiIL/pNwTxBMT6A3K511sclQ
         Adn7BmXX+mzddnwyEuhXWQaAKTcivD3OJKJnciVVWZiCszzyH2FYZNFaD7gypeRL04q3
         EPFLRXZMq5xOXyy3NmTpjCVH+IU5xz5/Dxb/H9wY21Yl9Lf/gxPR8w6rMEMApoMWcWsT
         UawTPoJxmQi9kiAh5NP8H+two6L+h66iUVJIzAQd73XPaLfP19kcXqQfWZD4lXnybsXX
         4rrWdAlD/gyO4I4wtuaXuNYxfPqAiR0z3+wuQ+4rM/lGQRMTZSjuXqMH/EQ0f0ayLgjv
         3VZw==
X-Gm-Message-State: APjAAAVJPgH71tgi6aQuntax7dB4QQUmKcu+J4XDkYT7/PA6IQ9jtS3O
        KVLrNJ0AjHa4UVx6RBeu8gCxMkm5
X-Google-Smtp-Source: APXvYqw1VeY5rvak8G7Lv5SinTYNwmg0GZIHV2HoPV6XtoT+Vo4OqhqFPTWVDWh7VQamPCb33PxyPg==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr378095wme.24.1554136876223;
        Mon, 01 Apr 2019 09:41:16 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:101d:3e80:8542:d1d4:667f:a0da])
        by smtp.gmail.com with ESMTPSA id s10sm11749070wmh.0.2019.04.01.09.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 09:41:15 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 04/11] promisor-remote: add promisor_remote_reinit()
Date:   Mon,  1 Apr 2019 18:40:38 +0200
Message-Id: <20190401164045.17328-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.203.gd44fa53258
In-Reply-To: <20190401164045.17328-1-chriscool@tuxfamily.org>
References: <20190401164045.17328-1-chriscool@tuxfamily.org>
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
 promisor-remote.c | 22 ++++++++++++++++++++--
 promisor-remote.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index a3d601e45a..d1fcd1a8bf 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -67,10 +67,10 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 	return 0;
 }
 
+static int initialized;
+
 static void promisor_remote_init(void)
 {
-	static int initialized;
-
 	if (initialized)
 		return;
 	initialized = 1;
@@ -78,6 +78,24 @@ static void promisor_remote_init(void)
 	git_config(promisor_remote_config, NULL);
 }
 
+static void promisor_remote_clear(void)
+{
+	while (promisors) {
+		struct promisor_remote *r = promisors;
+		promisors = promisors->next;
+		free(r);
+	}
+
+	promisors_tail = &promisors;
+}
+
+void promisor_remote_reinit(void)
+{
+	initialized = 0;
+	promisor_remote_clear();
+	promisor_remote_init();
+}
+
 struct promisor_remote *promisor_remote_find(const char *remote_name)
 {
 	promisor_remote_init();
diff --git a/promisor-remote.h b/promisor-remote.h
index 30c0b3dcb6..071dd6bbca 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -10,6 +10,7 @@ struct promisor_remote {
 	const char name[FLEX_ARRAY];
 };
 
+extern void promisor_remote_reinit(void);
 extern struct promisor_remote *promisor_remote_find(const char *remote_name);
 extern int has_promisor_remote(void);
 extern int promisor_remote_get_direct(const struct object_id *oids, int oid_nr);
-- 
2.21.0.203.gd44fa53258

