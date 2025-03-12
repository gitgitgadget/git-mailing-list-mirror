Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1831ACEB0
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808040; cv=none; b=b+JGOflZRRoIW4Y0tQNfohQ0ESGg3kUfS4KOyRbZ337Bguit7Rj4KAb30RaSf3Ur5D+7eeqCVpGOVrb6vuvH4eq3Hig2jY2tAb0zYYEOyQ2J+vIdJv5OEtmqcxRjQiV3pyw2KR8d9yWtYxcz30tv8NxYaUT4pxLVkznZ9keA5oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808040; c=relaxed/simple;
	bh=FD+P11bFA9mwmriLGcOLY1CV17QcnS3ZANB5cNViL+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn+XXK4+n68Flgt07EeaJotZ174BiG4KDuqWc30osI8m76Nh2yW5RxwfBuNBVSIWC4X6bLB7g6QbpjsygX9h8YwMLTUkVCatLtYyTe3WKY2u1ENfwBmOHJafHTTG7EJqMnlvFF1boyQnSi3LrYi7Rns2aQwopdEQ+cH9TlhAb60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VE+SaU3C; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VE+SaU3C"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f6ae4846c7so2071957b3.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741808036; x=1742412836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fg/y5Mm9+yvntyodJeFephMwDGhhxbUkRS/tS/TUNwM=;
        b=VE+SaU3CrD1QHjl289o18+PgEJgr3+CwlthtGWuQ55PfaTdbJEz5YQ7Y15rV54oeT2
         sCCP4M5uPR/VWGiqMVynWo3OBQs4dmnzRIQA7rcJXxKv5l7SwZFjv8uQs07ylSo1uQlb
         6NEAq4wLXbpRh/yidGurpnp//tkc/Dmd+o1Wj8SGZDb3/Ngq0LEqgNNh/R8VplclGqnY
         mY6Akcda5OypJPeoDCAqzIBsWE3rRG24cCKV8dpqYAl9blq2n9FppEDxQ1cYYCxDmO7w
         NenTdMJRz2LgjMDqWiDtG2TJMk4A3Qv7Rh/oOpOl/x71Qa3UbruzVkInYm4W/JJIBO8w
         5jQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741808036; x=1742412836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg/y5Mm9+yvntyodJeFephMwDGhhxbUkRS/tS/TUNwM=;
        b=GozOevTZNke6ibTDzIJwWikVtYzfveliRQX0KDiw2XJfKc83c4ZwE/h9VcFS+gWe9j
         YHsT7++5MVIzBNrDeQr+xA29u0Bdhw/TNHxrsKeX7OMOLHrxMpHyJ92aI+nf8zBR3vTJ
         ahnic/Pv53zNcz+XBoSDHtioCKc5+FeSU6188oVEGECBUHDl60rkGJHRuqVsRGSYQzJ2
         XzSK3GJyk3x07vPswxPragyoWHAAuuHhnRB5ySwWlYpQxzplpGxqJ+kdGMvGbEVsmpyg
         rP+zWZd7W7kKY7P/Fo3Xz0MFJNIPbzJugAv10wejyKUKJln1etww4rysDHvZeB/frkei
         ncaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfAc2saOUeLkl5cJq47x2GQeiehjyl/6uWTB3SHNNc55w4dZy+JZmYndo3Pu1CO2tJqcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc+C2+jMn51VNrZhOUQSZLoiur1D4e/h4ZeNww1Gk4YxncLwSq
	PJZr3nNkV/ImhaXycPOtDSjPDMmbAPG6S6TgUcTd1UB/pYv8m0t1nlMUmoTef5U=
X-Gm-Gg: ASbGncsCAWqqYErxobtU7CNw5JySG7rvukYOJ/+rVcILS+OTIdtyj5sDkwFQFdk/5Op
	P1FTWnozXK99sbDhQAFvCF5SSSRdriEUgpgGCEvDddDOlfv2fFo7uAdFCKiKUh2crJqxKH2m7hb
	4GbhVeLds9JH6akCl9uU5MVntFTwCwTq4T8Q4v0iEo3+PQJM4cgPaQJwd5ZSaCNPUPXaIJ5E8r/
	6wv86l9k8Xn8w0VCQwwZ481MXfQtjVkh2Jj6jy/rAV5dKTJaKV3XKP3FphnloedR1pYSM8AahSu
	LIpdSaXE0qGGIiX7j6QBtQiLIKxVygMOJdWWPW2NyhiDtRe76aL1ipBIXJY/Hd/lF8lR8A2YUFL
	6BcjFpwdJlo9emNL7
X-Google-Smtp-Source: AGHT+IEa9ASHwatvfyMV5cZKRYdGjoOwxAHZawFDdUIqMooTETBXZQr7+9Hf9J18KjqsTFvW95U38g==
X-Received: by 2002:a05:690c:650e:b0:6fb:abd3:d98d with SMTP id 00721157ae682-6ff091abecdmr113282537b3.7.1741808036585;
        Wed, 12 Mar 2025 12:33:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2c304c4sm32860567b3.80.2025.03.12.12.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:33:56 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:33:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 4/6] pack-objects: generate cruft packs at most one
 object over threshold
Message-ID: <Z9HhnpYYbe/FNUWT@nand.local>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741648467.git.me@ttaylorr.com>
 <f2ca92245ada74825806b50f786aab312275fd85.1741648467.git.me@ttaylorr.com>
 <xmqqikof2pqp.fsf@gitster.g>
 <Z9Gmo2P3Fnt3JeOs@nand.local>
 <xmqqjz8uxfyq.fsf@gitster.g>
 <Z9HaYEyYgBYTiia3@nand.local>
 <CABPp-BH0rbieCV4Z11pHOX-mwrtEO-FPNdywV0P5HxXnusdRKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BH0rbieCV4Z11pHOX-mwrtEO-FPNdywV0P5HxXnusdRKQ@mail.gmail.com>

On Wed, Mar 12, 2025 at 12:13:10PM -0700, Elijah Newren wrote:
> > > > But in current Git we will keep repacking
> > > > the two together, only to generate the same two packs we started with
> > > > forever.
> > >
> > > Yes.  That is because the logic that decides these packs need to be
> > > broken and recombined is flawed.  Maybe it does not have sufficient
> > > information to decide that it is no use to attempt combining them,
> > > in which case leaving some more info to help the later invocation of
> > > repack to tell that it would be useless to attempt combining these
> > > packs when you do the initial repack would help, which was what I
> > > suggested.  You've thought about the issue much longer than I did,
> > > and would be able to come up with better ideas.
> >
> > I think in the short term I came up with a worse idea than you would
> > have ;-).
> >
> > Probably there is a way to improve this niche case as described above,
> > but I think the solution space is probably complicated enough that given
> > how narrow of a case it is that it's not worth introducing that much
> > complexity.
>
> Would it make sense to break the assumption that --max-cruft-size ==
> --max-pack-size and perhaps rename the former?  I think the problem is
> that the two imply different things (one is a minimum, the other a
> maximum), and thus really should be different values.  E.g.
> --combine-cruft-below-size that is set to e.g. half of
> --max-pack-size, and then you can continue combining cruft packs
> together until they do go above the cruft threshold, while avoiding
> actually exceeding the pack size threshold?

We could, though alternatively I think leaving the behavior as is
presented in v3 is equally OK.

We'll never make a pack that is as large or larger than the given
--max-cruft-size, but because repack tries to aggregate smaller packs
together first, it's unlikely that we would ever repeatedly repack the
larger ones making them effectively "frozen", which is the goal.

Thanks,
Taylor
