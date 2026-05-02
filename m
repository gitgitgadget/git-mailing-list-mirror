Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC8E2E7185
	for <git@vger.kernel.org>; Sat,  2 May 2026 05:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777699730; cv=none; b=Ha2C03rwnrsdag/51EOIbGuJc91bgIjx+2orgOdgf9xtwoqu50FiCcHGzUB4FllvP1hBPSaIWcBjA6VdOvHLUWdCYkwdNp2d1mKPqWATMGRyR4GlZO3q7qYBbty0vEn1AxG2s+6RVdQoDsOxhwi/rd0VhJHJsOb+SeUOGDw6laA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777699730; c=relaxed/simple;
	bh=GMfBZIWWX/MjNnBlsCQqUlvoiwRrrzERkWYkXzRMcJc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=S+7GZ9OOwaqnrqQkWWlL1wL2njrOGOs1GIpSav36AK+tZ7MYqA1FqEIMjI6BUeeGo3NI1fmPb8Zux12sLLkykrYcug4FwhRELHQP7ZwGP500trArmeLjikY+KU17J+lI6SxqueiCbSFegQEaTgawiPyXibt65/aEUZyJTtXJc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ow5ySyk8; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow5ySyk8"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8b7105dfb35so807656d6.3
        for <git@vger.kernel.org>; Fri, 01 May 2026 22:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777699728; x=1778304528; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A7hhoGW+CS4cGk3xniP0Vw7I1DTwDRECXOTZSuA8iQ=;
        b=Ow5ySyk8XrLrCe/1BUjT2WLwWcM2XS4jEMUP9RQXw3LzZfNSxmKw6C09YKTj063zlh
         v76hK7T267cFor9iAjS2x62OJYv40tvSQTo5R+p9EO7EdfURAYbuH8jRkuYQzBse/iE9
         ZYMDkrouEmYF8Tnbho2FppRLJJG8vGI+UrnHkwQuiCSDeEr5VDssTLmX8+1duIgiCHYo
         c5lkcAd6iIvfdZ8vKRhcKQ5+I9pTldneFrs8Di9xHwMvviqD19dqoxNOeMadE18iI6/i
         ZLtaNupC6EamvUP15SdQBKgTDNJkYGEVJn0lHstAeItIrC0eJGaLX2o6V/eLr7LQ1FZG
         7L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777699728; x=1778304528;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3A7hhoGW+CS4cGk3xniP0Vw7I1DTwDRECXOTZSuA8iQ=;
        b=ZFvuSdfxIjNgoVNlPm+m/d4b748rkHb2p8EROVzbiQqIVERS2KueL6w9gJwkm5RrEU
         nGqortEfkCYm839e0r91dZqHl3QbfU/ecusfV6g0TkV+MhisXzo6kh6cPWZ49YC4iLlh
         ZeypLEWM9Z+9+pLjFpwHZHfkaiQNRpEN/M64oCNYEciFgXy31K19MRKbWr8wYeWmXcDM
         NSmnk5che+QvERHhMZUQLT31W8JXWH/NVNhB9wYPbkv5KLc0yKv510mDdi9V2AFn5clL
         fl/FmVnbVeFGbyhcBnwk+8mT4h6Vy/SqjNYJGTwJk6A7dvs5CtribNwm8oqf9QFVeWr3
         AMQg==
X-Gm-Message-State: AOJu0YyH5eEfTz1G8alD2IEqPOp/dnOQLcIF/WUHkVGBmmrvIqupid+W
	b1R0dAprd6OiUl47R4Dd0ookB9VhGVfN3XUorThyytEcjB8L6LEgKRw52fkGoA==
X-Gm-Gg: AeBDieveUJZqvVuCKhgITY0YsbnkCT6kK6ZLcPNRYGav7NnAQDzLqWsJT4+Ar2DNTmd
	K4zfcDn+AE1Cj/o9YX/HnUXQO51a5BBy0vQuzEk/2TiCWLYuXk1Kfz4KH4Pp9SO1MbaUwK8YNsm
	mN1qNZyyWwduN8qE/Ukwn0Zw5xaetymCHVbcwLMI8bBp6S2f8wUWmv9hqlGnbFHtG0qV/N6abq3
	4VdWHPXzLVt8UPRs6XsgXNCerN38HBuut3Apwrh9k/8qo9UEtoNVCnod/pd/g6A4sgJaIVx/C3K
	5XnBp1K3LCe0HQS5QWPyPyLzRCUclcZwDU2wMbaqkfvnGENwTOCJxzsphKFv5UmEyA6lLM/Qiyh
	A3RQOo1M8V/5NshceEqxH42Xp733h1eoRWNNqgoc8IQfm5JN8WaLHwbh8/4KGEpZV49SohPBTRT
	VHqMIY97VMS0EUJPhrZ0Qg/Fnqi8I4suKoJoW9eK2FIpMYcmyQeg==
X-Received: by 2002:a0c:f40c:0:b0:8b1:f2b7:cfb3 with SMTP id 6a1803df08f44-8b6667e3c20mr41551036d6.20.1777699727649;
        Fri, 01 May 2026 22:28:47 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.224.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c0e6d72sm53100376d6.26.2026.05.01.22.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 22:28:47 -0700 (PDT)
Message-Id: <e584fb03f3c23fda452b8e53d287f8f835becd48.1777699722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
References: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
	<pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 May 2026 05:28:37 +0000
Subject: [PATCH v3 3/8] url: move scheme detection to URL header/source
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
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
    Matheus Moreira <matheus@matheusmoreira.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

Move enum url_scheme and url_get_scheme()
from connect.c to url.h and url.c
so that other code can identify
a URL's scheme without depending
on connect.c.

No behavior change. url_get_scheme() still dies
on an unrecognized scheme name, with the same
translated message as before.

scheme_name() stays in connect.c
because it has no other callers.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 connect.c | 22 ----------------------
 url.c     | 16 ++++++++++++++++
 url.h     | 13 +++++++++++++
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/connect.c b/connect.c
index cb145de30e..1ac7acc6e8 100644
--- a/connect.c
+++ b/connect.c
@@ -700,13 +700,6 @@ int server_supports(const char *feature)
 	return !!server_feature_value(feature, NULL);
 }
 
-enum url_scheme {
-	URL_SCHEME_LOCAL = 1,
-	URL_SCHEME_FILE,
-	URL_SCHEME_SSH,
-	URL_SCHEME_GIT
-};
-
 static const char *url_scheme_name(enum url_scheme scheme)
 {
 	switch (scheme) {
@@ -722,21 +715,6 @@ static const char *url_scheme_name(enum url_scheme scheme)
 	}
 }
 
-static enum url_scheme url_get_scheme(const char *name)
-{
-	if (!strcmp(name, "ssh"))
-		return URL_SCHEME_SSH;
-	if (!strcmp(name, "git"))
-		return URL_SCHEME_GIT;
-	if (!strcmp(name, "git+ssh")) /* deprecated - do not use */
-		return URL_SCHEME_SSH;
-	if (!strcmp(name, "ssh+git")) /* deprecated - do not use */
-		return URL_SCHEME_SSH;
-	if (!strcmp(name, "file"))
-		return URL_SCHEME_FILE;
-	die(_("protocol '%s' is not supported"), name);
-}
-
 static char *host_end(char **hoststart, int removebrackets)
 {
 	char *host = *hoststart;
diff --git a/url.c b/url.c
index 057576042a..300acf98fe 100644
--- a/url.c
+++ b/url.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "gettext.h"
 #include "hex-ll.h"
 #include "strbuf.h"
 #include "url.h"
@@ -140,3 +141,18 @@ int url_is_local_not_ssh(const char *url)
 	return !colon || (slash && slash < colon) ||
 		(has_dos_drive_prefix(url) && is_valid_path(url));
 }
+
+enum url_scheme url_get_scheme(const char *name)
+{
+	if (!strcmp(name, "ssh"))
+		return URL_SCHEME_SSH;
+	if (!strcmp(name, "git"))
+		return URL_SCHEME_GIT;
+	if (!strcmp(name, "git+ssh")) /* deprecated - do not use */
+		return URL_SCHEME_SSH;
+	if (!strcmp(name, "ssh+git")) /* deprecated - do not use */
+		return URL_SCHEME_SSH;
+	if (!strcmp(name, "file"))
+		return URL_SCHEME_FILE;
+	die(_("protocol '%s' is not supported"), name);
+}
diff --git a/url.h b/url.h
index 39d621312f..24c8cd91d0 100644
--- a/url.h
+++ b/url.h
@@ -23,6 +23,19 @@ void str_end_url_with_slash(const char *url, char **dest);
 
 int url_is_local_not_ssh(const char *url);
 
+enum url_scheme {
+	URL_SCHEME_LOCAL = 1,
+	URL_SCHEME_FILE,
+	URL_SCHEME_SSH,
+	URL_SCHEME_GIT,
+};
+
+/*
+ * Identify the URL scheme by name. Dies if the name does not match
+ * any scheme that Git knows about.
+ */
+enum url_scheme url_get_scheme(const char *name);
+
 /*
  * The set of unreserved characters as per STD66 (RFC3986) is
  * '[A-Za-z0-9-._~]'. These characters are safe to appear in URI
-- 
gitgitgadget

