Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEFB2ED154
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044622; cv=none; b=ebFSJFJHtrvCl0jcm9drP2hsT2qjmuokLkh+RudXB8VcY7d/uvyzB+hp2xco2TawCo9oPpTvjghPdHrhi92OCgfM36Zg26IFO2sq3N6hxo6ZIL2VmzBScz3ZQQh1zKx1uQmbUfY8jEvg54VlKixSCZMdUJjshmEOJh5Ysy/pMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044622; c=relaxed/simple;
	bh=ypvyXrAhKe6bEeDpEzH05N4Ui+8VGRbBTGqjr+tr0iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ej8+mQJkP53VqYdypNHq+PThMg/aYdzLfvNDdeLmwUknx+8DNLDJjFYDjLyZAkbgpieLsNYljuEYyGopiXFn4BbgnI+BPFY8q0IRSjkqjuNMoCdS9rpVlArLZCo43eI8dFDzYkmAjkXsBqh3V8tTdUXECO01UySUVO9XoFe8f20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxY18vxl; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxY18vxl"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5fe086fb0bdso1827251137.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 10:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772044619; x=1772649419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJkD6ryGIPAmk/+vMsMZudfnyfau6ng2fKuFs/NXFF8=;
        b=NxY18vxl4xwdHDQtC4xOaFyjj2vzGme3FN5xNLlrTLBn9/OuOIrmGLUc/mdnOLbCWJ
         x1OT2WubSevlQlrDD0OW5lx55sZPGV9unB4D8XDH7/Hohc2E1R4mv5OeF4L/7Dygm4Fc
         yMIPiIvaspVk32K0KPvQOgB22IoaLyl3iLsVJ+5gCjnUfmg9p50q1yUX0Y2Xy6piJnUX
         J4yZ22QcIfh4Q4+bWDBlpe9TrI8EVa3z1XnHfojze2SwMeE7+nmrEUQRxPWeFayxyWcM
         bCXxfjdc/oQ9wYmefKcao3Lx6l08zPZGg5f4eCSv8LXI3CM8NjThWPthdjJFN5V3e4l9
         Jc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044619; x=1772649419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pJkD6ryGIPAmk/+vMsMZudfnyfau6ng2fKuFs/NXFF8=;
        b=vj4IPMRrSb0tOzg/0KU29Ow0N08dKHeMD40FCDHop0eoRfBjCcXkafdcvUFlpdpDaQ
         dVgceGup4U/Up0oMJ4L1WogEPwHL2VlxFqJlEL+V6s7kXOIm16DUO2oBCDjpTuekn01Y
         fNFav51FW1S1LN7QnZsDiJQ5DDUW9zCr/cnLBSREojgX1cVk3XegBukrRttTnv9sPVRS
         Hq3sxA2yfXAILMhc+lmfZ0qgQWTn0DfWhiRWuxzwaQ0Ayb2SZpDdrSiDxcLUxoatwOdQ
         QYNY8u5ci+slYvncuHUbzEs3dNWN9gUsXiqJGGmeemDqNrHBWnTELVpP4v3vdqv9YFuX
         lFEA==
X-Gm-Message-State: AOJu0YzMLRpRIDNYY7PYHd9gKNoJ3rOSfCArCefOR0V2XOHE1vIvp/q1
	l9Kr/irMQeXS5odkuNyLa+OB25sxxqQECLnhQu0QDeAuT5vygVDNnQhaUXb81Q==
X-Gm-Gg: ATEYQzz586CI2B5atZfZYWnQ6pj525zlZ6whC6B2tA//39rEThGE/vvoNs3qL4vV0+2
	2mojsrgiL9h9sO/OYwrwbRhsS1NK+EMKBRmxG/QTQYFJhnfuj8czaUAJziwkeZdFkHnTASIXLot
	TKiXWpRuMXVsk/8e3WU0jPFN1fsvauA6tFbjCHWC523md1HIcMWeXqOXy6184aqNFyPDZGXV40c
	V7x+F5pb9I/9OxRkmwoLZ0XTFIxWi0vHa0mmqWxQs8ALAHqqk0bd35ok1j8UkSA9Xb2VjBrRiP2
	Q/NDwSB6aVTkVgyStV9iS1pI9sBFKKwaTcdY5hxTkcM5lozfILEt4zqh0PlX9wwIQJ0/lFBDZho
	NIiFHWYWLrlvgTLgaD/owT6kjhwWjKPUmaF+VN0d8jJ0HGWHXosmZvWTu45JUpZxaxpoZLbt2lg
	xQ97xwlZocBxuI+P3JilrfqguIQ36nneIGsauCx50I4u7wLXQVRu9keQe5RrgY
X-Received: by 2002:a05:6102:4429:b0:5f7:24dc:3ac3 with SMTP id ada2fe7eead31-5feb2e86b02mr5424591137.7.1772044619360;
        Wed, 25 Feb 2026 10:36:59 -0800 (PST)
Received: from localhost.localdomain ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da89e129esm13457485241.5.2026.02.25.10.36.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 10:36:59 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 1/8] CodingGuidelines: instruct to name arrays in singular
Date: Wed, 25 Feb 2026 13:32:10 -0300
Message-ID: <20260225183559.79303-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260225183559.79303-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
 <20260225183559.79303-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arrays should be named in the singular form, ensuring that when
accessing an element within an array (e.g. dog[0]) it's clear that
we're referring to an element instead of a collection.

Add a new rule to CodingGuidelines asking for arrays to be named in
singular instead of plural.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/CodingGuidelines | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 51cb70b515..6c595696a5 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -658,6 +658,19 @@ For C programs:
    unsigned other_field:1;
    unsigned field_with_longer_name:1;
 
+ - Array names should be named in the singular form if the individual items are
+   subject of use. E.g.:
+
+         char *dog[] = ...;
+         walk_dog(dog[0]);
+         walk_dog(dog[1]);
+
+   Cases where the array is employed as a whole rather than as its unit parts,
+   the plural forms is preferable. E.g:
+
+         char *dogs[] = ...;
+         walk_all_dogs(dogs);
+
 For Perl programs:
 
  - Most of the C guidelines above apply.
-- 
2.50.1 (Apple Git-155)

