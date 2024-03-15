Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD676376EB
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508941; cv=none; b=WgHUP9tv99H9rW12IS/kGbPzXk6e7JIVwABFMRJenQOr6DM7S+59jSXQnyeFTBhC3qMSMyy87gifIuE5Vok8ACktEZ41tL3wdEmGUthqK53f6VV/ZTNYA6tolAad0+4YndE03wB+ROKEH4ljytfkZxgxzp9onXZrSiXcqX7i+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508941; c=relaxed/simple;
	bh=PoyRDylxbkqm75BvNRzPLsscaHmVc1gjPmFC2S3xKjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FLFdJ6kZ/IROelOxCd3qaFV/f7ggsaz2Uy+3IY7+lmj0wRoPvovrioS0PO7E01I+PN/LRwbTUEO5gd2iS59+vcxpxvXkpZ3WEJL13Ol7a0dokijTh0tRqVAZ1fidyquEYhOihNG6sOCzVrQBEpTXahQ1opi9QnWrjPufH4/O+hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FIBbC3uB; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FIBbC3uB"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710508935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRSa0NKeEtkIoLJ886cc8IDnyDtEN/EyT3ZAc9qahOM=;
	b=FIBbC3uBHuCMV5mCWbcAC3RYQvlRFkFdd3YjJxi7Itp7SCQVOuDdhlKkkNfIUxENT/gg3n
	6QLeZZHp0i6Uusaou6ufPMPe8w6SXUNl0Hv3xAli+23tRFDQ6kS0BW3PNyln/cyahCxB1Y
	E7So4FlLjeZxohp9yQ7BT0W68PiOrSewGe6GGr8nO8oOP8fwBGlWCmpjpAXfRmyilOf0rF
	e/NChuXQPoSz7mZkSJ0YRVNOFgXYeh51SQPXwj8ldWbBrmVq8t6+Emdzj/54VfcEE7jWPq
	W2P9HfP2bgycdflOZK2Ndy8OTHER55MchgwJXIri3lErrc33c5j4M2vSrrlR+w==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de
Subject: [PATCH 1/4] config: minor addition of whitespace
Date: Fri, 15 Mar 2024 14:22:07 +0100
Message-Id: <33ae9976fc089fe8f59aa857373319183bf558b3.1710508691.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710508691.git.dsimic@manjaro.org>
References: <cover.1710508691.git.dsimic@manjaro.org>
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
