Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B963A1A3166
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773475172; cv=pass; b=qR/cai2JYufTiNOqpZ5s/Y1BY8nkIH+gANiJE3uCrBaJwABwvZAqD1ENAL6KRa+0ZRUntx5XikBwA5Yl169KxDd9Pg1S7/RVANy1/4rbZKi+yWSCGIpVSL3rIWfBNVIzJYGvmyaUsBh3lEzBWwIwWgUa42iQPf8/d6rKF+FeOVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773475172; c=relaxed/simple;
	bh=XCm5lkAIEDKwFz2t6TxXby3tSEPMcKPuoWYN5Yewwdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMEBkq1fpQyGKM5/YVtRFhDAkAlmqkzrfHjGXTDRFKvtEiaDvEBT+MVhUQBquJvCAPY44uQx4dnraJPNXE7MZeVDDmJ5y4HgkZvVkYHsgAvRB7gIz48UMxcpjS4d0Ghb/AZWsJbCtXFXJRpIYbtZH9tHWPgqCQ2LiLav0DrztuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com; spf=pass smtp.mailfrom=ritovision.com; dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b=nJcRCQpo; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ritovision.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b="nJcRCQpo"
ARC-Seal: i=1; a=rsa-sha256; t=1773475167; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c4LkITLcpyGzxWgCiSgvuVr4KOJw60DE5zLx0GHaRR5d7cVIwCBaP0TZGMD4rft/9goxjkrADVkCYL8zkDfDKieXmGHdx7VcGMokI+wCaaF7LB3F5SfL14AJXF0fZvGYsFZLG+xgrHFfyzWcoKoaBUK3sMtAuiP0SQ9ep29jqX0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773475167; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Qfkdk2KQMCOctg6zgcSDnTaZ7RWz2n5FMvgUGslVoWQ=; 
	b=B/GUO/WhYyBY2XX0uUCdJO6mdKZ7z1x0DSCQz1H+COedeIRNz5pIojaRNMe+0/6sSuWdl/OT1QXZMzj/eFErzFgg8cx1BEfPaLWumsX96zrTq3zZgcHXG4fWTmRZNC+axzICPqJocLxPutUCyd5aP88X1Ot9RGJfvRbu4XB+OO4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ritovision.com;
	spf=pass  smtp.mailfrom=rito@ritovision.com;
	dmarc=pass header.from=<rito@ritovision.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773475167;
	s=zmail; d=ritovision.com; i=rito@ritovision.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Qfkdk2KQMCOctg6zgcSDnTaZ7RWz2n5FMvgUGslVoWQ=;
	b=nJcRCQpoC8OVV9UCT07GGP+IG4Fe+sPjlvCRPB/Lvqq+Z7yJqXDsFSocXLATXUxP
	W3tc9ua/PwKX/Zlv/CaI18inshSMLTlqpvQ63Gety5/WYOL1jPKTSopEqoMbKuOcOli
	Lwh5WokmRHm2ty9swt5lCYwtOA1Pt0mt5L4JTUaA=
Received: by mx.zohomail.com with SMTPS id 177347516526170.30474967005671;
	Sat, 14 Mar 2026 00:59:25 -0700 (PDT)
From: Rito Rhymes <rito@ritovision.com>
To: konstantin@linuxfoundation.org
Cc: git@vger.kernel.org,
	rito@ritovision.com
Subject: [PATCH v1 1/6] add viewport meta tag for proper mobile rendering
Date: Sat, 14 Mar 2026 03:59:17 -0400
Message-ID: <20260314075922.67391-2-rito@ritovision.com>
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

The site UI is broken on mobile because pages currently render at
desktop width on phones, which makes the content appear tiny and forces
users into a pan-zoom dance of pinch-zooming and horizontal panning to
read content. Adding a viewport meta tag to set the viewport width to
the device width enables normal vertical scrolling on small screens and
establishes the baseline layout for follow-up mobile fixes.

Signed-off-by: Rito Rhymes <rito@ritovision.com>
---
 korgi/templates/base.html | 1 +
 1 file changed, 1 insertion(+)

diff --git a/korgi/templates/base.html b/korgi/templates/base.html
index 9872e08..ce1d5fb 100644
--- a/korgi/templates/base.html
+++ b/korgi/templates/base.html
@@ -3,6 +3,7 @@
 <head>
         <title>{% block title %}{{ SITENAME }}{%endblock%}</title>
         <meta charset="utf-8" />
+        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 	<link rel="icon" type="image/png" href="{{ SITEURL }}/theme/images/logos/favicon.png" />
         <link rel="stylesheet" href="{{ SITEURL }}/theme/css/{{ CSS_FILE }}" type="text/css" />
         {% if FEED_ALL_ATOM %}
-- 
2.51.0

