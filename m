Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F522261D
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273794; cv=none; b=WrQc1bZzXOdcgOGD/G9GktFfIecjGp6PMYQbdzxNvt2Cgsg7KovmCTa6w/eRnGqYkaEFbKE9Vnt2GhavBwvNuMe/eoqI0hp53zd/9YrG5CmAsI/Dz4ZiYpOITPqV01ZPajrknP/tyk6BUWUDVsMnfkhU58RtxTuwQAR6KsFurPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273794; c=relaxed/simple;
	bh=ABgoEfkBsNmxA7PeGo+zERoQEOcD9OXWlNfhzwoJ6mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dlds+Kq7GiXRVGhgqtlipMAYcxrFzUU/oT5EXLDD+MjJHkvCCbMZEkVXEMTwweMkI2RRRkDal2Qu8zTOa4HtS0jSGhoBhZq2iAKHfU2ijk68CZWbtu3XQOnrc6iGm+Qj+8Y0DHawDk1RBJCojuCXl6e+AgdtJXEpx5TJnziP1wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cb21f041c8so4352276d6.3
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 21:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728273791; x=1728878591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABgoEfkBsNmxA7PeGo+zERoQEOcD9OXWlNfhzwoJ6mE=;
        b=dx7EsTodLSlKPvyG8YResNlJinEVbdm5dOkrN02PK2JBe5rs5nXrtxaPTVSlJKlnVZ
         3oJf9aPQ4mML9tXzPD2aaDxepZQfPEEB+EhA3GPuknTQRKrYNV4/yl/lqPOBc0Ko0aQM
         Qb8C3bt630bDrRQWJye0OR1PmYVH3ql9+8xWeR4xzgSLovUTs8FMfoTqALMZ89PZ8Irt
         n5R5qmNCcHJPMFQbjk33lL5gxvxu+HkzBmUzwZBitl6Cwtq8JGUKgYAw/WcodLZ/GDDE
         FyBp5A9hMfD4NS4xQa3GS4HOHzV+Km54T0F+MbdGzFbZZnKcpCtuO+fMG9Cj+HO8D4L8
         gr4w==
X-Forwarded-Encrypted: i=1; AJvYcCXYsOuJzJBu6e6kpRQmxJGJxrb0OHoSquGVfzQDIVZuy5AlbLMft4VOJX1mfJ8Vxe8VM54=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRQk7ZgnjKsvVogrrcQFs3M30TeGu6rdZ0AXrr4+s0qU4F8Gxz
	xJKxDdOTcEhT1rzvyVLFvkClOINGOaWkTRW8hcoOULdALp2u6ubInHGc6VZsE7jkTj1XJmAzpjM
	CwVDZ2yGQQWPVoomBJ3XTWiVbDAI=
X-Google-Smtp-Source: AGHT+IEbLXD9leEuMR8LrtENY+gWT9wa2jxEw3k6BqtHNuwS0VW0ydPquF9vr8AzkIF/kxI0zpQvHMF9NOB10cv5yIA=
X-Received: by 2002:a05:6214:dca:b0:6cb:63aa:b05f with SMTP id
 6a1803df08f44-6cb9a454988mr76245146d6.7.1728273790818; Sun, 06 Oct 2024
 21:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-3-cdwhite3@pm.me>
 <ZwKuptTMf9ECd-kf@ArchLinux> <I3BmSHTyOELt2DzfSaLhRYLouu5iAPZIZGZ2Ne73AygO35CM0mq44INa68t6VD4XV61DgzbrfUW0m8fivd3N9Rejgm-tecXQHXQRs1BP9CQ=@pm.me>
 <ZwNZRX1LHlxawJJc@ArchLinux>
In-Reply-To: <ZwNZRX1LHlxawJJc@ArchLinux>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 7 Oct 2024 00:02:59 -0400
Message-ID: <CAPig+cQjHCZChToM_nEhmQsXedK4nEObs7YV2Q2PzrZqcHB4fQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] worktree: link worktrees with relative paths
To: shejialuo <shejialuo@gmail.com>
Cc: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 11:45=E2=80=AFPM shejialuo <shejialuo@gmail.com> wro=
te:
> Actually, I somehow understand why in the original code, it will use
> "xstrdup_or_null" to initialize the "backlink". Because in
> "read_gitfile_gently", we will use a static "struct strbuf" as the
> buffer.
>
> I guess the intention of the original code is that if we call again
> "read_gitfile_gently" in this function or we have another thread which
> calls this function, the content of the buffer will be changed. So we
> explicitly use "xstrdup_or_null" to create a copy here to avoid this.

That's correct. The code is being defensive in case the static strbuf
inside read_gitfile_gently() gets overwritten.

> But I wonder whether we really need to consider above problem?

It's easier to reason about the code in this function if we don't have
to worry about the underlying static strbuf. Also, this is not a hot
path so the extra allocation and string copy is not a concern. As
such, it makes sense for the code to remain robust (by creating the
copy) rather than becoming potentially more fragile by eliminating the
string copy.
