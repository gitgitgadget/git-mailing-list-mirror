Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC3168BD
	for <git@vger.kernel.org>; Mon, 20 May 2024 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716238530; cv=none; b=e1ScqEK33b2In096lmJTCfpq4AcIXFglAYAL4b83T8ga2LJCJaMnocieUxBHX7pt/D9gH6P5sRruhkC7nnNKoVguv03EV6rfWIXlKdkfre4FV+65jEMoAioAbjVbaGdDtAXxCR6vSVOifDNq7AQI0iFNOQAi8Vgn8yJNc1+gL/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716238530; c=relaxed/simple;
	bh=mkXZ8PLMD4cE4p15xY7SyWnjxFqE/mgGBcDq+f+ey0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiFBme9+kN/8CATMhlOUfPV2EullNpS1Uut8IImgD5Thhb7/Kkz6qWTopVGx+a63B7MNk65lS7ap6YMLTcUHN74IHDQRs3MJBrOn5KcoxdF4UnTdx47KyjQC1Pkan0XQcdJVlU2RtJBxl8aLKjfwerXEpaiyL3xPgfLG/IQiv1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H18XAsi8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H18XAsi8"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f0937479f8so85418055ad.3
        for <git@vger.kernel.org>; Mon, 20 May 2024 13:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716238529; x=1716843329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jV0iNAd4pO4ne74fJrDCELC4j7bVs83uHBboc5rBcgU=;
        b=H18XAsi826pOAUEPkrDACvQzQx8WlJ/GUbBJT0DBByET+fdRwBFrTuUfU/VopJapVG
         Y7ebYQokGATtFG3BGjLevhUp9hGfuJvTZBpirzgGGpFaF5S/21wTrqy9c202CJ0P8S96
         3on5Dj8YYEozKBQSgy0yWP3ksoBn+V1d0PLu7bD50qlcgKNW3jJNULHH9muIZNhP1A4N
         lzKk6CyRXNgLSTtsbmEVWzIzT5v+3kSBliS3V0L0/FcO0k9iUQpnJpt5ouvh5mO9AhTQ
         YCFwS+3ceOfldupY/Re8l3Kd42PiTxHPLQ0nWYkySN0KHzkXgsfmKmEKEi8nva+geNZi
         eYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716238529; x=1716843329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jV0iNAd4pO4ne74fJrDCELC4j7bVs83uHBboc5rBcgU=;
        b=BQoPkhQNsgU3B6LBuceW/NyGr+I9EbOdZevxzjYlGDro3Rjk4U8HJJSQS90W3+6oet
         Fvoubdlt4bT/tARVT6FoKMuj0NQUBdUaFFYT7u4oyHrIA0JSj418cfUT3sIu0IssIj1c
         NZRXX5isqFrAoiR1JFtgdYfe6jTPiAH6VzhP51Zx+YM/lkMV2G/hsgBDNGdy/7lVA9a4
         YIHEDA/aK7w2HEAu8LfNvrNDWniV8yUbI06293sRtxbFy/aoeev70+0i1ikVSn9gUJk9
         2GK7LXOPkH4gx1Xbgbohhg8d3DlY8GPI1x3ASyuk+w3MJeuoXaxPn20NIEbG6pzXdbqV
         tVzg==
X-Gm-Message-State: AOJu0YxlpySuli4pFmJhX6jw+DFIlcE6FKL4lyVrUJWuIzGhWwKIxBA2
	S4s3EQJX+tP9z7Em1uie1lFfhU1p2itYn99C4DzDpr0KSw8eYbat
X-Google-Smtp-Source: AGHT+IFcj/RxNs4b60Ak6/m6Twi1SH4xEOuWKDLN51AbxQF6T1rLWUfPcAU083Llc1/ct6znm9ZI5g==
X-Received: by 2002:a17:902:e805:b0:1f3:78f:899d with SMTP id d9443c01a7336-1f3078f8b10mr21500025ad.55.1716238528626;
        Mon, 20 May 2024 13:55:28 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f307733a7dsm15002885ad.128.2024.05.20.13.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:55:28 -0700 (PDT)
Date: Tue, 21 May 2024 02:25:26 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Achu Luma <ach.lumap@gmail.com>
Subject: Re: [GSoC][PATCH v2] t/: port helper/test-strcmp-offset.c to
 unit-tests/t-strcmp-offset.c
Message-ID: <7o3cyisx3suyqhe24xkfbraaxq4vzgy5er2tbshbtgfinkugjk@gmjtg7bhudwo>
References: <20240310144819.4379-1-ach.lumap@gmail.com>
 <20240519204530.12258-3-shyamthakkar001@gmail.com>
 <xmqq1q5wmpqh.fsf@gitster.g>
 <xmqqseycdxe9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseycdxe9.fsf@gitster.g>

On Mon, 20 May 2024, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Please do not base a new topic on 'next', as I will NOT be applying
> > it on top of 'next'.
> > ...
> > Unless the conflicts are severe and is impractical, in which case
> > see Documentation/SubmittingPatches and look for "Under truly
> > exceptional circumstances".  But the conflict in Makefile about
> > UNIT_TEST_PROGRAMS in this case hadly qualifies as one.

Will make sure for the next time.

> > Anyway, thanks for a patch.
> 
> I've backported the patch to apply to "master" and queued it on its
> own topic, so that it no longer has to wait for all other topic in
> 'next'.  The Makefile looks like the attached, which is just with
> trivial difference in the context.  We only need to remove
> strcmp-offset from the TEST_BUILTIN_OBJS and instead add a
> corresponding one to UNIT_TEST_PROGRAMS, and that does not change no
> matter what other test-*.o are added to the former or t-* are added
> to the latter.
> 
> We may want to sort the UNIT_TEST_PROGRAMS list alphabetically at
> some point, by the way.

That was aleady done in 'la/hide-trailer-info' (next).

Thanks.
