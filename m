Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FBC323D
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697534; cv=none; b=C/VAhSH7JLXK//P9hd74hnqFvehivuNmLcqVKRqy5skRCgEFDhI4yWx6wssQAYRuUEcy1SaDqc5uOfRIFYyYjznVXKd28QtJQBwyQGm+cl2Gy6LpQxWVy/TwfMJoqRndJzRPOWDHDSM+1OO331hGv3J19qSD6+oNAgdzHSjWQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697534; c=relaxed/simple;
	bh=PqQQ5Jes12QltZ5KJTQCk1J7ZzH+HEOb2QE6rcpSq5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkDyDA5Z5twjqhzCqfQSJaqhonNiN0TqjuAaNncjqd5Kh2bDdCyIHLSglGJB4VU6VnFne0IrnJbg0Qm+TVKCB6tt52cdOMleeNPkWI10UQsiJMnpavRVpU7QKjP1ZxzCx+a9CapxbbZIG/j1j22mUs8+C+4VGixRo2OyHgCIeIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=l8Y/jlz3; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="l8Y/jlz3"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47210a94356so11506941cf.3
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 15:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740697531; x=1741302331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n52nzR5Yut88B8abJun5HQhrLPg2+Qs/ePyRVFayXS4=;
        b=l8Y/jlz3lATLhsBiU/pQOwxl5uJ2Jm7kniA1TP3Rv5HMHHsC04Gbal65exr2LlQ1Qk
         S6NtBRXTmIHBHON/9ctkavg57OQc/IBsd8ZfR00nAe/QJ8x9R+VlfAC6fkQiBLwPcDlb
         LefIdn4+6/jAEbzXAZirztrFZjF8pJN0SkWZO3dHzTEzZMPOd962BIC6MrL3F4uV2Tr/
         BkFc4hQ4YDo0PHOqAiXB7Qidns4x0+7ICHdLfJWmV5lD7X+bK+OKU2zDPwCAL6jaRFmg
         psuf9ZeHs5C1jOgxlu9pc3+yoPPtCdC24mFDEw6KsleFRP+vuJiI2nLKnUD89P1wTFzt
         3Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740697531; x=1741302331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n52nzR5Yut88B8abJun5HQhrLPg2+Qs/ePyRVFayXS4=;
        b=lBYaCGpSDSwba5RR/fP71bQ8Os9NRrNxY2P+Ntm3Z9G1PAd6+59oigPHWC/8KufCUD
         Biqjbo2PjXDhSeEA8tQFIAk0GgIC2S7y0TM9XMKOM20gzDR6qTBpBkghabPcMYy1ZuKW
         NXwFe9ChenGqUEc7GczDabFU68wVnm4om6DeXAUXMnT/QApTgHzPeUaluyr6m+rSO7Wf
         jlF2i2NdeGEHCVU9PhuWj8pEDe4thHDaMR5mDy+Ec4FYRKdHaR0BOhzPCpzJlLjN3lXk
         SL3bx6ibP7ycid5hnp/obVm2sksu5TjoMLijRUmBvDuWBoLfGDCvn3ds0TvDuHvkN168
         U+fg==
X-Gm-Message-State: AOJu0YzBkHlfY8opHbSZJFVVpSt0ySLa406kk2wEUqw2+UpPykNcg4FY
	kDVqP6FlFuLxKmM/kkbgxkM+yZlzxJgMdMpzbu3NtVZbsi6w9P/ZUssGwjx+6At5ceo25+0zqdD
	F
X-Gm-Gg: ASbGncukaeirr+r6+s0nVoUCUjeUJ3KFFt/paN1XyQ8hxv0VFlaAHrYBk2XkUtXS7/+
	8QAZRJSKPQlpYUGpunZ0M02OKTNFgbu+YKLUOCueQtKn0gsYpZLWzXsZeFpB3L+9epuOhLuRPd0
	zmkeKm6WGhjAzc+ACM50hmgEyC/3dchk+bhuSCMMSad8B9OyxazX9NSi3DBx1FEwUgKiUJfn6g7
	YpLrWNIg8nut9zduiwAKlUXBPkefvARpRqP10Qil33UpCTRqmkP4723Yl4tnS3BQ7YKd9Bs6WGt
	Wt6pDs15e54fKJgNkb51AIZHLBRzBr4IVa1Z2KbedZqU4NkArt2m4hD/dmNi94CVLzwe3EUEBw=
	=
X-Google-Smtp-Source: AGHT+IFWLFotYlOQYSsj+pK6CLQK/dY/nHanKNJEd/m+Mts1izp0dYgX2cbcjS0kOQlnT2tItC5rPg==
X-Received: by 2002:a05:690c:3809:b0:6fd:47c1:fce4 with SMTP id 00721157ae682-6fd4a0b3012mr17827727b3.22.1740697521109;
        Thu, 27 Feb 2025 15:05:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3cbc5ac9sm4870217b3.121.2025.02.27.15.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 15:05:20 -0800 (PST)
Date: Thu, 27 Feb 2025 18:05:19 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] pack-objects: freshen objects with multi-cruft packs
Message-ID: <Z8Dvr3F1t7JKuNQf@nand.local>
References: <cover.1740680964.git.me@ttaylorr.com>
 <CABPp-BEK3T28iqDFxbMHa7GVrythYs+ze7wCZ5Q-LDjOmquiVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEK3T28iqDFxbMHa7GVrythYs+ze7wCZ5Q-LDjOmquiVQ@mail.gmail.com>

On Thu, Feb 27, 2025 at 11:28:18AM -0800, Elijah Newren wrote:
> > Previously the rule was to discard any object which appears in any
> > surviving pack, regardless of mtime. The rule now is to only discard an
> > object if it appears in either (a) a non-cruft pack which will survive
> > the repack, or (b) a cruft pack whose mtime for that object is older
> > than the one we are trying to pack.
>
> I think in (b) you got the meaning reversed, and instead mean s/older
> than/at least as new as/ ?

Oops, you are definitely right, that is a clear typo on my part.

> Code changes look good to me, but I had some wording suggestions in a
> few places for commit messages and comments.  (Sorry for missing some
> of those in my preliminary review before you sent this series to the
> list.)

No problem. I had only shared them before sending them here for a sanity
check on the implementation, so I was figuring that I'd get some
comments here on both the patch message and contents.

I adjusted the wording of both patches slightly to reflect your review.
I'll hold off on sending another round for a day or so in case any other
reviewers want to chime in. Thanks again for the careful review!

Thanks,
Taylor
