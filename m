Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719C29B8D0
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940878; cv=none; b=jWIK4n5uoZvPCz+pIsOzOIL4XufQSNqTBd5ZeMxvCIXnsmY50c2Qa7VXVFKfpUBj3g3ZzJHs1DuUkiOujAYd1wlQjXvrdIq5Xcx7s++l4FODYElytIiGt4TSxDLFNtUedhzPo79wSLjUnZoDLVx8hDWKuWfGHzwZTM60Iz9ojHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940878; c=relaxed/simple;
	bh=LYGDpeL9TEzcENrjg2cq7JFrhz3XSUKLiKDzvbH/ToE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NL5FALxAITzARL+QfMtv0oLNJuEKSX/Uod2KB1W51nxtFxOIQjZs3IQF1hhI+gGG5EYNXArJBjV0Op3aNlx7xk7vd/G0Ma0LxfHwkpwmmII2EdibBWMHu20QYnqbZRDBQyl6EkdgMImrQBbI18D0kF3BdG/0dVxv1VlvzEV5j98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUEnDfVE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUEnDfVE"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-782bfd0a977so6696061b3a.3
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759940876; x=1760545676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oL7aIpIY+Ko6biz8iDwku+HKdA/vKqUgj8GOvs/ZT38=;
        b=RUEnDfVEGFNEDKJki8lLUxFU3DbRFQZO8zFrZEGaiwOm74N8ReXMGWzPzSIroQaD8n
         D5baRh6w20DoDBJ/yoEYLfsHs4bg1RQZFziM1GLoNEopaKE2oEakLBKJRIAHyCHLEdSL
         n/MI6eH9XIhEm/8HD3xbuKJcUiTTAwPJN4dsbCtYBmdSAHeK0umHcIl22bh9mKFcYTEP
         5saomeS4C+UlT+sin305w6mUg0glv5e9yV0QwCjCle+CRbwyFTqYNWc0KQ5kvSsx9YdX
         5bv1ethzbFtWoqqQjBrzq3CkM7OR8b0g1BJon6CHsAy0fuLN5vS2NhtkiBnZQtgnsSHU
         Vu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940876; x=1760545676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oL7aIpIY+Ko6biz8iDwku+HKdA/vKqUgj8GOvs/ZT38=;
        b=jwdMwrEkscqy44nbHOPvpK485l14Sq56YYZQ0jufibCtBEMooSU806s1ychjB0HrUL
         a8vcTne8btOQvWve1tHeZIIBY7zmwwgIL6ziDWZAPP3LHdapGnjV69zYCv9L3K48jdN/
         4/vBYkVYrLOS1Bjomzi24GtKMm5TtU8keqBJyDg+TQtY/UIwqlVadEnfY97tICuxRlr3
         R2988ANJCWaRCpM4/CGjtmOimRCDUWMqKiDN4O68hW9PO3cOEyz1jQMzk+587+zyCqen
         LcYubrO41wJw6+Ig7sEyPzvGmhn28dhGwUSqhBEI4Nmrb/fDgOJi/XUGMD/UoIvwrtvd
         GfGg==
X-Gm-Message-State: AOJu0Yz1pomMKxd8JU/lvS4Rt26ec7I/R8dvy4oWuEqN1HVmEJOa/Krk
	lCCmw9NxfYgRzdUtNsCnI9owtFUTlIOuTOpLah9SZfVql0dICcPsoU3t
X-Gm-Gg: ASbGncvqFM0J5IB3rQ2q5+Szyi1PaY1xOOPD0JMRz7+t20PgIJ52n9dA5+wFOq+NFoV
	XKvE1ZrgvQC6693vKpXwB6bYY8vF4DkajqrF1iTmg3DRof0HCd9uKK0gxy4Fz2eOUR5MiIPolec
	WMvQQ2cUdv4fvF0brJAlKUiZFVPqeG50loeO/ckYoPAMF+wkOu9YT05GYSPmg1TbPF3NPpNAthh
	8nXRamKKOoX+X8VJhewSwWcaOgn7Gt7ze4MWX71X0qbKXpqFtzi6zHn3t9ydGFj21WAvi+PXMqY
	XaD3cPSWveDQT0nMgip0rNOwIurG8kP8OMfVr2uCMwiHxfKil4bE9oW6EQ1Cn4T/EZZGPgMlgYP
	pjY3DNLmVTByC26bLKj0n7zN/J9OQ0Yx4BOSYWAs8Tg==
X-Google-Smtp-Source: AGHT+IGz3u9sYuQU+5IQ5GzekOwpz2F0SkxjpiA64BJmXR+DHoxJ8Hj80fDku5P1Pb/ejeYRDbv3lA==
X-Received: by 2002:a05:6a20:2449:b0:306:2a14:d0d4 with SMTP id adf61e73a8af0-32da83e6017mr5759598637.43.1759940876110;
        Wed, 08 Oct 2025 09:27:56 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b6099b1e362sm18506362a12.21.2025.10.08.09.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:27:55 -0700 (PDT)
Date: Thu, 9 Oct 2025 00:27:58 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 12/14] refs: don't store peeled object IDs for invalid
 tags
Message-ID: <aOaRDhwZ0YkPdjkd@ArchLinux>
References: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
 <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-12-76e30d5c9542@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-12-76e30d5c9542@pks.im>

On Wed, Oct 08, 2025 at 05:50:27PM +0200, Patrick Steinhardt wrote:
> Both the "files" and "reftable" backend store peeled object IDs for
> references that point to tags:
> 
>   - The "files" backend stores the value when packing refs, where each
>     peeled object ID is prefixed with "^".
> 
>   - The "reftable" backend stores the value whenever writing a new
>     reference that points to a tag via a special ref record type.
> 
> Both of these backends use `peel_object()` to find the peeled object ID.
> But as explained in the preceding commit, that function does not detect
> the case where the tag's tagged object and its claimed type mismatch.
> 
> The consequence of storing these bogus peeled object IDs is that we're
> less likely to detect such corruption in other parts of Git.
> git-for-each-ref(1) for example does not notice anymore that the tag is
> broken when using "--format=%(*objectname)" to dereference tags.
> 
> One could claim that this is good, because it still allows us to mostly
> use the tag as intended. But the biggest problem here is that we now
> have different behaviour for such a broken tag depending on whether or
> not we have its peeled value in the refdb.
> 
> Fix the issue by verifying the object type when peeling the object. If
> that verification fails we simply skip storing the peeled value in
> either of the reference formats.
> 

I have a design question here: should we just report an error to the
user or just die instead of skipping storing the peeled value? If the
annotated tag is corrupted in the first place, it means the refdb is
also corrupted. And "git-fsck(1)" would definitely report an error to
the user. But here we just ignore the problem and give an illusion that
everything is fine.

Thanks,
Jialuo
