Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A70E1F516
	for <e@80x24.org>; Sat, 23 Jun 2018 12:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeFWMTT (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Jun 2018 08:19:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38245 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeFWMTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jun 2018 08:19:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so5297784wmf.3
        for <git@vger.kernel.org>; Sat, 23 Jun 2018 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uMO6nTxCSGoMRXX6C5tsphYzVDIPFBy/zl3GgH3dWKk=;
        b=iyZcAZTs+uDYyCtbBB/OhI01bBBqVcXyf7Z/AyEwJEpIeik3F7io+KY7hl8tISVYJI
         hWiP09yMcO9RYTqtMn7Mh+Nxm0/zVJ84m9zQ+GVtrniBwyKje7kfh88tBt6JxSJ0wPz6
         L5s9xGF6Vzhjth/Xxwbn8vXIKI+dwXcA4fJTKF5yONo+nZlhvepyG8NrKpcvhImSCaqj
         GEpjXdDIE7eN0FUdDCFHYPbghRGspnMt6ewiELWRnZZz0gWRluKYZjNZV4EXi9sunozU
         2wV39IycpSsRRTaOBjQxtHNy03Qpgt59g/TUA0064eCf95s61LaQuG/1kZBQDZRfR00I
         d23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uMO6nTxCSGoMRXX6C5tsphYzVDIPFBy/zl3GgH3dWKk=;
        b=dsWYh+1oZC/QrkH2drPNYnLvdHBVDev+dM8a0fssLQ0Auw9/1V9sOhVGdC5En1DWzE
         HjF9N3zxg0bFXiXIzvUgaMHQEF117Cqkmbgz3WmLh9i1VK/vXv6mWeZvL+zm08sKAWpn
         Jbp3+0Zgwly0Sj8TuKcopQyeFH0mliKPZCfSUYQ/T4gV+LI3wZlb6nvyJ3/JYnB1WydP
         lzEmRBWmsv+tWkfnh0L4+StzsBCVXthhnVZMGyG4o79/FjkN7zPQlCNywUyy75Cdr9mW
         N/KbYNy0GdcjwJhB5Wj5Lr2Hyfnj/JFPaAVASTTN1aCRGcbR+A+Spz2bKg7fCH0K3gxi
         1tEg==
X-Gm-Message-State: APt69E1izbkoyL5Op1tiV82mHzQ/Aj/qWMt7lkIfL6QaA/MAgn96m5U2
        1pwYDeCtU+HGE+gTqZ/SABew0qF+
X-Google-Smtp-Source: AAOMgpfgE3OYHDWv4By7Xi9U9C+SIJMPw7WkNb2Ukmw8CoPkBih6uhqpmzbhJGFKxGT1fkL/9OMXEg==
X-Received: by 2002:a1c:6954:: with SMTP id e81-v6mr4509750wmc.124.1529756347983;
        Sat, 23 Jun 2018 05:19:07 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id q14-v6sm5527731wmd.20.2018.06.23.05.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 05:19:07 -0700 (PDT)
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
Subject: [PATCH v1 05/11] remote-odb: add remote_odb_reinit()
Date:   Sat, 23 Jun 2018 14:18:42 +0200
Message-Id: <20180623121846.19750-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.762.g886f54ea46
In-Reply-To: <20180623121846.19750-1-chriscool@tuxfamily.org>
References: <20180623121846.19750-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We will need to reinitialize the remote odb configuration
as we will make some changes to it in a later commit when
we will detect that a remote is also a remote odb.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 remote-odb.c | 14 ++++++++++++--
 remote-odb.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/remote-odb.c b/remote-odb.c
index cc7059b23a..2b93d13abd 100644
--- a/remote-odb.c
+++ b/remote-odb.c
@@ -39,17 +39,27 @@ static int remote_odb_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
-static void remote_odb_init(void)
+static void remote_odb_do_init(int force)
 {
 	static int initialized;
 
-	if (initialized)
+	if (!force && initialized)
 		return;
 	initialized = 1;
 
 	git_config(remote_odb_config, NULL);
 }
 
+static inline void remote_odb_init(void)
+{
+	remote_odb_do_init(0);
+}
+
+inline void remote_odb_reinit(void)
+{
+	remote_odb_do_init(1);
+}
+
 struct odb_helper *find_odb_helper(const char *remote)
 {
 	struct odb_helper *o;
diff --git a/remote-odb.h b/remote-odb.h
index e10a8bf855..79803782af 100644
--- a/remote-odb.h
+++ b/remote-odb.h
@@ -1,6 +1,7 @@
 #ifndef REMOTE_ODB_H
 #define REMOTE_ODB_H
 
+extern void remote_odb_reinit(void);
 extern struct odb_helper *find_odb_helper(const char *remote);
 extern int has_remote_odb(void);
 extern int remote_odb_get_direct(const unsigned char *sha1);
-- 
2.17.0.762.g886f54ea46

