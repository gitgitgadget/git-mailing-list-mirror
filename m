Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7A9D1F404
	for <e@80x24.org>; Sun, 28 Jan 2018 00:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbeA1ANo (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 19:13:44 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38916 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752352AbeA1ANl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 19:13:41 -0500
Received: by mail-lf0-f65.google.com with SMTP id w27so5025311lfd.6
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 16:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=KbXydaKG2NNFXP2mT8nxBlJUrm7OSd22LI268sg7mYY=;
        b=Yf5yEslArcmWbguJaJrtKeu9fcWxtkCQocFHvrhW/LZzL7mfkP02MDvMBUpCEm1QDf
         3Xt6v3VODT4BkEjN/nE/usDN8eZvI4FjGUdSfGRd/SlplmHqczae6glZF8OvzJC3hprW
         TKhg73XhwNteWiYk8qwlUv0Sf1MhqsbOQW/XUMA0uIVGZb7cq7PuMijicwM66HrDetRL
         AXataryEG4g4+tpQt3PL3IamrWXYutTalhIQ+fMar/ymhMCgihu1KgoN97ff9OObkmhH
         2wKgFmTFACEizZQpL+iX1giNG6curDMyZCcwIb3DWHTSvtJxROzgdOlkSVg2zOP7TC0E
         uxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=KbXydaKG2NNFXP2mT8nxBlJUrm7OSd22LI268sg7mYY=;
        b=pqNjx0WNvcEbX70VTYSYiO2bvvOT+/1jvr3A3AGiPu92Y3yKTfpk/dD0UHy619bnUP
         IoiLBj+aUJUhRq7ubXG74dBvDaDDH5RxKUHo1a6/ftwp97+NXaqSsBZxQ2z8/OoMev/p
         ZCYsPMy9OMGclxIK7yhRqseZTvAHgt3LcX7CYnP0Ba/i0XcdM3HhGYzOgYcHKmNc3CeL
         sciLfp0gs21MlzBwqsRN4x7LVR8oZwn19PqKt4P8kUEWYIBFNzKRE/vHYmCZFRCARkXt
         9yX3SDdwSd8FSWB67m7kL+N6Mr9KlGKfifJe9OVWIwAqJZMww2vDzaBgXEroGiT45A/w
         vjeQ==
X-Gm-Message-State: AKwxytf+8VyM45Zm411plX1s3nEwDKO8y5auK8iEqtxyJdjzRkLXAYCC
        mkTgpfVdgQizgwMons0tQH26WIV3
X-Google-Smtp-Source: AH8x224a0KEiCH6n3L4vSRDyf/t9PeMV0tlOdm3haNa+hNTZBFI4KMecie6wObjW4sjsCuYnScSdZw==
X-Received: by 10.25.198.201 with SMTP id w192mr10048382lff.40.1517098419931;
        Sat, 27 Jan 2018 16:13:39 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id y26sm2144695lfk.30.2018.01.27.16.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 16:13:39 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 12/12] sha1_file: rename hash_sha1_file_literally
Date:   Sun, 28 Jan 2018 01:13:22 +0100
Message-Id: <5092a07b3545cbdce19b0959e3457d6b55c3237e.1517097306.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
 <cover.1517097306.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1517097306.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function was already converted to use struct object_id earlier.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 builtin/hash-object.c | 3 ++-
 cache.h               | 4 +++-
 sha1_file.c           | 5 +++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index c532ff9320..526da5c185 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -24,7 +24,8 @@ static int hash_literally(struct object_id *oid, int fd, const char *type, unsig
 	if (strbuf_read(&buf, fd, 4096) < 0)
 		ret = -1;
 	else
-		ret = hash_sha1_file_literally(buf.buf, buf.len, type, oid, flags);
+		ret = hash_object_file_literally(buf.buf, buf.len, type, oid,
+						 flags);
 	strbuf_release(&buf);
 	return ret;
 }
diff --git a/cache.h b/cache.h
index 0a8be9c87f..6ef4248931 100644
--- a/cache.h
+++ b/cache.h
@@ -1243,7 +1243,9 @@ extern int hash_object_file(const void *buf, unsigned long len,
 extern int write_object_file(const void *buf, unsigned long len,
 			     const char *type, struct object_id *oid);
 
-extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, struct object_id *oid, unsigned flags);
+extern int hash_object_file_literally(const void *buf, unsigned long len,
+				      const char *type, struct object_id *oid,
+				      unsigned flags);
 
 extern int pretend_object_file(void *, unsigned long, enum object_type,
 			       struct object_id *oid);
diff --git a/sha1_file.c b/sha1_file.c
index 59238f5bea..34c041e8cd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1652,8 +1652,9 @@ int write_object_file(const void *buf, unsigned long len, const char *type,
 	return write_loose_object(oid, hdr, hdrlen, buf, len, 0);
 }
 
-int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type,
-			     struct object_id *oid, unsigned flags)
+int hash_object_file_literally(const void *buf, unsigned long len,
+			       const char *type, struct object_id *oid,
+			       unsigned flags)
 {
 	char *header;
 	int hdrlen, status = 0;
-- 
2.14.3

