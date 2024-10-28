Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951B61E0B62
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158609; cv=none; b=jGMD3m15c+SrmXaa//Wntoe/U75rXr1hdmuEEpXH7jUPNdTMGvirtCFsWoddEf07kyPnr1j6WjYvU5rgIwVPZ0AlQMFMfRB+H1ovZR3vnB0O+b+VulMSgG9Z7B3cjQIkcHXZdVqgdxTMSv9CU30+5KQLfDHT36A7fr0q8INf7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158609; c=relaxed/simple;
	bh=AGInNZ+NhavbNoIgghuXMSaYw5ZhaYOb4jqsSZNtAJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwKcJTh78OPcRSsF2jToEnpyHSFXPz3k3i21QNOl4laAy7w6TALG07ADtAPwXmnOhxKp0p/+6OrLGO765lFRhOLcCjxlrp8563QnDSMWyFvNwy10ab/hfn12LUAG4k60qhuGzjYQ8q969/uud2nBU6QN1h5B5erYJ0J8SHiRNbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vLJW15jy; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vLJW15jy"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e38fc62b9fso42804407b3.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 16:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730158606; x=1730763406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=va9rlzJQ4wVXbcF7uHdhfQO7Wb8K+rhIyJn90HDdBpI=;
        b=vLJW15jyIF5ZgPSKp/oMVVZDW9vAfW8W79ahH/lP9KQJnO48JkpXIH6vFQ1QWlaWCA
         yOmdKPNXdUxtGlgfHltSWVApVReUYirJkyfVlU3Lf8xN390e2CCUhfzzOENd9sWjV8zA
         45rdQKeZxsYdIGnJwBqv1v7175OwIiFNxsCVfhwvSFX9Fdc7SM3+ZU8rsuHIGlPln7cK
         3Czdc59+ZtSOO0BfkB/lC++tQEseXkhd/D0IOjuSJ2CmIcJo1l6cJgEQLTdboAujWZA1
         NBR3pMcTo2uE+Rw8bNT3GvJwtbIW8VpFNmJ7h5MWrClH4GFooFKCRchIeuiZJhqeLIpG
         8shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730158606; x=1730763406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=va9rlzJQ4wVXbcF7uHdhfQO7Wb8K+rhIyJn90HDdBpI=;
        b=CS1fssMvwagXAlL3vsm57DPC5HZpOUkR1yAKlHPxqibXpo+ia8LPYOkC/jnHG1McHx
         gdJsh3F6oYVj3TrrlR5FHIgih59RWnAxVHV0MqO4dURa5v6uI5+n/hcCZavhvApAY9Rr
         yuIh5ycHqqquHxpl7/AfBxnu+mPL9QtNoL+NTUkPQDIdZcygw1Loyb7HqdRSm+22Prro
         33A+qtaL9I11eChRWqnK4bMDV1lAoDqpn8yB3n2M/u9vMfE7iGiOOzyCMJ924/O47bot
         UkgsDB8NZpfExQ9ETx2V5x1AFn5erYLbuA84DUnxiq4qzm/sEmyL//iKpweiT0CMVefd
         o4oA==
X-Gm-Message-State: AOJu0Yys72Kl99wpJxfpQ2LGpUxkA7z4w2smaWaXzJcf6nu98EGHVmDi
	gRREwWaDKkcwT7nBwYKQzuYbEmig8JGMuj5zJEjvSwkaE2UWezjo+G+BzkuGDyc=
X-Google-Smtp-Source: AGHT+IG+Xnzb/7WjDcR5WsCJSjKXOfnrXo9ho/4aDDo5D84ZBUe40QKWVFOOeZLPO6x62yALQ/cC0A==
X-Received: by 2002:a05:690c:dd4:b0:6ea:258f:a4c4 with SMTP id 00721157ae682-6ea258fe620mr9190837b3.0.1730158606421;
        Mon, 28 Oct 2024 16:36:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c95c4asm16522077b3.105.2024.10.28.16.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 16:36:45 -0700 (PDT)
Date: Mon, 28 Oct 2024 19:36:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	shejialuo <shejialuo@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 2/2] worktree: add `relativeWorktrees` extension
Message-ID: <ZyAgC1dRXIiLX9Vn@nand.local>
References: <20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me>
 <20241025-wt_relative_options-v1-2-c3005df76bf9@pm.me>
 <Zx7YxLPItxvFJK62@nand.local>
 <D571HWYAD4MM.28JAS7D0Y6OI3@pm.me>
 <Zx/FAoj2jcISsv0X@nand.local>
 <D57O5LHGRN1M.WHYPYUEOUOFM@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D57O5LHGRN1M.WHYPYUEOUOFM@pm.me>

On Mon, Oct 28, 2024 at 07:00:11PM +0000, Caleb White wrote:
> > But that's OK, and we can figure out a path forward here. I am just
> > trying to say that this highlights the importance of following the WC
> > reports regularly to catch cases where the maintainer missed some
> > important piece of information.
>
> My apologies, this was my first patch submission to Git and I was not
> exactly the process by which topics progressed from `seen` to `next` to
> `master`. I will be sure to follow the reports more closely in the future.

It's not a problem, and I am glad that you have found an interest in
contributing to the Git project. We'll figure this one out :-).

> >> Adding the extension was the direction suggested by Junio in the
> >> previous round. Git did not account for the possibility of the linking
> >> files containing relative paths, so there's really no way to make this
> >> change without breaking compatibility with older versions of Git. Git
> >> had to be taught how to handle files that could contain either absolute
> >> or relative paths.
> >
> > Yep, that makes sense. My preference here would be to make the new
> > behavior opt *in*, rather than opt-out, so that:
> >
> >   - Users who do not experience problems with writing worktrees that
> >     have absolute paths can continue to do so without any changes.
> >
> >   - Users who use worktrees *and* do not write relative paths can
> >     upgrade between successive versions without requiring a new
> >     repository extension that would break older Git versions.
> >
> >   - That we only add that extension to the repository's configuration if
> >     and when the user has opted into the new behavior.
> >
> > Reading this new series, I *think* that is the behavior that you settled
> > on, which seems quite reasonable to me. Can you confirm that I'm reading
> > this all correctly? Assuming so, I think that we are in a reasonable
> > position[^1] to review this series instead of having to back out the new
> > behavior.
>
> Yes this is correct. The new behavior is opt-in and the extension is
> only added to the repository configuration if the user creates
> a worktree with relative paths.

That is great. I'm glad that we're on the same page here, and that my
understanding matches reality.

> > Thanks for bearing with me here, I am quite embarrassed to have missed
> > Junio's mail that I mentioned earlier, but I appreciate your patience
> > while we sort this out together.
>
> No worries! I appreciate your feedback and I'm glad we're able to
> sort this out.

Not a problem, and again, I very much appreciate your patience and
willingness to work on this.

Thanks,
Taylor
