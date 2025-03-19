Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C2621C165
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423034; cv=none; b=PMaIP8m1pY+oeHRjAW/g1EwTjPxLIT9VYYmKbBBYBJa1DZxaNM/y5YfZPN76xDoxXcuY5ueHCgHWf8f+Yvh63k+a29eHrwg62dalK20eBLI3RFZjLe5++5qe7p3+CFTo7jQ2Q62vjZHIxQn/wabBiiI1902G6uhMCDIWjF11K94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423034; c=relaxed/simple;
	bh=LAbGcmcy1CtfnPV0Ow4SWyx4hucnLo3BRv4IvhJqlig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEapy1LN7AOTlD2b++hYaqk5k5GgPNZC+2BilAnnNOX/29vN/d0oHl1RkL8JTdVPQM1tkDMJM7Qb3/Trx8XM92vWVfnCnCVXa+36SF01zLXIcnPembO3EstNkmm+qPlj5XD+Xy8vWTV9ijR6WbGaE3ZkUxBjDZmiOCQSA9T+fIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fcGOfZAJ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fcGOfZAJ"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8fc176825so1304276d6.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742423032; x=1743027832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ciOryr52jhuETvpmmgojQBHZoAfhFTrPvrlnenjhGE8=;
        b=fcGOfZAJOmn4urKGT9aeQ2tKRujY8392ZR/25zauRFFhpBOkfIGtw27A6Kt0/x8xU3
         LgvoAl/YnPladREiADM5A9jDTDll+Anehb6SGZHQDyNCzseHFZK4GFPy2/NGzyqU232D
         lg7NEP5ot+rwgjf939Ht87JhAEUXLzzrDjQAVRW8ix2b6lMS7Nzbp0DigLb5P9s3gnzB
         Z+QEvXTN+sGBRUKsm8jyq6Cxfzrs0BOokR291KhM6cnhh0ekaHfLcAKY3cg8uGdoCH/s
         NtX3wewXZIg1gw6aMKedxx4EK08g9vBj9BGfPN7pfYMUfkXmo0+T/RX4PLKX4JNrWeh7
         LKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742423032; x=1743027832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciOryr52jhuETvpmmgojQBHZoAfhFTrPvrlnenjhGE8=;
        b=Uu9LqfbkTMaLQq+L4OxQgMrh2v8ztvX32SvVNh2kOEj/GtZFWmIt1JyCiuOUKdrJhO
         BnOQdTdYkL+qISgJyf27OtAUcZoCCKZriS3bIdvhKyPjbfI76dkDOUd53p/mbzl6e2/j
         7T4qVDlUOExNjw+C5ZdpZ8K6lpRQ2r0R9NZKMkFiF/jG/arE3rbAfiee+ghHKLlc9/iQ
         JMG4+tw0Eby7wTxZANH5QbsHCcRzxd2EsULPOCvWAUEeWL9voplJIPj2TdxQnbGbyCt1
         CfXlTaC2QlAl0E4VBAsWkgbrAjVIAiQU2RImqjEXcpFgYAbfiRqXqsH61G14RR9MmUdi
         MuEw==
X-Gm-Message-State: AOJu0Yz0X4lWY5vZXzlRyvYT9UF2VtQSxGPbSucM066qffOxyodG+PTg
	ffvITdyF0kycXDQNC4jWy/fyDtZ5YxZikKTYr5ZtFpgYt3kwWV3iGGWUUSsR/s4HLwLnHKIsxM7
	Z4PQ=
X-Gm-Gg: ASbGncvwOBisWbm6YK715kYNpagxX69ZfqTd0BhBdq85wqSN3UHi27AbgNZ/GZNP26m
	37XlU2kr6LA5qFfeAZhiYUpInfWMk7uxvJH/9q4JcicZBTa/6UxgeSaXvAmaNA5NFFHhOXwOhlv
	Pva6i3cffByfDbypjOkOehkwnJkvPBtGTQn/Pndis6fgzO2afgtsCI+HM1nwIZUKAMU3RtTcQrU
	bq/GzODyC6hVjh5APC4lA/OsOhSJvRHslhOiqgq/A4n1Gd7DIlLB1NNBlkJMzOhG4ROChe6WO/R
	gUIzAQ9a4XpyfIGb+BJxBaCpoOzMcbFtZsl1zqSyuv09jmMg56aAzGSHlpb2PdVSxT98NulJ1Qv
	zvnIpd27Tna9m2Jcd
X-Google-Smtp-Source: AGHT+IFIpBY+R/w4ejVORafE0G+KAyj4+BZZBy0KhIhQHHf0ix9+P1m79IuM/MMexIzhB0KCFnwg9A==
X-Received: by 2002:ad4:5bca:0:b0:6e8:feae:929c with SMTP id 6a1803df08f44-6eb2938c9fcmr67612276d6.21.1742423031829;
        Wed, 19 Mar 2025 15:23:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade24e7besm85170166d6.64.2025.03.19.15.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:23:51 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:23:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/4] http.c: introduce `set_long_from_env()` for
 convenience
Message-ID: <2e39a78e87edaf8f9842e510d05047dce647f4af.1742423021.git.me@ttaylorr.com>
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

In 7059cd99fc (http_init(): Fix config file parsing, 2009-03-09), http.c
gained a new "set_from_env()" function as a convenience function around
conditionally assigning an environment variable to some variable if and
only if the environment variable was set to begin with.

But prior to 7059cd99fc, there were two spots which need to first
strtol() whatever is set in the environment before assigning it to a
long pointer. Both instances stored the result of getenv() in a
temporary variable, and conditionally strtol() it depending on whether
or not getenv() returned NULL.

Replace those two instances with a new cousin of 'set_from_env()' called
'set_long_from_env()', which does what its name suggests. This allows us
to remove the temporary variables and clean up some minor code
duplication while also adding more robust error handling.

More importantly, however, it prepares us for a future commit which will
introduce more instances of assigning an environment variable to a long.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 http.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/http.c b/http.c
index 0cbcb079b2..17b676a1d5 100644
--- a/http.c
+++ b/http.c
@@ -1256,10 +1256,30 @@ static void set_from_env(char **var, const char *envname)
 	}
 }
 
+static void set_long_from_env(long *var, const char *envname)
+{
+	const char *val = getenv(envname);
+	if (val) {
+		long tmp;
+		char *endp;
+		int saved_errno = errno;
+
+		errno = 0;
+		tmp = strtol(val, &endp, 10);
+
+		if (errno)
+			warning_errno(_("failed to parse %s"), envname);
+		else if (*endp || endp == val)
+			warning(_("failed to parse %s"), envname);
+		else
+			*var = tmp;
+
+		errno = saved_errno;
+	}
+}
+
 void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
-	char *low_speed_limit;
-	char *low_speed_time;
 	char *normalized_url;
 	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
 
@@ -1338,12 +1358,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 
 	set_from_env(&user_agent, "GIT_HTTP_USER_AGENT");
 
-	low_speed_limit = getenv("GIT_HTTP_LOW_SPEED_LIMIT");
-	if (low_speed_limit)
-		curl_low_speed_limit = strtol(low_speed_limit, NULL, 10);
-	low_speed_time = getenv("GIT_HTTP_LOW_SPEED_TIME");
-	if (low_speed_time)
-		curl_low_speed_time = strtol(low_speed_time, NULL, 10);
+	set_long_from_env(&curl_low_speed_limit, "GIT_HTTP_LOW_SPEED_LIMIT");
+	set_long_from_env(&curl_low_speed_time, "GIT_HTTP_LOW_SPEED_TIME");
 
 	if (curl_ssl_verify == -1)
 		curl_ssl_verify = 1;
-- 
2.49.0.4.ge59cf92f8d

