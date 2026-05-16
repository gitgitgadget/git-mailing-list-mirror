Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349126B755
	for <git@vger.kernel.org>; Sat, 16 May 2026 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893266; cv=none; b=Hpp5DhnW8AosG/iz09z2/0fXNUApJqcLGIlp+aLo4i+QjwLT+Ej6v9cQo7x1xcuCRMda49j1C4VVYOw/4peSYhAZFVFPzhS5GvicIWlwKvZNsmWCDwr2aBaSabhhUGbIMG7d59lVtHW9e/S03n7tSzUbqhHxS0tm1dX6WkLqX9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893266; c=relaxed/simple;
	bh=wysLnwVW7UXtKTLG+SC6kE8RZqpVNgv1XaAhHNiAIE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LmfKO5aReoncNY7WvIkQKpL2pRlbgjC6A+JW70hO2Y+GMmrte9SZ3dr1j94yY7pxw4P4n2bo4fCEzM+g6zC7kMW2U9dpfN+OszBWCz76hP3hTBT7TgdDZV8qxjwIq3kD54eP3A00PJbrYYDh9+W3OK+fP/t+SL3LW3TlYzkHRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIcAlarK; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIcAlarK"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65c7a459105so632070d50.0
        for <git@vger.kernel.org>; Fri, 15 May 2026 18:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778893264; x=1779498064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka0izAgNRhOhHD5Ec085I9IymLNy0ScOFNOlDLDJuuc=;
        b=BIcAlarKMp5XDkNRYa2xilJweFpTkFEz/65RHQ1Y75Ox8k4YYEzRyTaRqyhoaPSZAc
         UW2r8EBWYYpXNbjpIUxg/T1aRN+MpSBuFpzzA/gfXTSaHyPv0p8y98pY/C6Zb+xWeZGE
         ymkSRv7b97YtopI9q4phlt6sslX63SUXMtoosv5UizMohPnZnZltazidPGMS8YxcF6Qf
         mfE637Rp96Z4EYwIKXEydHEHTbRkl3YXwZTIPGoas2dMkKW+ijK8nfgSUtB7K7Cpry+x
         uJs5Dm5G0qFxrZ3n3eOZ/AnUwrZOX+JFT9gEm7HYVXROC8pz+mdb28r6UcAlTw08WrVN
         s5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778893264; x=1779498064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka0izAgNRhOhHD5Ec085I9IymLNy0ScOFNOlDLDJuuc=;
        b=g9E954eHwxjv9YfzOnAvqwMTl5xZ4XrrQAJ4vBfMpDpoNnVA0RzMz9G/4zbawiDDkL
         NJIb0FhJDev1RB7YuOQKubH1oiYeAJxir3o0JIsdPUeVZ6qLeaFCgcrxaPQvpg/4o/C1
         ESG6srhWkcxHg9CzH7YqNAx9/n+3EsvHcHEx2Sjd4H3wJNJoaVnLD3Pkjvw0fMKTl/jO
         RO7YbSxOYRnE8Pmq9PCEOJi6BCXdBElD5XCpJ0ICY57C+VIl+cUFEWdP5GpYN07tc4/u
         8pQhJSAKXM2VufASedFms0CbpZkfeIB66PvnGp3TT4mOUwXUYDMrtQ9OeeQlqpcamNq2
         UF7w==
X-Gm-Message-State: AOJu0YzlsxB5r9m6pdt9o9h1rJ5yHyHLsvWxokkfeqsQWogkeqsDQ8zg
	Uu8aoBJn3ie1PmF51kTMFZH9yWHbSXWULcb2HrKJCPM/Xe4cBLstbP1o+xGj52tN
X-Gm-Gg: Acq92OGD+ja7aZpNUkzm5VhAeCLMUsMV4D6q1HRAg0n/lJvDVdrszJVBexab+yDPOvQ
	bJi2idEkb+EAPjfTlnL79CHKyLZefsoVJ0jVLVhwCs7iKoHmQRpMu3Am2wfl7zHaU765OBZClMq
	+6n5xYqvRtnmdDZVp2WtbUGmC8gL2YPxY6Pt1mYFeOOriHGrGsQHwrw9L0bmxBkSQIJw0ywQClt
	M9YlYKlME0encmYFHBn/GeBoozXXQGnbGzOwRU/R9puzvzkRLawU7CGANSTbrSL71tMF4HMvutU
	04YTI1WyPGbJPtDThzO8vnNz4dcpM+NqXClaMF48qmfdS7UG2lcUcwe4mqla3vlPfHdfmnZkN6r
	y/i+eUyI3km+BDikrhi836/ESsf1I0L4L0Qudq+J8l7aL2X9CItv8o1gbkvmB9mbn8xTrKQmR1I
	DHMga62gpFf55iGZv409PRAzYqex8GTgHrjNJpN7MixqYZ+c7n6qFN0RAlxcEBb82n2LXfGZ7T
X-Received: by 2002:a05:690e:1208:b0:651:c41c:80ce with SMTP id 956f58d0204a3-65e0b07d241mr9182473d50.16.1778893263980;
        Fri, 15 May 2026 18:01:03 -0700 (PDT)
Received: from localhost.localdomain ([24.196.231.228])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d86bc02sm3296397d50.4.2026.05.15.18.01.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 May 2026 18:01:03 -0700 (PDT)
From: Clinton Phillips <clintdotphillips@gmail.com>
To: git@vger.kernel.org
Cc: Clinton Phillips <clintdotphillips@gmail.com>
Subject: [PATCH] pack-objects: fix typo in code comment
Date: Fri, 15 May 2026 21:01:03 -0400
Message-ID: <20260516010103.94552-1-clintdotphillips@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"accomodate" -> "accommodate". Pure typo fix, no behavior change.

Signed-off-by: Clinton Phillips <clintdotphillips@gmail.com>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dd2480a7..80606890 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1341,7 +1341,7 @@ static void write_pack_file(void)
 			 * length of them as buffer length.
 			 *
 			 * Note that we need to subtract one though to
-			 * accomodate for the sideband byte.
+			 * accommodate for the sideband byte.
 			 */
 			struct hashfd_options opts = {
 				.progress = progress_state,
-- 
2.49.0

