Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB6B672
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739690965; cv=none; b=AdwnYQacOfAiUbxSRkQDf7GKJ8SY0oQTo5JnedbLDEazO0MN0AQn7XvSxqdmTSuX6vvyg5A03mbkaZcXh89t+7iIkJ3Kn6zEbkC4PnlfPhV+q9cvOm951am+TJrvZrxY7RM08Icu/dG0G1XH7wr909+z/rGTufP1mXGGcXS/SZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739690965; c=relaxed/simple;
	bh=z8wA8sJ6bbCD0iLG/TqzGwbSyOpjsCw7a3IeAQH+Yro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpTivPltOk8sRe42nQlFPKl2SK0ZSUqnMzFTfAB8cY5QXiawlfyDujR0zg4yb4vmXhtTT4Al2J0OStWkIv3KUdNuqe1BjytzAevymSn83d7a3QGu39fWg2xIbU0oT1Umsz836wH9YNDXwe4aWWKdIXk8JMRM+38z0WHgZzg1Xc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4yZ3BKK; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4yZ3BKK"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso4847176a91.1
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 23:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739690963; x=1740295763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FYGZS3ghMPe7aoFl9oMbE6U/jNx8JlezXHxAbQGEQs=;
        b=e4yZ3BKK99hcpYfKCB2QS7qafCcCFO23+xam0X5msNMxw8UNN/2qNWn6veE7U7nYy7
         Rn7sEp4xRDXBvXtwOBPThg9J2ot849yH2wQ2ndr+7/SskxDBl8kkXHpHtHxBu4KmOI8q
         tkIxptGxTo7GZbhI3tYNP1um9UOEdQQK7GKnoGgo3b//LutMmmxX9A1CqPSJ/JFycF/Z
         ZL6VndiArdQaxoick3InF4C4RPjfH7/qDVFF67QxaK71Qs9hSMJ5AiRDw9YpPqGVXnLv
         ZFYIj6gkcscnSazGO/nMnHg3gbUf0iRBArLRqkPlMNcCrPjfYGaOL9jDPipk06lgJ0yL
         ecIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739690963; x=1740295763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FYGZS3ghMPe7aoFl9oMbE6U/jNx8JlezXHxAbQGEQs=;
        b=CmRF307D+BuO3ZYAQNm7Bazi2jxILubuTs7R1Ezf1dC2dqFd/Dmu5uJGrHSsPE7nJV
         K+tUzB2JT20AeGQXxqmXjAoT3Ii9WcXLjLFHf/SLt7xA8/PC10FXEGHSdqK9JuPSJxB2
         FRKNWtD4F82V9DRL20ay6elIMJUbLJpel06E44dTkj0UvsWCYFV0ukwRrjRGhgYW/7Zv
         Hg5YyGE1Ra3ciAD/ai15hog+BgNygi9n1WIw3CJdVYqUZqqLpZ9K/syWhlY3/4KZerWi
         juQ329klkods6ioYtWbGWcnwbH4QvRAYv57K1gC0qJOfY/qCQvV+OjQWnWCCGoaIyyw9
         Yxyg==
X-Gm-Message-State: AOJu0Yya7FTC0FbCUUimIq8PZzBm77k02d1M6sxlSI3b6F01Fz71rzL/
	BBGFxNW25Z0HFfTjsnF2QARGC8PUrW04SvhjQwXuVN7+I/sUQ+X/
X-Gm-Gg: ASbGncup6YbvkS5g1aYsN0+xAqtBPVeDFDm6LSGYTYC97jh9gbA6Mr5/Y4BLsNx11U2
	75PBFWIRRXRaxI/WMfvWV3qUqO1OR4z33o0mMaNioJGuhQiXBD5MvlclG+1W5Pw7P+cT4BmJdZ1
	c1TGfF/xk6Ga0pC0xQNfccgnLuZ9jMrWTX55Fj5ip15Zf5VWz0MpL5cvjPkN3w4DQ+Hd0WIh0qz
	hPQWf/7m+OHamryENbqJgWS8yfmyad9AcyOfbd84hMU/uZ9ECfOme/fLOxhFTLVh8v0s+0GD63D
	qEIETm2yWLoint7PidcoQQJHhRAiEeefGgfnS1Rxd2qMMECtMdCDwshL6Q0ViCCVGW7ZxDfVcRn
	Js/1BRQUzNfQi/UAsdkU62fBeivJwTtOUwg==
X-Google-Smtp-Source: AGHT+IGt9sjMW97ZsEfGNLBXKHbIE8EI2GA3OsIobycROlFxkWTybpAh5LD7WMSQ4MhjzvoH/t1jjA==
X-Received: by 2002:a17:90b:4f8b:b0:2f8:2c47:fb36 with SMTP id 98e67ed59e1d1-2fc4116aaa4mr8749080a91.33.1739690963528;
        Sat, 15 Feb 2025 23:29:23 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. (ec2-18-166-75-244.ap-east-1.compute.amazonaws.com. [18.166.75.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc327a9d68sm4483243a91.1.2025.02.15.23.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 23:29:23 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: jelly.zhao.42@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	newren@gmail.com,
	ps@pks.im,
	karthik.188@gmail.com
Subject: [PATCH v3 2/6] apply: change some variables from `int` to `size_t`
Date: Sun, 16 Feb 2025 07:28:39 +0000
Message-ID: <20250216072843.72385-3-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216072843.72385-1-jelly.zhao.42@gmail.com>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
 <20250216072843.72385-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some assigned variables are mistyped as `int`, including

  - those whose values come from a system function returning `size_t`,

  - those that are used for array indexing,

  - those that represent length/size/distance,

some of which will trigger -Wsign-comparison warnings.

Change some of them to `size_t`/`unsigned int`.

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
---
 apply.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/apply.c b/apply.c
index 4380a83386..4aa47a22b9 100644
--- a/apply.c
+++ b/apply.c
@@ -1087,7 +1087,7 @@ static int gitdiff_index(struct gitdiff_data *state,
 	 * and optional space with octal mode.
 	 */
 	const char *ptr, *eol;
-	int len;
+	size_t len;
 	const unsigned hexsz = the_hash_algo->hexsz;
 
 	ptr = strchr(line, '.');
@@ -2185,7 +2185,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 			};
 			int i;
 			for (i = 0; binhdr[i]; i++) {
-				int len = strlen(binhdr[i]);
+				size_t len = strlen(binhdr[i]);
 				if (len < size - hd &&
 				    !memcmp(binhdr[i], buffer + hd, len)) {
 					state->linenr++;
@@ -2320,7 +2320,8 @@ static void update_pre_post_images(struct image *preimage,
 {
 	struct image fixed_preimage = IMAGE_INIT;
 	size_t insert_pos = 0;
-	int i, ctx, reduced;
+	int i, reduced;
+	size_t ctx;
 	const char *fixed;
 
 	/*
@@ -2418,7 +2419,7 @@ static int line_by_line_fuzzy_match(struct image *img,
 				    struct image *postimage,
 				    unsigned long current,
 				    int current_lno,
-				    int preimage_limit)
+				    size_t preimage_limit)
 {
 	int i;
 	size_t imgoff = 0;
@@ -2492,7 +2493,7 @@ static int match_fragment(struct apply_state *state,
 	struct strbuf fixed = STRBUF_INIT;
 	char *fixed_buf;
 	size_t fixed_len;
-	int preimage_limit;
+	size_t preimage_limit;
 	int ret;
 
 	if (preimage->line_nr + current_lno <= img->line_nr) {
@@ -2706,7 +2707,7 @@ static int find_pos(struct apply_state *state,
 {
 	int i;
 	unsigned long backwards, forwards, current;
-	int backwards_lno, forwards_lno, current_lno;
+	size_t backwards_lno, forwards_lno, current_lno;
 
 	/*
 	 * When running with --allow-overlap, it is possible that a hunk is
@@ -2791,7 +2792,7 @@ static int find_pos(struct apply_state *state,
  */
 static void update_image(struct apply_state *state,
 			 struct image *img,
-			 int applied_pos,
+			 size_t applied_pos,
 			 struct image *preimage,
 			 struct image *postimage)
 {
@@ -2803,7 +2804,7 @@ static void update_image(struct apply_state *state,
 	size_t remove_count, insert_count, applied_at = 0;
 	size_t result_alloc;
 	char *result;
-	int preimage_limit;
+	size_t preimage_limit;
 
 	/*
 	 * If we are removing blank lines at the end of img,
@@ -4293,14 +4294,14 @@ static void patch_stats(struct apply_state *state, struct patch *patch)
 	if (lines > state->max_change)
 		state->max_change = lines;
 	if (patch->old_name) {
-		int len = quote_c_style(patch->old_name, NULL, NULL, 0);
+		size_t len = quote_c_style(patch->old_name, NULL, NULL, 0);
 		if (!len)
 			len = strlen(patch->old_name);
 		if (len > state->max_len)
 			state->max_len = len;
 	}
 	if (patch->new_name) {
-		int len = quote_c_style(patch->new_name, NULL, NULL, 0);
+		size_t len = quote_c_style(patch->new_name, NULL, NULL, 0);
 		if (!len)
 			len = strlen(patch->new_name);
 		if (len > state->max_len)
-- 
2.43.0

