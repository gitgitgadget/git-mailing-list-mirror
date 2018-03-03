Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5013A1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 02:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965032AbeCCCrh (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 21:47:37 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44363 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935847AbeCCCrg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 21:47:36 -0500
Received: by mail-pf0-f195.google.com with SMTP id 17so4772515pfw.11
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 18:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qpu0iAHh4/SsVHmFtJ0ypAGJFL3Xur6/AaYc3KymR4A=;
        b=Lhlm+2lcMpB9oqa2j3h2zLXxK4qcybc1yqX1n6hF7PSDJ62SWXIT/9TCm8TQDX9FBD
         LTnbru0Ox6sdH3OTG2ZPl3LJ2NtRLnmjO1trTk+O9J0mug3BP2Rj9bGgfPpL8abhmjIA
         fTjSvr5P5CnOU3ZabuGVyAi6yhqP7DZOcTUi/MFDDGiqqw+n4qxfM7YWN4XFLV5XW3gc
         C8eKdoT7CuMx3C/sjUD/EUCvxmcB9u5F80jIBqzTeW1bk2UbjknBgvlxZE/FGzNrAsaB
         1M2qdgTTfSdgzh0BNmmAsUljTrpgKXx0aRLXXCezxmb41x97PLMBl6dn/LDHQTKcOO+K
         NzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpu0iAHh4/SsVHmFtJ0ypAGJFL3Xur6/AaYc3KymR4A=;
        b=lVhr6pbwWh7Q64iyTnCh/IEr1orTAT8JMsKcVvgSHePtv6QlEHR0ESr0JKcnjAnKUD
         B/DMDZJaqVnKlLZPQTqwEWeDfMOvfg1Xgomu6PZKDd1G/1KpTgFn7HSF6r2NvIpqIqVv
         N5xWdcCRXifdzsImwzYZiVa01E/IVr5ADmHsVF2PpIfKLmpXASE1bX9cJLzwga3RN5nA
         epiGm21OdgnDVwFuaczpa7nlE8qN1JC58TKv9PUfVG9CQasy75sOC9KPTtXakUnIpVxe
         kA1r6oyhw6/bdXCdpejL9+92Z3eSQmGJzTO1+uli/RfAZ4knJ4ehunDwjeHnJ7MbhX9D
         +WKw==
X-Gm-Message-State: APf1xPDB7hsYRIixTb+UZ/yPfeODQi7TB3fyB2AcvgBWVaY5VvlCglZx
        VMZcbJb8eQIosqfxF7f+JOq+tg==
X-Google-Smtp-Source: AG47ELvEoVN1+U/WTGgWB8w6/s/NjH24CvgeYZdIAvWEF8LwuVbfmwZMFE0PonvwA3Z4UVkI2b0HxQ==
X-Received: by 10.99.171.10 with SMTP id p10mr6116871pgf.176.1520045255813;
        Fri, 02 Mar 2018 18:47:35 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id q22sm15583516pfk.138.2018.03.02.18.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 18:47:35 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 09:47:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC v2 4/9] pack-objects: use bitfield for object_entry::depth
Date:   Sat,  3 Mar 2018 09:47:01 +0700
Message-Id: <20180303024706.31465-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303024706.31465-1-pclouds@gmail.com>
References: <20180301091052.32267-1-pclouds@gmail.com>
 <20180303024706.31465-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This does not give us any saving due to padding. But we will be able
to save once we cut 4 bytes out of this struct in a subsequent patch.

Because of struct packing from now on we can only handle max depth
4095 (or even lower when new booleans are added in this struct). This
should be ok since long delta chain will cause significant slow down
anyway.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt           | 1 +
 Documentation/git-pack-objects.txt | 4 +++-
 Documentation/git-repack.txt       | 4 +++-
 builtin/pack-objects.c             | 4 ++++
 pack-objects.h                     | 8 +++-----
 5 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f57e9cf10c..9bd3f5a789 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2412,6 +2412,7 @@ pack.window::
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
index a4dbb40824..cfd97da7db 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3068,6 +3068,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_to_stdout != !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
 
+	if (depth > (1 << OE_DEPTH_BITS))
+		die(_("delta chain depth %d is greater than maximum limit %d"),
+		    depth, (1 << OE_DEPTH_BITS));
+
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
 		use_internal_rev_list = 1;
diff --git a/pack-objects.h b/pack-objects.h
index 6a85cc60c9..2050a05a0b 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -2,6 +2,7 @@
 #define PACK_OBJECTS_H
 
 #define OE_DFS_STATE_BITS 2
+#define OE_DEPTH_BITS 12
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -43,12 +44,9 @@ struct object_entry {
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
+	unsigned depth:OE_DEPTH_BITS;
 
-	/* XXX 20 bits hole, try to pack */
-
-	int depth;
-
-	/* size: 120 */
+	/* size: 120, bit_padding: 8 bits */
 };
 
 struct packing_data {
-- 
2.16.1.435.g8f24da2e1a

