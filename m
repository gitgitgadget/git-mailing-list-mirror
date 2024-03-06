Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735EB1272B9
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731241; cv=none; b=Lgm+UVBc1GXtaV/8kvrvz0CHpAJ91DJNFEOHHyNH98NPyVGjGhxUs6QYpgtj/ldwuGpsPlDgJJ5UkIscx7c6GgvfnYTpkNG1ayHq9goCjR5G6pdgmarzypNkWNGpPhfTD+5QUR6hE1s5shGVXpGFdL9ZDfbObrnT3TlhYhY4Wb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731241; c=relaxed/simple;
	bh=m/Qic8UVInLL3iTUDDGplGggWaTaY6cRh8yD6ohEd00=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OqtOWxg9XI4ipUg5SfhDDKByRxtstiWhiwc4UO8xg9fVSCKnjk8zR96GA+uV/qFcD+RkFu/i9jkK4H9NmXublJkOobvTqr0VGZboPvmamJqxwqt0NqY41idMqxxcHrMhWuRtcpJGmueXzY4onsm4nwdKRGSfWat74wzsNY/J5Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liwR1ytV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liwR1ytV"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e61851dbaeso2350643b3a.2
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 05:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709731239; x=1710336039; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/Qic8UVInLL3iTUDDGplGggWaTaY6cRh8yD6ohEd00=;
        b=liwR1ytVqp+KzpfigYA0jgevdSVujajUi7/Ls2oUw9z9cpzBOV4X7uttmoIlngCisM
         maghFriO7dNyAy7CJ1l7do4QLCMTK0S2KQAVB+PvDtD2kFccGPexTsnzVnd+SoXZBOKN
         OhKxrQ3iANJHGlmSKHkwUsEqXLfvbh+MGkKTTfisVx2drBcJ3GEGb/vVWIKgxqYg3iFR
         A2YB6tC+8VMXmILte5q4Q9LU1zkfXUjABp+Xjod779m99ZKzNtJJfitp64rtqiLgv4Ng
         2jFfZ063TFLRsONgFcNv888yH3ldCGOo1XmayIpNkxw9JXkgKgasPLAk6yQATNewNfTL
         7qpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709731239; x=1710336039;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/Qic8UVInLL3iTUDDGplGggWaTaY6cRh8yD6ohEd00=;
        b=VRY5COMCEPq02GK9Av2L8VBovIQGLo4EgvLtOa65UklOkl9DZ2s/w+Y6mh/JikUamX
         5ABwN1CKcrhYqeB2bzY9LDApg7Mc/VrRe1yJjtwcDZ1+885yLT6iEzl0u3upDhqTxAxO
         kTOXVA9cwI0x4JukufziMu2oet4gBudrnPhVGyCY3JNrA2Q0NXjjWY4YAIzmgwg4YpC8
         RvYJZj+ArrZYBQj+F1aAq1X7r8wybL6CKMlOczvwwkPX+wI0Qy8aQdCr6XeLa/Y9GJgS
         D2UQ0UtmcATD3KnwagLV4kwz7vflon9LcMd8szzMjbHsygHy1aMfyL8v44jR2DnD6cir
         c/Jw==
X-Gm-Message-State: AOJu0YxkKs99uvzM/gTqVtFlGqLpDcnHJjO3zxmcrfUza2VbxSz3wYkL
	hWpkVn1XiiN8b1baScpiW9pQqXnpaxQL+elfWhRlUhHNiyyh/4GJaQYCQKZLEso=
X-Google-Smtp-Source: AGHT+IESomjN9sA32IaZOhQmaZUSu/Q0uqGvM06fa83eUg11f0H3GL70VlBUpdhdsgahWyivo34bxA==
X-Received: by 2002:a05:6a00:2d07:b0:6e5:f773:eb80 with SMTP id fa7-20020a056a002d0700b006e5f773eb80mr13097810pfb.24.1709731239203;
        Wed, 06 Mar 2024 05:20:39 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id lo12-20020a056a003d0c00b006e627d0e97bsm4795624pfb.181.2024.03.06.05.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 05:20:38 -0800 (PST)
Date: Wed, 6 Mar 2024 21:20:36 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Discuss GSoC: Implement consistency checks for refs
Message-ID: <ZehtpMtxPLuYYmgO@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi All,

I am interested in "Implement consistency checks for refs" GSoC idea.
However, implementing a feautre is much harder. So I wanna ask you some
questions to better work on.

As [1] shows, I think the idea is easy to understand. We need to ensure
the consistency of the refs. The current `git-fsck` only checks the
connectivity from ref to the object file. There is a possiblity that ref
itself could be corrupted. And we should avoid it through this project.

I have read some source codes. Based on what I have learned, I know
there are two backends. One is file and another is reftable. I have
no idea about the reftable currently. So at now, I will focus on the
file backend.

I think the principle behind the `git-fsck` is that it will traverse
every object file, read its content and use SHA-1 to hash the content
and compare the value with the stored ref value. So if we want to add
consistency checks for refs. We may need to add a new file to store the
last commit state (not only last commit state, do we need to consider
the stash state). However, from my perspective, it's a bad idea to use a
file to store the refs' states and we cannot use object file to check
whether the ref is corrupted.

So this is my first question, what mechanism should we use to provide
consistency? And to what extend for the consistency. And I think this
mechanism should be general for both text-based and binary-based refs.

And I have a more general qeustion, I think I need understand `fsck.c`
and of couse the reftable format. However, I am confused whether I need
to understand the ref internal. And could you please provide me more
infomration to make this idea more clear.

Thanks,
Jialuo

[1] https://lore.kernel.org/git/ZakIPEytlxHGCB9Y@tanuki/
