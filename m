Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C334449985
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783806517; cv=pass; b=EMHTFdWhyuwHknHtlGiXt82aNa6MAooR35Pn6PQljKB9ueH+iGOkuZW8dwMfXCqLQrW6MExvfP0mRT5uYLgm8lt+BY+lk6t/1B8l9m46iHvWBHPs3egcFZVVf+yvESGq0qoABiogtL6H3c1cXaV2GrpTYxgCYRq6VMTk1cqPB3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783806517; c=relaxed/simple;
	bh=srdLiuU5UrlTHkjQZMVYPRK4k5J948yvA+Ecl6SsFGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+0qZr8JE4HYC7EB0MO1IGYoIec5VLGQAXiin414OfYrQmOxICgp5Um01aOPFyJYvHhk6c47BrdojHB7y/Cqepd/qJxqXdu8vQjGQh+iYJ/eqKkissjTwOTlT0UVNmaqsi9LDMbg1Q3tTo8oJuhDapfTP6cSrcNlKAS6oRO1alI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=FxHJWcwA; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="FxHJWcwA"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7ebd88be784so1191724a34.2
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 14:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783806514; cv=none;
        d=google.com; s=arc-20260327;
        b=MiICvQiGE1pYS+it8NEWH0J6M9rfxRog4ASerAUPzJ1AITxV2+Z3Ge9vyZ23vymi/h
         e7D7alXZ+hhF4VZMF5OEABAuGVaZdUhXbS5AVlbDokM7z/APMFuLFQ80QkXwDKFmuI+8
         U3CmPfobLk3Z8rS+T2piKelKtnHPG5OTTk3umR7CeeHh4oUzPpR7CKbV0podyUhWghfJ
         1GWtWL7Ulb79mPgv1mw5sXVzMO9MkNvKREvxDudeIalwx1eGNacivrtld0VTDU2tl6k4
         huZIxwhdU4Tuj0xVvLA7LznvpUhcughhp+rEo9/kuliJV1s/zqnas4Fb2SaW33HUSkyc
         j0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4WkPTYDgarIS6OwOLRnfKkOLgL99R6NJt9bsP2fUeqw=;
        fh=WRlH9WyOh2bvb+T3DNh0AVX+T4VKg0D6fWWz0AblW7k=;
        b=GFqJ3HKi6MgSczokAxx40tZOA1YWF3UGw+kcjlR69bmUR6FX6zZoplPEi1E9RyKOS4
         cjk9TEKv5GgQV5IvjD0JaFGeZmA/QAoDGhSSBFUq6ZNHf0mXjWbXAlJ3XVf70SwH/6mr
         LabdeB75W5mvZUoo/sTWHBIBW36tTzgr6YswsveU300+cZWdxj3QhUdfDv4jLe9dD7dh
         nPcBmx72hRj0AxYacbNtBsoO5LViaW5XX6cq4PuSZC6jwemW0S0pg9kOK4gLMo6V9NNI
         TCTIQIjJFzzEMDNjONwj47ZjrUFdS3HIeSyld55Yr1Wem7PP4WlXy36IeLZatoU2v6Th
         2MpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783806514; x=1784411314; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4WkPTYDgarIS6OwOLRnfKkOLgL99R6NJt9bsP2fUeqw=;
        b=FxHJWcwANWzoLP5IH9in3tc30+8JCHRNSwJz+CEu/TzLQWBAST5OE9AWuSemdh6NNd
         RTpXulBfox1nhHWwo0EO5E8fdUP75aDj1BXrZr8jqRHlnSYylPSmBrykCP153COdGdCR
         MYIr3SwJ/3q4LQsb3y1hyMplmaCIv1umWzXk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783806514; x=1784411314;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4WkPTYDgarIS6OwOLRnfKkOLgL99R6NJt9bsP2fUeqw=;
        b=C/X/zpGt29Y8A/bIRs+uE3wdTNH5xEr4R7KftdPu1jA7qumv0uFupGmkEfMhAY+04B
         GF/t8FaiZHFsU42enjdNb9UjrlvIWjJrgGKXG8shBNa/GaacYURog7DQ9CPqK3AJtkvq
         TU922/1LtSfvqp6Mai/+ZBqrFVTUqtg8v1ZflVGb/DDm8kuz7EyfgkpBWxqhitcxL/LC
         6O8YuONVW7n9Atpv/R4ke47zt3Q8mNUcvudYrKKTAiq4omNRm/5k+E4t5I+c/Vnk79X2
         Z6R/tdCK+5itp5IvuUDyvb+FrW6tM4jLoQMEA4/O3055VgSZ7v46k3jO+w6/0Sl8EgI5
         iXuw==
X-Forwarded-Encrypted: i=1; AFNElJ9nL3LMO0mQqEQntNqCFwfo846VxfICvtT7/8FFCVVCZk2Q+yjGlotRYbbopseBHz9tCVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1cbXbs/oYR8oTjUBSXr1hQTbDRPJpzEPlU6NCs42mw39ZZHc
	u/WpK5agofW3WLEyPoMjnqXchc1uX1ERixNm4mgYzUzwrrSVX4LV7tKAk1QHuSjQvDOhoFxtXbH
	l4quVpChEIzEqxbYisVICsqFusvnfEDaPtqC5nQgL0UOP/tsLpU5trE+vzQ==
X-Gm-Gg: AfdE7cnhSCypuyHxvSkBcpXnafBuKEUXEzE9Cqzl+p8+fwQvCSq1J+Xas7eBiVO1n80
	eETAWcy/cDolQuAwn2y/EGZOaAk0naVDS3WjD223FQLndejOTSHFPkZ5tfv+IjTcw+9eUa5e6Mr
	OsAYxY9yAKN6qXJv7rP1J7qciihqfJqQW/mEC5DuX5esVa3+pxaTLkyKeIaA12KXG5JbHQdI/1t
	F2vkDKUBxkGPLY9KPuK7nzzRUnhvNifjO3aa3WmFPGOOvthJnc3H1UAD5PJrBBecVjIs31FbQ==
X-Received: by 2002:a05:690e:1341:b0:667:838f:cd2b with SMTP id
 956f58d0204a3-667d7c7d734mr2988796d50.63.1783806071510; Sat, 11 Jul 2026
 14:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
 <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com> <xmqqv7al9rbj.fsf@gitster.g>
In-Reply-To: <xmqqv7al9rbj.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sat, 11 Jul 2026 23:41:00 +0200
X-Gm-Features: AUfX_mxNKBsjoS6e5pCBwwzytFxAYDZRI1RCLk2gNxluT2SJJpq5Y9kA5p1J7SA
Message-ID: <CAL71e4O5=ZJoPD4dnPmh8mjsTKtugx05-8d83VeQdBNOjp=bFw@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Jul 2026 at 22:58, Junio C Hamano <gitster@pobox.com> wrote:
>
> As always, do *not* base your patches on 'next'.  I cannot apply
> such a patch series to my tree, as merging the resulting topic down
> to 'master' will pull _all_ the other topics, including those that
> are not ready, plus commits that merge these topics into 'next',
> into 'master'.
>
> Instead, choose the topics that you do depend on, prepare a merge of
> these branches into a stable base (like v2.55.0 or master), and then
> build your series on top.

Ah I think I phrased it poorly in the cover letter.
When I said that it's based on next, I meant that it is
verified to work against next but I also confirmed it
works against what you suggested earlier, e.g. a synthetic base:

    git checkout -b synthetic-base origin/master
    git merge --no-ff kk/commit-reach-find-all-fix

There is one textual conflict in commit-reach.c;
the resolution combines both:

    if (!min_generation && !corrected_commit_dates_enabled(r)) {
        queue.pq.compare = compare_commits_by_commit_date;
        gen_ordered = 0;
    }

After that, all ten patches apply cleanly with git am -3.

I should have stated this more clearly in the cover letter
instead of mentioning next at all.

Thanks,
Kristofer
