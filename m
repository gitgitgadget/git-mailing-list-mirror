Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99BF1D1E71
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112265; cv=none; b=caLL+sn8FfQDRhYmDNxEoxnrvdsg224MNfA1oy+MnKjWzrUxskFa720m9I6NFyf5PopAhLAHEhSzKhyEzTIEibktnOUzpSCNz2gjFXsrOj3NhnFVXdx2qf/CK95+0MqmuW6a8iVoJEB/YVJ58l2ba9RrE2iliAZQb3zYncgNmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112265; c=relaxed/simple;
	bh=Agp2S8rMwWFLEVNL5CIWjDleVkVO5cpxE0ue0fJMfGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vng23rd1oExLdhmwGQOsNm3aUuyY9Qtw32nmXjeQGlZpFbaoChhLu04b/dFFoZQlYg2ruM61LlgSCkUFmv2udk4RyXU2UDIHM2B6v8yvRin6/nhcddOrdi0WxWiJCHhAYq1ac4pKcNPFf96m8gJUH/eN9ObUTQHbAqBb517xfko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wVZpoFD8; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wVZpoFD8"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e28fe07e97dso248782276.3
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 13:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729112263; x=1729717063; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CdeIX47mBiBxn6t5WctexPR+zXl/wxr00XEvuu6K4t0=;
        b=wVZpoFD8W/bVxkOtQ/Jmcu8Qbvx0jgEBM6qfPFM5CY94s98YRzChbzvbKmT9nQ0f+j
         Ng4j+Y2Q7gkWHEijkxuB5zL31JWCI+MLC3pdmwCHNjZR46XMksOMIXsv77V6kiKyJNKK
         810T/kWZa512qmwzZ5439jdeWcQto9zuhH1LX5a7WlCoJZYd/oh/ecdPn49pNccl4bHe
         ZMuFySEu68YRRcIi7gyGz9s947HVvM72vYL6FKmlcxy9dNSHK7WFRsZNYqVQBK0fByq+
         5z5Q3QtdkAzjZHZjll4ns3aeFmmQ35bym4jChVpEN8Rz8HhVoGme73NWlr0o4tNCAVFd
         Uo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729112263; x=1729717063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdeIX47mBiBxn6t5WctexPR+zXl/wxr00XEvuu6K4t0=;
        b=EcQMKJ4zUXvKchPeJBmvBoFbXBDU6hdBbxZ8Bcd4U4d+N02rTHswG+6inLICCfxbIv
         As+Dk8YzIWytONq71CByblAQ4DQzRqDF1gdndvPA1EFx9Aby7ckV9vqdIihjREUTXNir
         2UbpDRDzdhFhWo25dRrXaKXfaFvDwKtA4w3yJPTUeBMZoCn+Fqy6Ov4VHTr6sBAXC+4I
         hPu44QaLmrsrGHLD636zQGIigps+Rf7TawDyFAUJ/uNKp2G/3VmuSwUVqmKlQaWMAmyg
         1wY/s79tSUChZkIzM1QWWeOJnbD7IBngbBuQW9mbe3q1nT4WczvCs6eyG/KEgnDCHz+a
         X5iA==
X-Gm-Message-State: AOJu0YwDBlSki1zR+TwyWEzUGx9iq/laHSGLMSsLGPlwFMDRWTDdG8WJ
	/EnuEZENua2mHF73CcOPd0mM4r+FeaowvzQq/p1W9WqFYWY+gLaRLF1qZNjl1g8=
X-Google-Smtp-Source: AGHT+IGSQmqHe4pnmVCwzXw1EoSCiNAbaRHhKzkNRZ8hoBR4DkV3EAxUsDGcN8WwYCxV+dNHGHL4ag==
X-Received: by 2002:a05:6902:cc4:b0:e29:1b94:ef67 with SMTP id 3f1490d57ef6-e2931b39244mr14096141276.19.1729112262737;
        Wed, 16 Oct 2024 13:57:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296d06c602sm700714276.65.2024.10.16.13.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:57:42 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:57:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Bence Ferdinandy <bence@ferdinandy.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 4/6] doc: update-ref: remove confusing paragraph
Message-ID: <ZxAow+zX72sSx4EX@nand.local>
References: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
 <cover.1729017728.git.code@khaugsbakk.name>
 <dec48e2d37cc4edafb51476284ce3fece4718ce7.1729017728.git.code@khaugsbakk.name>
 <ZxAnO5zH1vtgRvLk@nand.local>
 <3af2273a-891d-4179-96c3-865b0e64bf08@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3af2273a-891d-4179-96c3-865b0e64bf08@app.fastmail.com>

On Wed, Oct 16, 2024 at 10:55:13PM +0200, Kristoffer Haugsbakk wrote:
> On Wed, Oct 16, 2024, at 22:51, Taylor Blau wrote:
> > […]
> >
> > I think that it is worth saying that this concept is explained well
> > throughout other parts of the documentation, including other parts of
> > 'git-update-ref(1)', as well as the glossary content.
> >
> > I don't think that you necessarily need to mention that here. But at
> > least I was initially confused thinking that this patch proposed
> > removing the only mention of the special "ref:" syntax for symbolic
> > references.
> >
> > But it does not, so I think that this patch as you wrote it is good.
> > Let's keep reading...
>
> You/a reader in general being in doubt is enough reason to mention some
> other documentation source.  I’ll fix in the next version.
>
> And thanks for reading!

Thank you, and no problem ;-).

Thanks,
Taylor
