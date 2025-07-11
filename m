Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3FC21C19D
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752267761; cv=none; b=lIkamvFsNjlhIlLl//ir0duwy2tjCrcL4PXO1I6sE/JenRhaTTnH2NFFfcoTe2h81IlEMpJ9RBYVVgUk1NzNnZYdquSPxzmIMqe28sf503udKIkgY8MVAJr8UnehWJaaA4Px+Ny1b1ekdgi71U5Y0qvn9LTwN0opN9vzGGksKWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752267761; c=relaxed/simple;
	bh=47L/ZuZqPT0jwkFG132To6k89qctnXmGoCBVxIZNVlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbE5FpOicWN+QxGMNPknPK2hkJkD5swR6X0rm4Z7mnyJCExgxbVL+Ozoax7NW6qIMfKUmsNB2Y1z85S08Ly6gJHklKqgJjRirm7MKqL0VDEesCA2O92m8Cxz54AT4Q/DzwKAa3sM9FASWUCLFtKwoUEfboVpXzXVb3lyEUOjqfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlkFN5zD; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlkFN5zD"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73cddf31c45so624061a34.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 14:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752267759; x=1752872559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UdHapH+aE8Dz1g6fTChg8QUZ7XQ9dxqI9Mz+6r+EME8=;
        b=JlkFN5zDC2cA8DOoVwSs1WZAYQsFlseFymzA7NzErt5prh+3AkKgWzM33j8IjO8NXH
         e+A1DhOqwMDIgq05hondkn3Apq6sQPPp7z5ypVUIMZqPYHoO/5H8pSZ3ZaHam1gjnhrx
         TU/6sKuWrak7ImeC0xEV1QkQIsDLMpHPZXatkM5vPI3/xpiFuJnVNcqDfa2LSCfJ9QbB
         4h8lxK3czveeIDpx6lHBBJfL8zUWDTEQ55K8ff/wEeTCmSmermuNFpAqKk8Zzdt1A9hz
         PvO6paYkI5v9J1TOix2T+NcY6uvbpmRMv83HtgsRG0/3kW5HpXvheTmSoFs/zeX+m9Ch
         RWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752267759; x=1752872559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdHapH+aE8Dz1g6fTChg8QUZ7XQ9dxqI9Mz+6r+EME8=;
        b=J9astXPkQ96Cc/t4ARUfWJ3eABQscHwYinTACYqngwBh7beusfJ1TeyAbpUIdcJirN
         cSHzto6bNw/k23Cbh8V1tICbcEaVJcLfj06zsZ0pkDgYMKFuTqLj9tRT1Jff1x55EPft
         H4sA1vxBlw/dV+Lg/Ry8ersPZH5mBSmw3UCwWuTHavZ/6aPNrlFNRDXqdkG9Rbtqb5zq
         aBWQ/GDksd9CLiQsMLzs3aprUWy0LHrAtGFTkHeAhVbxWGhiY9ccGR3+AbyeJoTHFiV/
         vMjoeKdJL5kTVI0w10zWH+fCw4HX6O0S1SDhd59GHIP/7elmlfXNqWFuOd1yfq6geACr
         iqNA==
X-Gm-Message-State: AOJu0Yx+kP9xVKFFlga/R8Sxmqgs798NpafLJHyx0dW5OGZT6ryyhuGi
	OH32OU5+3miap54RGQvOZroicBP6ACkCklGdK6UJ+bLzzD3X3bqVfigL/thhzA==
X-Gm-Gg: ASbGncuCzTxD/vXmJjTOisjAuZq9k+eOquZuQfzzbix+g5OR4/lxpWUw6F/XSB8cllJ
	di4gddt7M9PKo7hOxmhJMvH5PWbA9dxl0+0MkhkAPfeH+hhtq6+KobdOGi3KIgWihixv+ZnrXnF
	oAJUvZoI+J4WF0pf/N3WOnFsJHyH64a3BFhm2Qdd8pJrkQGFYd5ZV2ylN5hROWWc8lXZ7JI8h+8
	Fj9PDIecywKzC3XKoE1Y1aKeKDhQHz6/xevXP+/NzDFGUft+vdmhVQy2ozWkbOuHXQs/2u24XGM
	fMhlfJRbIxDMnDUhJkzcCQOvfzRpD1o6uBCgBvXdkn3KGXmFikkunI+/0dDr9EW87vMOd703ICi
	3hIscTsXTFK2Mmyw=
X-Google-Smtp-Source: AGHT+IFWITTq1+XgHiiWtYp5a1G4tZ4PKuTYzPdm0FdOvHqaWhYfY6Qy/WNYWPxiVvAmkbSbYPqSkw==
X-Received: by 2002:a05:6808:2124:b0:401:ea7b:e535 with SMTP id 5614622812f47-41511619958mr3804209b6e.22.1752267759004;
        Fri, 11 Jul 2025 14:02:39 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-4141bcd27b6sm668732b6e.29.2025.07.11.14.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 14:02:38 -0700 (PDT)
Date: Fri, 11 Jul 2025 15:57:00 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] tag: allow idempotent "git tag" without "--force"
Message-ID: <dt5ruadvr7lmhsbypmb6yili5cookfx5btw4gzfeui7ehxxajv@ziael4udbbcy>
References: <xmqqzfefodje.fsf@gitster.g>
 <xmqqv7nyzgp7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7nyzgp7.fsf@gitster.g>

On 25/07/11 12:10PM, Junio C Hamano wrote:
> When "git tag T O" is told to create a tag pointing at an object O
> without the "--force" option, it refuses with "tag T already exists",
> even when T points at O (which makes it a no-op).
> 
> Let's allow this "idempotent" case by special casing and making it
> truly a no-op.

Not necessarily a strong argument against, but I could maybe see a user
only wanting to perform some followup operation if a tag is _actually_
created. For example push the newly created tag:

  git tag T O && git push --tags

To me atleast, the feedback of knowing whether tag was created seems a bit more
interesting. I also don't feel super strongly though.

-Justin
