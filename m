Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27713187859
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087430; cv=none; b=sH+qekWHry0/XGeV+fUeq/5CEACvG8xp2x8WvGI99httIv0jzIAPS1hy98uJjeivnIat8DyLmuw3FIw23Si104DEVUiq/zNjVW1z8Hz5P517Y2tWT632Csr5e+/sIUu1AchHDzRZRRb8J0GOA/TG+bwVmvG3fS2Fmjn8wkzBW3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087430; c=relaxed/simple;
	bh=g+P000lnwdkAcKAqGLnWodm4n9Jz8YjwtOwVUhM/wkQ=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=E/ZHcE7C0yqHulp/4mF35pPh96G+BaNFa2vMtFm2uikzEZ4PTfSIzJ1TxKk+ErVutBhIh41q+ntY1zXOKwZYSXdAe5t5zmV5oVmqHnn28/Buh51zB+H+uECPw3YoMiNAzqv9FKKa0F5XUayT8TF3skoZSOIOspSI1TXu1HwPCxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIqYOmeV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIqYOmeV"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-710ffaf921fso2951379b3a.1
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724087428; x=1724692228; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+P000lnwdkAcKAqGLnWodm4n9Jz8YjwtOwVUhM/wkQ=;
        b=YIqYOmeVtulzYZUmib2i3A0Bkq0t2+qUhfOsgxvLrmJOgkwKIedKKFegXDVwSPv8oe
         Gkbe+rz/gEV5TjWwM06sL4scDo76WUOPMQitAoCDnee0tpDIFBHZKJhDUSDJGwaj3hS2
         D0EuIiVTGWVuKrlAMzs74fbOS4hG5qmOnOY4SRKBa6i3LPIKcAVdy/G5g1FeAfKDj2QV
         AoPdIfvk7smbvNUwlsJFcT0Ai9icxbNa8JgKhE0uoNa2ETNY+eH7LQHEVyVA7VQQKrmm
         G/bR2AOseSDmupXpR5R53l8qhSob7R5t9CDUtbrLK6FURs/EdswqqMeIIIkV2j9byoBG
         VBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724087428; x=1724692228;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g+P000lnwdkAcKAqGLnWodm4n9Jz8YjwtOwVUhM/wkQ=;
        b=emr7tJB8E8FK6GpbPk3Kh85/ASgWi8erWXTSoKm2Xq+l7em9TSFWPeeVUa0b45gxPU
         p8MlPo975JrqASrjHLCp1iZqNEHanNEfjaZHHX2uOn8fsBzyUegkg+wUjsFCz0jJeI/c
         FgS+jlrPWgLjhchNviAc4IRAvwSGxQKqWQzWem1D/CTdz0jdYC3oftq2PwLLaxrucGMr
         iCEu5TuEcp7n1Ien8LAw1bSnHmp34m7LE+J3sJzEIit/bpv9K0AtFNm9u8M4D2Y7FIlk
         K9Z7KkflLGYnQDxSYZz6pxamSyWzYYKuuWGC4YpWaMNJA0kkJtO6c+umJCnAlm7/fusL
         zwlA==
X-Forwarded-Encrypted: i=1; AJvYcCUW/zx8FPaFCCIWMxV9DVAeIxOX1P5KaZXSBJ1wpSFRdKiHgFYhzQBcjaPFs9MF0QQyEReN1L0Rz89AIiOOFSb2g3HL
X-Gm-Message-State: AOJu0Yz33FLnHPce/q7f3hVm7YD6bL/CTmjdxw5nm1BTGSSxdFBYNiUV
	1IUYmR/+ZykHNeuMrgVbzQA5ioacW9jW7+aUyQJvLgvFZwlxU1IJIvR/apHm
X-Google-Smtp-Source: AGHT+IEmMn74fnFd/VzrB1rbHh01DQUjikcr9Hh3DPLwzCc1A4j4aSaCgiQqBMz+bNGRgt4l6yiErQ==
X-Received: by 2002:a05:6a00:1392:b0:70b:5368:a212 with SMTP id d2e1a72fcca58-7140831680dmr316811b3a.15.1724087428028;
        Mon, 19 Aug 2024 10:10:28 -0700 (PDT)
Received: from smtpclient.apple ([117.20.113.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add6d82sm7033356b3a.10.2024.08.19.10.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 10:10:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: khmer song and funny clip 855 <limeangkonkhmer@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: [RFC/PATCH] Add fetch.updateHead option
Message-Id: <7AB823CA-2E45-4BF7-BE83-AEEE24BF4BDC@gmail.com>
Date: Tue, 20 Aug 2024 00:10:24 +0700
Cc: dominik.salvet@gmail.com, git@vger.kernel.org, gitster@pobox.com,
 jrnieder@gmail.com, peff@peff.net
To: felipe.contreras@gmail.com
X-Mailer: iPhone Mail (19H386)

=EF=BB=BFHi

Sent from my iPhone
