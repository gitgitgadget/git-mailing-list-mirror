Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D261F2B8D
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241144; cv=none; b=AEwUiJl9YOLFCBBe8rBz2N/YlNQk+apYOIHXpPIoPJmERqR8MXMGYx7Xd6Bz8HiQuWWmifkgY46KkD34ZODFDBpQ8Olx0qshnjz6KMwkvjEi11rAZnpL+JvVmkzqWUDjE4az3+mkRbT2TzdnhDCpgn9k5NlTBzS0rmtnPiCpXkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241144; c=relaxed/simple;
	bh=GT1q4EisbiGMo3JCYoKLWHYvOIbbdpg1lET7H2tXaJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBAsqUiqrGeHTScEyV8x+Ye3sqLSzWpkn5URFVqWkiXkZY5Jd/6Gr1K6GJ1avvy3ZiH7NA4sLPnZ4RRRYzZuub83F0EnsPEs1ByPJNuIcHXliL+z/vX24zO8QKZrsg4oYxwcM+KSdYMbpBhbuWklF35VVFpWk+lifDpiwbWPcag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gu2+UUs3; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu2+UUs3"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so6216897e87.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 01:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241142; x=1776845942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB2C3wE84CfMaDjWN3CPAvtGXgbaDRZaGm6iSSmQ4f4=;
        b=gu2+UUs3M/0yPU7ijbvNXJOTw/y/pxUlpMZ3yVDu4Y81oFp803WpeZnc5RlI3+qIV5
         v5WWXOTBmO0D5J36H5fhCnDG+zn8+nfdBHtcK7j3stjng0hmZXaRMU55vfq5AOehj/UV
         aIGknpoQmxYLs7TnEzFOiPghXFk9j3xOboxY7ZXd2+7NnPxFrdKidAHg0MQs2zfaNtoK
         NfCND9Hr1iLNlIgpG5DrgtPc/GBazr92urepjWDNs4YNePR6EW74l9ZUzO3JJ5BfVrL6
         vY9mNB3NnDCMARpSUWBnvdYaPion0yTW7gKsDjeKHc/ZoQuYZHcc0RiY1rtbchfMgsza
         BsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241142; x=1776845942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wB2C3wE84CfMaDjWN3CPAvtGXgbaDRZaGm6iSSmQ4f4=;
        b=WmrqNZuH20ywwybB/aOP/M7MPLEl1U2m1VDc4fldB3eNDgD25rwn00xQ6ROtVGAWeM
         E4gV5dCWV+sdZzzLcFI2PElaCyRwNvxzGk3BGtBFSjL/OS3+OJ5NzrXD+FUOe08kuDTG
         8PF9mh/R/4qOWQygDvk0Dl/f9iTuQhVeFXNo5WeZxUQFNcGl58/nHSeoUHw9sF4zBbys
         7ZGAy1CRXtTJJ68lvBjpxsWKNDOsSn1g+lmivAswTgYI3d8cIrwCxCqrASyCXghyy0pw
         xcw/sA36H46L+XDDi0CCSZUQilSwx+Ye2p1Ts3RaZ41CozuAC+WT2xGBWrSnALZgadFe
         pSew==
X-Forwarded-Encrypted: i=1; AFNElJ/rNLi5Tzj1dAX8QAU+lfbbKmuIgh1nWLlEMsNvglWGM/+zMwbR3CiE7xF5VaxQsULsH1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYWlIrpq/e8VCAP92BxG/YGwU8pDvuZvdItl4kFyAr2EF575H6
	aaWurjrolgx8WYpyOUDyamxLDQur9Y4j69rVZiEComKj7aN2SVvMKORY
X-Gm-Gg: AeBDiesH5i4CDqse/AyX9nPPtZJfF+o9VaPfVAutILuNG0TWzgMOekDIthzPm16AHo3
	G2BodePbYd5A40aDPfFxwjTIllYqdyBWocHt1N5+zReGDhXetqXvjndvo3Ga4bWmOuWBBm9wGu0
	mvChSmZyNMeiuyXrSx0erlyEW1DC1igyap8E5Yqf0MjATHU/LIe8PkcIFyFdqaHaY0iKlEdO/ng
	iAc8qoqxdE6A7Zhn5XOPRpNjTjxihXfv/fYFV7otqxx95KMsR722RG+b/4mmNrgofnN5hWRa4PG
	ftJocH7OXukaUW360N4+THCtmrOxU304GOCVByjmF02cpAw38WS7N4Rqlgn5jdr5E/FfuHt/IaI
	CM1KE3LvWCCLcD9z2yl1e3aIMIPYOA2CEBAsI2XUu876vF4qu5D5K1ppUeYbgsxsNChVgf6otTP
	cf0Xc0OszC4RNUSI3eXAeChlHwjZZen7nbgz/jtCCe4CzrfnZMJv2PTNg01yPja1nHfJWj7eEv9
	gk+W1w0k6Er0+LEbGNmlvEduuU6cA4R
X-Received: by 2002:a05:6512:3b0c:b0:5a3:ff48:f7db with SMTP id 2adb3069b0e04-5a3ff48fa55mr2998377e87.34.1776241141487;
        Wed, 15 Apr 2026 01:19:01 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a40a2f9d2asm283750e87.57.2026.04.15.01.19.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Apr 2026 01:19:00 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	peff@peff.net,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Wed, 15 Apr 2026 10:19:00 +0200
Message-ID: <20260415081900.86956-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.77.g97a5d87c81
In-Reply-To: <20260414201327.51745-1-haraldnordgren@gmail.com>
References: <20260414201327.51745-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > > +                     strbuf_addf(&autostash_msg,
> > > +                                 "autostash while switching to '%s'",
> > > +                                 new_branch_info->name);
> > > +                     create_autostash_ref_with_msg_silent(the_repository,
> > > +                                                "CHECKOUT_AUTOSTASH_HEAD",
> > 
> > It's a shame we have to create a ref here. MERGE_AUTOSTASH exists so
> > that "git merge --continue" can apply the stash once the user has
> > resolved any merge conflicts. We don't have that problem here because
> > there is no user interaction and we could just hold onto the stash oid
> > in a variable.
> 
> I don't know how to actually do that. Maybe better to do later?

A gave this a try, but it becomes a very big change. Or maybe I'm missing
some key knowledge here.

> > > +                                                autostash_msg.buf);
> > > +                     created_autostash = 1;
> > > +                     ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
> > > +             }
> > >               if (ret) {
> > 
> > I'm confused by this - if we stash then don't we expect the call to
> > unpack_trees() in merge_working_tree() to succeed and therefore return
> > 0? If opts->merge is false then we should not be trying to apply the
> > stash when merge_working_tree() fails.
> 
> Same here, I'm not sure how to get this to work. Maybe better to do later?

I think I succeeded with this one.


Harald
