Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10F32A8D7
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235893; cv=none; b=FNNO81/OZgm7PiuUyRp5X2sH2hFNskjjydTvEEyjhO+57JS5cq23d/WRycmPDAWIx+DElx4PDeeePiStWeysS1bUbV9OWeau6rNUsjM9tyEl9/qu4oCBjU67FKCxmlCpxEkfq+dEF/ALLT9PIyMe624b+COgiOy/DvIbB7MMNzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235893; c=relaxed/simple;
	bh=EHJIrAUzGzPJZTAombx759gtFk4Jkg4sepJQkr51mL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V34CzFNXGlU42exn2nyhhit1K3OYdMpKskZ6Mhf8XwlDtVOG2LJNDUOdeF9+qbZbV1IPXzFv+cCCs1HcLjRNC+j0RYpNWRaf8KyzTvJc5pJhM6IbrrWesy4OgcBp0rvvEm3zBAz8LgUlr8mR3kRQaiS+TwGD/1eiP945Yln1X34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iprJ1Dvm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iprJ1Dvm"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3e7f7b3d95so199098666b.3
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 11:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709235889; x=1709840689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo8bWHg5dNEHK/3aJCdyg5kVpPoI9Pp2tfTo/eoQ5fE=;
        b=iprJ1DvmQa/fD30mnuhM1lGX/EOF//jOfyrPecx0rzOU2J5ulqEEHMsVgzsS93Viyo
         YNWIIB2pTfTbCRWImtU/r5GYng43Poh9QGF0QVMYzHXSQKtWtimhgZ7duNxAsXet4E8q
         b/sjJEWRqj1k1wTmEJ+JIiOGtie4ii1YCeQ3Lvu5eFNYRWyNZWMk0Dhq9rtvQOvNCVbC
         k6MphbGYy3IAytC8BIEVtbse8zhw0VB32a73bKj09q1ogaFfly7jjSwfOXWIRvJLMPqh
         xYPrsjAJpgLIFK4c11yoqHKKscja/KPezdxWKT1CupkNHAi8dGBWDDeV9mBrxECbxuS6
         GtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709235889; x=1709840689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zo8bWHg5dNEHK/3aJCdyg5kVpPoI9Pp2tfTo/eoQ5fE=;
        b=qQljJw5V3fNFugxur7SFiixrHpTY6TyDaUwCB88tgT9pLo8tUIfyHpmCjywsglDeuy
         r6B1J6VvNEHJBUfDb03NLqpAncWh9gdXj33aWEp6dWHBn9Hso7uoooveJ+WAdFhW6QTz
         dzf1eTAhAxWKb39ZtS3LBosXAO+oA03ucoj7g9c1LGDADR+kJJux9Ljbx+7y/DQc4lKX
         DYOQoPbYBM9Szb/mRqqgNZUtKTnds0iGC97LmJRQpq9KhMd4yYc+/Yqnx4Uv7l/VCOpm
         cHhzeEKwS6uXErastrhREc6ECKhfzHrzN+gvlHmNwRV68wbnUqtgUdBfDN6r9zDr/nYA
         gGPA==
X-Forwarded-Encrypted: i=1; AJvYcCUS5XTflvNpenBzqP+mwVu4rYFoMFm0CcJSLwumZUwb6dLU+P1g631ePLMsw81gqvY6BlYntIjpzLNosjFRG2PoHrDT
X-Gm-Message-State: AOJu0YwG3yuIa8phbyyMbf8K6IXiohUQerbPuBQmxs92c/Opgvs2yVSo
	Ild8iEQUd1n4FDrHzxV/tPNaIMPQnb7/Fb/p85fk6mEGzT/9AWnP
X-Google-Smtp-Source: AGHT+IE90kq49rZbpitlO/aI3gFjs2ePaXp7HBOggMqDbl8qxgL+lsCpdN9X/BFGW/57V+6hX3o0sg==
X-Received: by 2002:a17:906:a3d7:b0:a3e:590f:6348 with SMTP id ca23-20020a170906a3d700b00a3e590f6348mr1841724ejb.41.1709235889289;
        Thu, 29 Feb 2024 11:44:49 -0800 (PST)
Received: from eugenios-Air.homenet.telecomitalia.it.homenet.telecomitalia.it (host-95-235-237-78.retail.telecomitalia.it. [95.235.237.78])
        by smtp.gmail.com with ESMTPSA id tj7-20020a170907c24700b00a413d1eda4bsm978787ejc.87.2024.02.29.11.44.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Feb 2024 11:44:49 -0800 (PST)
From: Eugenio Gigante <giganteeugenio2@gmail.com>
To: gitster@pobox.com
Cc: christian.couder@gmail.com,
	giganteeugenio2@gmail.com,
	git@vger.kernel.org,
	sunshine@sunshineco.com
Subject: [GSoC][PATCH v2 0/1] Use unsigned integral type for collection of bits.
Date: Thu, 29 Feb 2024 20:44:43 +0100
Message-ID: <20240229194444.8499-1-giganteeugenio2@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqsf1ekf34.fsf@gitster.g>
References: <xmqqsf1ekf34.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the commit log message
based on reviewers feedback.

Eugenio Gigante (1):
  add: use unsigned type for collection of bits

 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 2a540e432fe5dff3cfa9d3bf7ca56db2ad12ebb9
-- 
2.43.0

