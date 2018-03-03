Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAFED1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932111AbeCCLig (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:38:36 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34362 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeCCLif (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:38:35 -0500
Received: by mail-pf0-f195.google.com with SMTP id j20so5144882pfi.1
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w7zF7vUcNjqr2MAtLn/cDP0BAjBW1g+T6vvIE2yL55I=;
        b=g1epgncuxHwUjclobI8hdne0YbJupTz8niWEypno4R7DXJ06BBrAGfBWBs4O8ThC5Y
         N7JDqT93Kw+QpbCiYEbCTj3Q9Uy23J9z+wto56UXWIENSLo8ZYjfnA9oz/Nr7mwuYYIi
         V/6VSU9i+5v2qihfljo7lKskBH+wzWvdRFDag2PTL2JmAFm+Z/XHClGDaGuWLJ3rV32a
         2Qm0RPmZv5P+t27vMpp33XEnf7FMe3EFVNfrSfUf7CGUEG28KOBKDI7XeVnk02Oz1/+7
         zjKM7xSRvSzh1Dr0LmddsTTZvagK0yQOyAbtxyCWo/w3FHJFoD36qCqZLrKpQ4nSu1qQ
         98qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7zF7vUcNjqr2MAtLn/cDP0BAjBW1g+T6vvIE2yL55I=;
        b=mql5fJAMT1TWpxmKwp72Mw3MFvmjHjOkovVrj/GOYfrRMv5dn92TWduRyXny+agYj7
         lxpv/DayzIYbOFtwt+3zQa2BkoO2UCnFtXOJcrGzuxf0jWZETSSzwE5pwbyp6jZZnXV/
         lTXepHYpm+xvC/+AijobSO5SQHPhZOunOGTyDBVTe0LJBtWqiHxlhjjfWWkTV4LNbHss
         B7nxasbO/vrJOoWYLYrFL3vQvQ65pQZxSimSG5vUzOCnEqm2MQ5/W7Jse3ZiWApr/izb
         CMV9eMNLurruApDC3a79Iv+6cH+DgALX6mOL/Hu2eUZrSEfc8uEa86wqIY1WwhdiOD9U
         UNkQ==
X-Gm-Message-State: APf1xPAvVQB7NaY4TA//C9Ttqa8ueZ879hzfXrpQ/X8cUuE28f70rDmc
        vyWwYBgdb1Fa5mehIdSC78IFYg==
X-Google-Smtp-Source: AG47ELtQUMgUw1Y6UidU3XT7W+Tgfo+jUJ8ETZcnMz9bmQA0uqBPIYefT1Lvd0JyIfdm27Jwv3JZGg==
X-Received: by 10.101.85.71 with SMTP id t7mr7024567pgr.386.1520077114537;
        Sat, 03 Mar 2018 03:38:34 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id k23sm16361460pfi.79.2018.03.03.03.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:38:33 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:38:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 22/44] sha1_file: add repository argument to stat_sha1_file
Date:   Sat,  3 Mar 2018 18:36:15 +0700
Message-Id: <20180303113637.26518-23-pclouds@gmail.com>
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

Add a repository argument to allow the stat_sha1_file caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1_file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index e06d62a451..7b640cca28 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -867,8 +867,9 @@ int git_open_cloexec(const char *name, int flags)
  * Note that it may point to static storage and is only valid until another
  * call to sha1_file_name(), etc.
  */
-static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
-			  const char **path)
+#define stat_sha1_file(r, s, st, p) stat_sha1_file_##r(s, st, p)
+static int stat_sha1_file_the_repository(const unsigned char *sha1,
+					 struct stat *st, const char **path)
 {
 	struct alternate_object_database *alt;
 	static struct strbuf buf = STRBUF_INIT;
@@ -1174,7 +1175,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
-		if (stat_sha1_file(sha1, &st, &path) < 0)
+		if (stat_sha1_file(the_repository, sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
@@ -1388,7 +1389,7 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 		die("replacement %s not found for %s",
 		    sha1_to_hex(repl), sha1_to_hex(sha1));
 
-	if (!stat_sha1_file(repl, &st, &path))
+	if (!stat_sha1_file(the_repository, repl, &st, &path))
 		die("loose object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), path);
 
-- 
2.16.1.435.g8f24da2e1a

