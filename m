Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF148CE0
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907278; cv=none; b=ghiPDYNJByCWiLd7tPydUIfhQ56+ANV518zUHjg46z/yiHqAT0lWNIvccZF1D2k6XluwwgR/DyymzR0HgsDQVZ0TBpazXSAMJuLOxewgcEcaDkjBo8iX0uM2sAKFRtxFGsvwFoLU5Xc++VgqjKBoFW/G7KuY1dOqskO2yO7jmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907278; c=relaxed/simple;
	bh=A0YrVTjRnqL1mcqVGqhcC1XMkZymD6gkzV4SF1wYBX8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AwyphwhM9qqSeZH80QO4N//Z/dUZWUCDEjmE42Jz4BKpYUu6XB/sn05+R4z7wK+iSH940sBcU8MueMZWudRgE3yOI7NGKcrJFnn3ZC9fs/JOaJno7g3V1GPLR3YhdxcwMYmDpOHXPqZUwsjD8kCRObUnY5BMTFZN8gl+B37w9NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSdyKdzA; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSdyKdzA"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512ed314881so2030584e87.2
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 06:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709907274; x=1710512074; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3igKwnp4fvuAKJOi8YTwLUw7jLZUiI8LUC+1noZy9w=;
        b=XSdyKdzA99GJagtY+K+xSMaH52Wr8LMwGQE9wuuIuXVjyyFs+ympmxbr97YxbSLETo
         ow6YvBPvIBOxlYLq2YXlWFa6out2+UKSUaS/tYo0G26gbuOz+4xywUjKIJu9wZ6i2gqP
         sH3zysHdE0W/dzfXn3nAS8pP79fdPDyj2WnCYs72TxCvhzBD9vu7uZ376H+0i6QURNxr
         Ir07ZaPN2uUdBbYcI1sCS6prphZnjKuQtWW8UHy7tuDhduDcpaSlg3L/oMlM010GtG8r
         VtiuR309Beca56M23BrWPqQTJ6aXp+Vy4TM7llZJ+My6cQ2idLH0M2r8xzv2yOhhhdfI
         eArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709907274; x=1710512074;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3igKwnp4fvuAKJOi8YTwLUw7jLZUiI8LUC+1noZy9w=;
        b=e8aIaSz30dhwPTtlNVUy6UJ4cKqcOymsQsRqSXTvqCqbWmZQweCIiplRaaqrXxdGr6
         9a6ffR7/Z8S3GtT9Dn2iwUkFNpL9vRqz8BRurb5HvFyBEiYoyT40jMhxEpVo/5FBL27L
         6iiSEKMovdma0NlPf3DCjibMzKeO7RoRAXJp1cSfdZw6swt5rH7AD6IdXxAi5aN8uLFl
         5E8b8cf2PuAxn/yNSPj8gWSywwyKhtXr+7MoRnRNGbDeMW3Clzu2Zq8P4GKCJgCVoGBl
         l8DHFYoq98MtSjYQ7T243HE6i9WswDIY2Xmcfb5+8jtUwfHurbP0qvCj/yYZImYh+5O1
         eEyQ==
X-Gm-Message-State: AOJu0Yw1wACdoQr4vjkSAhDNIvVnLdIbXHRCvoXKcw2TwBA//1AIpdxB
	QD1lq+XKcJEzMbiYRIdpwRYQ914QBEkg14e0bhYNmh4SWfPSjgYb44JfkoJy
X-Google-Smtp-Source: AGHT+IHuWa7o96CF1sYJ9m8ugTOb3X27h9L9s9wPoHwqj59OeiOCGyd5bluwP39mvl+IwRGJi0X3jA==
X-Received: by 2002:ac2:55a6:0:b0:513:3f81:224f with SMTP id y6-20020ac255a6000000b005133f81224fmr3701117lfg.37.1709907273946;
        Fri, 08 Mar 2024 06:14:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc20-20020a05600c525400b00412ae4b45b3sm5976969wmb.30.2024.03.08.06.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 06:14:32 -0800 (PST)
Message-ID: <4e05bc156bc93e86f3f2ac878c39596bec722a56.1709907270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Mar 2024 14:14:28 +0000
Subject: [PATCH 2/4] merge-ll: introduce LL_MERGE_OPTIONS_INIT
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Introduce a macro to initialize `struct ll_merge_options` in preparation
for the next commit that will add a new member that needs to be
initialized to a non-zero value.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/checkout.c | 3 +--
 merge-ll.c         | 2 +-
 merge-ll.h         | 2 ++
 merge-ort.c        | 2 +-
 merge-recursive.c  | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 067c2519334..6ded58bd95c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -262,7 +262,7 @@ static int checkout_merged(int pos, const struct checkout *state,
 	mmbuffer_t result_buf;
 	struct object_id threeway[3];
 	unsigned mode = 0;
-	struct ll_merge_options ll_opts;
+	struct ll_merge_options ll_opts = LL_MERGE_OPTIONS_INIT;
 	int renormalize = 0;
 
 	memset(threeway, 0, sizeof(threeway));
@@ -284,7 +284,6 @@ static int checkout_merged(int pos, const struct checkout *state,
 	read_mmblob(&ours, &threeway[1]);
 	read_mmblob(&theirs, &threeway[2]);
 
-	memset(&ll_opts, 0, sizeof(ll_opts));
 	git_config_get_bool("merge.renormalize", &renormalize);
 	ll_opts.renormalize = renormalize;
 	merge_status = ll_merge(&result_buf, path, &ancestor, "base",
diff --git a/merge-ll.c b/merge-ll.c
index 61e0ae53981..6570707297d 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -401,7 +401,7 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
 	     const struct ll_merge_options *opts)
 {
 	struct attr_check *check = load_merge_attributes();
-	static const struct ll_merge_options default_opts;
+	static const struct ll_merge_options default_opts = LL_MERGE_OPTIONS_INIT;
 	const char *ll_driver_name = NULL;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	const struct ll_merge_driver *driver;
diff --git a/merge-ll.h b/merge-ll.h
index e4a20e81a3a..af1ee36abdb 100644
--- a/merge-ll.h
+++ b/merge-ll.h
@@ -82,6 +82,8 @@ struct ll_merge_options {
 	long xdl_opts;
 };
 
+#define LL_MERGE_OPTIONS_INIT {0}
+
 enum ll_merge_result {
 	LL_MERGE_ERROR = -1,
 	LL_MERGE_OK = 0,
diff --git a/merge-ort.c b/merge-ort.c
index 8617babee41..4a02c3ecd99 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1956,7 +1956,7 @@ static int merge_3way(struct merge_options *opt,
 		      mmbuffer_t *result_buf)
 {
 	mmfile_t orig, src1, src2;
-	struct ll_merge_options ll_opts = {0};
+	struct ll_merge_options ll_opts = LL_MERGE_OPTIONS_INIT;
 	char *base, *name1, *name2;
 	enum ll_merge_result merge_status;
 
diff --git a/merge-recursive.c b/merge-recursive.c
index a0c3e7a2d91..02b7b584f95 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1047,7 +1047,7 @@ static int merge_3way(struct merge_options *opt,
 		      const int extra_marker_size)
 {
 	mmfile_t orig, src1, src2;
-	struct ll_merge_options ll_opts = {0};
+	struct ll_merge_options ll_opts = LL_MERGE_OPTIONS_INIT;
 	char *base, *name1, *name2;
 	enum ll_merge_result merge_status;
 
-- 
gitgitgadget

