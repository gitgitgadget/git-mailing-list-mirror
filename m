Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ED3266565
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786803454; cv=pass; b=Zq7aolgz3S2Rfd8oIRwO4Rb9Dke68CAHrFOmo6i8fwfwO4WVJJ/zhorbSLnHDX9KgxO6juFdVyfG7Pn0wDaviRwp5EnudOOND58RlIuIh/sehtUWPWtxfgrCD+LBjnFrp1Zkxv5fj+ksIGuKG6/8ApZ5yfddb2/VpCEOuwyRSpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786803454; c=relaxed/simple;
	bh=3YVwhY+2v+vSb72lDi3E/Ek15rEul106lct1pt7Ik3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1Ni1LQzUZdW8scXur2mrYUqqGW1UKpKo7Ms7JWK3gWZwiDttqk1ZfSQ8KT/GF8U1jfywaFv0DXuh+108KtlUHzN4NJXNuCprtfw3os50hjKOyXRYoySPiPjxwDvtLzLebE10DNOvI4qtM4jMUlREQt6sa7ZKWf3ArEHd5QkcM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivLnYdty; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivLnYdty"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84fa3b14ee1so1457819b3a.0
        for <git@vger.kernel.org>; Sat, 15 Aug 2026 07:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786803453; cv=none;
        d=google.com; s=arc-20260327;
        b=P9B+v+kpAiI466hxkBHb8hFsEubCd8D8NCFBpLIppsvmQ+In3pVPrpaFm4WrfdimsQ
         h+NtLR0uZKFpX8HFKYkztjjjaJLjuWOuwVmN6Mq7dqAP/JerWGQsbm6AQi2R7ka3g/Ot
         iCcR1kpuvnObWe379UX4PZVEWy6D9f4UTkaV3th52xXJhWL/amLAOMmqJipVnwmiSOVZ
         BiriJ0WiCQ9mDDMEcZDC7PoN2EyJ8UOuf9NvGB70NZ0wtBN56k6LtzPgpXpvfvloB+JA
         /XBqGiM9CAhd+zNgoRQhBWzeFA/QQIo96rrGDYoz1bWAs8VAl1u9ZtMFO7giXHCvULEv
         4fhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3YVwhY+2v+vSb72lDi3E/Ek15rEul106lct1pt7Ik3s=;
        fh=itp/4CGQQUMRl9Rz0KbGhpV0UW3JW+Ui+mb6ZC1yg7c=;
        b=C69Fu5LHGwbOPCteqOFFnzgRRJXMcif7R+SoPtudt0H1iwRTkRLVksHJAlzlZDZgcq
         /Yl2OPrjmB+FKPOwbZI80xvEu36kxvG47cEtSkfuoRsNk5wXKQmkPFf4UZCQw+Tbf5Ou
         h1fz9eOCl+fqURY65OgObkXm5dwwfWSEsaVke0Ua57qkLMAkqpJXAkzvaMWETLaQ73fM
         KHiV7xDrN4UkV/pUJBCqJ3wLu3PRFGEInNLf7Milcw31axj3ocuQAyH78GLy50U7EWJR
         U2slGctWQ/53tIdpaQhBs38G3AOgdYtjWVz+jus4d+eOreTz7w9UJsBICchSp6RJDSJW
         kH3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786803453; x=1787408253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3YVwhY+2v+vSb72lDi3E/Ek15rEul106lct1pt7Ik3s=;
        b=ivLnYdtyCBUo+NPgIMV60YI7crACD5s5bxEr5lm4jLWUFr9T3zt7AvRP8yjOL4rBHE
         vstk+otDrQWLIPR1zCkGj87UFP+8lLt5opzSawRnAoGNQKP8Ca00AptW/AS2eQgv8LZn
         UEBp51i2/RhpKzFXGX+gDvcAdl+XKsSweGqh6up2N2bA/tgOAtoLi3PJGVvfYWS4YHyi
         NSn16kP0E8QCn7An462YXe7d2cYPTZkLY+LAH2a+SJVqGUIB4rVYefZB1slIDi3N9TvF
         MR2f1SaQij0ZcjeqxuDxuXPqSK3bJhVhWpHT7/mnr65ecjovgP/aue3fedGhdGejnjnW
         h8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786803453; x=1787408253;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3YVwhY+2v+vSb72lDi3E/Ek15rEul106lct1pt7Ik3s=;
        b=oGGGkDlKuvVhQ7Eidq6hkgbojK0ogGTM4k6ZlpqsSzFeDWZ2jE6MnJ+1C3LqaP3YPN
         s3WA4OHV11pDGv/W+yMtnGqqulK31zU/88zc3yScMvaDuDsZho23QjpMfaRLeXhRRFC4
         fUkYEKNy3C4kbQguO1x5fi9Q6x2hXiNTTfbUUxdL+e7ETE07b+ie30M0ZQGPB9tFRbLl
         50SvDiT9lZfK4Mf+kD9/kAZwjgRO4qEpjZzUZT7atph1jihF+QqBufZ5H2ZXPSV/fc8g
         aCDKdSjUJUDD4GiRyC70Nw+K1XQq8LYKzbL7DeYJI3fgYdwyV1tpbn6qOPFn1HBzGona
         ILqA==
X-Gm-Message-State: AOJu0Yy7aXppNpYk0i3duWvKZS4U9auVEm8Vxhmv3NdFxVsdUt7YgIgH
	8gyJ1SPx28/u4yqw9NBlycayOEiLeKpLSVkcBqDd+8hrKeYDN3gGXBxf1g9g/ojUhdpBVqLVC8N
	w+WRANDkCqFtMzzDFBtMPHnkE1n0HHn2bg4om
X-Gm-Gg: AR+sD11JXLnEoPb2ZxjFf+fkZ82hvfeDtzACgzNm0gZe4fuYnMhrJIHw5QJiNvVmwsL
	Wx65U4QFaGb+UMTCZo7hU1v8qztPoNoaVVLz+dxF/sKxhIrzzQ5pNVzCsRhar+Rv8x3+5dCGLaN
	KW5+SrxZtxHZUZtd+AeFoJO0vrUB+Gvg5ShyfhaGBjjCCGs4pojXfErKeI1CoPjU6McLswTLuD/
	K/Uyav4gzokSM93MUePjUQ/Ycgxet9KeN1Evsy/DLIaMEutosaLPLotWyFMUlom3CRVJC8bRRF4
	x1nVJKeioKeR8gRuPwRVHQcRmSvCXZx3Ry0o2G4NEf3Qu5tjNiNlE63fqO4GUXQYhzfo7hFyAJq
	w13VlDEWZ11qR/QhLA3dkQz5twsHkBAUUcLQ7D0O6qJgLe45uK9VGDh+3FRyqMjDf8fPxSEAg7i
	9OyqdgE6Pf7wSQVC0o6P6FIK+FG53FKg==
X-Received: by 2002:a05:6a00:21cc:b0:847:8f8a:a05d with SMTP id
 d2e1a72fcca58-84fde32ca95mr12237098b3a.29.1786803452838; Sat, 15 Aug 2026
 07:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <an9iXOqOOvFfyN4A@desktop>
In-Reply-To: <an9iXOqOOvFfyN4A@desktop>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 15 Aug 2026 10:17:19 -0400
X-Gm-Features: AUfX_mzs529XH67ODS0PXUsFDAIGaTVCszcqrPmqO3A222djg6KeWL4CU4xaxLo
Message-ID: <CALnO6CAWA4szRqq_=1kAjB_y6WqA5zSyyMZzPmgnV7KGb+AS7Q@mail.gmail.com>
Subject: Re: Bash completion very slow in large repo
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 2:55=E2=80=AFPM Matthew Hughes
<matthewhughes934@gmail.com> wrote:
>
> Hi,
>
> While working in a repo with _a lot_ of directories I've noticed a painfu=
l
> slowdown in some of the bash completion for git. Specifically, for any
> completion that calls `git ls-files` and needs to iterate through the
> file-system (and not just check the index), e.g. `git add`. Has anyone ru=
n into
> this? Are there existing solutions or workarounds?

Hi Matt, have you tried turning on "feature.manyFiles"? That enables a
few things (like the fsmonitor) that might help in large repositories.

[snip]

Best,
Ben
