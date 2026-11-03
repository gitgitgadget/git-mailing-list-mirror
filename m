Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710124;
	b=PgBz7yGeyd/N9xjCQk72FfohaMTK9K+HIdjJBatBsaa5PJaUEJu1H8+t3byEDOiQg47l
	 JHaWuErxov3r5oQVRV/vUtLVu2ykcbedc0qY7gwCUU8mYCm0CBwmmtf6FCB++t3+tYedv
	 gz54yj+LuOEW8Ra+PF/jKCNIopm9MmWrMqxbeSyDYTMPzaJQdc3p7hBOEB0+T67jQNAaS
	 38on7s4eH2aGKGVg6t6F3BpLDbA0HKEDmQqzHSQQgatWq4/ShSBo0MJOGDqNJUsDFJLNy
	 ILhXD5/pNyBNHxlUkY7GfMQhW46M7Pe6qyLtEKI4TtbcQzpvg8X0ecHb+0AxUL59fhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=z1OAw47xAfYplRy2ZEdue8bP71cs7IA2EFIEKUR1f24=;
	b=esYnqNopoDGl1/CERgObUQOAQ6B72b6JW+rwQMz3KDinUpW/42ESNgz/hahIv9wKZqiV
	 BXQKfCEk7TnZY3TzVaXbLm2RrGbF3SW3/gV8jZ6GM9YLLiGg5pJrB9j4ErFE76CvokR8q
	 skwJYGRC1r/Me3zhql8XWw53/yHx/Pfz4xDWg0/kHH7aU2KAtWwJDNT8QbnyNCdo6Rb43
	 6brf2PVOAo4CLqSg4gazbDJgscbb5JL7SeiedE0tsnAWV8/81BMZhqMSkgnpG77jJJMoG
	 xRH01bEWtbqvItpHy3uTwyhwBi1J7bOognAaseaQQlSTMUMILrprPnd7d+UpT3Cc0eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BMmxc1vc;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879A606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8879A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BMmxc1vc
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-53dbe9b8d6eso490929b6e.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 04:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793710123; x=1794314923; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z1OAw47xAfYplRy2ZEdue8bP71cs7IA2EFIEKUR1f24=;
        b=BMmxc1vcg3FZ3CaLFFUMghZ5uaYYTIXu806f8PDW0AkbSBq3lmM+b321zgDsX7n25d
         0rOHLxOJJm8DzFwF10fsLuQkktesBPWFHX7oZxicMBqQs6Hi97WoOHSIjfVhrg4R3Jir
         ZbgZfULMRBjtRpNojP8Q6oJntn1MJ5j2vCjiFl/Tni5j3nr7VRwNMkgGg1QcPxHp+F4/
         UHIECiy6PWKb2WW7CoknvlqlPnTkdfkWg0YlKTrQ9LE0K1kjDq1Q/jbYzIgd0RLojc4i
         A+yL+dvSMgadHNtGQjbjf1Y7ezxdyQfUx7YKuhY97woZqhJoE63vb8PKnOo6zB/EJCPU
         g/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793710123; x=1794314923;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z1OAw47xAfYplRy2ZEdue8bP71cs7IA2EFIEKUR1f24=;
        b=TQtkpk+ssZxq85ibPp3Y1gGxQ/EsGf/gEEuv7ibDhIEuPbBNua3Lm9bmPwdug3ODrn
         kxWwyq0MIuTXorJAeBP8rQpW27uVJyYwYF/4fiPPFAbHw18CQWD+HsTYaXizOsl/RvVR
         S/gaBKnWiEwWJFQXAERKIfKs4Ua2wIYMHgIw09rM8721sQZtVv+EOTSp37hJEJz0E8XL
         nCmnUbkr2F2JblYsTX2k/ePefzYq8eWyus/w+7rOXldUWHTJkOUdBDMwQ4ff6ZNL6w/o
         yI/vEO02dmSY+nkspW9Pa+zPZKcRpp2YNLCw97axVX0vuH6Rc8W3SkrmnIYSVC3DrLCZ
         //zQ==
X-Gm-Message-State: APuU4Z/cm1GciaPUzQF1WF6tPBCgsRJsVLMTQMhzTX5fyWNYwSu8jw/3
	JI/n6ChvlK9LvDHMjva1YTlb+IiNa4kDc04Sk51xe1r4GdFchP5BsKfTOtm/VjmVEWQ=
X-Gm-Gg: AYBFou3bkoZbDUoXeP5Vq6XyIYsjQcywMUv7al7k3CasWbklNgempOZ1B7mUsH+63ay
	+NWY5XftJAoGgRC0ZPfOZq2Hyi+3dYQShzMxX9GdC56ATY0LO5nyx5IxhOdori8REwZG+IZbela
	l1W4T71abSHbVcQQQaO6Z7ZuBwUT70o0bQWOOH0AA6AWHI27hUI+8HroFvO+qupL9k6W2E1xrYU
	9msMgHxgL4MbcRhbRbUdAUHkXCV1UVj91L/lvtyb/XK+k/wixIfKBsblCkrkfcRnq1D1OW7FVG2
	Xjm/DujkydIvGFkeWroeGDSaoDEHxQDFxuyl+9RwmMGt2R7pqRFcUACjKmQfrFlZf3AKFSENPYx
	aNq1CamhQyKPUFv7djxF98wKf82Wy+BbRZCSHO4XF4NE6t7i8jTd7PJpwsD6VXxKDXNTp0OiH4/
	B+7Ygd04+sAVf1u8dYHrMRjvbwl1SveiQj8pehanUHunzMuivZ/dpjItJI93jh/6rmNm+NUWOKK
	anxG8W4iB7NqYsVj9osrAE/3gr55hXa6t54qZvXP0hdslX8baioVtM0j2jMKarVpyspWSeQIle8
	Jb2c8n69wSVO1voVu638jfKx6c5RjgI=
X-Received: by 2002:a05:6808:150d:b0:495:ce6d:7d48 with SMTP id 5614622812f47-5640de494bemr6240853b6e.9.1793710123418;
        Tue, 03 Nov 2026 04:48:43 -0800 (PST)
Received: from [127.0.0.1] ([20.64.66.196])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd9888bsm10816210b6e.5.2026.11.03.04.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:48:42 -0800 (PST)
Message-Id: <dc18b66976f681292e8539b68319393083554650.1793710118.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2271.v3.git.1793710118.gitgitgadget@gmail.com>
References: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
	<pull.2271.v3.git.1793710118.gitgitgadget@gmail.com>
From: "Joy Gundu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 12:48:37 +0000
Subject: [PATCH v3 1/2] repo: zero-initialize configuration values
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Patrick Steinhardt>" <ps@pks.im>,
    "Kristoffer Haugsbakk>" <kristofferhaugsbakk@fastmail.com>,
    "Christian Couder>" <christian.couder@gmail.com>,
    "Usman Akinyemi>" <usmanakinyemi202@gmail.com>,
    Joie Joie <soniqjjj@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Joy <soniqjjj@gmail.com>,
    Joy Gundu <soniqjjj@gmail.com>

From: Joy Gundu <soniqjjj@gmail.com>

When initializing struct repo_config_values, we explicitly initialize
several members to zero or NULL. This adds unnecessary boilerplate as
more configuration values are added to the structure.

Zero-initialize the entire structure with memset() instead, leaving
only members with non-zero defaults to be initialized individually.

Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
---
 environment.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/environment.c b/environment.c
index c83cf44839..5a2eb8b2e4 100644
--- a/environment.c
+++ b/environment.c
@@ -752,34 +752,23 @@ int git_default_config(const char *var, const char *value,
 
 void repo_config_values_init(struct repo_config_values *cfg)
 {
+	memset(cfg, 0, sizeof(*cfg));
+
 	/* section "core" config values */
-	cfg->attributes_file = NULL;
-	cfg->excludes_file = NULL;
-	cfg->editor_program = NULL;
-	cfg->pager_program = NULL;
-	cfg->askpass_program = NULL;
-	cfg->apply_default_whitespace = NULL;
-	cfg->apply_default_ignorewhitespace = NULL;
 	cfg->push_default = PUSH_DEFAULT_UNSPECIFIED;
 	cfg->autorebase = AUTOREBASE_NEVER;
 	cfg->object_creation_mode = OBJECT_CREATION_MODE;
-	cfg->apply_sparse_checkout = 0;
 	cfg->trust_ctime = 1;
 	cfg->check_stat = 1;
 	cfg->zlib_compression_level = Z_BEST_SPEED;
 	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
 	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
-	cfg->core_sparse_checkout_cone = 0;
 	cfg->warn_on_object_refname_ambiguity = 1;
 	cfg->protect_hfs = PROTECT_HFS_DEFAULT;
 	cfg->protect_ntfs = PROTECT_NTFS_DEFAULT;
-	cfg->ignore_case = 0;
 	cfg->trust_executable_bit = 1;
 	cfg->has_symlinks = platform_has_symlinks();
-	cfg->use_nanosec = 0;
 
-	/* section "sparse" config values */
-	cfg->sparse_expect_files_outside_of_patterns = 0;
 
 	/* section "branch" config values */
 	cfg->branch_track = BRANCH_TRACK_REMOTE;
-- 
gitgitgadget

