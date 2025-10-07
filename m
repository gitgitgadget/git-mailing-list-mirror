Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884043FC2
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868244; cv=none; b=cSXa/Hu3zJqAx6bphKMnwMnH19GNzyoN2nXU9Did50s4CK40SyCOLzy9Yi0yvk56flcx3mP5smbWfT4/zwv2pGSpaqUt0vzrk+6jMt5J3YrwMfgRpHeGRwly2IZO6VjEVQQ5hv9AleM4nNngeq669oB4MXNYq/rJ1FD5sEVwhX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868244; c=relaxed/simple;
	bh=0JiLjldCoA6BvcPbZLOT8hakHlwjKAnrBXGyg4c+VCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPt5UNSFDtC/plOxlqIF2UT6+5iP8JIfqZiu1F4QDXqvPtD7FQOW8Uo6V9lp+f1wl/mGjqDdptJyUgSX8dRlbrxtuPMs6XWy7F3h+nAGYMtuPd0jv6/DZptE7v16zXfGgkckuSJMhIAMEIB9av8NBHVtv85mpY6ZCVfO5ZzgJ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=dbCuBn11; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="dbCuBn11"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-42d8ad71a51so78359595ab.1
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 13:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759868241; x=1760473041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWRAai6mP5pmKtUS40coUdJk63VIz2kCCyMNzmPE5iA=;
        b=dbCuBn11UZNsWNTFLytixoquXmz9dV6rW3FA5h9vIMUGnCkzjhS0zP+l+AGD1KADow
         4bBFo2kwP2pPBdBsA6R19ykRA7IQtCxPODUHgA9VcTFXXdb4Hs/ZM0DnOZWv/1MSXz3K
         TJVgSltKNae6ht/A8FCQvZEmVuw5VC26yfbKLU1WoYstcBkQKu4pHb0cZo5VBaHI23U+
         zO2LGFD34LZYMuQl2/5AjuvrnB0ZoA3qDOI061KUaIxcK35a5XGcTFNM7eUWO62Nx83U
         Wb4DULNN/EBYrk7Mrb1aq5upwCLfnWsOf+8dCkycsh9/Tf8qHhwbsAoQK52bRL/HrmPA
         o7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759868241; x=1760473041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWRAai6mP5pmKtUS40coUdJk63VIz2kCCyMNzmPE5iA=;
        b=UubqQT/faEde8h2OofqmELv2kLiboGkYLo96CgyVCF8jrsSSUNpdlueIOqWz7NQetq
         zcVZe9MFfEQ1HVk5b+fqTKxk0kSbSggm0ai+2eDZfjrp8uFgAZemEDiZVa8cWK+mU6eq
         IBn158APHelUhlUiHne0GBPtA4tsBJ9BcOo0zv1CF0kXOtffhmIkoz45lk19eieFC5Ku
         f+MAGndMVt2LaFAqxLLTRUp3v5q+53IYicXw0ZV42skRrafNQeUYAiVr9RBIHyh6+Ffk
         9cVTGZv9RF7QFRvQeOd+jdDug6q73Ez7qLpiumV2UcifvmGYYaflt7FxP+O9gysoHIb1
         NYog==
X-Gm-Message-State: AOJu0YzDVgW80oHq76GpSyeJC1L0QhknonJXS83HddEATNmOEPol3Qik
	IdXVUa2L5hFp13qnqFMpeivRJ3hWkkTaHGHaD+eZh3eksLRAQvi4b7GWykbpEoweoWrtyVwJexN
	zYdVDUCOF9Q==
X-Gm-Gg: ASbGncvKAr0kAcvKSYA0Gv0Zuy7WcbhMYrjlG6tn55JDZuL/+bP5Uug7b0efuR/KlWC
	aZ+D6RvnFCYU7ywoR+L8P4E0gvdg6WKsqtNkNqg7DDh48kLvHE2EO+QLd9uSkJj9gWD3H/Vip90
	r4sa1gwuniNgX6wEB5MNSX0Pl2xQTS9Ti8M5dAfTRk8zZ+k/ce9i4TEL9oyiQsOyYL2TH5DS7Uh
	Ov+/78+HAOaBbYbp3lmTexGDN9i34C1wt4yqvECnx+bYfU+yu5UJhDyKBLRevsH9OtZ/G6RTzHH
	GPjY3g+E7dLnM/xrK2skZSWjc1hiCpEP2i8Uq6+ZVZJabVCub8trxwFJIOhFEC8bCTLxj4nmIk0
	EVm6JFY9KD8oxCrIiFtT6lnZq7li81F3vl8BIZlEKPSvlXDriqDB4lymstJFf3UMiXMPBLsHa6y
	pUBdMjXq2F2JBXhVbr1T8yshFcljGX+5GuRjQJ5pR+bxEh4cnqIA==
X-Google-Smtp-Source: AGHT+IG5ARqkfWPZZLUfCVC7zmSYZ9Kk6T+3hi7sDftoFJtZxjLeHGeosuF7UKslHnKviQc8CeXBkw==
X-Received: by 2002:a05:6e02:3c88:b0:42e:23e8:66f6 with SMTP id e9e14a558f8ab-42f8735bacfmr8892145ab.10.1759868241364;
        Tue, 07 Oct 2025 13:17:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-57b5ea4b312sm6239826173.30.2025.10.07.13.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 13:17:20 -0700 (PDT)
Date: Tue, 7 Oct 2025 16:17:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 07/49] builtin/repack.c: avoid "the_hash_algo" in
 `write_oid()`
Message-ID: <aOV1TzXOizrK3d4Q@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <37a7dea848f9618f7243fd9ff8ed704adfb3cf4e.1759097191.git.me@ttaylorr.com>
 <aNsUZtGst4MguEXq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNsUZtGst4MguEXq@pks.im>

On Tue, Sep 30, 2025 at 01:21:10AM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 28, 2025 at 06:07:37PM -0400, Taylor Blau wrote:
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index 094f5a0cc2..7d62959dc2 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -413,6 +419,7 @@ static void repack_promisor_objects(struct repository *repo,
> >  				    const struct pack_objects_args *args,
> >  				    struct string_list *names)
> >  {
> > +	struct write_oid_context ctx;
> >  	struct child_process cmd = CHILD_PROCESS_INIT;
> >  	FILE *out;
> >  	struct strbuf line = STRBUF_INIT;
> > @@ -427,7 +434,9 @@ static void repack_promisor_objects(struct repository *repo,
> >  	 * {type -> existing pack order} ordering when computing deltas instead
> >  	 * of a {type -> size} ordering, which may produce better deltas.
> >  	 */
> > -	for_each_packed_object(repo, write_oid, &cmd,
> > +	ctx.cmd = &cmd;
> > +	ctx.algop = repo->hash_algo;
> > +	for_each_packed_object(repo, write_oid, &ctx,
> >  			       FOR_EACH_OBJECT_PROMISOR_ONLY);
>
> As this one is essentially new code, and we have all of the info
> available right at the start of the problem. Do we maybe want to use
> designated initializers?

I considered it, but ultimately decided against it here because I find
it clearer to initialize "ctx" right before it is used to avoid
ambiguity.

Alternatively, you could accomplish this with a compound literal, but
that's (a) still a test balloon and (b) more verbose than necessary.

Thanks,
Taylor
