Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BEE1553B9
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080939; cv=none; b=Dc/ZBADz5rvrwTK1MovWkGUDG3VZ+54N7txApDLKT0fG3Tkl3y7khhWHPfVhRjDs55HdcZM11JH36h0qBjTOUQfZ4QwDoYhU+aPIj/QoXbEiFDID8YYdSqdMx2Tp83LUxrJ5CghY/JgSEOBlRQMG0X8PUHEMbBOMsELfjbTXOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080939; c=relaxed/simple;
	bh=GoVHPRZwGVZO+m+mlhp6h9ijgR7pfbiaZCfNobUlCTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YBfidQVrVEzeMijv8TYf93OfFy7oKdXv4dM4+WOA8CMvrSvM15plF2GOKyEWi57xpEUTs7mNUKId22uZX0xbtvuWE6Z4jHNB/YqMIxphx370VL9iXiUO2+66jJvQMO1mq9V9vgz0idmhNNW3RI7p+kJxu7NHpZq6yhE/f6lz6jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvaBVnLO; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvaBVnLO"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c7498041cfso890948b6e.2
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 14:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714080937; x=1714685737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYY+bEwvsKaerwjCQ+YdfbhsZtIYSqMEtmL8R7sAi9g=;
        b=XvaBVnLOZ/zb56Kav6BwOaft3M9Anw+hw0K8ZTlqblMVnWd4Um3qmHvEUmEDCwVK2Z
         +pkwPqf2ZbU8s6DvKw0aPRyF/uCIju3PRcDuT0weO5BGuxeuNfrMiD9/PxEtZsr5iGbX
         gwvqvaKh6+yvRSh2v3UXco7yNi9FtCD74OLxpBoJ/QSFYTSMlwsqp2Ml7f78tJV9VJTW
         St633ovVIlnAXA8Id1WmkSekEupdHexyjNRWblUrdQPLLtmEoAh9p99BqgLaM95jkQUh
         Uifw5+9jTh8xlDneDwNpP/mGIV6ZiPewllAwS2LpeCLH8crnSvWM9WtiMwQmfWAKnnt/
         g8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714080937; x=1714685737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYY+bEwvsKaerwjCQ+YdfbhsZtIYSqMEtmL8R7sAi9g=;
        b=gcVE4xH0/cRu9ZkI59k0qbXesUqnjH/vn7JaOksiTREvZLMUiPUMM04daDYaOJZ6ex
         E8onj31+we3GtctUeTeP8EpYx/2GSMvjezvWSACb/0lWN8wUTF+y0euvuJbbSZtJ71WG
         9Krsj/POByeqRexmLb5tzOSLvAn4M6XyWZTfm2vJ8pMzSeYV1qPgWPAz0b1SICpZ1xHB
         SqYN7yd3HZ0mFe1WKpWz9b4cmBWW1ygTGVbP+l6wWetpN44MaqSq8+DVnrQKDajVUhmx
         1AALpfQSz7nCoMaaD05uwS5ptBRskVBt+kBPxSqFiRrZcjX65JhLKEC0pDkTXg+vibnu
         AMkQ==
X-Gm-Message-State: AOJu0Yw2K0jmLfZVNyrvAiebwQzry2qMFnOGOO4EdyQTx84JaXx82hnQ
	ZevB8EHP0+tcmz/fdJCZ3AjFs/oxJhr55YtSsMZrVQFHJML1+nbHKu23wPEu
X-Google-Smtp-Source: AGHT+IFskLpkCqawevV6YSxTq0ewczNTheYGNYF7amla2nERgb5IqonBcV12RcQ7kXfKoaR5c9giLQ==
X-Received: by 2002:a54:4512:0:b0:3c8:2be2:7833 with SMTP id l18-20020a544512000000b003c82be27833mr1117027oil.37.1714080937294;
        Thu, 25 Apr 2024 14:35:37 -0700 (PDT)
Received: from denethor.localdomain ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id l16-20020aca1910000000b003c6f8cdce92sm2329234oii.13.2024.04.25.14.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 14:35:37 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH] doc: clarify practices for submitting updated patch versions
Date: Thu, 25 Apr 2024 16:34:04 -0500
Message-ID: <20240425213404.133660-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `SubmittingPatches` documentation briefly mentions that related
patches should be grouped together in their own e-mail thread. Expand on
this to explicitly state that updated versions of a patch series should
also follow this. Also provide add a link to existing documentation from
`MyFirstContribution` that provides detailed instructions on how to do
this via `git-send-email(1)`.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/SubmittingPatches | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c647c7e1b4..bc212836f9 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -415,10 +415,12 @@ e-mail tools, so that they may comment on specific portions of
 your code.  For this reason, each patch should be submitted
 "inline" in a separate message.
 
-Multiple related patches should be grouped into their own e-mail
-thread to help readers find all parts of the series.  To that end,
-send them as replies to either an additional "cover letter" message
-(see below), the first patch, or the respective preceding patch.
+All subsequent versions of a patch series and other related patches should be
+grouped into their own e-mail thread to help readers find all parts of the
+series.  To that end, send them as replies to either an additional "cover
+letter" message (see below), the first patch, or the respective preceding patch.
+Here is a link:MyFirstContribution.html#v2-git-send-email[step-by-step guide] on
+how to submit updated versions of a patch series.
 
 If your log message (including your name on the
 `Signed-off-by` trailer) is not writable in ASCII, make sure that

base-commit: e326e520101dcf43a0499c3adc2df7eca30add2d
-- 
2.44.0

