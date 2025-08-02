Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BCC8F58
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 01:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754099482; cv=none; b=J/Qt9Uud9xSlaCscfCAzWmj9SSklukbSlZPPqngOxrGre6WzNoSNi2m/kdGqcj/ImX/UnQ/paFUwzT5EXBIEC+MX1pc5tAb9NyzK9j4qkl6qq9ScJMf8SwNqYxyba816jrC8xeZnNJDG5fRRaGxiSCOJm/0kr8Zg0aKt5k3g3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754099482; c=relaxed/simple;
	bh=CelNZDzvwS94ULCqn7mUh0fAOrRJOImIPyIMoG5u1DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVgXf7/UC3QAziyyJcFQqgzyYduKWMBjvWO8hVsuys9wcbfWQeL+RabNHEXaEcd8dJC/eB9cS5FV3pr7BxQbjBupq9tMZahOXnJpbsW0a2hbBi/DFd+vJcZujRCA7n0OmZ6KbCLDW7ToBAJp/bdWxOH4yS2pdhWUEflyxu9a288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0xQkx1A; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0xQkx1A"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso1582394a12.2
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 18:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754099480; x=1754704280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9DMLRqaof1KjrMo+uG0TdN8Tsu9v02n7XDdkaWD6ukA=;
        b=Z0xQkx1AuhdHw4/Mn87ueSEqkZ7b3ns8L4AcR4Ky+2c+XNFpmVePzGvuDSFvmug3Un
         bUQQm7eAXRLqezmTltXRMjWzZiPinV5EVRce8Td5lqSpfbRmm6c6EZ3lDCmRB+9C9V6k
         j7S0+3tlJKwR7TaS+w8TSDmB4eSkM+FIW64Z+YWYbSMHba7IfHzhAwQbr8QOkllh9zhh
         /1a8R/U7cXf73V3AYFlCuU5FmEn81JQ5FvgvvicYTu5Xa8KReIlNy55WBM3JfsaoFC+U
         JWVSduKWSb+HMuIrU0wzHUsjjRb0Sn2Lb/JkFHxHv+uury3jyn94oyThKjKI8a2jZnpP
         8Eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754099480; x=1754704280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DMLRqaof1KjrMo+uG0TdN8Tsu9v02n7XDdkaWD6ukA=;
        b=XUDVqnh/zFp0De2UPWQksynys1jk/C4hAS06oP9Wk/jdNjIJrBxYXLZafzqMGmj2aB
         FNTYwTQEBEH5wSeBHeKtj6IIf9ezq38u3RtXZMogOVt01zgg+r4vpHqJxSKmLM7UoNXe
         CMqMSgfwrKIEdGuI1mu6PC065Wg/kZSO5xIG01QvJtTyVx+MBLjQS/7NIr1ljOggMHue
         w+RDvZXY2kqItxBwO7aYvg3XdLndvv+zs9nS2YjNYNe8sckIvJkj25COrDS6Rjobw/Yn
         XKg/1EMXl8JID5Y+p3Wp31ZutnP7/LYSLdgpCqrf4uD3WFMR7kVj8fAwqd03lbrAABFd
         y/zg==
X-Gm-Message-State: AOJu0YyZHjJnF0lUYT6Hh88JteSQbEiqn3VGiR7+jW30Qm1hejbyEhEl
	1vaUWpDFJqSxioSx/RvM0Ien77Mqar+a6SzRgmV0zgIu4jITypYG05SQT1AcV/0n
X-Gm-Gg: ASbGnctgwFAA10GLV4vkeUkVvsc+AKOmIe1EtH+1njx9OpCUEOtCr3haMyQrZnw2lkl
	J45qOI5l/awHU+cBGpZGT2mCXFsUEtQOrUN0BnpkuA8TCb8sDkJkZnwxk9WMXxbEqpFCbs+d8Mu
	Wg4i2cLoaFc+4xh/L26eeN3pEiymjuTFhxv17WHgjM7V/XiAK0/o7vF2fuMXNAzpSw1+bAJajxC
	mX0vLm/P0vbtSgeH08GWZPSElc+7xxm6m8bcjG0WQBCuob4JLn42wZpGsiM7WCbKsu9VHbYWDnY
	34W+HT14djMQP25b92ihUH5BnLQDpG55Z28ulk23jAiA3OlqyuS50qFCKu/DoNhtsUXeTUO/GTH
	dXlRgHXy8k7wk4o1tjw==
X-Google-Smtp-Source: AGHT+IEJwBaFUBnA4U8Ic94KUcYJrrVy0DuNh/vHqKwfguSu/WLBrvvjDNdMFleZ9XSLijAzsrSW4A==
X-Received: by 2002:a05:6300:210b:b0:23d:5691:df51 with SMTP id adf61e73a8af0-23df8f9fbc6mr2687014637.1.1754099479909;
        Fri, 01 Aug 2025 18:51:19 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32102acbc56sm1708094a91.2.2025.08.01.18.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 18:51:19 -0700 (PDT)
Date: Sat, 2 Aug 2025 09:51:15 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/7] string-list: optionally trim string pieces split
 by string_list_split*()
Message-ID: <aI1vEzuD2DeiFSzW@mbp>
References: <20250731063949.1601669-1-gitster@pobox.com>
 <20250731224607.3942417-1-gitster@pobox.com>
 <20250731224607.3942417-5-gitster@pobox.com>
 <aIwyIJqEIdSdKINz@mbp>
 <xmqqcy9fog8x.fsf@gitster.g>
 <aIw85gIurfEhvuPC@mbp>
 <xmqqa54iljw1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa54iljw1.fsf@gitster.g>

On Fri, Aug 01, 2025 at 04:09:02PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > I agree with you that we would introduce another variable. However, the
> > thing I quite dislike is that we do ltrim inside the current function
> > and we do rtrim inside `append_one`.
> 
> Your "quite dislike" does not matter unless backed by a reason why
> it is not good, and for that, you need to think a bit deeper.  Then
> you will hopefully appreciate why the current arrangement is more
> optimal ;-)
> 
> There is a clear separation of tasks between this caller-callee
> pair.  The caller is responsible for finding where the current token
> ends, and the callee is responsible for massaging the current token
> into the resulting list.
> 
> But ltrim needs to be done in the caller for this to be efficient.
> 
> Imagine the case where you want to allow both non-empty and trim
> behaviour at the same time, and use a whitespace character as
> delimiter.  If your token has leading whitespaces, instead of
> chopping them into zero-length ranges and feeding it to append_one()
> one by one, only to have them discarded (due to non-empty being
> set), ltrimming in the caller before it decides where the next token
> (i.e. "end") starts is far more efficient.  It may be more
> conceptually cleaner, but cleanliness is more subjective ;-)
> 

Yes, I agree. Thanks for the wonderful explanation.

> > My thinking is that we should handle the [p, end) string in the same
> > place.
> 
> Again this sounds no more than a subjective "quite dislike".  Is
> there a reason why anybody would want to insist these two things be
> done at the same location?
> 
> You could satisfy the subjective "same place requirement" by
> inlining the helper function into its sole caller and still keep the
> current arrangement to ltrim before finding "end", of course.  But
> at that point, I would have to say that it is a tail wagging the
> dog.  You are making the code worse by destroying the caller-callee
> division of responsibilities, only to satisfy a subjetive "quite
> dislike" criteria.
> 

I get your point. In the later review, I think I should avoid commenting
things using a subjetive idea. Really thanks for your suggestion.

Thanks,
