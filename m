Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B435950
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222483; cv=none; b=ieGA4mjAMhhzRuM9RQxP31iB4xAB5C2DiLTqdFBm1q7K2iD6VICAbdf0c24R/NpEmxVaH2ld+kM6bOOPJKiYyNj+ZCHyOoKGu1q9sa+Sjt3X9pA0HI8eqEyCM/fToDogmjaWXGGAXv30Q3KKMKzb/XC9PJzi1+Delth6NcNzxYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222483; c=relaxed/simple;
	bh=L3JdVzODKTGM1H+8HQhxzLKEx8EJE95uk8LZasb6a/8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=L07KDV3QBWgAYnpMkE2ZPAXmobGUbmePqxR0STGVGJ2oyq6Gp7diYm3BDA68lwKDm1MKy2vuGDujihMRhAM83ixGo71g9ilEPB5+2mzC6mT4rpmmSqsRPMr3yrIyDpUDYMkfsvIjj5YtTqkGnxvIJCR9oDZZwre5cY2hwAhPfQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qH9TgPDn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qH9TgPDn"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d560775ca2so29809365ad.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788222481; x=1788827281; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6dllLVuZeVpPrjdecSBEixYqoC6MYFsswZEtVXEe9ns=;
        b=qH9TgPDnsenwzfbr0E3n9twxql3GWpUIXqEtd8vP3F4vQzWsc+ROQkYFuoGpcuxyW8
         lP74KeYQH26gwmTJTvwcl13NH0yqP6/w+n/Z6ZEXLtnKbmDiPLfGPKsgEQW8a098/Lkg
         Uf4fFeuBos79Uil5EaI7UuuWFnJkSjYfzGCofqEhxvy/mugSxjIvaVcb+Y1r/u8/8ZPp
         CbWHSTIQekBMRByPG3JQTbyGNyg5PqGO4yIKfqE9TzSaOt56bONGulmV9cga1OOKQr+7
         AKRG8zdrUyIqBIWay1GzdDrf1gCfJqVUUmprIGVaXJ6RH2Cp4ssT1hoF+hhy+pE/dPvM
         +svA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788222481; x=1788827281;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dllLVuZeVpPrjdecSBEixYqoC6MYFsswZEtVXEe9ns=;
        b=XB3sebhEz0x2/rHZULKILqi/XHWVNRq+xPsRWxjfoY/RYR/8gtwnxjH8/00WtM/jtN
         uhk2Azffs3o0cFoknTFXSWKJIhdUWu297urai3dunePKbo5A77ht561/ayth9RQZevdb
         HwBHAmze1ngG4IqJfPEAAmvPO6G6vJGSNG8e3PXLe6pd41mMrjfAYoHMwQEhm8FPS4fH
         zWovztRpwRBZK+3239ledmg2TNbElOe4pZk1GbnkxqaxTEPo8FA+De6Uc9slCl6M3gU2
         d2UTVpJc28QMAeJEj4bjfY7Fx/2AD/ZolbDFB6RpAy27ZxbvNxBtUuq+ViAPHMBXuPJr
         lt5g==
X-Gm-Message-State: AFuF++nji3WLjFX6n8Aic0zoWIwZTwLhVPZlExn2MxLZFPCKqt/ogbf3
	ylNvjb1uaB6BZ0tPeC2KcznDulMT3tqe/VNQKHEst/zSb9AvyZFZKjxiNkAC3WmS
X-Gm-Gg: AYBFou3Z/rIEklbwWaKbrQFVZrwVJTT3chYY7kTPaj1PJ2PNDQ4AcuOxk8y48J1FyBk
	yAHngOfpKmg/PeUdW+b/L26CyDbAwvtJ/jle92ZDsX31cCbgLxIggpgZiE9zqKtJN27a2QjNA0r
	YTJzdeD1CMF97bCkmy9dhgvH81CY/3ej6jfldVKMj+dFNi812YKXoMz3Q1EAYkFVI9dd8Ni3G4I
	Ia9aQ8+TiDh+Q54O0CCNGZhITlrX8IqY62VvLcvQiuFx2nimtdU3gJE3v8fDp6o9gr+bC8wH4ZN
	OisxXTYfHTA0OBU7F0xnyugZX40Wm7sMdm8u2EQ26S7dEpRCqTM6fjJrI6m8i5NrRYcHEx7VxLD
	HxQriCdgPMNUT6cExnFB0cZyoNxpl4WZ2bLpLD3AMj5m/b7WeOTfo+aylBmFcu3nKKGVlrFPKIS
	pww2eeo9rak+tlg+kw9I4CdYDvLRyBrAi40KHuPVNsZWrF4Smb/MOKQydUwCIJAlLLiw==
X-Received: by 2002:a17:902:e950:b0:2d9:438e:b70d with SMTP id d9443c01a7336-2d9438ebad4mr88598745ad.1.1788222480840;
        Mon, 31 Aug 2026 17:28:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.55.133])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f99585csm32051923eec.21.2026.08.31.17.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 17:28:00 -0700 (PDT)
Message-Id: <79396d491fe15c94a4e4c079d1109b425dcf966a.1788222476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.v4.git.1788222476.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<pull.2171.v4.git.1788222476.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 00:27:55 +0000
Subject: [PATCH v4 2/3] t/lib-httpd: make http-429 first-request check atomic
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
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

http-429.sh is a helper for testing retry logic. It uses "test -f" to
check for the existence of a state file and later uses "touch" or
"rm -f" on that file to determine if it should return a 429. This method
of managing state can fail if the helper script is invoked concurrently.
However, this failure does not currently manifest itself since the
helper is invoked sequentially.

As a preventive measure, fix the state management logic so it relies on
an atomic mkdir operation to mark that a 429 was returned. When
$retry_after is "permanent", always return 429 now that we do not rely
on a state file that is "touch"ed and "rm"ed to indicate when to respond
with a 429.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/lib-httpd/http-429.sh | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/t/lib-httpd/http-429.sh b/t/lib-httpd/http-429.sh
index c97b16145b..1a5d7987db 100644
--- a/t/lib-httpd/http-429.sh
+++ b/t/lib-httpd/http-429.sh
@@ -3,7 +3,7 @@
 # Script to return HTTP 429 Too Many Requests responses for testing retry logic.
 # Usage: /http_429/<test-context>/<retry-after-value>/<repo-path>
 #
-# The test-context is a unique identifier for each test to isolate state files.
+# The test-context is a unique identifier for each test to isolate state directories.
 # The retry-after-value can be:
 #   - A number (e.g., "1", "2", "100") - sets Retry-After header to that many seconds
 #   - "none" - no Retry-After header
@@ -26,14 +26,16 @@ repo_path="${remaining#*/}"  # Get rest (repo path)
 # The repo name is the first component before any "/"
 repo_name="${repo_path%%/*}"
 
-# Use current directory (HTTPD_ROOT_PATH) for state file
-# Create a safe filename from test_context, retry_after and repo_name
-# This ensures all requests for the same test context share the same state file
+# Use current directory (HTTPD_ROOT_PATH) to hold state directory
+# Create a safe directory name from test_context, retry_after and repo_name
+# This ensures all requests for the same test context share the same state directory
 safe_name=$(echo "${test_context}-${retry_after}-${repo_name}" | tr '/' '_' | tr -cd 'a-zA-Z0-9_-')
-state_file="http-429-state-${safe_name}"
+state="http-429-state-${safe_name}"
 
-# Check if this is the first call (no state file exists)
-if test -f "$state_file"
+# Check if this is the first call (no state directory exists), or if
+# the retry-after-value is "permanent", which indicates a 429 must be
+# returned for every request (even if the state directory exists).
+if test "$retry_after" != permanent && ! mkdir "$state" 2>/dev/null
 then
 	# Already returned 429 once, forward to git-http-backend
 	# Set PATH_INFO to just the repo path (without retry-after value)
@@ -52,9 +54,6 @@ then
 	exec "$GIT_EXEC_PATH/git-http-backend"
 fi
 
-# Mark that we've returned 429
-touch "$state_file"
-
 # Output HTTP 429 response
 printf "Status: 429 Too Many Requests\r\n"
 
@@ -67,8 +66,7 @@ case "$retry_after" in
 		printf "Retry-After: invalid-format-123abc\r\n"
 		;;
 	permanent)
-		# Always return 429, don't set state file for success
-		rm -f "$state_file"
+		# Always return 429
 		printf "Retry-After: 1\r\n"
 		printf "Content-Type: text/plain\r\n"
 		printf "\r\n"
-- 
gitgitgadget

