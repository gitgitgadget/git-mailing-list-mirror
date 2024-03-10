Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E01DFD9
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710064900; cv=none; b=KPvlZYE4cmZxjhsUgZO8i+GC5eUxK3dzy5AZl9yIEgFHK6oXDh8xJE5izGWV2fJd0EPSUkicyEbaNa5us88HMzmo1vrtt8Ye6sL2fA981H6GTO/BbdXtMdi3Gs+yAeN80e7GY2/1HcoZaL6HuWs2A50E9aiPjszpasN1vOLDQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710064900; c=relaxed/simple;
	bh=c6d279So80cYYltKLDpW+JTXdRuOAU5yCyHy2OsnMKs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g0/HcfxkGgb3oDAg7dpzfBHEpW4hjp5kFhcPwRUb4Yf+iA1uPkPHV+nv1xz01QkH4C13NmEoHJlAyAVH7i+juUBlxfaKOObN4kCwFXmJWHmv7y0VVxWbrKxrorW7NjHzFJgZ4DWZsPpVk5/iGFSmMZw84LmlLcY9LNrmOBRI6dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/HOmZD+; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/HOmZD+"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3662e41370fso12841345ab.2
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710064898; x=1710669698; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6d279So80cYYltKLDpW+JTXdRuOAU5yCyHy2OsnMKs=;
        b=Y/HOmZD+WYBDXzXpalEoWn7dsixn96twNqPMUcqyJ7RjSZehnm+xXMlvIdWFKHu3vI
         pJrzgBSoEpFFjD/0Yt0KgCngC+TdfqdN8SAyXwo7VHZh7zaIF0AnfdjGqnxkvCiCNJPD
         xJM2qtiGbc3DlSyXWg0Bs9JEHvfC6A+wmKl7ED+85lbAlTgPqdNi7T4CSCVRjf9UgMu0
         W8h8FxNS9q8RVAPimFnU0ICeaVN3aKvkoeZVtleikghBmnVWcurzymWZ6YV87exWzCtJ
         UIjFNjZvUBRwiclGUN9PT43jRiwFaj03l1vI85SGaIL4mLkj+oQGS7fK9wRYOmfYc/eI
         bN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710064898; x=1710669698;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6d279So80cYYltKLDpW+JTXdRuOAU5yCyHy2OsnMKs=;
        b=RMoNN39Sva/TeAxngTafWvTXddkSz0w8ogwKrPTuS6Ji0uaUS5Ft9MIA4P9THHciqf
         RCHFKNfwI3ePDVoLnAsT1MVsV/WN3yMZl6m9TXJyIPWcQEzOzTTbCn50mzMu8qNVe5fd
         DaXyXUq80MTSykDB1ejRHn7CxSYWXNEIUCVXe6g9Xhsbj/Vk0MPC3rTJnYL5Tnid8vDO
         0aoWcX61udJubj5TQekur1wyYPafUS2BK0gbREkhqOEtck3yDWuHzu8ufpu0vnNGijpH
         sFKlwGBsvE9dEGd2GlScOPzpiksA21Jr6xkN25Wzi47/jOL3Kpz/lZltrcSqCfAEZbfu
         ABvw==
X-Gm-Message-State: AOJu0YwDaZGhrXwLlC9ITycxsmXOaLuISKo0Fn6w+NAmgCR9MQARo7C8
	KlBykHxLWOCEEmFmz28u8829MPH3e8JPKt/eoFqoQ9M98UFuao6OwqKhKulurLU=
X-Google-Smtp-Source: AGHT+IG5F6nQBS0KiHrnnnapi3m05Da7rQP+883viO3NG3JVGGs979QawyNSE1xnIeGYzjkHaiEiTA==
X-Received: by 2002:a6b:f102:0:b0:7c8:57b1:e799 with SMTP id e2-20020a6bf102000000b007c857b1e799mr4068214iog.14.1710064897904;
        Sun, 10 Mar 2024 03:01:37 -0700 (PDT)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id s125-20020a637783000000b005dcbb699abfsm2338333pgc.34.2024.03.10.03.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 03:01:37 -0700 (PDT)
Date: Sun, 10 Mar 2024 18:01:35 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: Discuss GSoC: Implement consistency checks for refs
Message-ID: <Ze2E_xgfwTUzsQ92@ArchLinux>
Reply-To: ZeiBfVyTCHUywliI@tanuki
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thanks for you help. I'm sorry for the delay in resonding to your email
due to my internship.

> I know this is splitting hairs, but git-fsck(1) doesn't give us the
> tools to avoid corruption. It only gives us the tools to detect it after
> the fact.

I DO misundestood the `git-fsck(1)`.

This time, I have read more source codes about `git-fsck` and refs
internal. So I wanna discuss some implementation of the infrastructure
this time.

I am inspired by `refs-internal.h`, this file declares `ref_storage_be`,
and for every backend, it should implement the interfaces like
`ref_store_init_fn`, `ref_init_db_fn` and etc. And in `refs.h`, it
provides the interfaces to other modules.

Based above idea, I think we could just create files in `refs` directory
and we could implement a file called `ref-check.h`, we design the
interfaces for different backends.

After that, we could compose this structure into `ref_storage_be` and we
could call these interfaces in `fsck.c`. If there are some different
interfaces, we could downcast to a specified type to call the specified
functions. (Actually, I have learned a lot how OOP is implemented in C).

> For what it's worth, not all of the checks need to be implemented as
> part of GSoC. At a minimum, it should result in the infra to allow for
> backend-specific checks and a couple of checks for at least one of the
> backends.

I think using the above idea, we could provide an infrastructure to allow
more checks later.

> You will certainly need to learn about ref internals a bit. There are
> some common rules and restrictions that are important in order to figure
> out what we want to check in the first place. Understanding the
> "reftable" format would be great, but you may also get away with only
> implementing generic or "files"-backend specific consistency checks.
> This depends on the scope you are aiming for.

I think I will at least implement the generic part and files-backend
consistency check. I will then read some specs about the reftable and the
source code of it. If there is sufficient time available, I think I
could implement all of them. However, I am currently interning remotely,
the response may slow.
