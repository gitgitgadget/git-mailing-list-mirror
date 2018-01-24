Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484251F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933257AbeAXLMn (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:12:43 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33865 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933158AbeAXLM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 06:12:28 -0500
Received: by mail-lf0-f67.google.com with SMTP id k19so4734746lfj.1
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 03:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=KbXydaKG2NNFXP2mT8nxBlJUrm7OSd22LI268sg7mYY=;
        b=ersTUeJHDNTIyjmM4zWy09QDE68GHEIwqdQpOZyczl2DUEqPwcGFKxRqIJmS3Znokq
         MF0GluXCEd3nGnS7E/64NAw+l7MvsdghCExvhvGgxy1KE+huz9yqZxb4PJkK15JNyJPV
         6JKThcx6gv8dcZwRinCNnvJHLspAGeEPaQcXantWju22s4it8PQsFRf+d7TVESXAH9AJ
         OsjGglkk68wHf1f74vyAXdTtBmohjn1i+IapNUwaz7WRo6sG1LsLaEGunBpXrHhfyeR3
         1YHvN+0BaJdQ89atxC1XK9gRomdyEHTIlopA+KsR2ecN2Iqe5wfR8FBogOMOnG6+7m0C
         VKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=KbXydaKG2NNFXP2mT8nxBlJUrm7OSd22LI268sg7mYY=;
        b=G1kwZCqPfPH3jNWkrxA+Bs3kffnCzJyBl92wbwMXQ4pvWYhlsGguzLcpu+wXZULcoF
         3D/GqtPytZwdTnn20XXFGKKF3LTucCvXI7lTsy+mQCOtXascmvzD4JLNJZRXc1krbkKw
         zwTXu0bext+tPFCB847E6M+wjw2XiDvO6SmXfGoJrscZKq9DKZz6P6o8wGT9q9NVU1Es
         BwiwafWb7f1F31XwiA32zh0n2EIQwUaR8a2Qm5mwgx0a3MTE5+qswEHVwBXOcJWHlNgo
         m5NEphWas6ioBWj9RYCYwc/pBGhF+vZkxefbVA2/n+zIjQTnCBJmahAR7sBYbmuZzNKN
         +/5Q==
X-Gm-Message-State: AKwxyteOJxOxVvKKgtfq1/K8cuvvk+vbJVrwBGGVAk8b42gY1LSKfYcq
        QOmnJFJN5oCcAjJT/wU9xWonUqcl
X-Google-Smtp-Source: AH8x226BDgXv4019Pr+zuRbOTXaksCFf0AtTaLeKWwhf6SS/gKk6sdtVGTjfwyl63EKhmnfdnhOYew==
X-Received: by 10.25.215.72 with SMTP id o69mr3245768lfg.103.1516792346911;
        Wed, 24 Jan 2018 03:12:26 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id i18sm14426ljd.27.2018.01.24.03.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 03:12:26 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 14/14] sha1_file: rename hash_sha1_file_literally
Date:   Wed, 24 Jan 2018 12:12:06 +0100
Message-Id: <06746851ecdf9c34608ecc4f26e19194da972478.1516790478.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
 <cover.1516790478.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
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

