Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110591F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeCWRWs (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:48 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42886 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbeCWRVz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:21:55 -0400
Received: by mail-lf0-f66.google.com with SMTP id a22-v6so19370652lfg.9
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dxuuFc1Qnu9YW7NUbb5cN1u1alncCzRnRM3HtM0s/qU=;
        b=NexEZ6oVHHbibu6s63tHFN/6uRyA1tyQRv/CkiPcs44SAKiiWNEz2ZSz4gyCruU48Z
         xh3I1eSbHPnqXy/6X2wWyuoSx7ZeWzjGeR8JD4udl0PlDT3PUuu96dDqiPanqx/QCwCV
         gewIbgsi9a6XynqZCBvp9K9rm21ZsgqBrQqlGxLoFHJOUMasWQF83989iCP/qGPm3sWB
         f8e8NVPDmPd1MvbLnUZesURGPUQ3qvAx5jYEO4mAj9Jpnz4jYcVZdTNzsx/zBocC4LfC
         Shp/bRuNdO8pwRxLL67F18pqFle/S9LYNseDbu9Cj+u58+9D/I+C0q6H96b/eOQP7ag/
         7jEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dxuuFc1Qnu9YW7NUbb5cN1u1alncCzRnRM3HtM0s/qU=;
        b=Mrk31VmMP1flx/2Ij7p1zbOUdD9/dRVEhcCrtBU1CYlevymN8uhqlH9w99mpPBCWMM
         6+4F8J6qbLUZ/QTRpCU8ZVWBjuXIrzXNtUfeu8+OJAF3/fBn/RWI1rxhEjzdHNJ4xiNT
         pBq9ousXVnJ0aLe1t27X60Mz5MHSh1F4LovgCg4yNTxRTztFs8qvb+BnkOV0Gr7vzbe0
         WTkRgX4VZO38GRwFg9pDiSNR36EVHYIM6ImA3C9ftADaGK3z4bATFFmsVjGvhBDo+Kj3
         TDrIdt+ODH7dwM0lIPNzGRFEVvetd21RAgmUps6ZryON7MDcODUGCs+CTaEPxOySAly7
         mmyg==
X-Gm-Message-State: AElRT7EjmxwnlTvX8F1j7P0vGhIgjn4dEHXkXFWiqdb+KRtUqLFMWfgz
        bxjQy0rvfYgHv//TtWItlRGsPA==
X-Google-Smtp-Source: AG47ELt9b9+Qr7dlBpEIQH9QAY3JkCcjO8pE+x4UqR7i9sMmS1PeYCwO0NjVBRa+K8O7RYXVpvZrRQ==
X-Received: by 10.46.71.12 with SMTP id u12mr13431897lja.36.1521825714161;
        Fri, 23 Mar 2018 10:21:54 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:21:53 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/27] sha1_file: add repository argument to read_info_alternates
Date:   Fri, 23 Mar 2018 18:21:05 +0100
Message-Id: <20180323172121.17725-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

See previous patch for explanation.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 7c0ace646a..81ad2a84f2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -390,7 +390,9 @@ static int alt_odb_usable(struct raw_object_store *o,
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-static void read_info_alternates(const char * relative_base, int depth);
+#define read_info_alternates(r, rb, d) read_info_alternates_##r(rb, d)
+static void read_info_alternates_the_repository(const char *relative_base,
+						int depth);
 #define link_alt_odb_entry(r, e, rb, d, n) link_alt_odb_entry_##r(e, rb, d, n)
 static int link_alt_odb_entry_the_repository(const char *entry,
 	const char *relative_base, int depth, const char *normalized_objdir)
@@ -431,7 +433,7 @@ static int link_alt_odb_entry_the_repository(const char *entry,
 	ent->next = NULL;
 
 	/* recursively add alternates */
-	read_info_alternates(pathbuf.buf, depth + 1);
+	read_info_alternates(the_repository, pathbuf.buf, depth + 1);
 
 	strbuf_release(&pathbuf);
 	return 0;
@@ -497,7 +499,8 @@ static void link_alt_odb_entries(const char *alt, int sep,
 	strbuf_release(&objdirbuf);
 }
 
-static void read_info_alternates(const char * relative_base, int depth)
+static void read_info_alternates_the_repository(const char *relative_base,
+						int depth)
 {
 	char *path;
 	struct strbuf buf = STRBUF_INIT;
@@ -678,7 +681,7 @@ void prepare_alt_odb(void)
 	link_alt_odb_entries(the_repository->objects->alternate_db,
 			     PATH_SEP, NULL, 0);
 
-	read_info_alternates(get_object_directory(), 0);
+	read_info_alternates(the_repository, get_object_directory(), 0);
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
-- 
2.17.0.rc0.348.gd5a49e0b6f

