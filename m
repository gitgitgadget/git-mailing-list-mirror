Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9B3AA187
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521185; cv=none; b=FcPlHPUCTCjhD+mnoflFHuQzivLk5gYuLIGUB8A0IhPL6oZBhbJoFePzJRz9WgkXaSLQQyrj/4yuJ1pxeMAQiizQd0wtTDvZK64r6ShTJIoTzSh5ax+3BWsVsGTgnEm/Zvn8k1UUNpaA836jKKSKGxOe16pFVn71bnb2pS+swKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521185; c=relaxed/simple;
	bh=CqzCJr/bYKQK7yz1Oqcth+9qT1z2kwrv7jBHJzzfJ8Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YUz57dKhKT+7wYN/UjZFJHE/QWBkzzSOtU1uKw7OL7K0N/PRgA4UKU0oD9m8GAUw7cyWHmXLRm0QnhkOtGw+LAgCwMDBm4dKo8V6wz7/DE809Q+Eqwaz+WVI5SLgurY7KYMGBbIVnY0PIgYhMpSUwJOwRFzBAsFq/8h52fv+wHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmDCJ71A; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmDCJ71A"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caf228a910so5894625ad.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 00:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521179; x=1787125979; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fiS3MKZxNfuXjpb0BW138Jso6uNlgcMNEe66vqL2lLA=;
        b=lmDCJ71Al3m1NNYX/lPwIB9aFkf8HsmUOVj3OqZim3QEP2YmNjgmIVYMeAGUnxAkd0
         zt6GIoHhZ9fOrSQGlyHBBlwb/2oC40seUXMAqhlkm1ihOJnND5h7NmeLcwEJnBHPJ/BR
         L3HL/Nu9dPtb5AGhepLqJkHPy+hExrKsZ3GkMq9iPmnj//+8jFvCQebtfQ4tCtpg/cy8
         pE9/Fdh3acMlTRpYKNTbb6TF0T78utX4E077z2aFgTegF77/mKBpkqFfnJofVstXRUr3
         oAYkOm4m8WSDnyO/yb2ymB5dkUVSCbaWsa3khWlh2Tv1AWZ9KJDKX+744c8X24DgqLlp
         gxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521179; x=1787125979;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fiS3MKZxNfuXjpb0BW138Jso6uNlgcMNEe66vqL2lLA=;
        b=L2LQBl7NDaUpAh3cFIsWBTd4dL02JPfGTzemlROnFW5kaI4wFNozCpxYf28xAMRCcf
         MjdXu3tdROBoLRfDq8pzhazhu7VewU2Tr6b3jcQ56PKXZ3DBA9PlboVeccuQkq/yxp5P
         0R0iSMj4GpimT0uwcxCVzalY/DP4DdXWI2Vu/rUJXt0qN7NnQTdDDwMg58pT12C6JSrL
         x9gTt8ex1rw5Aoc30s0TjnYaPvU8Qsf+jkeJcsV+UZ1v+Y89MiUJg0yCnIEdPvE958FC
         UvHH2gIud8w4d2LmS2WxXeb0RUfwemNC+ba+1QiKm/hmgP4WggsJxdNbpnPwiJTmAAb/
         /GMQ==
X-Gm-Message-State: AOJu0Yx4KHZuhwWq9PxxIu2kXHZEikte0ANzjnci0uavtb3e8gcqmyCc
	wyXYqxkbl25MPiJt2i4SR36zdXYCON2lIdoMOX/YYZzobl0hyI5Enc0r+OvyLw==
X-Gm-Gg: AR+sD11myQf4gIecTo31CIZzmvgQA9pOHGZYQZohvNYrCk8NiyaStcphBWFn6JtE6yy
	SHO8o0kV+uc2rmIqnehf2N4a6POBWIMmQDmX4zv8mh6Mh8uX5cKZ2pBzSgRMyP3PoBQinVFGcFf
	xuN3ETUUX8BJNjFejEMZBroSc6sWS4F2n2dh1ruFccYUlpcP938D1bbX6tXI06YIXMcfQCBaoeL
	rbNDHUWoc8RQfcg7tMmtyO0JXA+ORnR0VxdM3CSGkRGJuRmJVC8MY/KJvMCUVukAwUGNNQcTxt0
	c0XykiquxuO1YIArki0H3ddmk2lE9/CVZVfxVw9H+ZH9dEYSd1NbP37vyw1/2T0aEBti6clv4QJ
	yup5PmYESyoEBWJecHLn/GR7QB1n32KM7+ZU1ZBOfUHqelH5P66HyvgjPeIOEuV/PQ43tgcGjWm
	Xy1XaGz6gZxMSIbWgfToUAhRHz1ghi7ycRYIfvm2PSgQjyWVuvIFZmSFNXEmtsrNCE
X-Received: by 2002:a17:903:38cc:b0:2d0:4021:bb6b with SMTP id d9443c01a7336-2d3450e1acdmr37304165ad.0.1786521178553;
        Wed, 12 Aug 2026 00:52:58 -0700 (PDT)
Received: from [127.0.0.1] ([20.184.150.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d352230e9csm2801365ad.77.2026.08.12.00.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:52:58 -0700 (PDT)
Message-Id: <47fc97458247529f9d2205cd7c0bdf5125ad8832.1786521173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 07:52:42 +0000
Subject: [PATCH v2 02/12] mingw: stop hard-coding `CC = gcc`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is no longer true in general, not with supporting Clang out of the
box.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 8dd8acfaa5..a464b2009c 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -771,7 +771,6 @@ ifeq ($(uname_S),MINGW)
 		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS += -Wl,--large-address-aware
         endif
-	CC = gcc
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
 	EXTLIBS += -lntdll
-- 
gitgitgadget

