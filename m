Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A33940D592
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781132129; cv=none; b=ZcxwH3a8PhMG9hhjXn5EbxWWdEI07i8TLoCYitGxwFNtkxUHpGUT35K4BUEgoR5bCzXzPoR89Cn77WX5OLgq8tZEJboXgr4vjIYSFjCZjAQPgik/eKUmjogZw8tu0olB0LMxh9E9PYZNMzcXz5cNrQhyss0zRc1OpI0sYad/wn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781132129; c=relaxed/simple;
	bh=joyJtNSL9Tn+kG9zq/mgxievqbsy9HyBH+ByXwpLfRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaLuxd9rJ+6F9OVAw2437OZJ4GuhYBdW3dfhJIswsTcfZwOKs8nsFoBAxn8gqDB3QSo1DTsdRbNFYnvNrVknFwUYI9D9n1muhINrfWp3oHqTB+AbNL7wwjaT0++XU//4l9tRpy79D1K2M0yj5TnugKgNrQYLJTzmBTVrerCbRxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=QLInkuJx; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="QLInkuJx"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 65AMtHVM032427-65AMtHVO032427
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 11 Jun 2026 01:55:18 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wXRpN-00Euuo-RB;
	Thu, 11 Jun 2026 01:55:17 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 01:55:17 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 3113db40;
	Wed, 10 Jun 2026 22:55:17 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano
	<gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH v2 2/3] doc: config/sideband: fix description list delimiter
Date: Thu, 11 Jun 2026 01:55:12 +0300
Message-ID: <20260610225513.6269-3-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260610225513.6269-1-taahol@utu.fi>
References: <20260610185148.23920-1-taahol@utu.fi>
 <20260610225513.6269-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-12.utu.fi (130.232.247.52) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhbWkgDGgEbHAcODg0aAAkdDxsK
 CQMDKA4JGxwFCQEERgsHBUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYL
 BwVIWEhbWkgDGgEbHAcODg0aAAkdDxsKCQMDKA4JGxwFCQEERgsHBUhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=m4II0G+3tAKljs1ILbYECbJXto68CCmRpDRY0fuk6yk=;
 b=QLInkuJx45zpHEqKlUlc+D7hVZTbpNf+B7hKKyrmT3NP1pmmVkhmLvII0Qh37gTBvQQt0YZ0Upbh
	hKB5M9S9wzSeCvRz+kZBKqliSE/WrhzlPitFc2LobvQ8fmCVrnuOrRnLvj1CEnmVljkrM5SZP7GF
	iyC1Q8O4cIjhlmoe70tRn670bqBJVz9vTYaRj+dyT6TtuCYEYmlc0bQI5m13PrBuXF/r1XdQX/UK
	jw7oSBOyUsB9+hNFSBNk89prZX6lgH78tYuEZhZxxLnE/oaPBWPwISjEFDC0gNJCEobXa0ggXb+L
	Vio5/y8oi19eOCnGamH50M4btAg29wtbmTAglQ==

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 Documentation/config/sideband.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/sideband.adoc b/Documentation/config/sideband.adoc
index 96fade7f5f..06de0d5c07 100644
--- a/Documentation/config/sideband.adoc
+++ b/Documentation/config/sideband.adoc
@@ -9,7 +9,7 @@ sideband.allowControlCharacters::
 	`color`::
 		Allow ANSI color sequences, line feeds and horizontal tabs,
 		but mask all other control characters. This is the default.
-	`cursor:`:
+	`cursor`::
 		Allow control sequences that move the cursor. This is
 		disabled by default.
 	`erase`::
-- 
2.30.2

