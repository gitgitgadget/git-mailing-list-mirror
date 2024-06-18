Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11BD299
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726229; cv=none; b=Zoj7+PxC6PodvUl4XiVW5KgQczhuJUWiqkJvn9v1Om2Eln8V3bkEpMc9f/zK+aM3M5IrkhPhJ2ImWcLUR/0OcM1v3eLaZsQroRuUUkttRMJCRyucQldn3UCGftUjMzdrjE6vQXdmLGaShlbRiOII4cB6esDCTgLqTJCwvRLqJ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726229; c=relaxed/simple;
	bh=bonc78afVYF9Haf7yV9VznFG2BJYvquXhclfsdH4vxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtgJWkrSScbpPGEhCsMrhiAsw+E5yO7lV1tjMNbL3VOxObKy6/1McTbMJrCY/0GYezZow4TWXDjQBZD1urLGSFRgDyIzYKAQX+kFV3lDaNBV/7/q2BtR1P60MGMl4YXppMOdK55WemMB9asl92hqqg8MU0d8yfehHSreSqjlDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8h6fmvP; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8h6fmvP"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-709423bc2e5so1851297a12.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718726227; x=1719331027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4PfYRvMqQ2T1I6kU+lZWJlVfgEf/c/ecM6JkLkaKwRc=;
        b=a8h6fmvPsgLUyzI69zJl3Q6fKcQGt48u5CTY/Bc6r+Klum8t+M8ls9A36NHmMutWlK
         1QxE+0Uqo8ZmuJMpOhtFPgCeAZ0s6DiorOFlhxnSJnTfria3xpK3sj/DZ4nGcO92HlCg
         ufyBh/sbcNqpprDRvtNv73KakEKgAWcVE9g50kMl+pt6UMvKqP3dB0acQpmbRF7lD18e
         EOS4IiJnCzyV2QsvoIOkqpanLErzEojppKu2IOnX6WGdmp8yMlqGWgbIY9o4JiQqf2+5
         czal2F5+4s4jDacwGbhxn53/ZzDRriUEJUmeS8uKEIxdyVPqJCx6h3KokLsj2gO/XLFo
         vM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718726227; x=1719331027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PfYRvMqQ2T1I6kU+lZWJlVfgEf/c/ecM6JkLkaKwRc=;
        b=jPLOVuY3Ocj9+6MerAZ7THGXgQPGo3BSdWfHfO+D+dx7VMw250NK4QNr8bxjg7AsnE
         DZgkJErQ28FMP3DVffYoSHplOR5VplkLkQEkQKMtHzEU/X7/LJSJL8jMUGwDBoqA/6Ev
         hvcubnZJDO3MjEjdPTtT2/VkpVyp6ftQUDZlN45BUhtmTFA++No5Uh/Ndt5mg5UK9MDB
         DgsaGIMG9CNzSlL8IzlBGnRV/lHx9pmhgOOYxAItfj1k5A98Dc7DvMmu7fo2LEaXSvif
         nAPwCaSnXyzMkyZydORWUqZjlXlTn5AmDRuXPyRaGgaeiqSqvSF/8vjkQnkYRlFvnawP
         2KyQ==
X-Gm-Message-State: AOJu0YyUf/jcNrFZ/IpZMp9LJ1nbyeBOuqrwmE2ZQu3iPDFrVhaivmaG
	FGUpfei26jNU9qX9BOVYIfinttyVb/r6vj7WqzzEN0rQJaMGBv2j+s6lc4hNMevSWfsy513U9vd
	XdwtlFTwYh1VZiS+52BE+6tGwHeY=
X-Google-Smtp-Source: AGHT+IEixk3TDEtBzzOfLcy+qYU/ErX9n4UvKJp5z37fBfcO8ctJ16oWvdLZWkQTfk5s0wr/Zai07xlZDegTVWH6ClY=
X-Received: by 2002:a17:90a:db17:b0:2c4:e3af:a026 with SMTP id
 98e67ed59e1d1-2c7b5d9193dmr91093a91.47.1718726227341; Tue, 18 Jun 2024
 08:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZnFByMI1lWUDSxLd@ArchLinux> <xmqq8qz22r6r.fsf@gitster.g>
In-Reply-To: <xmqq8qz22r6r.fsf@gitster.g>
From: jialuo she <shejialuo@gmail.com>
Date: Tue, 18 Jun 2024 23:56:54 +0800
Message-ID: <CAH-kW5e079dkg99C3rroj+vh6C2L6roqVFYWg_Ykno3WVpHOhg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3 0/7] ref consistency check infra setup
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
>
> shejialuo <shejialuo@gmail.com> writes:
>
> > This is the third version. Mainly focuses on the following problems:
> >
> > 1. Add "escape" check for symrefs and symbolic links.
> > 2. Resolve the reviews.
> > 3. Fix some errors in version 2.
> >
> > shejialuo (7):
> >   fsck: add refs check interfaces to interface with fsck error levels
> >   refs: set up ref consistency check infrastructure
> >   builtin/refs: add verify subcommand
> >   builtin/fsck: add `git-refs verify` child process
> >   files-backend: add unified interface for refs scanning
> >   fsck: add ref name check for files backend
> >   fsck: add ref content check for files backend
>
> What commit is this series based on?  It does not seem to apply
> cleanly on top of the same base as I queued an earlier iteration of
> this series (f931bfb2 (Merge branch 'ps/ref-storage-migration' into
> sj/ref-fsck, 2024-06-13)), or the current tip of 'master' that
> already merges that prerequisite topic.  The early 6 applies on top
> of 'master' fine, but the last one.  I wiggled the last one in (the
> patch to the fsck-msgids.txt documentation expects stale entries
> that were already removed in 2.45.2), but if you are basing your
> patches on an unusual commit, please describe it clearly here in the
> cover letter so that others can locate (or recreate as needed) it.

Well, I simply does "git checkout -b js-refs-fsck-v3" for the current branch
"js-refs-fsck". And I use "git rebase" to change the code in this branch.
So the base commit should be unchanged. However, maybe Patrick
has changed the code and I forgot to update upstream.

And I have set up the base using the following commands:

  $ git remote add junio https://github.com/gister/git.git
  $ git fetch junio
  $ git branch js-refs-fsck junio/ps/ref-storage-migration

I am sorry for the confusion. Next version, I will merge the master code
and send the patch. I am sorry to make you so inconvenient.
