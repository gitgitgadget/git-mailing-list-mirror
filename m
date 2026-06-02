Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5295436A34F
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440069; cv=pass; b=Y5YtX9FkeceCQM1BLPMyTOg+Is/kXH1QEYrOkz1nSEW3I6nYUjvcvMMYc4v3InP80exhGrLv2/8OQc0EwZvWhX+nokaP0AxlQ1uD7Wq0PpqfRE2rpthA67UaCWWOEMAjC8l9+I9Li0ZzX3fFDu95kgkmyHiNiEJm+kvrWi0mVQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440069; c=relaxed/simple;
	bh=CkB0R9jRy/l8UlzqR1BCuAWoEEZuv+UdLBT+ut19bhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlfwQgvQJZsDRmX4UkpEvXUGdtdzXOxsZNzkzPBLrsjifjFUN6K6OtlnRNLbp5e9prROYLwkExYA1mbJCg8cjUBkFrVSm8TC0DgoygOQjQtBP20b5nlFNGRCQvIt5pKNmsyom95PltIuIJMRwTGuHyRwWtn0aWS/qxGzizor+j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=kIEVW+lF; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="kIEVW+lF"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7dd3f176f84so64674507b3.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 15:41:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780440066; cv=none;
        d=google.com; s=arc-20240605;
        b=OU37/vVXki38FXXH2l0/5XMoCOIAn/rIQQjZEPSscpow9HYD7EDClTQH7YWTCiShgL
         2IH9RrzOTGWzXexOzjAntsTFGz19qsBWV8YundV74DEZK6spE+oerZi3XHBf0msph0Ey
         +Pz51T4JFacmlZo+cDPqBIFrdXSZzq3Re3c15HQEPodMU4WRNJM98YMUyj6TThd9NqeV
         j4GunMVMYNXnsbeMXo0g5if25V4xPkabFCq/AsoSyYfot97a02rWEQ6UjXrIFKoTxadv
         D4nFzeYa7xpcWCRQH96jOq8v46JN2xkorHEWYEApzvWw62225BPCUelQt5xTTTJ+YT8u
         L1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IldYUj01AFaMMh5ztFkqHQrub9ZrObm+YgH3dwisz3M=;
        fh=7RTGiOwoW5V8op/YPgdCvVaFX9YK9sELIp5UquRmV6E=;
        b=lZgrFUoam1prTpOBE4i5Vk3SljfXy9XcyHdN7wSFnUZDNKR/L2IdS+kO+MmwL0H1Q4
         Ztjlhw+6Ct4LA+8pj8jL94G/xlDz6JX7GfGDvR+BTJf55+bGvA60ZaUXEJ21F0FfLq9O
         jg1dypcN+NXChVWjui1doJI4WN8bEcjO/FB15GXuUcHziVUB22lupFRwwe+5STSF75/I
         wZCcYaGcgecXwSVfvwWyCWXh0x5N0fUWbUc1hOpZRfpDw6QL+5BxGiZs+2MHtSOfvO5t
         FAv2yGV1TvKfaRY9ARzD1979B/yiCvPFiZBKMcvGfXZBSlHOScswZFhINtdUdw3n2B3g
         QDeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1780440066; x=1781044866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IldYUj01AFaMMh5ztFkqHQrub9ZrObm+YgH3dwisz3M=;
        b=kIEVW+lFizUrEnaP2sEHB004l5dYwxkHocseEnh/E+H01H+ZFFVrKqE9xfoXrJTmb+
         HXyIDbRgchTx55A4vUE8iMxwht6C57nOhJT+JansMMQEulT33cBEFxcCNBDNwbUS+hHG
         DM+d77rPobSMGpK4EyEFMd1fIDJjmfwdcdn0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440066; x=1781044866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IldYUj01AFaMMh5ztFkqHQrub9ZrObm+YgH3dwisz3M=;
        b=R8JaUDL2a71wjZsExv/e8AFj6VgCAK9y1kouwlhbGtvAc0DpmOpfVP6GoDbDKCdjqv
         RuD+2Oz0IXc1hG2ao9HsiDxCwDU1IArqARRKwhtbp44murqqEAoH+Ar11SveTgk0Jpeq
         SLvQJ+zNR0ph9b8oPO2Kunm4ysq9fV3zovvn7ctpMel6eEnHgKQNo6gXUCmZ6LsdhdHC
         ZtXFlua238gaRSxcA11GDBRYGvfuuxlNfEBqLS1Bcfq/6vthwXIKKcT4CQt33d/qSqgp
         aplznG+T1cFglMKftB1IviUV2fzwlmPmTJwtXhKb/FyUDVgKGAD6LLkfNJW8oYi8s0mJ
         Mgiw==
X-Forwarded-Encrypted: i=1; AFNElJ9j+G7JWrwrHCik0FATh+zTmIqV+I+m6wnSz0P8nePcxWyKqYLNHHhiUU0yRJXtbGZvxtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjjAUv6CBshbBo2Jd/+I2TljHMNTPOIX+3tZw0UPiC7YF+x9QN
	inVWy9JeDIQKCGYuNiwSttWsz7HAx+04la6vdTb2QgoVj5O0ZIEnLzBV+lIgSDcyIip1Y5dLZJ4
	QfoxcOA7lWGx6gq7CaUcvpU9+HTuFtVsqIJdeFkFocKz7MUbePBfsOf5fcg==
X-Gm-Gg: Acq92OHTAms4sx4VuOPA/X27QtTighRPoDBR8cV0mw24h13ldNJPCLsyI5b9nb7yvCF
	6a+wKAUoYh0hl7wYfdovzi148j4b9R1j7TwYKsU+W4NZbDj4/Pv7XgNYN5N3rQC/owv5cjYsBXv
	ufIEL3kgp817gfS2CH2ZGWOI72SuLnwWrpAJmlUzoXtC+VVya0JtBXaQPTgVOZ6yf/cK3dZzh2U
	0u1rSv7eMJZ4on33LfZ1EW+J7a7xsekleUKwsXub6hRxFXleA15gJL3ZfWkyNZor9vfK8GhsXF+
	EAeTdAYmvvJXD7bNEG1NpzJXROo=
X-Received: by 2002:a05:690c:3349:b0:7cf:f14e:bf5a with SMTP id
 00721157ae682-7ea483ce278mr9226227b3.20.1780440066306; Tue, 02 Jun 2026
 15:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
 <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com> <90270818-c52b-4611-8da2-6cee20628fc2@web.de>
In-Reply-To: <90270818-c52b-4611-8da2-6cee20628fc2@web.de>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 3 Jun 2026 00:40:55 +0200
X-Gm-Features: AVHnY4L8vpr2EJTMqyB1OKhIi3-18jiCMHMm8ATqJ9C7i9j_dGhC4NRMRzgCBME
Message-ID: <CAL71e4Ob-B5MJ5DPY+_tzpj6nyrbQ5WutxED2T93SWJV6kJGPA@mail.gmail.com>
Subject: Re: [PATCH v2] prio-queue: use cascade-down for faster extract-min
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Jun 2026 at 18:37, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Would you be interested in benchmarking the following patch for making
> prio_queue_replace() unnecessary by doing its optimization
> automatically?  I get a 1% performance hit for the describe command
> that I can't explain.  And it leaves the heap unbalanced after a
> prio_queue_get(), which complicates things, so I found it lacking.
> But I wonder how it stacks up against your cascade approach for your
> use case and if there's anything to salvage.
>
> Ren=C3=A9

Thank you for the detailed feedback and the patch! It was very
helpful to have a concrete alternative to compare against.

I spent some time benchmarking the different approaches on a
large monorepo with a wide DAG.

All measurements include the nonstale O(1) tracking from my other
series as a common base, since that dominates the merge-base path.

The approaches I compared:

  1. cascade-only: the sift_up_rebalance from this patch (v2)
  2. rene-lazy: your deferred sift_down_root patch
  3. cascade+lazy: cascade for unfused gets, lazy fusion for
     get+put pairs

Results (10 runs, 1 warmup, CPU pinned to performance):

  merge-base --all master master~1000 (~4s workload):

    cascade-only   4.18s (median)
    rene-lazy      4.25s
    cascade+lazy   4.24s

  rev-list --count master~1000..master (~3.8s workload):

    cascade-only   3.86s
    rene-lazy      3.75s
    cascade+lazy   3.74s

The lazy approaches show a small win on rev-list (~3%) where get+put
pairs are common in limit_list. On merge-base --all, everything is
within noise, the prio_queue is a small fraction of total runtime
there. Combining cascade with lazy fusion didn't produce additional
gains beyond what each gives individually.

Looking at your patch, I think the deferred sift-down logic is
essentially the same optimization as the lazy_queue wrapper you
wrote for describe.c - both defer the work from get and fuse it
with a following put. So I'd be hesitant to add a second form of
that deferral directly into prio_queue when lazy_queue already
"owns" that responsibility as a wrapper.

That said, I think it would make sense to fold lazy_queue entirely
into prio_queue. It's an optimization that never hurts as far as I can
tell, and it would simplify several callers. pop_most_recent_commit
and show-branch both independently re-implement the same
peek+replace pattern that lazy_queue formalizes. Making it automatic
in prio_queue would clean up all of them.

I have a local branch exploring that direction. Maybe it makes more
sense to do the lazy_queue fold first, and then see if the cascade
change is still worth adding on top?

Either way, I think the two directions are complementary - cascade
reduces comparisons per sift, while lazy fusion can eliminate full
rebalance cycles.

I'm on a company offsite now so I may be slow to answer, but I will
definitely resume this when I get back home.

- Kristofer
