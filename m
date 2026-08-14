Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13D3D6CC9
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710907; cv=none; b=TkrW6xpVrN3UG3Q6w5n+HlB4h5m7f0F9u28Dyz+4anWjdaxA6L8NeHwHwWurIlAsqnSxd6RJ8eQzNA1899I7sljE9WD+CdtKZ7pk2Pil8jwPhNtZozZkAPg8dXy/LE1FM8TgeEaQs9DTw+RGGFwvUYdrQtqyUKwuXT47iLKdKXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710907; c=relaxed/simple;
	bh=9WBfdM+CYShKl/lxdmTHtmiGnABYI+yefY6147aVA0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2ZpI3kB5u39E9gv3UEjjHI+qW00WUZ6NNfQor1t6s3DVx/5jAcv33vDSekJpSRxItC5KpKqtklJO/2LpOaz44Aczsxk6Hj0fGv9OE+MsDOpwmHlwYMq/HCxjE/2T6SX/pcdpEutyIKtxzpmqMMHp5FbC5/OwPtnCoys0vSGJMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abFQQiLf; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abFQQiLf"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81ff017d420so26986347b3.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 05:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786710905; x=1787315705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4OaTxNZmrmt54DsOJfXkmxbrUbtqLnOC5NNX4A2Px20=;
        b=abFQQiLf9p4Ksymfua35Ut6JvcHqJKfmgOJIWK/J7z6h70qJwJciPjze/lxE8f3WRY
         l0HzzEch21S9KnWUbWv7U76J0WzNkkXyswNgdJi0kGuuoxFZIl2EiuUgvEuby5sQxSXN
         4KKGw3Vh66l/Lh2FEbtuPsprecxIYNtYaZkflj4hRJTT0IjnYHe48rKhUeNQpO634nzP
         3sHCcQGfIGqlXLQYSw6UT8pJ6axAqtkPUQl2szJq0swJdRXorV6QQdCL2frVY3XSLn8y
         QKP/3eHVHzetD86G+lsjQ0QvoCjthNx5i7ioBP8JDaKs/yCo+uJQ/50wjR8CWMmAYHbc
         6P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786710905; x=1787315705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4OaTxNZmrmt54DsOJfXkmxbrUbtqLnOC5NNX4A2Px20=;
        b=dgVnxn9rfFAgNGFVI+05VJ/7OLSq/OrL1bF2ciNVQR490swuIaQ7yd3wszHHuoBkue
         Q/lhVCGKELQa9oQCpDc2RJFGqe7sqmVH1RTGibBHaSbEDCZI9V5zUEmEdtSXrsZ8DTZS
         letCSsEc4+qmE7sSTd7V6iVUOePogiGrTRS0KRT5yGvOsVJP2giERn8JkxvcLRy/iVzX
         M+fdfT+hy1HO/FJaI9qRkUFXO9RIylc4Hd8MorqaDEm78OMwcNJ9geUVD25w6byytOq4
         NG0E6BpijAY5FcIr7NYdsLrX66RBWDrNxMl370P6GrFovKJQdHFkBVg8JOq22N51HMXq
         2F0w==
X-Gm-Message-State: AOJu0YwpnYvM3IOV3Q8IWPnyv7TaSaNlvAQIlwk2AVRyFPUGVwy2v67J
	0hhcbzAY6SoGlmI2eam9IUlhoGDjfbVPRT7tYiVdL4RrqHg3h91FwlbQ14PPrtPhi4Q=
X-Gm-Gg: AR+sD12ZsnOWj/VMzxTa+pq1oXYDNioD/YWTn9lZXc9BboulOSqTOtX9FsJyKZpy63j
	Vgk9AiUMke8nv4wmKc9T+b0CwJ6AdAzDC+yjFAkL3/h+NXgi5TOh6FATazGFxAXNd5SbiVo9zYt
	6KM1zNaMuh0Hu6JZ74B6xQHCh9tBy8p2COOaOuspAp62C//UNO8UfcWL1rgx6A52m5BxxjJRDU2
	GFahOcYaaxpxt4jOa5cnUlWZeJP5R1DWyxLYbckM+HsS6Uh5uVV8qsHmmJk3sOWqX+CVvVz50FZ
	mPq0FYK9CP3w/i9JZXw8UhRAJIgmoHm1qhxNL3l+IqpuYbAd/NZc6ScTk2biVVjOrU9oVEgLeM1
	Gu3j6GLX45+i3CcFg84c7uAetPDJib4XiACoJkLuN5WwYIKBCkjoYI1KXpept6sOZopI17/+M52
	/e/WWnTLq1oEQQsQDJSGLoyrt7KPkuZJXchAqZgIKUcpHxF28K8Olhc/IiMjlYpTw4PSlOpXoaV
	OHTYv27MawnF5kZ/SjpxMMGXqD++kyaof7sYhDZ3d5R9djRfsEavo/pnHYWJWrkUoYZaQCk/Hth
	YQI0VH5j9l8=
X-Received: by 2002:a05:690c:64c1:b0:81e:5d2e:7a2d with SMTP id 00721157ae682-8370d7e6391mr26607547b3.1.1786710905160;
        Fri, 14 Aug 2026 05:35:05 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c21409eesm12428357b3.33.2026.08.14.05.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:35:04 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Tian Yuchen <cat@malon.dev>,
	Junio C Hamano <gitster@pobox.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 2/3] environment: align repo_config_values_init with struct declaration
Date: Fri, 14 Aug 2026 08:34:01 -0400
Message-ID: <5693baa9923afd20333c0eb016cc5949f8dfc423.1786710807.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f.dirty
In-Reply-To: <cover.1786710807.git.ben.knoble@gmail.com>
References: <cover.1786103607.git.ben.knoble@gmail.com> <cover.1786710807.git.ben.knoble@gmail.com>
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
2.55.0.699.gb54405d56f.dirty

