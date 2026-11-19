Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795082056;
	b=AZMhvGhsIvZA8i8BMsnMWznEra97e76V2L4GDVk3FKlMPSJA+xL6O7H5alM+2NKSnqeZ
	 XNf2XNmZLhkwbvAS+0g41+4GNUuSdyKly1DCe5hsXN4bbifEZyJ9+Ftq3rKOmJJcL4XJE
	 Z5PJWv6NrzI82asG3xDZYiNHklGXufOHW+UShTYoClsJOkEFNDVGtD2llxa2cOH/yKJ6d
	 xpC1N0YgEZuVYYu+lsGQspKhCF1KaAAXh3L52VZsdFyrlztwTB4/KDbHdcbMg+DU5/Hip
	 xTa66KjYNLiPpme0HN5LZzxXZvw4t5ArVvkSwSdeJ63JFPM9sGbFLg+78JUQVfoz+6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=SoOX3Dmm3ztONmY41CAGAiy19yfjyN8H5IrxIiXdv4U=;
	b=JsFLOogXK4mzu1aXT5Kth5YX3+9iUoAuOlLxHCdGYbKhTKCjBowAXqDWO4xtKVSZd0Ku
	 E/U+gJxjJSct/DVNszTvuqMFbM/G3XodETTi5pG6wGyIYRwZs/b3bXNgI7cD5mKzZqN5w
	 nnatgUnHZroahY5/BPy3U83wdjDXc5X2WoDeKPpeRVe+m4zy9c76sjktaQXlNRLJTCPFi
	 M9XKDTRibzaPChs52MaDavVzvYqT1AEWmHQ8ny6GzyNfWiVcTG2OFajyeg/OH0Sqy0GKF
	 pfKu4dklkGsB5/hXTKiLvbPhJ+yqerqnO+QunPb72cSV8+qpr3sm/p6SGZuJ5I84WUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kezNwDWb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C08606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 09:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48C08606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kezNwDWb
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso2436887e87.3
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 01:54:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795082054; cv=none;
        d=google.com; s=arc-20260327;
        b=NKyCaPOxvI2QXp23g0qGJbPsOIMnS5pLxCmiM/cU9v6fedVLjN71sDti+by78jdejD
         DMhCvnmMTJqJag3Q8BQOIDRwZA5KEIiOY7g/yT3dQPXFIwD/E4Aw5D4BuUXT/2mzlR5q
         kMuoEXojT3tfrixlxb/ktyrfYy11mSCYRGOaZ1L+6p7yRkCQ4VyfNg4980k9kNmtkOw5
         580kLGmkMu3uQUsmJiCWTOrgnMXoSNEDGq0cQfPxkPQNWgPzCFYXCSsd/Sy2QAOcNAIv
         VA4WvUK1nUmguic8WJCMAFOiHH+w282uPxSeLWuR1J/wfyRQEf+FPHQZcayiDthy0iU8
         B7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=SoOX3Dmm3ztONmY41CAGAiy19yfjyN8H5IrxIiXdv4U=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=LwKQxXykntXr6zNJ6POkIYIOmpwOzReguu2bG2RRgyK4/bA4NGf8Dl368JG74IAHLR
         cb6qWu93bt0hUIX0iZ8LJTU4KbgReVC+5x3dETTZV9oTDSdn2bdqLt3QHAPrGDKTWKPn
         KFve06nqTmzB4bdLTXTsaHAS6McvkAhaoqqvvfGcFqrcbOn0qLtTUgTNAiYH1hmZWkAj
         MYzRyXfq7SBqGi8ilQ+r5nDoDuX0DLPiDof4YozsEXyrKJArjBlTS/b4t5LklT/vcDSJ
         bKL7jjQlGrI4vDUZVZveVD8m4YfDMceHsWRz25QltcH4Whk2hXKR6+SjPK5ChjSn/fdZ
         akkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082054; x=1795686854; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SoOX3Dmm3ztONmY41CAGAiy19yfjyN8H5IrxIiXdv4U=;
        b=kezNwDWb34PPjmLGruE+wdo1KOm0QGerHP63pXjh0aBLFGzOCgXgEaljytfBeMAGgV
         cEytdPU20iPoVFX2LFd7U9f6oMu7N51LpDLsOXf1O5dAJdllVI9woua2caeyUN86/I2r
         SSXrBb5dOma9PjOsDWZWjfEdbstgK3YqIfbi+b5T/VUPOmML3QUnpv6Fj5UxYzvEnxTI
         SDYum/wkv7iOjtq0UDmUJJS2PIUvE4USH7gm+hzvp9fbchVdNE9hnuCscVv2ad6vgJJl
         VjOZyjYr5RCpt3aUe7KvhuDX3o9CweWAVAudqsln6htGuFoMmeTBLKDC1NFtUlsWgoI9
         CBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082054; x=1795686854;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SoOX3Dmm3ztONmY41CAGAiy19yfjyN8H5IrxIiXdv4U=;
        b=odIMAzhGWYfJiYjxkCMAwVYVgrVpVsu4WeJ5AV09K3RkL+KqIb7oel12awpucfoT/E
         LbiKm2d/fg08oj5Zu9B8pqG7mpXY066+V1b1x4WQdhbv8O/2450XXmkkCDvZwtvu+qt5
         RewdVuqDDuVRQUwfZENiURcuIvorXjrGJdAcOWWuj0yYNKoPmyPi3/lf6QyNFBB+Yk2F
         LO9MP/ZZFEnn9Ti1bG/57X8TAvLEhP6HbTP5vq9LWeljA3/sMoWV56X4+FngaDk8/3fG
         xDKZ6zNFZGgpEfaOskBIP3LoPbaAICj/MeelJ/N1dQxnoaa6RwO469SdEbfIWmW6/svh
         q9kw==
X-Gm-Message-State: APuU4Z/HIOsrYaupeNH4LNhQ0noNiEZmof73en6kiqUsQzZqrhF2Q7kQ
	9lUklETucuFOp2cyD1SJLplBVoBi5iGyjEPCLlj0BAVzGgk/P0363AGeLqWIYbRgvBl4VfSP/Lj
	vy+B5lqIdwSWflDhOEqadVnMpsQs/BVTvekFyopc=
X-Gm-Gg: AYBFou1XKt6rujmlQX5fNezSEQxEWY1Zcw1wLRQmJHqUBpdT7EaF7mckRM3T4EJ9tI+
	VsjYR5yBn4d2FvtleTvj0akhwLY7fUlzyf7cqYdd958+MMP+PZ5KjlOhILagC+2LmsspOcRXlDZ
	FLVnmvCIrsd2QInJ4amv5+EVjSbKEZkaARUwa3GxIPDLEYZxSz3xxfjW/kXBmvgqjTduCVdARww
	9/AjwBRNurU8RTmsduaGnlbSBHFgFuqfmRtMpgG1D0xmZHkhJr+3uq6fdvn8YsJxDdHdKgIAujX
	rKqgzCmpEFgOAlId4h1KzK0jSF36O57wMzfX5S+70pFHhpDoiKiWE+CGrWJo48FhWKr7FvVDA16
	vjtkg89Kn8tVg4Rm0J97Yoq0PODrZ+iLSscXVRe5zZh9RXcJzF5EIzrndDw==
X-Received: by 2002:a05:6512:669a:10b0:5c1:ac5a:828a with SMTP id
 2adb3069b0e04-5c1b2d0a929mr343763e87.64.1795082054413; Thu, 19 Nov 2026
 01:54:14 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Jordan K <jordankadish93@gmail.com>
Date: Thu, 19 Nov 2026 11:54:02 +0200
X-Gm-Features: AclHuK8FKBRtRKvqQjm4B4Qx4UPnGlblJhhF9Pj-edRxdw6Fftl9jSwQ1mdgXEY
Message-ID: <CAA8YNQAsyUe275DLPRnB4dym5aq9ZyemA39u+HJciKzat5tNQA@mail.gmail.com>
Subject: Branch Awareness
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have a situation at my current workplace that led me to consider this feature:

We crudely pass around a `settings.py` file that doesn't match the one
stored in our `main` branch, as many workplaces do.

Feature request:
Allow `.gitignore` branch awareness, so that changes/the existence of
a specific file are ignored in all branches that are not
`specific-branch-name` or ignore the file in ONLY
`specific-branch-name`

Sor of like a whitelist/blacklist flag (there should be an option to
use either).

I think this is an impactful feature, as many git users have
situations where they need to ignore Django migration files, local
settings files, compiled binary changes, etc etc but those files _do_
need to exist and be included on the staging/main branches

Regards
Jordan Kadish
