Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749BE823DE
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 03:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654993; cv=pass; b=Ou32bRUaNC5QQL9/alIoGQbRnFJPvtjmCKiMbVoH2MIrYk5wvZD4QW//Hy8UObNKaqD6fDjmhCA5lSwkyBv/q1DnrT9TpZM+hHVrRshVfsho4U7QsV9IaYQY84vLUdlafWNR3z631DTRU7svYKrSDVFPl876kHTl7E0EIHGoFq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654993; c=relaxed/simple;
	bh=HP75WplMHUYplEmQf7Bx4eJXJyvwY+ji2dWeRQCwquY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrYnfpOg/MntlrDaNYwjWvsnc6HkGMDuf42D2HBLJwTyDFdOyQz3MLV+n2ebPXNX3N9PXvYVEdEhrH99ytxysiwJ7sALma8iLeMss/KXkK5xBzc1H2Or+xPEodC0smAw9vayOQ2sFqHvWDVf1n0+9lmKe/XMu8b8TRzb1bb+zM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n7dSX4VH; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7dSX4VH"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15b75c9e48so67243566b.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 20:43:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783654991; cv=none;
        d=google.com; s=arc-20260327;
        b=Ksrzy1Rpw2oamxge336eWjG8bruC5rTr5YxlHG73ViMv9QJSSWDphGDzmyUCmz9BGJ
         vJUh7l4DqkppI5z5DHs9nWSfgdZw+zZGHDem6WDJgKLnzZx69QS/Z/hjmyUn0Zzf+AUQ
         4O17NijWocTuw+ibt0IEvztOH7Ly6cn9gdo2/4IsEF6HlmqYEL0L9+uDSZM3D/3G2AKs
         t0EybJoAc5nX2ar0kcptH6Tb6NG/iuzXzyvMHSr2uiP9cRYe5NJ9R4dahYlPdhRruS91
         CFj3Rd4q3w6FJZ5mIDQBmgtxPJ9o2ixRIJH/ng6rz+sSTucidOgUajarjUHMEyvtZxqy
         yLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IeuURvsL+tT71wlb5J8tmXcz7M0Jql5iIfS7nB4beW0=;
        fh=KtXoWdPy230Hiv+XXVVmyVGna/DRm+OQ7d9YphPzuv4=;
        b=IENFEAAFBJaknwDb468ZNThjir/qjXUB+1slDN7NZyKpHe0B0zn+cF4lZZ8MjIJU2l
         9d0dAamGuwjkTTcqhhYl3bopH9BBfTEq80cFlapzEa2gwIBhkY0HMtVsfjcyraOl6fUh
         jti/p/qaL1FU87ni+jtomn1OVk5KSnPeRb3/CSZarI9yR4rjrYeayuFj8fDBioZL8/J1
         tqQtdL5CXQWt4pYTeVuLuvv6EKlS9b2DJQKfhbJncfcycGhJBQkk7Bla5MFPyOWmPJqH
         R7+jR/RNPgDyBxNZr+w2C8AbYSbF+3By6iRMXaAQcahYTKxcorxRo1V/oYNIsWU34Ptj
         wIKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654991; x=1784259791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IeuURvsL+tT71wlb5J8tmXcz7M0Jql5iIfS7nB4beW0=;
        b=n7dSX4VH4yzSj8f2xN9MCnkz9vHXv7FHLIJF1Vu5FyyuSBc4Q53frxjlaq4CgUntXF
         szXPob03Hu+ai4bM/htcWzr2QCpaocu6wLXAr7QP6mVf1pBh8Rz373iudSEMkvRytDkr
         GEMkOaxtd67rQpqGy5xzN8lPPa4sQb8NxIix3YuBlXbYylP+QcShlD6vKqYrYpD2DW3H
         s3TLPNn68csbPMRn0oMBZvMh83UpqeLqduriU/Q8DC1BMxSOEZprWt+Z9X0Xga4wDi0A
         sPbwn7AP0d/xY2dIrVom//VBlVJqKttuRq5zlvPjVYfhfiYbWdwaJSMzI6Wjr0+VkAgC
         TLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654991; x=1784259791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IeuURvsL+tT71wlb5J8tmXcz7M0Jql5iIfS7nB4beW0=;
        b=K7J7z1HvShmYaAJpLK0vozVI5kqw+izdyPuq9lJaWUOdfSG7oj37P82CRLbucVyBOW
         AM46qy4CHlPPpUmXYTI3X9tc4BPegoy+n84ZVQd22j99gQ7gPQQk1iUUoSEuNjEvRmz0
         7PlCNKCwItxj1suSMu+a7r3SKh0K/XIIpgIAETBSsFEpnmaB6/Ny6sTAx1C37HqenoXv
         /IXOSVGv9NRpWRdw/eILNjqnhlynHeCzwfXMmi/fI17goJUC3g9vca8v865rguDWfW3h
         uVUUYc5cYMQfsCZZ+aSlA0d+OM2ktV0HI7ES3OQe+oSgfcZ4SDD0zfXV/v6e+83Z2x+p
         NDWQ==
X-Gm-Message-State: AOJu0Yyi3yksK2Ft6FaiQOEEZOpRo8cOqduQomhY4hY2FZF/c8MryH5H
	ReOSb/02hY+VgyCnQaOKvpiLz6GZXFwbMyiBXie1SjG8z2t1rRW0gWRdcPGLndnvxyzT9OU/n7v
	xCLyZeLO2PnA0Iom2+dF0NC3wc4j7uL8=
X-Gm-Gg: AfdE7cko/2sYfgFgW9MPXNzIhtJPgKFapdIgM/GgQlRv0rwIN0vJPu4F90rkYMc3+pX
	EzcJVWNXywQjR3h9uJo98x2hmWPFKWP2XC1B0Ee9vUdRSOP/GEFClRGwQGmgaayb0ptoNGGiINC
	6ggPYeErDsNnPUDX6FAPcJopw5hI5xwhJnNfgN0LbrooVV2oAt8FwwKKpblkldpSNRVC4BcmOBn
	Zn9KMEdYnig1jD4wi+dJmQoK9y9jcBwf5KTdPRA/1egorFMq3BG/6nOwrg12mer2KJt7UV5nkPb
	4jetH+a3PfcU2D4vte6XdJ85K1SI
X-Received: by 2002:a17:907:e153:b0:c12:5b6c:9b8c with SMTP id
 a640c23a62f3a-c15cdfe9aacmr294393266b.15.1783654990674; Thu, 09 Jul 2026
 20:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625194330.3711-1-graysontinker@gmail.com> <xmqqtsq7haev.fsf@gitster.g>
In-Reply-To: <xmqqtsq7haev.fsf@gitster.g>
From: Grayson Tinker <graysontinker@gmail.com>
Date: Thu, 9 Jul 2026 20:42:59 -0700
X-Gm-Features: AVVi8Ccm7WWD_gsrC5FF_VLrlZ5PH-5vAokU3WF7MUfeVu3bgv28sQX6GxTl_WQ
Message-ID: <CAAr3fC29Mkn08B4-TWF9Vuhng0TcjV+mRGFa9DjkxgKixB_hXQ@mail.gmail.com>
Subject: Re: [PATCH] gpg-interface: still print ssh signatures when allowed
 signers file is not set
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Fabian Stelzer <fs@gigacodes.de>, Jeff King <peff@peff.net>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 6:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> If a user runs 'git log --show-signature -100', they will be spammed
> with this message 100 times.  Because it bypasses the
> advise_if_enabled() mechanism, there is no way for them to disable
> it.

The downside to using advise_if_enabled is that this single line would get
turned into three, with a newline in the middle, which would decently
disrupt the view of the log until the hint is disabled. I'm not sure what t=
he
best solution is here; I lean towards keeping it as is to reduce the overal=
l
noise level, but perhaps those who use this feature more would disagree.

(The previous message was also printed every time, FWIW. So at the
very least this isn't worse behavior.)

I'll make the hint disableable if you'd prefer.

> However, doesn't cryptographic verification still provide value on
> its own?  Even without allowedSignersFile, the signature at least
> guarantees the commit content hasn't been modified since it was
> signed, even if the signer's identity remains unverified.  If some
> users rely on this purely cryptographic validation, they probably
> won't want to maintain an allowed signers file, and they would
> definitely want a way to squelch this repetitive advice.

Allowing for this usecase was exactly the intent of this patch; I am
this type of user and had some annoyance with this.

Thanks!
