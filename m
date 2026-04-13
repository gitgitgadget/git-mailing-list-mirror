Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760113C9EE8
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095167; cv=pass; b=qh0OpCBMwzpi+FArX3nULtiDNTdvRmIkKVtkgWT+ukLdLmQXlZ/zVESO5e5YPuk1C0rf7mW9LFLoGgFvHNRQugPJBGmsjgJPRrZZ2hPs82nEiE86y+Jk6GLJNiF3FvEeR2Kxa93b4yU6fyl20bGWMAWu0Xgy4A34CQYOQZVVXt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095167; c=relaxed/simple;
	bh=qWMYqc7FWl38p5m2r0p9LmSmaGPKG5whb3wSlS9PQwQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MAp5uwUVGL8QypMw7IitTX2QlXDJ1c8mTkxL2nsgbT0xi7UvpYKzkvwxjXJDas8ZD0HTp/YMzUWS14szYb28ls5AR1QKIwmiNF60HFT4UKZsvsIDMBdRsYcC3TXkXX8XGKrFn8jdNXvdjmwUMXYNrkD2Z1a2tdzowna9yKMfTlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPXEF0VY; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPXEF0VY"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ac9ef74131so24685396d6.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2026 08:46:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776095165; cv=none;
        d=google.com; s=arc-20240605;
        b=KZhxuBtryEtjyLaRHKvmk2sHlXIzAG8pteaiE4nNJJFN+VWTDM1HVATbwabuCRoTMG
         ujAJM7lc2PiU4sXmpbf7Dny4S7nKkqhHpZ25txgz/P8ZVXLGuNQVO+IG/zmPufzvatAs
         iz4M5q10iqZuFouzNAobwZKZtN/J4zM7PM1Fr9N/yYQFYbMoP8EA/L7ExKnvcKQOlp5P
         UXy94hV0uHtc6jKu+5Q1qZ5wX+IhVBGacVehDyFHUw8Q+8L1IhxIzs5sZiOBnng2KYZA
         j5eu/IUjfc3w7Ysj8M7EJZ1LL3wTWFiAOmMXlUFpPAKUwk0UArOu3efR9/vxSAcUSTPV
         YLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qWMYqc7FWl38p5m2r0p9LmSmaGPKG5whb3wSlS9PQwQ=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=L4gMPe3AS8HjU6iCaLyD2Op3K8Kt5yAwL3XoXhRNyd0u3toC7Kjjz+9DKs2+94S3Qq
         nqTLXGiEJ4aRTZv/4L8vENFZieXBor7MMvWVG1dejhZVvGAdE2rGVMxGzwm60mfNTzWm
         7ESkoUjkBz/HuLltVqQX5eSK9bBB+sUs/sZHXmPeUBb5XMPlO0Rg5x72S1BEWKZURKcv
         E6S9d+Z4itsvjdzX+2gkibYZ0JPs2s7i3qjzsiDCvTOD7o2oYWjSdXJAlKRfAnot+9Kr
         DKtNHvHYBAsBEWqV6pzNlwoAamio6DjYWm2OAWHdrPDQb9o99zHTZAgdE0LB72A5bM25
         1Hxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776095165; x=1776699965; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qWMYqc7FWl38p5m2r0p9LmSmaGPKG5whb3wSlS9PQwQ=;
        b=JPXEF0VY8A+FKKrO7hO7ujgtJh50Zee9lRTQsa27cJPXQBzZ+CuPzpkn7/CtKM3Shh
         UD7TO8wPWVpf1S6Uu6IJYkjeod4FnKbM60YBvveZL4JOb9YF5oFiwlQXPWv5EWGR/wBw
         PemUEZ0YeiLw+JKc+MfA2NM61+8wT/SpQrvlGehx3afaUGzt85kMe4AVt8fA8577CDoc
         bWoKxpGAyUg60eUSaaVxhZPS+0Yn+2uW/gtmU0XqSgpzxYgML8N67O2oKNVSE3fK7tCX
         0v/q9z1NM/TWbvI2Chp7zufYPQlU7CvjcFoYDpXgtywg21OGJipCIsn71kzKkxQqA9QI
         e8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776095165; x=1776699965;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWMYqc7FWl38p5m2r0p9LmSmaGPKG5whb3wSlS9PQwQ=;
        b=slNN4rVGmy9OmkU2kNDR4H73aim8PHr9YEGai+cEhPAJukR+zMd+chU56B7c6h9/Vg
         fZJhm8jK00IWv/1K6mwz6qJdtTCG3ki8ah8BgDKJ6ZoklawcQibYsGckhaPyZ5wA/GOI
         XA2TMkz7c8JILkytsB96Ax3zUBxfQBYpcv20tyReztxzhu2MKivCabRg6G9eRXz4m6wm
         o6somtq+01AfPLbwzDWQa8RADmRBx68cyYsEevFDEQdZ4Kp+hWTpCQvvM0o0QAy+r8hZ
         R383JQPp9GOD1DQ9InYeTHh6zuHKBTpDwQEfTsIugnFPG3hqMJZ/thmw+7cSO1siNZmk
         NAZQ==
X-Gm-Message-State: AOJu0Yw4Qw8xKZhMWt3UfLx0NIuIsTPBOe+S4zChHVRQG6oVvBUfSl9l
	Vg+BxCEJbhC3kUsVlY3HgeczGB/43SluUxk5hdWZhAsNF+CMN50Fq3nQbrO38TLEl6UK5kXB9ts
	wSg9cdIV/6tpjGaa/siEESsoXCZX7bntoCn+xOOY=
X-Gm-Gg: AeBDieuK0Qnq9uKdFpEXQJSlWjF9647p5ZcLTu9rzdLDQ8BxTHi+8NoiGiI8Y/BTwfS
	Q//eN40QNXXIxAgUjW9Uiu/gGNt+jZQbQYIJ2PtYLBIJ/VYcmXWaIajaDIrlaKp4P1ZPN5N52dn
	VBplTEzGsp0pm1WmrAWpRZi5Yk+oA3t4SIeMhR7WdRCujiycbItCKrvzKRbTL5k03s7kw35u/vF
	DINPN4cyVLzl+Slr49ixfUvIHvOyBLSC19XkF4KI/CcXQPYGAo+hbAIsnejJXdX9Fjjt5+xzO1t
	p0Hm2S1xIiR5p3s=
X-Received: by 2002:a0c:e004:0:b0:8a4:58ff:f0f8 with SMTP id
 6a1803df08f44-8ac8628a171mr183126166d6.29.1776095165026; Mon, 13 Apr 2026
 08:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shibo Xia <sbxia25@gmail.com>
Date: Mon, 13 Apr 2026 23:45:53 +0800
X-Gm-Features: AQROBzABUBw_IieKDASmVIcUwVV1aXq3dQdjEa6f4V10iHH0Q50a9sKlDP21KWY
Message-ID: <CAAC4ekqE0rGTeZA3fPKYePr3=J8pHe-KORgn5W026J8AAhRRHw@mail.gmail.com>
Subject: How should submodules use different sshCommand during initial update?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a question about submodules and SSH authentication during the initial
git submodule update --init step.

I understand that there are already a few ways to influence SSH behavior:

core.sshCommand at the repository level

GIT_SSH_COMMAND at the command level

SSH host aliases and other settings in ~/.ssh/config

However, I am running into a more specific problem with submodules.

My use case is that different submodules may need different SSH identities or
different SSH command settings. For an already initialized submodule, this can
be handled by entering the submodule repository and configuring it separately.
But during the initial git submodule update --init, the submodule does not yet
have its own local config, so there does not seem to be a clean per-submodule
way to do this from Git itself.

In practice, the usual workaround seems to be putting the logic into SSH
configuration and encoding it through host aliases or URL layout. That works,
but it also means the authentication behavior is kept outside Git's submodule
configuration, even though the submodule remote itself is already configured in
Git.

So my questions are:

Is there already a recommended Git-native way to handle different
sshCommand values for different submodules during initial clone/update?

If not, would support for something like a per-submodule sshCommand
configuration be considered reasonable?

Has this been discussed before specifically in the context of submodule
initialization, rather than per-remote SSH options in general?

I am not sending a patch yet. I first wanted to ask whether this is considered
a real gap in current submodule behavior, or whether the expectation is that SSH
configuration should remain the only solution here.

Best regards,
Shibo Xia
