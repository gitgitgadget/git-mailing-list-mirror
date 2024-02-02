Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF802145341
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886318; cv=none; b=qQccb6wFuMLPzLN4DP0/uxeZfthvwNKcHoLbgGcDD4qXAcSoW8AiL/baAjCXUbILLihjYKWgDw1QevxG2Fi/8xcyv3N/240wrh3/ju32i8D5BJnC+nQ/YzBETMrB5Rbq9m7WFBqhcmrgdtwrsvo/hKiKm4iExyHkxqgx1gNDvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886318; c=relaxed/simple;
	bh=S6LJF9pEddCJOMZM5T5JZVJmkOLCyCRarjE0RNG0Utk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9swhWWQdzF88cJwCG3zbpB+WQ8ePktCEwTU3qIQjX3r2R4aFkS44ktGPYOd8p9oYAr3oSGWNosqpDyjBrBLz5Pieqej/8NT9bRPvO1cr31dUdbk+mHHm28FRn5tCQVtpmXtZaLlSqz5pRnQvmB9G9JjgTW98BtwwnDg3OIsGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShuMLyYf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShuMLyYf"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7858a469aso16819695ad.2
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 07:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706886316; x=1707491116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNURAQ3QnbcxdBHn+rrJX0/DQoMdPfLL6WiXZ8rwlyw=;
        b=ShuMLyYf0ndidempRSambtM153GfB3+iWoLLTv1EnEUS0iNt6CUgzxE/9cGjuwoi4e
         NhNfg6MJvqU+9XcO4IkAwZ54Lz3uUTwX+UFX/ZjaUPOUPwd6cI9V1TAU9X+0JUSLc62p
         3UcjBS6G2tvl+4r9ldtqj6A4w/ViZZtnR9wLrY+VOZ8/llKOnIAAIAa5+vSb0aZgrotj
         OfUjv2B/FK1IrVxTcatb6emq8qsE9bKoqV/m8oeQIBw4f4kAm9FZ1VCDlyMfdYagWp6T
         BxPXi+eXrlxgpsMhlgOrli3OArpNR9w8ZTGpumokcPMBIGtyhf8qtNh31UFBGJ0ac5bR
         KhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706886316; x=1707491116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNURAQ3QnbcxdBHn+rrJX0/DQoMdPfLL6WiXZ8rwlyw=;
        b=Sg5gncnMTxGs/0Yg2D33if4DLaMZlG2bgMxMoLsKl10yG5mQmzbWO8mb/+vVH08MQQ
         9ziQfXEnycm897z8MddYAiDZbwzlJxg+AbJXiH0QKyvFbsYsLwxz+N+09LUcCJl6h44c
         3lU7yAvtPwMcPkff0jUq56epPF3lSZZ7znyQDgkbsy6EBalu1z6W7NkAfzzNBUSUBVIt
         QrOjvYcjKYx1B8121M11V7dnY0+pM/p6VGHcaCZnxTGM7qn/uWAx49xiz79QSH2pukMt
         /r8RBVQfECvtJnBTxi+ODipIFIZeuj/GQ3YC93hlb1Rg8EzbmcNZjdVsOl4V6o01HmbD
         mE7g==
X-Gm-Message-State: AOJu0Ywanx9dTiapjnoxeQap9McPmRGYwdThBC8Rp0wnurGwC7ILGV70
	hr3gn3lkdrMdGUrEm67+e+q2x2oFFsphdXxNFc1FtOXSno5zlL6ADRE0pxnZOJo=
X-Google-Smtp-Source: AGHT+IFZPmezs3cKIGF1HY2vh+U4fmMgxwUePsm62m6x/hDUZrc+j2zDjhwo7bBCoredh6whrelJ0Q==
X-Received: by 2002:a17:902:e748:b0:1d9:61ef:187e with SMTP id p8-20020a170902e74800b001d961ef187emr5150459plf.23.1706886315466;
        Fri, 02 Feb 2024 07:05:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWw4tujl2pLLq+og6TRc3PkNTVYLooCv6FKaeVQA/E6oRgCueE7MQIp3amXrKbwZnDKCPp+uJC3nqwmORqfwqaRxQcqWXQjYmuxZat2xCs/kKlZk/Y=
Received: from localhost.localdomain ([14.139.110.146])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001d9620dd3fdsm1685423pls.206.2024.02.02.07.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:05:15 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v2 0/2] add-patch: Support '@' as a synonym for 'HEAD'
Date: Fri,  2 Feb 2024 20:33:48 +0530
Message-ID: <20240202150434.11256-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128181202.986753-2-shyamthakkar001@gmail.com>
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series removes a non-relevant NEEDSWORK comment and addresses
disparity between '@' and 'HEAD' in patch mode for (checkout, restore,
reset) commands.

The removal of the NEEDSWORK comment and the '@' support are split into
different patches because the former is still up for discussion. And if
it is decided against, the NEEDSWORK comment can still go as it would not
be the desired solution anyway (described in the commit message).

Ghanshyam Thakkar (2):
  add-patch: remove unnecessary NEEDSWORK comment
  add-patch: classify '@' as a synonym for 'HEAD'

 add-patch.c               | 19 +++++++---------
 builtin/checkout.c        | 11 +++++-----
 t/t2016-checkout-patch.sh | 46 ++++++++++++++++++++++-----------------
 t/t2071-restore-patch.sh  | 18 +++++++++------
 t/t7105-reset-patch.sh    | 10 +++++++++
 5 files changed, 61 insertions(+), 43 deletions(-)

-- 
2.43.0

