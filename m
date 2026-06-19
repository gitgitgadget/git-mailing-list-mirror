Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB9322B87
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781900798; cv=pass; b=lvCpi4KXGs1hGzFhwbKM6Iuu2T4Z1ddA47N3qbs3NOlmLZuQM1Q5wyPzrR6KqongfA4Tu5sQDlPyMxKXZANrWewQIWCqJ2aBtIY80n4+U01QOMvmXgDTOd5osDe3Sujnrlhewt7NrYS37Q9OhPg+ggwkkT5Em/4hrEfLHOss8mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781900798; c=relaxed/simple;
	bh=sM0VcNMZ1YwfKZkzv/qhJQSQetYTivBXlvxNCz8pCz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJ8gd8plMM1PLQOaSzCuTQ2VL6/M/OUHtmPnPI8IqMx+u6t7bPyvisB8VeIX/oSAIPdOul2+drUZhEbF/Isy69p8q6MEXQBpwk24b8CjUJJcbINKwPCV+cXLjYvAaeITgMID9iaBoEXp1agKasgiBv6eIa3H6HMT+o1amNwIwTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT+ELHZM; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT+ELHZM"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-697564cb3f0so1254776a12.2
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 13:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781900795; cv=none;
        d=google.com; s=arc-20240605;
        b=IbtY+V+6cb6JtXhSD/Ymz43R/wGtQ/xFw8v6UkrKraEe2ZDvP1H64y6TqBxUVZ57KO
         0nYJJToU6oI88qLsr+9UndIuDY6JBT1LA9wJu23t4GMPcloybkANhQ/cHG206YfIEQHG
         j5MZHr5kuZMKoVW024qaNCFxeRHHB1fHPl2UnahNBk5aXgw/zJooafPK0BMe0FbriaYM
         9KrfU+HGgBWMZKhpZ51ofzNS0anQpauSSJ2DysBylaY/eRQeLuDXx/EPzfhUAKr1GnSz
         DAD/5aAllwerjDqsNDRPNXPFw0Kao/2Fjvw7gl0EEtWqCylK2bJxum8UDxu7Yx0pHEAA
         sSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sM0VcNMZ1YwfKZkzv/qhJQSQetYTivBXlvxNCz8pCz8=;
        fh=qS7zLRcOBalHI/nkx2h7lxI03he3RTDDuOT1BfAYdkA=;
        b=bGWXviODuCyGhTw2/dI4yFIivfEbGjO8L/Mo/cp/rVGpo883CNtIqIY3Oc7IQDUm6b
         TIINZ8vZjT1ej+o2R8U9QGOXwCoQsnVendHIQFHtwHZCsh8sYVbA+LTnDO6uMcE262eT
         //gO8YfdPVmXYOnEt0Nx4iuJtGXlXlAfrAXMssdy9l7XqmAd6E0qpYpXOYL++pQA2yJb
         a/D73Wgfi4gNI5weNoUvU8aCREGSKCPxqnq8ErPoyZsws7TCS8eIIV42xLdYLTzH8M13
         UT03x/toscC4zjtTY4Sb+Eh3mvLqzZwahA1/Z120Dg0H4fTWmxHbf+i6obmIfFhepqAu
         31OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781900795; x=1782505595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sM0VcNMZ1YwfKZkzv/qhJQSQetYTivBXlvxNCz8pCz8=;
        b=LT+ELHZMAehG3NI37O8QN/iwr3kSJh0BsvroLhuy+O+iU6AW7HuCtby39Ama/Sq/Py
         lcuEdyvVlLkI+mJS7f217K6UiV8kIbxy71ay+D/M5JHIIdoX++ZUVQs/XS6yVWY4t0LL
         iolctK3sXzNlErXOEQ48jbRcl4BdfeXlgA/tHDUT0T51hD5cG0SxElUWmKoOFTHAUw6S
         qh8dAa5Arwhevh+dQ3cHFpkBHw/QY9o6FsY9vgWlVRNe5jSjV2368oDcSgdA9rVfsx//
         Hq/ScoCrEZaZsH2WH14P9pZeuqXtfqwOcl6BshKNEyHxKubcRFdx5zFgJK8O/lSnR4uW
         L/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781900795; x=1782505595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sM0VcNMZ1YwfKZkzv/qhJQSQetYTivBXlvxNCz8pCz8=;
        b=pnOAQSKg+0zNqVbVO2BPo+uqoulJ7L22j4wej20oIyU5+cQtFGTRIpr0Wxxea7YeNj
         m8hSRN9wDnN4nDQYO6EzgugmLVzfLSSGoaISoAeySgy/A2FNr64LEZ6PFYdoLwROP6Xw
         9UQHb6SKPuNVwWcuIa0XycMohE13hf5IH5qPRk8KkF//77AIYR2awoNlB45fUGVFXMwP
         LiIugW/tY6Ivk7/KVDgbEEGlrqcfbNhMyitps4iebqTPoyQXRZTCYtVkrvgE9/7QL1RK
         vqGuGK2uL4lwSmXyR4z8+gM+1GFYZQt0mzdiFemXyjwGkth62WJBAumROJ/FEx/F7fux
         6bmg==
X-Forwarded-Encrypted: i=1; AFNElJ9kdTYiOQwNSpLG4YqhUT2oUqDshfBLfL66T+6w677+rx2lbITO/XwMrgoTMatYh8IBxAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Q5KY1dqLXjkWe3gSjzBHtWycmVeMTvQ56f1KZbXkX3gGC11O
	KvIX2Df8XrLx4o2z6G+r5nyZtRKjKjDal3QablB3+wSyY+wyhzvbZDGYlyOYjGu7m3sbM1h4BAF
	pYrFImNUFa+fnsigmIDq3Huh468G98/E=
X-Gm-Gg: AfdE7clQjgL8kkN23Lo83qREDktogKLj5+Bb91f38I5DXu5Jzsc/9XsBGXYTwz/YDmX
	fX64KNRxhizaJ9srZMk2Qdqn5Cb3NQ+vyjin8L89XskG9cj+QS8IVXOEeJ6eDQOUcI4240Sj41u
	gjz7MhzXIN8p8tp3ETuKNVd+/p/SG/kQSR3VhK+UVUw/LtY2iMJejqyPwaFNE8mni+Vp6bq0FiT
	BojbXKY4C45s4CgI/Fnqm87FsjO7yNZsVP/AhC1nmaJYIKS4o5vKNBcw7lNAhHpm/0ibwtgwf6R
	EJur9AY=
X-Received: by 2002:a05:6402:268b:b0:697:74f5:806c with SMTP id
 4fb4d7f45d1cf-69774f581cdmr780457a12.7.1781900795206; Fri, 19 Jun 2026
 13:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2314.git.git.1780269406949.gitgitgadget@gmail.com>
 <pull.2314.v2.git.git.1780610623006.gitgitgadget@gmail.com>
 <CAHwyqnWBb65dC+qSYTw9SKdufjibUmTm065feM5D9906H5SQ4w@mail.gmail.com> <xmqqldcamtat.fsf@gitster.g>
In-Reply-To: <xmqqldcamtat.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 19 Jun 2026 22:25:58 +0200
X-Gm-Features: AVVi8CeTf2ih_R60gx9tsNSsQid-PNKipXR-nLvkcVKTCGwUj5ggd29p4VIo9iQ
Message-ID: <CAHwyqnVutjoe-0Qj=HBkbrRU7zq2o-gtoBt_iVyB2so-uB6_8A@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: dedup archives in $(LIBS) so link recipes
 don't repeat them
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for a good lesson about linkers!

Good idea to fix it through the same LD_MAJOR_VERSION as we did for
the __DATA,__common alignment, makes it a lot cleaner.


Harald
