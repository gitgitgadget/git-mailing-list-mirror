Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDEA59B6A
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800670; cv=none; b=JWvHVKXogBPwdvYUXxlyOtNufQFi3EHSZUkcgP9fltLrWfLL6OW5HydchdbtWQZIpJty1VGfL1nQMpg/D1xSbY4coKXH7ZdLt57WR3VFDGW7QHb3J7Rpyi5vnGBXrbHIx+yXtAKrksgdZFdYEPljwSo1qes3frHNwaJSglRdzqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800670; c=relaxed/simple;
	bh=PvNSAsFlrDXjT2Mpge9lcdiC3B67yGjfuWQTpGpjj1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CggyOFJFL8xXHrMICnn2DEAccL0RyCtNpuqdEXIAU9d/t4jo/K7/JC9QEG0V60Ce6bJDPo1Pd88cvEIG4DOTK3DpRc0rSg+jNAY/ZnNBkOVYeljfM95EZMS20+OGTu5SUxAyS5mBp3ZrJWi7bdmYEm5js80mj/yaGMlyI+H1L2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rM7wYV4J; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rM7wYV4J"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710800666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DeMfYo8d3De8yyuA6WBdBoyY6ib8otqM9QvDDSs4q8k=;
	b=rM7wYV4JZVwjGWpiFKbBsGbRmIGE+j18URnkcEiW9CdO+mt073mHV1n/d/ooXz8UQTQYEI
	Qsepv0mK/CP83ABA26YpIYAGCZuweCNxe9/uJAENOBCpVHfPnfuyZa8oTWkvjlk4qQEckp
	WzoRwAu2JlLgYPHiQOBCzZoCNyQRUikXcKiS1mey8KEg9PhLMicIM8PN0j0VVMsM4CouH7
	zZPbc8ZKFu+b1SItCEsfQEu2sCHpCfwC8UbxfpJwVy4bPft7agorUe1aW2fMKIOKIhSCUz
	wMdYVuZJ/IbxktvDJsrZ2jJ7Xj0KvYNjw8h4yna70zQp0w1a96r8A4BhYL4tLQ==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v3 1/4] config: minor addition of whitespace
Date: Mon, 18 Mar 2024 23:24:19 +0100
Message-Id: <2161355e5c9a8ca0c8c0d3e5115a8843be1f4111.1710800549.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710800549.git.dsimic@manjaro.org>
References: <cover.1710800549.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

In general, binary operators should be enclosed in a pair of leading and
trailing space (SP) characters.  Thus, clean up one spotted expression that
for some reason had a "bunched up" operator.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v3:
        - Patch description was expanded a tiny bit, to make it more accurate
        - No changes to the source code were introduced
    
    Changes in v2:
        - No changes were introduced

 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 3cfeb3d8bd99..a86a20cdf5cb 100644
--- a/config.c
+++ b/config.c
@@ -869,7 +869,7 @@ static char *parse_value(struct config_source *cs)
 			continue;
 		}
 		if (c == '"') {
-			quote = 1-quote;
+			quote = 1 - quote;
 			continue;
 		}
 		strbuf_addch(&cs->value, c);
