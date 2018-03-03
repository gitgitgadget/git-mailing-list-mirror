Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 740F31F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeCCLjM (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:39:12 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40323 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeCCLjL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:39:11 -0500
Received: by mail-pg0-f67.google.com with SMTP id g8so213051pgv.7
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtWbozDubZCkcgaNrYh4X36PnWmxGv1mQNHgMPXrRn4=;
        b=sRnx3+VD13TG2IqWDKTyebqUgC+7z9qQentcYD8ko85nO21OP3HaQMPH/7RjpaVXMt
         CVdYyNDae7mDj22kjAXFGiItH5WcECTOPTPjvVwDhSW91BwJ8fio91q737d4YvGbHpW6
         x8PEwq8Xish3413M/HC5e9QuUbvIqQoFjtJWUZKQAVxQQ7o4ykk0l86mZamGg81dnByh
         S6D/9yJseMQbFHbAzRKskFp0gt4Yg81YEGvSaQgcQocFPOpPVoEHMnsA8Jj0qqRnFZ71
         wbu2qOZwKWdP7iduJE2WTJ0AJXVgKeizW8Np2pDtvlmnRFubZGoaPAb7lRy24nnPJJMi
         foYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtWbozDubZCkcgaNrYh4X36PnWmxGv1mQNHgMPXrRn4=;
        b=Lk5+eR4xeN78wlCTwj1GJdR4U/mv3bI0pCumfVbIZSIf6Qj9mFsWoFwZwtc9OjfW4Y
         kJbF0gZc9+Y07VKM4dpHYyH02Q2faw+Nq6UQPCLo1kO63Tk1LO4jCz0jeUDBJxuYWvoR
         yohPqbKlFkr4z2CVpEEAPGiAQxdRqzlwXUx0uQFBiiXxBM9IfbtqkiPmZQ8FWS7WGT2N
         ao18lR0dBzMkN1XpOyt4s3GMDVTKkGAxja7iR/mH+cxufOu8eSWU7RNUi6FHp5uMjZKu
         rtO0vSQLxixJ8RbB0/DfjvFspcGJirDoICu6k47xRY8b0+oCHFp1WwP9mXlAv2bV2hSM
         DM5A==
X-Gm-Message-State: APf1xPDXgwIashuLWkN3/wpozvpVFvSfl3PnramlN4g4iddKnnr8H1cW
        Rbkuxn9Z44TeoYXE0vwbUs9Lxw==
X-Google-Smtp-Source: AG47ELtZJ7LQITFylS+q5kvW3ttWo7iWyFjk8EO2NUmydQxJcODDxsA85nZE0dkZDun2Z2Y2ZDpQQA==
X-Received: by 10.98.245.131 with SMTP id b3mr8851764pfm.20.1520077151112;
        Sat, 03 Mar 2018 03:39:11 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id v14sm19818986pfi.8.2018.03.03.03.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:39:10 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:39:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 29/44] sha1_file: allow open_sha1_file to handle arbitrary repositories
Date:   Sat,  3 Mar 2018 18:36:22 +0700
Message-Id: <20180303113637.26518-30-pclouds@gmail.com>
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
 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f2533dd9e4..b3f7656c35 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -895,9 +895,8 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
  * Like stat_sha1_file(), but actually open the object and return the
  * descriptor. See the caveats on the "path" parameter above.
  */
-#define open_sha1_file(r, s, p) open_sha1_file_##r(s, p)
-static int open_sha1_file_the_repository(const unsigned char *sha1,
-					 const char **path)
+static int open_sha1_file(struct repository *r,
+			  const unsigned char *sha1, const char **path)
 {
 	int fd;
 	struct alternate_object_database *alt;
@@ -905,7 +904,7 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(the_repository, &buf, sha1);
+	sha1_file_name(r, &buf, sha1);
 	*path = buf.buf;
 
 	fd = git_open(*path);
@@ -913,8 +912,8 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
 		return fd;
 	most_interesting_errno = errno;
 
-	prepare_alt_odb(the_repository);
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	prepare_alt_odb(r);
+	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
-- 
2.16.1.435.g8f24da2e1a

