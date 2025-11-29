Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65E721770B
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764441204; cv=none; b=TGuDB2fg0XmgMTVL/Bu4grqyPoRj9b6WY65/HdyjAJZINXdJIk0c9ur3sca6OkWAEFHcbviglG/BXbdk+N0BKUEuyjpPr5VHrOjeCJUqNIKM94QgFQ7iAVyJvxpTybZPmjyCGa5+yndmZnYnXu+Xg+85/+kAe4ea4wUnd2tvGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764441204; c=relaxed/simple;
	bh=7iRZ/PyTpzwwPQyLFu46+QT+1edlu9mMj7GVhAp1Dpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTJFM8gsR2RaKBO2BWWIp6+2GTPAnGf/64m/REpL0cq62xwpPePWLrGPKKoiDonnm/zinl6AeROA7IOQFLkh5qQTQRsxFGhkhCuLeFePpW4JCdjUb4WtzGBaZoyBrHPxYXOUz9XOx3RUBTc7wXuLqd+0JFBUxhXVGgoMN46PbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/SfTK0K; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/SfTK0K"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b2de74838so162109f8f.2
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 10:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764441201; x=1765046001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=62pAgPW74xmYsSsM4uMD6LWnt7XIaAEb3bUGwPvPqNY=;
        b=V/SfTK0K9tgEkAMaTwTn2fjvD0zEq7Xcmb6Bo+Fpd0vIGLn2gAkUG4jCpJbBzCYu06
         BThXcM8g5u/kjcl/vdkmosRiIlegm1CNyYexMznE4SYsDQn7Kmu5e71bOJUXue2SH6A6
         Z618+KbY1IJs/rsEsT+LGHAGxarJcvlBrWeIuvMXnKWO1BS0tDBaq7N2gHG2lT5nvDDd
         cBRXpvw2KuyClGuE0KN9HVw99xE12arYkf5SqVXA05m1UB3FY5VPVDBIGX+4MSxCxUIw
         rqTGhx5nc3rKEuCuEaOKSNKPKiCFbR4AnM6LuUgYK+r8Ne1GY+wWe+be5Jjw56WDQzHH
         uR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764441201; x=1765046001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62pAgPW74xmYsSsM4uMD6LWnt7XIaAEb3bUGwPvPqNY=;
        b=bzH+3hj1z8ejkM+rzAULkLx4bYUTupuQEmLmWO9r6Rbs1VTrSSv7IH6CfnnUnTXJsB
         5jUIOjbZN+3dBMTzndvsaQlnL/maJRSXPsbsYnjFZxxJaUuwZN77L/HuRHoPHIGeO+O2
         Q3TxQbpd9hkzKtb6GYI5dFMyVYUEskqP3qgOfH2naxGVX4azjELr0d1a30R8/B5i9wL7
         mOzzh87t+wIMCjGLrh02RG0wLrQsgH6zpdaTf3pXVm2KxgCtJ10pTWizF8o1RssEA5Hj
         jJyxRl3quR4Kg+JimgKHvxhm/6EkDKkptR4oswjouuWzXwQ55cpFUoi9w0E4Dxl5lD9m
         hZTg==
X-Gm-Message-State: AOJu0Ywf0GL9f51bGwRicnnp7dQfa1EUuYtYq0iUy95Tf06oPJDki2yg
	gLL6Zj7W6jxhg6xufWjh8Cm1nvy94kwMqjjsGMqnFfOWdMOshG+Bp/M/P8S9IjCns+M=
X-Gm-Gg: ASbGnctqRR8umjFAAmELCxxzFPCRR324IFkXLwBhg2gvu1M5ekDR+zYNs6TyeA/MFls
	D8n5QigLLmkmma+NdP5xaNpKnjJ49KcSHtIgnMNALlOZEMeJ8rgABWZHX3NSqwDBqMs5ZhRfYdQ
	/BAGgC4p9ADq1s50NgKMXuHprs1b3eFQBy5p1MfZK4QyhFhYlvct7g37fYltUpITKxvBHCW1k37
	EHTMoO1MviV1yJoFZwSYKBhorsgD9Nz4ULe/hya2ZhhdRUEUqyxM7Qr/RTaU39K223j+S2iJyUr
	E3RGVfyGvVLdLoF1KO6kAXJTtMtFC5QpLUmLYagZ/wJGdOmiG9G9F31zZRxjom0mOCg8KKZhVEk
	fSOpRtHTWPrcf0cnr9/xSuWiUuEaZry6RuodiAB+j1PePXvtsxDuyyv+h3fPoTBMKYjPabRISf1
	zR48Im0JzrLEAqWQ==
X-Google-Smtp-Source: AGHT+IHkpUJgvP8kVGDsrRnYH6mFFvpQM6LLkd1TrkC29IrliC+1xKFvmvspHuQAc5KXYmkYKZsklg==
X-Received: by 2002:a05:6000:240c:b0:429:bde0:1da8 with SMTP id ffacd0b85a97d-42cc3fdf636mr18565988f8f.7.1764441200805;
        Sat, 29 Nov 2025 10:33:20 -0800 (PST)
Received: from desktop ([194.127.199.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca8e00fsm16579377f8f.34.2025.11.29.10.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 10:33:20 -0800 (PST)
Date: Sat, 29 Nov 2025 18:33:19 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Cc: Matthew Hughes <matthewhughes934@gmail.com>
Subject: [PATCH v2 2/2] config: document `gui.GCWarning`
Message-ID: <20251129183236.52760-3-matthewhughes934@gmail.com>
X-Mailer: git-send-email 2.52.0
References: <20251129183236.52760-1-matthewhughes934@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129183236.52760-1-matthewhughes934@gmail.com>

While investigating the config options set by `scalar` I noticed this
one wasn't documented.

Signed-off-by: Matthew Hughes <matthewhughes934@gmail.com>
---
 Documentation/config/gui.adoc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/config/gui.adoc b/Documentation/config/gui.adoc
index 171be774d2..3323ff9b7e 100644
--- a/Documentation/config/gui.adoc
+++ b/Documentation/config/gui.adoc
@@ -55,3 +55,8 @@ gui.blamehistoryctx::
 	linkgit:gitk[1] for the selected commit, when the `Show History
 	Context` menu item is invoked from 'git gui blame'. If this
 	variable is set to zero, the whole history is shown.
+
+gui.GCWarning:
+	Determines whether linkgit:git-gui[1] should prompt for garbage
+	collection when git detects a large number of loose objects in
+	the repository. The default value is "true".
-- 
2.52.0

