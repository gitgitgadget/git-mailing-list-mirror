Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6002D20248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfC3LVE (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:21:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42060 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbfC3LVD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:21:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id cv12so2217302plb.9
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=szpMHP8EhvpaCOO0W8tVbc6AFYjGROhwwjWwnfbVc9o=;
        b=UaPsLQTzrlT9nR6EBwN1KEt8/7ZJ29ry8K6uDDqTgCFtSHynHxI91XYuaVFC07bE+S
         63yvq3eMDb8XnXMS2GQsHvxrbWc5aemoXFCGffVC95CEYRXiOtOFPc1j52TziIWDiTvm
         M5UlHaTc+m341MhFltQOQaDIsLBS+hTyEQvB629qGFQD6uvd3M+3u693UaZEphn5hQUn
         L+YuriNP+uPGwPXwedLjZPjDcJHre3d4rVZo0u0BSiTK/pIJQ+c3R4D7PNATX3ZM4TN0
         cNgCg+ek2Jfj9+FDE+NciRE69toVsbVGTMXR2jJ+S/5DXxLMXQF5JWnnWUxIWpQkdXfq
         1bBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=szpMHP8EhvpaCOO0W8tVbc6AFYjGROhwwjWwnfbVc9o=;
        b=n9B/5HABuAGylpe2XrT8T/9Ze1ku8egBEiv3LNPytxQCuIBJHrgEhx9qI2ojUSCDjp
         hbe99MyEkJ5U/u8cOFChhlTVhUKX11koX26b20OuI9aLpWS0EBtyT2ulxvlH37ZnPoKH
         aGKjH5EVY1+kVA6Eb8DhF1YCQ++iB5Ha/hT3g2PUXeL12JB4YvGdCqiuc21wFCYHO5JF
         FjqTpb0C3BJ/snAhGsmr3JqmBPot/HXanNfPhBCB2S1S0yFp+rr0kcW68oAX48mjmT14
         5uJpx6V1r/yQBzLdzgK1Tc5RTPaOFcRSvS/PFkbw1ZVaFlJOHwfyuYhrxVrRJNHx8Bmm
         AoSw==
X-Gm-Message-State: APjAAAW1P1eJtKlXHJZgBNijn+9VU0a/g0xnXW4RGLkicpIHmm3hlZ9J
        x4jJ6u4FdfnqiWrEkPayfb82b7AT
X-Google-Smtp-Source: APXvYqx44OsJ3t4MAcU/i/2C4MB6xuCxrIkOTeK7w43sv2L6TnF9eSS82j/y8TQlUUWNMgktRlKmbQ==
X-Received: by 2002:a17:902:282b:: with SMTP id e40mr53647238plb.111.1553944862652;
        Sat, 30 Mar 2019 04:21:02 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id d69sm8651263pfg.26.2019.03.30.04.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:21:02 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:20:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/31] refs.c: add repo_dwim_log()
Date:   Sat, 30 Mar 2019 18:19:03 +0700
Message-Id: <20190330111927.18645-8-pclouds@gmail.com>
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
 refs.c | 21 +++++++++++++++------
 refs.h |  1 +
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index bd0fec5776..edea001446 100644
--- a/refs.c
+++ b/refs.c
@@ -603,9 +603,11 @@ int expand_ref(struct repository *repo, const char *str, int len,
 	return refs_found;
 }
 
-int dwim_log(const char *str, int len, struct object_id *oid, char **log)
+int repo_dwim_log(struct repository *r, const char *str, int len,
+		  struct object_id *oid, char **log)
 {
-	char *last_branch = substitute_branch_name(the_repository, &str, &len);
+	struct ref_store *refs = get_main_ref_store(r);
+	char *last_branch = substitute_branch_name(r, &str, &len);
 	const char **p;
 	int logs_found = 0;
 	struct strbuf path = STRBUF_INIT;
@@ -617,13 +619,15 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 
 		strbuf_reset(&path);
 		strbuf_addf(&path, *p, len, str);
-		ref = resolve_ref_unsafe(path.buf, RESOLVE_REF_READING,
-					 &hash, NULL);
+		ref = refs_resolve_ref_unsafe(refs, path.buf,
+					      RESOLVE_REF_READING,
+					      &hash, NULL);
 		if (!ref)
 			continue;
-		if (reflog_exists(path.buf))
+		if (refs_reflog_exists(refs, path.buf))
 			it = path.buf;
-		else if (strcmp(ref, path.buf) && reflog_exists(ref))
+		else if (strcmp(ref, path.buf) &&
+			 refs_reflog_exists(refs, ref))
 			it = ref;
 		else
 			continue;
@@ -639,6 +643,11 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 	return logs_found;
 }
 
+int dwim_log(const char *str, int len, struct object_id *oid, char **log)
+{
+	return repo_dwim_log(the_repository, str, len, oid, log);
+}
+
 static int is_per_worktree_ref(const char *refname)
 {
 	return !strcmp(refname, "HEAD") ||
diff --git a/refs.h b/refs.h
index fd3dc1d0f4..859dffe691 100644
--- a/refs.h
+++ b/refs.h
@@ -150,6 +150,7 @@ void expand_ref_prefix(struct argv_array *prefixes, const char *prefix);
 
 int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int repo_dwim_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
+int repo_dwim_log(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
-- 
2.21.0.479.g47ac719cd3

