Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081701F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeCCLjH (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:39:07 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37011 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbeCCLjG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:39:06 -0500
Received: by mail-pf0-f193.google.com with SMTP id h11so4746051pfn.4
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PoEAKmRF9MwcAIHhq+Vd6/Bmem8duy9EeZ8ZI9k3AxI=;
        b=s3TzOCtmJbM6WponpXzx1knXbpyKX4yNez/1/yJ9jTgsc+VJ3AAMP/FCToP04e/CUA
         p7SEVkobf7MhHcYyG3drDo3HXZBHllDy54K1IRJrfGBnPJyMQZ13vyGG+hTV2OKa0xwb
         DGV6sDacVrrPlObPeqkVzo6mwQbVIyvOezIWy1ftqd6nStXC83Ei4ncosZGMlW5BWaUa
         1MSoHVlPGqwOMUoJuG1tWQBfsUvURL5xsA+jpanSW9qy4oKUJQMIszc7B3i1aui/ZjG7
         4kU9Ler13QgB8QLGJiubORmQ5JvPavAM+LxJ1q6I0garIcPWlh3rvtfQtISo0RDdN+Zo
         eiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PoEAKmRF9MwcAIHhq+Vd6/Bmem8duy9EeZ8ZI9k3AxI=;
        b=LzH2EOUpOC3A3h0lRSCVIN0aDfn01PNkRWsOIY2TqgY2edfGRwKQz+RFbL6PHNvHS3
         hUqP5xiQDUjYiYL8a+DKtefulwYNEsL6cobhoPtNehalvY4ZGqWNVemJjv/h/cd2WJtE
         rrVHeRHKGg6eyMI5Bn80cT0z9tv04dHUVosVvyg0UapD/6wJDxu56K69K6Mc3/eCXG5b
         01fA+OJjmiig09C8hhyDRLY5TQ66b1kLgHF0U6OudsNkVbolYRadPJafv+6O0jNb+Xz8
         jIVSPljYFd7qr5PFteWyCiBEAhl8IAzf9P9gp6q6h99Izbu8l4QeZeXetUCfl7GWY12P
         ETzw==
X-Gm-Message-State: APf1xPDNLY265+E+lIwMlXJcrHOtkh68W/kg/ekVFukofSPSZOMZZILQ
        JiLcUAQS/pHIBHIpmBjt7F9yPw==
X-Google-Smtp-Source: AG47ELsxvNrdl4p8JbVZOHlWbVVawOPqDqfRBxcoM5QwQVCMITIb/Fe6QWOxYMS3owy9V5TamHs5mQ==
X-Received: by 10.101.92.72 with SMTP id v8mr7001147pgr.153.1520077145711;
        Sat, 03 Mar 2018 03:39:05 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id b72sm3871957pfl.21.2018.03.03.03.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:39:04 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:39:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 28/44] sha1_file: allow stat_sha1_file to handle arbitrary repositories
Date:   Sat,  3 Mar 2018 18:36:21 +0700
Message-Id: <20180303113637.26518-29-pclouds@gmail.com>
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
index e04e0587c2..f2533dd9e4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -867,23 +867,22 @@ int git_open_cloexec(const char *name, int flags)
  * Note that it may point to static storage and is only valid until another
  * call to sha1_file_name(), etc.
  */
-#define stat_sha1_file(r, s, st, p) stat_sha1_file_##r(s, st, p)
-static int stat_sha1_file_the_repository(const unsigned char *sha1,
-					 struct stat *st, const char **path)
+static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
+			  struct stat *st, const char **path)
 {
 	struct alternate_object_database *alt;
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(the_repository, &buf, sha1);
+	sha1_file_name(r, &buf, sha1);
 	*path = buf.buf;
 
 	if (!lstat(*path, st))
 		return 0;
 
-	prepare_alt_odb(the_repository);
+	prepare_alt_odb(r);
 	errno = ENOENT;
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		if (!lstat(*path, st))
 			return 0;
-- 
2.16.1.435.g8f24da2e1a

