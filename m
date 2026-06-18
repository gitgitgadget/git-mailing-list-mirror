Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9686B233942
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796978; cv=pass; b=so/wKsuHbkxRTZa8YQl7qywZO2aFD9jg4yqWv0wGZblWu5IWZ11RAQkzCaPuqa1n5oXuWYdKKNtpQUBH1YHAyEUy4QAMAqzSgCEb0IaL3wID2jLQ6mjeVtbq1unOMl0EnxOXVoYwJ/zq0n3PknJja9o/5FV5Rj/byNATbOkxe8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796978; c=relaxed/simple;
	bh=mRE+rLwCBJZpa0bUeUO21Tzqh43CFgNISBveA5K7pe0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BnqZCMFEBU/Re/yGsvNPDsMwc3HWX06rdOFCHPuAyghmVYYbldDhZ/9KaAtXyKun0+8BBQNzmgt3EJ04ef+fgSNY6EhyIpRo3tL4o/2pjJT8X+EWYcINJj1MLGRZ6D0VUgJuzxeAnpB7Lp4AOtwDPnYjX6GAG3vQocVK5k8RBDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YO0HkGiC; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO0HkGiC"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-44104dac6f5so1777783fac.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 08:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781796976; cv=none;
        d=google.com; s=arc-20240605;
        b=Ec+k2vyGqr4ojaYRT3EH7qUL2Oa03TR1yaXNlBMxYAMPq+JyOn/XoNnYyq4wSMd/RT
         Jp9Rz/L5A6xi/M4DKPSUqBvO1nraoYILs6s0iJzxpkhdKfhbO3txtXvty8hXuJZzooCj
         iUoMmoLfEcWJceBZhBo8SuBSEi/4iZBVMAQQP0Q10IUonzdQ+SCi/x8fUN1T37+YdYLz
         ZVpD9oW5jPg003tMADSG78D59ns+xsfulTWzukC1adG/m//9GyQXXF4uA6WY4Uqgh6uO
         xqlfd7lPCEk5INMxYv3KKgTmTnweS2eLKVX2hqhMQKJC41/wBUFxuzLhKkSbQrvlM20g
         cDoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=XX+DJAONABdHkQ7lvK0GMKBsu99TwPHDIA1KGycL2C4=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=D9mi4SV0vqHk7X82oQumnmhcXWglzmTyDZ2ICDvRIeMa0MR7i2j8vWhQn975lTDFeU
         ermwAw/oqUvl2563tP5DoZLfnxC4PyEfDfarJZV2WGMF5fLvpM7Nu6Tkst2O4cUivRtk
         bKQAu+UeKaQ6RP6CQqPUs1fWYe2XDdxJQu6OAqPlvL6t1FgpHetHA26CV8bGpVLPfwTQ
         3frea4xoxGgNpODDFtFvajjN7gZ2Qh9OUci67pTbuAandYdnR2sMYP1q4YzfzKsNTmsh
         ytPXExpVBZlAEqvJfhJBnN8FIFdjxbNCwrF30Qq0GoNwg/g/7ifQow/AlYsD0UV/qTwk
         wIJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781796976; x=1782401776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XX+DJAONABdHkQ7lvK0GMKBsu99TwPHDIA1KGycL2C4=;
        b=YO0HkGiCify8fXUGn3If+V5Ew6aVC3zEkEFX3KU3dUSXnFd0XSz5TBd8NHM50LUMaP
         5ueAgiy9xNvqQLuoLyBH8Nu4e48FU/T8cy4WES1QNseeREYAV27nfkPnbQbgZjevPgpK
         z9WjSUmccSDQP5olk9bLjCQ73FTo5K5XXmepJVSstw0MDun7HFUoqMttaspgBZCOgdMY
         j55EC/drwqVP8UI1346kvGJ4o3w56AhA3XYxD3LPfDZc2dUj9gwcCpfGRkp+tHwrw67A
         srm/y4tWXY+MCyQPvZ76j6ghZqh/PuYx0OOLH+57q2A4q2ZlsgOOUifma9086b4eYX+Z
         DikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781796976; x=1782401776;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XX+DJAONABdHkQ7lvK0GMKBsu99TwPHDIA1KGycL2C4=;
        b=qIggJ2nYYslzTjc/HrEuelAaL9gdBRj0IGqM7nOVYwo8ZKHOx8pp50mi0XaD/1NTgs
         wxTqxie9wEnt7bngCGgJNQ1pMfQYLjmBflRFAT67R0TiyfPXIPCCWLi9VYsqNjYgMvYV
         S/IRXSnoENWNHgWsK6/YjHJcy0Nllzy4YfsvsYSsMumbj4SkbOO3GmaOHQUiDxncx0kJ
         aNvQA8Xe63K9atNvgi66Y5MTyluD06aNu4tdkayxta6u8kx/OOAq4Qw6b7a/l3B9aVEK
         DI4oeQH9aUpy8UYyMZaXyVfYw3BuCLAJVOM74+3trmJcEo/xekxO+rx1Pc1Iyq4u4oMR
         V5Bw==
X-Gm-Message-State: AOJu0YzUl1M59WmFKTaUVSRTZ+ds+wKPo+IYmR6Dr1Cm1GuAzpWWDG+Q
	N+EeGohrp+znJAcampSrp/ZjUJAA+RDlt9hmKHvbENrR0hhGxYlqpMWRLquutWDVSTzwz7cy8bD
	13j7kKKGFj52jLGl1T9yi5/oww0u24/EQxxsL
X-Gm-Gg: AfdE7cnrCwOkOwGQJOIBc/iooS4M8FSfHlWw4PPVZmKoDqIQJoKT+cE1C2zz1v8co5S
	86SEhS9vAUwPMlC+d8+wz2BOG7e9VTkprP//lMFIcQ9srkc0CPnfq1mtn9bUXJW5fqhLU388PeP
	2C1OioSS3Uf9BQM6WfGV64uKv/fEiG4lUIS3haTeOyWRQAGlmslmQQ927qc0jdg6caXxNa0GwO7
	BzfdIYPACUkZXXJ6fJCyqN/L6mWVcgejOK+CYxmP0ozBUo2gF3d8svZuDjX/uohm6fGa9aK6AiK
	SK0Fw8adLsQ40+nsHZmXRpDOSDmB7J0xKas1cGb8B5e9MbTm8sZb3mN0xiRT9Lu/YAV7YKxYmob
	1vORSQ9GcjIQag9A=
X-Received: by 2002:a05:6808:11d0:b0:486:4b79:12b6 with SMTP id
 5614622812f47-4895609e253mr2829671b6e.9.1781796976572; Thu, 18 Jun 2026
 08:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Thu, 18 Jun 2026 08:36:03 -0700
X-Gm-Features: AVVi8CdL0glnp7cdRIVa6Fqz-7Eq9KwmzGLc5migSO1_3xSn1Np3-9fzan7os-Y
Message-ID: <CAC2QwmLy3WZbGYC14kYuC-BmLGFi6ztTEoqZdo+hVTQt+6=y=A@mail.gmail.com>
Subject: Re: [PATCH v2] SubmittingPatches: address design critiques
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> wrote:
> +You should be particularly mindful of critiques regarding the
> +high-level design or viability of your proposal (e.g., questioning
> +whether the feature is worth implementing, or if the chosen approach
> +is appropriate).  Defend your design decisions on the list first, to
> +avoid wasting effort on an implementation whose design is not yet
> +solid.
> ++
> +Make sure that any new version is accompanied by a much clearer
> +explanation and justification (in the cover letter, your responses,
> +and in the revised commit messages).  Aim to make the reviewers say
> +"it is now clear why we may want to do this with the updated version".
> ++
> +Topics that fail to address fundamental design critiques without
> +resolution will not be considered ready for merging.

This wording looks good to me.
