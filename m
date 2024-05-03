Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B264857C9F
	for <git@vger.kernel.org>; Fri,  3 May 2024 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714762701; cv=none; b=Oc/VMY44cNTjH28D88EoUIPg06o+tqPseBKT8J+1IHpDB/XcsThpg0GYaTbqLHjts4lzKZv8hko7JqpbTphnytFnCMYMdUBO4L06cfPMt46QsXeFUbk7/qLvxEdqPyvdvlejNM/fzWJcyvR/nwLFe7tb0u4qTveMznxSqdmGgf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714762701; c=relaxed/simple;
	bh=iFAaEESSlZLJk48hal/efjZ4bRAVK+NTwxs11uphl80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho29Ruqy+2pu23cB1mGTlqNOUMAewppjuvHSxi0cXkz3STX3dwPpsARruBHMkfzC0wSxWgXXAkl7J3jRIluZx+/7jLZfG2tn1yoO0kk9TrQYCnIxWI2pXpiue2/sRPRnZgkwaoXZW0FIhqZiBYEeTmepXHGTU/X4F/iW/7BkIvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hF31Tpx5; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hF31Tpx5"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78f04581a66so646390685a.2
        for <git@vger.kernel.org>; Fri, 03 May 2024 11:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714762698; x=1715367498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k6mNXRuGeAPUmn34yJP3W85oOHP0uRmaZecAtoB6Z2c=;
        b=hF31Tpx5YWwh18Dj4Qbwg3djx4Jin4miCmnImyxDb1d9m2fAHMBK0gCZ9Z+aljvXxx
         /1s081E8RFCrHAWxjxW4zkwOUwJAIRSYOVLR2GMYrv5om4fVrBoL5dqRkFPmYmi/HyHR
         JpfTilg3HJIVBbNp8NUc9vSqkH23bjmvL/4Bcn8S3KDM0kLyQg1VxTqeShh8z+b9Qi8C
         K88++RURK3lvwXtjC4YJosjkqSzWBTP7InZGbDf3mX8RI7yzytS2RKgx3Rd6F3BB8ZTV
         C72U2+IY97o/xjDgMl17k9PSYKVqQakiZsS8QLBnQwWizipnfKWgtPtMAagLctcWQwaF
         /9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714762698; x=1715367498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6mNXRuGeAPUmn34yJP3W85oOHP0uRmaZecAtoB6Z2c=;
        b=v1Zq2ijw21ZJDdtJTNAMkg1VgXS3SxlS0IVswukqayyWSJszUp3M5awwHGoEI7zu7z
         t2gupxmJffxRc/d3f5vYJ+ov6ovT2B9KT97SRffC1FMlpRsbNWhP0PzCmnzzFgqQ69Ve
         7RYyeSxTkkaDajPnURaFZGupDS4orvhyrfMQBxmVDi8HEnnTR00eRUkY66bobp7wM7gc
         cBkkRgLFXle9Mg7kxCHVmJxd74w2mgwuQOSPjOCrC/xKbF95EZBuWf22VIkTozfPryW3
         AglZDk5kjto6g69cyV0B2D6tucjSDjZwS6mKuAf83nQEPYlUjxWLHiiam1pHv3vzgdfD
         AsSA==
X-Forwarded-Encrypted: i=1; AJvYcCVvAyf59Q5sfr9iwgqJyqmqDVAwkDpS7q5TAGT7pk9ft5iKBu7iruhrSRPqccDwthsVeOdizojiWELaWAeOIe8lJWFU
X-Gm-Message-State: AOJu0YyGN23EPpXNEo7QyyqV/Ac0Zs6X9CM288wpC/1EZPpDqUyX/NK/
	N7rquN44q/dtl5QxDl+gHcejcXN4lC5MV2iHC3tlFTrwlKU5IPOIM0xVN54r+aM=
X-Google-Smtp-Source: AGHT+IH1NUY8pmln30XWJiRhD8rRbzV2JcrA7oudyX83zZATqiUDbgb+eXAdVGlMhxZLzhzdqs4oMw==
X-Received: by 2002:a05:620a:bc3:b0:790:f25f:62df with SMTP id s3-20020a05620a0bc300b00790f25f62dfmr4176870qki.23.1714762698599;
        Fri, 03 May 2024 11:58:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b9-20020a05620a04e900b0078d5a756e61sm1457813qkh.60.2024.05.03.11.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:58:18 -0700 (PDT)
Date: Fri, 3 May 2024 14:58:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs: remove functions without ref store
Message-ID: <ZjUzyNnBW1BAtEc/@nand.local>
References: <cover.1714717057.git.ps@pks.im>
 <xmqqikzu95cf.fsf@gitster.g>
 <20240503173553.GC3631237@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240503173553.GC3631237@coredump.intra.peff.net>

On Fri, May 03, 2024 at 01:35:53PM -0400, Jeff King wrote:
> Though maybe an even more radical proposal: now that read_ref_full(),
> etc, are gone, and we have only refs_read_ref_full(), could/should we
> shorten the latter to drop the "refs_" prefix? Its original purpose of
> distinguishing the "takes a ref store vs using the_repository" variants
> is now done, and shorter names are less annoying. But:
>
>   - maybe there is value in having ref-related functions namespaced? We
>     certainly don't cover all ref functions here, though, and aside from
>     tight OO-ish APIs (e.g. strbuf) we don't usually do so at all.
>
>   - the error message for in-flight callers of the "old" names will be
>     even more confusing (it will not be "foo() does not exist" but
>     rather "you did not pass enough arguments to foo()").

I actually thought something like the approach we take in banned.h might
be helpful, e.g.:

    #define REFS_DEPRECATE(func) use_refs_##func##_instead

    #define read_ref(refname, oid) REFS_DEPRECATE(read_ref)

Then, we could add a bunch of these to the top of refs.h, which would
give semi-helpful compiler messages to those whose series are affected
by this change.

But TBH I think this is probably overkill and anybody who encounters an
issue like this likely does not need the extra hand.

Thanks,
Taylor
