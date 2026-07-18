Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC12DECDE
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784367432; cv=pass; b=hpc1S8sRH8Qc2TffCnGmTzma+ytyKr3yU4U22U4JXyglBjPiQr9qxP7nVCRSys2vLMHfCsT95boen50qfGDcqJqptw/CEnMBWuaO4RYuGdLXoAQpSMACQHF2YIV4/3sRy3Kg5OVVZj9oK8t/jsp7VWRL5gccfVXtaCYgk4FUZCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784367432; c=relaxed/simple;
	bh=2YfLsRS5DTsz/QTjyBGDlfcpvV8eMK7SBadFauje3oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfIZ/TaJxCkqBD69OsZNtUouVw73k880HQxM3b9XN9ZIgyWsVqS14RVmRT8/BJ9xSby/nb/w1LrHiNtJJ7l5c8utYhY1oiBNLeC77Ob0KwOXw3pE7iYTbogSP40ZP3L2XPZVlu+rwml11iCX4fqTFcJqwNGMYwj178CgSz5ROS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsYTTjsA; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsYTTjsA"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c12614b81c9so1548184066b.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 02:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784367429; cv=none;
        d=google.com; s=arc-20260327;
        b=BuGlQNtlRnuNv65T5+hBiJVo2p87lDq2PY3mKPV7v2ZW7HxN1QapdtRh+6SaXFArKh
         eX0qn9XZEn45udxIsFt5wT+NnK3eSeklrMrVNOjvMFAbjVwoC69xQH9aEeFKUQ/489M0
         OeLKPj0EW9sP/DsesiYCR+keM8rh/T150mvkV7EBCpzHbMLk0vdh7BZWCav+c1d7ud9a
         S6J/ubLMkNMsftqvqkTOGy7VnvV5idX4iHeEsJBPzACUhMYt4ZBq377Nsaj8eNEgoVR5
         m1Cyp/Lty4bTro58RgQMhs6XJOPRdY+mMICjP8cIPwRt3px+e/1DApwDA2Fjq8VjJDeK
         Lf+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2YfLsRS5DTsz/QTjyBGDlfcpvV8eMK7SBadFauje3oo=;
        fh=ob+gNrlUQjuGhV0CnMxY1EoyesKaZJ2Awz9OsSa7GCI=;
        b=HFh++VIAJSsjyGWr4bfwj2YYuCGFH4WqbIJ94wSa8lps6TdA/Nt7qTvXNsRGtYlwM/
         nOvpgalD/7f4DfpNQi/El7wMUHyi7GgP7N9FC+Jywm8Rda6bRKaLsAy22aWCNGUFy9To
         hiNDnUMumgjHaAW2hiFiIbxUtR+Jp41QwojimF+m6pQ7Djiv9fpOXG3b9i8sRDxcpXEI
         Rf7N97hUv8qqsAggE08nrUeH/dWCabu7uG3z3VjwHyr7uRkWuaqcCeYE0+H4yPf4Zg9D
         6tD5jGWuL2uJmDsAWiMHIQkrNDHqiPiY5LXTAMzRYfFDKb9b3C/WG4EseGFs/b0cx2+r
         fiLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784367429; x=1784972229; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2YfLsRS5DTsz/QTjyBGDlfcpvV8eMK7SBadFauje3oo=;
        b=QsYTTjsAzIKHwmGSy9wnaqB8ePfUvS58/wx5i1zJ37h2q6LinEHjSx3A5triqHgKql
         nElTebC/4URmNZFaQkiQuDLQNSIbjkbGU3xXyp64R8zEiaElx8NJC5yUz2yQMDrjbvAv
         cGZjQYHTVxgKqadnq3vEOf7zWolohzFkTY2APnNqZcJojapDKOQTTdIhz0NxvsLyqzJ7
         E/OeNqWhAPcQ4sHGXGstFLCaZkiu6Z7cW3KjdWyQpuOekw2BCDR4LN9WPREMTMitVQAJ
         mO0XCbp255LepO/T3ub+RfWytcnfOBAIo8JpIYAFEhbTfNTWsHG3+wXk/rBkCZgrKpM0
         oHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784367429; x=1784972229;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2YfLsRS5DTsz/QTjyBGDlfcpvV8eMK7SBadFauje3oo=;
        b=OE3nKiAwfIipHF5WAfPJXZ4sVYEG9xAYYCK5zC8JJQ8jEE4b41s9wRY86ydiWGQKUw
         xYm7qJ1EqdKrY58a86KqSc7tt7lLghubARwyyS2Ej4Hrnin3wlv6t3cOSiGkjubTVet4
         PenwPBrSHRQ3dtVJtc01TJfRzI2/gnaBlZga4716XyN9TJJPWvgR2p6NnRst2xivRpVd
         qHeXErpC6Eih6OnjSXo5MEK71sKfockTdY9ibkJvBwLU9q73Wl0VxWBwbljnpFp4m2cV
         EOyTtAyEfvuDSsuXDYgzrJz6HDy3HdfquEmX3Ixmb0iT8BXc3ChaA6O3hqrO+fE3Bp8U
         bzVw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2PKBEdlYXeUBsPBlindfihpKiWnkicmp/hAIM0r4Y1pRhTwlgwy9WUjjub+Lnx+96W4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG19lAXrMZlswNlnNr7gMtpMJFVy1SF9D7b2/HJ88pzFaOGW2/
	AZ23pNoaQRL64L7lJmgkJLKw2coK4cm+D+HcD+HujVnRXu/oQIQFM9Ljd3w/Yg0pNa2b2fTjqf3
	xOhwk1WKI09jjCpXnxKg8Qodwfj21NfI=
X-Gm-Gg: AfdE7cmbDToBZDAXmekYpBmQmS0HcM4ajmDam7idslGN5nvhYnoPGBbek5nqgiEQUQd
	wnSS/Dvf0V/1IoLeEUQ1Du0RxDqGgEf4jGfmBplAfvm0Pi3By2msCQdGZNLXEjdW2+OFQdZNnQr
	ezWTrRc8B9iKjNb9qybOS+NrrtaPV+vrZBkqNoyNdNAcWJoIFLVnXrLqtC1FH0a3psay0DWXaLy
	jwYehcMnsePX+ZQZsfJYIHoOTC+5u9P+7s3RfAbAMq14KsOHHX0RY4nxBnwLw==
X-Received: by 2002:a17:907:3e08:b0:c16:4df6:176b with SMTP id
 a640c23a62f3a-c16b46e8bedmr291810166b.20.1784367428879; Sat, 18 Jul 2026
 02:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
 <pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com> <fb76afe31c98833582d2b6be764fa3a1c8b71bbe.1784128573.git.gitgitgadget@gmail.com>
 <DK1KIH6CXW0X.1U2V3GU8L6HB7@lfurio.us>
In-Reply-To: <DK1KIH6CXW0X.1U2V3GU8L6HB7@lfurio.us>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 18 Jul 2026 11:36:32 +0200
X-Gm-Features: AUfX_mzoRwAsvfr8_KhA3u-HW9VIOjLMj_yWABw9VOK0JehsmFm-J7lnW_mRcrY
Message-ID: <CAHwyqnWV7whjONR15y0W=xfZdwz2burQtn5BzxVuU0fijs=9Yw@mail.gmail.com>
Subject: Re: [PATCH v9 5/5] history: re-edit a squash with every message
To: Matt Hunter <m@lfurio.us>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

Good points!


Harald
