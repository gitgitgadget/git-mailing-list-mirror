Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93A6C1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 17:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeIIW1C (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 18:27:02 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:38946 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeIIW1C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 18:27:02 -0400
Received: by mail-lj1-f172.google.com with SMTP id l15-v6so15947085lji.6
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 10:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mVHGx1JTpVXa0ds892+8PxBxOtAYrM8hBhiMYaYArBQ=;
        b=GOIN2McXUEStqJxwKSHeSDYX/g7LVhUGRXKe1vwQDJtGl+3tXWl7tKbFaceZTfA/dD
         u8IyFjoylM35tEg0TbvYjB4tFkbooKIWfFJiLSdfgK3QtLyAHFCuDNZ7oAkKQINZL47O
         eMVQx2mpv96I1AYo1Dq7VPsuZahzo78f3EhfYJevwC3VtZBKA3G0sNHqiiO/kDBwcdaX
         SDtNkOIQzooULHK9+QACSGV9ubrP880OIuDY0zgNc7x11vPfHy6lKkmHzKqytzlc+d4s
         Qc2NCRIXBdN0G9sCKYejUbZFmVM6YfcHPzoaffWDxbC7lXz1PlT9DlIaUvXs7Wg1j3C7
         KxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mVHGx1JTpVXa0ds892+8PxBxOtAYrM8hBhiMYaYArBQ=;
        b=g38wX2ajlOXUdLha4mks+Ig6UZN1KMr73NinKovHxrY6qdZMM+rvw8UxbiwMMOa++6
         MWEslRgCYSq5+2gg2Tf6kmyDyE37A64fqJYRsf/8Rt1T0LY6NAfJFJqOsbcvfDRKR+yE
         KARbeSt3z6TJ2oJIcUgp5/ly8BzOnStoAU5MfFJxgqV2j3xJFpanFjqCBu2MFZwkvO5q
         ECh4kdDfmDwxyxUABvaVrh7cX/SdTC2mdP5ahaUUNtShoJpEbkkUboQ9X386qLoN5xCM
         zcJWTzD+8IrdnPfT8gF2CUBSIqY4ySJxMXg+Ms1GGJ0ARNxOZaM4ZWEwHCE59VfVcDR7
         L5SQ==
X-Gm-Message-State: APzg51Cj+mYvFBqOD8fDXqZT5mqYqa6KB5SzihpNMsFBFgTSkjMGkud5
        W3hZ3mLFsTvZaIKh2jzctKVxsamU
X-Google-Smtp-Source: ANB0VdaV4vRvS28SYi/FthsSJKZk6IB2mJLxY3cMkLlgRzuDPoZZYzvGX79EbBb1UQ9FfAHNLRoUcQ==
X-Received: by 2002:a2e:9243:: with SMTP id v3-v6mr9867681ljg.92.1536514597999;
        Sun, 09 Sep 2018 10:36:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u19-v6sm2317793lje.51.2018.09.09.10.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 10:36:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/6] t/helper: keep test-tool command list sorted
Date:   Sun,  9 Sep 2018 19:36:26 +0200
Message-Id: <20180909173631.1446-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909173631.1446-1-pclouds@gmail.com>
References: <20180909173631.1446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile             | 2 +-
 t/helper/test-tool.c | 2 +-
 t/helper/test-tool.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 5a969f5830..1208584fa1 100644
--- a/Makefile
+++ b/Makefile
@@ -729,8 +729,8 @@ TEST_BUILTINS_OBJS += test-repository.o
 TEST_BUILTINS_OBJS += test-revision-walking.o
 TEST_BUILTINS_OBJS += test-run-command.o
 TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
-TEST_BUILTINS_OBJS += test-sha1-array.o
 TEST_BUILTINS_OBJS += test-sha1.o
+TEST_BUILTINS_OBJS += test-sha1-array.o
 TEST_BUILTINS_OBJS += test-sigchain.o
 TEST_BUILTINS_OBJS += test-strcmp-offset.o
 TEST_BUILTINS_OBJS += test-string-list.o
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 0edafcfd65..79e03eecb5 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -34,8 +34,8 @@ static struct test_cmd cmds[] = {
 	{ "revision-walking", cmd__revision_walking },
 	{ "run-command", cmd__run_command },
 	{ "scrap-cache-tree", cmd__scrap_cache_tree },
-	{ "sha1-array", cmd__sha1_array },
 	{ "sha1", cmd__sha1 },
+	{ "sha1-array", cmd__sha1_array },
 	{ "sigchain", cmd__sigchain },
 	{ "strcmp-offset", cmd__strcmp_offset },
 	{ "string-list", cmd__string_list },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e954e8c522..4b7212827a 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -30,8 +30,8 @@ int cmd__repository(int argc, const char **argv);
 int cmd__revision_walking(int argc, const char **argv);
 int cmd__run_command(int argc, const char **argv);
 int cmd__scrap_cache_tree(int argc, const char **argv);
-int cmd__sha1_array(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
+int cmd__sha1_array(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
 int cmd__strcmp_offset(int argc, const char **argv);
 int cmd__string_list(int argc, const char **argv);
-- 
2.19.0.rc0.337.ge906d732e7

