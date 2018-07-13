Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53051F914
	for <e@80x24.org>; Fri, 13 Jul 2018 17:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbeGMSGE (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 14:06:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52368 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbeGMSGD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 14:06:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so3620596wmh.2
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 10:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AzKj3aFzY0vzxhg9mhOdNcN2RpmNrbBznXISsOB3ytg=;
        b=IPG3EVkQqwMCOgTF73Bzi7ABR0CjvzoSiGnE/tKXzDfkOdmyXn27y9kI+RB5NKZ2x1
         Jc9pA1eL9skQ7KsN/BWgS56sL0bFOUQa7u/RSYaJETUIYaB3oh59VQ0uJn8oMoLlKUKQ
         fhLV1ysT6QOBC3xaNbOGVA2Gp2TX5T/VEqVmjDHRGka9FYhnK2NniqglIoqmYJ6gBk0L
         fXvZYf4Na1T5Crlbm4DES3jvGtMduJ5ZpaKGvMXclJ10oGwRSZTvSh8SKKiXCikVDhG7
         GejS9nsdsKkzl5Lhsn9HZTzuKAQBvN3fBQza1DEsVXgsgU21QWCDFMlD5y5F6LqNn57K
         iPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AzKj3aFzY0vzxhg9mhOdNcN2RpmNrbBznXISsOB3ytg=;
        b=hJ9xx1MxHUWLRgfxI5pQx6NDUE+dnYpss8fkco585/HX6eIj0P5kZm4xd9Hyl3WroD
         BmPFDuJmQuIQCv8EuMeU+2XUwPbJ6LutcXWo5kz4WfTVr4HixI9G9Y7+Yi86XCAN0h8X
         IHYhWPKUIe1n62zecikTdIVJmP3INMFiboRdPeY5FDWXLdO58DDiEt2SsNbAtKB0dV2H
         zOoaJOosRbVotiIOANoDaV+/+eYO3EWiowkLzZzxMP0sM0KaAZWSyL97mAQFinRiwUso
         T0bUJKSkagDFtVPoKhOYB4Kv30faZilhkt1NM6sLHxZ2oXhk+QtRtkCzMBz6BGce1wc5
         wcNA==
X-Gm-Message-State: AOUpUlFvrR0CpJKCBW9qjGPJn8y2nuq+Vlv9eefgfknOATVvqXl92Dgc
        mgRlCK5W1e9vp/BizCGUddFwCval
X-Google-Smtp-Source: AAOMgpd3GHpe3jVRYLk0N+HFDHtb0N0SEmQN+qHsisaYIV1SFz+I9tomX+pmsTw7l27gzglxLk24cg==
X-Received: by 2002:a1c:5cd:: with SMTP id 196-v6mr4766617wmf.114.1531504223750;
        Fri, 13 Jul 2018 10:50:23 -0700 (PDT)
Received: from localhost.localdomain (188.10.112.78.rev.sfr.net. [78.112.10.188])
        by smtp.gmail.com with ESMTPSA id v15-v6sm6556862wmc.16.2018.07.13.10.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 10:50:23 -0700 (PDT)
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
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 4/9] remote-odb: implement remote_odb_get_many_direct()
Date:   Fri, 13 Jul 2018 19:49:54 +0200
Message-Id: <20180713174959.16748-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.138.g7076a5fae1
In-Reply-To: <20180713174959.16748-1-chriscool@tuxfamily.org>
References: <20180713174959.16748-1-chriscool@tuxfamily.org>
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
2.18.0.171.ge260395bfe

