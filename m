Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392573988FB
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853608; cv=none; b=aleDLIJAUHz6iEKi+OoX1fXUQni+0LCemmPuDKhP0wz94zr0Svq+fQDD9SOTdvk4Mu8SmIWLKJLRYsPJPvykJ+QS3jcp3e18CBeKxG0n7d2LqRyGxGA74zbKQxOqlU752xfZjUlGbHy//QjCAIOSK1wbhaqRXgjEA423TmehNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853608; c=relaxed/simple;
	bh=y/xe1gC7B+qil0NCWPQlKKrh2JTnIltsUGjfO8k08E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLUcoKBebROPlupwOweUb34iHmODk5+NxWG51BkMxdIHgH9SojxtmcooJCgvkP4HKWsFpX8qGikUa1/tWmF6TSUVi8UeIn2qSyV1+OgxWQnottVLofnWOT3pWBasZqv9dnTIO8NAO+9XBdAxVrGv9B7Z7VdxrSugM11N7zXsV10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sithyd.siu.edu.in; spf=pass smtp.mailfrom=sithyd.siu.edu.in; dkim=pass (1024-bit key) header.d=sithyd.siu.edu.in header.i=@sithyd.siu.edu.in header.b=lwYcClIu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sithyd.siu.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sithyd.siu.edu.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sithyd.siu.edu.in header.i=@sithyd.siu.edu.in header.b="lwYcClIu"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so2010862a91.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 23:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sithyd.siu.edu.in; s=google; t=1774853606; x=1775458406; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2b8jW/CJe8O1pXbiEvPjYp599I2IkDRzB8VGuiC2Sc=;
        b=lwYcClIuZLPtJdsj/CybSCv15Tlu6yMP/7bppHdjTvbpwCaMcXatTYIcA3GwAC1+NE
         GcQT0ivn4/E3nG5+x+rx2IQvyz4Vkb5nyD6wS7fv/CGonw5F6qhWZw+WoxuEtQIIDCP1
         X4Cvcvn++UuY2+mWoxqhNWkDTg1a72ERZ1jtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774853606; x=1775458406;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2b8jW/CJe8O1pXbiEvPjYp599I2IkDRzB8VGuiC2Sc=;
        b=p9mw6X//BdBZ4mUDL3YSVDdYhEGZ7fqfbz8RaKr4rCmGh8/sm5ZwmNe95CNI4hG0un
         mEF3zWaK9e5eeRqh+mLlkV+wYbXV5UBR5J8nfAgyS1pjatV3j+wJVy5apkz8D0x7DIBP
         4QtDS5phfaJXmLavGEDrnReVqMGW74f6ulUsgjOL9aG0WjEDCuHG1t0WXf9rltw3FOhL
         OBi/XdNowJ18xgc5kEImREClKi2SwOSCi1TyDCU5i2WQIPzivZhnSKapVrW6Yo1yBNye
         3/lfblYb57Fv3OArPPF3Xz6fS9VPqXRI2tZfTR5e0V9L5opbads5bUiwlM9otz+t2kjv
         yQgQ==
X-Gm-Message-State: AOJu0YzpbJzJrWp4Zd1p2vMGyfgmpduTjCHoWZmzcRiZCtB7gbMlr+OQ
	YiHK33tq8m9zGSzZ0WbmgGWdtfSKV3CZtZL89dixcfQkiVD+eFlq8wS0OB+DW/kLTd8OBCtseCb
	QExuLNYMEgEmFULVTxO2XC1IP6SLwue0C8n1Q1ehXTBnKOby/nioIkjXqMcE=
X-Gm-Gg: ATEYQzyRV8YU4l3375rce0T5zWGzuSnoNcEAgIAHI0gnURXfkTCpGTu1GWobTmNR+VI
	sYSWbLfZXWiv/U3gtMj8NBfdsEMXSQ7wBshIkoqvLHhefR/uc4hkAipBq7JbOAYZrP8MAI5jX1w
	oQIfIzu6nf5qQ9KyHejv2TKktqLwOMjhH+wpLFFPyXd90UyHlTfAoWXHr6IXs2vrQn4Mu/+e1ZA
	v7wjjx5oz58itV83gUIT7ROO92cHPzadl1o1eCzuR52sRzvQEyhwA6227pHFSv2yL+7GREyCBz3
	3ow00zojE1O4vahlZ+HEfhKsVbhat9zYT8cc8MtTSL65PEKmfGeGrRsxZWP+mVJt17fqAKt9yPW
	5IcTp0FldTjij93iZPzSQ9vOzhfE8jpGQ0gxxarZ8ZQxtRiklxxDj9nw4Ck4rBxQiajKNRpRgQa
	Dz4X89f4uDXcZmuFOBrYx4aS+KjHkbVHfxXCY3088puPNMIUZvuyvA5KLv/g==
X-Received: by 2002:a17:90b:4b87:b0:35c:195e:112f with SMTP id 98e67ed59e1d1-35c229714ddmr12545211a91.18.1774853606350;
        Sun, 29 Mar 2026 23:53:26 -0700 (PDT)
Received: from LAPTOP-A2K1CSVQ.localdomain ([103.255.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d94d03e4esm6406103a91.3.2026.03.29.23.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 23:53:26 -0700 (PDT)
From: Smaran Jaianand <24070721037@sithyd.siu.edu.in>
To: git@vger.kernel.org
Cc: smaran-jaianand <24070721037@sithyd.siu.edu.in>
Subject: [GSoC PATCH v2] bugreport: clarify usage message purpose
Date: Mon, 30 Mar 2026 06:50:36 +0000
Message-ID: <20260330065053.76919-3-24070721037@sithyd.siu.edu.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330064454.76833-1-24070721037@sithyd.siu.edu.in>
References: <20260330064454.76833-1-24070721037@sithyd.siu.edu.in>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

From: smaran-jaianand <24070721037@sithyd.siu.edu.in>

v2: Fix spacing in usage message (add missing space and remove trailing whitespace).

Add a brief description of the bugreport command to improve
clarity of the usage message.

Signed-off-by: smaran-jaianand <24070721037@sithyd.siu.edu.in>
Signed-off-by: Smaran Jaianand <24070721037@sithyd.siu.edu.in>
---
 builtin/bugreport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index f78c3f2aed..6b1d1accb1 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -56,7 +56,8 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [(-o | --output-directory) <path>]\n"
+	N_("git bugreport - create a bug report with diagnostic information\n"
+           "              [(-o | --output-directory) <path>]\n"
 	   "              [(-s | --suffix) <format> | --no-suffix]\n"
 	   "              [--diagnose[=<mode>]]"),
 	NULL
-- 
2.43.0


-- 
* <https://www.facebook.com/symbiosis.official/>*  
<https://www.instagram.com/symbiosis.official/>  
<https://www.linkedin.com/school/symbiosis-international-university/>  
<https://x.com/symbiosistweets> 
 




**Disclaimer:* This email is 
governed by the Disclaimer Terms of SIU, which may be viewed at 
http://siu.edu.in/disclaimer.php <http://siu.edu.in/disclaimer.php>*


