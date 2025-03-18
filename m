Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10624155753
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 22:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336506; cv=none; b=tKIPAJfNvQjO9wX4kPOxreAKT1eRQxdGLEQgVuruNDrpF87k+yX6ysfud8kqrrVy62Cii7t3kYW71Q9zDyWm1o2A3eYzQfrcletW2lJV8KA47RId6NQdp8BJe3TR7bYIXTkrPwSz3J5ELhN/VXycvLYjk7JOCSdiqR8vNg82nyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336506; c=relaxed/simple;
	bh=29u+Iv4Z7pFxYvt9JwJPx39IusKec5crMboChv5mBQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K45Y10DXDZlKf3Xxza5k1leWU73Vo6nBgTKf7Qg1f3Z05qAroZNB9Tq5v6KXCC9y+Dd8oUNcGg1p4HOzi5Ypab7WCSoxTld/FWAbmCd1Lve/YapKgD3b1WFGlU7rQQCYciObV++l6Wmfu/EFkVGl9H3XYF7J7W7R+tn2b5DDDXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=a80ehm26; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="a80ehm26"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476ae781d21so60077521cf.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742336503; x=1742941303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/FXNVAMaoJsLH04y6DmqLHS3Gf88mohQWCg4yIc3AM=;
        b=a80ehm26RfyC2jsJhYrHO9rjYphExZWAVomaCnLNo3bMXLbNVbCDFj+CxF77PHtsT5
         uTC+mJJHtV/TnrhBqNnR2dmcXrBGstIaj06t1fx1z5r7BeU6/rsl9FIkcUAHOm5F037U
         OwuQfE1sgyC/67fl331kBxH1alU2Pg2DZjyb4gINamDQTWOeWKMHTYKeYx1pbMSysMni
         IY5tDy+iwDlSz8RXdn8q/fXaI1mHVUiivvvj2X1xPe+0gy4lZEi6sF2P0S+VYTFDaZLU
         octBWGL/Ze3xvk5QYXt0TgfcTyEwvUrkzLcEy+qdq+5SZuoim6WfpX1HfpUcqsVZnOr1
         NspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742336503; x=1742941303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/FXNVAMaoJsLH04y6DmqLHS3Gf88mohQWCg4yIc3AM=;
        b=YJ5wRgPeilXvRd6TJRJ7FbLNM7Nl2XnWH32e5iznO3kuvuK1a0FKAjAeCLVYaAMXrs
         Vxb7pHUcxlly+izHD0u6ovoOYDF4a/XQZzij9TGzjjE3Pv9KKVa1kGteL5JnpiVdeVC4
         6qUNMSC8LbkMkuoanBgSRgJQ/5t06MzVg3LGEdwQIMfxxX1bIStspiWrOiW1iAha9gL7
         PEz9J0Yx0PvLZmRU7bPujWk7TDNRqyMlj76tcVkiLVZld8GIYBadHqp/JvisA9DbQxOm
         GSEs5DUKvlLO46Zm6KrzDNZ7xAi5RE/B5J7B5S5Ayi4J2KGQD/TNDztYxvU5k+Ca7Vhl
         JIdw==
X-Gm-Message-State: AOJu0Yy/8OE4YPGi93PxqCwVJaCQckXVZ7UP0sNrhlKuLEQCtu47X908
	mBhp+4IzRuU+QNzxR7ASHF+d1OZPzliUn/rp01Yc+Yl+oMoJGALH/QnLqhazAshb08I5ITY/tfG
	j5Ys=
X-Gm-Gg: ASbGncv6G8LbRjMaTMX1CqdbiVpOrdWNPqH5ZclhG7MqoqIJEifHwJIQTJCIZllEYcx
	wYiEzG2GGXJ/CjomMFTtb1VfSstITM8tZReYLavBuuEoN9+xKqyr2Urz3uvtijcqEHDWVGIypQ4
	S2kMy87QPDfOTiv5KVBGkA1si1tiuDD/JnjR5l3s7CWarV4YExkTWBnqZG/ecRpO5h73yRQIbOw
	X3hDYhF/RIvLCndEkuFAIsv27p8W1+X5R8D0dDyP4cPc6XlGJMve6sJoOSO6Qh0A2WezVYfLLgy
	GaBnh8+YRcujSnSj/b3AYLzx5FZ/olHQlfjODkv/XbVo7oDhojp+CyXZrKnzYlhDhkFgwrSD11+
	2o+yt4D5ZiV8UhMoz
X-Google-Smtp-Source: AGHT+IHU7CKsuoy1429jAd8LMYg7zcnuGVgWMTXMjj2/23PZhTCFxPS1RO5EPqX+6TzTjisBKViZlg==
X-Received: by 2002:ac8:690f:0:b0:476:83d6:75ea with SMTP id d75a77b69052e-47708333f79mr10275191cf.15.1742336502708;
        Tue, 18 Mar 2025 15:21:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb63ab9fsm72734081cf.26.2025.03.18.15.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:21:42 -0700 (PDT)
Date: Tue, 18 Mar 2025 18:21:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/3] http.c: allow custom TCP keepalive behavior via config
Message-ID: <d84041580895a653648ee2370e21d7d2aa4fc4bb.1742336481.git.me@ttaylorr.com>
References: <cover.1742336481.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742336481.git.me@ttaylorr.com>

curl supports a few options to control when and how often it should
instruct the OS to send TCP keepalives, like KEEPIDLE, KEEPINTVL, and
KEEPCNT. Until this point, there hasn't been a way for users to change
what values are used for these options, forcing them to rely on curl's
defaults.

But we do unconditionally enable TCP keepalives without giving users an
ability to tweak any fine-grained parameters. Ordinarily this isn't a
problem, particularly for users that have fast-enough connections,
and/or are talking to a server that has generous or nonexistent
thresholds for killing a connection it hasn't heard from in a while.

But it can present a problem when one or both of those assumptions fail.
For instance, I can reliably get an in-progress clone to be killed from
the remote end when cloning from some forges while using trickle to
limit my clone's bandwidth.

For those users and others who wish to more finely tune the OS's
keepalive behavior, expose configuration and environment variables which
allow setting curl's KEEPIDLE, KEEPINTVL, and KEEPCNT options.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/http.adoc | 18 ++++++++++++++++++
 http.c                         | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 22a8803dea..67393282fa 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -296,6 +296,24 @@ http.lowSpeedLimit, http.lowSpeedTime::
 	Can be overridden by the `GIT_HTTP_LOW_SPEED_LIMIT` and
 	`GIT_HTTP_LOW_SPEED_TIME` environment variables.
 
+http.keepAliveIdle::
+	Specifies how long in seconds to wait on an idle connection
+	before sending TCP keepalive probes (if supported by the OS). If
+	unset, curl's default value is used. Can be overridden by the
+	`GIT_HTTP_KEEPALIVE_IDLE` environment variable.
+
+http.keepAliveInterval::
+	Specifies how long in seconds to wait between TCP keepalive
+	probes (if supported by the OS). If unset, curl's default value
+	is used. Can be overridden by the `GIT_HTTP_KEEPALIVE_INTERVAL`
+	environment variable.
+
+http.keepAliveCount::
+	Specifies how many TCP keepalive probes to send before giving up
+	and terminating the connection (if supported by the OS). If
+	unset, curl's default value is used. Can be overridden by the
+	`GIT_HTTP_KEEPALIVE_COUNT` environment variable.
+
 http.noEPSV::
 	A boolean which disables using of EPSV ftp command by curl.
 	This can be helpful with some "poor" ftp servers which don't
diff --git a/http.c b/http.c
index 526f9680f9..c13c7da530 100644
--- a/http.c
+++ b/http.c
@@ -104,6 +104,10 @@ static struct {
 };
 #endif
 
+static long curl_tcp_keepidle = -1;
+static long curl_tcp_keepintvl = -1;
+static long curl_tcp_keepcnt = -1;
+
 enum proactive_auth {
 	PROACTIVE_AUTH_NONE = 0,
 	PROACTIVE_AUTH_IF_CREDENTIALS,
@@ -557,6 +561,19 @@ static int http_options(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp("http.keepaliveidle", var)) {
+		curl_tcp_keepidle = (long)git_config_int(var, value, ctx->kvi);
+		return 0;
+	}
+	if (!strcmp("http.keepaliveinterval", var)) {
+		curl_tcp_keepintvl = (long)git_config_int(var, value, ctx->kvi);
+		return 0;
+	}
+	if (!strcmp("http.keepalivecount", var)) {
+		curl_tcp_keepcnt = (long)git_config_int(var, value, ctx->kvi);
+		return 0;
+	}
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, ctx, data);
 }
@@ -704,7 +721,6 @@ static int has_proxy_cert_password(void)
 	return 1;
 }
 
-
 /* Return 1 if redactions have been made, 0 otherwise. */
 static int redact_sensitive_header(struct strbuf *header, size_t offset)
 {
@@ -1240,6 +1256,15 @@ static CURL *get_curl_handle(void)
 
 	curl_easy_setopt(result, CURLOPT_TCP_KEEPALIVE, 1);
 
+	if (curl_tcp_keepidle > -1)
+		curl_easy_setopt(result, CURLOPT_TCP_KEEPIDLE,
+				 curl_tcp_keepidle);
+	if (curl_tcp_keepintvl > -1)
+		curl_easy_setopt(result, CURLOPT_TCP_KEEPINTVL,
+				 curl_tcp_keepintvl);
+	if (curl_tcp_keepcnt > -1)
+		curl_easy_setopt(result, CURLOPT_TCP_KEEPCNT, curl_tcp_keepcnt);
+
 	return result;
 }
 
@@ -1367,6 +1392,10 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 			ssl_cert_password_required = 1;
 	}
 
+	set_long_from_env(&curl_tcp_keepidle, "GIT_TCP_KEEPIDLE");
+	set_long_from_env(&curl_tcp_keepintvl, "GIT_TCP_KEEPINTVL");
+	set_long_from_env(&curl_tcp_keepcnt, "GIT_TCP_KEEPCNT");
+
 	curl_default = get_curl_handle();
 }
 
-- 
2.49.0.3.gbb7a4a684c.dirty
