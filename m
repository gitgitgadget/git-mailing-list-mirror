Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F99BA50
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727017065; cv=none; b=IxG3KQb7P28WdQIvAtEX6zZYz47ZBv2iF0rHt/fSrZfhkvAbGf2ul71Kohc51JxhAuqfcISzD70ojH2OBsCPmif1aIS7LzAxWxygKfH8msw3M0gk4q+dqWoN6USZFO94D6Va7bCXnz82zC7hJQ+PaURjPHiCA7/bJ+2N/cV/NgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727017065; c=relaxed/simple;
	bh=W3/eg98AnOAqlRyzHSnbNcscldO9o1H8cKjmzH5Fs/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI/9m7ao/LPvFo7ZI4XO/pxwYS9zxbZNHok0JILzl9dU0VynQ2bqrk2/N2Y+Yn/jrZhZUdja8EWxBbhwLv0lEpwPNBgvZkLRwWth6OHFf9mVUHQ2b1x/tiW4IK59D82Jnj+Cyw8Amhe4SLdyhJHOyGqceH4rh7Ko7K9szX6Mj/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bckAOnhp; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bckAOnhp"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2db928dbd53so2869300a91.2
        for <git@vger.kernel.org>; Sun, 22 Sep 2024 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727017064; x=1727621864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx0c0fDwY3HQple902D/Z0hY6Ltu1dQ++Icb08ia1FQ=;
        b=bckAOnhp3Y/xEsOMvdLhvUIHvgleTe2a4530PdIUR8A2775nPhd9mW4S8bPg4URpAP
         eGp7G/QtFH25hVCkQd35uGzysjRGDmUgKUdlVSgLqAmox6828hTMPG2xco5BATFfqbLc
         DTjMgMjDwabLx42G8zR3B268OtbrtWxq6aSkWy57vjAoYV0TIdy7W5MvN8c9BIg4Tty3
         zy3WwBlEKeKutbM3/kCBy4sN7BMemo/UjXVh3xtyevvMpReX5oYdkWfq5WsEfCbxcmPh
         A7u7oIRUNaDbsGzjPQvZlk3NRacv89B06scCnC6A9fppIsX8KQMWnzYhTHc8lCapvM+T
         SeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727017064; x=1727621864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wx0c0fDwY3HQple902D/Z0hY6Ltu1dQ++Icb08ia1FQ=;
        b=pNVspsyJtOPXLminNuOaZwd5DTUPquOom22Oh4Zic2MmFyl3j7WhNWtxULj8IbQ7vE
         EMGyubhabdL2hqO6r7baP/GXYYNBUAVZ9bNfMCp7hZdJjiHdu/rLLcbZMP301w1IAayV
         1JKwRg9i60qK0GBeMuuKJY+ds4EinUOz2fcnGYAZRwXYKdqAz484ppXMVD1LYdunEOTf
         98NiCt3vtiVxNz8/1SqgADNTn4ma2n+o+xprM1GfT2Jm31ItsbwlfjMcCWcE28dKPQ4W
         CI8rwMN5ZxVr6mLE4CfMJPal0QxDkSeKRgyUifJ85XyTtFdhU3jtIaOwyBgh9c1ZgquF
         PoYA==
X-Gm-Message-State: AOJu0Yz992JS2O4+Dyuk2n1QJ+0F1sbS46moKBFxT9rpXX292g1zo2l6
	tEE1wj3KJ8ZjSUucdMxS3gS9hpW/bAmrLrxxK5iQ4apPUS+zu11+
X-Google-Smtp-Source: AGHT+IFdgWO3kO3R7dEA0raZwf35gqwnYyVDFdwapMCLvgaS4Vlo/6cStFtpPdV0RLWKXL5jKN3WFw==
X-Received: by 2002:a17:90a:c2c7:b0:2d8:8fe9:b015 with SMTP id 98e67ed59e1d1-2dd7f79e457mr11756021a91.39.1727017063560;
        Sun, 22 Sep 2024 07:57:43 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef3ede0sm7661729a91.46.2024.09.22.07.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 07:57:42 -0700 (PDT)
Date: Sun, 22 Sep 2024 22:58:55 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 2/5] ref: port git-fsck(1) regular refs check for
 files backend
Message-ID: <ZvAwr6uj2WRD7L7y@ArchLinux>
References: <ZuRzCyjQFilGhj8j@ArchLinux>
 <ZuRzwKTFd65RL4HC@ArchLinux>
 <xmqqh6acdbz2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh6acdbz2.fsf@gitster.g>

On Wed, Sep 18, 2024 at 11:59:45AM -0700, Junio C Hamano wrote:

[snip]

> The above reads as if you are, in preparation to "port" the checks
> we have in "fsck" to elsewhere (presumably to "refs verify"), you
> are removing the checks that _will_ become redundant from "fsck".
> 
> But that does not seem to be what is happening.  Let me try to
> paraphrase, in order to check my understanding of what you wanted to
> say:
> 
>     "git-fsck(1) has some consistency checks for regular refs.  As
>     we want to align the checks "git refs verify" performs with
>     them (and eventually call the unified code that checks refs from
>     both), port the logic "git fsck" has to "git refs verify".
> 

Thanks, I have re-read my words, I did not explain this thing well.

> > +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
> > +		ret = error_errno(_("unable to read ref '%s/%s'"),
> > +				  refs_check_dir, iter->relative_path);
> 
> Is there a reason why we cannot to use report.path aka refname.buf,
> and instead we have to recompute the same path again?
> 

Thanks for pointing out this, because this part I wrote a long time ago
and I think it's unrelated to the fsck part. So, I forgot to change.

> Should this error be propagated back to the caller, not just to the
> end-user, by a call to fsck_report_ref(), like you do for a ref file
> that has questionable contents?  If ref iteration (like for-each-ref)
> claims there is this ref, and you cannot read its value when you try
> to use it, it is just as bad as having a loose ref file that has
> unusable contents, isn't it?
> 

I agree. The initial motivation for this design is that I think this is
OS-specific issue (It may be read successfully in the next time). So, I
don't put it into the fsck part. But It make senses that we should
report this.

> It is a separate matter if such a failure mode deserves its own
> error code (FSCK_MSG_UNREADABLE_REF) or can be rolled into the same
> FSCK_MSG_BAD_REF_CONTENT.  I can see arguments for both sides and
> offhand have no strong preference either way.
> 

We could just use "FSCK_MSG_BAD_REF_CONTENT" and add a message "cannot
open this file". I guess this should be enough.

