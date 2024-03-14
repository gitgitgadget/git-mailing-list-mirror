Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D787441E
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435916; cv=none; b=CIHVrT86eMensXHqd2f/prz2bYpZ/hbXfOr0D2EO/X9BwAlDdUR/7+Jw46CFlgZaBGOsVIrLnTuhh5RtiObO1/eNAK6rMFK7vLDdHfmCo+hpcb65dArWqeHOMw8+oX/grCh8bilEBnYVQqQUskfE/xipC2XFwP2cCwrf8YbbcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435916; c=relaxed/simple;
	bh=A0YrVTjRnqL1mcqVGqhcC1XMkZymD6gkzV4SF1wYBX8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZhgbKkLLkzuQ5+U2y8CIsTdeFQhgK1QWT4Z/fqIApiYUrRcM0Qdfm/jGa/pb2apejRcwIpcimQoWeqLiiI9xMXSab7P8RJc868h7y2Nd87jKOSSAxYHGP1KebbPpuc5A/g674uhncqOZEyy8cQnMxBg9DfWodLdETdNuQPtqtKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ92X77N; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ92X77N"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ddd1624beso800549f8f.1
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 10:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710435912; x=1711040712; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3igKwnp4fvuAKJOi8YTwLUw7jLZUiI8LUC+1noZy9w=;
        b=dZ92X77NDU38H3/u4WtLHwHSvNauNJmz5JlOUHmJw9CsC5drly6C/8AdlfJX7uudct
         u1QGm0WRPpo5/C1Tg/n8EPQbveSQTj9iS2YfHFkqWBJXFhdqt+uYhuraTwfpU7uRRo9e
         UnEA8Ht6pHLH2zNJZ3HBVgQaYLYTVUqFAxEpA7DM+oJnqQKwYt1xWNr0wLb8Twp6BIHC
         uJp9JY4dXzjrg4F+Z2Xdd/9b8dYIsj4ZZFEyYIpEEpb1Kgsq1v/39AhqiUxGxqc8olA+
         Egd/XKPKJ3GUPZRf/yWl7qt1zm8FB6DLtRkkkmiWkpLRaAxQjhSV1RhzHlGoBz9iaIpD
         jvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710435912; x=1711040712;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3igKwnp4fvuAKJOi8YTwLUw7jLZUiI8LUC+1noZy9w=;
        b=SOpjcVC3PVlct5uT7RlMHWcoqENfPDjYuQ8ty+7ipdDiQmj0KKNpPYu8dD+BVtFgFN
         BFPsoj9C/AuJORIJ8hIRbdrSjt0wAEGaM5kZwCEYDAwMFYV5vd4evYoX3EfVGXMLhSX1
         4mCY+boosOiwfWaICGcKu0I0o3cDZbfFl6Do/BQ/0eLqHDb0wfq5ath61+6DNXoPVCzJ
         g88l4twT/sSWVMvL9x7lGjKz4gkXdhZ6hkqfvdTDr7C0dUZlyr1veBu7yF+k+Z69p3Dg
         t9qJ7P0K5mFWxw6ASe66oGf8KXmsBieIvg3zEZ511EqoN/8fUvbcniDa6MQdTismwzg+
         AmFA==
X-Gm-Message-State: AOJu0YyJSxgZXcxiGNxfofKvmoBEBrGwVrFECwsdjbViIW55v77IBMPd
	Ekep2RTTpFMiOaazNNWlfVEL/AIPNhUPzJzxgyS+BMUP26XeUcrVnU4sV4IR
X-Google-Smtp-Source: AGHT+IHeFnhRYtb5E8i6RhvfxbZCuI9A3NI5REmzQ2evNvElnwHxnAnLcTRsJpgsv3ni9PyjhaoYYQ==
X-Received: by 2002:a5d:638e:0:b0:33e:7fc4:1518 with SMTP id p14-20020a5d638e000000b0033e7fc41518mr2394504wru.8.1710435912325;
        Thu, 14 Mar 2024 10:05:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az9-20020adfe189000000b0033e43756d11sm1215707wrb.85.2024.03.14.10.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 10:05:11 -0700 (PDT)
Message-ID: <46e0f5a0af7d3ab406bd6dd4af9eb4e0a008ba59.1710435907.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
	<pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 Mar 2024 17:05:04 +0000
Subject: [PATCH v2 2/5] merge-ll: introduce LL_MERGE_OPTIONS_INIT
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
Cc: Elijah Newren <newren@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
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

