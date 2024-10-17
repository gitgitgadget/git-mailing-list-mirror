Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4731DA112
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170365; cv=none; b=WP6mHa6RnVCUpjvUf3BFHzlYN73qH9yLaRnrJYugHsoqojyBqb0LHJP19nbDHB3GAD0ln2Uaj3WmRGfyvvUYFy4Po1hkLveBlDLliCtQcSQ3xiCqYArguWSmHVeWB/ti2s+LZqJuJzDt/aGYnU9fcDP5w6vmF3zB7KHMVYShE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170365; c=relaxed/simple;
	bh=CGHXSsTILZXfSwkw0Goq2T2D8CX+Y9AGwMbkNaCqbZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ql5Ywr68t2W/BwwelcR40swVADhNbhEDiKgVVqiCpmk+u+ETtsXob8+XueeiKk7zRCnqHWWowOVIzPpp7dUcdV/HlSTGfr+gAq4oZJN68na9iRPi0HmQS4VDSSUmLTSxqpFFkbfPuwn0txFBsdsAFEMvyrLMZqAd3jGVq0cupUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJwwWvU5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJwwWvU5"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cceb8d8b4so5713215ad.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 06:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729170364; x=1729775164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEL1NHQ3jk0W8nwijM1R1mlyQ9JTZlbz3c/4YdFiSfo=;
        b=CJwwWvU5pCyGD/Ws1LlH2fDB01YEJTpOTCg6lR29rVOWisY/LxPLF5BMEiE//r256i
         llCvACLS/kPpgm7+Qljqt6JpWCtTGAx3OsXjZXWdc0CrMbHZ6cL5PhLR+DU7ejjx4ue4
         YcQkaahgaXC7O80NMSEzO/JEOtVuqUBySqH0SKzPTn0YQqbn8meYwiM+SptliC7e8Ony
         NSCcoE4Zg6JLyXkKF+qz6WfDZAyYV+BUJiHDwxzrJAq5wSBVViz3YtRUaWS3AwKeR4mh
         4aOKtadcRp34tBKLFLKwcdIm3Qf/F1L0sqeyh49Zx0RkkZnXlGB9KeytJ/OhdRMmUlK5
         ogNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729170364; x=1729775164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEL1NHQ3jk0W8nwijM1R1mlyQ9JTZlbz3c/4YdFiSfo=;
        b=W9tRSuuQ4xVSd8ZJ3kGoOD5RJAVvCmJKvhRGJFPTwN8P1OJ2E9v2qMN15OHpPiX7vg
         sNC+d6kkFNwBYrODUA/BA3uf2ixO2CXapbx6RB0GS5E0qxJkHAN6SShQCAvcicdDY/F5
         8QidA6FF/ZTe2yE/4OLyQQZkCK+FnmYrIWEYQ6VLBFwAoyNac228Mfl2jZQ61jsm2QRd
         7CZGDertb/Q+YjPuOB/W1rET/pMPjcw/q+PF+zsfcQljL0m6mFGALPmtrnQU3TiYwTn5
         ErBH87it+1E0MnEEQFLXfgVBc3JYvnMIxDLS1i/PS9fOsJQMbroBGYQD/ddRdW0EB2hC
         cABQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsoSUpc3puaW2oAxcUTr8viRVLXDaQsr2h+dsMepAIHJJDwWWi1IE/46v/b9DqwNKQPqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUafx3TLW1nF3+/0CKtERq33oHwjy0002907cP9w8bsYofIJP
	dtLpki138E9LK6WWSr3Flj8Ct13vUV/+Kax48rrN5vNI5U7E094m
X-Google-Smtp-Source: AGHT+IFveBJRvilbVhiPPEHtMhiDGQda8Ggm/guCAsU77rnrS9QL/csTTFlKLFAjKfTRCZQkslcUZQ==
X-Received: by 2002:a17:902:d50a:b0:20b:a41f:6e4d with SMTP id d9443c01a7336-20d47923adamr53957625ad.15.1729170363481;
        Thu, 17 Oct 2024 06:06:03 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804b706sm43756595ad.217.2024.10.17.06.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:06:02 -0700 (PDT)
Date: Thu, 17 Oct 2024 21:06:02 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] repository: move git_*_encoding configs to repo scope
Message-ID: <ZxELulPlLQIs0sh0@ArchLinux>
References: <20241015144935.4059-1-five231003@gmail.com>
 <20241015144935.4059-2-five231003@gmail.com>
 <Zw6SsUyZ0oA0XqMK@ArchLinux>
 <Zw9Z_xcHKcjKVUB4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw9Z_xcHKcjKVUB4@pks.im>

On Wed, Oct 16, 2024 at 08:15:37AM +0200, Patrick Steinhardt wrote:
> On Wed, Oct 16, 2024 at 12:05:05AM +0800, shejialuo wrote:
> > There are many builtins will execute this config setups by calling
> > "config.c::git_default_config" and then "git_default_i18n_config". If we
> > need to use "repo" pointer, we may need to wrap this pointer. (This is
> > not the problem and it is not hard).
> > 
> > But what if the "repo" pointer is NULL? We still need to set the value
> > of these environment variables. Because when using "git-mailinfo(1)"
> > outside of the repo, we still need to set "git_commit_encoding"
> > according to the user's config.
> > 
> > So, from this perspective, I don't think it's a good idea to put these
> > two configs into "struct repository". Because we can use these two
> > configs outside of the repo, if we put them into "struct repository", it
> > is strange.
> > 
> > However, I either don't know which way we would apply. So, I cannot give
> > accurate answer here.
> > 
> > ---
> > 
> > Patrick, I wanna ask you a question here. What's your envision here in
> > above situation. As you can see, if we put some configs into "struct
> > repository" and we run the builtins outside of the repo where we need to
> > set up configs, the "repo" is NULL. And we will get into trouble.
> > 
> > My idea is that if a config could be used outside of the repo, then we
> > should not put it into "struct repository".
> 
> I guess it would be nice to have a set of convenice functions in our
> config code that know to handle the case where the passed-in repository
> is `NULL`. If so, they'd only parse the global- and system-level config.
> If it is set, it would parse all three of them.
> 
> I also kind of agree that it should likely not be put into the `struct
> repository` in that case. I think where exactly to put things will
> always depend on the current usecase. I bet that in most cases, we
> should be able to get away with not storing the value anywhere global at
> all, which would be the best solution in my opinion:
> 
>   - It can either be stored on the stack if we don't have to pass it
>     around everywhere.
> 
>   - It can be passed around in a specific structure if we pass the value
>     within in a certain subsystem, only.
> 
>   - Or we can parse it on an as-needed basis if it happens deep down in
>     the calling stack when it's used essentially everwhere.
> 
> Now there will be situations where we used to store things globally as a
> caching mechanism, and not caching it may have performance impacts. But
> I guess that most cases do not fall into this category.
> 

Thanks for the direction. I will dive into code to think about how we
could do this. Actually, I have tried to refactor "git-apply(1)" to
remove "the_repository". And I found it hard to remove dependency
"environment.c". It's a long journey.

> Patrick

Thanks,
Jialuo
