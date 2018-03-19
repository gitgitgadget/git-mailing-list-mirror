Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10BD41F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933318AbeCSNcc (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36158 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933186AbeCSNc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id x82so2876774wmg.1
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=00DV2rduOgaqG9QJYg8ZtgfvhC1sJeILZY3UWRBodRA=;
        b=G7OTA935tDR27XjMR3oQ0IvB4Y7hJJWtEUSb7ejmI4JCmIGMI5TIiAivUvzJqnU5Nt
         /Cpc2MwsfDHLRsXQ9LnIIMNQRtJ65+bQCDBttIAeIEMGjCvCtk7VGSUyDGFtaP7sXu1e
         1vsqvLADcX+me/sTY7fPEonvtakHL1KtrdNOfuLGjjtB9ejczU7r8CZkkoahHussxROZ
         FepZpw/RU//tp7VlrzT7iO9R9ljjnHcXAVLtdddAIwVLZNzuf0iSomZ55n9yDJF2Z8Dn
         H5yiaWONen069C4u09K3DY1jFwxMcs1iIGo5xDc8rF817KJE9imd0ZR7ptqlo4Oie95x
         d36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=00DV2rduOgaqG9QJYg8ZtgfvhC1sJeILZY3UWRBodRA=;
        b=e9Tig3Y++ODsRWxbOwJEZjc8DVEWKO/5Vb9HTfENVc/q1JM91axwnk6qYOvQeR9w7/
         vI41xfgvULIfrv5amKCKd3OVh4nREA/QSD23n7o9GtZlVbH2X+dSmTy2Yw8UZwQ6VWIW
         9oqMo6TCt7Tk4t2Bcvigk2b/g1Dbif1vaFVdbQPdtNnr8r+uYHYSz3kQ41lKtt8UYcdP
         zbWHis2Z8KbiVoMexwafCSBTnbNmXoK/OfR0Q2bNFu6tSD6jgL2cF958cgnBTtw7Zvse
         IjwIEMDB6rSy82AECGIH80VWvrwtWDWH8CMp8MsEQJ/KjKYL3Pc6NfOSA4iTK3m9KyhN
         nNKg==
X-Gm-Message-State: AElRT7E1Ab97UIgdHksOgsYLlojZ65weDIppmHu6brr5HufxKcl/gSma
        wOiFslTN0TlqqrKQSXzx8KyRTAeM
X-Google-Smtp-Source: AG47ELtcG5/Xs3fXv7m/uP18YS7/qSrlWvZ9Gr4ZTE4fWTzof//SZy+Ez6a9Zm6qemc90kiBtkIMGw==
X-Received: by 10.28.185.208 with SMTP id j199mr9246043wmf.9.1521466344589;
        Mon, 19 Mar 2018 06:32:24 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:23 -0700 (PDT)
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
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 12/36] external-odb: add external_odb_get_many_direct()
Date:   Mon, 19 Mar 2018 14:31:23 +0100
Message-Id: <20180319133147.15413-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 17 +++++++++++++++++
 external-odb.h |  1 +
 odb-helper.c   | 16 ++++++++++++++++
 odb-helper.h   |  2 ++
 4 files changed, 36 insertions(+)

diff --git a/external-odb.c b/external-odb.c
index ae6bc017fe..8be92277d2 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -182,3 +182,20 @@ int external_odb_get_direct(const unsigned char *sha1)
 
 	return -1;
 }
+
+int external_odb_get_many_direct(const struct oid_array *to_get)
+{
+	struct odb_helper *o;
+
+	external_odb_init();
+
+	for (o = helpers; o; o = o->next) {
+		if (!(o->supported_capabilities & ODB_HELPER_CAP_GET_DIRECT))
+			continue;
+		if (odb_helper_get_many_direct(o, to_get) < 0)
+			continue;
+		return 0;
+	}
+
+	return -1;
+}
diff --git a/external-odb.h b/external-odb.h
index c5ac071995..a4eda95b09 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -17,5 +17,6 @@ extern const char *external_odb_root(void);
 extern int external_odb_has_object(const unsigned char *sha1);
 extern int external_odb_get_object(const unsigned char *sha1);
 extern int external_odb_get_direct(const unsigned char *sha1);
+extern int external_odb_get_many_direct(const struct oid_array *to_get);
 
 #endif /* EXTERNAL_ODB_H */
diff --git a/odb-helper.c b/odb-helper.c
index a99f4a1299..7e5eab94cf 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -345,3 +345,19 @@ int odb_helper_get_direct(struct odb_helper *o,
 
 	return res;
 }
+
+int odb_helper_get_many_direct(struct odb_helper *o,
+			       const struct oid_array *to_get)
+{
+	int res = 0;
+	uint64_t start;
+
+	start = getnanotime();
+
+	if (o->type == ODB_HELPER_GIT_REMOTE)
+		fetch_objects(o->dealer, to_get);
+
+	trace_performance_since(start, "odb_helper_get_many_direct");
+
+	return res;
+}
diff --git a/odb-helper.h b/odb-helper.h
index 7720684744..2c529af6af 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -39,5 +39,7 @@ extern int odb_helper_get_object(struct odb_helper *o,
 				 int fd);
 extern int odb_helper_get_direct(struct odb_helper *o,
 				 const unsigned char *sha1);
+extern int odb_helper_get_many_direct(struct odb_helper *o,
+				      const struct oid_array *to_get);
 
 #endif /* ODB_HELPER_H */
-- 
2.17.0.rc0.37.g8f476fabe9

