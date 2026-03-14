Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1542E975E
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773475181; cv=pass; b=EUoYs6rH8JnXtdDIM4Hh+8lSNGohsJGs++yiBk6bxeRLAE5Nok/x3gPauHyc0QO+2r00o/ek8QBXqOJlvfiYpBpt7fXnkOgaas2wYGXqkOFmaz5aTna3dvIq+bUNy0gM0FRohTUy7bPbB0fm9ee1OJ3mSQiA/R+AsZ+VdM9MGuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773475181; c=relaxed/simple;
	bh=TCI76K4yPIIuPDGTluIV/CbjkRI3HRTI+0TJMRDnlTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvTXIwCXjpkJovk6KagYwjidFqsEnPsmyG7JZ+VxTZ1g4wtoPo+9eMONgDPNGcTGI+4wFL6McNWHH8dCkN1KMsPXI2NtmclbSkkqzxKLCs02flBW0EkMsulE6xB4TW0FU0YveCfzhfVoot2R4QYqiYOr9CzfXxpoZnbTlH85tIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com; spf=pass smtp.mailfrom=ritovision.com; dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b=R2uC726p; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ritovision.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b="R2uC726p"
ARC-Seal: i=1; a=rsa-sha256; t=1773475172; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=m7U60PuwMhH3DRD4eqFeB+8pRowICDI+QucWP6PRgQKXv42x4F3sfgmzqTEWDyE+SywlULTfzw/pUluCURQat11B7gAhCP8dA/+93uhztiAn29tiLBvkHkL2uovjdXhmeweCutozkDZ/T8pIY+vKOX3xaveYARFv/Bfe5Ay4W4E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773475172; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JOtPm1O+LgaZqdcbnMSbpE2aPXFmdJ+H0wGJoi9ro00=; 
	b=HodJ5VibxqFgY6/8CfGnJwsPJVqn5TCC+8sGhAGHD/Dgz98gxtMTbKQHFdddd4uvtyEIuC2Kft+zcVmFmYgunMNq6K0yfIOlPCdf0H4hK6Hel2+N7SVJbQuQxH6bcIv1CK0TrvkjJUvuYyIscToJMnZpUJYIU1uF/HOJF36zURo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ritovision.com;
	spf=pass  smtp.mailfrom=rito@ritovision.com;
	dmarc=pass header.from=<rito@ritovision.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773475172;
	s=zmail; d=ritovision.com; i=rito@ritovision.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JOtPm1O+LgaZqdcbnMSbpE2aPXFmdJ+H0wGJoi9ro00=;
	b=R2uC726pV3wgTChGCktWs8uFAwQTjkAJDt9H50qm6yraCJUhCOz/Vk/2tVpu4P2+
	BaafMS6EQYfbSyiZPOZ7oXM2hTRkLbcRKSpkGere0z/pSApcXVclbeCLpWKeoEI4Gjj
	u9dbAGGXrS9U65zmamKoVSbFbC5MwFUw5njVGz1I=
Received: by mx.zohomail.com with SMTPS id 1773475167502814.5871763432677;
	Sat, 14 Mar 2026 00:59:27 -0700 (PDT)
From: Rito Rhymes <rito@ritovision.com>
To: konstantin@linuxfoundation.org
Cc: git@vger.kernel.org,
	rito@ritovision.com
Subject: [PATCH v1 4/6] add responsive extras and footer layout adjustments to contain overflow
Date: Sat, 14 Mar 2026 03:59:20 -0400
Message-ID: <20260314075922.67391-5-rito@ritovision.com>
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

Below 848px, fixed-width extras and footer blocks overflow the page and
create page-wide horizontal scrolling that breaks layout.

Make extras and footer sections responsive by switching extras to
wrapping layout, stacking blogroll/social blocks to full width, and
relaxing fixed heights/widths. Update donors to wrap logos and hide
manual <br> breaks so the sponsor area reflows naturally on small
screens.

Add 550px and 400px refinements to progressively reduce
blogroll/social column counts (3 -> 2 -> 1), preventing overlap and
preserving readability as viewport width shrinks.

This patch is intentionally limited to extras/footer behavior; content
and homepage table overflow handling are addressed separately.

Signed-off-by: Rito Rhymes <rito@ritovision.com>
---
 korgi/static/css/main.css | 84 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/korgi/static/css/main.css b/korgi/static/css/main.css
index 19ee328..d20d8b6 100644
--- a/korgi/static/css/main.css
+++ b/korgi/static/css/main.css
@@ -360,4 +360,88 @@ dt {
     #banner li {
         padding: 0 0.5em;
     }
+
+    #extras {
+        width: auto;
+        margin: 1em;
+        display: flex;
+        flex-wrap: wrap;
+        gap: 1em;
+    }
+    #extras > div {
+        height: auto;
+    }
+    #extras > .blogroll {
+        float: none;
+        width: 100%;
+        padding: 0.5em 1em;
+        box-sizing: border-box;
+    }
+    #extras > .blogroll ul {
+        display: flex;
+        flex-wrap: wrap;
+        gap: 0.25em 1em;
+    }
+    #extras > .blogroll li {
+        width: auto;
+        float: none;
+        flex: 1 1 30%;
+    }
+    #extras > .social {
+        float: none;
+        width: 100%;
+        padding: 0.5em 1em;
+        box-sizing: border-box;
+    }
+    #extras > .social ul {
+        display: flex;
+        flex-wrap: wrap;
+        justify-content: space-between;
+        gap: 0.5em;
+    }
+    #extras > .social li {
+        flex: 1 1 30%;
+    }
+
+    #contentinfo {
+        width: auto;
+        margin: 1em;
+        padding-top: 2em;
+    }
+    #donors {
+        display: flex;
+        flex-wrap: wrap;
+        justify-content: center;
+        align-items: center;
+        gap: 1em;
+    }
+    #donors br {
+        display: none;
+    }
+    #donors img {
+        max-width: 120px;
+        height: auto;
+    }
+}
+
+@media screen and (max-width: 550px) {
+    #extras > .blogroll li {
+        flex: 1 1 45%;
+    }
+    #extras > .social ul {
+        display: block;
+        columns: 2;
+    }
+    #extras > .social li {
+        flex: none;
+    }
+}
+
+@media screen and (max-width: 400px) {
+    #extras > .blogroll li {
+        flex: 1 1 100%;
+    }
+    #extras > .social ul {
+        columns: 1;
+    }
 }
-- 
2.51.0

