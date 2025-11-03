Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBA21C5F13
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192792; cv=none; b=Hk25keEFCOVneOl5DdkmHZfhow4ubXENWNvrK/jDp+gEjjbhT+gSBMkCTJ+nXGkglNHS9KlhYc/90Uo6vtRwA+T4hg5CKh92iUgHjav/Ibqo01Qq8fKyZ689EnyEoKwVayvGX7xDim55cWBOXqEGffZauFMLsyrROwsZrvF1Qg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192792; c=relaxed/simple;
	bh=xM1ORG4zpJPTmIOBerB2jyh6gxCj4yQErRFQHjxXhrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj3348XKpvv8ysdDZxQB5+95GC43Snt3a23gbFSRO4BwLs+wwibxVVoWxbNeLVpYi9PTRZyqvSsZtHDyGRjGaNO1sjdyPZdsW5g1lg4DpH12X15A4OR4mQxffluKIotRaRYXTpEez3oTZIYC+zlfjIl5AbPipYPaBbkk6MTj7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZY09YAY+; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY09YAY+"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c68bee554cso2704994a34.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 09:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762192790; x=1762797590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/TH1s6+M8B4IwGFjKOYCpnGeFm2DMEBOXaz+muNez8E=;
        b=ZY09YAY+sV3EtyJbufIg/eujWrLVPiqXfk/r7t1yeiexZDrYBLA0LYoJ/aN5sJFVi4
         dF2JkaegBiEDhBOwDdaH3Xyj6185hwOKhKYGlViOHLg7pml5yTY4GbWyLzk+Lu+4nGyC
         GxwOYStBMquiw6Ay0oFisvs4OinhCGH/+oufuMVGsFamEE5VIqDqT3JX3AiFGNDhbhWP
         sIKoAuXkNd+QNPw0h/7pPmPeF45hDnTwPod/HhrqIVe5yX1k1H4zPJse3iIAayF7vcig
         cWbO94EHxSooPckuMlOGTVjR+4DETmKE6cXoKkCL0lA/TGVqzTnYRDI0jl1/9yeqnr6r
         CVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762192790; x=1762797590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TH1s6+M8B4IwGFjKOYCpnGeFm2DMEBOXaz+muNez8E=;
        b=Mo7p7MKvH7W9UMigCHqMSZb4Sw6jRNazW8XhI/clNJSuQbsrjk78n3g+uZN/SbkkHM
         yvlatRj+F2reYkqGidZ18w1kLvXjXOU4x8EvtM6F5+KRIyjqdzNPBHZMAzOsWsMJbgR0
         RxpT65hBze3GI8Oaxfag6wmynvZ+I3cDrxZuXWmuNHFHleyf28tQwRxqzNVF7RW/cAST
         alx9b7t0S0Nrv0koUnoQIoy21GWSsJ+B06ggIS3MYBE7l3F9elaLbRL0ARMwVsXm1c76
         w52Tdzio+YZcgUvtXcJoRV8FT/krNMYvoXcjlYdox/dqzVN4ultsWVZgCIphG0UGKQX5
         zi+A==
X-Gm-Message-State: AOJu0YzB9sMX7rkORgLRjgy7nxebyve9azTYdv678dAga8mgwV0PaICs
	OmMNKDT3lmN3Lqsy49bzR0raabLWDtG/5RDllytCh2OETFQZ/j9nx3uE8W082g==
X-Gm-Gg: ASbGnctU6g1XCc121ZeUcoxrF4+o+X1e1lYmmGK71CQYk/Tx4HGk+LeV6ezsa3vyiCZ
	7mIP04IPW79dbDlCdGjwigp6sTDOiRLlJ2XMN5vMyxLaVEl7/lyoXd6sQEyRkMYwvQBN0dkyDDb
	ev0hGYAhOHckH6HZaOP+MJwWsSLjc2dn67phsXJDgsJGrAwfBmN83ubbVS339Y1uFn+RRRD37ke
	0E/rb16FZuBmSmfxO0aEXppdCCgPnVikC+lZdVdlAMpv5H6Z/upMoSll5OA4MmBTPH2h56Hl3vf
	zjVBcIkNNoQZcmFH3paKuUCYjUb86xnjkH+p6IOvLfBm+wl6hzz30ui18GUX/h9e+ZR7AT6R6qj
	SOOMSNmElGuU3/KnnfnQ0/gLodtfVXsXImLS4jeoXWkeimW8EBCEo9Tj/Vu9mvpAWYqaadprqkO
	JLVVW+
X-Google-Smtp-Source: AGHT+IEjGUVR0OlA4AH6wJ8JcEvmLskHThfxrLu5HqBov2p4o8DSXDXMNVf1lYhIxs4R/SlAC3J7TA==
X-Received: by 2002:a05:6808:6f85:b0:43d:498c:2157 with SMTP id 5614622812f47-44f95ef2a5cmr6153996b6e.29.1762192790411;
        Mon, 03 Nov 2025 09:59:50 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-44fd84b3624sm226281b6e.7.2025.11.03.09.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:59:49 -0800 (PST)
Date: Mon, 3 Nov 2025 11:59:47 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] reftable/stack: add function to check if
 optimization is required
Message-ID: <6b45z4xnzwzfi4ll5bintxqsrdwpaeb2mhozlujufalgrgfys7@6bw4z2ukplkn>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-2-a03d53e28d0e@gmail.com>
 <tdgxvocyp2armupgbti2wnbjphdvidooddbdyrynmdokjgqr3o@tzrbu5lcgipt>
 <CAOLa=ZRzLviMkc8C8617L48NwJPvi7F1Qsozezm9gUQ0_dRU4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRzLviMkc8C8617L48NwJPvi7F1Qsozezm9gUQ0_dRU4A@mail.gmail.com>

On 25/11/03 07:51AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> >> +int reftable_stack_compaction_required(struct reftable_stack *st,
> >> +				       bool use_heuristics,
> >> +				       bool *required)
> >> +{
> >> +	struct segment seg;
> >> +	int err = 0;
> >> +
> >> +	if (st->merged->tables_len < 2) {
> >> +		*required = false;
> >> +		return 0;
> >> +	}
> >
> > Both `reftable_stack_auto_compact()` and `suggest_compaction_segement()`
> > already check if the stack has less than two tables. I wonder if we can
> > avoid having multiple of these checks by instead having a single one at
> > the start of `stack_segements_for_compaction()`?
> >
> 
> Well we can't for two reasons:
> 1. We want to perform this check independent of whether `use_heuristics`
>    is set or not.
> 2. Currently `stack_segements_for_compaction()` does one thing only,
>    which is stack the segments. I wouldn't want to introduce another
>    responsibility to it.

That's fair. From my understanding, `stack_segements_for_compaction()`
populates a segment which defines the range of tables that should be
compacted to restore the geometric sequence. Since we want to ultimately
know whether compaction needs to occur, my thought process was we could
maybe have a single function ("check_compaction_needed()") that
effectively returns a boolean and maybe be able to reuse that. I don't
think it matters much though and as you mention we also want to consider
`use_heuristics`.

> >> +	if (!use_heuristics) {
> >> +		*required = true;
> >> +		return 0;
> >> +	}
> >
> > Is there a reason we would want to skip validating the geometric
> > sequence and just assume it compaction is required?
> >
> 
> This is the difference between running 'git refs optimize' with and
> without '--auto'. With '--auto' we will use heuristics to do a geometric
> progression. Without, we simply compact all tables into one.

That's for the clarification. So without --auto, instead of following a
geometric sequence, a different maintenance strategy is used and we
compact all the tables into one. Makes sense.

-Justin
