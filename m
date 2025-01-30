Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE7819
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738243192; cv=none; b=lLfNfBjGAYtTQErmeRbHfUO6XV10DCN1+HfcuPWx69iucdg6dTcN15hTTr7cR+MKtc2pWPa+OFYfVuln7t7RmtrBbl1H8vL0sFKy6wMp02zO1WMOElACLoCVelYQGvT+vencX4GvSztN4z/msjm7x4Polc8V3R2YWeuVYiZaQrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738243192; c=relaxed/simple;
	bh=Mn679G6dLfd0vg/Um4gaNPC3OsvHC01cxFlmcWfPTDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sQrLqHTKK7gp6s0JQyo42CTRIowa+0af47hnhImGm+iiH6kcDzJc/P21syfM6TAqKpD5ptlEZnzT99553v0oQXIq/25WZ8FGTDZ0MeHiM3HkVxEjb1FfidPdDZ4H/AGLsC8ImTwL+oHEhYzlwvEHub0QuU1l2wtYuYdEoMbdN4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=emailcarter.com; spf=none smtp.mailfrom=carter.tools; dkim=pass (2048-bit key) header.d=carter-tools.20230601.gappssmtp.com header.i=@carter-tools.20230601.gappssmtp.com header.b=JuNbfTLH; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=emailcarter.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=carter.tools
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=carter-tools.20230601.gappssmtp.com header.i=@carter-tools.20230601.gappssmtp.com header.b="JuNbfTLH"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-724a5d04befso339302a34.1
        for <git@vger.kernel.org>; Thu, 30 Jan 2025 05:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=carter-tools.20230601.gappssmtp.com; s=20230601; t=1738243188; x=1738847988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qkkwONY7Jybs0pnVUGhQDiBHbifSpur+bogK8rnHjVI=;
        b=JuNbfTLHUKdZCH1PHpqSkRs9fMREk+OVpO2bgnlRtfarm2th67xqM/L/NHWf1Glimn
         07OwQHX1jInh2AvFjUsyK4uXtUBOlLST9hYRGFh7lbxAytL6rd47EyIGN98w6GOFK5v3
         SaGLIcbPcae4yX5wFZ+3fHD1Vb8JTTkyAYp9/LJR9fS3RZ3KA8ryuagRo7hG1FYZw4eC
         FNIvO8vdj8UxNC9ARI5eUS3Mg8MMnV+eBm7oDeqMbAJMSq8960coQPcwUnTc8GUwUUXj
         ToFh/5HY3lEfAPpG8XhXViVW/qSdiCEUbIGQgfWrF34rFzeTJMRUoyOywRqX/10cPspH
         syJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738243188; x=1738847988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkkwONY7Jybs0pnVUGhQDiBHbifSpur+bogK8rnHjVI=;
        b=NgpUqtyRwGrLwUFyhmX5scpwXRcRp7xbyDfFE23B36GnJELIMS+gCGDPkMntB/OtVa
         Jb1SrnnMlEOaGE1g5yL7vCGJJy6v9ubdtJduWs6thMeq/6rIJG+jlX6GssXuIFbvKIN7
         grGUFvvXdOun8gG+y/SDeQHxVunB1kEM4Bw0zfFpxM29sEefMoPYVMYr5tU8ljhotQXu
         xL0Hd/XRRVwnRzU+Io309F6sJNyKh4/QfiHyL4fFdtW1+y95r1r4R/x7rwcbxWWPBowS
         HXuz5zQtRcuARlRHYAn3a/DxQeSOwyI8L26rsgliPFlipTdl3cG3Gh8S17K0Z1jtnUgx
         lKZw==
X-Gm-Message-State: AOJu0YzC0cs0WgzCib1qRlCNLZGbwzZS8juaF7veqpY5ZgwJm8shWvyR
	PcRCYX5+rwdykpsGaZd0FVbBM7XzioOfckeaFK6fOhTGBCNXL1EfZccx584YntcylP0d9ggau+8
	lS0MDOg==
X-Gm-Gg: ASbGnctdocY3l36OWKfLkP6Bxk2Y3PPxEZgNimh72tT1Crh95g3+LCoDMWaw7hrjyKq
	UFt9Y43BKLFlo8duckJmo+mJ/cazODnXdJWxqk6st/XXST/eCcdleOTMS6ifOCZXM6hcY/MBvL0
	xWQcIPa1S0XkwxhgArr8DTj7dq7gayNy4zH2pEvPdzp2LuA5hgsnPEmtP1vDdFPgCjLFCG1KUuU
	qilUiBfjtWekWloGIGhJ8O9nhaO81rb7aCT0glF/WcnMvSYQHv+3m/hFag79AwRRafpnx8ttcZ0
	J1sHIZOD5Zxra4dbTnlu3CbDs4TI9VCAXyA=
X-Google-Smtp-Source: AGHT+IFt8CZY4EiwSWQVf+jMXTEEaNXLwjwOYkB7r/r/suflaNTTyZGWpX1oQnGdUnmFgQWplnT7EQ==
X-Received: by 2002:a05:6830:d0d:b0:71d:b6a9:74c3 with SMTP id 46e09a7af769-726603cbbc8mr2354116a34.7.1738243188222;
        Thu, 30 Jan 2025 05:19:48 -0800 (PST)
Received: from [192.168.1.193] ([136.50.173.150])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726618ba0cdsm309753a34.51.2025.01.30.05.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 05:19:47 -0800 (PST)
Message-ID: <dd5d9b93-1585-4165-8f5d-d9737725071e@emailcarter.com>
Date: Thu, 30 Jan 2025 07:18:08 -0600
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] docs: indicate http.sslCertType and sslKeyType
To: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.1854.git.1737591366672.gitgitgadget@gmail.com>
Content-Language: en-US
From: Andrew Carter <andrew@emailcarter.com>
In-Reply-To: <pull.1854.git.1737591366672.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


0a01d41ee4 (http: add support for different sslcert and sslkey types.,
2023-03-20) added useful SSL config options, but did not document them.

Signed-off-by: Andrew Carter <andrew@emailcarter.com>
---
  Documentation/config/http.txt | 15 +++++++++++++++
  1 file changed, 15 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index a14371b5c9..38e874307b 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -216,6 +216,21 @@ http.sslBackend::
      This option is ignored if cURL lacks support for choosing the SSL
      backend at runtime.

+http.sslCertType::
+    Type of client certificate used when fetching or pushing over HTTPS.
+    "PEM", "DER" are supported when using openssl or gnutls backends. "P12"
+    is supported on "openssl", "schannel", "securetransport", and 
gnutls 8.11+.
+    See also libcurl `CURLOPT_SSLCERTTYPE`. Can be overridden by the
+    `GIT_SSL_CERT_TYPE` environment variable.
+
+http.sslKeyType::
+    Type of client private key used when fetching or pushing over 
HTTPS. (e.g.
+    "PEM", "DER", or "ENG"). Only applicable when using "openssl" 
backend. "DER"
+    is not supported with openssl. Particularly useful when set to 
"ENG" for
+    authenticating with PKCS#11 tokens, with a PKCS#11 URL in sslCert 
option.
+    See also libcurl `CURLOPT_SSLCERTTYPE`. Can be overridden by the
+    `GIT_SSL_KEY_TYPE` environment variable.
+
  http.schannelCheckRevoke::
      Used to enforce or disable certificate revocation checks in cURL
      when http.sslBackend is set to "schannel". Defaults to `true` if
-- 
2.39.5 (Apple Git-154)
