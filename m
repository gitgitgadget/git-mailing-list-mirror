Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5411F33ADAE
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769763602; cv=none; b=qV5lAFN6hUEalCyq+By1U9Xl25BayqyY5gK6hDDxrSV8ymdFn2hSIvnorkcjkUKaNtHQUYP8SWZXm0S+O5vNFlXPLYYqZfVtx7Tufl0HoKRocZIiNG92MMvV3FuGv5MxLaeKPr6HTyHIv2sklmQw2F4KS2Qg3T6+ByRy58y/uPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769763602; c=relaxed/simple;
	bh=BRuQqkyDktTrdLyGexmxpvRX5/VgmXKpPB18NgyrQ/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWE1YSAhAJYdaA+l6Rfi4UWxAXM6NGiqdyKqQdwygBY3SmxlDxxILzqv6l0wZxNyu5/lKKuihIKdWFsroFAUc2KEXDvSI+7B4eEjup8amFg3T3NTYn7cRSqNCk3N/NOBWOadgBJi9/F7Q52eNqQi1h/gJKulOJlDJq2VnPdTuZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpFCOTBg; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpFCOTBg"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8230c839409so1643509b3a.3
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 01:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769763600; x=1770368400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rS5qJI73S0qLs+AxWQfK9vtgY0xKNXIaFgsKIT6on0o=;
        b=EpFCOTBgZFMvfSsYYqQg1UhHGL8tBxnYzDtr9T12oAatM6YzgQkOyd4lvti/SRuPEg
         lkdoq54mfCz80dXqiMu15VwbFDl3EHSCGk17sBcqQvH3Y8MebSrMMQblUDZR6xyQ2Eh4
         f4lEOhR5c7wLIX8wM+7Aef7ZxCTsSH50gYD6IkFjFBA64c/XLv1ZBRTQcnRlRx1TUPZV
         ocoHrKAJ1VzAmMdsIlYN89tmm8A+NBhILFX6kiXd0k5zWMY/6YUMMEnfFX05mfax4ZAQ
         YqOghcWGuwaNpgPSfdTL9Eg33kQCqIflMeI8uHtMovzPAzI8rpex02isbRXPe3g+RrvA
         IXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769763600; x=1770368400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rS5qJI73S0qLs+AxWQfK9vtgY0xKNXIaFgsKIT6on0o=;
        b=WUveb7tekS8qXbBvuKeO2Wa9W680jP8x5TVtC+rz6OyubrAHaXzJPulwT4QwFqqLiG
         f+/SlRjT5REpWtK8iMvP6kbKnuwQiNlbgn/VASbktJmGK1GMblYN274PstzqXCXmholT
         gThc55QamfFemLU5d5XZk4vKQg0ANozD1zLdcIp7fR2SoVG7jVRIHRyJpqxoQGlSKyCB
         DUGX+yDIiNuSFoEsQsI8kC+jqSzbR/cpUyujfyV/KlDEuQw4UWKugtx0WLIxFcywDoQZ
         wtJgWUQkdCKhqd7UY87uY/jGkrPhpunHGgRgCqWTwi9bY9s7fMlG3i7p+i7RPc3eWj7a
         G+nw==
X-Gm-Message-State: AOJu0YwM7v9m193gCYGHzs+usKzkxgJWb4IBOoaLofsI0ZHN6KaXPTyA
	IRJ3bcOQqDo7qgr/U6mWsfCQYUhvjcJWx3L2BQmdMpPXakASHEz+49ok641s6g==
X-Gm-Gg: AZuq6aIuUpW4zW3BB3/DbQ2T0lUBBn0ntl4mfxC8SXJXBtrVzouNcB7dn9OClH5YhFl
	I8/RsIy3rBSPJecD9nAtn//yZ6qPnDg58YXGComHSqfVtbwyunFcHgcZKudRSnVx6gycF5978/B
	M66bwF8ovDIx+XIhxolLtj1EPVq0D53N4A+fjiAsnI69517d9uKDig+6Sy8iEWnneU14fT7PPc+
	yWBxLja/RLlOef0zhf5hRcksCXtppCEdu+ZVmQbZfWyzas6iGmZn82STailBDGoDssBLY8/1JyB
	UTl8xh/njUCsf2/P9TvqWOEBjErkZrWwK74rsI7NkS+y5vprJ0DWttf5w7inKzgNK4gR1QSKx7o
	suDBf1NfCLFlvr0JipHtSMHxYB1Y1i5INainl9fUDavqPUR8vCaAn+c2NSXHBTXsuYG0emH+eN4
	oZHZYA4s8G0yrweG1pz0PO8dVHkZjgIUSnvmdlqq55eVUdsw==
X-Received: by 2002:a05:6a00:12e5:b0:823:6f5:4139 with SMTP id d2e1a72fcca58-823ab655632mr1978098b3a.7.1769763600264;
        Fri, 30 Jan 2026 01:00:00 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:3c46:c24b:c90e:ca5d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b65068sm8845806b3a.27.2026.01.30.00.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 00:59:59 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im
Subject: Re: [PATCH] show-index: warn when falling back to SHA-1 outside a repository
Date: Fri, 30 Jan 2026 14:29:22 +0530
Message-ID: <20260130085949.253788-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq5x8k9g4b.fsf@gitster.g>
References: <xmqq5x8k9g4b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> > When 'git show-index' is run outside of a
> > repository and no hashing algorithm is
> > specified via --object-format, it silently
> > falls back to SHA-1, relying on the
> > historical default.
> >
> > This works for existing SHA-1 based
> > index files, but the behavior can be ambiguous
> > and confusing when the input index file uses a
> > different hash algorithm, such as SHA-256.
> >
> > Add a warning when this fallback happens
> > to make the assumption explicit and to
> > guide users toward using --object-format
> > when needed.
> 
> Line wrapping at 50 columns certainly makes the lines narrower than
> 80 column limit, but let's not go to the extreme.  We recommend that
> the lines are still less than 80-columns after being quoted a few
> times in e-mail exchange (as you can see, I lost 2 columns by
> quoting once in the above), which means that around ~70 columns is
> the practical fill-column.

Understood. I Will make sure to keep message wrapping around ~70 columns.

> > Additionally, wrap user-facing die() messages
> > with _() so they can be translated via gettext.
> 
> It is somewhat distracting that such "while at it" changes dominate
> this ~100-line patch, whose "primary change" is a mere three lines
> we can see here: 
> 
> > -	if (!the_hash_algo)
> > +	if (!the_hash_algo) {
> > +		warning(_("assuming SHA-1; use --object-format to override"));
> >		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
> > +	}
> 
> 
> Can we push the "while at it" message changes to a separate patch, a
> preparatory clean-up, on top of which another primary patch adds the
> above warning?  Alternatively, have the primary patch that adds the
> above warning and does nothing else, followed by a post clean-up patch
> to tweak the existing error messages?

Yes, agreed. I’ll split the changes into separate patches again, as in
the original RFC series, and send a v2.

Best,
Shreyansh
