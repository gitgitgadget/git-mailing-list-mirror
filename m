Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB2A3B6370
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791442177; cv=pass; b=eQgaoz8rKY2wfVS25gdBJj1/RHIUiV5gHMhzb/d6I70zEYBf/fcvOiHCnGLoN0xZKc7lY76pyBUKgod5QOv3KwALPgK2CyEUnJRHvpHpcxrXBBV8mT8ns/qwhRO7SzKS0ddjK3vNuPEIJHrNI1FvVhgwjdipYR+la1YMErc7p0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791442177; c=relaxed/simple;
	bh=PYVmjWhJ12B9KmwzoeAFRQVaJN0L6LUmk1ON3Sm6pEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljhbHD1Mm5W+JPFVLfOLLqtBLm1+2nNxMWJFuphrxVd9C13A3550cjFGV9YtIwxdewMPTW7mbRdTZnm4gj1cdaEcwqSAFmVqbmRFDBE31CjFuQ0P5/spyUhRncIF7/ZWq4v44pzPCTyYq5WHzq06FEGg0AOiMfTjqYiHsnqsqoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Sbt4odWu; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Sbt4odWu"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66c7e3a2332so3581035d50.2
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 23:49:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791442174; cv=none;
        d=google.com; s=arc-20260327;
        b=q+DYxFjqscpJPdxcbvoYOgC7PGh0/ZR5CRAVzkzJcNCogmhs/HisC9aBkID1GkjvHl
         9H6dc+IljKmWue+hoCX0mpzGvC6hrY6hupJY9Z9m+FVUEB9smO6fdtM7LfUzsftd32G6
         F1ZRbCv4kOp5C+61YjTWMcwLOKDwsXd2YMuHA8S1Kc76bUn6HxRxtasVRqYSV8fUHtmI
         3sTZWxC0rG/mVrpcHCEZwpmP8cvFa9C4b2kLBJzDKd73tZZmzXUpAX1/hnl6S1b6ioeR
         4IfrBRBNaJXfz9AvptDnt5pXU5MCQNrCkjBSqqCIcs4PFGntxU57jTo/37OHm11j12E9
         Okkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u9EXrkXZvF6OqGR+EETryFCVVsphc6B5Y2pV8Odx0dw=;
        fh=Ium5CzqRihCZkK+NOFFq+cZ7fPGq0Ktc6nmy+oUHMhk=;
        b=p8uB0LuO6fXZdJz8xDThPTEqJ/5J6YTpwtJXJgqlr2ymU+5PJwzc92zpKR+3ZiGob2
         ICEQ1cAjW+zuXtJERBPa2BHr0tzZM9SguKieMaVaT9AEywJb+Hqvpk8clmyaqhodrWK7
         QH6GYcqh+6rMLZqLrCis87YxhYsHPyjxe23XlOXzlxxiOoj5vIcV/kY5uy+HzHksR/ge
         4BVC2fHd3mZUt9qpXq7QoxIYFoANvJA8sPfzHTSwavCJk5C0YeLIwOKZM4XpfNbxEYa/
         5PQVISU1GQthv9+CYWlRbvzKXs3m42ccBp9jKdtqQ2lZYu2BymcAWjjxPdRZvE8EPNj/
         BGlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1791442174; x=1792046974; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9EXrkXZvF6OqGR+EETryFCVVsphc6B5Y2pV8Odx0dw=;
        b=Sbt4odWuI4ekDu/YkugUTP5+JubcVwtIqxEKXaqcEeyqTyeP9ifZ+O7Ss9DxJ8C4VW
         pXGy7+eekOCKTdnIY2lTsN8RByFQZUeF4zk1rR3gSHcXgAqEAOY1vKZoeDCr/1IJ25w3
         UDGRGMn7bMuBkAdVKRi33OPazi92lsv7ZZjV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791442174; x=1792046974;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u9EXrkXZvF6OqGR+EETryFCVVsphc6B5Y2pV8Odx0dw=;
        b=iyTIgTdlQnlargOfLx8CEUBB5/12ogE/zRYhe+4uFZNSQ9yABirzEqD8BgiTujWQKm
         IjB4m9Q0BAZ/6WmS4K4UWEqzE/qZedGPiMykOJvw/WM3Ai62GzQC4qBnnwgp9YchNek9
         Krg39Nixb7LA20/9GLE6S4AVBoSlu87E0PvlxAXfogizKPGHmlbDSlkeAZmEGedtVswS
         cI5GNDDEWiL766/bfrRWV8NYLrjuBdKCUuomyjEyWTLcQjM0gf4QECu5u3XOqDWOJdCz
         wTqUF+AngUDCB0blpwW5tvX2jDFnEMJTnVZ2I0IE1CpLQ3crnJaeNAN99uaqn1x8EccD
         6viw==
X-Forwarded-Encrypted: i=1; AKwUvBxDB2AxjSIs/Zir+3zPzICKenxBzvq6fRTidblDgvLBqP/vznQp933CdOZww3NOFtW471Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJijN+ZPzjYYY58h/Gd7ClZN5hBONfyJSDC8qxocNw9RJI73sqI
	el7Bo2AGH/65w5+OxlzecG+nD8o8CckAUXjp1t3oIqcYoe372YmL5SfvTlL/KVHR587Ba9IyBTy
	RurAfl2sTpO5OZjEtUFZ43y8Xh0iVu+2tLlyHy2agSg==
X-Gm-Gg: AYBFou1q1ElkoxhEwkBFX6SgJy1mtdviGCUNjzIDMwNBnzwlbNvYvti1hWJ1HuduCzL
	yr2RM8QiR78RSCM2h0ZTRG5tK2ckUrv/RHrsh/k19esvORdfSbQK4JuDg03lc3706buBXuU7YOp
	urcv8SRELFG6cZvTgunuDA2j+VzHuYKvBbjDchSf8vqFj7albiM2uH5mv7NJZbUwnxwf7E7cHTQ
	ZDRYousbX0PNU7mJxIOdFSYTIOOuc5B6XuMLh9JCx06TQWjD87yqk5STIcKQJp6yFS5k7LU/5Bz
	nxWRR3d5MDwKqY018CkNG55aLhqkW8d/nkznjmAf5HrC5FtV9pyxdCM=
X-Received: by 2002:a05:690e:812:10b0:675:6fd3:cf51 with SMTP id
 956f58d0204a3-6790a370acamr1495654d50.30.1791442174493; Wed, 07 Oct 2026
 23:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
 <pull.2239.v3.git.1791382977.gitgitgadget@gmail.com> <01da9857bcd847bec4eb85d8f57ea1cdc40b1758.1791382977.git.gitgitgadget@gmail.com>
 <ascxqBn0RsXnLWSp@pks.im>
In-Reply-To: <ascxqBn0RsXnLWSp@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Thu, 8 Oct 2026 08:49:22 +0200
X-Gm-Features: AclHuK8GdjKZiD0viaRg2peyU3-x4pPFG5NkUIp9h1wlv79moa9oJtmuAp-MCfw
Message-ID: <CAL71e4Mb1FoQn3VqsujAEX_4ziUyrpSuTH+7NkgP9T=QBQQeEw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fetch: write commit-graph using updated refs only
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Oct 2026 at 08:01, Patrick Steinhardt <ps@pks.im> wrote:
>
> Everything from here...
>
> > After fetch_one() returns, call prepare_commit_graph() (which is
> > made non-static by this commit) to determine the graph-write mode:
> >
> >  - If no commit-graph exists yet, fall back to the full reachable
> >    scan so the first graph creation covers all refs.
> >
> >  - If a commit-graph exists and the fetch updated at least one ref,
> >    write incrementally using only the new refs as seeds.
> >
> >  - If a commit-graph exists but the fetch is a no-op, skip the
> >    commit-graph write entirely.
> >
> >  - For the multi-remote path (fetch --all), where child processes
> >    do the actual fetching, fall back to the full reachable scan.
> >
> > Full commit-graph coverage of all refs remains the responsibility
> > of "git maintenance", "git gc" and "git commit-graph write".
> > Regular Git operations may trigger "git maintenance run --auto",
> > which periodically rebuilds the commit-graph from all reachable
> > refs.
>
> ... to here is still overly verbose, especially the last paragraph. But
> I haven't been complaining about that in the last round, and the rest
> reads significantly better now. So this is not worth another reroll, if
> you ask me.
>
> Other than that I'm happy with this series now, thanks!

I thought the last paragraph was useful for motivating the change,
but I agree it could be written more compactly.

Will change it if I need to reroll anyway, but will keep it as-is
otherwise.

Thanks for reviewing this!
Kristofer
