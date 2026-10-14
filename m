Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0599E4F68C8
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976266; cv=pass; b=sOrmwXRAj80FcbouY1jpkJCTlKXl7MFUzlDSoKcGRahtPz+WTiRIoerAhbSXSwxzRog8zH7tXnY37M7tjLuXXFJvUrY9smCgBG2SwpK4cd3UKm5RICpJT9Ns4Vr93GMW2OUurcEAH1bPSIAtrwsrNnHOs/P51fQWuXjH9M5xvlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976266; c=relaxed/simple;
	bh=ULn2o9KaUPNe5R4tfBQwA9JltUcmDEjQXBwpGXOOtWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Grjvz2Q10sqiBRb3wbUoZtdxqZfFbLX1o6VZskBH61DPOYjW1vOGHihqkgZmmNAWfx5vklfysxwtMCwPn3Yc1n/ryMMR2IfTVpfRqyBPyga0b+1ifftkXuzlDbjySp1bCDr+SWwKqeUewEM1HA7LwevhABqv4a3xne1DzvfAtgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1AasKh3; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1AasKh3"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2e62319cfaso89228966b.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791976262; cv=none;
        d=google.com; s=arc-20260327;
        b=LcXCvR3FO33K1z/DI0b+kWiR9XVs4+wEH5i2vbmaCvUVTV2mDxlOBxjktA3iMltzs3
         7bB3JJLo3k0osk47IR/C9pYHa4jd0vvVQnkKSDDjxZadHl/s3tr0vAaOWd+AWir7NZA9
         HBgf1L7C5b9FOjaqo1Clc16SQlmBitZA4evuimHAbCp2d0IFtHBVcN+9gNNF1PoVnebN
         woxLh4UKncdiFwg2OmDHAPdR6X1+D0vVYvy+UJJJ5fMdkF8cZcYS5ykIAn+cSyK7cLRa
         wlq5Hx6uaQ6LAT/tRZPr65XE52pndpE55cfbzwwwGcD3upfNSj5D0AZ3iXVuL/9t2I0H
         9fKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0gEKSZkm5uGP+43GQdoXHAtKzrFq/cGnLPpvVU/cY1c=;
        fh=xEwNemFXS4bNjoQJ/u99Eqj9SfdLR39dP7gdi9L7gCU=;
        b=QF4HJJuJRNFnX4hXdOGPqepXvZYueXik1ybbdFQuj1ZR0fosuy3GPnWXeqyXAnjiE8
         PRpfracGJpfoBZ/1EeRcGeGISp6Q2+EoCSSModeaiLJqCqC7XtKO+F9fQCoYAb67Ccfb
         reIxNTR2swG81RtxQkELh7khMTd/QW3GnyyNGPywDqMCpGJIHrossbG9w1Y8g64tKOHp
         NT9c9O/xx39BGPSE3hlRSPtmoWqZbUcUew0SQNMtOmRGV1dCrNm5GGTqTiHi1bejbKY2
         GTXy7XPx+ggL5Yk94PH7L7m9L9jNN9SY5NiifiJ/14Cw+TD117cmcLBzirjdNG/FiaLl
         oKdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791976262; x=1792581062; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0gEKSZkm5uGP+43GQdoXHAtKzrFq/cGnLPpvVU/cY1c=;
        b=j1AasKh3NSfFODvd24xicNW16N0IX4Yg/GkLH2CXl2Enbl6t9WfL4BhRNyWr2u5XDW
         IC/rFZcF2rAr21bxCcNVwGmAW0l8dUp8rrZs88LG73i2M6k/RBSPKMeJlaiJUOwTBDlC
         ax9kCPbca18s+KQFN0bgymAc/2m7nqhR2mmDon/Co1qJa6SN8dHlaLbsMQZBUiAZezQ9
         C7QDUkytCNhKhkbTLTMhiMsqw3Js4yWslFy9Wn7adWPqCNshVIDs4F8lBXvoR1IRkqyo
         06DA6+DyJdqNbjeTLhIRZRQ3pvS723fMrtlCM2FEY0JtFF07kCXo44wPxiM/k66sKXyj
         SgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791976262; x=1792581062;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0gEKSZkm5uGP+43GQdoXHAtKzrFq/cGnLPpvVU/cY1c=;
        b=E6+Gs+0ykSR3ehzSQIZWay5oq6FwrCFqbLSwS/1cXwUuRmJJYrH3/6rol4tsFExZjl
         K7eCoq5GnrY2NGkBEYp3StS/WprckQduv0QlLSNlV3QxfytUjhG6frzZy8uWsrHG8FWM
         SWSFtYsY6hUeVSZbehmoTMGLVR/hxjtrONqj3OA6luQ3Od6ILhiyYsDlDCBDUW4LozRz
         E2jxA3lePtOfDdAER5GrWsOERCILFyjaG+SzZUo4l4aJtJvPe2KEEz99W+cwx8XOa1nW
         tUkwwRE7CSeBXKYDLd4uomvHqcSPSut4/ERnTrdhpd5bnGAWx7FRt4YkqYeJABZbjU+K
         zl+A==
X-Gm-Message-State: AFq9FYI+3Ws1iC3O344/NvyVo4mDFkSt4ClgHEB1CQ0MzaQdJ+M/RUF+
	g/bDVaY9S/jFdzYenU+7hmNVtMc0IBgJmvMjMnpAYgyeouZvJRTity2B7skXfqyX5AdtS75aF9b
	qIeGPKHXnLRIft7tAV2fP8VgpoqATjko=
X-Gm-Gg: AYBFou2OOXIEWmNXH8vklV9S+A+KxAvUF7h4zIR63eakJElbyoL6MRwYY/uF0TUVpoz
	XA30I303cKTYMbQy3bhGDzLmF96FL0z3EGIIIUDVDM2LBZuID5L4ARnnxJJ5W8MrEb6bLQ7QxMD
	l+OOPiUu44y1Esa5kri3we4Xi38Yxq+Vx2xgRHIXBtRBIycJnbzLMG6k0CqKF9kC6nBWpRZUCAK
	kdn/p2jMYPevTZkfZjeRsr4dldWJrU1RJi5K14KnxhzznFBxLGTRg7zEv4VvYVOzb+QtiA8/dgS
	OpHYkYaszRfKRE8mEJrdsbT9dENIhtnPNaz06tPK5Evz5xNoaYeTyywNycLCX1bRXJjRXwJSc/f
	mmiHMTgFLcNU=
X-Received: by 2002:a17:907:3e8d:b0:c26:19de:9126 with SMTP id
 a640c23a62f3a-c31aa00dd11mr1433303566b.25.1791976261911; Wed, 14 Oct 2026
 04:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014081209.61966-1-okhuomonajayi54@gmail.com>
 <CAPSxiM8xEA5zAUb_Wd0M0=PGD44XeS7=NX0vsdMcyid8-EOV+g@mail.gmail.com> <CAFpMFfBVSaGSoFfw9pfOcDWMKnLwnpMSyT51Nu7f-ZXE2NyxZA@mail.gmail.com>
In-Reply-To: <CAFpMFfBVSaGSoFfw9pfOcDWMKnLwnpMSyT51Nu7f-ZXE2NyxZA@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 14 Oct 2026 12:10:50 +0100
X-Gm-Features: AclHuK-nYWHySv6VQ132OJfSP8iGj1SmKTMNPj_z__jlzSb_9WfKBp-mwY0zoSQ
Message-ID: <CAPSxiM8NTdJo8TeSYNis20F0JNkTDwXn0hu_ukMkz0uQrsJW+w@mail.gmail.com>
Subject: Re: [Outreachy PATCH] diffcore-break: remove USE_THE_REPOSITORY_VARIABLE
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> Thanks for the review.
> I meant that since the USE_THE_REPOSITORY_VARIABLE has been removed, any
> future use of  the_repository without adding the
> USE_THE_REPOSITORY_VARIABLE macro would fail to compile.
> I see that my statement above is not clear, I would modify the
> wordings and send in a v2.
You do not need to add that. That is literally like explaining if and
else statements
in the commit message. It is not needed.

Thanks.
