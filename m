Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F62F223328
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044832; cv=none; b=OzHsSPwX3A/5WNFgx/xDkFa1RVAMUXgUiWSf/BpCHkJUHXEUplQEsPFO/4WGBKa8X7yBmL375Ws+2EqHODKDodAg1mKYNokQYF1h9NDoMKw6Wk78zVXbQrQa2IAdsrc4woiDN7lquHlk3FUdI5XxzYyBKsVPUNff0gekC75RMVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044832; c=relaxed/simple;
	bh=1ImUT+ttU4MSB1L8bKP1HcpQcOgdCvlHQf6AGcPBZ9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQClbnJA8FdikFVXUxfTPQzZoWvE5O7L6geT2klVPz3cHFVOKUWoc8gXQGffKEf9I0OT5T3HGWxL+6sk7PQXewcM/zVXh4hbDiFHi3i7DoxJKFhzZCSaYNmmc1wwr+NK4h+0rgC7AeUPKr2O0MPPt8qYAzSPaWvW9CQrnXuX++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtN/nTmE; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtN/nTmE"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-62340cf68b2so409229eaf.3
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758044830; x=1758649630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JvxrwVEnDUNkB2RiP1DcRwuyDZ7nFr2IkfDqP7bRe1M=;
        b=RtN/nTmEkm9n5nyBKp0n3kwGKDbuZT184qnaZzMTTMNbd/RdZpVOgRkb50OcrCCv/3
         QQuth4QwWa6vOI29u2P/zUBgTf0ciFk4Q/J2R4RiCa9v6R5Bp3n7+q0+b7mzQ0uQKsk6
         31cnymeXdBrI4ZEFDk4jG3X6MhJQVis8CqZWpVY8ma09cGl5P9Pf+MbpUAobzRWthJlU
         nuu3AeZG8Tl/iufQvHzOiRaCWWJ2RzSrR/hC5/uRfKtQDTN6AQ5xDgqwt2R+hPDnspOl
         rCQFKAYo1cj/orRnhtlxN4D/5PUvHV5a4Wy4usGRfP0+15Ch1BQvwNVvHxxdNaGw8ZnJ
         g1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758044830; x=1758649630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvxrwVEnDUNkB2RiP1DcRwuyDZ7nFr2IkfDqP7bRe1M=;
        b=isYHaNz1K+A4gIFC6PCHEIczdUOPt479ZlJzBNfEAG98aSTRAk7/l6GuhlK+LHDKSk
         OuWDeQwxkshDuHrmVsIkX2NjgXm6PH6LnGFZyM8c9PFx6j4jApLcfRv6eoIOAaNd+YuC
         9mOuXgOv8g6lbjKzlfHU4ppTuo+F0BcuLVcYPkYluAWdW0HESIki2LdmyQ0KZne0dFe/
         Q7WDGusInLF2tPYPW5vQHqWFh4Hree+a64AH8bg+dgJg3ZD5AhFe0L1JtCV1ylIsu6wp
         eOLV3ZzqIH13Qlm/JrOTZ8JMkcT+Iy2NsP4ynKIeMTV8ldMcXF4z+2XcbjldFr45XREg
         LHng==
X-Forwarded-Encrypted: i=1; AJvYcCWpiZN+UvUyHA5uURwnQ4fHIM0GT5eGLBymMWvGhQxTgPwevFXxYdd1JGPoZ2H680Hu5fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHdBfYShuM7qVewC1+TBaRPjsCthRp9ocbrB+XcVS20vjptiTH
	QdlTEUp782tUHb72TQDV5ZS0ov9a4wsqg1ve9RYYgT70ERJxI0UUom9n
X-Gm-Gg: ASbGncuETzXzSxBv4Z7mdRp75hdzhJhXlTXhttwMqStavkEjyk+TNbWRQX0AaKspbid
	89RU1uVV3uCk8Vo8coW1Dlwhibzw6NaNHdr8l3ajuwx8fFJYPSdbrNR+wQ9fjXjYdd/U5J6Huaf
	Pp/oVeiyGQROTpXcJFTpYLJl1CViMlzDBsdWnqShQM+v+J5iCPS2fKcuQtq+zCEOyz8yJ5AjHIQ
	BFHEhvH36+SXcXfk3G4gB7vt4xtX/1WxcYjQpV9Be9RvUEp+abbWE0eFdKtj2qwCEWjgXBVdwbK
	tFMUstU1awHVGEjQV8QKTsxwNG+qkn7/Z9aqoSrXOvyqQfP6xcmpI34+3BbcRz41R9jz+w91h7j
	0c6vBXJ1NQpoH8Wfr
X-Google-Smtp-Source: AGHT+IFthMi5g9Kb28WQ/P0TpQLUOek4BPSrJ1detdycdgbaRUjJ4Z546HTXjd9aLLClQ2mtanZTaA==
X-Received: by 2002:a05:6820:1506:b0:621:cf08:cc88 with SMTP id 006d021491bc7-621cf08cf13mr5585634eaf.6.1758044829905;
        Tue, 16 Sep 2025 10:47:09 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-621b7d22822sm1773411eaf.14.2025.09.16.10.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 10:47:09 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:47:07 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>, 
	git@vger.kernel.org
Subject: Re: [PATCH 1/6] bulk-checkin: remove ODB transaction nesting
Message-ID: <vy7ah7cvv2xtq74h4zn2peqnyprd672v5pkfxskduyznrcpp2x@uqs3ksrhw6z3>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250909191134.555689-2-jltobler@gmail.com>
 <aMJu4yoO5-Xp52oJ@pks.im>
 <aMijGE2CveYcQaWc@nand.local>
 <pk2cpihxk4j4ywgq3dtknybyzjeon7ajgmwq4yhknojjsfiqo2@q5dsygszdkar>
 <xmqqfrcmny8r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrcmny8r.fsf@gitster.g>

On 25/09/16 09:44AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> > Yes, this patch removes the logic that manages the internal nested
> > transaction counter in favor of requiring callers to check if a
> > transaction has already been started or not.
> 
> OK.  Is that related to those "make it a silent no-op to pass a
> NULL, instead of forcing the caller to check" changes?

The first version of this patch initially required
{begin,end}_odb_transaction() callers to manually ensure there was not
already a pending transaction. If this was not ensured, it could BUG()
out.

Going forward, I think it probably makes sense to change to a silent
no-op passing a NULL transaction value around. This should keep the
existing callers mostly unchanged and pose less of a burden while still
being able to drop the transaction nesting mechanism.

> Can all callers tell reliably if there is a transaction already
> going?  One transaction may start somewhere and end in a far away
> place, and these two places may not be ancestor-decendant in the
> call graph but merely a distant relative that shares a grand grand
> parent.

To start a transaction, callers must have access to `struct
object_directory`. To know if a transaction is already pending, the
`transaction` field of this structure can be checked.

Ending a transaction does require the pending transaction be provided to
it. All existing {begin,end}_odb_transaction() call sites don't
currently have a problem with this though as they are relatively close
together. If we wanted to end a transaction somewhere else far away from
the start, the pending transaction would need to be either wired or
accessed through the repository/odb.

> > The ultimate goal of this patch is make it so invoking
> > end_odb_transaction() on a transaction guarantees it is flushed.
> 
> Either flushed or a noop, I guess?

Yes. If the pending transaction is specified, it should always be
committed. If a NULL transaction value is passed, it should function as
a no-op.

-Justin
