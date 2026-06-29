Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B69383C80
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757674; cv=pass; b=ZB5f6cHSWfO0mwnksn5b9FvYOn2pco9iZE1Bgmf6SNvt74fsi7ohg4Xv7nncsNtapI75ENz+SaSKs7K8R99Z+YGfTE7sCer8a16evJt6CPyqT2i6yXwKFbLUETkvCVRdWL5feILuubexP8wCtuJEP1M0ODOafmmKHPSWMZfcX7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757674; c=relaxed/simple;
	bh=4iDLw35EkY6WXIiHEEOU4/d0HXGCLjdxsinmoKjcuAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4gD7AQETZKPAemXlC0y7GGPnrhGjIbSpM+GCZBHRxJv7EW2nCM7YrxhCCJ7B+ApCuzHWHSZZCo1J9ctXjju1/2pGOiRb4hWQcpG4z3r3/ZxNM50Q17jhXCfqGQ9hw4JCWI6DuZY2M5jXuQHoN314TJ/dXQsLNMEnZB8ZbGmwdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=iNC0pxAp; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="iNC0pxAp"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-809b19a7f25so34790207b3.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 11:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782757669; cv=none;
        d=google.com; s=arc-20260327;
        b=Utc+1+WxaG/KdYLBety8cyLZjK94SBB+oSkeacAo67/wiOMkJ3lVEYAQlH3TKaty88
         e7nHzKSQlMrLL35iBq7zC9o2OXFoRJHeH98/dUjcScGIW7/DZbBbMQ/bQzMPODleTqCP
         7UJE1vifJdxfSQinCniEvbbIW1EvWLsNjVZ6xCuYS7Wcsfk4nm64DWXkPvX/5Jb/50lm
         yL5drdsopPnVYoGPimdp+vGulI2Fc4J2zMznaerXVUqWUil3FP8dWT8Dmtj8KKS0Aj1H
         Rgw/ClO4ePq38co6gscT+KVqfa33XiXdzpmO30QCXegUrRgxxBi8n2kP/Sw5lknLuw3b
         2VYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CNFSwun57HMBVj9iFLjGWy0bbrTtnywuE8AMbCoV9fs=;
        fh=jQh3IvGRdJwhgGbXpOr2wS2pDP2pON+YQpQ40QZ7sRE=;
        b=lC1ma6g+2reQ3MXt6MxRCA2FYDqehrj2quBVpV9lV6Q7J1HT35bImrasLOiNYFEde8
         ROTKmb+P2afLFG6ixVqndmj42f0F5oyvuTJuw6NJFUBEYBLiM4bVUbpTJF3+NzNPLIrw
         2e+i1UWBAxsUpRcqz/ibr9n35YvLoIVaQETU4bESLIUwXQ0PN7gq7vzxXYdUR3YymIdJ
         bNyYqgjK3uBY2Zdtk4ME2ZAnl+RTcnttRywNVNTrabtPKgOLTIIdxvQ2gFzUvhDDkK3D
         nP8gHCMZTT0gNIjZIOro348NvGjIk9C8AwfNhjP0nZ/OhBIwI99DUnAcjRV992WRZmRu
         /W5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782757669; x=1783362469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CNFSwun57HMBVj9iFLjGWy0bbrTtnywuE8AMbCoV9fs=;
        b=iNC0pxApzZM5hsBG/+2Mbnid08Z4dLmgjFjhie1z5ujpzdtwYUpvtuvhzfV4f9fj+i
         VHUz0lSTVEnN7/m0yVl4dYm0ipgYg7EcmHBAeYwo9mQovPiPv4MBIDfPJvwLxsw8Qewp
         8V+4uEg89PRRaaywCoN/cvg4qlWZeYJmTNK2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757669; x=1783362469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNFSwun57HMBVj9iFLjGWy0bbrTtnywuE8AMbCoV9fs=;
        b=tQfKef27YK9DCwdAU5FMeOwzS4Dayp/ZStLzF3ImVNqmm51MP48npeWHJMuqH9yRry
         L1o/zerWPVQTTNn8ibl0SrnbFYWJu3gPlU1dxcjtOd2FBdzM4uYivEm7nDDlHS+LsViz
         AvufzOdrUh497mKsccc1DH2mRTCdyS77nuZOb6142JmXM9DmQtMnoBmhn/v84H1+oyVX
         qgysZK+eWV8lFMHGq2CPKPrJ5hKACPPJd1SnbHgq4CWoQ5S6lzNwqMr48pkIduNpAFo5
         iF/b5vJEcUB8ugYDx58sLffXW9ir3KnzOW8jAYx+0LwGeUMFqiHRrQ+NgCfz5XriIKsU
         8Ppw==
X-Forwarded-Encrypted: i=1; AHgh+RroCj2oa1F3tCsMC8DomDHIi54VrwKSdOrGH41BsErhLw6IdS/M8AFZ9V51jABRnyf00Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsY6aF7ZLTD3FizyXYSSIMQxRuGgAdKaycjEIPHdC+64HNnV40
	0xa9iIeUHPvGi1X5A7+phaNDqSnRmxCxYHHj8oayjwpR4ZnlRqmwCkZjmHjPeYkScVq8aW0fzAo
	EoDI1A3kEPPGaL90GF3854+l+cIu/9yBsxFNJd40O4w==
X-Gm-Gg: AfdE7cmtangYfabzBERfqnsbXaU/UEq1ANsEt62N9HEb+2xD9neaZzCGObMaNJLdqtB
	LrltPVmrkdq2g6VlneCe9dWXjgaoikuuxOu+0WdX3QMm9KQIJSNbsNtA+62B209zKBxLh4hzOD1
	8VsYqA7CEzEJxYaDBAk6oy/jUF3XdVeXpVbSSmNZKQJHUnA4qw8waIC327ALYYECQfN7KevwPI3
	HxeZocd1exo6zF+QDNV46cfNl4gF2VJZSCO+xZNqY5NSCKw9yvtYyDwHXZAitRNGcowkcPyvg==
X-Received: by 2002:a05:690c:6912:b0:80b:9afd:dbbd with SMTP id
 00721157ae682-810d7fc73cbmr6852667b3.23.1782757669584; Mon, 29 Jun 2026
 11:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2162.git.1782739162.gitgitgadget@gmail.com> <xmqqldbxw81i.fsf@gitster.g>
In-Reply-To: <xmqqldbxw81i.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 29 Jun 2026 20:27:38 +0200
X-Gm-Features: AVVi8CcfULUm70fkRO0tyUc0r6zLaLEwUMxjVH263LUE7Vpme2vouu6dkBH9JPs
Message-ID: <CAL71e4P4GbYYv1LdarAbeodm06q841wj4gdGpn0QYADQjOB5gw@mail.gmail.com>
Subject: Re: [PATCH 0/2] commit-reach: fix !FIND_ALL early exit with v1 commit graph
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jun 2026 at 19:50, Junio C Hamano <gitster@pobox.com> wrote:
>
> Where should this new "gen_ordered" flag go in the world with
> kk/merge-base-exhaustion topic merged in?  Does it also belong
> to the paint_state struct or can it be on-stack independent variable
> to the function?

I don't think kk/merge-base-exhaustion is ready to be merged as-is
and you are right that these two topics would conflict.
I will need to reroll v5 and exactly how/when I do that
depends on what we do here.

I wanted to quickly share this small patch as a bugfix
since the related code is already merged. I think the bug
itself might be a very unlikely edge case but I can't really be
sure.

My preference would be to merge this as-is, and then I can rework
v5 of kk/merge-base-exhaustion on top of it later - it will
add some delay but I don't want to rush it since it's a non-trivial
change.

The other option is to drop this topic if the risk is deemed low
enough, and then I will rework v5 to either apply a similar
gen_ordered flag or eliminate that different ordering entirely -
I see that as a good long-term goal that simplifies the code while
retaining or improving the performance.

I realize the timing is terrible, I wish I had spotted this a week
ago instead of right at the 2.55 finalization period.

Thanks,
Kristofer
