Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792796429;
	b=u63Zfd8O/QLGlE2m10cI5pxBmgxG7ZK+Tb3SlXZ+g2Au1x8JDIVbbKMDu4c78/imG1xB
	 HnTjeP8cNwOKXHZhHmBXY++dnPsXJPMweLqu87B2lI/bF9vX+FJZ2qva/q8G9IdWBAO/L
	 90I3kQrkd2ivuOO6ChiVGjF4Y/kF9TltUWHbazMvyP9g36Eg+skXjdqNCRK9jtucLoaFw
	 weq9VgPUO44icGxMnoTEiz9c9KtEMYL9ojVHpb+PWrSvRnbKiMIq/qJtwAeTLflZaLS5Y
	 TE4nYZVUAdUpaL6J1yP0Cr3U2KiCewGUgidPb8pnkhwWEdc5gaGc9gFr82kcl2IgPWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792796429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=CPjwsyeWcKtSwu2jL3k7ty2O5Pn3m6xoQXJ7iMY4w+k=;
	b=ZaS/s71amWROr4scRcsqoi2hRq+9BMa0tV1KGLv+4SStgRR4+rMEm4n4lO/xE6Ck88ng
	 VRUJ6gZ3A9X4ifogBisF/lWWCEV2m+JOPEGXvwm0Q4sev7wpHNJvDgaXBn6v1DRwaxata
	 SBunoiv3MjijkKIuzzCO64AVXWMCzcp0cZ/YAFmq8ct9mJLg5Qka5NuRtA+wbDdcnNW2e
	 egora/fjjLqXc2kEYkUy9nCNmleJq3WaVhOT4zgeZbLeCXY4Ih70n8yLzoCCBfIaCMleG
	 VN9nbzZjHuDONn6G3ASParSF46Fk6p8e/78cM+/pBOHb/fJajZcSLnd4yd7N2joFG8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ECmHyEQV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D14606A321
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 23:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0D14606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ECmHyEQV
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso2027644a12.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 16:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792796427; cv=none;
        d=google.com; s=arc-20260327;
        b=AJWrhDbXnLxFtKUomwDWqm3hGtpQeldTvbHTpc1I+PrZKzeWm2Fw7ZfVn1bdBVdOjX
         d89h636L2MOLib6r0+jXm58ToibZsrlDPy/HeUjiU34BPmEkoHEkT+G5QHa+Ddg/xlI8
         qhhgOQr+QyzA3JwgFjXRuNC/Ah2/C9RSx4ExPS/HOY+8SaxNUXP5ldhUoKLGNzj4AfK7
         B2qSIleIZf5L4Urbhjv94vzSuzXgbpj111jUd22ey4oXgwKvVECpf5+JA91qAduC1dVY
         BSK/G0wq0aviIMa7iwDb1kOaYWvbdc94DOXXdWhax08Ii4TCEdNjHqQ+EWQGCAUgwoIY
         O/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CPjwsyeWcKtSwu2jL3k7ty2O5Pn3m6xoQXJ7iMY4w+k=;
        fh=jZt1LvNszC72EyqZGT3p0DYNjJdZ+X9ztmGHZRlDCSk=;
        b=P3sGaSfbkBdb1gZUVOeA3gkZgSBrG+shFqtXmQkT6IJ9Eh1DnyIOLBLapgb+434KHf
         RCerHYwlSMqyM6EAdymvUm/Al3eR1YQESTBXmPSKfkaGQg2zbq+I0iBc2WW1nszpPjmH
         cN6iDOozL8JPimrKExB0UnfeY6M3hhFl5XmGSyWjtHPyIfhGXD6dxHkF+hbqHq57QwI7
         j5h/UZyPN0rhOEjafKTmDQpShQ4KsGKOnPM7Cplr/Qhe0UiBGgfmfH6pUFcaaBZsLosi
         DEPQCOW5Bw38L3V7S6aMByyDm88PKNBu9ZVWCqF2hY9Q/Tld4w6RL4HnGtDAHMPDz/fA
         J72w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792796427; x=1793401227; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CPjwsyeWcKtSwu2jL3k7ty2O5Pn3m6xoQXJ7iMY4w+k=;
        b=ECmHyEQVTxmGOyuEMhLmK4M2eQBMK2/UuqR2AL26te/uqP5AS5QlHVJt/sZ8B8ly5h
         Kd5ZyvMygGEBhYe0wvAuaztzxMLRu5pAIhcNk6lVoQVvMDdvvW237LeredGyz10yQhDL
         T+ytXMSDSG7vfSFg+vprIFavFmUuh9+S5CYovpWRQ3PfGsM1glSNKNE0kjHBnSGUglNj
         LzTBYmGDjebQTMUJSfFssE8fDQKn/larCE5Rhn/2l2bHLZ72DOEcpBBmx+wNcplTWuxi
         PksR1KeDWoWql7l+k+G3X1XAClxRTrpA3WFdSC1p9f5M9HzZnePB3sTp5hKtMpWJOxZ0
         hQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792796427; x=1793401227;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CPjwsyeWcKtSwu2jL3k7ty2O5Pn3m6xoQXJ7iMY4w+k=;
        b=WT2Z8LiN+QEkepdgmVw/AaxIUS52U5eW/ExegcG7+kYzXZxfz4pJ3FFJbHtjxFoR5/
         JUaFEA+QRa+TUq5WeQHxg3MHprjMqZO3WtUZzNYITJxeMvVuLLmqWK/1qIOjtQE3JWXF
         4SRPdq+c548LIr5N96qp+8fSQev8qL+v8jNtY2FJiv2Eqx/uhxTEY6XMT/oUyF6NcMcX
         xZ3TGGndfDNAbeKlJ5yH45q9DWaMOaPrdxj5DWTZovd7vFyuz+eW4KhBEHLKHdTSLFjH
         3agFW/EwhOX342PsigtgV4mszKCIMwPK5ECrqhLPmydt2Sj/5Mc8B1CWWlGYJWzJA1/E
         sN+g==
X-Forwarded-Encrypted: i=1; AKwUvByCy7R3vJllrz4UDo85IxooWaF3opSicyt1YwYjVYMF8NoIz98zT2jkuxBrnEPWRcdc0lg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLj0X1J7ZC7C6CF89pJc2nqQN1hox7Z3v+9vgBKLjLkxoiWRh8
	V20Bni/JD6hOBVZFnE6tZmwmPi038R2vrhCazcyzekVzaP4MKBBnmqP1lS4Rlk0vnN5liq8yFu7
	DTO/5dB/qvtIZ8Y9lvSmU6jASITEtwew=
X-Gm-Gg: AYBFou0DwpQalwTqCnBPKNsxwpMpJ8UidMe0rlzx3x7jGMLTmgDtl04BBx5YMJTYq8o
	iquOYpqREnzNdz5VX/Jr7i+mgIyYXiSGhkF+u+GSGLB6Y3Hk/+uVFgup5FGL/wkoznylAqujnKd
	SXD2yMmKLnzOA35LwhAfxWYeJf9W+0CtJk1+DNBwz3noeFw82cnrX2xy0ptr9icmfMcOmODSnxf
	lIIStgRDnuaNW/lLwLNnPqzTqTV9ogv5tOJqldix3ephlVgOxW3xIuRcZo2l+9/m837+MlLlm54
	9R71ucTvq0YqDCRYw1EadcF3flj366qkcsylUjbPdEDx/aSG3ySBRbIYltfHr9ihOpaqSCc2r/G
	7pRoalQ7ThxZ7MIYESNiJTaHSefs30xw91pMWug==
X-Received: by 2002:a05:6402:959:b0:6b3:f7f4:4e40 with SMTP id
 4fb4d7f45d1cf-6b442fe590fmr540543a12.11.1792796427100; Fri, 23 Oct 2026
 16:00:27 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
 <pull.2403.v2.git.git.1792774249888.gitgitgadget@gmail.com> <xmqqa4o43x6n.fsf@gitster.g>
In-Reply-To: <xmqqa4o43x6n.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 24 Oct 2026 00:59:50 +0200
X-Gm-Features: AclHuK8RX0uc0yAbcUhKE7XPxoipD_yC_u3YL5YQfQKp3-Dp88txo-_pw_6VOCI
Message-ID: <CAHwyqnUmEx5ykHD03QTXeHwS8MiUnv9UEru0FBM5ixw-KDV4YA@mail.gmail.com>
Subject: Re: [PATCH v2] ci: fail the build if perforce, git-lfs, or JGit fail
 to install
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

I interpret this as needing no further action now. Is that correct?

Thanks for looking at this!


Harald
