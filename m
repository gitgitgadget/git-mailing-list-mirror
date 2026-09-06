Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1DB3D6CA6
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788703011; cv=pass; b=YPIld1Up0tQmkAfW9jZBFKW/MEYY8kQVcF6bQHNwfzAdc6xikEMZzlevtVxE+6X3N818EUoWPQUwMXdDNi3/HNesh0z+53Le9p0uEd2EszuHQsaHjTvpszyH9fvdOIahXrQ7NknGErbCJPoN+gRDPiWhaqNuKXmmQuLxNQh3D+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788703011; c=relaxed/simple;
	bh=lUtXmI5iV+WMSTGa/s+GhsRNj0t+rxv/lkOhN2S/O+U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KegwKBQ2WzGReSebqFgTT3qkS4/ak+dsBvy9z5kJm9LeekgXv/eJJvz6AGCSlsLKh8Re/TkN6sgatu3ngnXjsWva6PAUF/7Yuugl1WZAmxOG2lScELUjU035pevxwXCjtoqvNS1qRTigmxXEkTZlQqgnWZQjuGisN14AK6HSXD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkQU/WY0; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkQU/WY0"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8518b3ff3e9so2473787b3a.2
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 06:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788703009; cv=none;
        d=google.com; s=arc-20260327;
        b=HPcnWdbQpEGtbVayhXeoZhT8u7ZHGaJXd20BQFCw+1Jcf8kfPlHYiu9K55rz+FZn6q
         3Mr313H8onv9+a3rjU42oasyKUTI232b6cBhG98fRxmIb4r+F1WcC/IdUH5LgmS+i6DR
         4X9iHg7fpfdEQJ2jplWLVrkR1sz1AtZ1RYAH5/FYRGObjB7tT7WnSxZXIoAVLpLMiF2C
         k+XYZyAb2u9/2NU+xcP5N9k8vkiDg9A47w42U8sc9JyWsWAf6W+wPXOkx2xDSUp1/9vs
         YOuRzqBYSLh+rvWVRAM0NyYqW8nGELMM5RVQV3bccF3CRK3TrfnHXde0TuNdvbWxMtue
         wLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=v+Wkz5SCdOSEA8q7VW28QXBIHeB1eK035yiUpo8yK7w=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=j7UhTtIfeZoRIDcIwW124u2tjaMA7HwCVt/NyOAPm3DR5uybXKeMciaf4ikgRjXxFh
         TNjgsyDczeBp2oOn0gNfnSDSsrscm4Sa0wl6eT0NZMvHn+Jnr4Zp7zDKFIdH1xOcHAwD
         ElYZ0a5wCO6xf4d9LJuY9luOssSKC5dEnRXv7Ay6TWfbjmXREQHJVCra+lgiJ6lnldtF
         p7IYP7nxej2ab7oMv1ab3LUI6BF0uIbsiRjExRet9458xtSB1hMYIVeEYxbBN2x5OoJl
         IDQEoTWdowx0UbF69hZ/5GSRIRGRWm//0bhUvLjupJx2DOhg1ulbAe+wgu+mjTy0pOLJ
         D6FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788703009; x=1789307809; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=v+Wkz5SCdOSEA8q7VW28QXBIHeB1eK035yiUpo8yK7w=;
        b=BkQU/WY0hS8iuKVKnfF+VtrVJkyhi8R57xAJvnaOPF4OqdDVJKUH3OkeWCNhWfYHun
         WTg/UrPcfHA6DG6WQg0gJETQ6VvLPHWfHItNiltz/ATaTUYAZ4BsuqrDqgNjk/n4/3Qz
         uLK331oNl/psoYQEUHe5QI/WElsfSgn7AsuVW+R7a7SneIpa8Qjy/WgM952lLFvCHbKo
         UizP+ZA8P2YV8ioasp+nRs1L8tLY1gekKWO4RwHfOZw9Bap6TKXtx38k3ze6nyfaPtc6
         O7vaUnmwHxzXNejNTJ/4q/OuCIWz9dM1Chh+xXfc/WugQZvZq/E48NpvGWrzYb5ToENO
         D0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788703009; x=1789307809;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+Wkz5SCdOSEA8q7VW28QXBIHeB1eK035yiUpo8yK7w=;
        b=bp7lehjCDTPCVA1rNVrvuFajiqj/dW60MKpjkRG+gCu7VChW6/nr5ZdsPyUg+N8/xX
         1+ou0ofuuNnMtpfePR/b8bsieqKC5q4gL+TJNrYRe9S9n4VxXdW0DT4XJL5ubjhG1Oc2
         WXOZUAn2X8HiGLOA0BXEY3vV1FWgHOS0jTXm/8VfbxnveRCgkN15m2nUUixGTKwl2J32
         bnC6rA0GSNXGFzBEn/zUVohmi8acvU5coJh+lH0Wkn2jxnDR9G0quYcsfyjsyGPxb8mc
         7Xa6mvwAAwVMbg1woHVow15qUZnE07Qqv9Czj2oRYEP4Ye/iwqYCY6sB+DVXRLUfFbve
         9Z7w==
X-Gm-Message-State: AFuF++mzriYDauZSemj7ZOUMLRh3nsXqzR2j0NHt8e0R7tS/rZ7GG70c
	KKxQQPUYg1ZNJ1s/FLCOqFsr61w7+bBgornOefG4o5GJjPawDOl9ZJX+cMSC3Vs9ACbasbio75c
	qQ4MtRCYTPmSbfPmbj9JIwbNOnbNQ3+8KvQGfGMo=
X-Gm-Gg: AYBFou3A8yLOnQzBnQWEsW96HrRJt9ZOP9enu5115JL8qFgfCBya/17wbBpeP2BeQo1
	nkEBFXax80ulbW04VAYyCypIbte9F42kWjPHGEx5A832bxo/YmXEeBXJuuA/t/mfyWAnefBH3xP
	ueBvJh712jy41fhECbXX6xLgnf+RBh6jdmc9+kxVhyvQTZJ04TD/s6t8M9h3lABeCJLWPYiM7YL
	KJURcerzO5n+KmV8yHkpEEkyO6v5TsyNKPr+9M7YQWbjCTa6xm9cn5SIAonaSkVnNYKmA94nlSr
	muw1NBDaTqFCMIBiYvjJ0d6lpw58AXM+uZNm6qSTh0uUfo08tpQopyK5eF73gxXxd3viXhZt5Rt
	XX8kdmUbtFAK8Ortjpa9YS7Bp0i4EDmHugyrKU87SHtqen4m1p4hUHHy0xswHmLBaxLfRn/B1sh
	SPJ8vXFXFAXpj8bZ4Fsr4YDKW0FNAfqiG8ZDyHG+rObMo=
X-Received: by 2002:a05:6a20:9f86:b0:3d0:cc29:ff64 with SMTP id
 adf61e73a8af0-3da39ff00c1mr29256055637.15.1788703009301; Sun, 06 Sep 2026
 06:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nicolas Jeanmonod <nicolas.jeanmonod@gmail.com>
Date: Sun, 6 Sep 2026 15:56:38 +0200
X-Gm-Features: AcwNN1V03kKzFF8O3Aio5c_s2c2KsPPn_pXAh1CWkYK9UedtTuX4U_ydZ9LbiQA
Message-ID: <CA+35gGbO4_Yy=vZ+nZSLBorRnZMyBsr-Okn+rh0yrXiEWy=BFg@mail.gmail.com>
Subject: [RFC] git clean: add persistent exclude patterns
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I would like to propose a way to configure persistent exclusion
patterns for `git clean`.

Currently, `git clean` supports:

```
-e <pattern>
--exclude=<pattern>
```

and these exclusions are deliberately still honored when `-x` is used.

For example:

```
git clean -fdx -e '*nogitclean*'
```

will remove ignored files while preserving paths matching `*nogitclean*`.

What seems to be missing is a way to make such exclusions persistent.
A possible configuration could be:

```
[clean]
    exclude = *nogitclean*
```

or, for multiple patterns:

```
[clean]
    exclude = *nogitclean*
    exclude = important-local-data/
```

which could be configured globally or per repository:

```
git config --global --add clean.exclude '*nogitclean*'
```

The intended semantics would be the same as if the configured patterns
had been supplied using `git clean -e`: in particular, they would
continue to protect matching paths when `git clean -x` is used.

The use case is slightly different from `.gitignore` or
`core.excludesFile`. Those answer the question "which files should Git
normally ignore?", whereas this configuration would answer "which
untracked paths should `git clean` never remove by default, even when
cleaning ignored files?"

One concrete use case is keeping local metadata or other irreplaceable
directories inside a working tree while still being able to use `git
clean -fdx` for build products. Such directories may intentionally be
ignored by Git, but `-x` currently removes them unless the
corresponding `-e` option is remembered every time.

An alternative design could be a dedicated file such as
`clean.excludesFile`, but a multi-valued `clean.exclude` setting seems
simpler and maps directly to the existing `-e` option.

Would such a configuration be considered useful and consistent with
the intended semantics of `git clean`?

Thanks,
Nicolas
