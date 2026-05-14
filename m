Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3D3E3150
	for <git@vger.kernel.org>; Thu, 14 May 2026 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765435; cv=pass; b=lQLvXDtCvXLwnnvzpObiimNZe2m/ismNSLuOg8E+9t+Fobyi6P+uODweCv+37dF5Qe0BK7a9hUj4kKPUClyuapGp3xehQu9Tmt1uJ+4VWbRQJ5HS5JXNlBDuxFLpmxGTXpMSGsnzzDTGp6Q+dfC/vOFlodlJeEH9dFEEepSxyXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765435; c=relaxed/simple;
	bh=hy5Dpe3PfCtfedSpOotAyvf9ErOig2fA602NhJRaS/M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fjq1lPmnRue9+Wbvk0D7bR6112bLRtlZseBqsJgJHaYuPVtFGGSF17UpBny4ilCRKmhNTdTxnicTz8nPPqm7+2l3VlRvypwHGI/2OSQ/QbM1J1ko0kRtAHK0tZMdW8ClOGduQMlwouBvlSnoCkV0ZZehxNdN8v/MtKve/dSu4HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKVKMibZ; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKVKMibZ"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a4113ab355so7666714e87.1
        for <git@vger.kernel.org>; Thu, 14 May 2026 06:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778765429; cv=none;
        d=google.com; s=arc-20240605;
        b=ObdEbunrFXDvzSgqWatK0iJdjIa/8GSFb/6DWxjuDcSDRqd6mdP4aDQrsjP9rccBtC
         jSVyARRRgUkYP6HwU3awzQ8lIe6oarcTK6BdprHL8I9g2ntBf4yAC3e54oiNDMzD+q12
         5roLHtehBI0DonBtXnTTiN6a8gxvIQwFduthgnB/OPkktBfQX9wFkykaTntJH7NA5EYx
         c02mz3OWlAXRnMsZUFj02qS8iWJP2SRwschfg8XYi6w1rYUgSRlztqsaeeLMrXQBsxlX
         7Vnv0SMLO+PtPXDNcImkQ9Moq1xIXAZhHgGgmwrIIkPX1SeDC7IGi/nHK16rSAzc9BJ5
         WF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hy5Dpe3PfCtfedSpOotAyvf9ErOig2fA602NhJRaS/M=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=QiRqv6pUVk6o4L7YFilpX5Q4qSjcj9yzECQ15MQ6BOE0tCIj5kkE3OI7+/CaGjZ0jA
         D1iIXi0x1c+cRbzA33CGekXaR+v8YGXxXRM4NKIFqGNkwjAyz30gYUl0lzF86c9pGrjW
         e0KCtfOND91Rf+pX1vnGf1zfti9W908FNBpqlLd0P27W0CzHxAcA6R2U6rs87mrIW0gQ
         orZniiAEMrswgl5iBwXQ81VFvjDwPDJUc+H4ErjziJC3+DXObobxtty8ijUhWhkFDyzJ
         dABr3wqcjs6TzZBysB4/sBxIfGEL3a3++SM1vM5TMq4YKkUNMqA6jsQqXggzqEnmxwDA
         IIUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778765429; x=1779370229; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hy5Dpe3PfCtfedSpOotAyvf9ErOig2fA602NhJRaS/M=;
        b=HKVKMibZWzoZoSm/wsHaeZ9JKnEf4TAokzsK4NEblyctENzZp7T7ZpetXjlrPEKjls
         oP/sJ4xlYUyWBGkq56SMNNMlMkd+mHiFcb7v2wbqFNVcIKibwFaRXlbnOIByrCOPdEZq
         mdCYlexA/US02Nh8wCJUmrzrTJi2vw2CBze0H8s+6XDBsWxDU2W9BUeckROU2hiLtYF3
         SiBS0/Os88oR+4Rxnm06eY7ajCWm86R9mVSIpJU1StQqkewlUg1MTunzKob6Y5fveq6n
         4WQUaASwWnSEGXlqsVsqM7S5zy/VsKPB0VTZcRLxRIFU3V9pCq8qmavOTTqrggNrAZG/
         XvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778765429; x=1779370229;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hy5Dpe3PfCtfedSpOotAyvf9ErOig2fA602NhJRaS/M=;
        b=OUVkomXIXxrkWuo/xlSMURclsvmTTqRxODvS4AEhcyt6KXt+2wZJ2slr6pCzlE6Y8/
         u/dAh7/ixX7/fL6EIKxSRO9au2t5HmGDmIrF3taRnAk1pVWaAOqAP+KAIdM/5BredULN
         RMCwd7ssWrCDcvIvuCiZVPOlnWp6QZqmu3C40AcKrXQDCkKl8nxqUEerLn8shT4q9+Vn
         PexcPsLofrIiHLssHlJRJWs8p+yTqvBQwhi3kYeP9U5BTrkZ+952oARB97BScawdJz0M
         n+u323osIQMZU475HAE7P+m8z0DZ+hv7y/dUyehKFEe7OCojOIEGg6EH2nc4A+ztI9CK
         /svg==
X-Gm-Message-State: AOJu0YzYP5LBhbbfUPIv6KkCBsLTgVt13l8oHXxh8i8H3YSWL/8bT9Sh
	c+vZKinK7/a8myZ5g3k1dni1fBSvsaLXuOa0ugKb3R8f5bpg6FuoXcueCm2caEouwIUDekhsMvh
	UY1Qzfx1CiIKVt/vzr05HVxGRjsuCv2Kozx2P
X-Gm-Gg: Acq92OFDiARASjumPoG5bFwEcucJ3O+8pKClC0kymjfm3eNsDoYF4ekPMx8HDirT74S
	7eXSH92EafAu5MlHPXL8VIXne/FW++KQZ3Zw/qi/gC4nL5c2z9UIeDzYfWmE8028k4lmd8ZLTzI
	LnHMEzjn+IRlKdk3M52/EAC4MC1hPMUE0wtUqlUTU2wTNiOqoOYqmhaQm/FkDth0WX8qI0jahRI
	qZWkOhA9OedZ/H9m1X3twdIcwtLNFH7RSPRvdtJWrFVKr/itXKaAUnNil8cbkm2OzbjeD3RaDp8
	Vts2Ig==
X-Received: by 2002:a05:6512:3dab:b0:5a8:7b52:946c with SMTP id
 2adb3069b0e04-5a8ef9a8b96mr2609848e87.22.1778765429259; Thu, 14 May 2026
 06:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: A D <diop.alpha@gmail.com>
Date: Thu, 14 May 2026 13:30:17 +0000
X-Gm-Features: AVHnY4KXJCWgMKAOYhD-G5BgEsnaRfUAsv1ESN4JTN_U460UwRcKcZLmqwozPdo
Message-ID: <CANULcizX5J5zE+QgY9TOvqpjrcJM3uFOOAWRJzOW2rBweg2WNA@mail.gmail.com>
Subject: I object the social engineering from Master to Main
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It is not your role, as a tool, to try to engineer society through
warnings or changes of names. Your role is to deliver solid, reliable
versioning, that's it! Leave the rest to spheres where it can actually
be done without weaponizing your position or your audience.

I happen to be black African myself, and I never had any problem with
the term "Master", and its history for literal decades. The term has
been used in Computer Engineering longer than some of you have been
alive, and I see no reason to change, or to nudge people toward
changing it, just because it offends the sensibilities of some of you,
who I very much doubt are even black in the first place.

"Master" is a term with a history, and it's cool, if some of you are
offended by it, change your repos, but leave ours alone and keep your
warnings to yourself.

Cordially,
Saliou Alpha Diop
