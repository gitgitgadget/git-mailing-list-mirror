Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B07AA1F404
	for <e@80x24.org>; Sun, 18 Mar 2018 14:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbeCROZk (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 10:25:40 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38275 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754153AbeCROZj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 10:25:39 -0400
Received: by mail-lf0-f65.google.com with SMTP id y2-v6so19588489lfc.5
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8br/W3LGG2aH+sMnfXnCA395GngtZOKDtXFw+n+I/x4=;
        b=fQ9Ipc4rlyhzPD1xFqU8RC6aWLJx41UVk54c+bCYvVqGxp0C6BGMORcBumcxWFnqHs
         FvWZ5mJxsUL1469e2E5MsWMg7mr/s2PP0cs8uKqZ5RCYGb7eN5bOF+tYhUVHYF+pdE+y
         7C1BXiJaxpUsGlfkmj3inCcVxOngWL2BRrMvD11lZKZSbHJ2pJTvG2iBvHB6ZSC5m2iG
         UY1qzOuxiDS969AfXj4gz8TfXDxosETzDW0A8rUS2402rU0nFGMV/7iQGxmvwehhOsW/
         6lGSBFS1UfH8vM6hEdWutXlKNnInd89iOu2SOA1PJX5FWDBjxpj/mhSyWpg/yWqAVau9
         dnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8br/W3LGG2aH+sMnfXnCA395GngtZOKDtXFw+n+I/x4=;
        b=fDAQvBAJM1DmnR+MJf1Mgraf44ptZv28Brk5QNIgUgLV/4EBbBwSgtPwmFd3GxEwu0
         ssLgFQGaGzYfHSoiJRSOMw20wB5/En2nw0wzx/xj02eOs8kA1/dU3K/N68y/BOv87aj6
         9pSDNGK4/Z7vcPQ+j1x8fJXzqf7iH+vHSOA2Xoa8rF8BD9rZf55fyDC4DrLk1BHF6ZAW
         7yuNLAR0nsrpNS7sDn14S45foiRB1Is+EItanvRV8PtDrvE8vfXNzns/QDg2/vCnVY6F
         BBfnwL2UEFuFA+tXYWoCcV+iy3UDMyjeZGOpldJDoDNSZ+Vohqv2MbMHqPVjoC4NGLFm
         Qk0A==
X-Gm-Message-State: AElRT7EVs9o6IfjxGPpZnjRLcJZRtKFlaosqLKE8jqa3D1yYf+qbh1Ry
        eY1wfy8ZbuoEVXX2hDVhLj8=
X-Google-Smtp-Source: AG47ELtkTk1YL/aQNGi8PVcTyu5GGME2hhb96dEDOl+hMsQpQejT0/6l4WHL98yYEGkRaGGjVE7Mug==
X-Received: by 10.46.152.18 with SMTP id a18mr5518891ljj.34.1521383137961;
        Sun, 18 Mar 2018 07:25:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n24sm2551554ljg.22.2018.03.18.07.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Mar 2018 07:25:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
Date:   Sun, 18 Mar 2018 15:25:15 +0100
Message-Id: <20180318142526.9378-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.347.gf9cf61673a
In-Reply-To: <20180317141033.21545-1-pclouds@gmail.com>
References: <20180317141033.21545-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v6 fixes the one optimization that I just couldn't get right, fixes
two off-by-one error messages and a couple commit message update
(biggest change is in 11/11 to record some numbers from AEvar)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fb2aba80bf..4406af640f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3112,10 +3112,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	if (depth >= (1 << OE_DEPTH_BITS))
 		die(_("delta chain depth %d is greater than maximum limit %d"),
-		    depth, (1 << OE_DEPTH_BITS));
+		    depth, (1 << OE_DEPTH_BITS) - 1);
 	if (cache_max_small_delta_size >= (1 << OE_Z_DELTA_BITS))
 		die(_("pack.deltaCacheLimit is greater than maximum limit %d"),
-		    1 << OE_Z_DELTA_BITS);
+		    (1 << OE_Z_DELTA_BITS) - 1);
 
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
diff --git a/pack-objects.h b/pack-objects.h
index 55358da9f3..af40211105 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -275,7 +275,7 @@ static inline unsigned long oe_size(const struct object_entry *e)
 	}
 }
 
-static inline int contains_in_32bits(unsigned long limit)
+static inline int oe_fits_in_32bits(unsigned long limit)
 {
 	uint32_t truncated_limit = (uint32_t)limit;
 
@@ -287,8 +287,8 @@ static inline int oe_size_less_than(const struct object_entry *e,
 {
 	if (e->size_valid)
 		return e->size_ < limit;
-	if (contains_in_32bits(limit))
-		return 1;
+	if (oe_fits_in_32bits(limit)) /* limit < 2^32 <= size ? */
+		return 0;
 	return oe_size(e) < limit;
 }
 
@@ -297,8 +297,8 @@ static inline int oe_size_greater_than(const struct object_entry *e,
 {
 	if (e->size_valid)
 		return e->size_ > limit;
-	if (contains_in_32bits(limit))
-		return 0;
+	if (oe_fits_in_32bits(limit)) /* limit < 2^32 <= size ? */
+		return 1;
 	return oe_size(e) > limit;
 }
 
@@ -307,6 +307,14 @@ static inline void oe_set_size(struct object_entry *e,
 {
 	e->size_ = size;
 	e->size_valid = e->size_ == size;
+
+	if (!e->size_valid) {
+		unsigned long real_size;
+
+		if (sha1_object_info(e->idx.oid.hash, &real_size) < 0 ||
+		    size != real_size)
+			die("BUG: 'size' is supposed to be the object size!");
+	}
 }
 
 static inline unsigned long oe_delta_size(struct packing_data *pack,

-- 
2.17.0.rc0.347.gf9cf61673a

