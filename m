Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC5D48381E
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946494; cv=none; b=rsBjKoXmIbRjDl1fyh6hIv0Uy3hNxrsfrf2EMiCk41aYFbwj9IcQQ7K5E4Os3B4KZv/bWtfvKeAFLqVpMlb597qLdm5eosKdbvS4Z/qGn5GDoUCvfk++CCJ5CKMEnACa7a7kGk8GvDoukfdI1yi6fbHxUFIRxkfqIchFPcTcr9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946494; c=relaxed/simple;
	bh=YNGnyhvQ+aXZSnD9yxBIwF4sNWi7EWGl/SHmOLLRaTY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FCbgXrBcaSsWG5JsTNduuVCn/Ehb5oIdHeTohK6ikR9PCv21B1a3lmtD04prGs8v9ow8GJTgAMPqABngtDVa4oo+dDXyJiyIK1mzRf50vDGZ/1WTPF0JxdDDwCv0AxppjZCxKUHnpmNeAl60MNHbEgNEuUeuIY3tjvHBuG8IGOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRrci357; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRrci357"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ee37dc91f5so797953a34.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946485; x=1786551285; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NkN0X+fKhjqByZ/LMuLq95T9hx3OvhcZJG4a7lGfnkA=;
        b=WRrci357rDLfJ25ISdGL4z0z18lznM0RRzRhkiphKX59QfBXhQ0Jf6768S3CehslM6
         hZurXMkwmhCUHRnkoreyIIl0hIVLwverLkyGItehEs+jHjQJYMvaVYrxQtQaxuSlx8Pq
         TzyvBzYR58iH/5wpskQ3VEa66yY0YhwMuvd3dtXefJqf408AMYyQYtyYp5JyatVlq49F
         +dFdgnQ+uFmKcoO+HbcRQZWHfg4d9rcys6xSYTARmOe308gDvT8pjRztcKDI02p9jfmO
         UoTOC1ICp9oDYZT9tOTuu9eV1onpQRGk45ZJYUilQV3Mjc4iEWZSflhlDSoELcQ8t6OI
         nZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946485; x=1786551285;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NkN0X+fKhjqByZ/LMuLq95T9hx3OvhcZJG4a7lGfnkA=;
        b=mbtmiyg9a82oeciwToVCqa42dvMtdGm6Wa9v+9OsArsYMgvSIMAHOjLAuC4cw8m94u
         X7B0+cyhVSZePr5M6JzCqD/PNsKbh3wv+j3/whx1UKIugcWecoRTbU+lcliVKTjO74JM
         4l9NjfGOkye0Fr6aaGPlX8B94x7tIWhPutyGNu/EK8fh5sqUxDJCHt6WCwnoQdQldoWx
         35IpaVHeNkevlYFKhxVqUPNujnFK0W0Zq+M4xsSV0kSh0Of+qiAGEUurSN2Yibi9EFFD
         8Xxyes0HdHhLjw2YzS2S6cIjdcbUrdPqa16IFgKzr7Sjr95rSg02hp3mQ5Y+Z0hTxmXN
         CY6Q==
X-Gm-Message-State: AOJu0Yx4MPTqA3SK0YF4z7CpU+EmT0OyGvikjUuXr2CecnJUKnIMmlCF
	6uSJ+JPWwNLTeql4tw32sSqggI2BV87zBrRigKaOB7006MBy0j53aKKi7jCQSH4C
X-Gm-Gg: AR+sD12i8DP7UeUt+mSb1g6PfwOx1VNRiInSCBOcCJzs+q0PdGtCR/FUj/RD3YlYHqI
	mKd1ZeEYcCKj43E9RR8vQOWznoIdp6NNLsds9lWZdF5tH9uKbvp2r6cEwp20BMrDYhSCyYSzF6d
	zRlHeqrSiRUtB95IFJNyWHj0HtnqHYD7XQBwLqQhpRCv3c59du2P9+0iMLfDq6Luu1bki2i/fB+
	ZeFQxp5g+uIHQX709oLQN5S3biAArTGrDMbayzkWUa9bZZ+oSI7zSDSAAn0pKUwQNw5soUj9Gx8
	TELyMXj3+9JimRAyeMwauxQ2+U28OqGg5ubkpzfVKq7OOL8wwP7ZfSIaadp/q+A3UFchopm4VKA
	i/8cb7q87tLnevMdxAQvOhFV6wti+uqCIcxAFGQeX3cLIrtxL8fWqDfDogg1VOlPvE/gULXIoNW
	EELqCMYqB5BKCOxouCBY9ftHKxxNwXnyTCs6C8y3VkZClJeVG7y/H2H2BwnfOHf02/69zEGA9qC
	2zq
X-Received: by 2002:a05:6830:6205:b0:7e9:8867:cb23 with SMTP id 46e09a7af769-7f1e5f10674mr5480560a34.16.1785946485418;
        Wed, 05 Aug 2026 09:14:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.142.251])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df565d37sm3045207a34.16.2026.08.05.09.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:14:44 -0700 (PDT)
Message-Id: <5b54041bafca1de826ddb4466b3d5d8fcceba3af.1785946479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 16:14:30 +0000
Subject: [PATCH v2 03/12] pack-objects: widen delta-cache accounting to
 `size_t`
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

These three are a single accounting tuple (the globals tracking
cumulative cached-delta bytes, plus the helper that compares them
against an incoming delta size) and are latently 32-bit on Windows where
`unsigned long` != `size_t`: a pack with many large cached deltas could
wrap silently.

The widening is internally consistent on its own: the additions and
subtractions against delta_cache_size already come from `size_t` sources
(`DELTA_SIZE()` returns `size_t`), and `delta_cacheable()`'s sole caller
in `try_delta()` still passes `unsigned long`, which promotes.

Prerequisite for dropping `try_delta()`'s `cast_size_t_to_ulong()`
shims, which becomes possible once 1create_delta()` and `diff_delta()`
are widened in a later commit.

Note: since `max_delta_cache_size` changes data type to `size_t`, a pair
of new helpers is introduced to parse config values of that type, too.

Assisted-by: Opus 4.7
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c | 10 +++++-----
 config.c               |  9 +++++++++
 config.h               |  3 +++
 parse.c                |  9 +++++++++
 parse.h                |  1 +
 5 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e3760b3492..97246c69ae 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -260,8 +260,8 @@ static int exclude_promisor_objects_best_effort;
 
 static int use_delta_islands;
 
-static unsigned long delta_cache_size = 0;
-static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
+static size_t delta_cache_size = 0;
+static size_t max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
@@ -2688,8 +2688,8 @@ struct unpacked {
 	unsigned depth;
 };
 
-static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
-			   unsigned long delta_size)
+static int delta_cacheable(size_t src_size, size_t trg_size,
+			   size_t delta_size)
 {
 	if (max_delta_cache_size && delta_cache_size + delta_size > max_delta_cache_size)
 		return 0;
@@ -3701,7 +3701,7 @@ static int git_pack_config(const char *k, const char *v,
 		return 0;
 	}
 	if (!strcmp(k, "pack.deltacachesize")) {
-		max_delta_cache_size = git_config_int(k, v, ctx->kvi);
+		max_delta_cache_size = git_config_size_t(k, v, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.deltacachelimit")) {
diff --git a/config.c b/config.c
index 6a0de86e3a..010a58d307 100644
--- a/config.c
+++ b/config.c
@@ -1268,6 +1268,15 @@ ssize_t git_config_ssize_t(const char *name, const char *value,
 	return ret;
 }
 
+size_t git_config_size_t(const char *name, const char *value,
+			 const struct key_value_info *kvi)
+{
+	size_t ret;
+	if (!git_parse_size_t(value, &ret))
+		die_bad_number(name, value, kvi);
+	return ret;
+}
+
 double git_config_double(const char *name, const char *value,
 			 const struct key_value_info *kvi)
 {
diff --git a/config.h b/config.h
index 31fe3e2961..b66dd08007 100644
--- a/config.h
+++ b/config.h
@@ -282,6 +282,9 @@ unsigned long git_config_ulong(const char *, const char *,
 ssize_t git_config_ssize_t(const char *, const char *,
 			   const struct key_value_info *);
 
+size_t git_config_size_t(const char *, const char *,
+			 const struct key_value_info *);
+
 /**
  * Identically to `git_config_double`, but for double-precision floating point
  * values.
diff --git a/parse.c b/parse.c
index d77f28046a..266bbd539b 100644
--- a/parse.c
+++ b/parse.c
@@ -134,6 +134,15 @@ int git_parse_ssize_t(const char *value, ssize_t *ret)
 	return 1;
 }
 
+int git_parse_size_t(const char *value, size_t *ret)
+{
+	uintmax_t tmp;
+	if (!git_parse_unsigned(value, &tmp, maximum_signed_value_of_type(size_t)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
 int git_parse_double(const char *value, double *ret)
 {
 	char *end;
diff --git a/parse.h b/parse.h
index a6dd37c4cb..db742f35fb 100644
--- a/parse.h
+++ b/parse.h
@@ -4,6 +4,7 @@
 int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
 int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max);
 int git_parse_ssize_t(const char *, ssize_t *);
+int git_parse_size_t(const char *, size_t *);
 int git_parse_ulong(const char *, unsigned long *);
 int git_parse_uint(const char *value, unsigned int *ret);
 int git_parse_int(const char *value, int *ret);
-- 
gitgitgadget

