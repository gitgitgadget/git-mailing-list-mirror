Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A0B1B21BF
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761332541; cv=none; b=SOOn6E4AJOq4fOxOi7tf/EsOcaXkoBFcAOP2XdvfcSvI/c0ZOr1e2EEAAjuBXoY7b7nB7SB3icoEk1cpX11M49sX53kfGtYE/DAoW4YAQ3bBiGJbvPB2WEY0lmhVhDzRov5zqg2aRwDtuK+oHQAY5+DAqP7WXrKfrvq43HkVfd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761332541; c=relaxed/simple;
	bh=AZ5K1XNScOemkAC47V2uhE6HCDEXf6Cqfux2O6UCtac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADtHaK4GRlnbPYTSenM54diXBw5zBafiBoE5Vw+eDJFq9lzmuoalcrjsFYg96HHHwIFHg4BqXLtHpR0IWobBejLCVLIWvDC9pXLQ4FSeAIsOyuWtFVOrbiR9JzJaeKMmHfqpdanz4OZ7Yk940UYEGi+EqgB2ASSm7IN0bTIJ5F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=We2e2AgR; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="We2e2AgR"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63e0c6f0adfso2431607d50.3
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761332539; x=1761937339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZ5K1XNScOemkAC47V2uhE6HCDEXf6Cqfux2O6UCtac=;
        b=We2e2AgRwgZzg4M6OzCH5eaecCpZa1ksVvzv+goz9NApGIy6xKO9Avxye5Ppp1TuZc
         O29knLDSmHwvKf1JzUxX7pzecLrZjYznPlO6OEb0FJO4vBhwkcw+nm9pLXrGtG2PH8B3
         09DAUUbm2fWx1vEudo2O7Flk40KhyepN3pPqWDUWqzaZcvKo/PNELX1MxMhv3GzgZBqr
         tSiyHlaEv8tgq8S1+K7003byAEaIXVt8uQuHkoUzAcqepFLVHZ3G4mtpigd6b5FR+nZv
         PJgw7gEmxgT24Hx7xewtod7fxGFw/ov61BwIjA1EJkgTKFxy+d0jQUzi7rtM608d1ARs
         901Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761332539; x=1761937339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZ5K1XNScOemkAC47V2uhE6HCDEXf6Cqfux2O6UCtac=;
        b=kcgaxG/8UoMgJ5itI1kIfA5WLNv/TFxtS3piFJQAkqBfuWlHv8I16Fe2KxtJzgzSnj
         lLTiG3QA1bNIohCbe2XxTzBOcjI57KFV32S5A9orPZpllU2g9X/JJkldyPKunt2CK5Mw
         8v5F9dHBENimx+42Dx6ysKXqnpmQOBPKOR9Y7texRvW/NeHD5KCDrXFrRNIpGsKiFj3b
         LJTxR+xjwvSTVcZnTVCGizE5yUHItHbV67/FNUD3bRHjby+nHtAYh21EkDn+AnjkMQHg
         NJ96X+diAW8+B3c6M89DGPWbk3OrtxHUJwMR1qlvNuxHSmoGaPLtkD6brj5oentgp5uj
         dVPA==
X-Gm-Message-State: AOJu0Yz5BtTc6q8TjTfIKXpxCJZ9bo4DYkXFP6aQNchwe4zvIVR0rJ0c
	N4f6ZZRq1x2ht07FQnJL2HW9HM96kyToFN5GzWkwauOa0klTKko0H7eTHNmjtrxeN70=
X-Gm-Gg: ASbGncsxnWJ1iyyO+6PlV1Lp0XXa/3koEbQ+JWV5LrJw2csGRycREySPlL9NVItT8JS
	bsk6y8Pg5SEO/y4fBtdFCpBBMuZJ+Eqar0u/RfiZ6HVxxNjhAIUyTvtYfEzLiN1S5zIuPuGVddW
	o8fS064LHqha3j+LwPbzULFjEVfsuaIRtvABX9by3BfuJSzyM8T5NBfofRDPRmYKVx9qNFkqMU0
	/FfERNLSkgTZcMFYi3YCDuYsEgCCvnqVChtyK/h9/jn88W10pBaX3Tr5iyeXzMV7yXlJ6tVEpkg
	oz/oxVJB7vFRF2cJOORruy21v1ryc9iRngiU0g/R3RJeqyKq+JEIGPnnvWhBnMPDWTXZRoB6VCH
	pb3xWibM3viR1FjbUZtHcWsrbP8fRGt9nU+cTBUaHm4ZxbzkLDVogr7QXaOVrWkxOCdLM/jKo9g
	uqeX2DiqimS6HGRDiJpNEcuraDr7NWajSi/L9AyZQIxFqgcDKQGPrWHOtpw0XS8Qp7AJbBNoN1p
	6+3CAHF/B6KLMA6KA==
X-Google-Smtp-Source: AGHT+IHYf6+lGUPPedWu/BTYk3XCgUDdUArs2Rz9UerWUZz5nqonLkdiFak91lNVPPkp/FTlNu0rMw==
X-Received: by 2002:a53:ba4c:0:b0:63e:a2b:70db with SMTP id 956f58d0204a3-63f434ee901mr1785972d50.27.1761332538942;
        Fri, 24 Oct 2025 12:02:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63f378f087asm1824216d50.12.2025.10.24.12.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:02:18 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:02:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 4/9] builtin/maintenance: make the geometric factor
 configurable
Message-ID: <aPvNOS2JXEHNHn28@nand.local>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
 <20251021-pks-maintenance-geometric-strategy-v2-4-f0d727832b80@pks.im>
 <aPqDG+f9ZL4Oc1Ar@nand.local>
 <aPsSbt0pK4sbmVQj@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPsSbt0pK4sbmVQj@pks.im>

On Fri, Oct 24, 2025 at 07:45:18AM +0200, Patrick Steinhardt wrote:
> On Thu, Oct 23, 2025 at 03:33:47PM -0400, Taylor Blau wrote:
> > On Tue, Oct 21, 2025 at 04:13:26PM +0200, Patrick Steinhardt wrote:
> > > The geometric repacking task uses a factor of two for its geometric
> > > sequence, meaning that each next pack must contain at least twice as
> > > many objects as the next-smaller one. In some cases it may be helpful to
> > > configure this factor though to reduce the number of packfile merges
> > > even further, e.g. in very big repositories. But while git-repack(1)
> > > itself supports doing this, the maintenance task does not give us a way
> > > to tune it.
> > >
> > > Introduce a new "maintenance.geometric-repack.splitFactor" configuration
> > > to plug this gap.
> >
> > Interesting, this wasn't exactly what I had in my mind when reading the
> > last round, but I think this is worth doing on its own. My apologies for
> > being ambiguous in my earlier message :-s.
> >
> > I was suggesting that we have a repack.geometricFactor configuration
> > variable that defaulted to two, could be overridden by --geometric=<n>,
> > such that we could start doing "git repack --geometric" without having
> > to write "=2" every time.
> >
> > I think that that is probably still a useful thing to do in and of
> > itself, but this change doesn't preclude our ability to do that, since
> > it just overwrites what we pass in to 'git repack' when calling it from
> > within the maintenance context.
>
> Yeah, I understood that suggestion, but I still think that in the
> context of this series here it makes more sense to piggy back onto
> git-maintenance(1) itself so that we're in line with the other tasks
> that we have. All of them are configurable via "maintenance.*.foobar"
> knobs, so I wanted to have the same architecture for the geometric task,
> as well.
>
> But as you say, this doesn't mean that we cannot introduce a config for
> git-repack(1) at a later point in time, and I also believe that this may
> be a useful addition indeed. I guess the order of precedence would be
> that "repack.geometricFactor" is overridden by
> "maintenance.geometric-repack.splitFactor", as the latter is more
> specific.

Yeah, I agree with all of that. From maintenance's perspective, it reads
the value of maintenance.geometric-repack.splitFactor and uses that as a
command-line argument when invoking repack with '--geometric=<n>'

'repack' should of course be oblivious to all of that, and whatever
value it reads from 'repack.geometricFactor' should be the default when
--geometric is passed without a value.

It is a little too bad that we can't say, "all geometric repacking should
use a factor of 3" by default easily, since that would require
maintenance having to read the value of 'repack.geometricFactor' itself,
but I think that's a trade-off that I can live with.

Sounds like this is all good #leftoverbits.

Thanks,
Taylor
