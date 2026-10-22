Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709313;
	b=OEoDS7KkEdsWJuhU5RP9tqVFperDtCXpbr+Ski+U8o6V900QlVqZdQ9+nss5z/kCaNfw
	 3nNXpDB3ifklVPak+/xy38pDJYO6ZeEwCDYr0xtE/dS3glzjzoXBg2m3Sqtbz6VfKtJbU
	 1BbyTpl2A3khrvOj7SQjaeWQGsFVYMNA9+/zGzd2lmcLFQj6s6v/jwlKe+U1JJUQOT+V7
	 WkpvmfdSvH4btrSZ/gRF0tkM3zvPtEJoT9Isu6M1vFVWkGD4NZJIaohpTzkq+yn5R+c1D
	 mgYPrkRItF8mz76Rb55NgI8kW38cyQUuy0UasecNjibnMtdD7jGU7kcmt5EiQ9RhRTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Xhg10NnmmHA9tGuXj9Go/FyQ+DDB6GKJfKe5MrbwQT0=;
	b=g7kA+6fX+gLOF/MpjItR6hD8K1ScO8LkFeaj8Ida7EvnbgEa/GHlKdHoNmNdyprFGEYy
	 G8/eLTDF0lMvWoGRgT5QZsEGbJzyTSh0U9bx9H1o94m/e9LJYKwWnWEM4+pV3IS0MWHAM
	 AO+tF/6bZFjmiylV6XahuyBUywA99H0UVeXpGSwy9VrxXGBjv4QuU87M+l6O8A4f3z5pU
	 5fpDnCrU9BZx8MH/JwnJHFf+juFHo4c4DP6hPNDXxI3rRN4imtxBxE+qQNA73Yv/sXviT
	 bbsHsBXF9Mp6NYS3H3fwFNuWv9Qo8o8qq1h45YYUBB9elQsHB6YmzJkvOLv9sNBZLRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=FDZDv7RT;
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C70B606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 22:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C70B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=FDZDv7RT
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4b1fcd3b1a9so179602b6e.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 15:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1792709312; x=1793314112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xhg10NnmmHA9tGuXj9Go/FyQ+DDB6GKJfKe5MrbwQT0=;
        b=FDZDv7RTAmjP1qL+MgGt6BACAL6d37Lhf1QNrZpglZLw2bAJnLMtrY76Y1rsd1xG8v
         EZ/f2Iex6hpyeyjy+q7EZ+KeKHTvJnpcN846XaZmk9rNOAlFIkk8VR/QjFv9Q4Xc692G
         0CSlDSdLvo6OU1QPcR5OKe+erjPBB4WyneTQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709312; x=1793314112;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xhg10NnmmHA9tGuXj9Go/FyQ+DDB6GKJfKe5MrbwQT0=;
        b=mtHfWoILvp5RIEbHxr0Ru1re7+y3jDHWkbYk3NictlyqaLrj4qfuVVlrW/lI3dVKha
         9Wsyn1hI6ZCFFnke4gSKAsIvBZU3z+Z1M0sUevdVIzwfD9czkrB8Rccq7jmeBi8eRRN6
         /MZpLCBPTr+FKAAGrUFV8epPjTmvtf00j3YOHV8AFilhR45EAmay0NvdP2iUYK/0uR7h
         vVsUboBfd+1t8K1wATZu0L3PisiwB6zPbGYpaaUflJAWYqG7dQWEU7ARs4pnOvd4OAAb
         4Wr1xNnDRahQCIcnrWwPoR9BqRToab1QnJPnH5aOSfo2jBYEckmRDL1wxYRXtkAiGYU3
         q33w==
X-Gm-Message-State: AFq9FYJ7KNi/7dbVEbZF30FWz30Ml0bgES2vmZ1DFm0VueMRuPi8gkBy
	P2HXvWiSQyhATDqIyKdBsykbtCHXO9T9uphnJLccZBAHmICkpSZNZhfSD4ZxPb1CLZ8=
X-Gm-Gg: AYBFou0RWdfngWHIB7W+O1SsbfvBXxPZ9v/cQEhYO8P2J6z2n5ZyuikVHmW6j6596a2
	h6dAFNXy30k1qxn+9hOzFLGCKE3fLhxNB6zwWtzIF9G5HTzuxh+UkhAzFTZc02S3aMVnc3HQZ92
	WYgXRJGq7ZAdIRx6mOVCN6BgVSAHeNmZyHF2AVXK8yldTZ7Gm4Ni57iKe5cVuTT3XawvGxziYoY
	LUxXzQeLmX7A1oLToTG7UxXoNGxhArLEh99KWVm9TS5OynUWyJghhXpEQ0xI+eXgTR610/aQTMV
	hdqyMBVk4KEfzi3i2XCiZemdHw8qRCxGVRw61v2+32Oe6p4Yi4AYFPWMYqLQvM7pg1tYJ1o4x4/
	nL2xgR5WILtPfY4lTGr/0DGDHBXEzsF/Fvs3YzQc6F3FOaczhvcIsfxvwACrRDtW1pZwQgqb75t
	8Mr969EAPugobqUQsnXHQEXhaIZb1/ydVpBAL/dsD1kJBVVSS8Np7e+CvSaGmztrH0FoJaWgpLX
	jwc94NVubkXb8m7z4ulre3pkIlxDkIa5f32SWoUw63+Xa4ORMwbISidf0Evosuo4DDy/Z6oXVVv
	Ceu+HC2UZzYCvfM5n1MNAU1kaBpYbFeB3+ANh/3zKPBht13dk1DS6PrJoPyX+Iw0EoE+AoPyxdb
	FiSdhrQmMt9bySRs=
X-Received: by 2002:a05:6808:6f82:b0:4d6:90f3:74b1 with SMTP id 5614622812f47-55be82ecb80mr366033b6e.49.1792709311877;
        Thu, 22 Oct 2026 15:48:31 -0700 (PDT)
Received: from com-79390 (vpn-centralus-04.tradc-corp.com. [20.80.83.168])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55be90bf98fsm255156b6e.0.2026.10.22.15.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:48:31 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:48:19 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Derrick Stolee <stolee@gmail.com>, Ted Nyman <tnyman@openai.com>,
	Daniel Reynaud <dreynaud@openai.com>,
	Aaron Friel <friel@openai.com>
Subject: Re: [PATCH v2] negotiator/skipping.c: parse parents before queueing
Message-ID: <atqSs0yzXw0cf3cH@com-79390>
References: <dc3dfa3647c42da9170bf3289f4e8a4a8a55c8e2.1792441003.git.me@ttaylorr.com>
 <9e9ae442333b5e2ccc0905c44c2c3e16c49481a7.1792704069.git.me@ttaylorr.com>
 <xmqqld7pcqku.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqld7pcqku.fsf@gitster.g>

On Thu, Oct 22, 2026 at 03:34:25PM -0700, Junio C Hamano wrote:
> Perhaps rev_list_push() should mark the commit as 'SEEN' only after
> repo_parse_commit() succeeds?

I considered this but ultimately decided against it, since the default
negotiator does:

    static void rev_list_push(struct negotiation_state *ns,
                              struct commit *commit, int mark)
    {
        if (!(commit->object.flags & mark)) {
            commit->object.flags |= mark;

            if (repo_parse_commit(the_repository, commit))
                return;

    /* ... */

There are various callers of rev_list_push() in the default negotiator,
but all include SEEN in the provided 'mark'.

Thanks,
Taylor
