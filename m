Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D9891F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeACQfR (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:35:17 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:45528 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeACQfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:35:09 -0500
Received: by mail-wm0-f67.google.com with SMTP id 9so3637002wme.4
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TOdKxKF+6yqJ9zYquh8mW6rgGgDshS5UIoHuQRuNTwg=;
        b=GbL0coB08GONg1W85qbCt8ePV1kLLRp8Rz6g+dQkzWvPkYr4uXa2MQkOkML/oMB/oy
         oFximR4a/vHaB+N7DqjjoZpGLiefobuo6jtIJFJlzq1jfC5PfVVkBUeS3/qJCJQBQg1e
         KdM24tXFW2LfdIFAgPJbMKDJnUO3J4swuZd8P0kTZZrzAq7CPnmKQ5AUpNvJu94XdFdZ
         ybYQtgbhtprQnD8V0O02uafigogSSw5qrB9ErdcK60d/D4snnwGAHg6MvJDNaIYWNHgU
         OOK/QC0xAw9UYjeDjgt+tSMdZnTuMFFOKGJkGdHxeckwaQTK/ly1as8wfoBShMAb5Utd
         +aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TOdKxKF+6yqJ9zYquh8mW6rgGgDshS5UIoHuQRuNTwg=;
        b=Lgfv0zGvcI+CPRhQe8xXU5qEapYTgC86Xp2zgV/W2NCoA4bjoWnnpsQyCR/HMzLvab
         7rAged1LtvclB/O39JPJGJGEIwxAL24vSZHyWFrp/6R0edgc70+Q3irtZz5EJ3TuS4yl
         /FTkRvaNpC+D0w40ad1xYQp0G417+KQHh4KSMPCNAO0AwweGwngU3Z78icGTeSOobBiH
         yzPt/wYNBvC6QRW7PP6WCI6lKmrAD0szGbLL0ku6vCmE20UCZE2Dym1BK9/LzKpST2WY
         pkMJNqPn0RW5FLDhJHnQoEI3aW2RNx3ByURdJbN19nyioboxeLoKA9gGIOHVqJ+wm03p
         hy3g==
X-Gm-Message-State: AKGB3mKpATFOW3KLjPakuv8FwOCyEqdLD2yhLscaMhUvvnQPj+3jBsZT
        1Svc20C+0nRlxawyzER7uSvN6a4J
X-Google-Smtp-Source: ACJfBouefvBVYxD5+/2gi2gg9nHBEZyq/i2fviJfyFyMMT/Q5m2DxM3RQxvPXN7Y8zTZl4sph5rQ4A==
X-Received: by 10.28.141.11 with SMTP id p11mr1944069wmd.149.1514997302539;
        Wed, 03 Jan 2018 08:35:02 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:35:01 -0800 (PST)
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
Subject: [PATCH 30/40] external-odb: add 'get_direct' support
Date:   Wed,  3 Jan 2018 17:33:53 +0100
Message-Id: <20180103163403.11303-31-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
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
 odb-helper.c   | 28 +++++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 93971e9ce4..3ce3d111f3 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -109,7 +109,8 @@ int external_odb_get_object(const unsigned char *sha1)
 		int ret;
 		int fd;
 
-		if (!odb_helper_has_object(o, sha1))
+		if (!(o->supported_capabilities & ODB_HELPER_CAP_GET_RAW_OBJ) &&
+		    !(o->supported_capabilities & ODB_HELPER_CAP_GET_GIT_OBJ))
 			continue;
 
 		fd = create_object_tmpfile(&tmpfile, path);
diff --git a/odb-helper.c b/odb-helper.c
index fc30c2fa57..0fa7af0348 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -429,24 +429,42 @@ static int odb_helper_get_git_object(struct odb_helper *o,
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
+		if (odb_helper_start(o, &cmd, 0, "get_direct %s", sha1_to_hex(sha1)) < 0)
+			return -1;
+
+		if (odb_helper_finish(o, &cmd))
+			return -1;
+	}
 
 	trace_performance_since(start, "odb_helper_get_direct");
 
-	return res;
+	return 0;
 }
 
 int odb_helper_get_object(struct odb_helper *o,
 			  const unsigned char *sha1,
 			  int fd)
 {
+	if (o->supported_capabilities & ODB_HELPER_CAP_GET_GIT_OBJ)
+		return odb_helper_get_git_object(o, sha1, fd);
 	if (o->supported_capabilities & ODB_HELPER_CAP_GET_RAW_OBJ)
 		return odb_helper_get_raw_object(o, sha1, fd);
-	else
-		return odb_helper_get_git_object(o, sha1, fd);
+	if (o->supported_capabilities & ODB_HELPER_CAP_GET_DIRECT)
+		return 0;
+
+	BUG("invalid get capability (capabilities: '%d')", o->supported_capabilities);
 }
 
 int odb_helper_put_object(struct odb_helper *o,
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

