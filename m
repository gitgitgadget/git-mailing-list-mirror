Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4CE1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932121AbeCCLik (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:38:40 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46697 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeCCLik (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:38:40 -0500
Received: by mail-pl0-f66.google.com with SMTP id y8-v6so7176147pll.13
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9IceEd8gnU4W96Rzw9dwf4JfzdrSWtfPbbx1U70/G8=;
        b=GGawA4ZhVQrAc3bWLwKQoGnnf29Hn/8oGH/h0AXMNmsitYyqqBOyMsUGcA7KkbKvJ2
         m4YLOkdALfU/QXdMUasBOrtOdfXrM8Cyaiftfxp84m4TXnhjHZNJe+cVPsRC6XnPV5uq
         s3DD5HwXFRa4jLKL7p0Qnz2m+LIOiKM2wxNGFoS65lHiwG5uWGwHH7Pd19F9QbZZ6HE1
         8B4IintsokcnmfCPOMn0b/kF+oPPKKAZccMc7NlaQI1htsVCkTO1Mu13huqbKXrKjCuR
         Tls8DkT+gWswplQvgx05TJGm7B7E9lq4uts2LACo/fGy1RksDBjP9taizvamyuyMXas0
         rAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9IceEd8gnU4W96Rzw9dwf4JfzdrSWtfPbbx1U70/G8=;
        b=b8uhIDNV5+J5qi+i97u5/UqLWRQHXYlWDjpsKt26O3pjh9hYWBm80AZx5C3huRtsU6
         f+Kq2u1dHUEVi+1w/VCNZsKTVH02o//3Ll3ioCI7a/3vDZelDy2gUdwtuFU8Bs12/h5t
         99OUDZibYaWKOqE1A2fpPYs0e6QA9+K83UXrS2r6W1Eobc3ctFe017XfFPFfOR2aVD49
         Dybz11jkhg2l6AcVqO7CTij0sLRme4EgooiUBurtHUSSqF5XS3Rfm9jH5EAAt/HqNoZp
         6c0yq5Y7cn84PLwhdQsCzCT+PzuYuhmvBqJ/63cOMC7kIuK4/jaEvhUcLQIcuQPWWD0S
         7QaA==
X-Gm-Message-State: AElRT7Gc+8jrjvgdFLQ2v4Z02qOAjr0WTdTsvogK1kWa7ydT27YUMgPf
        +tsd2wstk+LOIEzJzXx0lHKU4A==
X-Google-Smtp-Source: AG47ELvJTEjwZCz22C3wPLkwjI0bazJa09IotoR4Tk9ed2110AnEbi4xT9IS6b75yeJ0mqHsNdaHXw==
X-Received: by 2002:a17:902:52a6:: with SMTP id a35-v6mr2530489pli.179.1520077119389;
        Sat, 03 Mar 2018 03:38:39 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id s90sm18444582pfd.153.2018.03.03.03.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:38:38 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:38:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 23/44] sha1_file: add repository argument to open_sha1_file
Date:   Sat,  3 Mar 2018 18:36:16 +0700
Message-Id: <20180303113637.26518-24-pclouds@gmail.com>
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

Add a repository argument to allow the open_sha1_file caller to be
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
 sha1_file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 7b640cca28..d4298805e3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -896,7 +896,9 @@ static int stat_sha1_file_the_repository(const unsigned char *sha1,
  * Like stat_sha1_file(), but actually open the object and return the
  * descriptor. See the caveats on the "path" parameter above.
  */
-static int open_sha1_file(const unsigned char *sha1, const char **path)
+#define open_sha1_file(r, s, p) open_sha1_file_##r(s, p)
+static int open_sha1_file_the_repository(const unsigned char *sha1,
+					 const char **path)
 {
 	int fd;
 	struct alternate_object_database *alt;
@@ -939,7 +941,7 @@ static void *map_sha1_file_1(const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(sha1, &path);
+		fd = open_sha1_file(the_repository, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
-- 
2.16.1.435.g8f24da2e1a

