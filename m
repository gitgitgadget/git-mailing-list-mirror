Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE783D092E
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096180; cv=none; b=V7195pRIpQTh28mgKfW5cPvQOS8SzKNwo2g40Hy0Af5NKutRtWk6naeEhkHlzQOuKPtiZboqU543anYm1F1Izc7KfL3cVoC4WhnThhRWxseTWcMX0/IWbk3ilhdjPKyVuMaP0nH6z6875BiZzQ7vAyvZPJB6DxjZ0sfoxM61pN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096180; c=relaxed/simple;
	bh=9B4ueq7rXtJw1FwYGtMNYdpLY2WpH7BVjAX0kPABOs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUQuQlzEJxi6mHgp8NZmV5eP3VbBDEnp8Wl1i/Y7xrNmqs4XRSAZ261Is+5wLrHpUE5P6svRuTznG+uDgy9j4YK1TXeXhmzSH9eSpgxW3TunaVK9xLZI5oUjFn3a3pI2/318Ew8LZxeFAyKe+qVM/MZGAZ5IgwCNdfgOzrUNu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbk6tVkE; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbk6tVkE"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39f927721f2so22655701fa.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 02:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786096177; x=1786700977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MyM/2iIPwdU9MpfSYRzp+EeYVqBP9gu4PZe/6jCJd3I=;
        b=kbk6tVkE3kK+o8FOT9jWeub1S2Hhy/Nqqa7TUVLxq7Y6N7RTZGU29A5nqZQaIiqCHP
         +uNJ0g/f4t2B+/jQEYBOMLjpTl5yIsUQqqzLk0Y07He7wLIXYNguYU3Mw2OrMDXA6jl3
         GlkmOnFoIGx/NbROaEVqOWj6cDdOV8RinWCs43FORk3xcUg0qkHgBMYCcqlerk1VVpy5
         ryPO9LGUsav0gYYjt85X/rDKREfMoZQvr2GExPjrLzq4DBAk8nI1ogAtlF5D/wHf0K/j
         oCKoGMbn5O9BmJVXuxA2WKY7hOlUc/FvJAD5alWFVuqZ4+7bNZji2xCgvbK3ncfEP4qm
         VTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786096177; x=1786700977;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MyM/2iIPwdU9MpfSYRzp+EeYVqBP9gu4PZe/6jCJd3I=;
        b=skQPzY9CGSktJclHN7lhVEwMCBAHkZoGC7TXllAtuqp08qDshXYIZ1BYvLju4qP4tT
         63hySahqWapGj0VaJ1lNNVWQWq+ZCJtTh9l7DXj4GB8XzeTbbJZG3/XdoCNquPP16GBZ
         vyWv7go/N0/Fa1cqv0AGzbWg/29Mjvvr11qSGvTXjFfGGYan3dRo0TlW4GMIuEMdGuNE
         RwzIMUXp3hRQHoY+J3XhOFb+JlwqNFpw2EkbhjH9eyvpxWa2CPJWfzgc4DL7L+na6k9c
         OZDqhbF3g2bcBtdE+x5sQsi83CFzS1xTnwdHTeUU8PbhvliD9P5GsJTvz9Dpb1JGCjV7
         CeBA==
X-Forwarded-Encrypted: i=1; AHgh+RpdMydJ97Y0nFJhj3QlraKbs4dwliLldEqjlVM7l50lfpwfgVu/h1paqLU08EvhGwz193A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLh/z56SDebI94OiigjSiwO4OefVyJQunr0A7J3QRTZeAOetja
	AKBYD46QLtPjdkBbcLD8d3sM8kbxH4jSIJKva53g0HxhFYbCCQuwMyxgQAc5tg==
X-Gm-Gg: AR+sD1280gF+TWs7reoIlgBA6I5hgE/pwsnD08FNs9441+2q7yC9n0Ryt+geGM6kgJN
	1NufNfnEWLR5Ot7F9QWL4Tz/3+QjNCMGbYg9Blvw95q63C3Rlqom0w8GFintDnAPo6e/gQJdhUO
	wEig0INLG74AnVOortRhQ/0SPV137MuZ9j0KxX9hdtv31uKg4+OvHFapU3gWCK2FauPHPhpiZ4S
	/J/60FL3+GHwVJFqxAL72nUGjl0Ggs8eTGR27M5qcOAJxcy5JcRREwvpa2n0MrK42l90C56mB3I
	FP6IirdNwprxt9YWZicP42/z4pv+aINFQqclhS0fTCyOz1rX6/XdbrKGwLlCqCsgGacxC3aoHjm
	KkHOfVJrmWPrqmGFJFA6zdfoLh8xS7vqQotYs2ot4YiMIWDLF/MU6/qVbXpb2gOfOXQID7cVZv7
	26ckdnVS+QZwgCBXIufVuWU92bIFGzsGMQZ5W4xzKmVWhJ15aJnlTADODL4CCNPgaj6kXeGZKrN
	5vqvZ1z/d7fAI8SiFHcTJRMBy36eFSK1LS4Ns3FHlHFUUL8Y8Y0Iu7prPAwFQggKeAcPxe48dvP
	3Wo3vZdfqz9MMcg=
X-Received: by 2002:a05:651c:1993:b0:39f:bc94:eba4 with SMTP id 38308e7fff4ca-39fbc94ec51mr24402431fa.26.1786096176728;
        Fri, 07 Aug 2026 02:49:36 -0700 (PDT)
Received: from localhost ([2001:2043:be0a:d700:bd32:e7e3:cfbd:5b51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39fddd51581sm2272701fa.22.2026.08.07.02.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:49:36 -0700 (PDT)
Date: Fri, 7 Aug 2026 11:49:35 +0200
From: erik88 <erik88@gmail.com>
To: Elijah Newren <newren@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>, 
	Patrick Steinhardt <ps@pks.im>
Subject: Re: git-replay/git-history lose notes
Message-ID: <anWpt6rzws0yYdFH@vader>
References: <CALnO6CAN1=dgRsYjABfa3CJkGnvb139EcrzS9EnX43i3szOgtQ@mail.gmail.com>
 <CABPp-BHbWKr5tv9ApH8ZagJkY39XZgQbLoFrmQJfU71z1y6_xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHbWKr5tv9ApH8ZagJkY39XZgQbLoFrmQJfU71z1y6_xw@mail.gmail.com>

On 06/08/26 23:53, Elijah Newren wrote:
> git filter-repo (and implicitly fast-export/fast-import) too, though
> that one's a slightly bigger can of worms.  (Trying to treat notes as
> the underlying commits they are represented as is a really poor way to
> export and import them; any filtering on the underlying commits will
> cause the notes that attach to them to just be lost since they will
> instead attach to the original commit.)

There are some workarounds for filter-repo, IIRC they work _okay_.

https://github.com/newren/git-filter-repo/issues/22#issuecomment-1834041470
