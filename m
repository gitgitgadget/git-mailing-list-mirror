Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F40E1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933357AbeCSNcu (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51120 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbeCSNca (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id f19so2596138wmc.0
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CdkEB7NDShqG8PppC5GqLXUaknYGyg74dGc/+b0N2z8=;
        b=AAFzLg6JrJbDk87mtNXt9unxf2zN+88Dgx5p7DF1PRljAirzS5qeVvXqMzRMCQFpXu
         md6kVQ6Yp5kC1UpWtMk4tW1/xxLg++QoVilYocIdVVNxjhPgYFUC9vi4FzeuZzF/gj/5
         ek+6rs9WF4UOLVOYrqR46TtzhS8Dd0b/z5YT+Im4jO7wizu5d2Z0FyI9jD4VQ6PpT9EV
         iCrcpCUwo3dr8kYB7ZQuKX3YjXNFOV20+nfLgz/y0uh5tkW8vZyJpnMk+VKrsi/roCTo
         fyI+sDv9DxdBdu3jLL5Odm+u05BQ3BdG7WSLdQNsmuyphR6tVid/uqWMlwNGYNqLDmtl
         eF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CdkEB7NDShqG8PppC5GqLXUaknYGyg74dGc/+b0N2z8=;
        b=j+h7YmxiMKbo0YShVTWshz1sTIOcRRCmWmJyrBObRBIaFJ8V+SGk/2ZoIUd7edZU3V
         sdF/Rvy2tBzcUcim7s7puPBEaHIwKXsZ8xIky2ZuhN9V8mQJECiilxzw8hJ/cXJUjq6Z
         z7fk10kKQXlM/sp6RRRQ6aUADooTM+YoDI1yfC0yA033g8miB0NDf7iQn+qs32P6JHyA
         ZxWIs+lpUE8+s7rXiDkCrryqMkjP+5uzMe+7CddpOw5HQSBmwBdRw0GhMIuKy73IxUOK
         v3a9dZAsUI6OocEtNwjvC/uPdXY8SrAbudVibLcufTL/Tud6FElOEobwGG9h6zj2a8gx
         hKQA==
X-Gm-Message-State: AElRT7EuYmgw5N9tJEDzyk6kCaJQw9wVpJ6txwHrK27gFSGHCtuKzO5Y
        KrGyGhRsl/zRGO7J6lOfuVuGY/I9
X-Google-Smtp-Source: AG47ELtnO/l8wCq8IXULjoV1uOaWL3u5Jn2tILvigVFf6bVgnvxdyk823m+e1DKhTlnFpuoHznWwbA==
X-Received: by 10.28.176.134 with SMTP id z128mr6464695wme.86.1521466349256;
        Mon, 19 Mar 2018 06:32:29 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:28 -0700 (PDT)
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
Subject: [PATCH v2 15/36] external-odb: add 'get_direct' support
Date:   Mon, 19 Mar 2018 14:31:26 +0100
Message-Id: <20180319133147.15413-16-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This implements the 'get_direct' capability/instruction that makes
it possible for external odb helper scripts to pass blobs to Git
by directly writing them as loose objects files.

It is better to call this a "direct" mode rather than a "fault-in"
mode as we could have the same kind of mechanism to "put" objects
into an external odb, where the odb helper would access blobs it
wants to send to an external odb directly from files, but it
would be strange to call that a fault-in mode too.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c |  3 ++-
 odb-helper.c   | 20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index c3d90f39fb..192b09e843 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -138,7 +138,8 @@ int external_odb_get_object(const unsigned char *sha1)
 		int ret;
 		int fd;
 
-		if (!odb_helper_has_object(o, sha1))
+		if (!(o->supported_capabilities & ODB_HELPER_CAP_GET_RAW_OBJ) &&
+		    !(o->supported_capabilities & ODB_HELPER_CAP_GET_GIT_OBJ))
 			continue;
 
 		fd = create_object_tmpfile(&tmpfile, pathbuf.buf);
diff --git a/odb-helper.c b/odb-helper.c
index 7e5eab94cf..30cfe689de 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -336,14 +336,28 @@ int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
 int odb_helper_get_direct(struct odb_helper *o,
 			  const unsigned char *sha1)
 {
-	int res = 0;
 	uint64_t start = getnanotime();
 
-	fetch_object(o->dealer, sha1);
+	if (o->type == ODB_HELPER_GIT_REMOTE) {
+		fetch_object(o->dealer, sha1);
+	} else {
+		struct odb_helper_object *obj;
+		struct odb_helper_cmd cmd;
+
+		obj = odb_helper_lookup(o, sha1);
+		if (!obj)
+			return -1;
+
+		if (odb_helper_start(o, &cmd, "get_direct %s", sha1_to_hex(sha1)) < 0)
+			return -1;
+
+		if (odb_helper_finish(o, &cmd))
+			return -1;
+	}
 
 	trace_performance_since(start, "odb_helper_get_direct");
 
-	return res;
+	return 0;
 }
 
 int odb_helper_get_many_direct(struct odb_helper *o,
-- 
2.17.0.rc0.37.g8f476fabe9

