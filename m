Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA11EEE0
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541223; cv=none; b=k3m2uF0/QgicXHBugCtspsMKu+2ZzSMRM17s/2uRI6uLDTVX2wlEUdYhZojUpJ42eu7K7GJHL1twMZIj9M0pqzlCyYzUYcP0PmZU4O/DslS8Ltwj/W7aeamBqIYYmuTieHrw3gLWMJdwp4Lt7gmDr7o7jqoSZisBqL9OAFG8onY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541223; c=relaxed/simple;
	bh=2/A5ndUkd4pqcAHjwYFLrarn3iHR5gZXL18GTsFcunU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmXSRnn2rjD2RNOvEkAoNaRAjPiJU/t+Omdfm+Acsnua+aqSbja1tS0p2fxLNCs5uV4WgTDtwje4KODZa2qVDoNsHSGOeNsg1sxr69NUIEkdlR+7X39NBHG3A3J0pHX/ToO4qCtmWmuIIY+Xq/KdWBNeTC4Mrw0IIId8/lnZba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=AQHeDF2G; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AQHeDF2G"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e290e857d56so4857487276.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729541221; x=1730146021; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2/A5ndUkd4pqcAHjwYFLrarn3iHR5gZXL18GTsFcunU=;
        b=AQHeDF2GUbQu0gr7k6Vbvjd8rdEDFDfeCulpe2AILRYiXam8qDI1D7DnWQuIi2pZ/Q
         0wA+5oEjtmNj6xwCJyE4ZNFe9QEoYJ7/RFVtyKKlrAI05Z4eOYKjbtylcZ3pE04epSpl
         siD7VS1u6W2lyMbblDtOM2+Zq4gxe1E7L9ghZrVDh5i0gAJ2SysFCfWCOArmV7imVPM9
         ATqUUM7E6K5iBFeJZ6Tn6r8vDIsbidf7lpzsHX3+PKn5Jmi1+WgfRl34OaMZej49QDJ9
         T5kkujL0H66T2P9padzb+o4PYO2iN92XmcvrPHC8fZrNiVuIXHxYQfe0OiJ2WKK8Hyy6
         bi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729541221; x=1730146021;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/A5ndUkd4pqcAHjwYFLrarn3iHR5gZXL18GTsFcunU=;
        b=Mnm+vax/er29gpC04TFjOlMKDxJ2Tw/fyWwaf/+WdBw6M+iOqcEZ4gdIu/Blldi/9j
         /l0/if6Unco0+40c4VDgLpIKsrXASlc5ew+Efm1ZRIhpgd5oXiaiBiXtmscXYCyw24gt
         vqehe/sayueyd9HKjNA64uAHt8qzRhpAVXM7+POJZsw9UyYyyKPqKQXsEIQBds7tNDei
         7a+CdRURZndAQlXX9q4BsIqkvx/+IcmwxkJKB8LHItrY2KOCaLqSnh3aDt5ZY84z+KKU
         YOcs/GJKp//NSRnUlFlaMvqIpVVuuQ75A/Za7n2Af7rS80HRJOKrNP3brsvwKpM072b/
         js5w==
X-Forwarded-Encrypted: i=1; AJvYcCXcmEnTN4EdNP7UJeni6DbhKrJ/ize4RR+Dq6gbpfOp6f8q08/K9TIo8joHGb/WKESuL1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUNPUFpRul4RKEFYcvIclFlOhT5qVly6TvKCWWontFEh59NvWu
	PXKEMJvhqB8c5hTSGtQxTZkU6ONzz0ZAd9VYXfjv7nV/f2VHzU+JVXtMKG2STYgLEYN3sor3MLZ
	7
X-Google-Smtp-Source: AGHT+IFGtPH+hLwzf4VbVLF8SLcgUjf23W6gnl+ycqcRkwG91tlPKtgMpt4ut19gvHhYxGI4xLcv1A==
X-Received: by 2002:a05:690c:9a82:b0:6e3:10e7:b418 with SMTP id 00721157ae682-6e5bfeb26damr101118117b3.46.1729541221294;
        Mon, 21 Oct 2024 13:07:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5cef92dsm8001467b3.113.2024.10.21.13.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:07:00 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:06:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: fox <fox.gbr@townlong-yak.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@github.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: Bug report: v2.47.0 cannot fetch version 1 pack indexes
Message-ID: <Zxa0YwXfWt3qWWld@nand.local>
References: <BA07EFA0-0793-420D-BED9-ACD7CEBE0112@townlong-yak.com>
 <CAPig+cRPAs85koyaQxN5eaV60-qyGka7HrDMuoMoWjT0CpS6SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRPAs85koyaQxN5eaV60-qyGka7HrDMuoMoWjT0CpS6SQ@mail.gmail.com>

On Sat, Oct 19, 2024 at 08:37:08PM -0400, Eric Sunshine wrote:
> On Sat, Oct 19, 2024 at 7:31 PM fox <fox.gbr@townlong-yak.com> wrote:
> > What did you do before the bug happened? (Steps to reproduce your issue)
> > 1. Run git clone https://www.townlong-yak.com/test.git
> > Cloning into 'test'...
> > error: files '/Users/me/test/.git/objects/pack/tmp_idx_WT81vv' and '/Users/me/test/.git/objects/pack/pack-427331d91391b00844273eeb3879cb479ce2c995.idx' differ in contents
> > fatal: unable to rename temporary '*.idx' file to '/Users/me/test/.git/objects/pack/pack-427331d91391b00844273eeb3879cb479ce2c995.idx'
> > error: Unable to find 6261a9d9f7704c02a5421ff733919ab18793aa7d under https://www.townlong-yak.com/test.git
> > Cannot obtain needed object 6261a9d9f7704c02a5421ff733919ab18793aa7d
> > error: fetch failed.
>
> I can reproduce this problem.

Thanks for reproducing. This is definitely unintentional breakage, which
I see that Peff has already diagnosed and proposed a fix for. Let's read
on ...

Thanks,
Taylor
