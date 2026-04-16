Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EAD391838
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331264; cv=none; b=Cg8wakiCVHZMx0tnc5ZBYlR0xwxPzOeTEAftMheF/tM66ahd6v45sx1+61guCuAvm7UsWld2iM0lcMRvjx5XbW3Ey2Pp4hYfm2ShYguKMe9SUIMLoQEreZiV/j5wOJ4y3y2lW7dMzQ+++ww5IXvjgEvtWKt6Q/hakX/ZEQ0rJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331264; c=relaxed/simple;
	bh=Rzs9JWUON2lfExV2/3yNY8SiloU58aHLKVKIHN0zcsc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=guxwEMGhtOkKGF0diNelb71V3kFlb0W4FPULC7k2HSE3hZnwf8IM4vfMJ+6eLsr4fP45NpneDHWy1EK0TR+ygMbD1dDC4EOr5iu7J9tSKEk+BQQW1HtcdHYlxZoEQdcp2lhhp0LToDnTTd/hwLRhe9fm3u0SdCEVFkrYuGW/Ty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmMGP2EO; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmMGP2EO"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2d9916deb14so6553299eec.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 02:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776331262; x=1776936062; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Cy6Y/RV1dt6G3mU0S44K1/Vsd0MB+Dcb4kgKkYQxRM=;
        b=TmMGP2EO3IdgHBa29citqt5+Bn51hNupbdLZvjAT3fLVrf0wlY5gOFY/x6JiMSYTkQ
         CYW1cajhznyQ3hCs/v/3DpBIJyKdA3QGs/wjYEO9ggtHoom/fDDoD0TNoHIAyZiZSzP8
         /MMTQWIqJJiZ2h6+Zkpyh4KecwIDNnlMfC2I2UY+rV9eKlmlvWplQ1Jabyz9clD7JywT
         ADChVq7tUafZFDDUM2SAy31sYFtvR2ptP+Kh1bAzi6Vpz2FOMdQBvfKxdIdX2y5DS8qY
         Y/YH9TUhl2XgECH2h7zTLUJe7VnGX2E1KIVtgI44vO6HSgHVbMsVwyw+ktfZT83AzQJv
         DXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331262; x=1776936062;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Cy6Y/RV1dt6G3mU0S44K1/Vsd0MB+Dcb4kgKkYQxRM=;
        b=mv2MVpPz4qZqKSqwMIcf+fzc8uHkyUEj1muz8o0FkxIDjQww9f58G5hwwibe2QZwBN
         N4y+qWcShOIQx7z04nlRjR+d4ShE6A+7UVpE8tOSm56tnln4gX6NuUoj2Bh3ZvOtAd79
         j7DGsyFDEnwHXhOlT/+dHb19bvMAMrpPWfaR+8SVOVQwuQnTLYFefI9EVxpPFfQ/aEdk
         CSXaKCwdm5BOJ9BqUIjyaHbLrClKSBFEfyKIkpi/EtDJpMecNbYHt/PWwNPfQiGzMuYr
         E9a59cFw6FrWdCUFqsNpD5CryuLmcldv3hTbeQh/jtkYehz2i0iuwaCtYXOdYe5I+O7+
         fZaw==
X-Gm-Message-State: AOJu0YxeWsh0naGs3L4u7cuCHkl/qROHgm9eobhodUH17m9HnVCPOs2i
	h6jh0OR4lGGva8FdkrqD/RNN9OUdVEq6YhpXHwqoy8+uJErbk5LVbCqnu3x8Zw==
X-Gm-Gg: AeBDievq/13f3mulHvWm9Rm243OO5ffEQxfVWPc/PfSyqqTtR8v8XL/4GaArMSO+aUm
	Qibo/RrLxWI6TPUsuzFs2Qijr9s96mfTxKXv0FXWJGA3Zl18N7q3X4f2NU16PtGAfaG4O54vshf
	P1V/CMH8YnBbRhPXieh4/XflpntByQSVq0c6Djt967UsfrvlBFi3U5Cc71JoV0dBLB0+Kg3mmAJ
	VGZZkGIeOCxTZGN7CaGIlkNlziDogR4XuvfoblhsHPhe3IYeBRpObK1ocdTlAvLFdEATxZgzX2G
	Rm2njYVGhSUA4O7p0UCNhU1UFKIAFqNLcuuVyOmpWdJoXMGbYuORC7csdH+Maq0RPCTjEKA8ZEZ
	eNAetVDLN3lF+sH5j1SDLhmF5bBmsh8OvWCkHy5RDWwo9tNM8b4HCseIG3r/kXhuVLWF6CBwS2W
	eSMQtlIn1to/itYh0pkaP9X/e81XMJN3QfGA==
X-Received: by 2002:a05:7300:8292:b0:2d9:32c8:2b69 with SMTP id 5a478bee46e88-2d932c83617mr7267350eec.28.1776331262173;
        Thu, 16 Apr 2026 02:21:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.72.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb8443csm6590898eec.14.2026.04.16.02.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:21:01 -0700 (PDT)
Message-Id: <49488cc7d44404b9af55859dd892427bc8ee9142.1776331259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
References: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Apr 2026 09:20:57 +0000
Subject: [PATCH 1/3] http: extract http_reauth_prepare() from retry paths
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>

From: Matthew John Cheetham <mjcheetham@outlook.com>

All three HTTP retry paths (http_request_recoverable, post_rpc,
probe_rpc) call credential_fill() directly when handling
HTTP_REAUTH. Extract this into a helper function so that a
subsequent commit can add pre-fill logic (such as attempting
empty-auth before prompting) in one place.

No functional change.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 http.c        | 7 ++++++-
 http.h        | 6 ++++++
 remote-curl.c | 4 ++--
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index d8d016891b..f208e0ad82 100644
--- a/http.c
+++ b/http.c
@@ -665,6 +665,11 @@ static void init_curl_http_auth(CURL *result)
 	}
 }
 
+void http_reauth_prepare(int all_capabilities)
+{
+	credential_fill(the_repository, &http_auth, all_capabilities);
+}
+
 /* *var must be free-able */
 static void var_override(char **var, char *value)
 {
@@ -2398,7 +2403,7 @@ static int http_request_recoverable(const char *url,
 				sleep(retry_delay);
 			}
 		} else if (ret == HTTP_REAUTH) {
-			credential_fill(the_repository, &http_auth, 1);
+			http_reauth_prepare(1);
 		}
 
 		ret = http_request(url, result, target, options);
diff --git a/http.h b/http.h
index f9ee888c3e..729c51904d 100644
--- a/http.h
+++ b/http.h
@@ -76,6 +76,12 @@ extern int http_is_verbose;
 extern ssize_t http_post_buffer;
 extern struct credential http_auth;
 
+/**
+ * Prepare for an HTTP re-authentication retry. This fills credentials
+ * via credential_fill() so the next request can include them.
+ */
+void http_reauth_prepare(int all_capabilities);
+
 extern char curl_errorstr[CURL_ERROR_SIZE];
 
 enum http_follow_config {
diff --git a/remote-curl.c b/remote-curl.c
index aba60d5712..affdb880f7 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -946,7 +946,7 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 		do {
 			err = probe_rpc(rpc, &results);
 			if (err == HTTP_REAUTH)
-				credential_fill(the_repository, &http_auth, 0);
+				http_reauth_prepare(0);
 		} while (err == HTTP_REAUTH);
 		if (err != HTTP_OK)
 			return -1;
@@ -1068,7 +1068,7 @@ retry:
 	rpc->any_written = 0;
 	err = run_slot(slot, NULL);
 	if (err == HTTP_REAUTH && !large_request) {
-		credential_fill(the_repository, &http_auth, 0);
+		http_reauth_prepare(0);
 		curl_slist_free_all(headers);
 		goto retry;
 	}
-- 
gitgitgadget

