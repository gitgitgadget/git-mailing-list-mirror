Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C52F1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeCCLjW (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:39:22 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44664 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeCCLjV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:39:21 -0500
Received: by mail-pg0-f65.google.com with SMTP id l4so4859267pgp.11
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3rgNcjCt4Q8WEEJh299NJWWpigMWqDFfh3giTUzVAgk=;
        b=A6h3dMQejWXzfOQcZ50n+iAJBjjYWZGqtLfiqYQtdYAgY5Lx7ey9DF6etVzPk5PU/D
         g7LcKPsc7/k0fNRBzXlBM3rlO0T+g4DLT8efgO0ZrcHbfT8jJ70yR0hsFpFlncLSyZl9
         Xjf1Bmk1ltb0kk2ydVaGr0NraIlU2jUk/pkWcMJQt1dwmsWCzVSatEIXoFWmYEhIsXKN
         ETbAkXSh44xLv7lU5IQjxjz9aF+6pnv7j3JzOuYRp/K3/LcmUoKzxZP8l4rZaoByaELd
         cXcuE5Fd9IsdDYST55K+nJoPUNSzbvlSC1dITYp7glEh9UklynSpvxPd8SL+R8nCj6PM
         PdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3rgNcjCt4Q8WEEJh299NJWWpigMWqDFfh3giTUzVAgk=;
        b=jW6/cIo98bzwZURYwNCDCMp+yBnpUhAnpZD87KiFFGi+pHfkJaOAP5Mq1kO3M5HrjU
         IGs4xc8PGagJUB3MgZFncCJXtGv6605t3n0e0z+NwB1cycdIepaFsI1ikY3hfVN4hAZ1
         ETEAker8xT96kyVPUAGxzqQspuWYLPsC5/DZmcb6tdG+NwB2HFeHn0P2zSih26UrUjLu
         TmCpqEFOo8S8v61rRBKDux3uXZeBd3zozfM2ytYG2qJfjhy7szbG62+5Ha1wjAM2R+H7
         dIEBaA3UpILGwlmqkAwLsNZURTZYOVu2Ko7rg2vm1ERK+V2Yc2YduTY3ADX+BIyVmUXM
         ZCDw==
X-Gm-Message-State: APf1xPCHViB8J9eJw4v3869Bdk2yWM2r2dNl+jz7NpZGulWeqgxovIg8
        jM8jIA1mNdASrfVa4C6Ohlpp5w==
X-Google-Smtp-Source: AG47ELs0AYyDQoAM8QrpjV7cZsOe4HE4B+rxixJTMRNT7pMRp3CIlpKhiUFgD4henSG07uXWeQDzmA==
X-Received: by 10.101.101.10 with SMTP id x10mr7161112pgv.223.1520077160652;
        Sat, 03 Mar 2018 03:39:20 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id e82sm16232609pfh.89.2018.03.03.03.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:39:20 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:39:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 31/44] sha1_file: allow map_sha1_file to handle arbitrary repositories
Date:   Sat,  3 Mar 2018 18:36:24 +0700
Message-Id: <20180303113637.26518-32-pclouds@gmail.com>
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

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 object-store.h | 3 +--
 sha1_file.c    | 5 +++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index 98622a2b98..521f5a1755 100644
--- a/object-store.h
+++ b/object-store.h
@@ -121,7 +121,6 @@ void raw_object_store_clear(struct raw_object_store *o);
  */
 void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1);
 
-#define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
-void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
+void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
 
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index d4678f8162..c5a8b00aed 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -957,9 +957,10 @@ static void *map_sha1_file_1(struct repository *r, const char *path,
 	return map;
 }
 
-void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file(struct repository *r,
+		    const unsigned char *sha1, unsigned long *size)
 {
-	return map_sha1_file_1(the_repository, NULL, sha1, size);
+	return map_sha1_file_1(r, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
-- 
2.16.1.435.g8f24da2e1a

