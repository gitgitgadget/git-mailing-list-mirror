Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E600A1E2312
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195782; cv=none; b=jXM9+rWTd8rqRZrKmOPa2xaZhWXFlNT3pDJflNDTIoC17gBcaoUf8khtytMWURWp8hTBWtvc//L0X6kAe0JDIyMGjZSKJHgracUb1Kma5PBB1sBrEA4TRshBuKLEMkt4LDd13Ugx3M9kUgBil2MIZSGf9M4XHh49c7nQQIXvrYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195782; c=relaxed/simple;
	bh=gVtCh8jUqgwb/5JmdXiRRyc5hh6oeKC+gEvLKok88hQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kYzS3LsjwGLWKf+1Y5HAG7qfW12SQdI3CYhOw8MSAuvABexmC+JLT0Z3iTZeGNuwJQkF2/reRDq9p0p6U3W1qWBSwiuQ3Zl/lyeKqVjMUoY+z8dEtXgaiw9C2pIuGJOYIkr1SbAlD7FwmUmB8P1XJFc3lFgRTj2QVCYPjZU1x5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEsEQqEC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEsEQqEC"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so1279790b3a.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 11:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755195780; x=1755800580; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqzI9Lg/HV3eWNRrzjq5E/m3Lh4h7OOkSLtxL3UJq5c=;
        b=eEsEQqECEUaOMD0NtDKCybySALqdnhQ2fQ+v8foRipGPTCpzPcEyfGpOnEMx4teLnn
         oLYZog/POJC/TrHDtUdrDPBQ/f68UsADpw7tyIXRLwrVFTxPWRK80tWjDhK1Wj+cjlzw
         WlU4oVc1/5jouyq8BL7V/bLUYzkXunwOjiB7le9bZOc+zv9y/dpCRMKrWEJ7dAXIPU29
         OEUh7Du06gAqiicac7vb7wYak/3/e5UT6KvPXY5rmeUMEyfPGOlE+9BT2IBsRnPn8Nzw
         kssoGaLbR5UCYu66GnnS/aNzWatDYaPlwv2jHAHH6Z7YFbjjQIv6Qxiv88a5m/TEayxK
         L9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755195780; x=1755800580;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqzI9Lg/HV3eWNRrzjq5E/m3Lh4h7OOkSLtxL3UJq5c=;
        b=aUNJjV/e9gAb8zgdlZOahr+8NSxq0OxZCl+zQmrI369Moo+CZVp1rHZ2LJVRuDUEkM
         BGI1nPawXFA6qLjLBplcIl7wFLJ090Jyu7cQEmKALiiwAKoFMRhsjYOpdVHWvJOxfHPw
         G3wKDjuMjNLaqRh7bXxa2//glanfWcj2SVfF98c9NFlGrHJZwkxVbXO2zeMToo9YmE8V
         vsZkNifWNssjDzTfBZMwvDSVomwAKYGs0QBsrmrDRyOCwDvnlWcchkTGBwR0v9g5VcMF
         xLSu6dmXlQ2JwvKPNeU8espOFBvtq03162hi7HFcoTRXe3mwFncfqIGamNX7TUNsLRXV
         iPBw==
X-Gm-Message-State: AOJu0YxbOZGoNt+2jlZGQpaUFXcdRaGkVgfnWbm7JJXMzyZI5rP/3ywM
	XUGJrCjTT+TBqENAUlmmxxXpogz/hQcTY3fn7p2ocgSQjZRnJ36LjUhQ
X-Gm-Gg: ASbGncs4jbq4w+Jh4B5yjxft5sAjLl6WmaVFxN4MDYBmvu2UREQWpmM71DY97/EFDRJ
	bDMIUFJgcPD4BP9A+3HVpuHFkea4N0cYdIfFDMp+zKfSDSgtH95mHfJrtIbCAJj9mlCTz+xWelD
	PYAeu1CfIW4G+yF1V48Rrpg0lPAZkPGkbNSXK9CVYm6Ca1QsQfefr8lzfKRqMzoUupGMAfA6B10
	Stv/9w9QW3q+hbE5y9Bv3SZY331ghCO2owcwNqZ6GwVcJ/LF2wtbK72YHOSA91eBUB0N7o7labO
	MkgbMhPzdeo9kHPvXI/3GTlAuqQ81xcl8m6SFh7AM8feey55AUXY7mxuDIJ7jfAlRmTPSsgz1YA
	JlzGYw9q3KuMrx+nUM1dF7rlr62b9TLekaLloZHTB5GU7wQeuI75Ca6OD
X-Google-Smtp-Source: AGHT+IHQ5C2nZYByrLBFbQbzU/+LNvYjWjlDK5ezHY28cAVhk2touiLVMZBi9aSV0QbMvdRyqPajlQ==
X-Received: by 2002:a05:6a00:2381:b0:76b:e1c6:35d6 with SMTP id d2e1a72fcca58-76e2f92d56bmr6065398b3a.0.1755195780057;
        Thu, 14 Aug 2025 11:23:00 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd156sm35073003b3a.84.2025.08.14.11.22.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Aug 2025 11:22:59 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC PATCH v9 3/5] repo: add the field layout.bare
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAPig+cSBg6oQC4Y81ieH25-A9cHRTfbqC5i+22RSBcbyVo_qtA@mail.gmail.com>
Date: Thu, 14 Aug 2025 15:22:44 -0300
Cc: git@vger.kernel.org,
 oswald.buddenhagen@gmx.de,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 jltobler@gmail.com,
 jn.avila@free.fr
Content-Transfer-Encoding: quoted-printable
Message-Id: <BCCE25CF-8546-4320-AB44-9B729C3D6DE6@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-4-lucasseikioshiro@gmail.com>
 <CAPig+cSBg6oQC4Y81ieH25-A9cHRTfbqC5i+22RSBcbyVo_qtA@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3826.700.81)


> Since the documentation asserts that the emitted key/value lines will
> be sorted lexicographically, can we also have a test that verifies
> that behavior?

Since we agreed to return the values in the order they were requested,
I'll test that order instead:

test_expect_success 'the values are returned in the same order they were =
requested' '
	printf "references.format=3Dfiles\nlayout.bare=3Dfalse\n" =
>expected1 &&
	printf "layout.bare=3Dfalse\nreferences.format=3Dfiles\n" =
>expected2 &&
	git init --ref-format=3Dfiles same-order &&
	git -C same-order repo info references.format layout.bare =
>actual1 &&
	git -C same-order repo info layout.bare references.format =
>actual2 &&
	test_cmp expected1 actual1 &&
	test_cmp expected2 actual2
'

