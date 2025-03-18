Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65F2DDC5
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336503; cv=none; b=oMcK14gDo48z7yHxYvwd28cekgjZuzFB/GC/uYcmDgN3gNQ5XeGGNwL3iZJno6caXNSCtJWbqDMjZnaiTqRiifXrsZD3HXqW9BQmFDODiRtVR/798GBTp+5XyvUpcIgT/e3Fa9FZVcJtg7CcEoQDM0WG0p5R645mhA/LiE/iOSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336503; c=relaxed/simple;
	bh=436YxO/SjWFXrPV+etN+VWcX4Tkv+zVYNuTi3wH/uns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guYGVhZAmIgCrd3FiiO3HkYCSLzFyRivl5ZrUPX2pHL6uTBrYdVNnh7pV4eDIY4jx0NOofdSVVXMN23QftezpXG///QovBGzgeboPxZnmUGix9JuCLmsrWwLDnJQt0P3jwUGVQdfVRZ1+tmbzji2Ye/KrDx3V1/qJgAjXWIq3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1qVd/lBW; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1qVd/lBW"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c546334bdeso474426185a.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742336499; x=1742941299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kawZVWbYE7P6oI0Z6HrNQHQ0cC1cCaloGq1Vk0TuvPo=;
        b=1qVd/lBWXpe6aN94npLOhX9Dc1NzP2eWBs6HWMaK9GJ6UknCb2r1RZFCSOSN75XCIR
         +dIwEvHQU04EV2S/1dPCC50AKcV/85NojMeNMYbKzLh94aLCdblLOztbl4yfwa3pFCFU
         ZI0eERcMUYyK0COgMvqjPnOULDHJcyxsh9JINR/R6RTmwWbowj+aLx8LbIZN5wSXRMCK
         d0Jgw/pifFfv1HHls/0eUjoiiSHUl2G9q7a8NfUpmucQRKN8nhyRm+LQ03EXNRF8t7Q9
         ZaHPJsiXIf0pd4f68CK6kQM1oal2YGJOEBe6zpyzwq5mysjpGhwp2pc/SQe0WY1nzuzI
         VPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742336499; x=1742941299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kawZVWbYE7P6oI0Z6HrNQHQ0cC1cCaloGq1Vk0TuvPo=;
        b=aJhEqewxl3PuPZbCyPd1HzAEvsfTUsCekhbsW20raFaFIfjMHuy2Xb1tU6Y667LTMi
         pNa0jmLL9s43r49AG/LyNV31QkZvaEKsSf14iRkIITpaEO4Gf96QC3EDozufnHY+2IxP
         G7e5I8lwMIfkxX6e7aRtn23eq+3UOTmoHttBYxu2TLWj+CUkLtEtyvv6iMSoEVq8fXUR
         DNl7TMVxpWOJ4Rcbwvhf0SpaEP8LzI3TNqrvMRS8LTuG2nJXsTVNAUJ4JSTgk9rTJZSj
         nxigZZlblO0w2nWMM6aVDXapymL6jMzFu6lT7l1iKb784PhK8LIk3UETH65KPKVjMBhv
         sX/A==
X-Gm-Message-State: AOJu0YyU53WAHrd2sr7SpIuihi2Q6bRJcUtkH0KiG/WcJ5qCgmOg/4IX
	eZgH2mK7mh4Up3XQfBNEBa5rwUcY+nEwmHY5d1qV5cVOzeyoimrDjISCsxw5e2ifcBv6bOY8wuJ
	dxgY=
X-Gm-Gg: ASbGncsun8yauln2ux4aYi+2gLs2na9yl98v30D7KrUOhkPTlXOJSs3LsfwdvfgsaVb
	FuQlrfLp7n33woR2mkjpIi76w2nvUCbaBYjQRTJMDDkjvb/XlV7n4c9zYKQHCiatXbmaQDH79C3
	QLkPRE6roCPAtEVhwmqFFY2KRy/73OYWsj09HzswUKxtN91oBKajo4AKIxqyuvTFYiMcLZ/bNVw
	xLw9MoHLe50pQfcxEZb7MzBNGkJZk7DsLa+yGlG0cH5oyCKyUQ+uVSEPAZOLsliALwuO1OHd8ve
	hpwVd/UzeH9/G2MSOceUR+C7pl3QESfbusEr4iiehrStcxXrohbJ8ZcHaIJr7wQKkYjmRPGjRjo
	0ATC7ux+9R26VxuCY
X-Google-Smtp-Source: AGHT+IHhWnmkMX7wHUxKtMX8i+xkx3avTCWdkWhTY0f1rQONrrM/kyYDFWiyIU1E3fnM10m8tkLbUg==
X-Received: by 2002:a05:6214:5284:b0:6e8:fde9:5d07 with SMTP id 6a1803df08f44-6eb293b0533mr8430596d6.26.1742336499490;
        Tue, 18 Mar 2025 15:21:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade234bb3sm72231046d6.45.2025.03.18.15.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:21:39 -0700 (PDT)
Date: Tue, 18 Mar 2025 18:21:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/3] http.c: inline `set_curl_keepalive()`
Message-ID: <a05269552fc2c17519b935c3b9c279c2e231c5c5.1742336481.git.me@ttaylorr.com>
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

At the end of `get_curl_handle()` we call `set_curl_keepalive()` to
enable TCP keepalive probes on our CURL handle. `set_curl_keepalive()`
dates back to 47ce115370 (http: use curl's tcp keepalive if available,
2013-10-14), which conditionally compiled different variants of
`set_curl_keepalive()` depending on what version of curl we were
compiled with[^1].

As of f7c094060c (git-curl-compat: remove check for curl 7.25.0,
2024-10-23), we no longer conditionally compile `set_curl_keepalive()`
since we no longer support pre-7.25.0 versions of curl. But the version
of that function that we kept is really just a thin wrapper around
setting the TCP_KEEPALIVE option, so there's no reason to keep it in its
own function.

Inline the definition of `set_curl_keepalive()` to within
`get_curl_handle()` so that the setup of our CURL handle is
self-contained.

[1]: The details are spelled out in 47ce115370, but the gist is curl
  7.25.0 and newer use CURLOPT_TCP_KEEPALIVE, older versions use
  CURLOPT_SOCKOPTFUNCTION with a custom callback, and older versions
  that predate even that option do nothing.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 http.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/http.c b/http.c
index be564fd520..526f9680f9 100644
--- a/http.c
+++ b/http.c
@@ -704,10 +704,6 @@ static int has_proxy_cert_password(void)
 	return 1;
 }
 
-static void set_curl_keepalive(CURL *c)
-{
-	curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
-}
 
 /* Return 1 if redactions have been made, 0 otherwise. */
 static int redact_sensitive_header(struct strbuf *header, size_t offset)
@@ -1242,7 +1238,7 @@ static CURL *get_curl_handle(void)
 	}
 	init_curl_proxy_auth(result);
 
-	set_curl_keepalive(result);
+	curl_easy_setopt(result, CURLOPT_TCP_KEEPALIVE, 1);
 
 	return result;
 }
-- 
2.49.0.3.gbb7a4a684c.dirty

