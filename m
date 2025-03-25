Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE01254849
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899116; cv=none; b=UU1v1W2JDUmgfNtChg2TuFS9WcUvg3gxh7SaABrimFQdmVTAwXg4do5VfSIh3yP9fFXA0KbXxg0+RYEKPEWYW3ldyhOExMoCeMN6D/gSkXjP2dyXZ7TDuRgH9eKTbNTEl8fsRGm5FiAMzR9mXAoaD/7jYkTGwRb8pmk5sjOUyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899116; c=relaxed/simple;
	bh=kqyOS/cxQLEzj0Jd7w8iFYcejjnV+kc+g34wzVnBov4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nOZYvaPKEcNjeLgNfRTHbZHP432GIUL+lcZR89x5znPP+cp165nSk3L0bmWa4YaGec9W4wzhpvjXcc/9JP9+uONZR6+zlXW4gniF2wXv6d7WBijMOgyyhlHnOv7top4FmYnSzJwpfMyMeZO0TUrCHNuZYL3kfXUscBNExRHTZBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcIOlxCV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcIOlxCV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so51915555e9.2
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 03:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742899112; x=1743503912; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mk1GxskItl6b7+yK1DihKUFHW4+BkheTig6qLp4iFM=;
        b=OcIOlxCVK4dVDvERozY6kmPmM9wtD+if2bx72cuMhqa9keQ/iXeqSOVQ7/Mc1YWJZQ
         lcYW6UEs7M7UcARK7HD69YZk69jOiapIRBNoNEU6C4ItFJfH3kuDwUJBI19wGI7p7mXM
         xY+ka6VB8vwChJBqf41eWJov6WDpSjHoOJT7WqmxUu6clnPkTYX8ZmeuXR6eaLAWbUvH
         0SkVdbF5ChSLaFjuZeYcTstpvbqCVhxNXaF3NT4YqM47sgWqJ0lYsKkSqT0CZ1vaiCfZ
         Ywmk9aY0Hj3MXmlmIsFKSMvj/sNQAUtqC/kX6lcMTXEbkxa8mQcPMB5dPJALxTpuN2Bz
         IuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742899112; x=1743503912;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mk1GxskItl6b7+yK1DihKUFHW4+BkheTig6qLp4iFM=;
        b=bpI5xX86mCfg+NjUYEw6wbvq3AwcBV5j3AouRoywN5VsBCdnaujkwLEwN00n1cQ+iJ
         7VqQqgH2+8bxFfAAUhMzYh/gV0qaAGB3/B92sUUc4nbSYCmSrtrHa+6USgUIjVodfwmJ
         aqVOqK8/k8sMCkzAPwk4Eodn4+9AchuSH2VuvOHIi2kldimIkEYqRjBsC22wwXNnE73L
         Vq/XPOU+ce+7Tw7SIIGxCAYx58NhwXNolmq1Hi8aUoNeox+WPO7a8oc7E1LLbmn/lqLc
         JaM+60s7RHMFtxtY5I3r1bf8MXxH8g1kFuaQu/jiX2G7YG2qYB9kn/rCF9jRP8JDoKKC
         QSSA==
X-Gm-Message-State: AOJu0Yx+B7MLXRRePgQuNKvEvKCaO1l3Q8x88bORvmJ8+i6ssO5XHJOe
	NyCU5MxpvkN1479wXKSOj5q7ckZszahRW+zCthFVDjJmQySU1LVFRhIjQw==
X-Gm-Gg: ASbGncusQbfuQHplS0Q/bGff1cyTMOhAU+WFxlHpvRIQrW2FrGjcFJ1LhmQN92cM/hc
	QxM0B4pq2ur7OLjh+CdVzClzO4LsZw0Sgdkt/XRKOZu14myGACvRjabEXIBK0T6bjH0jnMEWSHf
	PzcFhH3PSKdLxXu86sPfRhGyBeOQOSr936BRxq7ccaFbFZltcpmTHXgyZhduwQSOYLHdpqMLLTa
	X1TlEgnX+JtPglcWrLu8mKXx19vy/Bf3LOT9IMikGYhHMcMt1WQT7bLpuK+84UACfL7Nkr2rB95
	TcUG7EZK3wKS3gKxjGp4PbXz6N8K80G9Ib0QcTgPQAK0tg==
X-Google-Smtp-Source: AGHT+IGB70rVLrlHqzhWgS1dmNI51Dn00o94NbVk7RuFQxaCDeQI6ZDDlzZNhX2B3BBQ3UOToXZtjw==
X-Received: by 2002:a05:600c:3c82:b0:43d:45a:8fbb with SMTP id 5b1f17b1804b1-43d50a1d1ebmr135146985e9.22.1742899112102;
        Tue, 25 Mar 2025 03:38:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed4b8sm195533725e9.35.2025.03.25.03.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:38:31 -0700 (PDT)
Message-Id: <90aec0788d075e11ae81fe192a2ac6a3b73728e5.1742899110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1893.git.1742899110.gitgitgadget@gmail.com>
References: <pull.1893.git.1742899110.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 10:38:29 +0000
Subject: [PATCH 1/2] mingw: special-case administrators even more
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The check for dubious ownership has one particular quirk on Windows: if
running as an administrator, files owned by the Administrators _group_
are considered owned by the user.

The rationale for that is: When running in elevated mode, Git creates
files that aren't owned by the individual user but by the Administrators
group.

There is yet another quirk, though: The check I introduced to determine
whether the current user is an administrator uses the
`CheckTokenMembership()` function with the current process token. And
that check only succeeds when running in elevated mode!

Let's be a bit more lenient here and look harder whether the current
user is an administrator. We do this by looking for a so-called "linked
token". That token exists when administrators run in non-elevated mode,
and can be used to create a new process in elevated mode. And feeding
_that_ token to the `CheckTokenMembership()` function succeeds!

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index f524c54d06d..305a999f1fc 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2826,31 +2826,44 @@ static void setup_windows_environment(void)
 	}
 }
 
-static PSID get_current_user_sid(void)
+static void get_current_user_sid(PSID *sid, HANDLE *linked_token)
 {
 	HANDLE token;
 	DWORD len = 0;
-	PSID result = NULL;
+	TOKEN_ELEVATION_TYPE elevationType;
+	DWORD size;
+
+	*sid = NULL;
+	*linked_token = NULL;
 
 	if (!OpenProcessToken(GetCurrentProcess(), TOKEN_QUERY, &token))
-		return NULL;
+		return;
 
 	if (!GetTokenInformation(token, TokenUser, NULL, 0, &len)) {
 		TOKEN_USER *info = xmalloc((size_t)len);
 		if (GetTokenInformation(token, TokenUser, info, len, &len)) {
 			len = GetLengthSid(info->User.Sid);
-			result = xmalloc(len);
-			if (!CopySid(len, result, info->User.Sid)) {
+			*sid = xmalloc(len);
+			if (!CopySid(len, *sid, info->User.Sid)) {
 				error(_("failed to copy SID (%ld)"),
 				      GetLastError());
-				FREE_AND_NULL(result);
+				FREE_AND_NULL(*sid);
 			}
 		}
 		FREE_AND_NULL(info);
 	}
-	CloseHandle(token);
 
-	return result;
+	if (GetTokenInformation(token, TokenElevationType, &elevationType, sizeof(elevationType), &size) &&
+	    elevationType == TokenElevationTypeLimited) {
+		/*
+		 * The current process is run by a member of the Administrators
+		 * group, but is not running elevated.
+		 */
+		if (!GetTokenInformation(token, TokenLinkedToken, linked_token, sizeof(*linked_token), &size))
+			linked_token = NULL; /* there is no linked token */
+	}
+
+	CloseHandle(token);
 }
 
 static BOOL user_sid_to_user_name(PSID sid, LPSTR *str)
@@ -2931,18 +2944,22 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 	else if (sid && IsValidSid(sid)) {
 		/* Now, verify that the SID matches the current user's */
 		static PSID current_user_sid;
+		static HANDLE linked_token;
 		BOOL is_member;
 
 		if (!current_user_sid)
-			current_user_sid = get_current_user_sid();
+			get_current_user_sid(&current_user_sid, &linked_token);
 
 		if (current_user_sid &&
 		    IsValidSid(current_user_sid) &&
 		    EqualSid(sid, current_user_sid))
 			result = 1;
 		else if (IsWellKnownSid(sid, WinBuiltinAdministratorsSid) &&
-			 CheckTokenMembership(NULL, sid, &is_member) &&
-			 is_member)
+			 ((CheckTokenMembership(NULL, sid, &is_member) &&
+			   is_member) ||
+			  (linked_token &&
+			   CheckTokenMembership(linked_token, sid, &is_member) &&
+			   is_member)))
 			/*
 			 * If owned by the Administrators group, and the
 			 * current user is an administrator, we consider that
-- 
gitgitgadget

