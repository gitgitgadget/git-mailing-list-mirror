Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 451DD20377
	for <e@80x24.org>; Tue,  9 Apr 2019 16:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfDIQLx (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:11:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41421 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfDIQLv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:11:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so21642325wrq.8
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N6vaBY91AoiJIMKSeCFmJ9mFQ4eiKK2CdaYB6w1obkQ=;
        b=cGr9X6WPzRh3WmhOMNRyPmHszSIMohABFBGb5ylADkwOwJQ9/EeGF2WQE1LStd0dk1
         VBRam/ExVM3lcV4QB3arDADuQx/OY3nSaF3uCvzGhuC+7YbCpwlwtW3B0FmN7hdbRf77
         Hvt5TUc7fB6anr5gvCQB6yB5ASUIsPAGUenKoSWU8Iy/qyJDrN6udV/fDB9dVZhymbJe
         1mCi8cGUl7JZ9wvFlVtqM1IN3M1uuhkdP//ukgLKkRtUERusKqTjYdl8wfY8t6KzegIB
         iQH0Ny9pcDuniZjZrMLM40/nG5nS/VmULj5GTBKTf4xykuvWJFT4nQcX+SJG+oUwIWz3
         QidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N6vaBY91AoiJIMKSeCFmJ9mFQ4eiKK2CdaYB6w1obkQ=;
        b=k1ACZ4sc8ZIRZg2wtgGEllcxaNN+OWF0/sDrnDMG2W+cXoXiB0N2dSIlMCLqcYhUQT
         0bwJupI+f7YsHEz/R9NoH9UOEPYlj8NWllV7Zc6w09JKE7FQh9oegweBT6OgDtyqhIax
         Sqm9bthX38EjU2hbGUvRRbXFWSTdhnziMDX8DAYyF+iVB3H2QR2MYsYcSXICJtFuyIO6
         XtXLBab6qX0q1XkATTBQZCqvh48gtyX7JUgE3rrSd3PnKXt74ExPbIDoUfVUCH+fQdEh
         phMjul0jfsTJXFkEsqyuyzID/0WsZNtf5X93LO6FW1gkjSxgc4a2/4qTPvRJwNaS/eWX
         H/qw==
X-Gm-Message-State: APjAAAUaN+6/bnyuvFU/EQTXuAz5ZKdRIt1xvnzrsioWS+s1AUgBZ7h6
        qXq2iSA3wEKp5GJclpj7kuq1gHWq
X-Google-Smtp-Source: APXvYqxsEQUOerjaOMgBoLihm9XRg7sclRMBzttzbEpJVv9vGs5Avkkc55eicVUC5Aihcx5jWbUklQ==
X-Received: by 2002:adf:c788:: with SMTP id l8mr23279612wrg.143.1554826309342;
        Tue, 09 Apr 2019 09:11:49 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id i2sm4356012wmg.47.2019.04.09.09.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:11:47 -0700 (PDT)
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
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 05/16] promisor-remote: add promisor_remote_reinit()
Date:   Tue,  9 Apr 2019 18:11:05 +0200
Message-Id: <20190409161116.30256-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.750.g68c8ebb2ac
In-Reply-To: <20190409161116.30256-1-chriscool@tuxfamily.org>
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
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
index 289f1dd074..46271eb3e3 100644
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
index 92650cfd4c..ff69963907 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -12,6 +12,7 @@ struct promisor_remote {
 	const char name[FLEX_ARRAY];
 };
 
+extern void promisor_remote_reinit(void);
 extern struct promisor_remote *promisor_remote_find(const char *remote_name);
 extern int has_promisor_remote(void);
 extern int promisor_remote_get_direct(const struct object_id *oids, int oid_nr);
-- 
2.21.0.750.g68c8ebb2ac

