Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DFC31F576
	for <e@80x24.org>; Tue,  6 Mar 2018 10:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753431AbeCFKQY (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 05:16:24 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46135 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbeCFKQX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 05:16:23 -0500
Received: by mail-pl0-f65.google.com with SMTP id y8-v6so11578470pll.13
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 02:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJJ7xp1pMdxBt4QefJ6Q7piflYH3FxzHWT5S48g4gUE=;
        b=UkNcmUU0f7WlKTM/ikP5n4Eg6ZFr8vBPLdQletfJ0HZt+IubUKrMjTwP3Fh1d7hNbY
         KBIhmjcU74ut8oFSjyb+SXRo33SG0rj1YYp1whseaJf4HfovIgAiXsjpqSA2QdrTWlks
         7wQpdi7GOl5sFyzZ8f4mdJAc81y/SgoAsS0gxG6o0TXemZWwgKu6JpTqmFCmtDgcw6jQ
         HZpVZfL3buVeA1NpbuiL0QxYIxfUOj/1GDbISfExBQmfHpgXLf1yvIeV7sRF/k6JQMSd
         rlsqX6e65LlTUq8HNcG3NtBPI6VlYudFeE7Xz6i3e0wsYKMgbFEb+K48o9SYQ4Ekkifc
         REFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJJ7xp1pMdxBt4QefJ6Q7piflYH3FxzHWT5S48g4gUE=;
        b=YOeEGwTVJ7n55liqERLybl6Lt9APVoFeyRqAp5jtQW+aGVdjLmMUvZggVApcLXO3Kv
         RRl0fcwJma+S7brb+b21QdTZ5MJCmqHD3sd8WR1dQsj0j6hmER59D8K3ihPVrjKHX8hO
         hxp2GF05GoO4dfosCd+6p+e++USnKSWSpUugQXnyQOASWXfX3BX0+3oLyzonQD2uaJuU
         yzu8wNM76rNLf32rKr8ED9ITWQ2RrkwPl7ZJwLB8zyCmHn894LCe4HQyXaltY6qiwH+Z
         5QHwS57zOO8FqCBu0ClhoO72KUqybckiIHzZAFYSSxkhqL73oWl/P9c4LzBRy0xNiX9g
         QokQ==
X-Gm-Message-State: APf1xPDutwU2JMLctu3CXskt1gnccmhYaUpd0lFOoCvitTtiwin/6/vi
        fmr5O0ZrIpYRluvv6o8k/f2HOg==
X-Google-Smtp-Source: AG47ELuZ4sboQdXwTTZW+ZD1649F0iqSzbYc0nFpNU5xrC+i4bsWJXmj1W5xVcM/MgkOGDR0JWJ78Q==
X-Received: by 2002:a17:902:8b85:: with SMTP id ay5-v6mr16607262plb.329.1520331382321;
        Tue, 06 Mar 2018 02:16:22 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id 73sm27298431pfz.165.2018.03.06.02.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 02:16:20 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 06 Mar 2018 17:16:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] object.h: update flag allocation comment
Date:   Tue,  6 Mar 2018 17:16:14 +0700
Message-Id: <20180306101615.5173-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.784.gb291bd247e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the "flags" is shared, it's a good idea to keep track of who
uses what bit. When we need to use more flags in library code, we can
be sure it won't be re-used for another purpose by some caller.

While at there, fix the location of "5" (should be in a different
column than "4" two lines down)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/index-pack.c     | 1 +
 builtin/pack-objects.c   | 1 +
 builtin/reflog.c         | 1 +
 builtin/unpack-objects.c | 1 +
 object.h                 | 6 +++++-
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7e3e1a461c..b4239a633c 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -49,6 +49,7 @@ struct thread_local {
 	int pack_fd;
 };
 
+/* Remember to update object flag allocation in object.h */
 #define FLAG_LINK (1u<<20)
 #define FLAG_CHECKED (1u<<21)
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5c674b2843..833126e671 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2549,6 +2549,7 @@ static void read_object_list_from_stdin(void)
 	}
 }
 
+/* Remember to update object flag allocation in object.h */
 #define OBJECT_ADDED (1u<<20)
 
 static void show_commit(struct commit *commit, void *data)
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 2233725315..95becf0e7e 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -52,6 +52,7 @@ struct collect_reflog_cb {
 	int nr;
 };
 
+/* Remember to update object flag allocation in object.h */
 #define INCOMPLETE	(1u<<10)
 #define STUDYING	(1u<<11)
 #define REACHABLE	(1u<<12)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 7235d2ffbf..fba9498ffe 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -158,6 +158,7 @@ struct obj_info {
 	struct object *obj;
 };
 
+/* Remember to update object flag allocation in object.h */
 #define FLAG_OPEN (1u<<20)
 #define FLAG_WRITTEN (1u<<21)
 
diff --git a/object.h b/object.h
index 87563d9056..15901d2901 100644
--- a/object.h
+++ b/object.h
@@ -29,7 +29,7 @@ struct object_array {
 /*
  * object flag allocation:
  * revision.h:      0---------10                                26
- * fetch-pack.c:    0---5
+ * fetch-pack.c:    0----5
  * walker.c:        0-2
  * upload-pack.c:       4       11----------------19
  * builtin/blame.c:               12-13
@@ -40,6 +40,10 @@ struct object_array {
  * sha1_name.c:                                     20
  * list-objects-filter.c:                             21
  * builtin/fsck.c:  0--3
+ * builtin/index-pack.c:                            2021
+ * builtin/pack-objects.c:                          20
+ * builtin/reflog.c:          10--12
+ * builtin/unpack-objects.c:                        2021
  */
 #define FLAG_BITS  27
 
-- 
2.16.2.784.gb291bd247e

