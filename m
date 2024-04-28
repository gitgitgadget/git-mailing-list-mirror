Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A604B676
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343468; cv=none; b=n2UhOa8Uy6eD8lc0+8E+G0h0rp+OIG2x8sGa8GKOJKaI/LbSaBkGkCiI3tXnMSpKUVSiMUvPJttuFc26/MV/T234tdHQmJ5glvjwIannJ0d5MEWLwWy+ZEL6ypxCteVR7FzV5AOkbbZMQ9luWZIcVonPwXWfhIV24zlZHU8hT+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343468; c=relaxed/simple;
	bh=ZcZUn5zFaPW9YL/tD/2XoOuIlZG6UyMgqSh6qkEv8Z8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TTj4R7/gSW4GvrAoxDvoIiTyb3Ezk3XVWpIrlpeeDRfvuGVBMo69UgK8GKKdp2jkZQxyGM+BpWEyXyApFmZcEDK7UJxcFPIRvqYSA4e8hf44rJONIQRZyAgPRZxNLoCJM1NH4eD8fsNGBaXhnd3wX/xwMJP0+AKSCVjGOb3/vSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHFWITwH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHFWITwH"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41ba1ba55e8so17319145e9.1
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 15:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714343464; x=1714948264; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liInQRHJsrHlb1bwMwRyD6EgSrZWZ0aVkEQS5W47Hoo=;
        b=XHFWITwHnzcG3MrSp7Cc+NM7FwHWfjtMWAw62zPkDJ+bLhZCGrnAOujRTqz9Rlp66d
         MxneoMY7jGyQEkCbh5l2r3E1LnhEnfN6yT53qjfp42x+l7AYkJm8JM/9idOSDUeie4y4
         oGxPfTXdPrZuoycJUOLmQUEVyKHAiCh7rE8cR1zE0bUVVor2Eq2KOtk2M7aKU1fb4Kcd
         QY+0rRJGfq8gc1e6oftoZB3NlLu0PQwin811xK9rVw9t9PS2jca8zk4m8KJ15rDGSOBI
         Ss5ij3SoaWuE0EQ4pbqWY4ZWJT33zOW9vNMpDTgiBGsYqDYOJHBbzl7IhSYRYkJed/5L
         DOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343464; x=1714948264;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liInQRHJsrHlb1bwMwRyD6EgSrZWZ0aVkEQS5W47Hoo=;
        b=OjTuYxRJ6IXo7Qb7G96Za5LFBNUjxcqkyHgaa8cgzMsXK/EAiUYaodZA0HWCqePve4
         Mw/Z9taesBo3Ez6nlKwj7dybl62ynoghOz3fROUe40k6o2z8hj8KcK3T+rX2x7WSUhvf
         AodtEvps61mt+uiEAmJGXIXcKKKCUSTr481Lj4uH51pgEaRZDM13vvNOOdhTiYu7FqpH
         CZuXXG2Y9seT9Z5ai7bjmnZstMD1c58NMjnKojiO2C1ASKoI1pMSx8RDEpQWkF4k83N4
         C80kytbedLELkuSZA+R+L9WDImgXjfzXaAas69Gww8etkgGJILx/RbLCfaA/MEKof6Lr
         OAeA==
X-Gm-Message-State: AOJu0YwXzuMeJwRkyIOSItmofaaUIDS1f7g2DbRZ7rUu3mm1RcR3Lwno
	vHY8LbRjoBAiVanren2Bo4w2nQpqwRy1CFg1aRhFKExezHoVUciqxBAD3Q==
X-Google-Smtp-Source: AGHT+IEv4Ll7nHczZOQQawtSw3Gm9nk4mmwbBEEjzSmC65h95Y9+d6p3+aQmcNbK6/fB/mBCY2qxxA==
X-Received: by 2002:a05:600c:4f08:b0:418:5ed2:5aa6 with SMTP id l8-20020a05600c4f0800b004185ed25aa6mr6701492wmq.31.1714343464586;
        Sun, 28 Apr 2024 15:31:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8-20020a05600c45c800b0041be9cb540esm6027261wmo.18.2024.04.28.15.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:31:04 -0700 (PDT)
Message-Id: <13b81b8aa06cfd63a5fd9d1acbaf21a8b388ff47.1714343461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Apr 2024 22:30:50 +0000
Subject: [PATCH 02/13] urlmatch: define url_parse function
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
Cc: Matheus Moreira <matheus.a.m.moreira@gmail.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

Define general parsing function that supports all Git URLs
including scp style URLs such as hostname:~user/repo.
Has the same interface as the URL normalization function
and uses the same data structures, facilitating its use.
It's adapted from the algorithm used to process URLs in connect.c,
so it should support the same inputs.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 urlmatch.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 urlmatch.h |  1 +
 2 files changed, 91 insertions(+)

diff --git a/urlmatch.c b/urlmatch.c
index 1d0254abacb..5a442e31fa2 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -3,6 +3,7 @@
 #include "hex-ll.h"
 #include "strbuf.h"
 #include "urlmatch.h"
+#include "url.h"
 
 #define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
 #define URL_DIGIT "0123456789"
@@ -438,6 +439,95 @@ char *url_normalize(const char *url, struct url_info *out_info)
 	return url_normalize_1(url, out_info, 0);
 }
 
+enum protocol {
+	PROTO_UNKNOWN = 0,
+	PROTO_LOCAL,
+	PROTO_FILE,
+	PROTO_SSH,
+	PROTO_GIT,
+};
+
+static enum protocol url_get_protocol(const char *name, size_t n)
+{
+	if (!strncmp(name, "ssh", n))
+		return PROTO_SSH;
+	if (!strncmp(name, "git", n))
+		return PROTO_GIT;
+	if (!strncmp(name, "git+ssh", n)) /* deprecated - do not use */
+		return PROTO_SSH;
+	if (!strncmp(name, "ssh+git", n)) /* deprecated - do not use */
+		return PROTO_SSH;
+	if (!strncmp(name, "file", n))
+		return PROTO_FILE;
+	return PROTO_UNKNOWN;
+}
+
+char *url_parse(const char *url_orig, struct url_info *out_info)
+{
+	struct strbuf url;
+	char *host, *separator;
+	char *detached, *normalized;
+	enum protocol protocol = PROTO_LOCAL;
+	struct url_info local_info;
+	struct url_info *info = out_info? out_info : &local_info;
+	bool scp_syntax = false;
+
+	if (is_url(url_orig)) {
+		url_orig = url_decode(url_orig);
+	} else {
+		url_orig = xstrdup(url_orig);
+	}
+
+	strbuf_init(&url, strlen(url_orig) + sizeof("ssh://"));
+	strbuf_addstr(&url, url_orig);
+
+	host = strstr(url.buf, "://");
+	if (host) {
+		protocol = url_get_protocol(url.buf, host - url.buf);
+		host += 3;
+	} else {
+		if (!url_is_local_not_ssh(url.buf)) {
+			scp_syntax = true;
+			protocol = PROTO_SSH;
+			strbuf_insertstr(&url, 0, "ssh://");
+			host = url.buf + 6;
+		}
+	}
+
+	/* path starts after ':' in scp style SSH URLs */
+	if (scp_syntax) {
+		separator = strchr(host, ':');
+		if (separator) {
+			if (separator[1] == '/')
+				strbuf_remove(&url, separator - url.buf, 1);
+			else
+				*separator = '/';
+		}
+	}
+
+	detached = strbuf_detach(&url, NULL);
+	normalized = url_normalize(detached, info);
+	free(detached);
+
+	if (!normalized) {
+		return NULL;
+	}
+
+	/* point path to ~ for URL's like this:
+	 *
+	 *     ssh://host.xz/~user/repo
+	 *     git://host.xz/~user/repo
+	 *     host.xz:~user/repo
+	 *
+	 */
+	if (protocol == PROTO_GIT || protocol == PROTO_SSH) {
+		if (normalized[info->path_off + 1] == '~')
+			info->path_off++;
+	}
+
+	return normalized;
+}
+
 static size_t url_match_prefix(const char *url,
 			       const char *url_prefix,
 			       size_t url_prefix_len)
diff --git a/urlmatch.h b/urlmatch.h
index 5ba85cea139..6b3ce428582 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -35,6 +35,7 @@ struct url_info {
 };
 
 char *url_normalize(const char *, struct url_info *);
+char *url_parse(const char *, struct url_info *);
 
 struct urlmatch_item {
 	size_t hostmatch_len;
-- 
gitgitgadget

