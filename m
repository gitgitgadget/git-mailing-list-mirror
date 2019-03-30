Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48FA420248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfC3LV2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:21:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43506 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbfC3LV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:21:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so2247143pfd.10
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3tl6C17iYwwBOSBKh5AtgHHBV5w/wvyG2a5No1/lCw=;
        b=E/8aWgWsKpuYPa3XyJouGjx2ZMCDEt7JWWKSplQ6vOiwANVb0cBZdKLK2p5bl98ANB
         KOxYdKRaXcUoV4VPHS6X5j79764uy2mG17NNUEVhQLVcBgSbmkk0v7TRpKsysNXe1zRU
         La0Q8+E419Jl8/gKTBfOxOHVX2VeNH31sN4MQ7U2lPv6KvYsLRtvEQyCciTxMtK41qri
         XhazFCpjdSAKnSu36jYF5cyOY0w3VMv/E7+Jb6WMxIomSH9XSxnkVmBjk62rF0LXF2WK
         xK05bCOFi7qhoGNWsE1fSI2eaFdF8lRWmPdnrBQjbkJ/LPlutoVpVO13LWIhBoIG3SXC
         JReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3tl6C17iYwwBOSBKh5AtgHHBV5w/wvyG2a5No1/lCw=;
        b=ey8dbEPvv433OA12M45pqfn2Z48+3rdnBfn1Pl16Jj5oEJtlwyZRbt1XBTxNjIQURE
         DknzQkOrw/F2l/gusqLG+PcvBQetlApSkgEcZACmB919NlXfoekX5dJu8g7c7BloMjwB
         QdyUWvq6+RzowW+fvotJdFiUeBnrTRIExKgRkSnhNAGsiAITHMwBTvbHtaNN4kIl6kfy
         wIxKnWtCc5E4H+64dJLBxBmvkcp7YzGM/dPW6XsMRTku7C93EM2sC1/4hjGNYkJ7TfnT
         CCgkNTMF1MlB4M/MGknVnsq8fAoDd4YJHB1PSFjGWvTQWOOkEggHd+P4Jome05pdYg0D
         O0dQ==
X-Gm-Message-State: APjAAAWzEmUIeDiFh/7B6X0RbVO0Hej5xP833g7zT9sQfK82sHzaunBc
        rEiDS6uI4dRXWyieOv5M+3yQ65rY
X-Google-Smtp-Source: APXvYqxh/d1ylFLZiQ2jvttwj0pVz9IS3XYTDttFhCmYwE7I/OPIGsS6aCUmdVJeNWNsSoj9yleUCQ==
X-Received: by 2002:a63:f541:: with SMTP id e1mr50221458pgk.388.1553944887192;
        Sat, 30 Mar 2019 04:21:27 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id d38sm5646106pgd.40.2019.03.30.04.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:21:26 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:21:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/31] sha1-name.c: add repo_find_unique_abbrev_r()
Date:   Sat, 30 Mar 2019 18:19:08 +0700
Message-Id: <20190330111927.18645-13-pclouds@gmail.com>
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
 cache.h     |  6 ++++--
 sha1-name.c | 15 +++++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index fcb24b5781..4f8ebb0a67 100644
--- a/cache.h
+++ b/cache.h
@@ -1045,8 +1045,10 @@ extern void check_repository_format(void);
  * Note that while this version avoids the static buffer, it is not fully
  * reentrant, as it calls into other non-reentrant git code.
  */
-extern const char *find_unique_abbrev(const struct object_id *oid, int len);
-extern int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len);
+const char *repo_find_unique_abbrev(struct repository *r, const struct object_id *oid, int len);
+#define find_unique_abbrev(oid, len) repo_find_unique_abbrev(the_repository, oid, len)
+int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
+#define find_unique_abbrev_r(hex, oid, len) repo_find_unique_abbrev_r(the_repository, hex, oid, len)
 
 extern const unsigned char null_sha1[GIT_MAX_RAWSZ];
 extern const struct object_id null_oid;
diff --git a/sha1-name.c b/sha1-name.c
index b9381aaba6..9b57787b76 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -626,15 +626,16 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 		find_abbrev_len_for_pack(p, mad);
 }
 
-int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
+int repo_find_unique_abbrev_r(struct repository *r, char *hex,
+			      const struct object_id *oid, int len)
 {
 	struct disambiguate_state ds;
 	struct min_abbrev_data mad;
 	struct object_id oid_ret;
-	const unsigned hexsz = the_hash_algo->hexsz;
+	const unsigned hexsz = r->hash_algo->hexsz;
 
 	if (len < 0) {
-		unsigned long count = approximate_object_count();
+		unsigned long count = repo_approximate_object_count(r);
 		/*
 		 * Add one because the MSB only tells us the highest bit set,
 		 * not including the value of all the _other_ bits (so "15"
@@ -659,7 +660,7 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 	if (len == hexsz || !len)
 		return hexsz;
 
-	mad.repo = the_repository;
+	mad.repo = r;
 	mad.init_len = len;
 	mad.cur_len = len;
 	mad.hex = hex;
@@ -681,13 +682,15 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 	return mad.cur_len;
 }
 
-const char *find_unique_abbrev(const struct object_id *oid, int len)
+const char *repo_find_unique_abbrev(struct repository *r,
+				    const struct object_id *oid,
+				    int len)
 {
 	static int bufno;
 	static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
 	char *hex = hexbuffer[bufno];
 	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
-	find_unique_abbrev_r(hex, oid, len);
+	repo_find_unique_abbrev_r(r, hex, oid, len);
 	return hex;
 }
 
-- 
2.21.0.479.g47ac719cd3

