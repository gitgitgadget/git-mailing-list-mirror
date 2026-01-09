Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0BC35CB76
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767974574; cv=none; b=d2Uztmb1foI2ToXLgOVu/yDq6KbZImbcH5Qb3E3i7/ABZGVL6Rcuxgz7ZXERBVOHX+Tsw+WSMhSFflLWf7Q5B/2Cospt43f6qUtfubZS8+VDE7sjcTrdsdNs4GB82xgYr0mDEXhTojG08aVY7DMuQFZM7hiYGuLi0LmQ0jBPkzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767974574; c=relaxed/simple;
	bh=in4YvxKvyx2FSR7QtWyYXY7TOvHnb/MQQzwIWQ846qA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=sezX0pJxS3fK/AR4X3J4LTgkcfioX/9Ir/jHJWpDcwdZEDjQdwfRhWofrGEXkYMyxVVnKMR5YKpleqZLsIzzcODJu0lQRvxsBKwn9wUDGpfzcD29kMpv9oaDzcJJmG6ropK0XVEOqwEPDfyf1ULTjBvGN+MyYQLAdleYeqija84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db5MG3sj; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db5MG3sj"
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-64471fcdef0so4220414d50.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 08:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767974572; x=1768579372; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=in4YvxKvyx2FSR7QtWyYXY7TOvHnb/MQQzwIWQ846qA=;
        b=Db5MG3sjsXVMFt6jFmjx4l9u8AZR2mZ+FkCenn3F8EOxMm/ZFWzGimJp23aPtq0XNc
         BqK856qxTc33QHN76oFWlA0eLNkdWhPgRoAozYn+E7bihwXdIHcvSK0n/DP48q6hiWHv
         Pnd02yK2Els8TiKxm1XoDRaxxwIrN27iNe0Qb06lvoidj16VzjLwVCJdCkZJnBhjoIKo
         VRdhZqXBmqgD9wNTSn/2FPzfRy/KS50eiPqjJSuv7vjjQ1BOopNP950bnOhnZnMjVx+1
         sWm7G5iU7W5UCfl+a5li7L0huGZgJXcTAjWRYG8SsSRQIKPx2RpyTk4QGJt7JEelINK7
         234Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767974572; x=1768579372;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=in4YvxKvyx2FSR7QtWyYXY7TOvHnb/MQQzwIWQ846qA=;
        b=vMXw90uwdzDgURvfnfOUsCRbnrM4A/Xfgv2FJgqaSdtbbE7PAOUKy8vsSaAbYyGYR1
         nUT6OIMPjti5tzQ/GkKP8Fttl2RpIDivXNgfE2o1W3J6x12ge/E7UlxSWTfZ8pk4evNs
         2tzf65AEDflxTabspSlRo2nQmni5cEgaj6p+FHyEzI9/v4yXqiTbs4MisP0WYCR8ap6k
         m0yGmsLfG6unw5DLNYHEbRRUkMKktqLcHyQ0BPTtue4Jo6Lq0qqdW6qqVbSamrf0/EBJ
         pY1nuDpDfRQdAmpncVDDqS24Z+XMvdn4iL0xGh76ZNPZidJ7bPDjn++TbgTp+xr7Sfw9
         iD+A==
X-Forwarded-Encrypted: i=1; AJvYcCU8iUEwaSKXKxI8DRGVdXV8WGkjtWBkWJ3D56suvWP5f6Z5Kuc2bnFZnB6Pmb+9IFrAtvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4IrekxYGHmVLHo3KhOUbswElV+/cqo9rujZYO1fC9bI0IeON9
	PT/iv4Pk5tYA1fjfTF2DRoNr322kYTHC4yPk8/7AhvDyKAzluQ3zaia7nRZTkiE/
X-Gm-Gg: AY/fxX7GWItzJKTIITrQOagaYXr18KW6QweoI1T2ROvMziz8T15fWrPxYY557/XMmSP
	BraIAqDVrc3L7LIpgoCdJUEIBDPl3uLnbnPk3bh9tcGHqT+QUvxL6UdyvNFsnjhBOlBhkBwNztL
	1Q0XHZmPuLkEYqvhWt3QSsSm17G6THNgH6NYtrgYudrw8ZxNop3C2S5lMspsqeaZyGXuOJevIGp
	bbQArB9NqXrt1qFKYxDRIasqvMbJRs/Fmz5DE/2HcYOjZ1QiZU0y2p0K/CUhPtSWHoUFMcmcKJH
	My8YSPBnaYt8wiZBIYOgDP5Jn6V4ujvty+ZQ7eZ0WmTTp1Qn0rqQqiHJ6rYWA/ltNI0zTenZKrj
	jYgb0eu5pS/TGncbKkhdBPmYainB4BfWTiXXIxse41NE419pynuygfWjb4yl/h9uGBUT3SIYw/T
	ddHO8IVZk+4NS9TG5+HAPJQn0exva0RDoa6MrYNw6nW9/RPvha/BcSzLuLp+jfhgMnRAs0L0XS6
	BCf10wmizncyI3rmEYiG4aCX5iF
X-Google-Smtp-Source: AGHT+IGahLYZnNNMdPU5wZdBglh+bzQ89LK8m6U02wOL5Ayapg2/u0oELiFbNreDZRaiSO/PM+F0zw==
X-Received: by 2002:a05:690c:6303:b0:78c:6664:3104 with SMTP id 00721157ae682-790b5723332mr214761467b3.5.1767974571398;
        Fri, 09 Jan 2026 08:02:51 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:b1a4:3976:e3a8:a9de])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d7f7c04sm4657996d50.2.2026.01.09.08.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 08:02:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [Bug] hook: -Wanalyzer-deref-before-check warning in run_hooks_opt
Date: Fri, 9 Jan 2026 11:02:40 -0500
Message-Id: <7BD989A0-30B1-418E-9257-1731724DCB72@gmail.com>
References: <aWDm_n2YgjvaRmpV@pks.im>
Cc: correctmost <cmlists@sent.com>, git@vger.kernel.org,
 Adrian Ratiu <adrian.ratiu@collabora.com>
In-Reply-To: <aWDm_n2YgjvaRmpV@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)


> Le 9 janv. 2026 =C3=A0 06:31, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=


[snip]

> And we'd reliably
> segfault anyway if we dereference the pointer, even though we would not
> get a clean error message. Not sure whether that really is worth the
> hassle though.

I think you=E2=80=99re probably right in practice, but doesn=E2=80=99t the s=
tandard just say dereferencing a NULL pointer is undefined behavior? Just wo=
ndering for my own curiosity :)

Best,
Ben=
