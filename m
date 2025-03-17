Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E1205E1C
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250657; cv=none; b=uic7zRW9Nnb3ik018FrBVM7zrnifs4/MbPRlZTfRwgiUZfyEeHXh7a/Wg3zA1vODoeFXRhaW8Bq7yIlWSQV9+LHKms1TQOscVSWGV7/TVzp7h2xs6/B/z+Mi6VQ/RF4F9g843xYsFfujPy4tV5VZ9GPQISjWAAaKHYl0optqdz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250657; c=relaxed/simple;
	bh=tXygsvpIYR1HIDHyr9EJLwxIxUW6Ue9JyeEJgtDChN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUogpr8urgwjqgKXwyZs5JGgeiVg3YZe2saBgFy8g+/WS8sMyWRZDiz4W51D8KTZ562NGx9n0HmA5qxF5gHLdzGYpD1i3U9m2kmXrwrTNnO60QBdVvaf8JSM/me23BV9WO37b0xgQ3uqw9JJxn6uzaf1qMgfqqBb9WU3feiWuMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=rfkrHl0T; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rfkrHl0T"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c559b3eb0bso285972585a.1
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 15:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742250655; x=1742855455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd2EZ5m6wzsyDW1fjwUS4zfZml0geMHP3+fLgWc5Omo=;
        b=rfkrHl0T32yy+WhULt26AKHCZQ9Q0r3ciBe+b1LenFYdNqYQtBRDyBhEPgCjyQOXiu
         zSTGPn/SWFHKQbu2/XoIguy+q8bY7iKIUeCpTUatYmmh/F83yIWykeVJ/htEHUcUZALQ
         Im/GATxTBi7DDTmwjhwo6NgBfMHYxxpId4qML+DIaaszrBIr4/2I2IFsCDqnqPoIRb35
         lCiytQyuxP7jgeSVVElk0RhfzfN6KYgzjkR3ctC/4PdBcJd3kDHwNH9t1bnnmbm43ti7
         d0nA7H/oJYU5k8D11r5twUZxZkGneWGQfDkPPh6mEsTz2O5sUsMhSu1RvFIw0sgEy1mI
         xjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250655; x=1742855455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vd2EZ5m6wzsyDW1fjwUS4zfZml0geMHP3+fLgWc5Omo=;
        b=qtc6y3OVjW8HCdwv3C78GhZ5q8swbC6pOrwLVZ9ulSkYWUjjkO755opD2jjp2g6Rit
         eLDBVygWcd2lRcJ9GGAEIgvkXejPs4GkUsAdwRxrvP92LDeSMz9fLRWHEAt2Z7Y4qeOF
         q5/5M/TMojAzaFIuJapu0l1L9ViVu3DXYzttXQnVRES8FRe5elL7YNMC0KT51zguEIWz
         QhRLxNZbrjuBPTYYrlHhtGGAvR5ooqYG7ww9rjfKIkbV72sv0+lTKmHJ8NZTXj8asAko
         EadUyCYVY4lFsb5WD/pW08Cpc4UXzH1F8c61iPYvTsEy+o5zhT/vBaK7vhkhxk6Mzivo
         ZLEA==
X-Gm-Message-State: AOJu0Ywzwveq4jyHM8KiXkoEAys+AoQ4lU+PW5pfW4RRS6Lk10TWzxdv
	cwGZXidONFVOLyrAJ9H40Obyn7gVRTqk4U9kztp5rIESzA01plUDviYoAo0Fj2/vqp361r39zFz
	lwng=
X-Gm-Gg: ASbGncsLYLHhTOXSysIL5XNDypjSUnQkXXEaGdQ7pVW1qPh8n24nyopfz/iXeUbJRbv
	YTMo7KXIG70W15ZavUdxSbKNKpMQb4dzhJGdfPvZ6g3IsesnP8ZkdgkQqoWJ96p9W8UfsFLH6ei
	EWsUHIEYNtVnVh5ykyUOTw9AV6DKwz6iGPQQ+hs7r7Z0KbzBPp7JX586hBO2wyiZ5MJ9MdTCCx5
	3qFeduxP039ZVGgogzXVUH/k595ROZOcww88K/IrSSrIhW2/wpGf7jXSrClcvdJez4xn2CgTyav
	4qI+KpI+saZ169iqqQJQsnfs3qPj14U7iaHll4QBX1Nq+EJIO77RKyZT/wwjKecpla8m70yJS38
	x6WmGYfIW2TvAeZuz
X-Google-Smtp-Source: AGHT+IFOQnt1PVOS01MkHI073g8z5pnIL2XqXYim1/IoN1e0eZ4EtL7tCVRzfBWYkZdJJT8UCnpCQQ==
X-Received: by 2002:a05:620a:198c:b0:7c5:64a5:d17e with SMTP id af79cd13be357-7c57c7c123dmr2439481085a.25.1742250655074;
        Mon, 17 Mar 2025 15:30:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573b3a042sm644642085a.0.2025.03.17.15.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:30:54 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:30:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/3] ci: add build checking for side-effects in
 assert() calls
Message-ID: <Z9iinbyrn4PeFmCl@nand.local>
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
 <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
 <58cb8f6a1609b10d761e86bdad541d1c018cb582.1742107322.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58cb8f6a1609b10d761e86bdad541d1c018cb582.1742107322.git.gitgitgadget@gmail.com>

On Sun, Mar 16, 2025 at 06:42:01AM +0000, Elijah Newren via GitGitGadget wrote:
> We have roughly 566 assert() calls in our codebase (my grep might have
> picked up things that aren't actually assert() calls, but most appeared
> to be).  All but 9 of them can be determined by gcc to be free of side
> effects with a clever redefine of assert() provided by Bruno De Fraine
> (from
> https://stackoverflow.com/questions/10593492/catching-assert-with-side-effects),
> who upon request has graciously placed his two-liner into the public
> domain without warranty of any kind.  The current 9 assert() calls
> flagged by this clever redefinition of assert() appear to me to be free
> of side effects as well, but are too complicated for a compiler/linker
> to figure that since each assertion involves some kind of function call.
> Add a CI job which will find and report these possibly problematic
> assertions, and have the job suggest to the user that they replace these
> with BUG_IF_NOT() calls.

Very nice, and thank you Bruno for placing your very clever assert() in
the public domain :-).

I wonder if it might be useful to explain this in
Documentation/CodingGuidelines as a follow-up to this series. I was
thinking of a scenario where someone either writes a side-effecting
assert(), or a non-side-effecting one that is too complicated to prove
otherwise.

If that person runs 'make test' locally, they might not see any
failures, but then be surprised when CI fails on the new step. It may be
worth mentioning that we have such a check, and that we expect all
assert() statements to be side effect-free, and that developers can
verify this by ci/check-unsafe-assertions.sh.

But that may bring us into an assert() versus BUG_IF_NOT() debate, which
may be somewhat counterproductive, so I'm just as happy if you did
nothing here :-).

Thanks,
Taylor
