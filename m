Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D836EA90
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253158; cv=none; b=iaYfLKd7CHuGM8TKQIvfB2d8C9sWv49PjCaoAuXyGbM7c7vNUvhmmpgjVz88Pyd1+mCYQXJRseqnEGUum7VIFcKXYFZGTNHGzHhDG87yASJhsVWRdxYchjG+ag9MuAEraU7VFtqZpfbBbSIFF9uimHed4Uz/+/2H++hS85lA8r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253158; c=relaxed/simple;
	bh=KJ5sCQior/mHxwNs5jjAu6KdD6hcoT2t/DrH8V0cQb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fh4WlWR9a6lg9+npGiEAeXPpxqasm/R1/FKsNCJ3Ii8a5Vh/+tpkJKoMBf2HGwrij1o6W4IWSX3fS6DocBcRKDCfBIm+zBG7bzAxntp1yS55XE0MO1nyNx9Ph5LqiPkGiYatSg5Rxa9Ze0/VL5EV35sVNlUYNLdS8FPVEAczdKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNfPVvbO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNfPVvbO"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48538c5956bso35652715e9.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253155; x=1774857955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX7gHOyAGYjr+sZHrgqrrumEkHVrYnkxRDXOzZZbAmY=;
        b=JNfPVvbOfavMindx6FBZGw7/ko438BJrI9mLtR0a6MuPypV9HDVQDADOIvfDzD+slx
         btHaWefjioRaftQ6jX8sAFe8K0oTsAY4dm5U+RBreCRQEN8RlambIoajytm7YMXYifBJ
         YgRbehB8upw+lKH2VgndTlZXlwPFn7RrgdmVVVVmKiZKRA9y+wJP+HyxXJWJt9Omnt3V
         rsmFOU6NEyYQC2g3PYroH6CLgYvAaJ6eg0t9YUvpyvFEBxNxdNjhe8QGsItd5SHrzMKe
         Zd9AA3x6DMD5Bb+H1l3fjWRssVoTRo7/VwZkwHW66zH1q5o8gUm0GvaBYFVV734GRiIi
         Fy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253155; x=1774857955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RX7gHOyAGYjr+sZHrgqrrumEkHVrYnkxRDXOzZZbAmY=;
        b=E1XFaCS91COYE3v60qL/iwl5AnGIC3OKWHIjtMzHghYhdjDItWuHiPqncKutcI2CLF
         4SFkhKAGPVlMjjXAvQI43OKhpsd3EldiMTMLrgQ8siT4/imK4aYJ/rlqYBsaoO3FBV3d
         Kd7SaBxpUyU6S198WEu1TLDW+50A/vLJRIJhvFYEMnLk8Y3UKUhufUbzkfX8+Ewgym1v
         G3fhKkx8VJKySUbDVT2bLSjJHwAObJplDqKx5GDxiRasr2EILgC9RwBHVIk5Uhnbm4WU
         99pZBL/9yTi+sVeLytcw2tmlOOOEOlLMRRTsmRuNCZXgzeRpaldjo1c5PP6biaLwqoor
         FjjA==
X-Gm-Message-State: AOJu0YzkmR4uZMnKrMPx4njAk/Muw4Elm8CqRvQqOM4O10fNnMazl2KU
	Of6a8902hsaIPw51xAY65J5DBgNztNeznTUK4C9h/H1X1si4tSgycM7SE71uiA==
X-Gm-Gg: ATEYQzx+IZLQylIDYMXoJhldMVo0cmpwV22d9QPeWUCnzIZ4MCX0uVTlnJf/Q6FjZMF
	LtnOOip53ujZaHJtqoteb5vF4eC1uy2r8UcadLiRHGpCaHLMEDbIXahnMSu+gy9p7N+QjyXOBbb
	Pa4ptC9JkTZznufFno45am+1l/C3OSAzMJabAZ8bprOOrlGrKsQ+48nwad+cdp5hujAr+HGSKd9
	yAGsH/TsYqSgaJ80ggjU57ZLg3w0aruRF368MULo38Zn9ZcVzoN3u9SRdQYgzmDadP0Y6iE4hoN
	9h1ZzAAH6bTuczgW8E6UAYlGKYawm4ThA8ZgUbyRyzXFvt7bR8XZPQ5VNBxMtfrpEMRGhbZ9leV
	4N9Vjy3RKZAF7xHWOxeZjTzwamFaHV2vE8tezPpZDQZLiGZrj4A3wmjOSBn9oiYe47ivDLCxAMa
	M1sUDX9s09x/Q45IZxWMDTW+jjFriT+TTr0HzW6an6dzQD3F50xjCn+Aa55qdhruHAoJuoYjDkf
	LaJyVBxDh4RJ2sRrGV2pKW1WuWvdHQDix9ajGA=
X-Received: by 2002:a05:600c:332a:b0:486:fdef:c3e0 with SMTP id 5b1f17b1804b1-486fdefc432mr124104465e9.6.1774253154932;
        Mon, 23 Mar 2026 01:05:54 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:54 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 13/16] promisor-remote: introduce promisor.acceptFromServerUrl
Date: Mon, 23 Mar 2026 09:05:16 +0100
Message-ID: <20260323080520.887550-14-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.625.g20f70b52bb
In-Reply-To: <20260323080520.887550-1-christian.couder@gmail.com>
References: <20260323080520.887550-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "promisor-remote" protocol capability allows servers to advertise
promisor remotes, but doesn't allow these remotes to be automatically
configured on the client.

Let's introduce a new `promisor.acceptFromServerUrl` config variable
which contains a glob pattern, so that advertised remotes with a URL
matching that pattern will be automatically configured.

The glob pattern can optionally be prefixed with a remote name which
will be used as the name of the new local remote.

For now though, let's only introduce the functions to read and validate
the glob patterns and the optional prefixes.

Checking if the URLs of the advertised remotes match the glob patterns
and taking the appropriate action is left for a following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index c2f0eb7223..4cb18e1a6a 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "environment.h"
 #include "url.h"
+#include "urlmatch.h"
 #include "version.h"
 
 struct promisor_remote_config {
@@ -656,6 +657,76 @@ static bool has_control_char(const char *s)
 	return false;
 }
 
+struct allowed_url {
+	char *remote_name;
+	char *url_pattern;
+};
+
+static struct allowed_url *valid_accept_url(const char *url)
+{
+	char *dup, *p;
+	struct allowed_url *allowed;
+
+	if (!url)
+		return NULL;
+
+	dup = xstrdup(url);
+	p = strchr(dup, '=');
+	if (p) {
+		*p = '\0';
+		if (!valid_remote_name(dup)) {
+			warning(_("invalid remote name '%s' before '=' sign "
+				  "in '%s' from promisor.acceptFromServerUrl config"),
+				dup, url);
+			free(dup);
+			return NULL;
+		}
+		p++;
+	} else {
+		p = dup;
+	}
+
+	if (has_control_char(p) || !url_is_valid_pattern(p)) {
+		warning(_("invalid url pattern '%s' "
+			  "in '%s' from promisor.acceptFromServerUrl config"), p, url);
+		free(dup);
+		return NULL;
+	}
+
+	allowed = xmalloc(sizeof(*allowed));
+	allowed->remote_name = (p == dup) ? NULL : dup;
+	allowed->url_pattern = p;
+
+	return allowed;
+}
+
+static struct string_list *accept_from_server_url(struct repository *repo)
+{
+	static struct string_list accept_urls = STRING_LIST_INIT_DUP;
+	static int initialized;
+	const struct string_list *config_urls;
+
+	if (initialized)
+		return &accept_urls;
+
+	initialized = 1;
+
+	if (!repo_config_get_string_multi(repo, "promisor.acceptfromserverurl", &config_urls)) {
+		struct string_list_item *item;
+
+		for_each_string_list_item(item, config_urls) {
+			struct allowed_url *allowed = valid_accept_url(item->string);
+			if (allowed) {
+				struct string_list_item *new;
+				new = string_list_append(&accept_urls, item->string);
+				new->util = allowed;
+			}
+		}
+	}
+
+	return &accept_urls;
+}
+
 static int should_accept_remote(enum accept_promisor accept,
 				struct promisor_info *advertised,
 				struct string_list *config_info)
@@ -901,6 +972,8 @@ static void filter_promisor_remote(struct repository *repo,
 	struct string_list_item *item;
 	bool reload_config = false;
 	enum accept_promisor accept = accept_from_server(repo);
+	/* Pre-load and validate the acceptFromServerUrl config */
+	(void)accept_from_server_url(repo);
 
 	if (accept == ACCEPT_NONE)
 		return;
-- 
2.53.0.625.g20f70b52bb

