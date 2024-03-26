Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2451E534
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 23:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711496391; cv=none; b=jnCiyfnlOXXVIhH9MfQckxvkcgTdhxgCQPGh7vT4DI97GHUaz69Ep/doHjxV0mbCqDGTo4zdUNARV+pBQjrg0fB5PBPK3AVV6pgfaOcRkvdcwH4DnHyuqCO5o9mPELTnOU3D65Svx6aFHdVD/pnUqZsqqkXHw38aZGOLZjWraow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711496391; c=relaxed/simple;
	bh=BvbHzwq7lOpmnlg1h7zEzsk9mRbMsd21UFBWVxiVTbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aydhh8sKwQHanVx6SF1P4vWvrh12MK8ag9mbNZptdK2LHFfgWCcr2xkP/l52Af9KIoj9zfzyIsHm2eeamtH+Vy3ipEng25QCZN3My9yNzNZLjhvIg6ylBFKW4AQk4rYIZNFKlk+ssyUHpHCAEbE1sdK0jwNcsTcOE2UeKGpsk6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=H/0LtdXh; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="H/0LtdXh"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-430c63d4da9so43665141cf.0
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 16:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711496388; x=1712101188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZ2DLO0mPHMuYAZrejEEkpynelIlJXUPAxOlJ82omrA=;
        b=H/0LtdXhxZiquD/bNl/dwHKJ6W8GuGOrHsPGY6mReh7suEKySZaW4ZrQ5lB3/SuJKS
         dBiChrJQROhGx444FKg0rcR2uXsTU4jLI+qFRW3PVkLHKsCiCfh02IA2N4Ely0ew8zPW
         BNmeeQaHRROW/N2leVGkzQgRpKAJzMOA/7T+PWo2Iv2q11I6V6lOwg2dZVt6zqU+SXvk
         S5/p39AGEoc7hnXVWbGzt8AyS0vQ6BSu3p9/cllKaixMPZ9JA0Eoc0KSiNQvgP3HfgUm
         P+mEf8XSWLiVpj7Gmg0UUjnTsI7PIke3CmPH8yvR1C0LQMyCVelgQ9szbUxvNYPqfB1Z
         3vKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711496388; x=1712101188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZ2DLO0mPHMuYAZrejEEkpynelIlJXUPAxOlJ82omrA=;
        b=mwPZli9ISEipDvdrawP3xihKSDue74OHBTmuA57u5XueHJCzUqF9c2rr/7HGl6esHb
         aJhrRP0a9mt8cAEevT0BHC1PRaXYvgyQVlViiHYMDSN+vre1BOtETUB9Xz+oM+E/RItG
         cBKqQzZTgAiYNKSBCNkZxaqx8rHpBnuJfDDsugJmrmbbVcAfMbdiOgs9FmggxWaR0wxY
         J3qhFqS9yC9eJThNqiewIgmDA3TVS5epsAWt6Iw/32YP5ut9RiVv4p5SlQJ9X8YWpoFu
         xrUpcUQydtTJAdXui1a9U9odGOw04aorYBm2bTKXOmsY79z2TkE1LvcczloTiUJUWV7h
         157A==
X-Forwarded-Encrypted: i=1; AJvYcCW6jsM7NH/B3zoWv/UnDWfXvhu+s4iHVULWBih2tE8xHDA/IkdpLfSZ0/X14RG7/mIqbBj+KdX/JnbIbOeuev+ef8D0
X-Gm-Message-State: AOJu0Ywg6Eh5BcJoXLA6KA3ASUm1/n9D3fp1W3xyBP/yYazzu2ReTpkC
	g12ORuuZoSJrbMbsGzB7//kA4poOEEM5Ps1QU2APyGpyRGfjZ8fQCrDe+OZevSo=
X-Google-Smtp-Source: AGHT+IG8qHpl3lmOAE7xdEkF1H9Hv7j1V9T8l4Z8petc2GDiwju/7d9qHF33pCCTgsBOiN0usxOXKg==
X-Received: by 2002:a05:622a:4e87:b0:431:757c:9a85 with SMTP id dj7-20020a05622a4e8700b00431757c9a85mr2379741qtb.44.1711496388209;
        Tue, 26 Mar 2024 16:39:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id en10-20020a05622a540a00b004316bafd1afsm1255390qtb.3.2024.03.26.16.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 16:39:47 -0700 (PDT)
Date: Tue, 26 Mar 2024 19:39:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH] RFC: add MAINTAINERS file
Message-ID: <ZgNcvR8STOUxxc1e@nand.local>
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
 <xmqqsf0gvjrg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsf0gvjrg.fsf@gitster.g>

On Sat, Mar 23, 2024 at 12:19:15PM -0700, Junio C Hamano wrote:
>  - Is the project big enough to require this (especially for the
>    purpose of (1)), or would
>
>    $ git shortlog -n --no-merges --since=24.months -- path-to-file
>
>    be sufficient and more importantly the value that it will keep
>    current automatically outweigh the benefit of having this file
>    that can go stale?  To answer this question, we'd need to know
>    the turnover rates of past project contributors, of course.  If
>    it is too high, having such a list may help for (1) and (3)
>    above.

I might be biased, but I think that we are not quite there, yet.
Subjectively, I find myself working in areas where I mostly know who to
CC based on what parts of the tree that I'm touching. But in the cases
where I do not, the shortlog --since=2.years.ago is usually pretty
small.

The output below lists number of individuals in the right-hand column,
and the number of files with that many individuals having touched it in
the last two years in the left-hand column:

    for f in $(git ls-files **/*.{c,h})
    do
      git shortlog -s --since-as-filter=2.years.ago -- $f | wc -l \
        || return 1
    done |
    sort -n | uniq -c | sort -rnk1
        192 1
        160 0
        112 2
         94 3
         80 4
         68 5
         40 6
         30 9
         27 8
         25 7
         19 11
         12 10
         11 12
          5 17
          5 14
          3 13
          2 18
          2 16
          1 22
          1 20
          1 19
          1 15

So a vast majority of *.ch files have fewer than 10 individuals working
on it in the past two years. By my count, there are 891 total source
files matching **/*.{c,h}, 828 of which have fewer than 10 people
working on it.

IOW, ~92.3% of the project is touched by no more than 9 people in the
last two years.

That kind of scale doesn't strike me as something that needs something
like a MAINTAINERS file to help make sense of it. It's possible that
some of the files that see more contributors might need some sort of
aide, but there are so few of them I have a hard time imagining it.

>  - How binding is it for a contributor to be on this list as an area
>    expert?  Will there be concrete "expected response time"?  It can
>    be different for each area expert, of course.  I'd expect better
>    from those who work on Git as a major part of their job and
>    contributes some part of their work product back to the upstream,
>    than from folks who do Git as a hobby.  Is each contributer
>    expected to volunteer to be on this list, with self declared
>    service level target?

I share your concern here, too.

Another thought that comes to mind is the difference between
"maintainer" and "reviewer". For a file with, say, 4 committers in the
past two years, I imagine that as the maintainer that you'd give about
equal weight to any of their reviews (with obvious exceptions, like if
someone had showed up in the shortlog over a much longer period, or had
significantly more or substantial patches in a given area).

Those kinds of things are hard to quantify exactly, and perhaps that is
the point of a MAINTAINERS file. But I think quantifying those things
matters a lot more when you have dozens or more individuals contributing
to files across the tree, and the numbers above show that (at least for
a large majority of the project) we're simply not there yet.

Thanks,
Taylor
