Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06D27FD56
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219598; cv=none; b=tKhXp9hnBvSM41Af6KGjKUnrL8GfKVhvdb3NIvaZ+UR3dOsFkv09Hpzgpj569ZAcJQGsEb9Ai5gUzK47i510wv4X999I6UxQqWHtceBHj4x+gGGemOargU5P5pFbPGXEGXmA6sPsr4TvMuj4xTGPwLTMnYABdGfWoIaGV1bk+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219598; c=relaxed/simple;
	bh=s42BU47wluQ2BeMhtjIsjTnYWYoqFvKmDJFxRAKl/hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XI8GfKyl5q22Kz3Gn66MvPdUuPwoklsZQONkNT3lL+WwmAYKLY/ygT1FrrJb3Fr+mL7B80goRSNHKDBDteTRmMOQxabKro/Tnab7dih7Kwib3ZW9TqxZ/3v2boi15IyfcYwzd0WiDNHE5X8YxqCdQYHrg5oEvNCV9ktADBZeAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gj0xrnvf; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj0xrnvf"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-41b8e837427so1678983b6e.3
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 14:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753219595; x=1753824395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cgbYeD7CeUB5WrLzjPSQJJFjd4dj8hAS3Qz2oQZVAoo=;
        b=gj0xrnvfQpc5zGAT9HgYkY62eauavXOUzY/QtpmLLHVlvJXbdWN4tacuxS63ecx8+V
         e6yyJ/ox04CpnPipfSw+OKgXohSFWNWaftxoQAlNRpjHUTbTh4LX6wGNmqDdfH5Ea6oa
         M8qUnmSLQNaRIYjm1LKn1DxNnsrpDr9sd/fnTx2FhPDQVndFHt93kjdmHafO+nkeroSc
         tBbv8CQMSCXgB2SeiQLpXvgla1iH/EW3j8YJ4t2H7CJonIxQ0g/xRfkq4PwZfaYHz3n5
         yiMmD13N9rmg1z0KseScewEVu3Ut3recmpoGkFXVIPA3Ma9RerbzVeItLdNv1CUrwxaa
         6rdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219595; x=1753824395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgbYeD7CeUB5WrLzjPSQJJFjd4dj8hAS3Qz2oQZVAoo=;
        b=XRa/chSKzIHYO+Qc7Be73ddTw4Yf9QXpYpCZPDD2ND9SZbpC7Qb9JW3hFT6/wgVRW6
         zDU74BlaKIjdm6dQJ2b+TeHHqo4MVgD6Mv32O8Y26Buj6X9ruyu53ynHt44lYKc0gOnF
         df7t2n3+bYMpZPzsJZBQ7puzInl9iCvbR7G9gcB5I85VhXJSbFLHyb2nTp7Oi3exhAIK
         yzlltmu/ZACxcARWVfZNvR4dW/nm59DwtbF7icglC4A5RUwm7Cb0n1dVtNRgeLdFQJa2
         PpRZPaQjXNESbJINnlaNQlp3GLdaKvWB62mdDaHDvDFvsrnV32p3yblNagN6fVV3gs11
         cuMg==
X-Gm-Message-State: AOJu0Yy2IV8gQPq0Ew9ek2PLPOHJipTguuFwhNCCn3/egt3iLufeuUSc
	7ab7iTHHJpZF5JwHMR363+H2cs01XGabLCdXm6xL0BrUKQnH8K65NyblFLj0eA==
X-Gm-Gg: ASbGncuP0aFEriAK1Fvjb9k9GNA0wGY5rCy4Ypz88ZfU9v3YoioxxkeFhITuRkh5tA+
	Li3d3fvE176X5e7tt3vCpNPF4lqIk2vQKR86OK5JLZfS2rBn4w7p/j0oFprj7A49bxe80YQtS+P
	uhet4JbMhBSL3ENikIvQMHYB0TRLa10OB97wBoV5vm0kkz1JAcI+JOmo7+gvHPTgZz1Du8ezUi9
	sLWN698uR6CZsMYpXN6c4HDWllC3Vx9HN9wvlS69IPqWzv2sd418biyG7+1keJkoyJsjMRLn1n6
	ns46ks76+Sp+dRtNZtHpo2cm1yFQyzyjvN3aE8tcrAGQ0xOJFGHep+hNdlU/L+o0VKKVdEF0uyX
	naO9srszfjCqBjIE=
X-Google-Smtp-Source: AGHT+IHXLcptMASpTTsaZKngF5wbFR1SDPAAXTBS5YquX6M8PFcEW30EvNQLU6bDyHaPI0B8hPgTyw==
X-Received: by 2002:a05:6808:23c9:b0:40c:5b59:6b8d with SMTP id 5614622812f47-426c662c1c7mr799523b6e.26.1753219595157;
        Tue, 22 Jul 2025 14:26:35 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41fd5074209sm3377271b6e.31.2025.07.22.14.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:26:34 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:20:45 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 2/2] builtin: unmark git-switch and git-restore as
 experimental
Message-ID: <i5r2zmrfcdt5huyds42aixvewrql3aipcxrvdbqcuru4yc62ei@4b7jutquqruf>
References: <20250722180818.1043014-1-jltobler@gmail.com>
 <20250722180818.1043014-3-jltobler@gmail.com>
 <xmqqv7nkq6ud.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7nkq6ud.fsf@gitster.g>

On 25/07/22 02:00PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > In 4e43b7ff (Declare both git-switch and git-restore experimental,
> > 2019-04-25), the newly introduced git-switch(1) and git-restore(1)
> > commands were marked as experimental. This was done to provide time to
> > make breaking changes to the interface. It has now been over six years
> > since these commands were implemented and there has not been much change
> > that would warrant these commands remaining experimental.
> 
> Remove "and there has not been ..." and everything after this point,
> and replace it with something like
> 
>     but there hasn't been much change.  In the meantime, these
>     commands being experimental has become an old news.  People have
>     become so grown to rely on how these commands work, it is no
>     longer feasible for us to now make breaking changes to them.
> 
>     Let's mark them no longer experimental.
> 
> or something like that, perhaps.

Will update in the next version.

> 
> > diff --git a/Documentation/git-restore.adoc b/Documentation/git-restore.adoc
> > index 96de9bb5ed7..903e8c4618a 100644
> > --- a/Documentation/git-restore.adoc
> > +++ b/Documentation/git-restore.adoc
> > @@ -28,8 +28,6 @@ otherwise from the index. Use `--source` to restore from a different commit.
> >  See "Reset, restore and revert" in linkgit:git[1] for the differences
> >  between the three commands.
> >  
> > -THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> > -
> >  OPTIONS
> >  -------
> >  `-s <tree>`::
> > diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
> > index 7b24450f841..1d46010292d 100644
> > --- a/Documentation/git-switch.adoc
> > +++ b/Documentation/git-switch.adoc
> > @@ -29,8 +29,6 @@ Switching branches does not require a clean index and working tree
> >  however if the operation leads to loss of local changes, unless told
> >  otherwise with `--discard-changes` or `--merge`.
> >  
> > -THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> > -
> >  OPTIONS
> >  -------
> >  _<branch>_::
> 
> I think these two changes are OK.  I personally do not think [1/2]
> is a great idea.  At least I am not convinced myself not yet.
> 
> And if [1/2] were a good idea, then we probably should apply it, and
> then wait for another 5 years before proceeding to this [2/2] patch.

I'm not sure even five years would be enough ;-)

Thanks,
-Justin
