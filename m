Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525922EBB86
	for <git@vger.kernel.org>; Sat,  2 May 2026 05:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777699731; cv=none; b=pJiCy5jS+xxm+5L0OwqBBii7OfSIz5zLwHC12GH+6xCKd0dBDRd6TnQB53lShHcNM+Et+G29Ol5n02sYjax4igF2+qvPOzYauYz14nwCmL8KtH0fFcHN6rE95qxx/+bARoWy8EFWzgNNWfbM9QFMomTjLP5QdxC/1hhHeu9TkWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777699731; c=relaxed/simple;
	bh=M4RJ6jhK73iF4lBIzOOcMCmIbuNg1X+vUeKQ4E+5kX4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=INJ7noPObLgEpu/BriWdxV6bLUy6IBrbzOI0iM7vBIkUrcq7RiRP6vbetrjHoqu9ZjtwECBBjmCeUNKimFaLHH0U5UZpVGf/lXA3NPXysZ8PdFBcLNT8dqxhkOyLfXZvfHZ2z/L+VNTZ0sc6GO/zmMAAN9nKaFUyT5LxLDYJeQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kjq5+qdf; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kjq5+qdf"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso35691676d6.1
        for <git@vger.kernel.org>; Fri, 01 May 2026 22:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777699729; x=1778304529; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0N99xeMTsFfNBPOJZ+NQOEPKlNV2Qvh+SMY5pe0SwE=;
        b=Kjq5+qdf3fzTm3ZytiH2/QqWpbTVkLfkdfE3zByecqmDnnruZHeSg0o8EuFkS0uHuv
         Qs83wyjVsiOZA20PYOfaraB9RgIxLYtsmFuaOg+tbS8UmY5KY2vQ81Y1z/na+SE9awYw
         iuxJYzrh/1fiW0Vmdo0YMeXy7NbOh3gk3xIds/unHYtOPc0diN9Ek32RHRhCnsWHXpaV
         Gagz9HouE2UzrJh2oEwGsGK3GE26dIERk2xG3xEdrka/rxmtr2XGB9idb37CMSyK4/Iv
         XxXhkTbM7sDmKkAZHaZs6QULiHK81jSU9m3E/bw8ZFnMCNHimZdwzUnYjua8j0KARTqM
         uKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777699729; x=1778304529;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0N99xeMTsFfNBPOJZ+NQOEPKlNV2Qvh+SMY5pe0SwE=;
        b=BoXSZVD6gTPMEDG93u1PGh7r84q7Tcu19kkTYx1eq8FVZYknv4s46e3RQQTng5/BQ8
         ibY62OvJajBLgJHNQmItRud6i22+VZmOibhUDtmUHKguNpLXbPyBMTjPex9U9i06P+7G
         4CJRJykaXZDjuvM2MdVB+lU1fHHqtdoiqMwKau3rzvUEncq7RlmXR4QQofzpRVa47NTy
         ceMf1mn/r5BofttRE2vqtcR7Rz/JAlKxYIKTOU+VWslf7OszQpizZQJu2wbEAiNJRW9Y
         EUGVJZqWQZnwrk7KGgIJkpCKFF+GBQvigyxz57mzWaD5NgB2Y2J6NrKN0zBVHdIFV2ap
         UfwQ==
X-Gm-Message-State: AOJu0YwvL+oIVjFxUJQ51cEggkDMlajSFES8k6uZQPnttG03GJL9MTv2
	kdcZaZWG1yFFsnxeIaiHOyZL/82gpPYBWvgGuV6PlXsMBD5LZ0s60wEc1cIzcQ==
X-Gm-Gg: AeBDietX2vr53jbWxEEuWr3XhH90aY2r+WNF8lzCoTNgPSnUmHWo1PDnU5Hn3/CnW21
	udWeh12rF8nIhvUsMQmMp7OT+7muGxoG/fqRiW1Rc/Q7jOSdZXUe82L/LTx9yDLjz8XgH2UU/t2
	jwAckQ21+sSJNmfVF1B4pzh8K++VYnS2sqDFAgusqdpwmwYcH/GO39vsRF9MOe+Yz77k0Cvjo/8
	rtClZwvjO0maIw4at7/YDu2bnIiJwnUoYJ0/U6f98Z8b34e34PXR8s6hvPTnNmJpnkNw5DTxGVR
	AL5me8pAdluqI7zRAF3yBtfskUqolTARV1W5GDlQTJEe91jVjkAwMXNEf5IG5l5bIYBP7fUT305
	8wBeoGY0meKsamzoekr6HdBfskzjNCugP0Vxtcam++JKz/aXLrLT+npCPDZKjIIixHohlKnvJ9/
	ny3zXCNzapu1fQo8I4FxzzVj7jMvKqUCQj3Natumb7W4Ms+UHdzg==
X-Received: by 2002:a05:6214:3290:b0:8ae:660a:be75 with SMTP id 6a1803df08f44-8b3ffffe751mr134958856d6.9.1777699728854;
        Fri, 01 May 2026 22:28:48 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.224.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d450dcbsm46823146d6.45.2026.05.01.22.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 22:28:48 -0700 (PDT)
Message-Id: <7381704c3809deec3adf1442a920f47840e0f104.1777699722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
References: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
	<pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 May 2026 05:28:38 +0000
Subject: [PATCH v3 4/8] url: return URL_SCHEME_UNKNOWN instead of dying
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

Enumerate a URL_SCHEME_UNKNOWN result with value 0.
Have url_get_scheme() return it for unrecognized
schemes instead of calling die() itself.
Move the die() call to parse_connect_url()
where url_get_scheme() is used.

This lets url_get_scheme() be used from contexts
that need to identify a URL's scheme without aborting
the program. For example, a future plumbing command
that validates URLs.

No external behavior change. parse_connect_url() still dies
with the same translated message for unrecognized schemes.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 connect.c | 2 ++
 url.c     | 3 +--
 url.h     | 7 ++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/connect.c b/connect.c
index 1ac7acc6e8..73d7a6b8d0 100644
--- a/connect.c
+++ b/connect.c
@@ -1071,6 +1071,8 @@ static enum url_scheme parse_connect_url(const char *url_orig, char **ret_host,
 	if (host) {
 		*host = '\0';
 		scheme = url_get_scheme(url);
+		if (scheme == URL_SCHEME_UNKNOWN)
+			die(_("protocol '%s' is not supported"), url);
 		host += 3;
 	} else {
 		host = url;
diff --git a/url.c b/url.c
index 300acf98fe..a59818278f 100644
--- a/url.c
+++ b/url.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "gettext.h"
 #include "hex-ll.h"
 #include "strbuf.h"
 #include "url.h"
@@ -154,5 +153,5 @@ enum url_scheme url_get_scheme(const char *name)
 		return URL_SCHEME_SSH;
 	if (!strcmp(name, "file"))
 		return URL_SCHEME_FILE;
-	die(_("protocol '%s' is not supported"), name);
+	return URL_SCHEME_UNKNOWN;
 }
diff --git a/url.h b/url.h
index 24c8cd91d0..7289523605 100644
--- a/url.h
+++ b/url.h
@@ -24,15 +24,16 @@ void str_end_url_with_slash(const char *url, char **dest);
 int url_is_local_not_ssh(const char *url);
 
 enum url_scheme {
-	URL_SCHEME_LOCAL = 1,
+	URL_SCHEME_UNKNOWN = 0,
+	URL_SCHEME_LOCAL,
 	URL_SCHEME_FILE,
 	URL_SCHEME_SSH,
 	URL_SCHEME_GIT,
 };
 
 /*
- * Identify the URL scheme by name. Dies if the name does not match
- * any scheme that Git knows about.
+ * Identify the URL scheme by name. Returns URL_SCHEME_UNKNOWN
+ * if the name does not match any scheme that Git knows about.
  */
 enum url_scheme url_get_scheme(const char *name);
 
-- 
gitgitgadget

