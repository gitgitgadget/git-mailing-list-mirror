Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3310730BBB9
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520429; cv=pass; b=fBVar/BqjG90soEl0Hdb/I26p0v4TY94BHjOABjLWm5tUNBMrGz9TmnzDyXvtnjWqJLTiy+DEdnPpPogjHPdM7PMFLcYjPCZBjeimCyqyvQletkSBATUQvpB0GnxcZElW69ON8w1lfdMpNLlFmupLdY25ZAweqhbFDWtUy5ls84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520429; c=relaxed/simple;
	bh=OdruoYwyNNbLHTi8wHa+0WFf+wgF0H6mJB0YUgv/lGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNNbmOBCaXO+CRn+pVpGqSWBef7p9sC3SoSpc4IsWBME5pJ47B1JRwhB2iLdZgjU7VTg7HGTNvN662+pzk4JMKC6HQQv+5cemN31Dd86/ZED2cg+Mb9cqQruWPEpK5+l8ZwV+DeLrxthfVSB3vw1gCKj1/qMT89ZN9VkglWspug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=JlrwJh9o; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="JlrwJh9o"
ARC-Seal: i=1; a=rsa-sha256; t=1774520411; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Jxt/uj52s0tIYsBM7JLncwfY6t2UbWJ9ODXMneD8flT0TuuZwdJPwPBDl744EiuR5JFy/cqL9uIEtz0PNSqkZHaCwjSnPCRxYOr8cJg+8d9yAInncvSDBZxY6j+O5/nl8y4Bpp/6li/5xWzPrxnJ234b/FTA3AEE6QTc2pJC+gI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774520411; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=d270zZLuHvSTvk8lHyk3FlYFW2MDjpydLxsvAl/8doY=; 
	b=H0y5YpZj/DOgUndLpwpJQOG5AaiWoIRPKju49+cbUemj40Yu7IsY8YDv4zjcB2xOfh9rIhOQPSeG4T8+XxqSW89t4xSR5em1zUvv8O5Q+piKYK6KDLeM92UmWrhDfwIZhnW1Dt7OPyafGW9tZgKImZulwCq7SvjPoJVByanqGig=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774520411;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=d270zZLuHvSTvk8lHyk3FlYFW2MDjpydLxsvAl/8doY=;
	b=JlrwJh9oy3NYJ2o7/1Ea06t0VfhYrbOh0uObeUhtuU+rK0ZQEvDdCktWlcoRXSm/
	BNxTQyxGOtwUS1gXMhYBwUDYiicT9A3fcDsL4fqN6IcwlRRQwwAw+RIGf0GM93RUCY7
	i0BTp7HU4zoluyKnjuxBTsaimG1ojF026FrLGs+w=
Received: by mx.zohomail.com with SMTPS id 1774520410335244.65869409002664;
	Thu, 26 Mar 2026 03:20:10 -0700 (PDT)
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
Subject: [PATCH v5 01/12] repository: fix repo_init() memleak due to missing _clear()
Date: Thu, 26 Mar 2026 12:18:08 +0200
Message-ID: <20260326101819.1307742-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260326101819.1307742-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260326101819.1307742-1-adrian.ratiu@collabora.com>
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
index 0b8f7ec200..fb4356ca55 100644
--- a/repository.c
+++ b/repository.c
@@ -322,6 +322,7 @@ int repo_init(struct repository *repo,
 	return 0;
 
 error:
+	clear_repository_format(&format);
 	repo_clear(repo);
 	return -1;
 }
-- 
2.52.0.732.gb351b5166d.dirty

