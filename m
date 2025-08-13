Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859D157493
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095900; cv=none; b=sVfIZPiXqgQMwVqYZUD5r5tAl3gKry6jrtjrq/VGubRd4TKkJSFLrI5PkU+6TuOYZVbvCDiydTs2t5jINvG4jpJ3xeDVrGs5ptJ6rYyNvqoIRF7iLHxksnTbjpOIHpxSl2Gj8i8FJHAoNaRrp3Tchgg16lOFe1EPSNbHVob6Dts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095900; c=relaxed/simple;
	bh=m5oq5cRcu6zd7YI3lLxRM6hRR3+gMzRNSycEhHgHWSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjfysM1Jx3YAm/cOZFDDGyH6oU3bFGLc6cL88frThoHccHDeQ0mmY8/8Vidfik1IAxzUqrXyVpdpTCBPFgJifeC624MdF2o5kn7eZQ5cSRxvLTJOJ3/9DDwUqkXF3l80oBB4qRPqJFWKenF1/b+caqGLoCBAgH0Na/QQWOEjHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTxLrLvn; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTxLrLvn"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6196c753e66so1119243eaf.2
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755095898; x=1755700698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qlp/FwMvBGKnNx7ZUzaBBK6GlWLsBG5YEN/L92dXFrM=;
        b=iTxLrLvnaYox4MWkyvT+szK9vD+VuVtkC9thyE7rpkJeNp8SW2AP+qtlnekWkmuHWL
         VfzEXmhvIBDITTcROQGMNgTOFS4iHzYPDvFDd6AIz744OPpZAVDTabWMQkHM0a5ivgG5
         ikEKr40POnrTLwwvsmLpZB1TxZw1i/JJf09059nbWu7Q6c4IxO7u/02N834KYSLmE0TR
         4a6Dar85sK7Y6pM2QtZBUpYP4bgoZAxNc82SFYbTJGV50J5zrOrzM22qesc1nnezlpoI
         V/qJqAlk2eojm2vlbmq9BpXVez+cBs2LFpHHcTWuLYSFsNRoJF/y5l1hVSuvHb+Jq2oE
         lkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755095898; x=1755700698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qlp/FwMvBGKnNx7ZUzaBBK6GlWLsBG5YEN/L92dXFrM=;
        b=co/nvSKBox8MGwO2MLhLRGDECQp5JK/ooIZ7YCmARGPpTdmQ6R4cMKNZDUUzEcNlNV
         bZ1uYd9h/uvyx8QfpH7AEr16Fbg+Tr3OdWEMydHrx4PdRJpM25dqiMBetcL/6xTBVVTc
         HctQG8dU5sym+JWlwGVBYJjQP8lYTs3Hg0O+woDD2OsYGZN+UwbtwC2QEHG4XSXY50bq
         vjYE5g3Y8U54cCwOns6TbP6f5drKAhmmDPtmr9A/L3VNOfasu1Fz+m/W2xKdhUFlHDBg
         EtpLPlNiOoixdIgkaMquahP/G6xMH3Qz2sWf4cwy/Pl3vViTOAe2p167A8d8XSG1Rqyy
         6oow==
X-Gm-Message-State: AOJu0YyPaXfor/4MfX4ew30j98vWfefUu3OmtY2R0+ngffjP1Fw1AMWR
	MM1LQgM0ydQ/Pf3VZDWn9Nsj2MpdGoXfQZmVjZmumR2RbXt6muV86s8q
X-Gm-Gg: ASbGncvYmSnJ4EsNWSNuLtGAwpLuxI6/5mofgLCKjac/u0UFIN90Wer2gb6OpOrrCmh
	CS3RA8Fcee2UE9hAl/QreXeyrcXZU0cUxujak9U2VYjnDs93q+nylr9tvRexz2w7w4QSd4rJIgN
	GZ3XYBD3rgZtU2Oo3Sk1HLYdaSVcvaIXMVE8zLvDrTteDVR0MRpproVlwCQYydXvukKFFervs42
	4XVX3LRJNF8+KxXEf2iy9614pNCvgKVt+8QS+a6/w1Jeq+La1+FjEgP7lVLXLVtbkUHAP3szlIr
	flboKC5ouILgnLndfd8nIk5kundodVYzcXHIOA1ajI0SCOIV14jnNkNdDVfkhRVb9XKleVYLBqa
	NfCdByX39uzkG8kESOI3tBbRM8Q==
X-Google-Smtp-Source: AGHT+IG8T9i3cYZaGVsSO4NZ/DF3wCwhZ6dQFYyexdwrNN/fuUpxxw7u7+Sj7PVWmBL2VTDQRuTSwQ==
X-Received: by 2002:a05:6808:1905:b0:434:b6e:52a0 with SMTP id 5614622812f47-435d41fcf44mr2219315b6e.22.1755095898023;
        Wed, 13 Aug 2025 07:38:18 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7436f96e057sm882997a34.31.2025.08.13.07.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 07:38:17 -0700 (PDT)
Date: Wed, 13 Aug 2025 09:38:16 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
	Junio C Hamano <gitster@pobox.com>, Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v4 0/8] reftable: a couple of improvements for libgit2
Message-ID: <tea72qawkdmsqoualurcjbdaonjfwjjk2a3fehcm7nmt2rdmbk@xyhkwpapmwcw>
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
 <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>

On 25/08/13 08:25AM, Patrick Steinhardt wrote:
> Changes in v4:
>   - Adjust stale commit message.
>   - Fix a typo while at it.
>   - Link to v3: https://lore.kernel.org/r/20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im

After reviewing the range-diff, this version looks good to me.

-Justin
