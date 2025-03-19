Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E03D21CA07
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423040; cv=none; b=PeOykgOHYLlRbf0t+yuCbDAtc6oUxDH2IB1G4U+7JH0S57ActsOAI6nY5ts31F1wmit8YtNNpVJsDsYtjFMtI/bJu2LDoFNtOZXYi+1Uv9Yd5DSwY4IR/XCtdOSGSzh4oDJk7SHIi3TTaDvz9V26KAEr4JOxTykRCweF5q/Xhgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423040; c=relaxed/simple;
	bh=u8J/a6vtMrg6CW6vYKAQQwum9mFHago0MeMkTTKxE30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=absTV/Hw6hwSSKOqtNRS1dcvl4MPIQEWHrrcSjIwV5WrESc24FpOOBN9Rf6X5fBLqMslIY9rbV4Fezvd97vYR1sm1vgiJvBinleeMNkS1bRKu41LAURpq8Oi6rgs9wlqqq9in6RSedFC+khfS8hLTpbBU3rFbksLyXNpFuY9R9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=rGXOB6d+; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rGXOB6d+"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c3c4ff7d31so32747385a.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742423038; x=1743027838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vU99CBhtEvFLXiRnbmZv+/YrKYqi5pLiWFjZDprO8F8=;
        b=rGXOB6d+6XL6jZB1poyBCKQgUlzh6oJxT4gZ943/GptfgTOJ3vh35nerxDenbKtR4f
         ALqfQtxDiUFHl4wvysuOHCoDTw+mHhImAjQl/z959ESnUqsunH740uywKr5oyEgXfqXw
         rFefXWPSFDmRCDxjrEQepvnRt1sgOrljJOu3Wq8Db9xgp/4OCN2jOO46vQIDnkBaqQ15
         tXbwG/1mzU+JG3dCkefsNJwl7KX4fgFBwLPy3mGoNzgUydzQly4yxZdhY5b8jYSDlHQN
         UI83oy4kqhEZUIbr9Wi8f5E0lGH1tyuulO7o4S3WD//3DCrDuHbl/GaEoVkbYlqtB/Nq
         Xvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742423038; x=1743027838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vU99CBhtEvFLXiRnbmZv+/YrKYqi5pLiWFjZDprO8F8=;
        b=RmHPqBGBj6bfHho0xyOcP8WtNtwc3mwgVLiKr5BhLw05pXYHW0wrd6SmYasiVSr8AJ
         vYVGoAZ6vlTSuK4sLry7Ijxv3yzT48hRQU2ALDVuYCuVd4CHp/rOI2jfgDwxFlGBds5T
         gN29NYdGqkkvo9E74oGrPSvZ6LMYDZ+HD0j0vTfiUY5/4aEZsI7qhtMT0aMym+AmL5br
         +wL8eCbe1f4ugOpzfozy5yuGQ/m71gsjGk2BWn00YfFrtPFU4j8j+LZWULTgUOHzFMjr
         4RPPHq1xIjtKqC/msk9unPqlkpYoG5W0Yz8d1Ywl9kIWe74BXk52V4FP717LWvCinW94
         yzJQ==
X-Gm-Message-State: AOJu0YxjMwwyXyfPStC6GvTAL0tlrp+arymV8qw5mx3WpLzxajGVPgcA
	iSNXPdeTh/z1JCTlecSrNdddKH2kcVpZ7jdQd88YY5NplqITarOGvISU++4WHIHGFOvT2Z8m5s2
	d2qc=
X-Gm-Gg: ASbGncsXO5r+Ygk91Sm/czlY8HIuetmtyWO+2fFSXGkDd/4Owh6wfEe15HUc6k10223
	1cwtT4GmJaZXQH7XXYkBlhqwLXq9IKcNLL3GCixM1nM6vQayL1ufeBMUzv0Ak83Q8Uhz1yF0EBy
	QR27hgKX3K+aL4u6RwujY5p1hhg1FQXFc+AhMN8hnzk2z5PSEQAzHJplA4Q/f4Z5KTgSgNIiAK0
	+jlmtiXeQ9w4Tb05o+CmSnVjlhJ+hTTJv0PbD1Sn1YuyocBgI1J9V/NiGscm1wZzCgFTz/WhYki
	u4y0v1s8czE8XbReSWX5uRRfw+PE3dfCD7CvQhe4Bg67b2rYjUhGibiZVyAYk81cSzIptAUzoxr
	7/zS0UBTGYaFWSGugsi4ehBUoVJ0=
X-Google-Smtp-Source: AGHT+IFyu6Zi1xEgcxSDdM6N2MMG3laRpc8Bxz2ytei4DEbcMeNu4ecDtsm/mTDwcMWLfD9f2/n5Eg==
X-Received: by 2002:a05:620a:17a0:b0:7c3:c111:8c3d with SMTP id af79cd13be357-7c5b0d37d1bmr174041585a.49.1742423037819;
        Wed, 19 Mar 2025 15:23:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d70004sm913866385a.83.2025.03.19.15.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:23:57 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:23:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 4/4] http.c: allow custom TCP keepalive behavior via config
Message-ID: <3fe62181e563d011d4a6374ed7894cc4ea807316.1742423021.git.me@ttaylorr.com>
References: <cover.1742336481.git.me@ttaylorr.com>
 <cover.1742423021.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742423021.git.me@ttaylorr.com>

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

Note that while KEEPIDLE and KEEPINTVL were added in curl 7.25.0,
KEEPCNT was added much more recently in curl 8.9.0. Per f7c094060c
(git-curl-compat: remove check for curl 7.25.0, 2024-10-23), both
KEEPIDLE and KEEPINTVL are set unconditionally. But since we may be
compiled with a curl that isn't as new as 8.9.0, only set KEEPCNT when
we have CURLOPT_TCP_KEEPCNT to begin with.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/http.adoc | 18 ++++++++++++++++++
 git-curl-compat.h              |  7 +++++++
 http.c                         | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 1 deletion(-)

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
diff --git a/git-curl-compat.h b/git-curl-compat.h
index 703756ba85..aa8eed7ed2 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -45,4 +45,11 @@
 #define GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR 1
 #endif
 
+/**
+ * CURLOPT_TCP_KEEPCNT was added in 8.9.0, released in July, 2024.
+ */
+#if LIBCURL_VERSION_NUM >= 0x080900
+#define GIT_CURL_HAVE_CURLOPT_TCP_KEEPCNT
+#endif
+
 #endif
diff --git a/http.c b/http.c
index b4267bfdb0..d21e3a3bad 100644
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
+		curl_tcp_keepidle = git_config_int(var, value, ctx->kvi);
+		return 0;
+	}
+	if (!strcmp("http.keepaliveinterval", var)) {
+		curl_tcp_keepintvl = git_config_int(var, value, ctx->kvi);
+		return 0;
+	}
+	if (!strcmp("http.keepalivecount", var)) {
+		curl_tcp_keepcnt = git_config_int(var, value, ctx->kvi);
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
@@ -1240,6 +1256,17 @@ static CURL *get_curl_handle(void)
 
 	curl_easy_setopt(result, CURLOPT_TCP_KEEPALIVE, 1);
 
+	if (curl_tcp_keepidle > -1)
+		curl_easy_setopt(result, CURLOPT_TCP_KEEPIDLE,
+				 curl_tcp_keepidle);
+	if (curl_tcp_keepintvl > -1)
+		curl_easy_setopt(result, CURLOPT_TCP_KEEPINTVL,
+				 curl_tcp_keepintvl);
+#ifdef GIT_CURL_HAVE_CURLOPT_TCP_KEEPCNT
+	if (curl_tcp_keepcnt > -1)
+		curl_easy_setopt(result, CURLOPT_TCP_KEEPCNT, curl_tcp_keepcnt);
+#endif
+
 	return result;
 }
 
@@ -1382,6 +1409,10 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 			ssl_cert_password_required = 1;
 	}
 
+	set_long_from_env(&curl_tcp_keepidle, "GIT_TCP_KEEPIDLE");
+	set_long_from_env(&curl_tcp_keepintvl, "GIT_TCP_KEEPINTVL");
+	set_long_from_env(&curl_tcp_keepcnt, "GIT_TCP_KEEPCNT");
+
 	curl_default = get_curl_handle();
 }
 
-- 
2.49.0.4.ge59cf92f8d
