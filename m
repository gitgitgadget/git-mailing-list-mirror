Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CFD21F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932085AbeCCLiL (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:38:11 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42408 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbeCCLiK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:38:10 -0500
Received: by mail-pg0-f68.google.com with SMTP id y8so4862222pgr.9
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fh51HMVwMzLXFGgfV+jEFPcCN8m4Be7GchqTaPFVvSE=;
        b=UN2jBuHNDSND+iIeqZOruNO0YOG5Dva6dOSRAcr38oavxCe8VjM0CbDvGI+nKmqtCt
         HDvaDvOAQN1tlP32a/d9L46tNE/o/aHXu6tsp5WlmshTCn6NakQhkBxsyoFVYhAaUeNY
         R0sKd6nT5PQE6Vjfygt5HjtxyJNiHKoQbTBgb2OGKy9UuECxGE2p7aZ0DBgq9vv6//GB
         rFTkweriYHoH0Lh04VnFsXv4kCry2BhuuKFDSex4u4ztdfcHYDVEdFeIw3ZdmrlUpFKi
         0VCbZkPYuvF706D2GKsbAuz/cKGQxq5/KnKEfshAhh/G2s8sbLxitjyobD8UI42BDVgf
         jQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fh51HMVwMzLXFGgfV+jEFPcCN8m4Be7GchqTaPFVvSE=;
        b=dpfLTDjAdw8XWhowZ91PiW74MTCQH8LVnGavr6hI59E/bAekTRJJuyS+3Kpd8JqZRY
         CBb/eY7KUtYZgLK4Z1FqzHhMJsZj/0hAMS81sRcUcuOo6ndX/AhEJewKl6QDndaR6wEz
         OVCkJQecyWeYmL5Uc7lx9vyRNLE7ebH9j/HX9kaCHXs3IH8HsyJUWXW4TKJi8U3fLU48
         LRnwPXD2qBDnhDMLY3bFP4OfZusudYiCQnt3gMjr7IVm7SBgji0aSUCEKo0vYF9FDx7x
         uLcspRzZZp1AKc41W79HIsMBElMf5WOb5nXmp6vmHzKz/e7fzi0yaVlwmyqh3OlyuwUY
         D9JA==
X-Gm-Message-State: APf1xPD+gxqO2N6xkIqG/UH/zlH9Onmpcs0O1FyoJyx83pmlgy73awU1
        MpynmoiAgLivCrftQHv+y/ObgQ==
X-Google-Smtp-Source: AG47ELucZSBd1o2SCEWZ8PC6uu5z2iMHLxXNnorsDTub2osI62/fN9pWQsUhXy1gjgDawdnn8LxAjw==
X-Received: by 10.98.194.219 with SMTP id w88mr8839299pfk.26.1520077090358;
        Sat, 03 Mar 2018 03:38:10 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 5sm19781939pfh.133.2018.03.03.03.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:38:09 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:38:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/44] sha1_file: add repository argument to link_alt_odb_entries
Date:   Sat,  3 Mar 2018 18:36:10 +0700
Message-Id: <20180303113637.26518-18-pclouds@gmail.com>
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
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1_file.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 175ea58686..4f9c07b547 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -467,8 +467,12 @@ static const char *parse_alt_odb_entry(const char *string,
 	return end;
 }
 
-static void link_alt_odb_entries(const char *alt, int sep,
-				 const char *relative_base, int depth)
+#define link_alt_odb_entries(r, a, s, rb, d) \
+	link_alt_odb_entries_##r(a, s, rb, d)
+static void link_alt_odb_entries_the_repository(const char *alt,
+						int sep,
+						const char *relative_base,
+						int depth)
 {
 	struct strbuf objdirbuf = STRBUF_INIT;
 	struct strbuf entry = STRBUF_INIT;
@@ -511,7 +515,7 @@ static void read_info_alternates_the_repository(const char *relative_base,
 		return;
 	}
 
-	link_alt_odb_entries(buf.buf, '\n', relative_base, depth);
+	link_alt_odb_entries(the_repository, buf.buf, '\n', relative_base, depth);
 	strbuf_release(&buf);
 	free(path);
 }
@@ -565,7 +569,8 @@ void add_to_alternates_file(const char *reference)
 		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
 		if (the_repository->objects.alt_odb_tail)
-			link_alt_odb_entries(reference, '\n', NULL, 0);
+			link_alt_odb_entries(the_repository, reference,
+					     '\n', NULL, 0);
 	}
 	free(alts);
 }
@@ -578,7 +583,8 @@ void add_to_alternates_memory(const char *reference)
 	 */
 	prepare_alt_odb();
 
-	link_alt_odb_entries(reference, '\n', NULL, 0);
+	link_alt_odb_entries(the_repository, reference,
+			     '\n', NULL, 0);
 }
 
 /*
@@ -677,7 +683,7 @@ void prepare_alt_odb(void)
 
 	the_repository->objects.alt_odb_tail =
 			&the_repository->objects.alt_odb_list;
-	link_alt_odb_entries(the_repository->objects.alternate_db,
+	link_alt_odb_entries(the_repository, the_repository->objects.alternate_db,
 			     PATH_SEP, NULL, 0);
 
 	read_info_alternates(the_repository, get_object_directory(), 0);
-- 
2.16.1.435.g8f24da2e1a

