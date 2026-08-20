Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769B44A3FB
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231917; cv=none; b=sUkmoAPpxiFgi4JCVusDHVJGSCb+VWfyPR8fm7hfCA71GbSEe5mnnNp57pzjC87F7TFrrWvhVHOGAobkp3ghLzchrd78r3Kwh94m3d5/x+/ucZ5uw5GCLD2WH46k+130QwDEmX/zj0plEN8iXVhjQtS5GicJjcJK5sPkdMs1IMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231917; c=relaxed/simple;
	bh=sm/hciHZkBCP6uTWJsB37SGClWfq81zpR7WoHDy0460=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQHWQusMKBKBMWOLnTR3gB8c6shVij7EvztZhYQdtyMHNDuRUUpi5BbIrLj7q29UdNlWL/RhfhkSfgV6iTB4h2wLW+05i5tU4SyEYR48R/mA9HRpT7sOEhFGbLh6u7EabunXTghsJ+c2ShvcNlmc91GoQvhcUWIqMR+WCcvQULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2uRsL4i; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2uRsL4i"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-836c8bdac50so32836327b3.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787231915; x=1787836715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cXGp2UZKJoxWmCOMMmogL7kVyZ1ReMzh2MkiM2WhHEw=;
        b=K2uRsL4imyImmxNKpnDFpLB1Rwt2pjwA8tLKdpQu95wGiNXR6btWxVROwdR0xDRHjO
         txfBV9fHzIlxQ2gv8cVSNE0mjp/BCR8uTfd2G7dxzmy/s+CQ+2EcNxTPXnaf753d33mu
         wWIMfO9VcYhj2oedwqx3XPI6b9N2p6/gP/fbBFkM5fFQy4AwwpMJf4Em33YYIEikl5lG
         AENSR6eRJdy8+copaP1wD8Shk34sRrV5cYx+OoKVrA+Qa2liJF3sZppp3U1E1cTP4UAl
         NQXuk7HWtTeWzf94EM4hyK0n1MHK/Cy8QSA2xjxtXsSS8lZBhw7cQwJYZm0zPGJvKfNb
         Tl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787231915; x=1787836715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cXGp2UZKJoxWmCOMMmogL7kVyZ1ReMzh2MkiM2WhHEw=;
        b=GD5jelmHA+ktLXGjQ5D7jvQ2mUKUUfZuhc4/ITaxhMXBZVgstXdjjk8dS5RoPFtcWy
         eQbe70ZP4GDtK2Iqm8rHNsAU/uT77r47O4LOBS+gldKHdFwdc20aR1p9g8qJHos3hSQ+
         aj7pIrRfP2OwOYhR0aW8hDZc5ErBrZ//N/hZvwguoW68VwJzrO7J2/im5aIy8sWVlbkE
         nqT9NVTEM3T/nx2TB6vur5sW+JeknuqTyvalT/oz4FoknL2zbcaiQcn10cKVZ2jeKpli
         jlOzpDd3ON2AplZBO0LqB3VfP7+bh9qs2twkNeIAN0zYhiK/Fq0l/ooN04g06lUkBMX7
         3l8A==
X-Gm-Message-State: AFuF++lGeI56mKSFbBUTDHCW/Im0qtC2bhU9FgWSp8gnWjTakiQWJRSB
	nCZdF2PrC7l0erF87w5x556Y5tFHGFSKTxQydspihhrJZHx7kYvdwFJ4cWhAludwxu4=
X-Gm-Gg: AR+sD10Di4OsX3xIyQsysZm+kHu28K54Bu8mimc8VSc/KBWiwtBjR7e+DjKu2UqEl5u
	GzAKcCnVaTOtLaj1RSNXoMOcI9RBNZeKs7jx5U4Qyx5L9nEj+idHOIGb3FciXaN/MkbIMvOXIL4
	9WbTIm1UxLR32/yEjc4OLy/DvsPtg70k5D1DVkHd7LGiYnFoK0IgCC+8yTXD5UzUeFukbUYDYm3
	De5bTdItpYQrF15oRHXKIzYy3mGr4RmrSIP9RbxRO0vExifBGuGj1sqKVbhQaprf1VS/b8c7QQS
	bqJKjM8q3bAgPRzvTY+xiPsf/iuz45LPXAqrS4pxiQ4B5lg5/HAznImoiJ5jVt/2e4dhZFrtzWb
	Ibz18rNAWEjtihaKJhTx0QLoafJSEUhXjzv7zMT0Gk08JqUgB8SgfWZCTj/PPN3TcIHKT2RoqxT
	c0MiawKCtVa79/kCxpDT+cxplg0VBJIH6vYpqWt7ihS6zuPeECppqUUfOO0nxO9aNt7LbDquUk6
	x/wkVjOH+K2yhWm+dLExnZqVaaqJ02JQzuF69CmtayZgp7p2L3NvPmZdmv/+H6m7AVEoq6oY1jq
	C+rkKt7zovo=
X-Received: by 2002:a05:690c:7286:b0:81c:8005:9104 with SMTP id 00721157ae682-844e2513bc2mr53904467b3.30.1787231914859;
        Thu, 20 Aug 2026 06:18:34 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-847ccd8b6cbsm8021807b3.27.2026.08.20.06.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 06:18:34 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Tian Yuchen <cat@malon.dev>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v4 2/3] environment: align repo_config_values_init with struct declaration
Date: Thu, 20 Aug 2026 09:18:08 -0400
Message-ID: <5693baa9923afd20333c0eb016cc5949f8dfc423.1787231825.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed.dirty
In-Reply-To: <cover.1787231825.git.ben.knoble@gmail.com>
References: <cover.1786103607.git.ben.knoble@gmail.com> <cover.1787231825.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The order of assignments in repo_config_values_init is chaotic and hard
to follow, especially when comparing with the struct definition to
ensure all members are initialized. As new members will be added in the
future, make it easier to validate changes by aligning the two.

Refactor assignment order with no behavioral changes.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 environment.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/environment.c b/environment.c
index 76ee65e62b..6676e6f5ae 100644
--- a/environment.c
+++ b/environment.c
@@ -745,6 +745,7 @@ int git_default_config(const char *var, const char *value,
 
 void repo_config_values_init(struct repo_config_values *cfg)
 {
+	/* section "core" config values */
 	cfg->attributes_file = NULL;
 	cfg->excludes_file = NULL;
 	cfg->editor_program = NULL;
@@ -756,20 +757,24 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->autorebase = AUTOREBASE_NEVER;
 	cfg->object_creation_mode = OBJECT_CREATION_MODE;
 	cfg->apply_sparse_checkout = 0;
-	cfg->protect_hfs = PROTECT_HFS_DEFAULT;
-	cfg->protect_ntfs = PROTECT_NTFS_DEFAULT;
-	cfg->ignore_case = 0;
-	cfg->trust_executable_bit = 1;
-	cfg->has_symlinks = platform_has_symlinks();
-	cfg->branch_track = BRANCH_TRACK_REMOTE;
 	cfg->trust_ctime = 1;
 	cfg->check_stat = 1;
 	cfg->zlib_compression_level = Z_BEST_SPEED;
 	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
 	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 	cfg->core_sparse_checkout_cone = 0;
-	cfg->sparse_expect_files_outside_of_patterns = 0;
 	cfg->warn_on_object_refname_ambiguity = 1;
+	cfg->protect_hfs = PROTECT_HFS_DEFAULT;
+	cfg->protect_ntfs = PROTECT_NTFS_DEFAULT;
+	cfg->ignore_case = 0;
+	cfg->trust_executable_bit = 1;
+	cfg->has_symlinks = platform_has_symlinks();
+
+	/* section "sparse" config values */
+	cfg->sparse_expect_files_outside_of_patterns = 0;
+
+	/* section "branch" config values */
+	cfg->branch_track = BRANCH_TRACK_REMOTE;
 }
 
 void repo_config_values_clear(struct repo_config_values *cfg)
-- 
2.55.0.860.g4b6b3295ed.dirty

