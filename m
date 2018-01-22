Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0DC91F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeAVLFE (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:05:04 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39295 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbeAVLFB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:05:01 -0500
Received: by mail-wm0-f65.google.com with SMTP id b21so15976128wme.4
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=yDD08nKFcU5N/ZlS0KTwPsi4VkuvFLH8klEu8KjeXUE=;
        b=cYhQgfmxcYDvmt+SueBm2+IGAaz1mpGtq5QYq8QrcXoByuPD47wFXCtubzHXp4ADtz
         QCBOAplF7fP29clPicdWtCWYwG56y7Y/jeEyBIekXXLTXzAnGtStDfFbp9Gs6x30bxOi
         BMwurB/1wVEdOTO1fiUnBgkYIeqMs5OP2zXyBH2Iwj+1yYK3o0jHAIZvXm072gSvC3Zo
         yP9EPoU5g53XkukBx4YKPzU6bKICLrWkXRVK9WNSiUz8lpVX491UAD2/G4OetZg8eOn1
         bxFyDtSywCEM73VOiFEKQoieEUONShD8+//WrNOfq+Kxfbqnv5iqEse9T7OjGH3QIWle
         ZS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=yDD08nKFcU5N/ZlS0KTwPsi4VkuvFLH8klEu8KjeXUE=;
        b=n3eXbM1MwZOXwAw9T4gnJruuFCS/cOoiA10Xj+BuDvWkXcPlogevfJ4btH/VAcVfxD
         G19tQSY5gVdDC7fSLrSkTNgA65HBEbs5vhKmaw5jmJJHefpLYo6WPoP82m/hkzkiEm2i
         xFQ7/P1h6a/AYalRRQ5tPAOYVi1oOWBxPtbbb/dvV34mm7OrmGIak2hcRbLsIAQhvEEC
         Dn0vh4SLlQbK61P+ymN4zCgo7eQsNVFsH/3LORW4I+0Wj9ytvasTHpLVV42jlvPwMbhk
         A7lCVK9BSsYk+ZVUZNuHEBmT1sOWtcl2p/FnJhQS22M3fIdGIHtpSKr/FS1vgdKIAFpW
         R/VQ==
X-Gm-Message-State: AKwxytc+SLnRL1l9yiBJfauMkHh05l+Ly7G7GnOMj5d/lnEUEP52XB/z
        kEo8Q7seZv4bRbj36zUPp9XCbA+P
X-Google-Smtp-Source: AH8x2265idrkcm/WOi/JRBBPEpoLzxl+IaIKKr9YB5aQjZX8bLiE+BnZzvJJhCma4zScg1rrf+eKgQ==
X-Received: by 10.80.173.202 with SMTP id b10mr12786455edd.209.1516619099977;
        Mon, 22 Jan 2018 03:04:59 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id e12sm10833591edm.42.2018.01.22.03.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 03:04:58 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 14/14] sha1_file: rename hash_sha1_file_literally
Date:   Mon, 22 Jan 2018 12:04:37 +0100
Message-Id: <4c1d5a2f6ea5134cd05574855614a6a87f10edc0.1516617960.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
 <cover.1516617960.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function was already converted to use struct object_id earlier.
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

