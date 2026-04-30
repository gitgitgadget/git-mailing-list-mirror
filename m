Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E284A3BF667
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546480; cv=none; b=R5r0Wya/GJKoyCBWKi7SxlQajVlaF0Mo89Le+UJPM1pr/HDDiwdty2O0VdMrAH/oTwc7dTOui+hSyt1GlUhX7uErEWCfcgTf17b6WWt8d5lY2/cSlWIT6iXYF3pdHuL7k8VhXkpCIbg9fltmq0f9DljTEubK1439XCgE7c6wFL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546480; c=relaxed/simple;
	bh=THGskOHGWuBwCBBYrJJKhDNY11NGD5ZL0n0kUzveOTg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IudOuXdHZtxvcDGrFpeTHhJ3GaPJCnuEPa7Kyyyx5NA+leZr/oTKgbj1w9h7yNIldJP3aviFPMfudzazqqTy2Aqy6jgt5pHwNa2UBJDmOSkUBPFYiJJDG7hp+rWfmgo40wzMik6N4em+AEJSHVcqQvGJRmpWnqd9iuh9ZDvpIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtpsYwiW; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtpsYwiW"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b4520f6b32so1283321eec.0
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 03:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777546477; x=1778151277; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3M1oFC20+52tcAEAm0Q98Me2wu07wi9TJ+QAxGBrXQ=;
        b=VtpsYwiWfdyEJ60YUASQObFLFT9af2mO8yj1Pxio1zdJm+dljtO0t7pTx5SZYONzvC
         7zMc3l45ShKXNja+E406rLn7jmfFs4PoHAS0sOKXLqP9dCBWHnulNwhX1qlDoSELl3fH
         Ded+/amC5WuwNyL/XJ3IyfpTVUExG5PgLxo1jnm8g/+HNf1WGxkml3lzYEct6ed8fpH3
         xhdHT8CHYSUAt+s8tT9XygnGI+E6eZoCZsgawx76SzzlLEU5hHr01tphOAZRNzeUzo7P
         iSvuog5dCTwboZL6VSnvB2QMnVNun2dfgiU2mPomULW0ydhrjyzHK9BrWnZg5dji8PiI
         5VCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777546477; x=1778151277;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y3M1oFC20+52tcAEAm0Q98Me2wu07wi9TJ+QAxGBrXQ=;
        b=UfSUT03SyaZfi4GqMcrElPTJOIbw1fHU+KiKboGg9Qg3zo8hznGiZnhTgivcAS433b
         lB24G1jqtvmc1oTPJQ0+aVFez888RCr2MQlo6Ixny2ZNaWpeXgcYo7/qBeP1sLkRVmWp
         SABrJCl/lqzEpcZa93pIQgXt7G9EcTjvja3NVYHIYQSMJBmnBftG9mMkImqM1f6D+ihJ
         ovaBflhoqoJBbZRFhC4P9BpTtECQYRTa6z4FXmnH7EKIiHm3Do/G2tzRC3ZmY9QCCyaZ
         sUmPY374K0qzF6PcYLC59QbJvKMb1XUTGRzD2B9pVEfREwLCLFbAA2u5LXzidEgC2We0
         Py8w==
X-Gm-Message-State: AOJu0YzYir9/d/GpYjXenykEVtiMERWS1fUfdQ6VVuRN2DuP8s4gnPxM
	b2yINfZjtjAlYW899bTFpTq1vryeek7MbSGo6AXIVBM0iRxrynSDI7xzGUVVKZlz
X-Gm-Gg: AeBDiestOBvaEWMO/7LItH4Nb0bcDIGGtcJmlDDdz/k8kHfxDLnVrAIcUCtKwAXMgkv
	9z79vL+OnhpvQ1zhONBk95F6Za30q+ZysN8ZX5MyIp13/PW+k292XIAjVbsPvW/DkCNCnM5+p7o
	N6UkR0Gq+W6A+n+PvxL2vg2CNx+z4besQtnc8nQK1cmm6WAjCuWZTvAGluNoF4m46hFjyT/wato
	Mj3M4BUhzR8dYeGNuUMMf4CXoTiCssvxY6HtXzGwUNWkx8N+/wm1vQxkitHVJ3MRyRzopdNjrJP
	xBrfsqKDVrJSl9o5eHmtg0O2gCGG6/X4K51AJ0T1m3UFsevPGwF+9PVyVmarrxRl0aFOk/mgmbQ
	LYDJ1yN0dBs9EIgqWc2XffFJtvsl8aW0ZhLwkLrxYdADzT9q6Vk5+D9YoD3whMfrdWUDRpMpW44
	FCppUiDjZAIuuFgbRk7j0KRT5CTBH5TIGNM2m+
X-Received: by 2002:a05:7022:e17:b0:12d:de3f:f3e6 with SMTP id a92af1059eb24-12dead2545cmr923520c88.38.1777546477354;
        Thu, 30 Apr 2026 03:54:37 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.40.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de3261533sm7321486c88.9.2026.04.30.03.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:54:36 -0700 (PDT)
Message-Id: <f175294459c9370ed79c8338d6008b69c2028f99.1777546472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2087.v2.git.1777546472.gitgitgadget@gmail.com>
References: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
	<pull.2087.v2.git.1777546472.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Apr 2026 10:54:30 +0000
Subject: [PATCH v2 2/4] http: attempt Negotiate auth in http.emptyAuth=auto
 mode
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

When a server advertises Negotiate (SPNEGO) authentication, the
"auto" mode of http.emptyAuth should detect this as an "exotic"
method and proactively send empty credentials, allowing libcurl to
use the system Kerberos ticket without prompting the user.

However, two features interact to prevent this from working:

The Negotiate-stripping logic, introduced in 4dbe66464b
(remote-curl: fall back to Basic auth if Negotiate fails,
2015-01-08), removes CURLAUTH_GSSNEGOTIATE from the allowed
methods on the first 401 response. The empty-auth auto-detection,
introduced in 40a18fc77c (http: add an "auto" mode for
http.emptyauth, 2017-02-25), then checks the remaining methods
for anything "exotic" -- but Negotiate has already been removed,
so auto mode never activates for servers whose only non-Basic/Digest
method is Negotiate (e.g., Apache with mod_auth_kerb offering
Basic + Negotiate).

Fix this by delaying the Negotiate stripping in auto mode: on the
first 401, keep Negotiate in the allowed methods so that auto mode
can detect it and retry with empty credentials. If that attempt
fails (no valid Kerberos ticket), strip Negotiate on the second 401
and fall through to credential_fill() as usual.

To support this, also teach http_reauth_prepare() to skip
credential_fill() when empty auth is about to be attempted, since
filling real credentials would bypass the empty-auth mechanism.

The true and false modes are unchanged: true sends empty credentials
on the very first request (before any 401), and false never sends
them.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 http.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index f208e0ad82..1c7ea32ef2 100644
--- a/http.c
+++ b/http.c
@@ -138,6 +138,7 @@ static unsigned long empty_auth_useless =
 	CURLAUTH_BASIC
 	| CURLAUTH_DIGEST_IE
 	| CURLAUTH_DIGEST;
+static int empty_auth_try_negotiate;
 
 static struct curl_slist *pragma_header;
 static struct string_list extra_http_headers = STRING_LIST_INIT_DUP;
@@ -667,6 +668,17 @@ static void init_curl_http_auth(CURL *result)
 
 void http_reauth_prepare(int all_capabilities)
 {
+	/*
+	 * If we deferred stripping Negotiate to give empty auth a
+	 * chance (auto mode), skip credential_fill on this retry so
+	 * that init_curl_http_auth() sends empty credentials and
+	 * libcurl can attempt Negotiate with the system ticket cache.
+	 */
+	if (empty_auth_try_negotiate &&
+	    !http_auth.password && !http_auth.credential &&
+	    (http_auth_methods & CURLAUTH_GSSNEGOTIATE))
+		return;
+
 	credential_fill(the_repository, &http_auth, all_capabilities);
 }
 
@@ -1895,7 +1907,18 @@ static int handle_curl_result(struct slot_results *results)
 				http_proactive_auth = PROACTIVE_AUTH_NONE;
 			return HTTP_NOAUTH;
 		} else {
-			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
+			if (curl_empty_auth == -1 &&
+			    !empty_auth_try_negotiate &&
+			    (results->auth_avail & CURLAUTH_GSSNEGOTIATE)) {
+				/*
+				 * In auto mode, give Negotiate a chance via
+				 * empty auth before stripping it. If it fails,
+				 * we will strip it on the next 401.
+				 */
+				empty_auth_try_negotiate = 1;
+			} else {
+				http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
+			}
 			if (results->auth_avail) {
 				http_auth_methods &= results->auth_avail;
 				http_auth_methods_restricted = 1;
-- 
gitgitgadget

