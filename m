Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B93020A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbdIPIJZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:09:25 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36336 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbdIPIIT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:19 -0400
Received: by mail-wr0-f196.google.com with SMTP id g50so2374357wra.3
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=caPZ1e+hqnqHVWOa2Fy8R0Ftfb4GYCfNge/Nt8K40fg=;
        b=OROV5kSJWgRHXLaM9EnKbKiqlLLK09uEwB5QiFPKFYCpmg+lCHB5DOPsJyR968Dy5a
         Do+bmPvrmSFQJWHnj0qGX0fFso+mqxdZsq0s1pXYDA3fZwXNmQlmxYp0rmkNpOersbz2
         4Ns9yrkoHkum4nUHOQgnNsGYL4Jdwa+slDEdbutJiP0i7wQqlcBkgiP90nS8TprbwpG9
         qZ9vYwId7rNDwBL5/IbVBFc1cuFWz+OFr8oHOUS+tWNFfLzKmkR/Y2MXaY8Agpiu/Lyj
         Bf38uFdTEh+rGme+lgzX9gSajksPrw8OgUuI2v5BdvaPA1+iSzBdZI5IJBC60V2AaeID
         6OLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=caPZ1e+hqnqHVWOa2Fy8R0Ftfb4GYCfNge/Nt8K40fg=;
        b=Uy7mk2FuW3HxogBZHGPK4GPNub2oWfNLizQzJXeS2dXGwCMoSdjYmRprsdYISa2HXx
         OeJEISls34uQpZoVGHjCoan7f7L/julGkhmqDTQgmh0WILcQ09eicDMZ/+j4lsNSuBUO
         jv1m484ttsZJpExw3QsDPU1nV2/ZndVlKPQ59mqLIG5mq2t18CTl7Qa96AHM3nL/GuU8
         Eq9DbYXhX2eyxKeRvoQ8tFc2HP+zvcc6uUzKpZGLt5DKphX2K98E3Bc2M5VHV5TD0fpN
         BV52c0llEU3vq4jwOQwRoWug5p6WHpIYmaJXOVWAUjfgQmk7L1YyaKtk7BmOWF/J3Fu2
         O5ow==
X-Gm-Message-State: AHPjjUhGlq/QioQ0WWIooeIQzAvtTNMnXS0zZ0ofm8nsEnIdAbkPgPs0
        /0br9irp+kOgXChH
X-Google-Smtp-Source: ADKCNb75RfYc48UGAoOVTCUHMq2Gc+bzKqTnDrfIYdK92MSzOMpj1Gk8WMS3qVb+pp3RMDPcx9MM9w==
X-Received: by 10.223.193.71 with SMTP id w7mr25159652wre.158.1505549297148;
        Sat, 16 Sep 2017 01:08:17 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:16 -0700 (PDT)
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
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 24/40] external-odb: add 'get_direct' support
Date:   Sat, 16 Sep 2017 10:07:15 +0200
Message-Id: <20170916080731.13925-25-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
 external-odb.c | 21 ++++++++++++++++++++-
 external-odb.h |  1 +
 odb-helper.c   | 27 +++++++++++++++++++++++++--
 odb-helper.h   |  2 ++
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 52cb448d01..31d21bfe04 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -96,7 +96,8 @@ int external_odb_get_object(const unsigned char *sha1)
 		int ret;
 		int fd;
 
-		if (!odb_helper_has_object(o, sha1))
+		if (!(o->supported_capabilities & ODB_HELPER_CAP_GET_RAW_OBJ) &&
+		    !(o->supported_capabilities & ODB_HELPER_CAP_GET_GIT_OBJ))
 			continue;
 
 		fd = create_object_tmpfile(&tmpfile, path);
@@ -122,6 +123,24 @@ int external_odb_get_object(const unsigned char *sha1)
 	return -1;
 }
 
+int external_odb_get_direct(const unsigned char *sha1)
+{
+	struct odb_helper *o;
+
+	if (!external_odb_has_object(sha1))
+		return -1;
+
+	for (o = helpers; o; o = o->next) {
+		if (!(o->supported_capabilities & ODB_HELPER_CAP_GET_DIRECT))
+			continue;
+		if (odb_helper_get_direct(o, sha1) < 0)
+			continue;
+		return 0;
+	}
+
+	return -1;
+}
+
 int external_odb_put_object(const void *buf, size_t len,
 			    const char *type, unsigned char *sha1)
 {
diff --git a/external-odb.h b/external-odb.h
index d369dfdf6f..1fda08c0fb 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -4,6 +4,7 @@
 extern const char *external_odb_root(void);
 extern int external_odb_has_object(const unsigned char *sha1);
 extern int external_odb_get_object(const unsigned char *sha1);
+extern int external_odb_get_direct(const unsigned char *sha1);
 extern int external_odb_put_object(const void *buf, size_t len,
 				   const char *type, unsigned char *sha1);
 
diff --git a/odb-helper.c b/odb-helper.c
index 1f4666b349..3d940a3171 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -425,14 +425,37 @@ static int odb_helper_get_git_object(struct odb_helper *o,
 	return 0;
 }
 
+int odb_helper_get_direct(struct odb_helper *o,
+			  const unsigned char *sha1)
+{
+	struct odb_helper_object *obj;
+	struct odb_helper_cmd cmd;
+
+	obj = odb_helper_lookup(o, sha1);
+	if (!obj)
+		return -1;
+
+	if (odb_helper_start(o, &cmd, 0, "get_direct %s", sha1_to_hex(sha1)) < 0)
+		return -1;
+
+	if (odb_helper_finish(o, &cmd))
+		return -1;
+
+	return 0;
+}
+
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
diff --git a/odb-helper.h b/odb-helper.h
index 0571ba09cb..fbb6d333ee 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -35,6 +35,8 @@ extern int odb_helper_has_object(struct odb_helper *o,
 extern int odb_helper_get_object(struct odb_helper *o,
 				 const unsigned char *sha1,
 				 int fd);
+extern int odb_helper_get_direct(struct odb_helper *o,
+				 const unsigned char *sha1);
 extern int odb_helper_put_object(struct odb_helper *o,
 				 const void *buf, size_t len,
 				 const char *type, unsigned char *sha1);
-- 
2.14.1.576.g3f707d88cd

