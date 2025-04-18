Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22221B6CE0
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745013157; cv=none; b=Awv6LgYS3R5ftDl0rVEgaNqm9FNkShfy4+rw9Vy13KbFRZ6MxL/8tx9iebH4rYAakp0C2OvBoRmwMyn3jMk+oNsPAjbCEYJzi8XK9thiBzR+eic4wTi7jaHTleV/zb9omm7NYL2h0w3g8Zn2sLLXl63YsNxSGF+6DDQC/8+W2G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745013157; c=relaxed/simple;
	bh=T6Je5Mash7BRC+O5V15MS+RiuW42Dgk7Mvb8i4bTbpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSPQM5/iGqzeoQt8PHCM/OEq4B4ZpFiZiJrEvHncv/9+wnKFY2ylLpHx4Qz4u8DVVDO5gAFAa0wxH4mCgCUnYpJXUsFBV2Kd1vUBeTGQiNvZLOjzBeEHoskRuPEI/NCrn22kYvTl66N6paAMBmTIxCPPDOgg/tO79NXfsjmjdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wrJtb7+q; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wrJtb7+q"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ecf0e07954so32302246d6.1
        for <git@vger.kernel.org>; Fri, 18 Apr 2025 14:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1745013154; x=1745617954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxOPoquOAN8mffLbapi3/N+Ighoarmj5EsJXMtmNZnU=;
        b=wrJtb7+qKGEjyxU4fayrLnInMglqHEZoAwOgliLXTX5ItZJATvbrAyK9cQuXNQvU34
         7+/CgjRv+WcNsN57Ub/rhA5Qea1XdO3SSeot1yfqp7xPp5iZBpF9mhzIeJu9N8t9RkBJ
         AoNaVi5WhqOQCulnPZA0UR8+iREMlv5reGCWzd9UprZ0RpLJIomOasSEE1tcKPrZ1yAL
         PMedF3ekUpzysNDWIK+QYCrcKj1J4YEj7bFT1ZmFKJS9AV/Hzo7g4yGMxYIoZJMXPPGO
         S9L7wv7V9mDUzfXvDknuM3EICs5o5XACJg/nB5/ND7S6SMeMdLLVnLR3T1fPYCyV76c6
         YRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745013154; x=1745617954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxOPoquOAN8mffLbapi3/N+Ighoarmj5EsJXMtmNZnU=;
        b=shcogJfTlCz7kGWDCeAb9t3zn5XuCnntS0PCB/TI7O5Wte+E6gxcCZS350eg1EpnHe
         gmzY4JPtqL1flug+f0iucGrhRkIV8wA3ZoZgJHgg8QoHcv+oB14lpJniimXIxcQ14B4G
         qzP6SQE8/LmKRqSX5Lc9Bet/07RZO03xnBMBlsZl/M95X3v410oDrcQ9mNP/+swzhK5k
         pBAOBA8entGafL9CmSmXX14aCpMSf9aXCBEPYsqoI+5ew1AETBErjZHzCeWo0QeawWjs
         vM4ow7WPGFF5lR73rVCiH9qvMdWnaW5hqINt1YGx0zMyJUYsAdnW+kNhJaEccIHyccHD
         CEBw==
X-Forwarded-Encrypted: i=1; AJvYcCXWSu852wk/oPqAk0d3sAegSRAjyjqlkZYFrKDdLYtffXBf6udxWT7aeYt+cFRiIcPwuVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzapXOdeyzoI/9EGu306eiZgJJVK+6jOBRD1ocdzFKPspZ40f5q
	sGPdrlDDf8MpjG16fYlg3XJ6kZ31GdtkjW2QNy6jBZz4Va8LcoP9+Psc9EheKV8=
X-Gm-Gg: ASbGncuY0Y/z7G2U9A6QqS/SkWiJrX9JEqDbVD1X7jMwmF5+pZA3UAPXrqeVunH9Ss7
	+X8toi8r6GubRvYQar3Kd07bgNKC2liXDR36gSlddzndDUg/Uo4+YVdHk5HZglI4/LibCLkH8ls
	jsvi9U5gg3URF/9mSB7M3784bkvcM8XTVD1fnZH10ydu/226SlCvtZpl17I+oeUjF02CzwVQgN/
	SLW18C5q1XBDEt7/pUJM0/53aCh8g+pSVNtM2maDQ0/RQDuDALuV0nHTzof+YJ2cafgPxYpvcaC
	Eird/T6+vwOmMS+2Sbz8ffx9g1EytsjPCP9am7q8JpNKAhm8GrJsfAdi+usrVbEoyPZKxyZqSv+
	WJQB3dLBymSIv
X-Google-Smtp-Source: AGHT+IHpIvlqzhDYY5ZqRgXoAwGDRYqqk8TW1iiCAKpF3hEE3iZFj+wPB/eE8O2oFXkQi2nf1sRAGg==
X-Received: by 2002:a05:6214:224b:b0:6ea:d40e:2bc5 with SMTP id 6a1803df08f44-6f2c450c031mr76736956d6.9.1745013154626;
        Fri, 18 Apr 2025 14:52:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f2c2bfd8c4sm14691306d6.87.2025.04.18.14.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 14:52:34 -0700 (PDT)
Date: Fri, 18 Apr 2025 17:52:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/4] pack-bitmap: write lookup table extension by default
Message-ID: <aALJoFOUWq0v3fiB@nand.local>
References: <cover.1744924321.git.me@ttaylorr.com>
 <b7cfb1267fdd7f50f414c9f79377cb338a0c1ab0.1744924321.git.me@ttaylorr.com>
 <xmqqmscee97z.fsf@gitster.g>
 <20250418093335.GB10441@coredump.intra.peff.net>
 <xmqqr01pbhk2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr01pbhk2.fsf@gitster.g>

On Fri, Apr 18, 2025 at 08:44:29AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > They're not technically required to be in sync. It is OK for the midx
> > bitmaps to have different options than the ones we make for packs. And
> > in theory they could intentionally diverge, though in practice I don't
> > think we (yet) have any extensions or options that would be more
> > appropriate for one or the other.
> >
> > So if we did want to join them, I think it would make sense to still be
> > able to use different flags for each situation, but initialize them from
> > a common definition.
>
> Thanks for great explanation---I guess it is not worth pursuing,
> then.  It is not like it would make the system misbehave when two
> are set differently.

Hah, Peff beat me to it. I saw your reply last night and was going to
write you a very similar response.

I think the summary from my perspective would be that: the two could
fall out-of-sync intentionally if we want the two commands to ever have
different defaults. Tangentially we could use some common "bitmap_flags"
field whose bits are defined in pack-bitmap.h and used in both places.

The latter is a bit awkward currently because the current "flags" that
we pass into the MIDX machinery from the builtin all have MIDX-specific
meanings. So we would have to either make sure that MIDX uses separate
bit positions (which is awful and far too fragile for my comfort/taste)
or store them as a separate set of flags (I think what Peff is getting
at above).

Thanks,
Taylor
