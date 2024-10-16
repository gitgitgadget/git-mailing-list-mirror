Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71992144C1
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107353; cv=none; b=YME/i1lGX1sFx4khRC9BOvGLYyckb1c4qKmDozUk4GJ14+6jPLuGHad5amIbaDy/n6lhjKrVLNVw5bS3yAjJNgiRB+9D/Evp65DXg24d3AznTQQeGmrXviK44lPOM68d+Bx3RTm7Pqe9uqU8cof/AapOkVz0thqHfKTbNCwH+jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107353; c=relaxed/simple;
	bh=cHkjExU3n/YAcH+3lL67bTPu84hVaQeiTjVITQXGt0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvwCzZxjPazbM6i3jf8jPK9iOEcrF2fWRLlv0V5jzuqcQLHDMYesgQglhCKjfCF4Juouybxca2Krd81A7/hvv1yhGATKQ3oFxxJvfu+3SOVkEZduSm2ujez9p2Yibv7wTaNEqubG4jy9LTJT6lDVu7/5CKPl+6xErZxh1v5WUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=iLG8d926; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iLG8d926"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e38fc62b9fso2920967b3.2
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 12:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729107351; x=1729712151; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cHkjExU3n/YAcH+3lL67bTPu84hVaQeiTjVITQXGt0Y=;
        b=iLG8d926iwyuSvSJErxXjYwR4E3mMDhGLhWfapmrqgCgZ2BPUR7ZLZethUxFL5pD/Z
         TZM9U6HyuNOK+GIcw91cjRX8N27s8hbjjXKqg+E7JlsdF2eqjGfBWEmmH+Auk1t5bRs2
         5WZT4i8Qp5a2Ok9vmkzyhyhBCpLAg4sHg2SWdVupMcSbfTzSoqjsmtJQOUq9lIbn1Ev3
         kVYRMREW9B6vth7X423F37Gxo2c0A4doYrFP9yFk3eoI3HKRwg13DMZyQHwJlEnt1arZ
         13Gqo98paDG/yYiVIOfp1xk7nbrQa2+D3189hWGZ4N6uS4Vs0XMw2PRBd+xt7HU+0qg3
         69gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729107351; x=1729712151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHkjExU3n/YAcH+3lL67bTPu84hVaQeiTjVITQXGt0Y=;
        b=mFKjAzyErNOxaSO/UUciA27coJzIM4vEHc3czUR9qgtu06Yx5sUHdlrQ6akGCItZjq
         cSLkFSdb3GyWNo+9pQn6kTRcQcya2l0d0S+XOPMWeYNoLi1AoMzqofDr9RDAO9oGR4ea
         8hfa54TzWVQCQiZiYGQMac/XTZZrFrJiBbSWXJBuhP9n2yC6Ceqhi/QLCeX2UnojwWXI
         dTlCnLZSYBsWgVHBatojmU+x85+e/iO1LX6PAAbezf91SIooRG77BC6rt/+5zDEaoswN
         7K2i/ewYUvjPfaRzq0PK0m5OYJw3is6hdlha4q1XZoz/1xh5DEAYiJJxqPns6U2aPPuj
         wybA==
X-Gm-Message-State: AOJu0Ywye6ibLK1Hmsku3XVEf0YMJ3vXvZ9PSB66y8xNu7W1vWOOyphi
	Y8ev2D/Dt3YiGsRabKzb+kiW7E6BOkU/f9ltVM+KG/AK7crNGguQXElH+mIeEuLFOFG0GSzjf96
	H
X-Google-Smtp-Source: AGHT+IGz8A9T5ZhB3VHZaH8/rIiu8IYBJtCiNPOkPU/Gen7IAmAMN6ldkzsBgJvsX0nSzTTIw2Y7ug==
X-Received: by 2002:a05:690c:9692:b0:650:859b:ec8d with SMTP id 00721157ae682-6e36413ca6dmr140603867b3.10.1729107350835;
        Wed, 16 Oct 2024 12:35:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5b420e9sm8286257b3.57.2024.10.16.12.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:35:50 -0700 (PDT)
Date: Wed, 16 Oct 2024 15:35:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: =?utf-8?Q?Germ=C3=A1n?= Ferrero <ferrero.gf@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git submodule update --init breaks if run twice in parallel
Message-ID: <ZxAVlDuT3IFajqFp@nand.local>
References: <CAH08wShkp6Mnz5itcbT=GyCY7_dW5eQWLy0yBFS8njUHumpQZw@mail.gmail.com>
 <CAH08wSh7Jzn-RoziaEM3mDcEEQqcnKpnrSZKPTD9yn9BmZgQxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH08wSh7Jzn-RoziaEM3mDcEEQqcnKpnrSZKPTD9yn9BmZgQxw@mail.gmail.com>

On Wed, Oct 16, 2024 at 03:49:02PM -0300, Germán Ferrero wrote:
> Sorry, it also happens on version 2.44.1, It just seems less likely.
> But if you try enough times you will get the same error.
>
> I guess this is just the way it's supposed to work, and there's nothing to fix.

Yeah, I suppose the error message:

> > error: could not lock config file
> > /path/to/my/repo/.git/modules/path/to/my/module/config: File exists
> > fatal: could not set 'core.worktree' to '../../../../modules/path/to/my/module'

could be a little friendlier, but I agree that this appears to be
working as expected.

Thanks,
Taylor
