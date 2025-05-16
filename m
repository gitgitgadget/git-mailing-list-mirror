Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DC4248891
	for <git@vger.kernel.org>; Fri, 16 May 2025 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422375; cv=none; b=qR7daVv2+2gOqBMw3nes8m0ecVqYzybLhOvwUbVgBKjaLVeuMCIuZ+IaMf1zZMC1AZD9zxC14LsGPo9MaWHImfiYoPBJofEXvYlUP3IYRTwtYgbJ/CQZxmiWH/inm1dfVltDLv4sRlh9ygTK+ule1qBt18+d1tX5Sm+lwgtFM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422375; c=relaxed/simple;
	bh=BKAEBKxWknV7M9D9bdwY1/1cbCgip99VcokWla7kub0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxReqcZp5GELdlC1ZvrsEJJCbWYTNhVDJE3h8KCKNNrSQKdC6LzYYFEu74CLwcyAzFhwnZDM513ZdqyIN/8HmqBrvRJ4i9F2KIVUhqQYkzF3iOuVdqqrAA580tHXkuHyIVXzhCyM/PxEnPKOVMagnuCC4XHfARY8uUGpFQiHkYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3bh99u5; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3bh99u5"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47698757053so33355621cf.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 12:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747422372; x=1748027172; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t+S2PgbzWyu8GAaXviOOQ1Mo4+/Qc/Gk2yo+yWVkLRE=;
        b=Z3bh99u5IwEOupzbnQgJa9NY+kt0N40Jm0G//7CtqeATWUS80MIHDWn0NZB9UTpbJe
         mybmUuaarc/DgaCUUOXbEsCC5LDgQSRpa+BKxhehA+b+cvNDJVIDJTmOHrEBH4cSyGvo
         B4EOgp5OJQwhoWAhcilpbZqFpocVZaDHpfTHqjaa4XXK2xzpkf0H7QMVxrDGWA8owkjo
         N+k66wfDMG3FRaiKU9L5LfiVIYRHI2sVMsjh9M7+ZC4BO/MVwF4F1Q7Y8/kdmrDBdnDs
         XA4qakt+0r8v49Q968ieFI421JthmqveLnvB+mhSGnO20TyzYy9Eo99VqDjhLtAn5lE/
         lAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747422372; x=1748027172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+S2PgbzWyu8GAaXviOOQ1Mo4+/Qc/Gk2yo+yWVkLRE=;
        b=Ey8PeYajJdYQVsIRSNY7kzzEw1NohPaddhKt1GfJYPIgBl1RlnXYM0ZhALRuiAaUMu
         O3DOKaC18Cr7a1HNpX+GPEYjfTxAEQ7wpSHLd37pulUjNbwQNvQ+t/1AZ05DRGjhlgO3
         /Sr1+en+uD7R2u8sX0k6rvk2thDSraoqHZu4BK3VyrVtIt3FgGI8EgfGpCxEpDN6E+aT
         EKfwXhLxX3g8+mT7qlotx4ZFHVlVBlfOImqkfuvqxTRB/9bCvLau5ZPxCR+FlLb/n70j
         15h0YzSZxBv4boPJkYWjfOjHZL7tVfCf3DAEbGW5gRXePsZccFXgfLqyTmjk0VWpnErs
         hCNg==
X-Gm-Message-State: AOJu0YznqKNfJOfwqUvCwsc7MuRWVsa8/VErVVPxDdaDtLYYSLQkGfDr
	u9gKSfMgOlpvaRyZvOXh5R0BxenEIO5yBg7zZbG8kpgr7uza3STmgkkizO03Vgfd02Y9s6s9wNs
	5l/I+rXNEkah647bT+CGCjAL2B/YH7bc=
X-Gm-Gg: ASbGncupYPD1O/TzsyfMLhpKSnIq+EkXM0socIuRg2cpQQH2EpciwowNYs+HMVYbBTd
	uhvpJatO77gpxsQ7g67w09xWNRbhPZ51b7iibd3vzjMNy93L7sFRyk8EvZAXsxe1xsXOwbAl1LP
	HcoQCAQsTQ3B/BR2Rj8cOommofUyEgqVs7MjuxuGV6mGqigH29k7QjcGFqBwsY3HCXcvwtCwofo
	QQ=
X-Google-Smtp-Source: AGHT+IHGVWosQBsuchCIdv3vr+0exru878DpFbKunVYqIpzup/7thXCtkTgqVQZCQ2hchBmUaCKyLaTcncDmi48cmvc=
X-Received: by 2002:a05:622a:22a9:b0:476:923a:f1cb with SMTP id
 d75a77b69052e-494ae4600damr77014341cf.41.1747422372120; Fri, 16 May 2025
 12:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
 <20250416061450.25695-5-jayatheerthkulkarni2005@gmail.com> <aCeDZgaNWPbDV0Ra@google.com>
In-Reply-To: <aCeDZgaNWPbDV0Ra@google.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sat, 17 May 2025 00:36:01 +0530
X-Gm-Features: AX0GCFuYrA9xiYCZNkFtSsnZ_NBls43Yj08J87equN57luIpB1xr7elFNQoBFn8
Message-ID: <CA+rGoLfk=m4QzrRnCsweBsL35yiLEUHJagetEL9DD2Pty5FgAQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] cmd_psuh: Prefer repo_config for config lookup
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

So, I've consolidated these patches in only 3 rather than 4,
the UNUSED fix patch was actually delving into 2 patches so I fixed
that in a single one.

Also the commit messages, I gotta admit I was given the same feedback from Junio
But these were actually written before that, Apologies I should've checked once.


> I'd prefer to see this stick to the prior formula of including only
> small chunks of the function, rather than a full function you can copy
> and paste. Because this is a tutorial, and the goal is for learners to
> understand each section of code as they add it, not just for them to
> paste it into their editor and hit run.
>

Yes I've done this. I've just changed git_config to repo_config
without changing the other parts.

> So, I don't think it's necessary for you to add the rest of the function
> here in the process of switching to repo_config from git_config.
>
>
> Generally, I find the changes to update the code snippets
> unobjectionable and don't have a problem with the added prose
> beyond a couple nits. But as I assume you sent this series as a way to
> learn more about the codebase, definitely please revisit your commit
> messages to align their style with the rest of the codebase.
>
> But I think with the stuff I called out taken into account in v2, this
> series is good. Thanks for the effort to update it. I'd also like to
> update github.com/nasamuffin/git/tree/psuh once this series lands, if
> you can point me to a branch of yours with the sample code I can pull
> from :)

Surely, I will write the builtin function with a test case and make
sure it compiles.

> (Or, as we discussed when I sent this doc in the first place, does it
> make sense for a branch with the sample code to be maintained
> only-best-effort on git/git itself?)
>

I think it's fine both ways as long as we link it to the proper place
in the docs.

>  - Emily
>
> >
> >  ----
...

In the new series I tried to keep commit messages as good as I could
without naming every line I edited and just keeping it to why instead of what.

Thank you,

-Jayatheerth
