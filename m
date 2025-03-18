Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A18DDC5
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 22:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336498; cv=none; b=CZ2m/6CjCW9o89hIn/rG/Nhw/vRg1yX3QO5arMBQxTfwtn+0OvQCXYFlTC5MqbUMrNOIpgiSgr7iV2tyaNsI2CJ7ruQ7YRuv6Ye5L+zeMobi7kqDA4QU4QF768OY4cvvDzDsNQwDeAKIelPJ4UdqAsuKJDdW+ZvfZlOTeoORzG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336498; c=relaxed/simple;
	bh=5ff5Nt1ckVh6iRobI4VJ2xhOz3K906aa9uw9pwZotqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SS/gh7kDXozrckecWUxglv8pFm/MukKF8XGr98xBoE1c5HmpimopOj2LoRtHELvuhmQHxxmNVEoLwnIuyPgll6c0I3mlxxPQIQ4VO2yY8h62fS2HKzDd3eOZZmCqXGdFVa1jm4aXjMvU6lJou9eafkwRz/U0Oo/Q9FZ7cM9cIxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KbfV7buN; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KbfV7buN"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5675dec99so662306785a.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742336495; x=1742941295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iprgw+C4GzuzwYhtByzAUBcb33yv8mRumtifgEJbMmE=;
        b=KbfV7buNUCuHo84Yr/Ctp9fRs8mGczlx3YE8lpFKd53NzYRHGegsWGcEX4NqX7ReTh
         MepSwb4kiOq/+7W/wyO9BsHSZCmNYx8j6RsjCzbRxeuftrvpbjPvHdK59DcA0TUR2MSt
         2vwOkT7pNrLjNOI3K5Nb8qSofYKrROQ4zMRXRkQ2XpCoB4RoLpe+hQNaiH9Y8ne+/NaP
         ViJjbmzzpy74EKx+3kbZI8qXEs1GV+QqbA/1JC4NN9/2LR/ff+yw4PY+AQiZE0HzEv0B
         g/52P5mc/L0lMp8Hpw1+NXc81H1+CKykPYxHlf0p5r5tRkXY5JJlRBZkD/Uxs50ukOiJ
         3t8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742336495; x=1742941295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iprgw+C4GzuzwYhtByzAUBcb33yv8mRumtifgEJbMmE=;
        b=ew6ilKETEaELPLzMpgk8DV4YoUqniSo+20r1ybzqFi3Jvv4t8CaloUfK+EJ17vxxDk
         JD+z+z5/SFq2vCYA4TYSsa2MkD5nK0qt8CtH8QMpdaoyeQK7ZF8mt/mWy2E3hTNvDHlq
         jN3mSV9Tcl3sSqzJ6kpZ35C3rYApFM2LlW4rTKB08w+Hnz7E8h2bDuv1T4rakHwE4Ceo
         nr8tBld7O9DfGSl3HSzwft1Rgdcv3qyRZ1mlH/hH7HM5UfTItaQMUpyvWM/lKv0q06Zi
         4jIz8zwtNzSPDPYiAMx0G02xXHxyA6iGnlLradQ8xW75rikCelg8u5fSojZLLaihm+Om
         0OIQ==
X-Gm-Message-State: AOJu0YwOTJfiT7mzIvEBfmvB1AtzrunV5gX8uCW0U5barhYmLqbXtCpr
	codq3D+kl+jIT+GNVolSR6R/nGOR5XDw/WVy8I6rB4OuoH7+ivSkYmmYAvonXC9xT7PKFxd6Fch
	gkZw=
X-Gm-Gg: ASbGncu4LsTO4yTKvlTe/pRFh0kGcMPdlVCSTJqc0K68oSv/8GBiMO3wEa3G3grDrER
	qNlaVo7OYL5TvgRBz/4ndipbHvmaRFMoufBVEZ8A8iT/A2OzAbhFiEIwYw+xc1Br5Z20cUG8wvu
	+4fz9q+d9mMKV6MsttNW1pv1SpePl814LEGFGmF/I0GQ1Cudr7EDRd0SWndvHcbcDB8K2iDRwDN
	V+BaesYYZ9RMW8MnnWWd61+JWLbDUQztzU0NLkDsQaPNzJp1k6Lx2L/lASSUU7Sap0pxmCxQLkx
	NT51V4YuYYlCliE4icsmsLvo4WwIAxhBUqR7Ubvr0pS2BqowxPrlu/vcKcFvC+zEH/Lr6TrHI4r
	EhIlAPq3Uj5jaOOOyky0tkHtPeR8=
X-Google-Smtp-Source: AGHT+IGN+LVfxt4yCMU+hVVmCOJza0y6sUHbQMFCunGDHA90IKqETHkFeMiLDUd9jmhquKYSZwpopQ==
X-Received: by 2002:a05:620a:29d4:b0:7c5:58b0:42c1 with SMTP id af79cd13be357-7c5a83d2f17mr51540985a.34.1742336495402;
        Tue, 18 Mar 2025 15:21:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c9a80dsm768658285a.52.2025.03.18.15.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:21:35 -0700 (PDT)
Date: Tue, 18 Mar 2025 18:21:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/3] http.c: introduce `set_long_from_env()` for convenience
Message-ID: <ba22a121fa699e490de00eba988552b6c10fe2fd.1742336481.git.me@ttaylorr.com>
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
duplication. More importantly, however, it prepares us for a future
commit which will introduce more instances of assigning an environment
variable to a long.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 http.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/http.c b/http.c
index 0c9a872809..be564fd520 100644
--- a/http.c
+++ b/http.c
@@ -1256,10 +1256,15 @@ static void set_from_env(char **var, const char *envname)
 	}
 }
 
+static void set_long_from_env(long *var, const char *envname)
+{
+	const char *val = getenv(envname);
+	if (val)
+		*var = strtol(val, NULL, 10);
+}
+
 void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
-	char *low_speed_limit;
-	char *low_speed_time;
 	char *normalized_url;
 	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
 
@@ -1338,12 +1343,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 
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
2.49.0.3.gbb7a4a684c.dirty

