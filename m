Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73956510E
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088111; cv=pass; b=BUF3hK0I5TD0+Fp8170Tgizpdg7a0BgCUwQ8R6CGvz8lfFUDQZl7vV/zfJT8cRz93aTFFQ/bwUmzRRyCdx1h1VWlUkkwfJ6p8LdSzysG4VGJa3PECLbR7GbpfBa1+ZDktCimPydiizSMqpc4dwUDDt6bm8tESA8FWL8nMqgIhyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088111; c=relaxed/simple;
	bh=GZtD/gYEIeaL1LEQoLyW8eXDUljwyauEVJDd1JCJaE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtPD8wSj6fCXUbzngiZ/fuvOC+fzjOgRHlOWB2XgY5t8KdgB3beuTXDqcOpRAnpNTam2W+nPk6FFWneCFoop8xvhrGPXMIRAhS3KR1oo2D4Y1PsDZX2wkfs6nPku0FIyn3YAYV39OSa1ED8GPs16UyISh3as59lKuUcA8cPvSkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwtgTvkM; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwtgTvkM"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c34bff61551so780923466b.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 11:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792088103; cv=none;
        d=google.com; s=arc-20260327;
        b=cCeUkhBfAMWROgqzpGWxsSQLHxpEtzsH5QcsJGYBWCphLTsVW/ArMfqQ2m3elHIuOI
         k/kssUlMsEqFj2c38G5knQkcjTUSxxHHDGLpXJEcrr8ZqgvDWO8XOtSF6Wc1eP5TrkkU
         giviSPMNMQfQsokh/VfSo2Urhp4eoBxA4RgwHCF/9NP4MdE+3dCAOW2o4pkm351qpzpn
         C/D9mz4QHr2RI+Wl5SRg1XJGZ/SqzG0BFw4raBhR7GIxdwGwklU5tkRLmM/XL+KF8qND
         5mM0qHXWgsMO3bUa4oyrt+pD5Wa0oCqJA9x4W5dezMWF790VwP7bGuvixITHb11LtGo7
         c4Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GZtD/gYEIeaL1LEQoLyW8eXDUljwyauEVJDd1JCJaE0=;
        fh=NwQ0MYnkSGyBJwSuWDblmSBDK5u1S3nNwk/5TPU1Qhk=;
        b=k8HZE1RuWf8oV+yzKCEFKwa0pR2bsh2yrz2w7PFNSMR009FLEa5fQsZ8GQSX38BcKE
         h5l1VQl2Su+pZtwe5BsP5TYOq6qojUv/Wcf7zegJF1/czXIXo9XAQkPw4fe2dSXO0ztZ
         RDMFzGDPduwyibiHdpqM3CV5n2nxiVuCol+uU9cMIfTP+AYyKCPQJn1Z0RIZODVMjciQ
         jwf3tON/Bh05B/QqvWd56V3iCD3siHJtELOpp+Jm/Sk+kuAnvRSmD7KXPv+3GDYUFmpF
         t3HhITfF0VGLf8s7qd+MbFCuOCBuxKdH+DW+ab72CbS3Mq8flYX1pzER+ceAqWDg/fNJ
         TPAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792088103; x=1792692903; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GZtD/gYEIeaL1LEQoLyW8eXDUljwyauEVJDd1JCJaE0=;
        b=gwtgTvkMFgFzGWOSvPeH8salVF+N3ebTnYWyJFBNaqwQbB6Hm+MQcr6+ddwU7AUR4i
         uqYhDV/sX/Pcq7oDUXMbxJVpEo2vprSwzuDBsMreS5GSoMPwy6XtUwggciRiqNNYzQp4
         YrD/RRmztQf+qKvGzex7KaIvsEhjLcd10ZuRSdEYb6qXO4DidBMAAoWS5oUpPfh4pdOS
         aTBhWwLYfBrNphgG+byaTBZCEi8ZvIrYklge1vzUsneh85ZIKJoAhNPt0diXFrDHjdN4
         TDcvtTf97dMM0Tdpvf5m2YceF3Q8oC+YFAq2uIdhbO8g+c91LrrNOZpdx9eejwkSuwGq
         EEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792088103; x=1792692903;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GZtD/gYEIeaL1LEQoLyW8eXDUljwyauEVJDd1JCJaE0=;
        b=atT2mi8wZ8LP1pddu7+OWIDrsP+bn37GmenKQ9dTyZxyx7TvxjTZl+awhJEh2rsiFA
         56JJV24/wwA7f931Fgg1V+yYaMBsg/zz16e0tqhRwKtCmpD2nTgVccnLQhOvJXQxhYDh
         kvAk3fZe+/nIcWa48E5GiMBv7nChFUj/fTqRUpSRtaH++fpqFyUtRTD0cW5Bdv//u0w/
         dQOyP3gVMEyytxp0O4L5JOI/yFs5iNsdt/P31GpKE/PGMDMCrzv/x57tRK/S1CaOFPB/
         O6xNCm6gtP89Q47OnqX/jwxkR9twvy6QG20w5IuIQNgL3ET5XooJyGnaU8IjZXwdcOmw
         KHDA==
X-Gm-Message-State: AFq9FYLB9Jzj5pMkkfOoxCxCyhrwlbAarGq7fziBy+Lh2nRfDhfeRDDv
	IrFlmgQ3AWzNFFu+MyF3XdGXmm/GAjO945B+/Ur1WpGkl+KWBM5uNWWP9KU8EIJaiCo+rOGeTGj
	yNp4bU6Io96F4g8nswmuI6gDuHrqSzoY=
X-Gm-Gg: AYBFou26ViwwX8JLfdAAmbXPTqRdZBfevf/4Z4odCv7mQ3Q1/ESLCwxbRxJB6HsGdmX
	E9W14sGrCMErg/Mfb+wQva3cinizJBalhd4MCmPCotRCVvlhCXLgzX8qP19ddiRqv3fGpQCQUDK
	yT37O6TY69qTIl8hSUleLlDN8oaufj+paRdYvCWQoUK2zQ7xq3KpNeF5btEfIkWi/yL9dj33P0g
	wIxW2/ws/aM/iEZFeOxj2KFHbXYqswBuXvRzGd76Mj93TAxosLm2zY3wt74AnkBlbXVLfLW28uL
	yCpVjUEJCOkS98ny2T8UWt0I2lv7odXYwJ1WerQJJwpTezjLG7ecngagag7Uj/80R+KBjm70/iZ
	mf2gx9leS22o=
X-Received: by 2002:a17:907:3d09:b0:c2e:5efe:f1cb with SMTP id
 a640c23a62f3a-c31a9fe6bdfmr1851889666b.8.1792088103241; Thu, 15 Oct 2026
 11:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015175131.1739-1-kerylefondji7@gmail.com>
In-Reply-To: <20261015175131.1739-1-kerylefondji7@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 15 Oct 2026 19:14:51 +0100
X-Gm-Features: AclHuK9Y0rfDNV7stC1e4wg_-cKU2M3vyAxaGrpSDfbGDOXAdb0WPaKhFsAH0dQ
Message-ID: <CAPSxiM_So5LMC3cFm5Ob+DN8Yy_nUu4n0SAHhkpSNKV5cVTf_g@mail.gmail.com>
Subject: Re: [Outreachy] - Keryle
To: kerylefondji7@gmail.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Hi everyone,
Hello Keryle,
>
> My name is Keryle Fondji, and I am an outreachy applicant. I am excited to join the Git community and starting my journey in open-source software for the first time.
Thanks for your interest in the Git project.
>
> For my internship project, I will be working on "Improve how command arguments and options are scanned and parsed", guided by Christian Couder and Siddharth Asthana.
>
> I look forward to learning from all of you and working together through this journey!
Hope you have fun learning and contributing to the Git project.
>
> Kind regards,
> Keryle
>
Thanks.
Usman.
