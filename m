Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724313C83D
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732131700; cv=none; b=GLs/3qN+LN3P0X6XW2WBRpvxThM7Hp9TBloMUwog3NGlSwCTbFMIOT8G8a10RrMv8aS4Uy0MQmVVtTEOGB5HWfOKTDEsgXkSf920w3qTCbQbBG7JLOzdK0cClUxK6+FdivRbAZccEUrnM0i/B9D1JgGaYXV6AKUACasQAevHErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732131700; c=relaxed/simple;
	bh=+gGHcCLWNWIwpecdlffFTiDUhmkgWC8K6GAZBaN8TYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/my4TTHNqxCvQbm+Cr6Sp09vBIQkllGy3kJJO+suTd1nlHKSSoeWAAv5hyolMh5mNbzUczBwl6fnNpZOEQlKW5yjnuq/ZlMgNGJm46+z/2n8ndwrW9SyqPnmCnk0SZwK95uVlp5qJ5JiBTIPHbcQKtgfktzP7ngOvxEDjyJbLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=B6yOVeGM; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="B6yOVeGM"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e38866c8b2dso58453276.2
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732131698; x=1732736498; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+gGHcCLWNWIwpecdlffFTiDUhmkgWC8K6GAZBaN8TYo=;
        b=B6yOVeGMZNiVFnT7FVs/L88TLSfCiwpoUIqNKNIQBMnYW7Gzktyw4V1tHvJ6HS4jwW
         g7BoixPTuHaXfpKsfby5z6n0izQc1/FZ4gm9M3DRauTdS38vW9BaXLqtahnjr1Y8vUFq
         oyB9uRs7ez1XCRQ7DADkaA+VuwX+xInm9FkcN6PC6dmjaPJiRbzNEtETAVZz1ePPCjJg
         V1bm7qc8QIEQihl8oweJoNCCjtl8KorBuDi3h8yzbBM8RTLhIREjY/L+xmlNFM2lzFYV
         zcgnWf6WyqeCekeHa5EDJqdqk8bhG25R8H4i2AcD82DXX+h60PI2MQRyBC/ubCMyhiJ+
         5hzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732131698; x=1732736498;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gGHcCLWNWIwpecdlffFTiDUhmkgWC8K6GAZBaN8TYo=;
        b=UEEN2z9aFEbcclYFGNQXBEwvwTTUG1XbHKbH7yaXAJkwtLr+nBkPgkkUxHtfKgSFW2
         YwwSsRbTrU3Q6tRoI7mHUrwMSSnqoeA2rGxs4oIzfrO7cAkln9YEqo+kGc4ZuEn00b31
         tbTPircU7rodCAngr5X0ci6sX57EEtIOqWlE3TlktnTZ/Ke2NQX59/hlzL1CMlm0pk2n
         zB4cY1E9G3fS9Gd/A2SyCCQPzKkcdTYL1ZekF57K9qtYLAthRBNcuOM6OrFtmchvvqMh
         QFenzt5cuYwushcTX1qAqWEreFUtQ6OLCHE01we8hVKl5bPSKBf/k0TxxyfPTSvp9cIW
         HHCA==
X-Forwarded-Encrypted: i=1; AJvYcCUzNSSICIl8SC3M0Ef/pSbCmQjx6FrS3JKwPB68E6FQcTFRp1dw4pWwg06r+lCCQsYV77Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvjumAgWu/q1Fd2IVbLAlbQULhgl0HID8CMD4ExQ+Gc9BfwoX
	Vi6MZQUuZkErLaBBSSq9znYGnanp1WHa72/Ak5EtIIBa9apzc8ajYuUSLeb5gAg=
X-Google-Smtp-Source: AGHT+IGVl1/iGH3cR42cOiZBuMm44TXyZHQc+kVNLR3HoB8Yznblm3EY88V15ptos6JPElm5xnEF3A==
X-Received: by 2002:a05:6902:1248:b0:e30:d158:988d with SMTP id 3f1490d57ef6-e38cb54bea2mr3485377276.9.1732131698072;
        Wed, 20 Nov 2024 11:41:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e766fb7sm3317518276.32.2024.11.20.11.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 11:41:37 -0800 (PST)
Date: Wed, 20 Nov 2024 14:41:36 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im,
	shejialuo@gmail.com
Subject: Re: [PATCH v2 02/10] midx-write: pass down repository to static
 functions
Message-ID: <Zz47cIz5EzMLI0h4@nand.local>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-2-e2f607174efc@gmail.com>
 <CAP8UFD0RpTXCdeYPA44yiS1E-LsmSHVrGxNKaUFkvUqq+zNTZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0RpTXCdeYPA44yiS1E-LsmSHVrGxNKaUFkvUqq+zNTZw@mail.gmail.com>

On Wed, Nov 20, 2024 at 07:15:04PM +0100, Christian Couder wrote:
> On Tue, Nov 19, 2024 at 5:36 PM Karthik Nayak <karthik.188@gmail.com> wrote:
> >
> > In 'midx-write.c' there are a lot of static functions which use global
> > variables `the_repository` or `the_hash_algo`. In a follow up commit,
> > the repository variable will be added to `write_midx_context`, which
> > some of the functions can use. But for functions which do not have
> > access to this struct, pass down the required information from
> > non-static functions `write_midx_file` and `write_midx_file_only`.
> >
> > This ensures that the usage of global variables is limited to these
> > non-static functions, which will be cleaned up in a follow up commits.
>
> s/commits/commit/

Good eyes.

> There are a few places in the patch where hash_to_hex() is replaced
> with hash_to_hex_algop(). However hash_to_hex() is not quite a static
> function and is not defined in 'midx-write.c'. So you might want to
> mention this additional change in the commit message.

I think this is fine to leave out personally. Since hash_to_hex()
relies on the_hash_algo only, it's natural to expect that when a caller
has access to a new variable pointing at a 'struct git_hash_algo' that
they would convert that function to hash_to_hex_algop().

Thanks,
Taylor
