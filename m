Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A253D25D0
	for <git@vger.kernel.org>; Fri, 22 May 2026 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447027; cv=pass; b=LaAQ+OVxHWWxa62xr0uv8RtvFiY8N4Ihe8vDkd+8rpDNDiLJ62B9QroevInO7iJ7GHJrq/IxN9JnIrDX4Mstn7TGUh+cnsvIScS5g+Mny/L50jER9EjhvyJANkj5/KrUILB7fQGLX6M1aeJWPgYMtuGz12BvYFtEek0P+NuEVzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447027; c=relaxed/simple;
	bh=Rnot76blbh5WZm7IBIuoZPuaaxoRQ2uEubZDT7s2glg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olAnnfn82UseQ267u4GQEjBzkwFlF7BQ5Tp6aqWAwv+JwHZlM3RtzP7R3gU7YGHAAUsiXErR0cftP7iI53XgKiUQdvvp8VPqAanG83013RA9BdpiC3JrPbwsBYvNFabsDIjhlBqdlT1qAkEoITC+TvmphtQShbr3orvCE76LMUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un7gdsbc; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un7gdsbc"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd01481e592so1022210766b.2
        for <git@vger.kernel.org>; Fri, 22 May 2026 03:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779447025; cv=none;
        d=google.com; s=arc-20240605;
        b=UAyo0msA5HNUXe/gTHU4nv+pA/mxsxQwTEbAUXkPj9B3WLXo/8m80lOUgecUW5Eb8G
         UVyIe6FuJY3gLo0wiWixjFGqE92AATNTtURMi4XkGHbRj3Jang84FRJ333mVuAci0V2d
         m3e3/0T/ZEvYIhfD2dtCYeXeX1jhrKhmjHvWumEYhas7opX3gDdQpufQsYXAHZTTqZO6
         bWSpdnoTqQSpkwctVSD7rbjOLQRIlNJOuVkUQG660qXDZJe9NK4CxjhAnWEgAUvTTwhP
         eWgo8fOyILVlHWVrzeHNfGG891vm49FkJC3Bh8SXK6vCnv1OXdFlE2VaE1UIkC0yZdJE
         jwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hs2hY6yI0+fB+/x2VfP5av9ufjuyo+WpTJ4SlOVmkVc=;
        fh=u0YzrhG14BayFVUYPMhFOS7qdTqx/2eqKUnq0Img7+A=;
        b=JPCaCp2dhQTmBuj9MmSaTIXTrTYObYhmQlLOJ5bBcwHKAnWwNikXQsVVVYMDovPHI+
         GofbiQpd9emJGgx+I1wUrycqtyOvuVSfrzSXWPwGtBw/pau9kh4ASRQbec5ZccitBCbT
         mPES6lx25atly0ilJ30GDBO0CLuISSmy9n7TDCL1zFLBKdjE++HdOTujwMNfCN/nL3JD
         yPbDkhdhyg90k8hEiL8/JiFCtNmBXsKRU1N91iQ/DbQ/ITcDEXFoq6iTRKxtvrRj3hKh
         AAitrL1TbPK3mnzPb4d8YEZeORNOl0KI08Zq0QEEQ1EhdJwg2CPO00Tyf12E/C7v9vBW
         lcXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779447025; x=1780051825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hs2hY6yI0+fB+/x2VfP5av9ufjuyo+WpTJ4SlOVmkVc=;
        b=Un7gdsbcCYt3S9kbLBAqSpcg4OwQmw+hU/FWhAmnc0F9pIgOH/Z7tyUAxzHUkO8ggR
         krgFbAKpyzYabFcCOsBsxMB46lF0K0oSP8tLBN5nCSFMCQ8VvfdLi1xFQAjDRpvvjW/V
         dC+GKiHXkCGzq9Z4TR7LW34yo8LBVp40Xx+tGaw4WGceYd0qCyINBqhZhQBK0b/msqOs
         Weala7S3dimPYdu59Ey2En47EBgJWiz70OciU6CYcRZwOIiyR/O1MdZYvpcEsjftvPjH
         OOLtL9AlVX8nuJ/Wi60b+kLTYeqVY6RyCeQb9IB7nce8jSU+MHBT+tiR6iqAji6cqmef
         Z2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779447025; x=1780051825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs2hY6yI0+fB+/x2VfP5av9ufjuyo+WpTJ4SlOVmkVc=;
        b=DSrDeOq+bC3UQJe7BaNN36cA05qelgDaE3Fw0CkCKmGUbZRJX2ImKXELtGIv1TYZsn
         H41xZgHVlXUVeV3lALCwfat1XNJM2vUdbt3iFBBaCEVccO/KUVdulKvsMUHKuCMIKvsC
         Gu3bdPeMs8Zv91hOBL93DzgfBK94kTji+ip9oNeuEgYbP5JNhehJnv0lgYpdWkNqEUQj
         ghGPGvbGX3q9IxgzB3rA7skKlFCIok6y/2SuB6Cy4+On9W3Eb/el4bCLjWKKm4bH2/SM
         n1FO8LS0GWFpumoeBmLpf6BQEWP/P2iRhxygUqFCAq1DPEUxMhb8mNjNQbtReRrX9NNI
         UhYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9VpRY3VuU6cMJi5lSHjyzJv0hZPUVGXiZg31vbCpSeb9RPm3VAeYbel1tUEtGlimIOARE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5LWVfn+h/cGuWc+Z1HDIzxXQataiCU3N8ql2xPscu+cubklLI
	lE+w/b7CBEQ2D9mE79QQInptMOL1CfZzSP9PHtFQZWt3rBGHHxVbv0e4Rd+xoZcK59TIxP7DYu4
	DEN/ztvR6RClt7e/ZwWbmyzFMq2/Oh3I=
X-Gm-Gg: Acq92OG0t50c6tDiDu6/qLsFgTXGbOCEotDLav5nuOdAUJ4yhg6944Q8xeCpZhY7aNp
	CcSTSWBa7K4p0Ki7hesiT1CvxLJZi8zN8WpqslvMEKUY0eaV6tH9ZqVGOga2LuJITTJbBtqB328
	slXOjNeicwolfMhT5ozYR5RWPmBu8ogzuSdpORwLZcKEPR3/uUB0gYRkPizG1dJPKgHqN8dqyMs
	Ejpa4O170CV03Fi91f4GshDcdOxaWv0awLOUHFvGXoIlUlXGKnR/jVfYeThBbqpC3pdPoHeNsU+
	gfzLcGA=
X-Received: by 2002:a17:906:6a0b:b0:bd4:99f5:52f6 with SMTP id
 a640c23a62f3a-bdd264bf66bmr192813566b.34.1779447024610; Fri, 22 May 2026
 03:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
 <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com> <f2df15983067ce39b6c33ab81115863d5c3567f4.1779403204.git.gitgitgadget@gmail.com>
 <273103d7-c816-4cde-9e89-b630c37b0749@kdbg.org> <xmqqse7kt0ge.fsf@gitster.g>
In-Reply-To: <xmqqse7kt0ge.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 22 May 2026 12:49:46 +0200
X-Gm-Features: AVHnY4J-A6g71G16qkM7yhsKj3EnDh9x1O4ad1VnWz3xt6-mUgNq4s1cG9wu5io
Message-ID: <CAHwyqnX=zvjpy3w8qn+H7L_Ncxs5+tK5Va-Lr4ZXX=XYLs2YZQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] branch: add --forked <branch>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Johannes Sixt <j6t@kdbg.org> writes:
>
> > The icing on the cake would now be that
> >
> >     git branch --merged origin/main --forked origin/*
> >
> > provides the list of branches forked from origin that have already been
> > integrated.
>
> Yup, that is very nice.  Also with "--merged" replaced with
> "--not-merged", i.e., "our work building on top of origin's, and
> still need to be finished", would give us a good list to work on.

This is nice, but I think this would require an overhaul of other
infra as well, maybe better to do as a follow-up?


Harald
