Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014FB39FCE
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798737; cv=none; b=jAKyc7Oz29DBsa/WBXvazYZ5V8SPCli5n66HM9ZUBIaUs+iJKmO3PX2mzwSR1qWLcP2Qbk9K7Av4aK38CNyMBD5n6JSCcFnMSo8dJEKVcFhQfpW1qG+ibl+jgi9nuS1NGVdigrxyfaGqUHh+HE3UROV9/F8nzm3t1xIpVI2o3Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798737; c=relaxed/simple;
	bh=fq1L37oX+kp0OmLm12Qgdz6+LUWxyMb1wW1Ki0XbgRk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=JcmSdvDWwHvYh1ZHC047BNRurJBjydD3ZG+2HOhvXcSqWVZHaEIBMgJBdvm+ASV/LCyBzlxlI+6oq3cG2PKJKfBfG8Y+rAYyqP+SA69HQgUAljoovlT55q3/a1cQB7jQVA+cldA6kVOQ5ZcpLdpj+kCypg3TF1ucCw/OxHX9Cuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q528FPbq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q528FPbq"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ce98cb8165so2862455ad.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 02:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784798735; x=1785403535; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LPo2pxLRFHQaBuzZgLLNuJWh2uwdzyp5AjZu7qtdgmM=;
        b=Q528FPbqtHKoRVuOlIql4FF9ty/wBM5AxloGwbultP/yB/jABqYvNWoPyPiRGR0hQR
         rJyx2R6dqR/lzd8hNNFcuCRS/83q/434RzEfGpFukX2iH/4ZNlcxNwgAIPkYtLZTt3g9
         SKnOpVkiGz5zqH1j5cVWW7mRyrRK403B84OaQqib7oAHbsZCCFQWxnQteckjvBZWI+eV
         oQdQ76CdE07x63NjhugX3zNbQxbANJl+/pDyEDuJwhGZEKpotS4z/V20/j+1jXHVaiX9
         E+1cfDyf1EX3gqzBVLQ4edyJxqJ6v3jxj8jt9DuaTQG8QHH7DpakFwkzpwg5rsfg7QM6
         5EHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784798735; x=1785403535;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LPo2pxLRFHQaBuzZgLLNuJWh2uwdzyp5AjZu7qtdgmM=;
        b=cBCpqt0UszGPVm8ZZdGgyWOZYGmQ8yS+EpC1vT3sTX+RlZrGH+G/nmMDim0gkfN9GJ
         +brPLwzWfMmNBYfmJOVMwkGn+lnJalpjgYf1iE78jWz0RhHMoJcBw5XtdzDyb7r3UOJM
         3NVmajYMYfJe+6wEwJw5kFqOCvwn4iuNsKbxeSvuQYDCYsyauOT84ppoGzynAkWkhAx5
         nDwVxdRgHE3fSMqxlLkY+978bxbNQiMNLvJge53zOBOIhyjcjIGsE0GS7oOf4OPON2qR
         H76IBkIjWPzcP7WLSZmBhPfl/NkFtcvLzqY1zK2RHCEgsNFka1yheDj/567sE3EsT7FG
         o8ew==
X-Gm-Message-State: AOJu0YwSRkSN3Gas7X9cKN1FA5iiBcPrzScGWh1VjtjJeYo66/RihLZt
	nFm1CM45eF3jBMWtkbifJj+CZR/xm5YifBTXqyZUjxdoazlpB5q4xJoqCz6wNg==
X-Gm-Gg: AR+sD12qqwuI5T6gmCtXfl3OgOeKK2DncW7fYx52F2CS7ztZrctsjNCjRvf4uDJZqTX
	i5BBe3TzZed1E2Rayx7R121QJYbqwmJoKV25xPfnpcP0vj1yzILXbk5apPegyhaPuy4G5V9SLIJ
	4ctAdPqH3PVgnsL42n27XDCrhtHMG1zST/6/KVOH55yrlebpxpl9H+FpFM0Ze+rOCyTSjP92s6m
	6o1M4oa7KP0Qj/rGyqmdmjuJ38GApE3Bt0goWSeA4d7iBC+FdLyg3Dck0EzAVPEPqblVNsdtLif
	BxRUHd94lSNZwOumhWlXdfFtQZZNTMqc2iwfWFCEn4wXaBVXYqV2Uy/ZSK+xyIg8Vr7w6+BE6qb
	glSD/xhbbILVAayIzJO3Ico/cjlwmRKLCb+izQ+4wZEAIG3oAd7R14+EIrabS9ag76DleKc8fB7
	DTaCTT0Q==
X-Received: by 2002:a17:902:ebc7:b0:2cf:7db9:e13e with SMTP id d9443c01a7336-2cfa94306e2mr20707675ad.3.1784798735099;
        Thu, 23 Jul 2026 02:25:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.128.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f3bbf58sm29699255ad.82.2026.07.23.02.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:25:34 -0700 (PDT)
Message-Id: <pull.2362.git.git.1784798733557.gitgitgadget@gmail.com>
From: "GalaxySnail via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 09:25:33 +0000
Subject: [PATCH] http: add a config to limit the connection time
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
Cc: GalaxySnail <me@glxys.nl>,
    GalaxySnail <me@glxys.nl>

From: GalaxySnail <me@glxys.nl>

By default, libcurl uses a 300 seconds timeout for the connection phase,
which is too long for some use cases.

Add http.connecttimeoutms and GIT_HTTP_CONNECT_TIMEOUT_MS to specify
timeout in milliseconds for the connection phase. Both of them call
CURLOPT_CONNECTTIMEOUT_MS internally.

Signed-off-by: GalaxySnail <me@glxys.nl>
---
    http: add a config to limit the connection time

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2362%2FGalaxySnail%2Fhttp-connect-timeout-ms-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2362/GalaxySnail/http-connect-timeout-ms-v1
Pull-Request: https://github.com/git/git/pull/2362

 Documentation/config/http.adoc  |  7 ++++
 http.c                          | 11 ++++++
 t/meson.build                   |  1 +
 t/t5585-http-connect-timeout.sh | 60 +++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)
 create mode 100755 t/t5585-http-connect-timeout.sh

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 792a71b413..a4f7afa61e 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -300,6 +300,13 @@ for most push problems, but can increase memory consumption
 significantly since the entire buffer is allocated even for small
 pushes.
 
+http.connectTimeoutMS::
+	Maximum time in milliseconds that you allow the connection phase
+	to take. The connection phase includes DNS lookup and subsequent
+	TCP, TLS or QUIC handshakes.
+	Can be overridden by the `GIT_HTTP_CONNECT_TIMEOUT_MS`
+	environment variable.
+
 http.lowSpeedLimit::
 http.lowSpeedTime::
 	If the HTTP transfer speed, in bytes per second, is less than
diff --git a/http.c b/http.c
index caccf2108e..befe9ea8a0 100644
--- a/http.c
+++ b/http.c
@@ -68,6 +68,7 @@ static char *ssl_capath;
 static char *curl_no_proxy;
 static char *ssl_pinnedkey;
 static char *ssl_cainfo;
+static long curl_connect_timeout_ms = -1;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
@@ -450,6 +451,10 @@ static int http_options(const char *var, const char *value,
 		max_requests = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
+	if (!strcmp("http.connecttimeoutms", var)) {
+		curl_connect_timeout_ms = git_config_int(var, value, ctx->kvi);
+		return 0;
+	}
 	if (!strcmp("http.lowspeedlimit", var)) {
 		curl_low_speed_limit = git_config_int(var, value, ctx->kvi);
 		return 0;
@@ -1215,6 +1220,10 @@ static CURL *get_curl_handle(void)
 			curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, http_proxy_ssl_ca_info);
 	}
 
+	if (curl_connect_timeout_ms > 0)
+		curl_easy_setopt(result, CURLOPT_CONNECTTIMEOUT_MS,
+				 curl_connect_timeout_ms);
+
 	if (curl_low_speed_limit > 0 && curl_low_speed_time > 0) {
 		curl_easy_setopt(result, CURLOPT_LOW_SPEED_LIMIT,
 				 curl_low_speed_limit);
@@ -1474,6 +1483,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 
 	set_from_env(&user_agent, "GIT_HTTP_USER_AGENT");
 
+	set_long_from_env(&curl_connect_timeout_ms, "GIT_HTTP_CONNECT_TIMEOUT_MS");
+
 	set_long_from_env(&curl_low_speed_limit, "GIT_HTTP_LOW_SPEED_LIMIT");
 	set_long_from_env(&curl_low_speed_time, "GIT_HTTP_LOW_SPEED_TIME");
 
diff --git a/t/meson.build b/t/meson.build
index 8ae6ab6c5f..6196736cb2 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -724,6 +724,7 @@ integration_tests = [
   't5582-fetch-negative-refspec.sh',
   't5583-push-branches.sh',
   't5584-http-429-retry.sh',
+  't5585-http-connect-timeout.sh',
   't5600-clone-fail-cleanup.sh',
   't5601-clone.sh',
   't5602-clone-remote-exec.sh',
diff --git a/t/t5585-http-connect-timeout.sh b/t/t5585-http-connect-timeout.sh
new file mode 100755
index 0000000000..7363e23bfe
--- /dev/null
+++ b/t/t5585-http-connect-timeout.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='test http.connecttimeoutms and GIT_HTTP_CONNECT_TIMEOUT_MS'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'setup repository' '
+	test_commit initial &&
+	git clone --bare . "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" config http.receivepack true
+'
+
+test_expect_success 'http.connecttimeoutms accepts a positive integer via config' '
+	test_config http.connecttimeoutms 5000 &&
+	git ls-remote "$HTTPD_URL/smart/repo.git" >output &&
+	test_grep "refs/heads/" output
+'
+
+test_expect_success 'http.connecttimeoutms=0 is accepted (disables the option)' '
+	test_config http.connecttimeoutms 0 &&
+	git ls-remote "$HTTPD_URL/smart/repo.git" >output &&
+	test_grep "refs/heads/" output
+'
+
+test_expect_success 'GIT_HTTP_CONNECT_TIMEOUT_MS env var is accepted' '
+	GIT_HTTP_CONNECT_TIMEOUT_MS=5000 \
+		git ls-remote "$HTTPD_URL/smart/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output &&
+	test_grep ! . err
+'
+
+test_expect_success 'http.connecttimeoutms rejects non-numeric config value' '
+	test_config http.connecttimeoutms not-a-number &&
+	test_must_fail git ls-remote "$HTTPD_URL/smart/repo.git" 2>err &&
+	test_grep "bad numeric config value .not-a-number. for .http\.connecttimeoutms." err
+'
+
+test_expect_success 'http.connecttimeoutms rejects empty config value' '
+	test_config http.connecttimeoutms "" &&
+	test_must_fail git ls-remote "$HTTPD_URL/smart/repo.git" 2>err &&
+	test_grep "bad numeric config value" err
+'
+
+test_expect_success 'GIT_HTTP_CONNECT_TIMEOUT_MS warns on non-numeric value but succeeds' '
+	GIT_HTTP_CONNECT_TIMEOUT_MS=not-a-number \
+		git ls-remote "$HTTPD_URL/smart/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output &&
+	test_grep "failed to parse GIT_HTTP_CONNECT_TIMEOUT_MS" err
+'
+
+test_expect_success 'GIT_HTTP_CONNECT_TIMEOUT_MS warns on empty value but succeeds' '
+	GIT_HTTP_CONNECT_TIMEOUT_MS= \
+		git ls-remote "$HTTPD_URL/smart/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output &&
+	test_grep "failed to parse GIT_HTTP_CONNECT_TIMEOUT_MS" err
+'
+
+test_done

base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
-- 
gitgitgadget
