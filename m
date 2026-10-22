Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662436;
	b=f3YV0fPhu89/GaHEazJD9v6nlOmxSpyd1xEo9DLXQPBrzqmbTUmEXePo7255fbYn2jCQ
	 cKkeNtSf4qq5RfwX5A6unEuA9GTA/+91LKpP/rcrmsRc7gh4GWXDdSz1I70ftveCnNp7n
	 UwJC6l1XsSEahpR7jryFJ4UezurOjl5GUGkFa5fnkuTyY68u6tc22sA5jl+7Lf9fV6v1f
	 F3ZpYMLm29LI7FFtwYmfsGpqDwf7dZrb25fYGHw4dTH5Lqnv4u5SH/kGJg0kIWpk56Llb
	 nXUuRS5M6aKwxq0zP7ZpNEiwYwSA0gDHu/bzrlf6LUdGaivOrvGvFoLayKOMD14QOnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=zc4MWjAar4ZOcU6GV0xgIV2NZCKXbqQ0Q/hiqsD3Ur8=;
	b=uVyHPAfmnFTUIrlNxN/woM5WQDu0F62IZ9ktz8Sku+HlGXeeaVvpAN6iaftGztYOnTVr
	 v5JLyBb31MoXnObTlcGry/KCMVKz//91jvuwd2DT0KbGDidTrMpat+DinClkUhRj1WZoa
	 Oeon4qf28UPxfbXRresQfrLeZjOTKDtN/ooxR9L1rDZBcYY7Cf7s+nb2HChcFNgxMbOJM
	 VoRNLXA+jaf+d2HFfGmbGdcPSN2UFXaczLnfnv/JOoisWhSIfxgT4OOuxYdkJGSPQUkEn
	 ZtOy1KDq+JdBmc/5aLFObpRg0hl88hIRHOXSpHmoz3LpmVTEyaGPnuWhcPUm48240cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YzaX05oE;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08229606A31B
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 09:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08229606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YzaX05oE
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-157fe9d771bso2142386c88.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 02:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792662435; x=1793267235; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zc4MWjAar4ZOcU6GV0xgIV2NZCKXbqQ0Q/hiqsD3Ur8=;
        b=YzaX05oEC9kbg42ZLPhnTPkh5dkk0fjkQ1KKv+tRoA3qlWhVPrs3YjBI84m5NRy+Vi
         aRT+JeuoG4V8dpH+D6U8MeJs9Z3VodvBSpp4gi/jod66nsjWH6bg7uShEMJmFgSkQqw3
         sAg+wroozjTU8XY+cToAGxC00dwX9wSMTQMRMj2Q3378rfijLxme/nOvJJopBbelSlTG
         MSevxZ8kw4cN8yMiUKrqBEBEsWXPPYCmWTfZYKZZ3WhTuRyNsUTzBcr+2NnqeQL4fYqc
         WAtGOeJn+8BfWHpg0iWZSJMzJNo3mFDmdMWjCyvbZLwL10Z+oor8Pj4EPRL6F4Wv3FdZ
         9twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792662435; x=1793267235;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zc4MWjAar4ZOcU6GV0xgIV2NZCKXbqQ0Q/hiqsD3Ur8=;
        b=mMqG+e7Xzx4KLsb2EsmVb3o9tnvPDkUFbdXi90m+ZxV16tCJ49EZuZpUVnjeVpsgAm
         s/jv9I4akH2zJg9Pmz+Om+Lk/UFidB+K8EoumrLk3FRq/495l63ZCQAaCtJm5rpg709D
         Eu4slUxYJEUmLnCyMXs27P+KT+RHx/KlB9wOVGHkaDVIpQJyKU1ed2+W9IIxYJnmIgfd
         laNaFmJDpM3TMrq/HPpGD8Sj+uIwfceZSTpd81S9NGKktOHY0E10oV5QLi0kFf+SB0yo
         GsQxEzMCKeGeJQ9qGJJVvdtWaEOjHZkvLLCHLiUBaGwCznfdGqiwtDz1RQbsYT4TvrnO
         TDtg==
X-Gm-Message-State: AFq9FYJXHUr/cIM6MRAmMCanJyhFJk0EW2ADSupLrBangY+YL0lAbqO8
	NmvT4ZmhJlUME+I+gmDqgmGDTPXkzyZfxbEveYIozHMxn5fD08bxazV+Rv50SQ==
X-Gm-Gg: AYBFou2zGm6/OHJN+iK+D2mN1E8DwWG/oW8Cr9iQw7L6Bt76Q/ztDhKOLwy1DuzrJ5E
	HaI/ACLqID/7IUH00rnySr/Vaio4WfpnDDa48A8i9Dso/d7ZW9qXEYD80IJzY+ceazC7VrLTR/S
	4NJyzIFGhDE8zzil6OHi3QLjzuZlMok72Y1N64pWGy1/nxNXkfP3j2kFuRZIonRyLqS3fxulIui
	xOKD5WcigoHEnQny7Defpec/Sj+ZgFQoDzMYLhPIMiqtfNbJCUO2D+a3MbmJOV3hPP8eR2GfTcX
	CtQ637TsTwfGkS2oHIrioHvUqeu6523eqBeg38MCMZnQ1RD+hactCf9/+UDhXNaelI7pELcEOfD
	P9uepHZLqeDLElpHqx9/N7D9dusAtJy1LEqgHerGu2SczVz7dt12nCv1wnUwxpWyLdVMPmRzlxU
	WTBqvo2z6lQz9SYbTi/l7Ty8ev9l6ED40zEOqFlMoZslTmq4lzRyNExfg+CBKXtrvqdSBxgq8K8
	Pn+9WJaK/G1WZzzwofrtA/tmZgvbnpHZ3Kkihu3bxPGCqPPebJJ9sS9CJ0X1KAFd65ttrsqEDTM
	xzIvZg==
X-Received: by 2002:a05:701b:270c:b0:190:d9bb:281f with SMTP id a92af1059eb24-190d9bb28b2mr5688957c88.18.1792662434960;
        Thu, 22 Oct 2026 02:47:14 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.245.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cca3d8sm14872818eec.14.2026.10.22.02.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:47:14 -0700 (PDT)
Message-Id: <df93a2a86cae7d342270c0ee67a1c0d41ada202e.1792662432.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2271.v2.git.1792662432.gitgitgadget@gmail.com>
References: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
	<pull.2271.v2.git.1792662432.gitgitgadget@gmail.com>
From: "Joy Gundu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Oct 2026 09:47:11 +0000
Subject: [PATCH v2 1/2] repo: zero-initialize configuration values
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
    Joy <soniqjjj@gmail.com>,
    Joy Gundu <soniqjjj@gmail.com>

From: Joy Gundu <soniqjjj@gmail.com>

Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
---
 environment.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/environment.c b/environment.c
index c83cf44839..89af09aa40 100644
--- a/environment.c
+++ b/environment.c
@@ -752,34 +752,24 @@ int git_default_config(const char *var, const char *value,
 
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
 
 	/* section "sparse" config values */
-	cfg->sparse_expect_files_outside_of_patterns = 0;
 
 	/* section "branch" config values */
 	cfg->branch_track = BRANCH_TRACK_REMOTE;
-- 
gitgitgadget

