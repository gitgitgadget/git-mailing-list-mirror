Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650623B3BE3
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812019; cv=pass; b=j6faG8gfTDGRCut2ekUWYX0WpKSf61TNrdFfvFsTDM1DFgBenC/7PIPUOCuExpqwD9UiPg/cvOXBnW8stZ72SgqdDm5hfIP2MTw2kAZnL1fm0C/xUvQH7mLDZIE56aednrT9Te7vIRM9cote5ZQxu4dVxSccewra8NhzlHcTBsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812019; c=relaxed/simple;
	bh=XJJ+Dok6PVPHbpCRjGHAgQnNi/LncbeixWs5T0zaS0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXOn/qNRVAShuEhmDQGSnfcJXenVlu/lzwjJq6AtwiXoVWTUr15Cpb+FAjrjqGOWJd/4LL947PRC6neBj/gVE5PjDd8ra8M8fYUf7JsgzVrAwe3EuUAGRPFwu6ugnE/BQvKUqxuEDbZcOhRju7wMgWfQcJi8EkstczT8XNc4IKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=iI9lX5x0; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="iI9lX5x0"
ARC-Seal: i=1; a=rsa-sha256; t=1775811998; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i3RiEcXsekqiHBPtC8Ik7BfLZYp5HPU2mVoV6NPcvO0ris1+KjSIq+eXc3DFg5uUjkNQWosulEk86jRGfp9pflqH9ZzUX3qroXxMJsugaNDh0wzh5Wi5xPbmzt/2czRDWdGfXEZ6O0WcXGa8/dLKs3WKBRv9FmTBKs9AgMSoa/A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775811998; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Xxu9yYviTFoTVKiwz6ZelmCPxzzOE9OaZjP/OC5bkko=; 
	b=WxGLEM3NZDq141C93lCNOPJuOaMxa5ngpQkVb6b5uyfiChAZ4vtztzMWkxJ5L/yj62oU4KmlypyD9IjZtTq1TfcdLBBk5RWiOH2jLp+/6CTSq4xeihe5VTsyVP5410tGZa0+6nApsrvxt0pSRvJMDRN4i1v1GDrD35LGERDZozY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775811998;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Xxu9yYviTFoTVKiwz6ZelmCPxzzOE9OaZjP/OC5bkko=;
	b=iI9lX5x0ow345Ae049OEUU7t1uj95AAkO1ZRN9Kr1drWLoh9pRnjk89eP5JLGiJk
	T7zONVYWzmbzD30T7EDUeyQ7XI60kKWf6SOabGEHrqutPGJDGdAJSntva5ODj030y+W
	LJX93P8q1HTWoJH105dWP5HpctXUxGb+E3vP0Xmk=
Received: by mx.zohomail.com with SMTPS id 177581199686768.12848732855218;
	Fri, 10 Apr 2026 02:06:36 -0700 (PDT)
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
Subject: [PATCH v7 01/13] repository: fix repo_init() memleak due to missing _clear()
Date: Fri, 10 Apr 2026 12:05:56 +0300
Message-ID: <20260410090608.75283-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410090608.75283-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260410090608.75283-1-adrian.ratiu@collabora.com>
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
2.52.0

