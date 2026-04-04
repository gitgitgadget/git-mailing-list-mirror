Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6292459C9
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775291423; cv=pass; b=hkER5EoHkeHQq0x1FcxH8ee9TkCzf7ir0cbW8agtljgzRpg8eAskwfy2HlhQrIY94u+2GBpWRzq3AFbeuTr0Y8pqZcFr0LM2wmnA8jn/uHhzK9yAESd0VY8m/1gg8h27zvZjQgHT9l+KYMYtc4BHWniatAvS9/ByZs48wSmK1eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775291423; c=relaxed/simple;
	bh=0eVJZ5iYC48bxBmM4jgNwXh2SY8WsSOiDmdsP5R8aXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j35viciV8Ys5k6pEVJMh2qWwh75NaUvXqAfBuvsrWzXJq0oJBcZ32do/C4qxQcyXpI4MWVFYojD0kN1bBkonF10FFuLIug88ONUQ71MTTnZbvJXgrsgiu75AkEfqv1kUgH1UVyB+++5Y+vLRPlps4dYV//vYvCRHsaOgXWZVdoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=d/IPYTwC; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="d/IPYTwC"
ARC-Seal: i=1; a=rsa-sha256; t=1775291400; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b5qajbmyDtnEgMREHeR4q0oeVVutlAATJ2qoiRCCsQRtwNpWXfgATDHsgMlLqCjIL26VVavYAQroc7yv+Z5taWrH7IFvfZc0ulcq4mtRR15vFBqcKrs2YVomxOwVkAfTtV3t7J06h+K3AFMJglqfqDkXfqpjPSjSTEODal36oW0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775291400; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SsD4nN5M3iKXS8wP5Y8wP5vBkSvfMKi4+0wgiLvy2/w=; 
	b=FkN4Umd9shRsr9ZgmTA2QrbsNC0kiP+tJ9UCvY09wEQ0YDXiXOh2sWFgQFKHOsSX2m1mvj04JgePE0JvcuVIyyWsAHimMsen085cgq/U6scIqyIVEBrb6gK5yCqcZBZvI6TUGq8KLaKAG287OFlZTyV7RF+s8HFlhF/Q/tlFHxE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775291400;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SsD4nN5M3iKXS8wP5Y8wP5vBkSvfMKi4+0wgiLvy2/w=;
	b=d/IPYTwCEoCU6/dmtF1AA40LXzdQcAEPloj5Y8yHkgbt0xLEQIVD3yNT7mVO0jrE
	7Q4n4wnZDttqobE8yn+Lt3LOj1VL+xmgsnH2ynBsdkrTOKXG0s5wqC3ZA6+eXEwY9fG
	fzZAOsmAb1olM/6DeolCtsUEQEHqLxSGziB/IIYY=
Received: by mx.zohomail.com with SMTPS id 1775291397225614.9484829003817;
	Sat, 4 Apr 2026 01:29:57 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v6 01/12] repository: fix repo_init() memleak due to missing _clear()
Date: Sat,  4 Apr 2026 11:29:23 +0300
Message-ID: <20260404082934.173788-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260404082934.173788-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260404082934.173788-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

There is an old pre-existing memory leak in repo_init() due to failing
to call clear_repository_format() in the error case.

It went undetected because a specific bug is required to trigger it:
enable a v1 extension in a repository with format v0. Obviously this
can only happen in a development environment, so it does not trigger
in normal usage, however the memleak is real and needs fixing.

Fix it by also calling clear_repository_format() in the error case.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 repository.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/repository.c b/repository.c
index 9e5537f539..192d6dc9c4 100644
--- a/repository.c
+++ b/repository.c
@@ -323,6 +323,7 @@ int repo_init(struct repository *repo,
 	return 0;
 
 error:
+	clear_repository_format(&format);
 	repo_clear(repo);
 	return -1;
 }
-- 
2.52.0.732.gb351b5166d.dirty

