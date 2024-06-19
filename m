Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA121262BD
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 02:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718764798; cv=none; b=k4ehbYhwMYljY0BzFiEi8Du4SmP41wYzMDs1dTGB0JuUoAVie44Sk7aD45mfCWFksiNPvTVQJ08ih+TqGhpf1hQVMpTyQJaI8rqDe8SGKKUZmb+7VpdYjJo9VZvNvZCpI8hVhXtHPvIG6UBPVKqbf16QzjizzTyqOo3zOBna4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718764798; c=relaxed/simple;
	bh=puAWCdKebh3davHSCoapVZBeelUX+tqBV2h64WLlFvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVxhUF+jgUbou0OitNA8EKObCq2vVccLV4M71LTvz4UEhHZq9e5gaMrXufHQa+WImcC4DJwFvBeepNKFRzyv4u+nGLhxjyJoRiCDzELCanmgKowCr/yyN0pk+tOeynulxtGiwFg/TAnl3XDxaOgEFw+ZE/u4+eJsTO1iMYzT0t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAFPRTSO; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAFPRTSO"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b9706c84e5so3540514eaf.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 19:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718764796; x=1719369596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qVbb+QzhzWxV5fK0HLi7ZZTz9SgotTa5W1g0r9AxH9s=;
        b=bAFPRTSO8nVbf3OWILTGnN/WsW6Pp5fWi0R9UMC+xZLLsE8Uiu5VeZJT0J8GV7cT+b
         TnEEveZDhpZapzQPXed0bQbP82twGFukrCrYscjaabXVg2Oo3irxYyWDm0lPfFrKKJai
         ez2e+cSkDm3EOUId/6aO3gznsjNAbQu7K6b1lw+DLnjYsudaW0HL4k4CUnmtwVGaDY9M
         x7ARfJnO78eTNi6BIdLmFcjBKuaEVSFZIbPxsVuPnW18uuBRlQazOt5kebAC2dQqLTQy
         AxXaGe6ImTfv+QCmxNhDkBrcxsECOQBoOkvC03ZrVnAC2mq+yaREJ67gQgppPJs+5nle
         +1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718764796; x=1719369596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVbb+QzhzWxV5fK0HLi7ZZTz9SgotTa5W1g0r9AxH9s=;
        b=e2G8pZvepgaoAiL+k8lAdYfn1/4AmicSN8of/LJ2n/u0Sjlqy5c4XoKqWJ2VJ/HRm0
         jSxypwJGZHKqNxy9fKtTbmyEIFuEjRLuzaEBlFbJtyMPIMQ3a7L5LQzfjxVKVFUhAhw1
         0ppSCoogyeZRqi4U2sUCfSy3R80BUv307Z9B4d7GbZJVs/R2YCnGiG6Cq4fwcqKZIS+d
         x1KChgBmT01rHdrsv1/0sNE3sFYLzOYrMThye7HJBXpKjTXRuUPvvxI4kTbYsIVrgRCe
         1KI+ORExxG/NSboLT7vrKSWrC+7ggX8Ql4xZhezrrMpGalOzHu4x9xBTDHfuc3KQu9Go
         laKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN4jl/G3Z/OsCkjtjAjAumN5BXi2CdPboHAEPbrtvTnoMy8p5VnNrYovyjSeDbwR0oG4dbmWYr4+/S2PkOzEcIcPpE
X-Gm-Message-State: AOJu0YynllVmOgGCyx6C1JEjW6dFQ1AfpKxA4fWqCYiD7j9ooZjAtRhj
	nzgqUiFKmqzhNe0zItrdMWrvc0WA+SAHEm0C4px9xVJuYjqcUBLzA4F1vQ==
X-Google-Smtp-Source: AGHT+IGHNqFNmG1sCFbk4wc++q3txmVa8rL+CFcFKSjtB8yodVum080itDCBW+B8p6aExkM+Atpegw==
X-Received: by 2002:a05:6870:1705:b0:254:9c46:8877 with SMTP id 586e51a60fabf-25c9499a393mr1625484fac.16.1718764795743;
        Tue, 18 Jun 2024 19:39:55 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf592f0csm8755241a12.54.2024.06.18.19.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 19:39:55 -0700 (PDT)
Date: Wed, 19 Jun 2024 10:39:53 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v3 1/7] fsck: add refs check interfaces to
 interface with fsck error levels
Message-ID: <ZnJE-QKgUfM3WSp5@ArchLinux>
References: <ZnFCEYypdAyXMMlg@ArchLinux>
 <CAOLa=ZS57EsZk+7xOW9imbA4oWANKf0b+HxBZ8hGFaQQkCsvcQ@mail.gmail.com>
 <ZnFJTdHQcHVagflt@ArchLinux>
 <xmqqfrta2ryp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrta2ryp.fsf@gitster.g>

On Tue, Jun 18, 2024 at 08:25:34AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > On Tue, Jun 18, 2024 at 04:38:07AM -0400, Karthik Nayak wrote:
> >> shejialuo <shejialuo@gmail.com> writes:
> >> 
> >> [snip]
> >> 
> >> >  struct fsck_options {
> >> > +	/*
> >> > +	 * Reorder the fields to allow `fsck_ref_options` to use
> >> > +	 * the interfaces using `struct fsck_options`.
> >> > +	 */
> >> 
> >> Why is this added? It makes sense to have it in the commit message
> >> because it talks about the change, but why make it persistent in the
> >> code?
> >> 
> >
> > I explicitly add this comments due to the following reasons:
> >
> > 1. If someone needs to change the `fsck_options`, without this comment,
> > he might be just add some new fields at top. Although the change will
> > fail the tests here, I think we should mention this in code.
> 
> Do you mean you plan to take advantage of the fact that early
> members of two structures are the same?  IOW, if there is a function
> that takes a pointer to smaller fsck_refs_options, you plan to pass
> a pointer to fsck_options from some callers, e.g.
> 
>     extern void func(struct fsck_refs_options *);
>     void a_caller(struct fsck_options *o)
>     {
> 	func((struct fsck_options *)o);
> 	...
> 
> If that is the case, then ...
> 
> Do not do that.
> 
> Your data structure design is broken.  Instead you would do this:
> 
> 	struct fsck_options {
> 		struct fsck_refs_options refs;
> 		... other members ...
> 	};
> 	void a_caller(struct fsck_options *o)
> 	{
> 		func(&o->refs);
> 		...

Well, I totally agree with this. It's bad to convert the pointer type. I
will change the code in this patch to make it OK.

Thanks for your advice.


