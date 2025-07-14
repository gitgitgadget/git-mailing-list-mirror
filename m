Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6182263F3C
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511594; cv=none; b=kI8U8YpQ0ElNRw3lCNx7IBSEWcMSab3yO50+KOyiXfYqK+YYPM1BOkQfYYBlO+R1cjZshAaFO/yzSElRg9sqH52Pd89XtkQskFtBTRWHwYNfhbPwrS2DlsUWDx/To2p2Ea3mBENyIYg8sn6lw57jiZOmlAyzQXVQfTiy9mkXkpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511594; c=relaxed/simple;
	bh=lh9TnS91W59OWkPFM8B+8FFHt6fKNe4/2SfablaxhlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT0E1I/H9f1Y/9Ojdb9my+pM+l/uTb0ackJqHvmOtyl8jXLXEtTFK4JKgJCvAk2SrrMnRszU5dgJzEFCxG3ZOq0dwVYpIdqTGSSpe9B/zGtqunTmv1SvQfRlufIXlZqqhPlJoSg88dBI/hH+NUialXfwfhpD/Zblo8B7CzDpN5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlsMXpLg; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlsMXpLg"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313a188174fso4554190a91.1
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 09:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752511592; x=1753116392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RxdxWs+xNfXqRVFwo6LNL8nZNy19ruIk+6c8eQ1yBUg=;
        b=ZlsMXpLgf5tOeLMCQNiM+tOYuQz4XA0uC4P1nL5PCwDwZoEX8J93C1LPijEEBH2Bq/
         KEt4o77c4nw8wVCALC8svzXEVKFbB2LsRGyPl5iOtKKqWQiCiOAmwjjtc0ldkyJsFxSw
         sAfT69oeJyaaoHcwOpOxQidJFbZEbk+hW2JiuKy3397VcxcXbnIqhS3fNWIWrlCBGGWo
         k3T2XrOTnAhasGUqIRP1dI6CqGCAk+xswKI9DM7bOpRQ3OjSLa3fdHfMHU9j4n7yKMAJ
         Tpd4SVCy4+XpEimVwYOG8jJpmzLMxxcNAbrt0x8a3lQPwbIQ35exKU2AIq62WWUevJEj
         H1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511592; x=1753116392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxdxWs+xNfXqRVFwo6LNL8nZNy19ruIk+6c8eQ1yBUg=;
        b=OMoc7e8EnbMTbEFmVm1MLGKnHG8YsZUDiD3FRPnHShISRbcjQqJXtapUSEkGIzetxL
         Vectz7tFuMUcHvsXlOwL7gRX0Fw8k6N23eixRCu5iMj1COftXeCx/OgtbT22AYPD3cDv
         GKsengkITis6KkIj2lHv6oNguSjkNWtWPSFSV1tRmmKKr5u38FJQUBJCDJ4IQgwPJYst
         YXHlWm2dwvbbJORSZhlg7qI3DQAn2oe35PczZPkWNdQL6RXV+AtOVv5GISqLH+YfG542
         fXTkfHehgt1Lh551GFP3DGty8/5KI5zfv8bWXdplcnjix2WjEOvoPn97vSnBK/iF17Vu
         TNlA==
X-Forwarded-Encrypted: i=1; AJvYcCUKxLH2p3u9rGORRIdtuQYznhNqFR3Fm0fee6tSVUeOnshd/33fw2CCVNJtWTsOFqEk1UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoPo9F0R75oZh8l9H8g+o8RgUX1bootUB57MDl5xknmETjyhmi
	dtpML5iZUQRPsBmssVrReTjQuFQEg6dFaU+7KP2EeH41M/GzE/hX9XD6Q3kpQA==
X-Gm-Gg: ASbGncuxh4RurFZtAie0QzfZxotngnqi7pAT6usF+SRf+YsGSiCqwGuwSkn72IgwgIV
	VOFtEw8azfkTCCi6ZBK59d+HajDNaqRzmB2anm2HUf3bBLcGFUY4iZFrgDB1r8MM1fLzaObsDZW
	raEMszXtohxX62jFW0z+I5MYNVu2TiTzbaGHGbS4fALNvhpgkXQdV1uCSGI6c7uUJCGtnKIP9yI
	fVxq+ItmH9flwFXCOsPMancmws5bPxwTCwNvCFPD+EdzBi7CGbzoQ1rbgFuYTOf0ofkAEaMIeaD
	RIl21gNbTXVY+/ZCw9DAKIockbYybNQllq7tJTAgRtm/alA8XtCRruC4wfp7vHXYS6LD5MNPAGC
	P6yPaouo0fAr/tuSkFXmF82ZmMd/jORC61b8IFn02I0MuWO1ZXKIK0kxuEw==
X-Google-Smtp-Source: AGHT+IHLsoAbOuRoi04tIzNGkQJD5OoyhPiBZPOL2PGAbSZovnpf5bM03UjmqvrV4QirGqGxznAx2A==
X-Received: by 2002:a17:90b:184b:b0:311:ab20:1591 with SMTP id 98e67ed59e1d1-31c8f8a770bmr385449a91.15.1752511591904;
        Mon, 14 Jul 2025 09:46:31 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:584:1c8e:a09a:776d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42afc7esm95876305ad.79.2025.07.14.09.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 09:46:31 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:46:29 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH] meson: disable PCRE2 dependency by default
Message-ID: <ymreouejava2acp3xpvrviffd3bd7cu3wwmi3fadzykkaaubim@25oyqvcfhrda>
References: <20250712172615.11364-1-carenas@gmail.com>
 <aHKgu3Ew3Pk0PL2v@fruit.crustytoothpaste.net>
 <CAPUEsphoFaS7CnxXs_PsMCtCrB7ByE+y+SxQGaxoovjAdH7UFQ@mail.gmail.com>
 <xmqqikjuvlxc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikjuvlxc.fsf@gitster.g>

On Mon, Jul 14, 2025 at 08:20:31AM -0800, Junio C Hamano wrote:
> Carlo Arenas <carenas@gmail.com> writes:
> 
> >> For most
> >> builds on Linux, the system libpcre2 is the right one and users will
> >> expect to find PCRE support by default.
> >
> > Agree with you on that, and indeed I think every packager
> > of git (except for NonStop) does enable it at packaging time.
> >
> > Maybe this is an argument to enable it by default?, one thing
> > that I wonder though, is if we should first isolate the code on
> > its own and link it only with `git grep`.
> 
> If we decide that PCRE is good enough to do BRE and ERE emulation in
> compatible enough way more performantly everywhere, it certainly is
> an option that wrap our calls to platform native regcomp/regexec
> that we use for our use of BRE/ERE and internally use PCRE for them.
> 
> Before that happens, "struct grep_pat" that encapsulates the
> distinction between using BRE/ERE and PCRE and compile_regexp() that
> compiles an end-user supplied regular expression string into members
> of "struct grep_pat" so that it can be used to match against in-core
> buffer we have, would need to be exposed outside the "grep.[ch]"
> machinery, and direct uses of regcomp() and regexec() in the rest of
> the codebase has to be rewritten to work with "struct grep_pat".
> 
> And after that happens, teaching "git log --grep=<foo>" and "git
> blame -L'/<foo>/,/<bar>/'" an equivalent to "git grep -P" option
> that tells the command that the pattern given is PCRE would come
> almost for free.
> 
> Is that the kind of isolation you are referring to?

Thah describes perfectly the probably unrealistic plan I mentioned
in the other part of my response that is not quoted above.

This part was more of a: let's assume that we enable PCRE2 by default
in the Makefile as well, what is the impact to the libification
efforts now that there is a chance that libgit will be linked (probably
statically if using meson) with libpcre2?

Sinvce the plan you mentioned above is still dreamware, wouldn't it be
better to move all the pcre2 functions out of grep.c, export them back
to it through a semi private header and convert `git-grep` into a
standalone binary that might link with pcre2 as needed?

Carlo
