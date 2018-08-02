Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F7C6208E9
	for <e@80x24.org>; Thu,  2 Aug 2018 06:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeHBIFR (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 04:05:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52442 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeHBIFR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 04:05:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so1088038wmh.2
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 23:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vY6+VqQKfE0baxWaq67NOHbT5r7aqBQNKyyclPW3psU=;
        b=nBboopfBcwwqdpiErnUxgkMxeMPHfGTmf4FgfNFKjizm7mVb/V/vT6WHBl+w04CE2a
         7j3Du4JSyV5QhwOqCWdj50tdTQMXayMPpFWLNiF7VWAWUvAu/AkaJjbTVFrFIYSe1CZq
         /4Y3eFYB842nzHcxi2rFmbdjei7Tv7/qHOtMmeNXtitpsk/uB75Z3s3Ft8Y6S2DFHFtJ
         5sqfFHYKgEZaTLvz38mudjr3OgzNTWuegI1zxwDWX8yOwTLsTKXcEzCJovbTaigecZLD
         WpQhpHoFyvQBEHn46f/07HAn0l8As8cTxSL2tkp9vmqhNar++lbjH+AsbH/hxcQZlPIA
         tIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vY6+VqQKfE0baxWaq67NOHbT5r7aqBQNKyyclPW3psU=;
        b=Jt8pUovdGLXmdwNgkvhx7//hU1P46YihISVlouUn8u8YIRAp7GQjzkZ2MXunptfbXU
         460S/Ogp/wDxrHyjKfGd+XB7Wl6b465yu8A/FDMLk7efztygXnHlJ89hociEQpe8/lxy
         21hBN0vGWfJoTh9xy0G+O9C/T0HXVviTQCoNJHY6ULxRatlRU03rwNSzu6/O4zHsyZIF
         wOchEYJSzecQtDCLHwsOnEnV9JSgOoJSy7e2UogLb1whKuE4VTW3TJuP8l8z20bZUwGQ
         cC/e0oJZkpJRMlWfuveg8aDn/Qq6afuLQKrektYd+fSCNgf5HCQFGHzyG6n5cy044Q5I
         Eeiw==
X-Gm-Message-State: AOUpUlE7ntoK+EtgUq+Rcw44won7zAlHjfEMJgke6HSvt4tTxZQbJIdL
        vTZMoe7M/7Q/n+BpDfoIOF420GnW
X-Google-Smtp-Source: AAOMgpcRUvHGLz+MmZpmozH4kVOA/pVB28joVevzl4TYqvFHUrbFyzrzkMkM6QJUs/3Bn0n6+lViUw==
X-Received: by 2002:a1c:ee94:: with SMTP id j20-v6mr933070wmi.66.1533190544530;
        Wed, 01 Aug 2018 23:15:44 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:109f:b149:1092:6e1:496b:fd26])
        by smtp.gmail.com with ESMTPSA id m200-v6sm1093018wma.32.2018.08.01.23.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 23:15:43 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 4/9] remote-odb: implement remote_odb_get_many_direct()
Date:   Thu,  2 Aug 2018 08:15:00 +0200
Message-Id: <20180802061505.2983-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.330.g17eb9fed90
In-Reply-To: <20180802061505.2983-1-chriscool@tuxfamily.org>
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

This function will be used to get many objects from a promisor
remote.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 odb-helper.c | 15 +++++++++++++++
 odb-helper.h |  3 +++
 remote-odb.c | 17 +++++++++++++++++
 remote-odb.h |  1 +
 4 files changed, 36 insertions(+)

diff --git a/odb-helper.c b/odb-helper.c
index 99b5a345e8..246ebf8f7a 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -28,3 +28,18 @@ int odb_helper_get_direct(struct odb_helper *o,
 
 	return res;
 }
+
+int odb_helper_get_many_direct(struct odb_helper *o,
+			       const struct oid_array *to_get)
+{
+	int res;
+	uint64_t start;
+
+	start = getnanotime();
+
+	res = fetch_objects(o->remote, to_get);
+
+	trace_performance_since(start, "odb_helper_get_many_direct");
+
+	return res;
+}
diff --git a/odb-helper.h b/odb-helper.h
index 4c52e81ce8..154ce4c7e4 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -17,4 +17,7 @@ struct odb_helper {
 extern struct odb_helper *odb_helper_new(const char *name, int namelen);
 extern int odb_helper_get_direct(struct odb_helper *o,
 				 const unsigned char *sha1);
+extern int odb_helper_get_many_direct(struct odb_helper *o,
+				      const struct oid_array *to_get);
+
 #endif /* ODB_HELPER_H */
diff --git a/remote-odb.c b/remote-odb.c
index 7f815c7ebb..09dfc2e16f 100644
--- a/remote-odb.c
+++ b/remote-odb.c
@@ -106,3 +106,20 @@ int remote_odb_get_direct(const unsigned char *sha1)
 
 	return -1;
 }
+
+int remote_odb_get_many_direct(const struct oid_array *to_get)
+{
+	struct odb_helper *o;
+
+	trace_printf("trace: remote_odb_get_many_direct: nr: %d", to_get->nr);
+
+	remote_odb_init();
+
+	for (o = helpers; o; o = o->next) {
+		if (odb_helper_get_many_direct(o, to_get) < 0)
+			continue;
+		return 0;
+	}
+
+	return -1;
+}
diff --git a/remote-odb.h b/remote-odb.h
index c5384c922d..e10a8bf855 100644
--- a/remote-odb.h
+++ b/remote-odb.h
@@ -4,5 +4,6 @@
 extern struct odb_helper *find_odb_helper(const char *remote);
 extern int has_remote_odb(void);
 extern int remote_odb_get_direct(const unsigned char *sha1);
+extern int remote_odb_get_many_direct(const struct oid_array *to_get);
 
 #endif /* REMOTE_ODB_H */
-- 
2.18.0.330.g17eb9fed90

