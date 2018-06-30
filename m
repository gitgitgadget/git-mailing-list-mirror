Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B901F516
	for <e@80x24.org>; Sat, 30 Jun 2018 08:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933988AbeF3IgT (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 04:36:19 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43290 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932861AbeF3IgH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 04:36:07 -0400
Received: by mail-wr0-f196.google.com with SMTP id c5-v6so10846253wrs.10
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 01:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WEyF4gXeMfpoEuf9/9/XSBYqU24tEMFPTKj5GeWWpBQ=;
        b=PUamywybbQB58JDN8H/9KJ+Kz8dD1+yvHua+KziTqzO8jjqCOLiPlhmib4anTWlZOu
         wxS1NLc09EBK1rqrzFpsJgDpgnokE8aPsZIq5xuSLBydRhRDjAblsebniQcMeC2JufAG
         EdjvFwmqYkRWUoNN14MZLv4JCOHwDSftFq1rIIojB3WyPi+GBGP3mazEURSczjyIVhJA
         5GonFM253AUiQ4zYAGIYu9UxR1kW8lNGAXPjTVkZwLuzlgKmqi4AKHF4n2nGWgcPLg5+
         LuCdtVN433bYUHfgUi/OAy+oP6c5PYYWBXEokQPMYEaK2K3q+8/eWzsm6r9kybCLXEdh
         ZbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WEyF4gXeMfpoEuf9/9/XSBYqU24tEMFPTKj5GeWWpBQ=;
        b=YPqqWbFogJfRPOVG4xMZfmk+lJ+Mhcvgx1f9rrcpRS4oIKC/x+rNSsC+zzs3r8Nkmq
         v0Rq18DtVXtpWD62bxjpxjiwm5r0c1NNp7Ryqe0r6rqeBkdgp3ConjVz5LoErhMaLWCC
         jNaoAjyM3PEgkb3hTY9fXSjXpWZ4qtnVpW3w2/R5lnFIYYeD4iYttSeQ3NZnE8JboZ6g
         0Ex1BVwCrdfkyNI6FhJJYq5Z4MougFnf4ZCEr26COg5dIWvhFG0Tc+ybbK4FdMPPpwj2
         Hqj7ZYnH+4DNuB47W2F6XK/Lfo/bfzu+CC8S4RWoAh/njxTLEJeZkGoCsaex/xab/E41
         EtQQ==
X-Gm-Message-State: APt69E3iWI+4EnJZKlkeP6nT5yI4F/Vld4z354nc+HrCMpinYnr3oGIZ
        gUFH0Ycp1wzgKaaxk6FfgxLkyOUV
X-Google-Smtp-Source: AAOMgpffISCMHIJ0b7nvfSAgcTrGH6vNYa2eIyL57r/tyyoCzDhupDUha4gEIQAINoZdnA5zIor+sA==
X-Received: by 2002:adf:8345:: with SMTP id 63-v6mr14757454wrd.37.1530347765891;
        Sat, 30 Jun 2018 01:36:05 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id u70-v6sm5338356wmd.3.2018.06.30.01.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 01:36:05 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/9] remote-odb: implement remote_odb_get_many_direct()
Date:   Sat, 30 Jun 2018 10:35:37 +0200
Message-Id: <20180630083542.20347-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.138.g8117677157
In-Reply-To: <20180630083542.20347-1-chriscool@tuxfamily.org>
References: <20180630083542.20347-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function will be used to get many objects from a promisor
remote.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
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
index a1811c1bfc..5aa36021dd 100644
--- a/remote-odb.c
+++ b/remote-odb.c
@@ -108,3 +108,20 @@ int remote_odb_get_direct(const unsigned char *sha1)
 
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
2.18.0.138.gac082779dc

