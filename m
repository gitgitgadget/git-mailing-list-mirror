Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832385;
	b=XiaZks5x6t/rG3OAB7V4RNxXRfNBWqOUpMLx9Cak1hlv0DdBL7Da4k4FgnC8/uGsPJI7
	 +mzENmbCkA41iO2qzuPXfBn7fpbwloRWExY9JTyp+agfjbMjW9rgwBVzHg+DTHAIGddUg
	 dL8SMxKrqobSAZvTZe/chXrA/yjyJZ4k28wLFuOW1x/UhfilpAhbNCJs6Kz0LkOx2WVQu
	 86bpYALI9x7Xs68Qs1DoB305dVHSXmQPf3FeZ+fcD1mqHaX1LfWAlLXE6IJcORA4F7mby
	 v1puXoTS3E1UhEIVWHW1lbiLAcpqLy5QKUpBOlFXHeGO79FEhFMNExklZy5jqL6QhOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mIejrvXzjorJKGOuWuJR+0heQZYkpk9R7JVHWixzbxY=;
	b=AsZ4Tefmd0XN1lEGr6sex/spLrwM3o1kZQiT+FYXlHNtBQXpB3hWG1MwGLwvq8oLev0E
	 1aPfXvTVLimt+KETn3kmnDs2lR9f+oD9HTxJz5OlPA04OnyAljYbhJrd/coF0M1ICy9D3
	 pUdyC35pMp5I2vJh1LeBFy9IdndhxMG1XAoWVFlCvu4KrP+IDCFOOzCJLzt8QK2dcEkug
	 9wRXvjsUxW7PjhXOa09x3xgXjFC4IDNpbr5CsTYDUUnwdVKqhaDzBklsaQP/py4Uza70y
	 8dAjk99xqaSDP1AgVEFEQyNIOqTME6iwF7tLCF4qXB3NLhhaZPMsYfaeKtsjcLfZnuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wR6Ya/16";
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A20606A334
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 22:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8A20606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wR6Ya/16
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso11293745e9.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 14:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793832383; x=1794437183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mIejrvXzjorJKGOuWuJR+0heQZYkpk9R7JVHWixzbxY=;
        b=wR6Ya/168355oOw8EYQB58IZVyQPmS8QJoAI6F0r8jRPc5fM5JlHtscWS98d7NK8Sp
         i7M/l9rzPOriCRMtYqGW6tfMIMqwJfP2Z1xc5QWcraWPYYho+ovoZNpCRA6m92OXwCcc
         T9ERN2uBxUEucXf12gmG/C8YHl5ZPjWHxLH8+0soegJNYagr9UfYpS/8dZdHVRL9w5k6
         Ugve8N9G0jQJVX3nscJ+7BsJEoKiAHLvPRBBlHMS2WFUP00QRXJAhIH0Ws2oHg7yyNmB
         h6TEvxTMCLasbfELPxBXCxazhn8K7phbY7nPIPudh3mF4ZAM6gUUyVXC4XtIxSJlgqQQ
         qaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793832383; x=1794437183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mIejrvXzjorJKGOuWuJR+0heQZYkpk9R7JVHWixzbxY=;
        b=s61JJ3/NX/rT//Hzxir0Gxs/tF+W5u9b+HAjAbMbRnuAJr4KEnPXgOULuYwgqvl3oO
         idG5XazTi39zEaZabaNCKjqncrsjHz5XXj+IeyYCG7ibnAuxJx/u8XpEEPgFfwXckcxm
         6FruI+699XhEnyFHlbST0g9whOQzxAfKFrhdVN3PPjvrE0mQmU1jZV6zpjWEo1b3cQ3p
         dStIQXTan/fbWKOIyYiIE9X/WRrxw6by+kZaQ3OBi1a48zhSw1wKJdQC6TBJbpJW/8cd
         xmkhAkTnjfkTzqmNu0yvaizT62OC3gaPeUjIpje0T2O4qDPKtvDAyv8aP/mw49vNZNr+
         aJbw==
X-Gm-Message-State: APuU4Z/VGKPYR4Pc3yc1l0bywcbamKtUoi2aZzbOg3ux2MNqx7rs3fZC
	i0RschXYGRhw38/nBuPv9h3RhPa3P6PEnACSsUE0pwaeSPQV5YFzKXNuiNVtaujQ3W7JRA==
X-Gm-Gg: AYBFou1LCZFQoUQfoddXW78cUll/rzSckczL3OjORz0qa2l87ZXoYKAhD4R0fGUdL3U
	V8TvepwXl6NVnlQX8MZ4kR1YN1L1cQ+iV/wl8b/5Ir+YAtkv0uDcPpMUik1i0TgBrq4M3lp6yBB
	YEDwYbqEMPwkyP5cQ33ymBjFWJmxPziGg4173RGYwYenRcaHoyMPqKwcOtGnmCi2hbBcRnHfzWz
	sVkoY7D0dybglxS2+JBqF8UIu4YQ63cloOtxt0rVHuhC8cUDPv34z9K9JReLsuDy+Y7GrfLplTG
	vIFPrscMK4lbsndFZlpcnkW41OctHN7mpAQMDNxepBnKPxjrH8LiXyMhM/XQersqMgO6U/OEcm+
	/B2vdFGRoXz8oPUKS/UdJE7aOXeKWwN4OS4ewGZPhlh4yRZxonHwYeUcexegUpKyA5BvPFuW7FH
	VlgU87A1ny0K7ZWMdUJuKsgMtESbH80nPrUCw7zLse/ocORzwl1VR/jnHaQEt7cvC+EI/05H9dj
	Ybob816rXcAY08of4GhvysgXG4xgPwnmarGW8Sdn/yaDNKHic3GdHuGgMSIYoHLIGdnpxO0tBxa
	PEsZ+PYjcJQHsBsjW9iDlvw1AzQHvcb9HXwfkvnKJVxVwztDQk4g
X-Received: by 2002:a05:600c:524d:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4ac18993ca7mr395185255e9.32.1793832383098;
        Wed, 04 Nov 2026 14:46:23 -0800 (PST)
Received: from GODS-GIFT.localdomain ([197.211.58.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece998absm6855457f8f.22.2026.11.04.14.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:46:22 -0800 (PST)
From: Cynthia Uche <herroyalpriestess@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	l.s.r@web.de,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com
Subject: [Outreachy PATCH] api-parse-options.adoc: restore a dropped word
Date: Wed,  4 Nov 2026 23:45:59 +0100
Message-ID: <20261104224559.4197-1-herroyalpriestess@gmail.com>
X-Mailer: git-send-email 2.56.GIT
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The description of PARSE_OPT_KEEP_UNKNOWN_OPT ends with "..., the
parser early.", which is not a sentence. The word "stopping" was lost
in 0d260f9a09 (parseopt: prevent KEEP_UNKNOWN and STOP_AT_NON_OPTION
from being used together, 2009-03-09), which rewrote the end of that
sentence.

Restore it, and rewrap the following line.

Signed-off-by: Cynthia Uche <herroyalpriestess@gmail.com>
---
 Documentation/technical/api-parse-options.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-parse-options.adoc b/Documentation/technical/api-parse-options.adoc
index 6dfea34220..14f0d2b572 100644
--- a/Documentation/technical/api-parse-options.adoc
+++ b/Documentation/technical/api-parse-options.adoc
@@ -127,8 +127,8 @@ Flags are the bitwise-or of:
 	`PARSE_OPT_STOP_AT_NON_OPTION` is set, the second argument in
 	`--unknown value` will be mistakenly interpreted as a
 	non-option, not as a value belonging to the unknown option,
-	the parser early.  That's why parse_options() errors out if
-	both options are set.
+	stopping the parser early.  That's why parse_options() errors
+	out if both options are set.
 	Note that non-option arguments are always kept, even without
 	this flag.
 
-- 
2.56.GIT

