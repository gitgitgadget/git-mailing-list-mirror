Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6339475
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764436965; cv=none; b=iy+3ySKDokhB1TpQqWc6b8e+TvB48mpyPuKdkedyqDioGAJWW8+O6vGu4X8BHwGkfEGFz0n2jX3rzsTR+GQ9muFj+UuxwcRqytrcI7/6RjCh4BmbGGvK7JsClRRJ1f/Qt9iDu8SdHs/JQXqseJjf7OhMh8Up/GDeJppgeOrd0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764436965; c=relaxed/simple;
	bh=6iKwjbcFNzsFmCy+KOhZLdYrKBq/smO5ZUAR9IzwcQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvNUTibD9+NGpmcNfaTVMCSbLLr1hdbkUhdyA9tEhLUZupLuTjouoZrWbFWabVpkCaQihVOgR759/eDwyvVQlt0vtW5y+CcwCDu6WuszgDmb8amkJFTSU9GUbMJM4aDNQ6/1WPH9nmrFzOOXMXx23Uc+KLRP8xIq0WsuBCBbbMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvjK0cTo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvjK0cTo"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6411f1c4b4fso359753a12.2
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 09:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764436952; x=1765041752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9fCpXWfardNead8UoXNoiBkvVoVaOz9UJlgjoUzkZE8=;
        b=XvjK0cTo0qs//mlPQbBmE8qL4+GZciKa6cwooOre2JSFqA4c6vuOco7JZlmX9PcAMt
         3pxkBL7T3+dnj0gi1TYwRCbx/YLH6R2ZrZAV0mvl9J202phQvjixApG57PrI3c+m0Jnr
         KBzrGuiDmXq+aEDfMgSyBHAIZCAiQxVVFEPJlDrtvTltZi9uKfokXrzahKxFtZ4XoGZW
         rde1Vvil5O3r3nNnU1fExk1tIAysCRW7FznYdkBDdEf79KwGejse3QTNoShL7sJQ6mLC
         E1Ojvq3DTkdixoi24MwscfyArCE/pfCDcMHLYKFAjC2Zp27Z87rCIzDYD0OFVUujf2wJ
         +7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764436952; x=1765041752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fCpXWfardNead8UoXNoiBkvVoVaOz9UJlgjoUzkZE8=;
        b=m8vNwt1Nlwd/Le+0mLJLEVikZKlc4n5bDiXPrEz+q7K24Bh4JQO/TGd7+RpeMfpUuC
         3+8sglkQ/LxWLIsbbT1ue1TuNI10j7/OdfhX2mXyAoxPo1pg6F3d9jPv8u7p5dT4l0vo
         u+XZTphRJcqmrH2vENB1ikzzov5Mgv1LtIjgOmQYQL4sSBO4C2BKpNxtIVCS2H+jye1f
         wEj5XZoPwWFs/0sy5UPttHxDH/kkmp0UaRlEWcPguyriz2MP6X5CUHGYBVVI53f5g40Z
         tL6wwKdSmQnuAxIODM0ov6Uc6wdVgZR0KYYWfvd+/BsftSHqgwDeJNgjSgAqmji4qBcp
         V4UA==
X-Gm-Message-State: AOJu0YzaNLRG2KGrYBL08iEFWTLX/ABm7wuJ9J2GIOReqnS3HnQRnHe0
	crO0I+wvMNDfut9p6fvJqf/uTSY2+ZIEkVOQ0eOISMIZXvwyxAAqODU7sr0pVM3Yxxk=
X-Gm-Gg: ASbGnct+SDYWqJdpn18Oeyuz82AH1yyl4A3cbexN7vTpU1hMcRcGs/ZTlGFMoLMAAHr
	LBAOhci71fjzdD8jwhF2EoOHsUYODKtlB9P/7xrgPr8apMsQpNO5d65ahcbggGhUun9IqRwyQWp
	mRZPTVHHHWuT8vq7gchxuGrutCkjX+F/XxNqz4nAN4j5vboOoMQMqTcW7HnT8KQFkTnfiIjg+nx
	gFZb+pkAqg/magYHYwaZXxo/8o1ajmahZB7jS1pAC0+pSTwdtLiO2o7Y5U3t4GuhymlKB0cZ0Cd
	BwuhHmGuLIIjQC9YslA5B8TU4obkYzPt0KjRvymI7eG2JbQAbKyG7NLiUm6f9XzNCbbK6Pvotlk
	lskKeufNr5DwzrMdf3bkbwUblSen+RVyTXsCRc97WylEIamNGhH7hhCUKCceLOwtYgSaxTJk2WM
	+PJ1deZ/tqrd64Hjm+
X-Google-Smtp-Source: AGHT+IEGghoLGl0rLgrgKNw5FSuqHIBhqSMhdTv/lsmFSzmF4E57WCD3qnGaYJFLy3JtXOF5E0LU2Q==
X-Received: by 2002:a17:907:da4:b0:b41:873d:e215 with SMTP id a640c23a62f3a-b76715672a6mr2021632266b.1.1764436952261;
        Sat, 29 Nov 2025 09:22:32 -0800 (PST)
Received: from archP14s ([194.127.199.107])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a7afb4sm731056566b.70.2025.11.29.09.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 09:22:32 -0800 (PST)
Date: Sat, 29 Nov 2025 17:22:31 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Cc: Matthew Hughes <matthewhughes934@gmail.com>
Subject: [PATCH 2/2] config: document `gui.GCWarning`
Message-ID: <20251129172124.4164-3-matthewhughes934@gmail.com>
X-Mailer: git-send-email 2.51.0
References: <20251129172124.4164-1-matthewhughes934@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129172124.4164-1-matthewhughes934@gmail.com>

While investigating the config options set by `scalar` I noticed this
one wasn't documented.
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
2.51.0

