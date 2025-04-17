Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA95820C48D
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744924347; cv=none; b=E24E9vdDgUYos1X9qMrp5zaxLjDoTPXVWvRNjskFXAMNvhekeuaD9l6jztBhKCmc1ryZ//GcCmks0SSt+cpuOy59bjcvlPsJ0PG/J1CJKPQQd/R3yMNdeI25Z0iR/ZxJUcxASKQZDPGcnCbGIERVGSxLt6NWepOMkQXARL8FlI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744924347; c=relaxed/simple;
	bh=5hxTwHr/osfqYdor1U8XDWtSy10bRFtgjLpEJ9DnHBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAhTzKDNd+1kTtrxLC3KiT/ZFRoF49bCb5HBlcemq+wyDqe3NZuWdD2UL69i6d9n46GJqrTiTbCiYPOf+NVJTyZ0pGJgWUpOti7U4Zo1ef64iASkreTy1QINq0biMhq/oHRSYiyMdjf8a2Ii47Xciftgdite1x5Aa4OWQZwda7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=emSnXL1E; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="emSnXL1E"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c5e1b40f68so126424585a.1
        for <git@vger.kernel.org>; Thu, 17 Apr 2025 14:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744924344; x=1745529144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LTORUGvVIfHeQvTJ4ksMsk1qox99eoiYs6suXQ6MmQw=;
        b=emSnXL1EY9fgPWTzaSRjouBhUzLBu3YfCqTHJfbPQub5jC0FS7gJVTUEmdmeTZKbIG
         DzTm3Im4TPrlIVgRj/gb00Zasmrina/8UrQDEpjt8rWWx5QeCcD/fy+U/FZ2ma5Xd6HT
         qrt8IjkUcyVZL0D4/steEPcGpzxXWgITbuA3rYJnmDyDo/pE/bRnrriH9SuM/aDe9ol9
         tsS2FUpOQfNBOhqU9PpZS/2KAQocYF4xdOMphzlSw0k8bwdn1RJFiU6bAyvhJJ5O12l9
         8ksCNdbOVZ53dKyL6rBkrApb2355Tej0NBhXfXAkwQl7UyNa1EbXkZ3tu/5Aage26+E4
         ZNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744924344; x=1745529144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTORUGvVIfHeQvTJ4ksMsk1qox99eoiYs6suXQ6MmQw=;
        b=k+RmE0dBwFJpzTCbTt0Izw6VpCzud1i2cFJ7xbIujND+S4ZBsxYai//YEM7gHrdnvn
         w4ImCuHgRnk0N/4/855pVUmfBvC97wFsI95Vh+In4M0LLmzZ8s6O11wGdMBij/rNEjKX
         1q0DvMV2ynK7uxyc/0j9RB7Sy2OEqxSEDAtoqb/kqUFzlFx+SX8nxy9TdiwiA4zR4Rqw
         +c4jv9zQ7ZZMGZebbM60wzieKKwP2jTktNsWKoHOMhM5bVFaCihbxCm7NrWvBtWzPhMX
         7d7uAJMTDbTqiXvtLKPd0ayUDBPRoWqKyNjY2Iz8OYiEDrtyw4W/U+OMp0GUNj44Vub8
         ZXug==
X-Gm-Message-State: AOJu0Yx03TF4KZWyOp3r3Y0J9lgOpSrzTDhFOILh5LrgzgLEMNKqEKd4
	m2EX8E1pNVANXahhK3rHjiqr9sSGsrLP0xb7w3t6THnNMuCSfPh5v4UrU7siJIf/aE0m43n98P2
	MJuE=
X-Gm-Gg: ASbGncv/i4UthJ9XT6jhcBO6Ut1J+AdxlHXj9QK5IWaexCLB91b+1gbGR2PKk9Ih1js
	gJC5bWebrlDWrQ3if82pKJ3/xUtVbtsUTkpdYgu4jg3uZpSHVcSVhHZS1JyRfYkGQr5mYlsOUmq
	+MbBwLpivFV866N25pr1y089HWy24dZrzF3xd0tCS7QMqmjJjllVctg/aLX2qgmHOYtny0lH7/I
	PQKz+ZrdT52Gb30QXEmiHy9KTiE5ssQ1AY5bloSnxj/IiuD9uN3w+Rq60ZtmQH/jB9Qk9nB8zMr
	v0cIcUSVhZ0WzAVVDyUwHbOZ5+gpmGRpB8j5VPvDnpm/p3Ex7WDYmNYL0s7WxceCyeeuOPPfaR5
	VJBd8p1CX3X3B
X-Google-Smtp-Source: AGHT+IFEsYJCPhoRHw778ubM+JydMqagCodR+b0Mvtd81w+6p+fjobzITU2IhGhoyWpITUJCWhQgzA==
X-Received: by 2002:a05:620a:3953:b0:7c5:468b:5658 with SMTP id af79cd13be357-7c927fb904cmr63193685a.28.1744924344462;
        Thu, 17 Apr 2025 14:12:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c925b778b5sm32662785a.102.2025.04.17.14.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 14:12:24 -0700 (PDT)
Date: Thu, 17 Apr 2025 17:12:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] t/perf/lib-bitmap.sh: avoid test_perf during setup
Message-ID: <0906e14c0e55b52573c7e0b632c7c639850700ec.1744924321.git.me@ttaylorr.com>
References: <cover.1744924321.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744924321.git.me@ttaylorr.com>

In the test_pack_bitmap() helper function, we first repack the
repository under test for consistency and to eliminate any effects from
different distributions of objects among packs.

This step is performed with test_perf, so it is repeated
$GIT_PERF_REPEAT_COUNT number of times. But we do not care about timing
this portion of the setup phase, and repeating the process does not
change the outcome.

Use test_expect_success to avoid spending time repeating an idempotent
portion of the setup for performance tests that use test_pack_bitmap().

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/lib-bitmap.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/lib-bitmap.sh b/t/perf/lib-bitmap.sh
index 55a8feb1dc..fdf5f35f1b 100644
--- a/t/perf/lib-bitmap.sh
+++ b/t/perf/lib-bitmap.sh
@@ -69,7 +69,7 @@ test_partial_bitmap () {
 }
 
 test_pack_bitmap () {
-	test_perf "repack to disk" '
+	test_expect_success "repack to disk" '
 		git repack -ad
 	'
 
-- 
2.49.0.226.g0e6cae136d
