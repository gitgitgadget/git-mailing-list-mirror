Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ACB31AA90
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773475186; cv=pass; b=qReA6poWZymEOL2CWykeSviewycAuwxGaUQ95DFQzRKM84NsXgdDBzWrvSpuQgypsmA0PUGeFcd2Eb8/NlORPPhOAkVwlpQTXXl6Qr39eOfLdV6EyBlHOWRodR/NHkAOCczJ2KY2rri2VdAiAUesqitKSB14lC7ZFpht2JyIDt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773475186; c=relaxed/simple;
	bh=vJ9qVe1C5/ZF8hb2dyyCd01Nx9e13HedCrGO9a2K8Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWt2YOqqjiYL5Y5gqidBthbiehZW2ea8RfxSBYY6ornK1f5stPt0EGOYrpJmL6p36R8WoodfQURYmm59Ec/e5M6iefv7p9Zc3wJ5nUtTg/f5cSmE/E6nGxFkM3q1djHM9F9LUOwh2HhhQKSHh/7hu9iDVnlX/kYb0nRlKFrFd3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com; spf=pass smtp.mailfrom=ritovision.com; dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b=Yx39f/LH; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ritovision.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b="Yx39f/LH"
ARC-Seal: i=1; a=rsa-sha256; t=1773475174; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aLGg5DRTWB1meOdkneNcjraftKMRfXtVDBlracodye8IUl4MmZVtrkvFen6X4HrmMOYZ+o4teEoWRWmAuM1ZQRj+HsK5vKxlw3dYmJMEd1pdCj8H9l9syDDZ3tVL4Fg90yygt1of1rDsyjs8eRVT7kPQrOi9rhC5ez0ZHPCLhJY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773475174; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vJWtUYuMW5ckXZlEqHW8krhm53qL1hvU/A1MiSgMeJc=; 
	b=KTVrYRJ4bAaqL6yszMohzytCUo08qxr4IAeRWMB0sEuheAMxFEb0OfbAlKou2BPeO4mLs8P7/0geQEQALuk5IgdcaVt7WBMp38B7ueElJ6oueYxHdRp2l0wsiRXnyVOebWWaKkMYeTIvnnL70qpFYxExCq/8E0A8dhkn+yKF3FY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ritovision.com;
	spf=pass  smtp.mailfrom=rito@ritovision.com;
	dmarc=pass header.from=<rito@ritovision.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773475174;
	s=zmail; d=ritovision.com; i=rito@ritovision.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vJWtUYuMW5ckXZlEqHW8krhm53qL1hvU/A1MiSgMeJc=;
	b=Yx39f/LHpK9vwQKSx2zg99TzjV9bN9gctWFMeqpngAOzvzShlIwDI6JcuhL2XwTm
	Rx8YTmig/eP3ZL2YdnDiNEDE/kL9jVoYWMBl7DOcrT2U3fD1Q67WQzBfSZ6wBTuQ072
	4cODeNacF6e3kORmjuULO3GfYYh4QgkhYttECNNs=
Received: by mx.zohomail.com with SMTPS id 1773475168871654.5814190811026;
	Sat, 14 Mar 2026 00:59:28 -0700 (PDT)
From: Rito Rhymes <rito@ritovision.com>
To: konstantin@linuxfoundation.org
Cc: git@vger.kernel.org,
	rito@ritovision.com
Subject: [PATCH v1 6/6] improve mobile rendering of docutils tables
Date: Sat, 14 Mar 2026 03:59:22 -0400
Message-ID: <20260314075922.67391-7-rito@ritovision.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260314075922.67391-1-rito@ritovision.com>
References: <20260313-loose-whale-of-speed-ccdbe2@lemur>
 <20260314075922.67391-1-rito@ritovision.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On narrow viewports, docutils tables become hard to read: the releases
table compresses too tightly, and the signatures fingerprint values
wrap and lose scanability.

Both /releases.html and /signature.html use table.docutils, and their
cells contain data values (versions, dates, fingerprints) rather than
sentence prose. Keep mobile behavior consistent with desktop by
treating these as single-line values and preserving readability.

Make docutils tables horizontally scrollable within their container so
cells can keep single-line values without forcing column collapse or
value wrapdown on narrow viewports.

Adjust border drawing for the scrollable table state by resetting
default cell borders and reapplying explicit grid edges to avoid
uneven/doubled outer borders.

Signed-off-by: Rito Rhymes <rito@ritovision.com>
---
 korgi/static/css/main.css | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/korgi/static/css/main.css b/korgi/static/css/main.css
index 16d97cd..04955c6 100644
--- a/korgi/static/css/main.css
+++ b/korgi/static/css/main.css
@@ -382,6 +382,22 @@ dt {
         margin: 1em;
         padding: 1em;
     }
+    table.docutils {
+        display: block;
+        overflow-x: auto;
+        -webkit-overflow-scrolling: touch;
+        width: 100%;
+    }
+    table.docutils th,
+    table.docutils td {
+        white-space: nowrap;
+        padding: 0 5px;
+        border: 1px solid #ccc;
+        border-collapse: collapse;
+    }
+    table.docutils > caption {
+        padding-left: 5px;
+    }
     pre,
     .literal-block {
         white-space: pre;
-- 
2.51.0

