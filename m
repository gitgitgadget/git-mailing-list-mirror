Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467DE3B4E98
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546478; cv=none; b=bWwWUmqMhYx95p0qNsiPKPvIVnrIGguopwU9nGD4y4+8Hkr532Q2UtRCj7Yb+sYx3rqBtEf5+dh0YTbtlDdLRBG8cTqO3qAVSafy+g87xEP1Kty/OcYTQMtaP4v6W1+0HHNDCcezQm9nmcsfk9jm4ewLONJqmw7M2uLo0rP5cP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546478; c=relaxed/simple;
	bh=Rzs9JWUON2lfExV2/3yNY8SiloU58aHLKVKIHN0zcsc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pb08sl078A5pcAus76vYicJESzSvGOkZqcFL1C0b+DHHFHPtLd9sOEPsIDcNRXPcUusLBHRMlj+NZFGFYIl9nvOW99qXoyeGF9ESQDs8NyILKnpI51YBFtWFe4pnHYxxdIhVxb1FKS94qjbAcCJ+PWmaVSV8oFhAOOVuSM9+/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWQz1HgC; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWQz1HgC"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2d868d014a5so786221eec.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777546476; x=1778151276; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Cy6Y/RV1dt6G3mU0S44K1/Vsd0MB+Dcb4kgKkYQxRM=;
        b=DWQz1HgCpa6V851/8JcXJ8JwAl1y9Welq/lQVjUiHp/roxLjLBkkWf6/yK5jQXA69B
         UUJGDNQB+0NMdea+1mNuptR9o+fKFHz3y/+MU6mCXAZTjTPLpAht0gZa3KqPYjrGhpn6
         bpsxvscIPU4860N2isLdOmUcRUFMUKOSHGUVnaAswxbqq0FukzeSa/fh45llKtEfxsdm
         voVau0VqoQ/yfCIlimmae0X2vG8bQpXKWKgmbSO0eNNJJ4v/BOt1fbEb/zIHLiZM7hyY
         H5bJzQuYTLH7vODDzPH8mddRZHhgoRoDE9zQWKz3fF3UlZT3b78HurFjKZWjd1XSbeDp
         f3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777546476; x=1778151276;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Cy6Y/RV1dt6G3mU0S44K1/Vsd0MB+Dcb4kgKkYQxRM=;
        b=DDm4uYRnHHPKtvkp8JLRHv0SInuFiAkdLBDqShaPNsCmTCWmwikTlf5T2YKIQ3FYcv
         sd3q58q+2aHIo3aIbHVyB3OjPpQdKhJ0J+VQM6gK8Z2UpztrmVrHOQj4/SrMcadBJ14a
         noZveZPYcdPsCAZAQxIxifVSQUw51ms6a4YmtzzGf5Uc+ot2Oso1FHoVfk3+Iz/EDzMS
         94GoHG2S7w8MwbRLqKTLG4mAs5dOjLW9mI8rCD+rW4FfVhXwTcrqwPAOp9P6/FHjdCx1
         zopjf60gctRvWdyLpRozJ5hfbbRNhGBwi2bbz1EKZEcmyVO0js8AQ9uCrV0ahiGgLagk
         Vz8g==
X-Gm-Message-State: AOJu0Yz+9J+xF/DXPCNXP3msvrw8f7Q37NDBY/1MOVvjlJIqLkc0KDU+
	Oi7Iyw0LmUa3hOtS2OZSL31eNEVhrFBMpeuImwr+OQYTA9nUql1f+pjeo+VIil2S
X-Gm-Gg: AeBDiesH+NwHOW5pnCOmgOxJFktoPRgErKhlyJ57lEtZ3fRsSRpSvElmQBF7yOoIiab
	Q5AehBdWr3genFpWCUQMP3yVivht7biEKL7XqQ+On5wFcqQOsf3yqtWEinOdsxvvet49p5aEGf8
	GjqaBM8GYiZ5D3/Skoab0EL5B6jKDqiJ+aRXH/0AGrp0b78CTj0dCm754oNrY3SqKeJ7O4ckex9
	eiV/r2DXIz3Db22qPxQp7fMkNoqcgPM93TL7NgtVmbIefXBQc1l9+rhtRijaOtQ7iiciwUxTKxI
	ljVJfuuBmEwNA32c7Kct8ni48mrYqIeKM9K7s6e+KzYoK1i92dyNXR2XcA9XlWZ4sT2OaDxRXCR
	C3luqWdOrAKy9l3J1k3/Iv30uEX7dkL1F/4gHs9YwrN+x9vy1JKHISuekZcSO2XSFdze3Ul8IBt
	8n3VmMQFcTlkcbGYTN2MFcBvMTAMGU1Ad9aihb
X-Received: by 2002:a05:7300:5411:b0:2c1:558c:16e1 with SMTP id 5a478bee46e88-2ed3c5c9cf0mr983917eec.4.1777546475821;
        Thu, 30 Apr 2026 03:54:35 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.40.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1bf8e77bsm6318223eec.11.2026.04.30.03.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:54:35 -0700 (PDT)
Message-Id: <49488cc7d44404b9af55859dd892427bc8ee9142.1777546472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2087.v2.git.1777546472.gitgitgadget@gmail.com>
References: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
	<pull.2087.v2.git.1777546472.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Apr 2026 10:54:29 +0000
Subject: [PATCH v2 1/4] http: extract http_reauth_prepare() from retry paths
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

