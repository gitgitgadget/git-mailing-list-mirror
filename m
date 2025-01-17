Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567425A62F
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737122374; cv=none; b=ui6o9ZSrdw1CCXO+HvO2cKlTlwbl5NExjBMqbXKjzqg9nzcIp/tCKOuyT1HLe2K3hBNEuIPeu4dbeMU/RaPsvrl2/PQ90aardftwoRgS7zS1k2tf+5bh5LEtVqhrCwscBDX3hcxDML3XFyhxZkyFojlkU4fKU4Vj/e4OFbYCstM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737122374; c=relaxed/simple;
	bh=225pTVF+Uf9mG1J4+fi4ojtOmxEBglXXIPONNEW+Wr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvSuVPa5c1EkjFzbN1UiRR7cPeNraGTUifmjCTtWr1YkQgUEsaf71QZ+B6TI89YRAU4TL+hqATnpNo3FV4Oc66MeGYqZk3g/BTddWBBLJjorBUoi4oOieHKMEthXQ8taJDyui1L9T7u7z4B3vcbPGjrb288GLlggXusRo1ee3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf4nCTjf; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf4nCTjf"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2a383315d96so1152918fac.3
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 05:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737122372; x=1737727172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kwzm+KLpwpNVvw06tuHmup8kZKHqJ3vC4faDa8omzgc=;
        b=Wf4nCTjfWxDYM201oNmH7J3V6PjpHt8+osFhzLG9f2RO3F8do8ddh2bY//COwyTREq
         xOoukOpIhgn8W8ocbr+wQnH/y4ULIVqsHbmD5+ioFhqqAv2M5ZfbsutZeCzWwgOGkm5t
         RlqLjmJk9WXVJLWLgApxstMdUWdAT04wH3qtR0QJGPgXiazRFi1hG/4HldGmJ7/CTemH
         2iS05Kko8cWjaCcFcPeDQ4+dHOgYc1gxP8t4oETnVKO7o1zyJ2T2mVnbXWEPnmGnunaL
         +tAdBt83TlWpilm9FIQ12P+UV8fq03MQCkqyUbjoFuz5VQVXQWIU9qwK3s+YxB8C36Of
         VHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737122372; x=1737727172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kwzm+KLpwpNVvw06tuHmup8kZKHqJ3vC4faDa8omzgc=;
        b=UEKS+juBbkklXbmibeLU1MaR++4ETW8+vErCTKXhh9SnEI8unw6WBcSifFih8u5QTs
         bUsyZvjh3l55Cn7FR556xGX3630HeTjtxh4bLljkfYzSALAeWtREgfVvgrds6PMAd9vA
         8fye2/sQ02J8js4kwXT5JVQoGheX4uTpfrMTVDOHqaylzP6zZesgHITVFEmSRIDQ8BMp
         15zfwnbpUcIIFQbR0nw1UbCC/PIBssPMLPWUkyQuUC5gfUOXYNqXDHm8rDuDX/A0b3gz
         sACj58wLGr4YMGEL5ZIYSKyGnenjN4XoRLPj2IP1tB/9ENvyMjB9XIj0TdRUiMLcR3zb
         WWBQ==
X-Gm-Message-State: AOJu0YxeGlh2ZJ/PEAlOzZ1u0qSd7l8OY2wwY5udNr/PDXd0evXxMSCj
	qWfht8fREs+BZ3rS2ODyG2I3vm4IXuxRcnEHS/NyINzc4ALOBPEd
X-Gm-Gg: ASbGncsybUdcR5Gxu0HvTsKjMePwx5fRHiKm4wCh0yiE20xNy/thWrrQqIfjC29rq4x
	mbxu5tDFiktvWlutmacFAEsiAbohn/AxF4gkjqB0mKdh5Hd+fc5Pck7jUFVF+aVBPQAZWuKuo2E
	UP3LBDA+BvsYn/oUhxFPMAjMukNF8IYrRf14kbJWYliqcNG26TFD1ltKT3UEdw7Sm1mbeGRJwJL
	WDN/0NVlfFj66ufSOT9DVCmLlLopS3F3Uw=
X-Google-Smtp-Source: AGHT+IH+LhcmCSYQU+/h7zw4FKmcuMAmrE5mAXpz9MvwW4dNDnmhQxpLvm+y7BI+/TvX39EX9cttHw==
X-Received: by 2002:a05:6871:62c3:b0:29e:68d5:a12f with SMTP id 586e51a60fabf-2b1c08e2412mr1628453fac.16.1737122372038;
        Fri, 17 Jan 2025 05:59:32 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2b1b8fee684sm1026732fac.41.2025.01.17.05.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 05:59:30 -0800 (PST)
Date: Fri, 17 Jan 2025 22:00:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 03/10] packed-backend: check whether the "packed-refs" is
 regular
Message-ID: <Z4pijwANZWAP2XKH@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qN6C2IpQTdVn_S@ArchLinux>
 <CAOLa=ZQ-cRJeWjP-_6N2v4GS5P7oYVUyb9_tbY26W7MAJfJ6ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ-cRJeWjP-_6N2v4GS5P7oYVUyb9_tbY26W7MAJfJ6ZQ@mail.gmail.com>

On Tue, Jan 07, 2025 at 08:33:56AM -0800, Karthik Nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:

[snip]

> > -static int packed_fsck(struct ref_store *ref_store UNUSED,
> > -		       struct fsck_options *o UNUSED,
> > +static int packed_fsck(struct ref_store *ref_store,
> > +		       struct fsck_options *o,
> >  		       struct worktree *wt)
> >  {
> > +	struct packed_ref_store *refs = packed_downcast(ref_store,
> > +							REF_STORE_READ, "fsck");
> > +	struct stat st;
> > +	int ret = 0;
> >
> >  	if (!is_main_worktree(wt))
> > -		return 0;
> > +		goto cleanup;
> >
> > -	return 0;
> > +	/*
> > +	 * If the packed-refs file doesn't exist, there's nothing to
> > +	 * check.
> > +	 */
> > +	if (lstat(refs->path, &st) < 0)
> > +		goto cleanup;
> 
> Since `lstat` return '-1' for all errors, we should check that the
> `errno == ENOENT`.
> 

I agree here, if the reason is not "errno == ENOENT", we should report
an error to the user.

[snip]

> > --- a/t/t0602-reffiles-fsck.sh
> > +++ b/t/t0602-reffiles-fsck.sh
> > @@ -626,4 +626,24 @@ test_expect_success 'ref content checks should work with worktrees' '
> >  	test_cmp expect err
> >  '
> >
> > +test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	cd repo &&
> 
> This should be in a subshell, so that at the end we can actually remove
> the repo. This seems to be applicable to most of the other tests in this
> file too. Perhaps, we should clean it up as a precursor commit to this
> series?

I have searched the usage of "test_when_finished", and I don't know why
we need to use subshell. Could you please explain this further here.

> 
> > +	test_commit default &&
> > +	git branch branch-1 &&
> > +	git branch branch-2 &&
> > +	git branch branch-3 &&
> > +	git pack-refs --all &&
> > +
> > +	mv .git/packed-refs .git/packed-refs-back &&
> > +	ln -sf packed-refs-bak .git/packed-refs &&
> 
> This should be `ln -sf .git/packed-refs-back .git/packed-refs` no?
> 

No. This should not be `ln -sf .git/packed-refs-back .git/packed-refs`.
This is because it is a relative symlink. And the file
".git/packed-refs-back" and ".git/packed-refs" are in the same
directory. So, from the perspective of ".git/packed-refs", it should be
the "packed-refs-back".

Thanks,
Jialuo
