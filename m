Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C073B7262F
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 04:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838799; cv=none; b=RhjaiKHU7PouUiZV/1sm1YyI48SHnIA8VzDN38nA658de+U6Obg8EVgcbbc7HymgidkPQ239zuAEtObLHSbN47ui/zWcaWQhPv6X/6SC/Up+pLCsJccwGR+Xijhz1Hdiay969TuypkHp+Fb9iyXNw0UWr/G/S2DjDfKe9gUl7TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838799; c=relaxed/simple;
	bh=38iV3H8KpKSDOEjHtf7tS/RyIONeLRhl9dbnhCNZR3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+8gDzztWRWYwixxX4DUPq79fSZRrjSFs9pNpcFjf26OvED/7O21i3ObyQwatVKkfHKzeImnDn4E2YWn9rGN23wCEa+U8yBhPqIpI8LotWaCewrBn5w0ESgcSz11c3ss5mS81hRKu0MoSnN4RlX4p780q8Mbo5t+VDWRtc54siI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHnxZ86f; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHnxZ86f"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24457fe9704so16316565ad.0
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 21:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755838797; x=1756443597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nmR6CyJuSSXbztyVc0m+5OuakG2ByieT1SRboR4GfdE=;
        b=MHnxZ86fImmsgxXKodcp9DfYmydU5bTfzGN1qGYhpKOpHxmUrExn/fBDZCimyzMNGl
         5k6uKFum/eD5X+DezzZgy3YNciTtYJJK5Go9vbtKZWoMwStU8VYWAlpqy6BS4K48fj9b
         2Ro4J8c1FIy5xwNuQbC/AWK7fS+WGGUBbZmL3TckS7RnVMtJ08yPQur0uA39LhRaC85W
         tNux393vxLaTVhEEPvvEM9z9qpitTYiq/QpFLmacQ82NqgcM7rNMJoF+bPjXnUWY/b/7
         rgotitStAdflGfZq3Yre6EuiKP3x/H6qkZS09BsN1v1OqcT4dRshs6BzA0ZAeV8ILGWa
         xmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755838797; x=1756443597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmR6CyJuSSXbztyVc0m+5OuakG2ByieT1SRboR4GfdE=;
        b=MlvxdCSVxGHuCpptiZmHw2+xxSrszAt1ylLRITAlXywc3pFvOu+UhLVmSUYrXgstXg
         rRcAj8nYp6OtOr1wfNZBAik4TfO8acDY7q7qyo/4DFvM+3f8FVoeQjEDn1Cs4cndLWRc
         Thpm1YSvnqS1RNvS0HLDMpRMk+8f7wLFu4FG3TuAPHpoKkqMrkl0pATu/3U25UHKVwdC
         QcrJYCL52YhtcyYYNKH6Kn84qSPsSPDf4pkK4hns4T6ofWIS+WLpo2zuIaF79t1SqMob
         GKXQw5ik5F3IxVjYFM8UvuN4fOO4vPAmue21630OZA5ENK3DweUAIjxo0+JPeplL5jXQ
         GqXQ==
X-Gm-Message-State: AOJu0YxRH3KXiMhd/bMZ8heeOwTHCdsFd7r0mamJRCTlIVKEMI4wA+tP
	0vfb0JJSz1aBT7Um/luYR75nU3xW2Y+b8GD9JWeVsKKuUf5excpbEf6eJ5ID/7XhRM/ehCKvGpL
	ljrW64QU9uNjXrIBwJVVeAjToeIdJGePvSkQo
X-Gm-Gg: ASbGncukS2s+NQ5yyc/4/a/fo0AhELsM8HTwkA/ruzve80pNFCFEbIt1SMTjTcGKyZE
	/6Y16A83onk2JTdn95iaks7Pyx7LXSHCZobh/SBqsU+rQUwiYZ0+wtoHxEfOqpwUycAj6TCKrXZ
	ebAoHsCXBD0q0r5YPUpISM8Eu6DwMtrLA0lZcF1uxiQBo8hRiNkfKW8Qkcok2JzJuGg8kPxwwtN
	cen54ju
X-Google-Smtp-Source: AGHT+IHoBIJ1m2lXRtZVVbz/peZcOGom3CPT1Pq5jm70X87GwmT56zC/Pwf097FPa23+YSBZlm65Hs1LYfaXWLGWYyU=
X-Received: by 2002:a17:903:124c:b0:240:84b:a11a with SMTP id
 d9443c01a7336-2462ee2bc6fmr27461805ad.17.1755838796855; Thu, 21 Aug 2025
 21:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821085246.929307-1-meetsoni3017@gmail.com>
 <20250821085246.929307-3-meetsoni3017@gmail.com> <aKbzNNcZZ-E0FVeI@pks.im>
In-Reply-To: <aKbzNNcZZ-E0FVeI@pks.im>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Fri, 22 Aug 2025 10:29:45 +0530
X-Gm-Features: Ac12FXx6JR03pynlagGt6Pbs1J21HaYm58X-C16Okx7xhtwnkXDcilSRjJBgvGo
Message-ID: <CAPhwyn0PAX12E_dmwE9UftcotKT5fyJq4xz5MTWkc7rz-qS-4g@mail.gmail.com>
Subject: Re: [GSoC][PATCH 2/2] t: add test for git refs exists subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 15:51, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Thu, Aug 21, 2025 at 02:22:46PM +0530, Meet Soni wrote:
> > The new `git refs exists` subcommand must have identical behavior to its
> > predecessor, `git show-ref --exists`. To avoid duplicating the entire
> > test suite, refactor the existing tests into a shareable helper script.
> >
> > Extract the tests for the `--exists` flag from `t1403-show-ref.sh` into
> > a new `show-ref-exists-tests.sh` helper. The command under test is
> > parameterized using the `$git_show_ref_exists` variable.
> >
> > Source new helper to both `t1403-show-ref.sh` and the new test file,
>
> s/new/this/, otherwise this reads grammatically wrong to me.
>
> >  test_done
> > diff --git a/t/t1462-refs-exists.sh b/t/t1462-refs-exists.sh
> > new file mode 100755
> > index 0000000000..c00d76cc9e
> > --- /dev/null
> > +++ b/t/t1462-refs-exists.sh
> > @@ -0,0 +1,22 @@
> > +#!/bin/sh
> > +
> > +test_description='refs exists'
> > +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> > +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +
> > +. ./test-lib.sh
> > +
> > +git_show_ref_exists='git refs exists'
> > +
> > +test_expect_success setup '
> > +     test_commit --annotate A &&
> > +     git checkout -b side &&
> > +     test_commit --annotate B &&
> > +     git checkout main &&
> > +     test_commit C &&
> > +     git branch B A^0
> > +'
>
> It's a bit weird that this setup needs to be replicated. I guess it
> comes from the fact that t1403 also has a bunch of other tests for
> git-show-ref(1) that are irrelevant to existence checks.
>
> How about we instead split out the existence-checks in t1403 into a
> separate test suite first and then pull out the whole logic from it in a
> subsequent commit so that we can also share the setup?
>
Thanks for the review. You're right, splitting the test commit into two is
cleaner. I'll make that change and send out a v2 shortly.

> Patrick

Thanks,
Meet.
