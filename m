Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793966373;
	b=RGF6kWLhstQpiGTANttd7oKk2ualtBKQ+BjvyrSPtI6vpLhA2FH3hhV4COWUTUlRi2XG
	 B+1n76LA6ztRp1pmEQtMYTnKJlayRHnxRez+fJxBGOp/ychblt7N2IrEWk2H0CIlboZsb
	 4s59KMZMRBA6pttHtsNmSrFxL1YloSXsXLtlLLr4d7zr5vzyxvOEM822PiJjIu/mXhxzc
	 VpL7gui4vNu3NtMbkh4eegrGcHglmu4BXLOOprmPardjAhn/hq+Qb9q1/Ghm6KfrD1OwX
	 Y5vtClJYFXnY1fbic+FrySsN/pfmDOd0PQ2/CxbAYC7pKO3lnZgzh//Evc96UEmqyYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793966373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=ivKN0DzZlO1+qNGxNVZAc4YGy6RYJIaA3hXnxBL9VQM=;
	b=1JSR09nnisMrxqc0Wf2M14v8Pb0jHZ6vP11KZFnirThV2FcNmz/VOE/2adHbPM9Ad1+3
	 mmnKqmApKK0w/kVAqUDYdzRYz+NScD24mKs3KGOxj9QCfV/JktHTypXWWBOtDxvbuEOCM
	 xMyMbJVcEzwEHOl/3eJu+Msh4hbPw9yz75w0xkjWMJkGq3bqTA+/ZpxEBcD1jZ8iFlS8h
	 Fkzg/Babk/32VMSql5OyVnHX1Dl/DKYtSxZ94CHXzPaDmj3JmMctr8KwIQJPOuOlUnVVV
	 G1GQRT3M2HvhAJloickt6VrdmhKxXrN89sZjvSLTVHWqGgkWEOIEEUZN5fao0nVvvEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFLfnhVj;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBAD606A329
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 11:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EBAD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFLfnhVj
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-84e513877a3so461632a34.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 03:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793966372; x=1794571172; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ivKN0DzZlO1+qNGxNVZAc4YGy6RYJIaA3hXnxBL9VQM=;
        b=GFLfnhVjDzUmTzjnbonfL8Tldzuv3cknJWYhgF+GX5MIwl28/LZgHeDEwx4if1+Zh/
         v+x+pEO/yNox7x6OxBUGpYzoU9ezQxaZ45Gum6ATG1iqu30UuQipDdKwrcGnEro5qlRy
         vpTw9rqONwAdTKMVQizHN7w4ZkldHefhorU+Q/qpwjmRx4ZjndOSaL3xX/O5GyqGBIDG
         D8em617NLUzwl4y5OBdIYKvLiyuTMkc2eqrJGQdeotIhcwxZCirRqFSUjY3+e2kqI7LY
         kRVNPJnBd+pi0PkBOcBq0NEsviuxY175wX7K54gw3oxEtIjtjzPTbtpkCqtG5RoJDrwL
         Xtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793966372; x=1794571172;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ivKN0DzZlO1+qNGxNVZAc4YGy6RYJIaA3hXnxBL9VQM=;
        b=yD9MdfAhiJvCKabT9+4WpZmXRX7ZmHMuDI9U54kYAbzERtTjw0N/2N1L9MifAqtByI
         WYnPWtH+a4BFaGkd9ATEe1uGCZj9r0msEd3yoC9Lw+CW6JPm5AkSpxNhAwM2ADt6uzTl
         W8RgyZcGnx86B2iReI5J6FUOiSc3rn01w9i5hIdCbGjktMOtKsYZCpFax2WVYyqOTkvz
         M5iyfSPfGQ9ZSHXkAGKoErKSJkwqTt0VVFqY7tZPwZ0b4L4WVqWpY39Lu6w1XHfXkgDq
         Zvd/FFFo8RM7+/hdKtGZLwQf9UTjUi0r/ii52Aw2Mi/fiNeTw38YksiSt+bTQRmTAtod
         bYJw==
X-Gm-Message-State: APuU4Z+a7U7uMg7zjgX9wteNB+w1eoSGm8Huh+FNCH3yEigSHy+q7H47
	s6u0gFQ1Dg+Om6xnUlvY9UHxKi/pbqrcThIVgqMr34mRFx3jMpt78EtWfrrErOhe
X-Gm-Gg: AYBFou2yPNog/3OWhlcj1C8dT7aV9wKoZ7/WtGwyCbr713dzWeEFRHzLC5R9niqLkKP
	4RHzFgXqq8knNNFfJnE9XgfGLhBO+7/mAceyFPZQIpGmf34Hm5PbIGDI6hpbqOTawNzae4EcN8O
	q48xetSucnach9nwH1YPOn7XPpO8xeVm5blSwC7hcb/+A1co14mLRuJJcWW9rzNT4Nb+IIUEQUk
	Fu2gxawBvXRYc2HRwssw9GW3AHc2M3fjHsfekLen+utwOpu1V086sALUcoA92J2tWuebGjhrjbQ
	4nKAlWZb5ViQ4X/6I/fgfpIqmntAUppp2sZeP1/eI/AXefewFzF4Pv2ul+9gU7iObz8+UQWH5kV
	oRe4b1yHhyylMJ0uA2Q8Cfzbm8rrJFCZ5vJa8kx3Y4noTe58btmbkxt/ABbzJhYrfB4kHrwkebm
	je+vN2uT44jUWWCF8s9aTBg1Hhdgym2yG7Vlkispz21oI0NS63+Mp2XpYd9oQgHp7QepEYVmoRm
	NjyDERkdP9FRzjOXTFiQFeU49B3WNiEtV0EGmJtd/3KqyQAyNtMmNDhWsqzQ5xK23ukFIv5eaFS
	s0mBdI4KMooYPoQfYNzMvF1MKqZ37rihSqY=
X-Received: by 2002:a05:6830:6512:b0:848:8d7d:4e47 with SMTP id 46e09a7af769-85f05865438mr3106272a34.10.1793966371978;
        Fri, 06 Nov 2026 03:59:31 -0800 (PST)
Received: from [127.0.0.1] ([52.165.251.245])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1dbb2984sm1735319a34.5.2026.11.06.03.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:59:30 -0800 (PST)
Message-Id: <pull.2298.git.1793966368860.gitgitgadget@gmail.com>
From: "Joy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Nov 2026 11:59:28 +0000
Subject: [PATCH] repo: zero-initialize configuration values
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
    Tanga Joris <tangajoris@gmail.com>,
    Joy <soniqjjj@gmail.com>,
    Joy Gundu <soniqjjj@gmail.com>

From: Joy Gundu <soniqjjj@gmail.com>

Use memset() to initialize repository configuration values to
zero, removing the need for explicit zero and NULL assignments.
Keep non-zero defaults initialized separately.

Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
---
    [Outreachy] repo: zero-initialize configuration values

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2298%2FJoiejoie1%2Frepo-zero-initialize-config-values-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2298/Joiejoie1/repo-zero-initialize-config-values-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2298

 environment.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/environment.c b/environment.c
index c83cf44839..afe35cff99 100644
--- a/environment.c
+++ b/environment.c
@@ -752,34 +752,22 @@ int git_default_config(const char *var, const char *value,
 
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
-
-	/* section "sparse" config values */
-	cfg->sparse_expect_files_outside_of_patterns = 0;
 
 	/* section "branch" config values */
 	cfg->branch_track = BRANCH_TRACK_REMOTE;

base-commit: 3de8ebe6c8cfcd312cdbfa675635810140f84c8a
-- 
gitgitgadget
