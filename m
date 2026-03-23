Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD918370D6C
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253148; cv=none; b=krAqXKtM2tTHCHAOlF6Zc75eTeqaJFRpqDyHYJKvi/BIghlIDNTKkbvp/X/lqRu5uUUS8I5vqQI+BkHwgoV4dfUr3p+f73Q7RaUWK+Z3RjH5Zuzld5FGbwWASxkYHB+/Zyto+TTJuBcorvc7JDZVgjBscJDKCOMNmfNOJbqm8Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253148; c=relaxed/simple;
	bh=Oj48q0W6NHHAyuqu62NZLuBBF0PeRqfrkDKIkBOug+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4pHbWXQl5f7C8WpmTKsnaAINr0z9M7yH9onq9fUR0gNCqrdiGXCnoVPkcF7Gq/dbFkXm8gEXKQ/5zF5KldK1iFjZTDzZeURRTsHENDWAG0yj0hBTef8qGqUTCK+GqHcXceaVW/yE5ANBlwKL/xrLYLNPnbdJ7L6ztnVcoNrtTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xh+w4qbz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh+w4qbz"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so3659226f8f.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253144; x=1774857944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knhNTSGkOlCa+PNQ+g5kmrFZB5Z9Igxlgp27B41Tmhs=;
        b=Xh+w4qbzIJlj7WUH9JrBAZWT2ScLBekvMLZiBY2eICJWR8VfeREneB7MBfvhNQA9cw
         qoag3Pvo64Wt02JcBFBKB8aN/4hfFYYBrkpe3JUzdnXn/+lhZPxY/MF7pXwbyaNIM21X
         +Ui8DW+1fEHsQuQWKTGMTDgDjmVRYaGP5sI6AUa+K1lifkExDx0S3NyWjcy8EjTA4M+u
         DB7FLutWGTe3yy+3Jn4j3kvqZntUiRSOfBRtMzRNL+KskRYeNZMA80Ws6RqnZv46KzQS
         Ix73RJzkC2Vtw/SuL7Q4AJ/P6XDDF4l2x9ml3fRHEDcQ1c6BiAprhjz3b33QrG8lYxpQ
         +9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253144; x=1774857944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=knhNTSGkOlCa+PNQ+g5kmrFZB5Z9Igxlgp27B41Tmhs=;
        b=XYxo5Y7RzMDDR1O2GXYDo5A6l/L0aVb5TLiLb6OPbX4vOrLKF3xX1mDs3f3OL1n2gt
         FjPMWI/1E1nR0om1IX5aR689cDY9gDjcw5wCwUE2aPIWfFgI2zrNtLOoifS7oYtAFIcm
         cyfKTtQPmfSV3ud1YDM3fG7ARnbeqSbOoIbgj10shc99F0W1mbZQnfEq6U/NQQhIh5LK
         M6iOIvpa6vURatAOzsjvR8YI9HtTGsdpMCvvzdHWNvuRp0TmxCHfrHpMdwiH60K3LtHx
         4bOcNz4eUj2asmBmWtlBrYEfXpvqDSRaONlZZza5Dpt5SJQaDd2JmYqV/WfDpjH+mIuP
         myXQ==
X-Gm-Message-State: AOJu0YzgE9ueaEL2qDMuSDZR/i5Fyxjh+VskZs0WINWgT1hGxIoHajfY
	oHKq6ruA3VQfm5XHGkBoDyMWomL/I+IcPUh4BqpRY338l7Eyli+nE8rnpr5Gaw==
X-Gm-Gg: ATEYQzxAIQ8TOl2FmGTrDjNliK8JFreNb8Xt36sZkHCL7m3p4VPD2N5mWNeNt5RJV75
	5254lJEuZgH9maZsAVCLlzP0R245Xrjqsh4ka9epasEDJXOaHK6JOQhlEFQQx4Jmvm3vB9nj7jW
	uenwb8dg4Nt5R1tCQ0Jf5RwskkOFi7vfOPqIwYNA+b1PDE5BGWPIK5A7GlSmG6JXPYhxL8AwiI0
	ABx6baOJISAIjvk0WlOG6eGpgzHq+hzBRFfLnUkoM/45keKeF8/zV9T3RozNuCbCoqL9RFt9bqr
	41eCxk685+eg3HPE8S+b6PoTbAUQUx3ipB5wEnfZT7tHDPFsp1wEvvF2DKSnnJslGRYp81w3Zfw
	ewqkF3eHcM6x9ReKzwMXIAk7IUrUGProcMZjhvtaEIGffsy48NjE2FyW7Q8Mrc6DfNuN1L/Rn7U
	DxdLjtYvMJRJtg9K8foZBn6NJ5TJH2SNqzSbTAQFzs5mMsu3dmHqpfnDbA3Evsaa7OjNdctO1WE
	h3hYrH8EElu9jMvJnl/HuPOX1ph6dLLy602Jvg=
X-Received: by 2002:a5d:5d86:0:b0:439:b114:60c0 with SMTP id ffacd0b85a97d-43b6427840dmr17298499f8f.35.1774253143621;
        Mon, 23 Mar 2026 01:05:43 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:43 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 03/16] urlmatch: add url_is_valid_pattern() helper
Date: Mon, 23 Mar 2026 09:05:06 +0100
Message-ID: <20260323080520.887550-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.625.g20f70b52bb
In-Reply-To: <20260323080520.887550-1-christian.couder@gmail.com>
References: <20260323080520.887550-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit, we will need to check if a URL that might have
glob patterns looks valid, so let's export a dedicated helper function
for that purpose.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 urlmatch.c | 12 ++++++++++++
 urlmatch.h | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/urlmatch.c b/urlmatch.c
index 989bc7eb8b..a8cb6c3bee 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -440,6 +440,18 @@ char *url_normalize(const char *url, struct url_info *out_info)
 	return url_normalize_1(url, out_info, false);
 }
 
+bool url_is_valid_pattern(const char *url)
+{
+	char *normalized = url_normalize_1(url, NULL, true);
+
+	if (normalized) {
+		free(normalized);
+		return true;
+	}
+
+	return false;
+}
+
 static size_t url_match_prefix(const char *url,
 			       const char *url_prefix,
 			       size_t url_prefix_len)
diff --git a/urlmatch.h b/urlmatch.h
index 5ba85cea13..4e01422a02 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -36,6 +36,17 @@ struct url_info {
 
 char *url_normalize(const char *, struct url_info *);
 
+/*
+ * Return 'true' if the string looks like a valid URL or a valid URL pattern
+ * (allowing '*' globs), 'false' otherwise.
+ *
+ * This is NOT a URL validation function.  Full URL validation is NOT
+ * performed.  Some invalid host names are passed through this function
+ * undetected.  However, most all other problems that make a URL invalid
+ * will be detected (including a missing host for non file: URLs).
+ */
+bool url_is_valid_pattern(const char *url);
+
 struct urlmatch_item {
 	size_t hostmatch_len;
 	size_t pathmatch_len;
-- 
2.53.0.625.g20f70b52bb

