Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5314929429
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047809; cv=none; b=fJRESIRW28bqivmsB0GwgypY5He76nK528VwguIPRQI+33q743RECHuxAED20BucEi6wUNjeU2DO/QP7xzRLVfZapvbK2h/X5gZ/PPJlaqM3kcUhvnsiWq9vdTavhlIRbaccL4yS1Snv32u+VbZLmT3bFSGkgC0JDrBsiL7/fUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047809; c=relaxed/simple;
	bh=FUFTMQq536GzNONhsRd+wX+Hu9IqsZ+dT9JVnXlAWfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWbQPWl9uAvHrI1iOg/hOYc4FwXXNG4umOrvFm+vsXVrhRXmwbICvci8KqTDZ2AZzd5/sUses/hFgkAYz7uDH1fVA4QqluBEvk6PY7Utlcd7im++GgnTKsScEW7w2XzsXYAzzDLQoM/gNYwsRaYuEaJbW1kX+6acUaUP61DAd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JM0Ep2og; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JM0Ep2og"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d476d7972aso70648861fa.1
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 01:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712047805; x=1712652605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FUFTMQq536GzNONhsRd+wX+Hu9IqsZ+dT9JVnXlAWfs=;
        b=JM0Ep2ogPJAYNfBk/SI8zz5EEq/qNWmySO1IznEAyB8wafgm4Sny5TNT9SpMKECqrW
         uesIj7G8Qetl/TQynMhctldCrFcC8AsYqy5cK6bunRB5dn8jP465FQmsdrA2Vg2Yb5Qq
         3io4SXPrRCDXTKc7Xghw9liTD73lteeSchlz4aFEvHDRDm9yUVqaib+dFrJZ8ZMEV90g
         IytsSNEGdwFw90WX7QLQ75relTmWjR4omjkrBz8+PUPsHkVk0PtMrdRRgm2GMcmohLwa
         8unGglCM1A95MXflpIecEpnnsNEwzVHNJqry7HMp9LFNNhExqfQgfi2rhGwgWE/xTy30
         1lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712047805; x=1712652605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUFTMQq536GzNONhsRd+wX+Hu9IqsZ+dT9JVnXlAWfs=;
        b=kom2YLIv3CkyyTlMQp3kWeuRmUZgmKIQgj790+TtlLztH0WzvLiqiFvyRua6KX6RJt
         IDlZXKjyJnqArHCR0C83YNszv/64c8qzk7tMzhhcKBiGwJJYmvlojBYyB5J+D6J44i/o
         q5jhnPhbt68WwWsI4aQhc4QdZ+L8/dMwm+5jaxNjcZJn9m+bvT+osSiWQJGAjomEfM7S
         K9WzBaBu/3NO/zZwPSrEF8A+FojkS0KiTUPwZSxqluEnSAzfjNUkUNKTWuy/Wdctg3XT
         p4UEuLfM6GJRr2ACouPdG11+i+jfhJ319/orRXlhyCkydVajm0V8TbMAZPN5IPlgbQe7
         nBzw==
X-Forwarded-Encrypted: i=1; AJvYcCXHvdnWIJWeuIv4W2b2l+b7tQBYCHbp6z12kTL/b6lHn2G4bncG7cNuTBooRSRXpK/j62wD7C/5ujkO+KmAUILiYm0i
X-Gm-Message-State: AOJu0YztoLCYYFqfXe2OqNhnqZOTaP9eGQ/yNRq6GzeaWaZGh4OD8u22
	SBiQ17TKgOa1LzqsiKoi9iiABjoptHwgu+U044jZj3kSjEmdKG8658lI8QqsnskZlbaY4cMvNMd
	Ah2mX3IJM2Up5gurek169WWXxHtk/GoYWHSY6ew==
X-Google-Smtp-Source: AGHT+IF75p3/0B//bNrsFw7P9uk8AdQitYD+O4hSH+ONpcY1AJOI2KCsy8M6TdVFO/uAE5Wcj6aRJGjTxVsCmpd6BIA=
X-Received: by 2002:a2e:a37c:0:b0:2d6:c61c:90c9 with SMTP id
 i28-20020a2ea37c000000b002d6c61c90c9mr6434395ljn.53.1712047805187; Tue, 02
 Apr 2024 01:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN7Jk_2mMiVjXuF02S14OX6Rjq2jVjNxcUbZvTqhcz_YMnD=gg@mail.gmail.com>
 <CAN7Jk_0hyjx39rrO1PKbEcJQXLtCYkWP7A4mCv01DZu2ffGHyw@mail.gmail.com>
 <ZgUdKU5uynGrJ33f@tanuki> <CAN7Jk_3Y+Ls2VjhQqzA3Ymy-WDv8nT+v5bzU2a1YGz+j89vPgw@mail.gmail.com>
 <CA+ARAtq85UYD0_XxPPu2QnWQ5gjpSMrXkTO48DOYkfu5h_1NhQ@mail.gmail.com>
In-Reply-To: <CA+ARAtq85UYD0_XxPPu2QnWQ5gjpSMrXkTO48DOYkfu5h_1NhQ@mail.gmail.com>
From: Sanchit Jindal <sanchit1053@gmail.com>
Date: Tue, 2 Apr 2024 14:20:02 +0530
Message-ID: <CAN7Jk_2ZQarqVHVCk6=AoUR3sQTFQrK7dfdETwpJvvrdxK6YdQ@mail.gmail.com>
Subject: Re: Fwd: [GSOC][Proposal] Move existing tests to a unit testing framework
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 11:46, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:

> > ### Availability
> >
> > I am expecting to be free from my academic responsibilities by 4th
> > May. I have no further commitments for the summer and will be able to
> > provide about 40-50 hours of work per week. I will try porting at
> > least one file per week, depending on the community feedback and the
> > pace of the development process.
> >
>
> You have mentioned that you would contribute 40-50 hours per week. That means
> it would qualify as a "Large" size project according to Google's
> definition [1]. It
> seems you have mentioned the project size as "Medium" while submitting the same
> in the GSoC website. Have you done this intentionally considering any planned or
> foreseen unavailability? If so, kindly clarify the same in your
> proposal. If not and you do
> intend to contribute the said amount of time, make sure to adjust the
> project time in the
> GSoC portal soon.
>
> [1]: https://developers.google.com/open-source/gsoc/faq#how_much_time_does_gsoc_participation_take
>

Hello,

I'm confident that I will be able to dedicate ample time to the
project, with the exception of a few days in July-August due to my
graduation ceremony
I'm open to changing it to a large project if it is required.

Regards,
Sanchit Jindal
