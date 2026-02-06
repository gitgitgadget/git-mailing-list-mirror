Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D802FFF88
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770358877; cv=none; b=sooHqdCdncfeSySMW5O4OZz7T7EvGU2oQhDOGeO2UjlRGX93Z1JFF4SAge3sNm7Yovqq9ipts1griVPSJkCayjPesEOP0G6nnL/V9mmf1Pa+3cu6KkzyPNxLhiv+8IpA6e67DCc+UNHFHatARXZ2i3j3xCWtbNv5UU400ResMSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770358877; c=relaxed/simple;
	bh=iAC5IU2meIC4A0oV69yxbDatoAuQX+L7wvIDkU1Y2EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6Jm3d0gBcx0gXe+DjQ+xraWdOnQ4Qefm98xDEnIGAvarqfrm1gNhN64c2v70Kb0fHvplYEavWs5iJgUbfia/YwzmP9qVtegW7eju7HsBbdeeNBgIcQfDInT3RUTs0KN1lK1Yt51k/VokarQvoYA3A7uQ8X1u5Ve+89yOgVAL4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuGTZkfx; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuGTZkfx"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c6541e35fc0so1049679a12.3
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 22:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770358876; x=1770963676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SB2jGtP4MYhCEn+R04V7h6CddahzqMZ5ThSylJRqGoA=;
        b=KuGTZkfxIhcOOPHzxRH2D+UWea8UxNFgJG+ZLGJJoysnPWHQKQdaZmzwxlAtdxH1Qv
         zea2PccHa/60iE8yblLP0jXOF9wITyQl8XR0990r3uSZsSYHnB6k3JQwO2KiNns84gmw
         WeotKuKANGxBOZ5O/iooHyOmV7vYrxOvZbg1NU4CYT4722RrpwyMlS4SMwAf+smA0v9V
         ap+DdSmnX/dzd9PzpgtMrSJQg9sV4oZxgZJSB3i04kNW7nSDFxl3PoSF4kqU+fqZ874D
         NJZah4PdER9EeY0iNE0aOAKsbkJqVSJ/mWK6vzV6z1aB/SFdQf29UcQxUbUmZNmiZNVD
         dZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770358876; x=1770963676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SB2jGtP4MYhCEn+R04V7h6CddahzqMZ5ThSylJRqGoA=;
        b=RjUjJae4U55DfeGf4+FYBCtcUjWxAtpjwVQWzCHii5JbRJs41Uc2INLQxPk60s+gPe
         k1QTs4ftuqYW74YWAUNY1T+kqSrq2UYBsguZXKeC1jLK0GcNNOPu6brBvRpESRLoKSMs
         RyizM1VFkOi+6Jqy5VnNCg8XgA2afbgjgf78fAsO7Cu1Y+HuumHdF/OhxXgopP22zX78
         gvdK826oSw+bXKPhIpC9VLHEP/gSMJXF1NMk16jDuFXFdnMg0DH0vChYl4N0xpj1M+cg
         UZ0QQGCJ/kz4DoB9Z2vQTT29gydXn4xCbRRFgN6QEsnwcqGwNkrqnmptuLmBH4SkHuQM
         GXnQ==
X-Gm-Message-State: AOJu0YyAiEbMr94TRKU7YwmcCPTBLNLmcsXrZaSxnbYUwWAPmODU5xaT
	xlJkp6LuJMvH8zvickdB40B8BX0zDF8/NWMZJX02F8+RwlY8BXQCuc3T
X-Gm-Gg: AZuq6aK+0HQpZ/mRzb7bO28FwsrNGtuDkx3oGVDbfQ8OdP1aSByxZ6diL0pl2bt9etR
	JrLPvFlol/uvDR80Q5MKYp2Sj82rO3NuIGm/8wzkDR6crgP5WzqtRJoVmp89DkZb7Pb5eCA29eC
	kuU5NZ4yx/DIfDNKlQZqSuqAqxcG8k8nSrtE4ltaIsgxp/IiyRX2sJXq2P30RLjGJH1Vy0om+1z
	hnTKn4xeE1jJLmlSXTjvJDA6FcIDJDdkL1d6Eytp9+oKhrl2KdaPNoT4rPbMT8eZe5+zbYYbZ+U
	2SCn0Q3nByUxnqBzOxj84JOwUj8ocsmT/dj8bUPf1zNzTVBQptTE89WYbj5tEt9C+hbucQQcRkr
	3cOqBDV9BbE2oJzWHqxku1TqfR1CKi+m8k68K0dG9nvFav6PI5GOE808nMcLW4PwKwfQ2Ytzb/m
	+8dt2G/g43FL9QOTjI7hCNUZMe30k7h7Px0tUPXqL67fZGgD02Srwat5mM+FVk2+C3gjYiAWYCL
	t+Yo/ESB1QtNwDRkc1kZWRTxb4EPRKipBgbvJSCRHMjXqGRApe4Do4Sch71FcA1wMoUkKrxBw==
X-Received: by 2002:a05:6a21:1fc5:b0:359:c3:c2ec with SMTP id adf61e73a8af0-393ad0245f1mr2138560637.35.1770358876405;
        Thu, 05 Feb 2026 22:21:16 -0800 (PST)
Received: from localhost.localdomain ([14.139.195.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c4d8cfsm12021495ad.10.2026.02.05.22.21.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Feb 2026 22:21:15 -0800 (PST)
From: SoutrikDas <valusoutrik@gmail.com>
To: valusoutrik@gmail.com
Cc: git@vger.kernel.org,
	shreyanshpaliwalcmsmn@gmail.com
Subject: [GSOC PATCH v2] doc: fix repo_config documentation reference
Date: Fri,  6 Feb 2026 11:51:08 +0530
Message-ID: <20260206062108.74072-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260206060156.73753-1-valusoutrik@gmail.com>
References: <20260206060156.73753-1-valusoutrik@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In MyFirstContribution.adoc, the link to the repo_config() 
documentation is invalid because the related documentation was moved 
to a different file.

Replace the path for the repo_config() documentation from
'Documentation/technical/api-config.h' to 'config.h'.

Signed-off-by: SoutrikDas <valusoutrik@gmail.com>
---
Changes from v1 : 
Corrected Documentation Spelling
Added .h after api-config
Changed Commit message to suit git's style
---
 Documentation/MyFirstContribution.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index f186dfbc89..92de476a7f 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -351,7 +351,7 @@ function body:
 apply standard precedence rules. `repo_config_get_string_tmp()` will look up
 a specific key ("user.name") and give you the value. There are a number of
 single-key lookup functions like this one; you can see them all (and more info
-about how to use `repo_config()`) in `Documentation/technical/api-config.adoc`.
+about how to use `repo_config()`) in `config.h`.
 
 You should see that the name printed matches the one you see when you run:
 
-- 
2.50.1 (Apple Git-155)

