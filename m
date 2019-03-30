Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB96520248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfC3LVI (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:21:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37885 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbfC3LVI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:21:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so2435397pgq.4
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LaAroo8H6l5o6UF7G2ggzqIjs+ycGdPBE3mfbGzd8Qc=;
        b=udxXEFznlflb8FuPoyglbDtxFlHYRK81YGvWkedN0BmFfVLmTKuE/0C/zA7LFidoAS
         s2vXT2hfQrrji3mkv+M0LpI2ajAEI+ZwVCRZwM2QUAUSALORhGpNp25jai3EM2L55QNA
         rbCgqLYSujr2T/q62VNrxx2Owt7pDKp8/xn4141eRhBvJjjkfyxKcjQ5Afl0Nx3CgdzJ
         AMcwciLCGzlzJqnn6g6VzTtATjnW5ZP07jCfhPMDRdrC9VHorHT4sCmch9xJSF9RdcEU
         e9EDEEUM4YQKN3E7nnoFw0fqhH/ycJYf5MWvk4rz0w89FrIbMtOmvOwfu55G5Ye6LMlF
         oD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LaAroo8H6l5o6UF7G2ggzqIjs+ycGdPBE3mfbGzd8Qc=;
        b=ZYUXcUWNfPEhCN8NFr7Heye0VYHy7CzWGjLcKrhb0qTgiKYo3pJT+qnx7vLyzyUJXk
         xkTd9MjNiudbIM+SrWq33Ekv3eROz7II5IUGZ5djfKA0yHVMcsTx8g3rfPzeE30Cvf87
         4T7APn62Ldjg72dw0+uWF/UKUW4wdfZov0PnxKgz+feEHolqObeSRPr37yfl/gXrUOtC
         eRK9BdN/dT9GwmLiSw265KyzlGaiUK9WNhFBvw7J01W4+S6Rp9a+Jh47q6o0c6Kxe5wO
         cnvFcLQBA44Iy2MKfYu4ZHeh0z8deqlNwgo94hxK8xWAv7axXprxU4lAHqdW2IBhMnfz
         72cQ==
X-Gm-Message-State: APjAAAXt4FI3vPh5ulU7TrJieTJoB6LTeyNIvizmmbv2d7V8bdVHDmwN
        ha+vzbfgd0dRiJoZPk/SJKyc14ng
X-Google-Smtp-Source: APXvYqxhYtW6b3J2O9VhfmpYBwfQhCy3i2ybEXMzyrf7igjUlhW3hcHEsWEb0MZ36j3Z5lwpNfRJiw==
X-Received: by 2002:aa7:9095:: with SMTP id i21mr30016520pfa.134.1553944867392;
        Sat, 30 Mar 2019 04:21:07 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id o5sm19441001pfa.135.2019.03.30.04.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:21:06 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:21:02 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/31] refs.c: remove the_repo from read_ref_at()
Date:   Sat, 30 Mar 2019 18:19:04 +0700
Message-Id: <20190330111927.18645-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/show-branch.c | 6 ++++--
 refs.c                | 7 ++++---
 refs.h                | 3 ++-
 sha1-name.c           | 3 ++-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 934e514944..082daeac32 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -753,7 +753,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				/* Ah, that is a date spec... */
 				timestamp_t at;
 				at = approxidate(reflog_base);
-				read_ref_at(ref, flags, at, -1, &oid, NULL,
+				read_ref_at(get_main_ref_store(the_repository),
+					    ref, flags, at, -1, &oid, NULL,
 					    NULL, NULL, &base);
 			}
 		}
@@ -765,7 +766,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			timestamp_t timestamp;
 			int tz;
 
-			if (read_ref_at(ref, flags, 0, base + i, &oid, &logmsg,
+			if (read_ref_at(get_main_ref_store(the_repository),
+					ref, flags, 0, base + i, &oid, &logmsg,
 					&timestamp, &tz, NULL)) {
 				reflog = i;
 				break;
diff --git a/refs.c b/refs.c
index edea001446..92d1f6dbdd 100644
--- a/refs.c
+++ b/refs.c
@@ -967,7 +967,8 @@ static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid
 	return 1;
 }
 
-int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, int cnt,
+int read_ref_at(struct ref_store *refs, const char *refname,
+		unsigned int flags, timestamp_t at_time, int cnt,
 		struct object_id *oid, char **msg,
 		timestamp_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 {
@@ -983,7 +984,7 @@ int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, in
 	cb.cutoff_cnt = cutoff_cnt;
 	cb.oid = oid;
 
-	for_each_reflog_ent_reverse(refname, read_ref_at_ent, &cb);
+	refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent, &cb);
 
 	if (!cb.reccnt) {
 		if (flags & GET_OID_QUIETLY)
@@ -994,7 +995,7 @@ int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, in
 	if (cb.found_it)
 		return 0;
 
-	for_each_reflog_ent(refname, read_ref_at_ent_oldest, &cb);
+	refs_for_each_reflog_ent(refs, refname, read_ref_at_ent_oldest, &cb);
 
 	return 1;
 }
diff --git a/refs.h b/refs.h
index 859dffe691..8f9cbf8a93 100644
--- a/refs.h
+++ b/refs.h
@@ -388,7 +388,8 @@ int refs_create_reflog(struct ref_store *refs, const char *refname,
 int safe_create_reflog(const char *refname, int force_create, struct strbuf *err);
 
 /** Reads log for the value of ref during at_time. **/
-int read_ref_at(const char *refname, unsigned int flags,
+int read_ref_at(struct ref_store *refs,
+		const char *refname, unsigned int flags,
 		timestamp_t at_time, int cnt,
 		struct object_id *oid, char **msg,
 		timestamp_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
diff --git a/sha1-name.c b/sha1-name.c
index d535bb82f7..15a1107998 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -849,7 +849,8 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 				return -1;
 			}
 		}
-		if (read_ref_at(real_ref, flags, at_time, nth, oid, NULL,
+		if (read_ref_at(get_main_ref_store(the_repository),
+				real_ref, flags, at_time, nth, oid, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (!len) {
 				if (starts_with(real_ref, "refs/heads/")) {
-- 
2.21.0.479.g47ac719cd3

