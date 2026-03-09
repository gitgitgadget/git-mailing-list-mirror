Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924253C6A2D
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063536; cv=pass; b=PyCjOKb+HJokEUfNntB9/SHMBe9DP/s1nvxtsyTMZjH5zb83fk27h3w7CJIfXvz3tOYleTnahc/Yp/1QQhq4q1IEPi2uCf5nvmFqN/ByNs6NV1QSvoR+v1Y+elpADe7poBjhrq0DJ/3G8fqf9OC/kn1t1ebHG76uJlAS/abhU0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063536; c=relaxed/simple;
	bh=OdruoYwyNNbLHTi8wHa+0WFf+wgF0H6mJB0YUgv/lGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrCckPg0EN6xL4Mxyfm02X5F4UGhixV59bDiMecmOm2+19mRXFx3t9zGq2TmfN5obSwSZ7hJSc1lFVnTV0We6HEzgjU1HExIYr0V47fEdQdZ+XjfYU8Nfm76+9xnStw+qgGWoHEFw0Ui50aK6488D9DjtIqwjZKiM9QLDwXW7XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ejkeaR+B; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ejkeaR+B"
ARC-Seal: i=1; a=rsa-sha256; t=1773063513; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a+KSVPqfP5FHr807UvUurBBmb140MHV1XXAhgev0TGpcFujNoxFKu6oTb2Tatg6MA4RRGlLScCOPJNGMqCNBwJJpVazsyrywJeRC7FiY2x5osYl73Qf8VImblxxO7sfM8FFhCslayHDChI9HNgNOkg4uTKxKjpm3DSrNltkREhs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773063513; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=d270zZLuHvSTvk8lHyk3FlYFW2MDjpydLxsvAl/8doY=; 
	b=K6OZaHAkUCI5OU60Mekn2ZhqptmXpAl0t4ZhoD86+uJtTgbvFrSRt0LGeSJp/3xSSKXUTw5E8a5gUUZRs3t28+BEikRtFLVul6ZTZJjhjOc8liKj61Yii+tSDAN2ePukxikstDnrsGE5Y4xL4pM9GVucV/erwYonDTXtnc0j5n8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773063513;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=d270zZLuHvSTvk8lHyk3FlYFW2MDjpydLxsvAl/8doY=;
	b=ejkeaR+B+qTTMRKu8k8sLobxM5xlYqjCSzaONMziH76w6YX/bkgb/jKeOWN+DoVG
	5BDd39A8ZnoSnukXKwnhw+eMlGXMdmOFh3Saj1EK8s2EbUnZmzF+2xfGOIp/SuqQKet
	H6elI63nttZCcKamyZP6/r05K+6wQ0qVgTbtIt8M=
Received: by mx.zohomail.com with SMTPS id 1773063510934777.9203095152455;
	Mon, 9 Mar 2026 06:38:30 -0700 (PDT)
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
Subject: [PATCH v3 1/9] repository: fix repo_init() memleak due to missing _clear()
Date: Mon,  9 Mar 2026 15:37:31 +0200
Message-ID: <20260309133739.294555-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260309133739.294555-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260309133739.294555-1-adrian.ratiu@collabora.com>
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

