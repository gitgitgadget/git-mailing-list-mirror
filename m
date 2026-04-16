Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02739A7E9
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331266; cv=none; b=QGNT6m19nQiA5cEHwCd/3SavQXts3Hwk2egqve0JzEVnUsZJG+ym8+4Yk8tNMsEWltPnlYKF3ixL0OhklU2CG7+YSv+9VO7+rfmAfe6ByA+imnbiF2rA/JJHUIvfg9utRFBVLIcSOjIdntcT7A6N2kgaMc9efi0swJaq89H7hdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331266; c=relaxed/simple;
	bh=THGskOHGWuBwCBBYrJJKhDNY11NGD5ZL0n0kUzveOTg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LTmF/K4sIPpJ7S8GrWRoHmLGpyc6ohbEvqUJyy5YQy+DxLl5b5kzF6qgX1la6icWDvpYbcdQ7fnkyLOUxYM1omTbhB73V/4N4cGqCpxqQlEvs/+EPVW1kBHtkaM1ywRP1HTCseFfZ4ZB+z5Ncvk6Ma+D9Bh7UMgLVRGGOJrUUJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JF0DbnCB; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF0DbnCB"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c565476d7so2519951c88.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776331264; x=1776936064; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3M1oFC20+52tcAEAm0Q98Me2wu07wi9TJ+QAxGBrXQ=;
        b=JF0DbnCB76czoC7nj7GmJ7OiSIPHd1gvNnvDyOghJQHJftTJFxj7z6zDxjaC04YNs/
         qebFzVlYPvI1JtVg2ySYI1aJJqYX4LM2wwfgvb5b4tadFcKAX2l0fS0JYo6qV4eYm9dw
         tUPSD1zFtIKZyWk1zDxfiyouF8yuM1TzXEE+A4UlchQgAvLOAvE/MounahgfyHakFNZs
         pa6F8MX8dYXX6gkcIzvS373bbW1vdCJhO+e/yBEwubEpj39k61H3yCm+D2FWwa3KmRxf
         JPVikmY2b2MGACXumUrYMBEuFzQdarcQ1BmjdGoK/EG1uTskfpm5xJKn3+9inUtHnQ/K
         zrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331264; x=1776936064;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y3M1oFC20+52tcAEAm0Q98Me2wu07wi9TJ+QAxGBrXQ=;
        b=mzFpiVpEuP+Ts9walBfpN3m6r2TzuPTPeBXbmrWXOpltgdLI6I6Rij+scI6ju1mR4R
         Di2PTw29U7TE91qgx362tLenV+wLnPhoStWy7KaCvpXVpRjXrDhvVybPntMBiLyqqDBd
         V2+DQYBy0KrpQN9YOvgr+8YwSdOOYNIlRp5XtpVeX3q1Ejp+6oCzM+zAJqPflkjWqdtO
         F1tMUgrUe4IBpoJGUO7/l52v5W/2gEQy6mz2xzC+o8fvywxFXuSGhfc9PuHurpnC9EXV
         3mYzXTfMQnbaz3Ul2EWmhiqetZ4RKKgXaIO8Ntpa8rz9dL0onC0wCKRSvMwGHETY6guA
         AS2w==
X-Gm-Message-State: AOJu0YwY6RNdbDinQzKY4rWQe/kPBjOLforDbcXkHwJEZwlZBOTyvo0U
	6BT4CCoFDsrTrzXx1VQbuAYZ34IcId4pCJ/BlFm1VqQ9FE2Eyi8OS9Y20nUG8w==
X-Gm-Gg: AeBDiespRP4Jg/s0tW7s14TpIbcfmKuMhN+ybNuvdm/2nc6u8VOnMcYz/2L6JhyaRc6
	PA34xLiMHmAqa5gKER+LhKIwuJ2TcnNUBHMaHDO7hhZWvtwI3mJsPMcZYaiqPuzHkpoGZXxXUQ9
	DXqUGm9JSeknjUlnhX5ktxYIAYccugzdTwl+i1LdarKCN0qLk4kuMtfk7EPQukA+PCxPgevpAYb
	/bQEnSvkKibmH8amPqEEZGqhji5Z+wKqJFHFJdH7HLM4t4fanNG4q0z0PM8wR7LVBxHWkIf9Bwb
	xIJQZsYOW2JNoqH8XDjsES40R2sKxjRvUvnDRD6SPazhYauTFVo5COwc/Fs4GdYkFGVJvZ658Xt
	OK4QNM+U6fbdg+n6c8H6VvkWUJ8OA+w7wwi2ReBEgiPyXnVZbEMkxwplsg7DpJk6e6dHhkKA+CR
	oOZoGWprMSMhRXElJm59x2YDxRnisxFqx1gw==
X-Received: by 2002:a05:7022:389:b0:128:d24a:a5c1 with SMTP id a92af1059eb24-12c34eeac88mr14786127c88.28.1776331263713;
        Thu, 16 Apr 2026 02:21:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.72.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e630143sm7526994c88.6.2026.04.16.02.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:21:03 -0700 (PDT)
Message-Id: <f175294459c9370ed79c8338d6008b69c2028f99.1776331259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
References: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Apr 2026 09:20:58 +0000
Subject: [PATCH 2/3] http: attempt Negotiate auth in http.emptyAuth=auto mode
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

