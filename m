Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA57063103
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105070; cv=none; b=e0P3QwxgmY//eA19zMtWzNjQfU8Luq/23YNTHeC/UhsRI3DHaUA6S0/CD/bHankxKRzeNXWf8jkZlyDUekQ5zqFyY2R29tBPxjLRUh1Ygz/weW8+cEBquicoi5IrebT+lmfYyXTNcWR96SpqsvZsiaVSiEybMDo0Ch8LuEPhzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105070; c=relaxed/simple;
	bh=2IcRwH/oBzPXKAKLG8G88KYyTy43V9aEIHz/xtlXkaE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VVkym1sjXVQDsAS2qOXpGoVF/KwUOGrfTJS8wdPD5x8ADvUNb+vx0SwJzomDOXtkUf4ubvfk3s5fiSOG7GOm0GN8ZahRyK2DGVt/mQpiOVdfVn6N6GrRCoydSljbuxOEBaiCTJZaWaBXrtf4jeG0jjYQTAanUP41lfeFi6wiJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIWwk0sn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIWwk0sn"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e775695c6so53541835e9.3
        for <git@vger.kernel.org>; Wed, 24 Jan 2024 06:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706105066; x=1706709866; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6rpVJZcOemDPFb1bXG8uxeF8iNYfcZ6iR2n1yPzgUk=;
        b=CIWwk0sn3ZfzK6KX117sPFqutZFL/nWTIwj/M+c+rSCR+9y3PimXGWk53lsmj9EPGq
         0WOdZvOVjjRIe2dwWjPCK2UTdUtV1oJbu9lcLlMu7H0gREKzxb1qUQwmPHk3q0TY2rts
         dyv3aCwIIj5U+Uaehm9aZxFDZlq2cQ3qe5WTNhmEKuGwQphcUKyJScdmpFHyJ1cZMHmD
         Lepem9GCJxCKZzS7gVqhdJ+pj+aW6gDQ9ETY9fp2YLGeUCKVOEa9iN7POUTjlcYXQ+LN
         WJ6uT5QBkVNt4i2K80Ly2PBVBd26m7JJlgYlNtQgb/gTwdjN88k7f13vAujFMnmyzec+
         L4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706105066; x=1706709866;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6rpVJZcOemDPFb1bXG8uxeF8iNYfcZ6iR2n1yPzgUk=;
        b=pBeQmxltJO1Dnl5cUgrYGNeMG13wuzEwecVUnjF8xXQykalCpxlSMtSUlenh6ro8vY
         P1SN5EoEDHC1G/7GAOp7wHd2gHuEz/ZG2u+t7TwgRG7K44QNb1cNNfvgnRtG8j8TRqfP
         xJh1mGtvyfptCoqSa84nRvzIAalqTateuSmy2GELLIL/9KAkJLO7DeAoGyAloDl3DkVo
         rHxm7WmNnNcCGYsLafedRxd7mSNdHkr9oZrn9UeCkH7TRSGeZbj3k9iuCngWekpLyQtr
         kBpfabRZwH4ZEBlOkfHD3cpfawTDIEmjFQ5bZMRNzCQTpv0g+aYb0A7JL+uaJg/QpiDY
         hF9g==
X-Gm-Message-State: AOJu0Yz/f6I1Coo6cO9DiRiusJcgyfC+vK7oD56a4Ku0rESOMY3Oyfjy
	hMzrUrUcwqQAkXH9z6F+656PN9Nhu9qF7ZbfEtnZsov/dSSm+IplCqiAyTDC
X-Google-Smtp-Source: AGHT+IEqmXz+C2AqD7gdpuq4DbElZQfUOtu743xf7x2Uoo6o8H23xBZzGszmwNR1BzvM9Bj3QXIX6Q==
X-Received: by 2002:a05:600c:500f:b0:40e:3889:84f3 with SMTP id n15-20020a05600c500f00b0040e388984f3mr1689455wmr.94.1706105066235;
        Wed, 24 Jan 2024 06:04:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b0040e76b60235sm34842300wmq.8.2024.01.24.06.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:04:25 -0800 (PST)
Message-ID: <a7c81f7e114fc8854436e2ca1fccb4c968653317.1706105064.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1653.git.git.1706105064.gitgitgadget@gmail.com>
References: <pull.1653.git.git.1706105064.gitgitgadget@gmail.com>
From: "Md Isfarul Haque via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 14:04:24 +0000
Subject: [PATCH 2/2] FIX memory leak in one branch
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Md Isfarul Haque <isfarul.876@gmail.com>,
    Md Isfarul Haque <isfarul.876@gmail.com>

From: Md Isfarul Haque <isfarul.876@gmail.com>

Signed-off-by: Md Isfarul Haque <isfarul.876@gmail.com>
---
 diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/diff.c b/diff.c
index e3223b8ce5b..9fa00103a6b 100644
--- a/diff.c
+++ b/diff.c
@@ -2309,6 +2309,7 @@ const struct strbuf *diff_line_prefix_buf(struct diff_options *opt)
 		msgbuf->alloc = 1;
 	}
 	else {
+		free(msgbuf);
 		msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
 	}
 	return msgbuf;
-- 
gitgitgadget
