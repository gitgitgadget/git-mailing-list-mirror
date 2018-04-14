Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D21C1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751493AbeDNPff (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:35:35 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37175 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbeDNPfd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:35:33 -0400
Received: by mail-lf0-f65.google.com with SMTP id m200-v6so16389360lfm.4
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxuohi9uHrhhadoyGZJRVYkPpPkimE1R0X46yCZoku4=;
        b=achvp29BmoFc3s0lY08oCi27cyHUqkyrNMv1xuXmnUM6QGVZuMMan/HzV9zIwYM9Pr
         MMF9EVeG2zZ4qdXEtsaZp+W+USa53cyUlV4jA86tN5sEzX2adY2O7fbKGj0rHq+gtsI/
         r5WEZ/Z8bKsVaWVkl78++HI/1knaarbYLY3NLIOdObExi2+3M93ZrIV++UtegU29QILY
         D1duLLftNR7OjCYLUMXSwc5OJsDxclpswz3Ib+qTtoTJQRS3aBAYV5Aie/bDE7b2cIs1
         8O8ztuv4YPIxWoMDyqkPS03m15z0eAOKyoYHAB6SH4BHYQ/bAkdBySqgCKkVk4Bkq0fS
         BXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxuohi9uHrhhadoyGZJRVYkPpPkimE1R0X46yCZoku4=;
        b=q0rharmcovd3UGtZ5StdUKYVZMadcJgHYTDhocdZmZx603EOZP1ap++CsGQ4SHoZL7
         e6Lg1Ipmab3ldx08yVpa7hZUjAxGNk80IxFv6n6lxj3Z48PAtKb+FQMEI/S9q9zyZfpx
         +3FxyPMm0DjX+yKvm9jTuNVe1KqnOwcPzdBJxeTBovEZhk4lHHkigcLrd06UuW3UyxrE
         +ysA5t1CryJpFTxKYFdDUiXTj9sA988Pf6uf29keRSGiGK8IbB/OYWrmDYrnVt2H2MDP
         uyLOAHjEIJiTa8DTeuNr93S0eL2aVDS1Btd5Ob+U8UGsJSlJUMazAdPdCpGCiNoS0d8Q
         sjvg==
X-Gm-Message-State: ALQs6tD7u10m5I5Xx8QreckMpSo4Cox1fTdossKv7cOyay0+Z7lz4UgL
        wBLjY+FgaBWvNyhNT1KmjTPx7g==
X-Google-Smtp-Source: AIpwx4+5Zal9hYQLu5kLoa9X1jJUv0KueLcQ0HZaCyoz84hnyQLnWiCq/01/7T3gAZOPpjuMAwa29g==
X-Received: by 2002:a19:2b84:: with SMTP id r126-v6mr10458152lfr.24.1523720131296;
        Sat, 14 Apr 2018 08:35:31 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t8-v6sm1844074lfk.9.2018.04.14.08.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:35:30 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/15] pack-objects: use bitfield for object_entry::depth
Date:   Sat, 14 Apr 2018 17:35:03 +0200
Message-Id: <20180414153513.9902-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180414153513.9902-1-pclouds@gmail.com>
References: <20180414153513.9902-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because of struct packing from now on we can only handle max depth
4095 (or even lower when new booleans are added in this struct). This
should be ok since long delta chain will cause significant slow down
anyway.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt           | 1 +
 Documentation/git-pack-objects.txt | 4 +++-
 Documentation/git-repack.txt       | 4 +++-
 builtin/pack-objects.c             | 6 ++++++
 pack-objects.h                     | 5 ++---
 5 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..d97f10722c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2422,6 +2422,7 @@ pack.window::
 pack.depth::
 	The maximum delta depth used by linkgit:git-pack-objects[1] when no
 	maximum depth is given on the command line. Defaults to 50.
+	Maximum value is 4095.
 
 pack.windowMemory::
 	The maximum size of memory that is consumed by each thread
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 81bc490ac5..3503c9e3e6 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -96,7 +96,9 @@ base-name::
 	it too deep affects the performance on the unpacker
 	side, because delta data needs to be applied that many
 	times to get to the necessary object.
-	The default value for --window is 10 and --depth is 50.
++
+The default value for --window is 10 and --depth is 50. The maximum
+depth is 4095.
 
 --window-memory=<n>::
 	This option provides an additional limit on top of `--window`;
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index ae750e9e11..25c83c4927 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -90,7 +90,9 @@ other objects in that pack they already have locally.
 	space. `--depth` limits the maximum delta depth; making it too deep
 	affects the performance on the unpacker side, because delta data needs
 	to be applied that many times to get to the necessary object.
-	The default value for --window is 10 and --depth is 50.
++
+The default value for --window is 10 and --depth is 50. The maximum
+depth is 4095.
 
 --threads=<n>::
 	This option is passed through to `git pack-objects`.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cc3c31747e..b231e80f17 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3068,6 +3068,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_to_stdout != !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
 
+	if (depth >= (1 << OE_DEPTH_BITS)) {
+		warning(_("delta chain depth %d is too deep, forcing %d"),
+			depth, (1 << OE_DEPTH_BITS) - 1);
+		depth = (1 << OE_DEPTH_BITS) - 1;
+	}
+
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
 		use_internal_rev_list = 1;
diff --git a/pack-objects.h b/pack-objects.h
index 080ef62d31..cdce1648de 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -2,6 +2,7 @@
 #define PACK_OBJECTS_H
 
 #define OE_DFS_STATE_BITS	2
+#define OE_DEPTH_BITS		12
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -89,9 +90,7 @@ struct object_entry {
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
-
-	int depth;
-
+	unsigned depth:OE_DEPTH_BITS;
 };
 
 struct packing_data {
-- 
2.17.0.367.g5dd2e386c3

