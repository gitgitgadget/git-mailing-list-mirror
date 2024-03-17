Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AE65240
	for <git@vger.kernel.org>; Sun, 17 Mar 2024 03:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710647301; cv=none; b=J4xV+09wnys92vwWnJLXBGDmw1Wh8+c3XB4x8jHVXQCaBx6sVCxD8DpEG8gOVNlwPbMK6jkreFlGExG62Gau5CyFv17QVwgEQr7dUuCn6RY7aAZYOv9Gkwc+A9gMC+BGZ4il3CRUY4sgqS87Bu4cbEPtrxMQR/MEjPUSSHQMpgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710647301; c=relaxed/simple;
	bh=hWIqF1G6J+zxqjxWEIcRXuT+KhKLX5Z670DrgWCGogI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WQs/BF/VaQQ+bbjSoKb4eqGAM9ruoK2Gx5QnCMft+ip6q95fO7i84uDA5o1hULPZole6vXeYoXwbe6Hq/pRIoXkNgbP6yKvbDlxy+K9+Bd96yWJVAUYL5KdPnuFQjlDF0m3dEaWpWBM9pdTmjqSMwoDQdqtZN8fpKNpnAH1t0DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=VfHXHjME; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="VfHXHjME"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710647291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWCU9Z4P7lG568CX/f5aKgQOUMsOeocYsvo7VWTVXh8=;
	b=VfHXHjME6W8iZ4DKZJA5u22YB5tnoT69ciY8Zr4MUFZjcoeEO4YEu4GQiVwwqW5Xi/XmUm
	I0/QVm2J0NV+9u7KgfMumZTfUBoSNWuSuvvC1JsUr/iUbbK2na+Q2Bg0Dk4RAFt6HRbarY
	srpwCav+5ePaA4prRmb7WuM+4N5B4NQmOnSD6VkGeURLs0wFxqhNxSKmYMjUWgvX5+Bkz9
	3biX4bGjpZILGiyw9KkVLoE80ElQwKlFlX3+PcKIJ1QlIaPWNoKelyEUe6LQkDct/KCrZC
	KrG9CaxofsZvTkIHs0mSD56vA+K+juaN3Q5/2f2sz7mYrTz63pTmhhTrIN8JGA==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v2 1/5] config: minor addition of whitespace
Date: Sun, 17 Mar 2024 04:48:01 +0100
Message-Id: <8275861d8c59d7030669a488d0b4b0beac110af2.1710646998.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710646998.git.dsimic@manjaro.org>
References: <cover.1710646998.git.dsimic@manjaro.org>
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
trailing space characters.  Thus, clean up one spotted expression that for
some reason had a "bunched up" operator.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
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
