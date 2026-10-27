Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091049;
	b=5QQmI/lB5Pqkk9ZrgL7ps65OwS0Cb6gnFJDPqeAYI/rpLLMPUOeXiaR6QSbo627DlQM7
	 REVEgVeyu0ukfK/5UyMk9ajmSBmNK0laqZQ727TQOFe7ccjlifRIsokYhZr++NXR+2RdH
	 rlxeaXSFjT93hJtqXN1M5gdDrbjtsZE5m0Df0jOXkLO4+JxCqsK0z7A/ydFZMbEXjVZZu
	 2afj/cjcbkjxPAFpflLtMZuZ41G6hN1a9ZdTKHiJ1LpjWHrSMdD2SgmtNH00wR0Z2ar1X
	 ERv/zhj/nMTRZU4NdVKwIeTDJlWvLMFuuwFB2DLVCpWOOICtFQy4gJ30Ov65ZS8sLJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YwI+Rluca5THsYBpvCS0u1mTdWxbMONdMosTnYylJWo=;
	b=cRwr4MLQ/8Y0SNMSIppEFz2cX2oNLu6RXIeByrD9vccNqtukTjyLKEWcVd0CGzma96oT
	 VKrqYWUUhJDyM/kmsMuPjZpbh9uSbY3nKH1klZOp09T8da8uTDpPlmmVL2h0b8nU6nuIS
	 HmvRv8B9PPzmdd3aYbpAHCpIsxzsDBjAl6pF5QWqUcOaMDd5+pTNj7rgkw89G5ueS/P4S
	 0J50R8Vd3p9UkgDjFqdXpOVtCOd6Sm3dXhiQQKSzMUNL/uz8AriHqeqR4b4q3gw5FK0er
	 pqQPyvWyrbHo7nmrHaDtOA0rwYaCtxDmOceDgXXUyQ4QH3T6dvmxUbVnMWwfcDYyfsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RNG3cB+b;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F73606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77F73606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RNG3cB+b
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49d05d51553so26492405e9.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 01:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793091048; x=1793695848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YwI+Rluca5THsYBpvCS0u1mTdWxbMONdMosTnYylJWo=;
        b=RNG3cB+bb5OofBW/9kzlWeKObAg1Zx4p6hJPINcJbTruIW8x0qQBX7cBp5BERjy380
         hUFZJcEtQp1Ye9ZGzmzMFVCMJn7Y++DNoMhXTkoiCz+5FzeGRzh/FWiCIr6CiL+ND4ax
         vFRCFTF26m8r3Yy+4SV2+2IFVJtrTUr+AxgzwjCbZlvBelEwzfCyPgSkcFAiiZLpBQCG
         Hss5M9UzZb9ei8Vc7IdTPTRZUQYi0Pj+Sds8TsZg14y2stpsHw/QCm6/cUTpdZ8f9Hdj
         NRBuzOYQ+ycgFJz5wH4IpO6ANx3RejrVTkBp3Qck6pPAnSjvyKDhhno9tgjiEUDVKLzb
         Gfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793091048; x=1793695848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YwI+Rluca5THsYBpvCS0u1mTdWxbMONdMosTnYylJWo=;
        b=LkkjcBN6mk+r7F1LHj+f+qOhoqdA7NSk+CC8DF94F2j0bvGPo4/gLywIxQmAvHNkDk
         dYCEEc7NFI7FfjgFh635A9AZYtCz5hn8fHE4/+AY/6pethsK7OrdGPmDQZWMP/gpVFU8
         Xtqu/SF5p+z3ASXZNBYUJRUfdMOt2xj76R0XXmvOFnR9oku5mNH0AvpIZpMwzWeZOUh0
         MHIJs2JZZS0WLGZAwejnbwUBGI9sthWPf+r1AUJ68Oi9cFXxOocpio+nZFvu1S0nQaDX
         8dbKVnI9UXV0c6FkIRQV+GYCW3xrH15NKHR+Fc6oBmomt+gBcc0H1iQuSGh+36hsMwlS
         L/Ag==
X-Forwarded-Encrypted: i=1; AKwUvBxC/N/kpR4JPFlMkzFlIwxYRndkukX5N/wawsoMIaTtEwvZnHdhq2aaG1phFy2BkyZ3ZzU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhWNlY2VO+4bppelQsKDL02N/HCKav9FCSd3UpFDOfYeYwzAqH
	vzbi2IR+NEJbuoKUsJb410szjlnz6O9qbgqCpLoj/ma7dIx2nRqS/PPw
X-Gm-Gg: AYBFou034sNk5Lffvmwmt+KfwC7GRH1NXwnsOJBHeTf7+ExIhV7jBbVKw6/QDxx3oNF
	mThQvDP7ven7Pm6F6KN3YbDsfPrksGEJIL4+K67EoryYUU4OXiKlXLhQHdgMzYsxgpfD8YDz1zP
	liDPdopEk6j3rJA7rWAHAOYduU+twR3RdPJlZ0Ht0o0Xr+eUi+sADmEDSMwy9pCBJ06PsxRl2jh
	V1Amtt7C1IEhQi2m02qX6dGCuk9+y4onGcdpbNSZ/yjI6kMmH/WpVqzKCFMARJpaXOIRm93PU0D
	UEPX/3T7uY2iwLF6R6kQ7A+ExKOehPevxzPrP8xsspBOCLZtQGEyFvgwHa9mojSzQO61UsrjHHC
	2fesdRHIXsjY9mw9EjW35jhBw4kXtDSIXEBmvZKKXhzXMQBQ9izP1YmTYvT9nAg4QUi1/HVhedy
	w192SU69iRm8RqS3vsDISKMmA4Mg/DcespFlS1EKYasoF52MJBNN/l6RyHoKpHxzhXEVmAZIJtL
	vPBt89lVy4EzNO1IRDMn5SOpwyMNlxr7NAqx0HgJbKR7h3eD+2Zp9QUyQo8lFuWQqDJdjDesvL8
	eAWU
X-Received: by 2002:a05:600c:198e:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4a35accbed4mr167675005e9.33.1793091047365;
        Tue, 27 Oct 2026 01:50:47 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fbc718sm212213085e9.2.2026.10.27.01.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:50:46 -0700 (PDT)
From: kerylefondji7@gmail.com
To: gitster@pobox.com
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH v7 1/1] archive-zip: replace _() with Q_() in path too long error
Date: Tue, 27 Oct 2026 09:50:42 +0100
Message-ID: <20261027085042.7150-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026192803.1985-2-kerylefondji7@gmail.com>
References: <20261026192803.1985-2-kerylefondji7@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Junio,

Thank you for your feedback on v7.

Just to be completely sure I understood correctly: regarding your note
about updating "SHA1" to "object name" being outside the scope of this
patch, does this mean my current work on this patch is finished,
or is there any additional change expected from me?

Thank you,
Keryle
