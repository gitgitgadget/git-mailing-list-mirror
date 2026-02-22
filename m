Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5814A78F26
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720194; cv=pass; b=jLJDiTmabuxaA+dT3Km0sSeCKOy2upu0s+X/NZrjMUhz5nyflWiU/T2n76VT8b3nLWgkcYiF5/ggUz6dfphMNkFYr3qNTAVCpS8udGEg2dZ7/MSBZeKDosNVwZzTjDVeJ14skVSjE5VpEnCakYU85HT4HTKk+IKqjZCNKcfFj6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720194; c=relaxed/simple;
	bh=6h1qJj2lvtOZcjj5GG40yR8C1sHq6X31OoHkTGl0NWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXlVSgc1uZn4tktWv0KZaoGVs55WVOVvtoEF4DeSjLuuzzuArbHmDTFvmG/ns5ad4aXgUyDFvk6upRXNPOe7/FXPTPmPy+EKSaIoY7XDjIY+gvldI3XKxa4wh/U2JVkNseAAEX08XLzCx6j8QCJCkNJ2mWJDAU/vWSm8X0qp3nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Gm4EUI9l; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Gm4EUI9l"
ARC-Seal: i=1; a=rsa-sha256; t=1771720163; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FfyNZapRMBpPcZzIGdFPT5vGsZ4xbeK948Av4/1r9huSGxL5hHJfZNir8eKaNy63WUHWHnuRhzRKETpbjneey40SwKEfUaJg3aFJM6cy11HiVbt1tqmIgC+O4gdMFOXqwXaaaKEa7Pf2EcMTN8BZ9jxUVvjloMIcnpNvQ8tx+rQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771720163; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9g+wMRneq0WkNVAWniZfV5py0Yuh5GOt4ndmFxAQaVk=; 
	b=XzKSZbRxRbeB+eCw7tHx9fLVfmYsNlop2rKBCNE39PqFvWdhjy4Ln1/agglJoT9Iv5KNkefrFALUp9AiNcvIFTMR6RmbT90JzBTMhbl9ZjO1B4AjdnEDUapwolOWpuK8tk1Slvu7XsXSy/lpcjyRgDdMN4WLrPXx3yfHOop2U8I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771720163;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9g+wMRneq0WkNVAWniZfV5py0Yuh5GOt4ndmFxAQaVk=;
	b=Gm4EUI9lSRBgPXtIkFXzkJe2CFU+vHnH9YZf6S6uhnVyxc+bmnmVZREFROAg+eKk
	6eysOMvkOTxeUNH++tXURekGnzCfLl2Ip7OdJ7+ayS4Td4jeO8kHrArN5j4bPbKL0+J
	YyG9Qz3sm5pT61OsEdBEaKTHZr6z+rfNJST+VROA=
Received: by mx.zohomail.com with SMTPS id 1771720159633594.331005534723;
	Sat, 21 Feb 2026 16:29:19 -0800 (PST)
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
Subject: [PATCH v2 01/10] repository: fix repo_init() memleak due to missing _clear()
Date: Sun, 22 Feb 2026 02:28:55 +0200
Message-ID: <20260222002904.1879356-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260222002904.1879356-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260222002904.1879356-1-adrian.ratiu@collabora.com>
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
index f27ab29b0e..78aa2d31d0 100644
--- a/repository.c
+++ b/repository.c
@@ -298,6 +298,7 @@ int repo_init(struct repository *repo,
 	return 0;
 
 error:
+	clear_repository_format(&format);
 	repo_clear(repo);
 	return -1;
 }
-- 
2.52.0.732.gb351b5166d.dirty

