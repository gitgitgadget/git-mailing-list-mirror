Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8B4E1FAE2
	for <e@80x24.org>; Sat,  3 Mar 2018 11:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932080AbeCCLiG (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:38:06 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42454 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbeCCLiG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:38:06 -0500
Received: by mail-pf0-f194.google.com with SMTP id a16so5138790pfn.9
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5WowLCZNClsndAcbVMAxASWeMiDMfatx25MGH4U3u9k=;
        b=aBuMkcmWvoW2DSJCssBQDvC8wscvsv9cXKIsTuT0qopvEn4PviHq/vk0OawFmPHXLB
         tLvRf4B6x+yKMTRCtf/KaExFv+XityfxdTSjsZSXju52lSpgx4rZPEwC3zg28lF+Ifho
         p7dtO8T4P+f8UGJXsoG/ncYn9/8SsZZ082/xSBT3fuv3mVJyQH7zYrzcrrkYtAznuK35
         zljiBgJDk5dwTUX75g394L9XKMl8lDstkHSU/jtdP8At8YyOQu9ZEQqTv0WFvyfUAbjR
         1kqRMUbNfcH4frC89W1kwbogqNO4rJu9cTdxZqbLyI5MXzglgq3KsRvl5FeMslHXRE3h
         F7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5WowLCZNClsndAcbVMAxASWeMiDMfatx25MGH4U3u9k=;
        b=HwyucDxxQXJ98p0KmbikSzgLzyqNXmyUHM4ZwFsa64z8pgwU5+fTOocNezwgDANFtz
         uJMlMQwLIfICU0ODDvXTIeDVt2+9AReK5zCrXOPV6LGFuv1KXtqp2LnHBWbGe68xWwGv
         BNHUSGaAaI+fk3HHR/C5Jlb+tLP0Yf3txdMa/NJ1nhEqsC7cS3Pfbg6wKnQR0KIidrTk
         OawMf4SLFsxw9bTh7ds9kXvwalWoJQ48TvqyN3vr3xJvqo5kNBDuJqFqZHnXxAF4HrxM
         mq0s5AVe62ZaGVn9tJMgwgxNL5HoO+QyDycsDeDys3SGsuqBwfFhZtfB+bFP+fWgqtQg
         k5Lg==
X-Gm-Message-State: APf1xPBgqHZeX21CMSpWaPbeJ9mmsou58NQAtN/LrQGM5JHFmUqDRZlb
        ZzEd4jrSu6TfBF0srOxG8gcvyw==
X-Google-Smtp-Source: AG47ELvT3H7VmY8EvqTQWM9tlraRa/56DDFKO7JL1kOW6YqgtgsWs0daCNf0i5QE0gZ9EsKOqKofWA==
X-Received: by 10.101.75.140 with SMTP id t12mr7254836pgq.442.1520077085360;
        Sat, 03 Mar 2018 03:38:05 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id y7sm19257048pfi.80.2018.03.03.03.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:38:04 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:38:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/44] sha1_file: add repository argument to read_info_alternates
Date:   Sat,  3 Mar 2018 18:36:09 +0700
Message-Id: <20180303113637.26518-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
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
---
 sha1_file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 2ee5fe6ba3..175ea58686 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -389,7 +389,9 @@ static int alt_odb_usable(struct raw_object_store *o,
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
@@ -430,7 +432,7 @@ static int link_alt_odb_entry_the_repository(const char *entry,
 	ent->next = NULL;
 
 	/* recursively add alternates */
-	read_info_alternates(pathbuf.buf, depth + 1);
+	read_info_alternates(the_repository, pathbuf.buf, depth + 1);
 
 	strbuf_release(&pathbuf);
 	return 0;
@@ -496,7 +498,8 @@ static void link_alt_odb_entries(const char *alt, int sep,
 	strbuf_release(&objdirbuf);
 }
 
-static void read_info_alternates(const char * relative_base, int depth)
+static void read_info_alternates_the_repository(const char *relative_base,
+						int depth)
 {
 	char *path;
 	struct strbuf buf = STRBUF_INIT;
@@ -677,7 +680,7 @@ void prepare_alt_odb(void)
 	link_alt_odb_entries(the_repository->objects.alternate_db,
 			     PATH_SEP, NULL, 0);
 
-	read_info_alternates(get_object_directory(), 0);
+	read_info_alternates(the_repository, get_object_directory(), 0);
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
-- 
2.16.1.435.g8f24da2e1a

