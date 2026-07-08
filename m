Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9438B140
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511167; cv=pass; b=PhqGTgM1HB9JXPdJm40aRTFunSRQd4U4FXuc472KXypAtwipQdH4tULzAtQTRh5xDPqQnSLAjyR3Yt3jWtkjkQSbR4nKfq1l0Rr7O0Fan19CqZmwS+1d7LxcqEhAZ8O9KInLXIrEIiBkebWbea9KUCTAIle8qfSrR3rosJRtQ20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511167; c=relaxed/simple;
	bh=jziAoF+p98LIHX+1C1Wtkg3gQ56qVMSux5GpcLriO1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtBInvcWgzgmAp2KsJWUBZlamoVHBGifyPpwK4BZZlvB0D93/ROoH3vaQDdW1soyXiE/vim+YEvJuosvgajtsoZ/A1OfXO/S5CwDp1wWdHIHxX4bpejEjBXIr6Us6UkRi9WhBdWdwWSGFaZTzfuknD9H3vMwJg9OT65WvAONN94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=KhBnX0JK; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="KhBnX0JK"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664d78637f8so781556d50.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 04:46:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783511165; cv=none;
        d=google.com; s=arc-20260327;
        b=chulVBetdRu0zIJoQkvanpwDl5JQhgasBAYnNzeoyhmAtNQ2r3dzp+M4yljQhd+h6o
         zfQbIikIkvln1/5J/xiJo4KKJkqocKazGYlfBcmgDqyaFIc9eUVou370h1Fa3Xyec5Cj
         YVNXvNhF+q2ciCPxKD0MgOBadz7g7K4sm2B7QHX2J9zjSMUe2nbMFF29TFUXAhhY6V/i
         LyZRPoEHEKjgI4SfzbP3L4r2STSjmGOqz9jZNfGMa9IvQ5cxiw4dnTBIMfv0l5uyZxXJ
         P0Hx2IwWnemFl+DBaxD56beewsH3J/tcV2qoeBMdl6EelNzdBE9ZBXMK/3aAPELjusVJ
         Ishg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ICF4rfebBGewdLg4o1wtn/ApyvLEADe0IwpeT/g/PYc=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=f7OwgrFhxAmX0ROpW/zgCgiFOZhVj5voQIxW8jdg9w2Qq6eEf2AV7Tk2ASCOYkRVXW
         ZaByAHICdCtlLhdYl5H4/kPQJtIif7cPoG56QIaZmopRUbXCNzXoWB1Yw5a/7t3xAqNW
         MGdvjLIkDp0Ag3AMJAabQ1dUj3y04d+hDFUDtsDeXiGqHSp+/ia6jCG1WWbfIY1nnzsz
         Coo1CFBfevYXPjJuR9Jn/ost3YzUSQAAiMWB5my8gS6DAoTxjsid8d/vK2celli0aOTt
         tyrsWjdQe6ptmZPTh9VRHhHyoC/l03e0aeSrZR6xaFwtBPLC9g2OC5c9VLjw7V8jN41s
         4Ylw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783511165; x=1784115965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ICF4rfebBGewdLg4o1wtn/ApyvLEADe0IwpeT/g/PYc=;
        b=KhBnX0JKIPnAwjaJlLdxZFcTsBkBY43qR2vonCHbMJ1gXQHWh6eco/GtDjJ22rLgxI
         W4giwZjx4Ag/NLtJLXfsU9OfMav/OPSmGzKgTBQRoyS0wprFFRBZSei9c28BGCDw+fcf
         A3c/FHqxK20fE8ccgCbHSy8GUxmPyZ7rXFh2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783511165; x=1784115965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICF4rfebBGewdLg4o1wtn/ApyvLEADe0IwpeT/g/PYc=;
        b=nPiiFN32sexoZWUwNQvM87RVudjMb+UljPSdxY6Xs6NqJc6y3cn9BfDpjgEIT0qpEP
         T/IpcXN68x+KqO+m2hxcMiVZvofl4VFZH8xR4ZEZFwY0JG7koAAaNoPEZSL1z21b0ZGZ
         1R5wyCMaTAQMyRjvFq8JDJditASpfOfzo8gnNiWyVXsqQp6Fg2HsCxJwg3NLzIBvxDxH
         GNwMMq50lmhH8WBO+tiBBSkXAhJcj+i8XQ0gI4kGXGkiqC1qKRd89mBqyPWQMIUquHEE
         s0QewtoyN8y7uIago11JxymkEPsMbh0FljhiCBhPdVQB95hLsX1QrHX8mic5k+ITU+7Y
         +5cQ==
X-Gm-Message-State: AOJu0Yx9MQm8WzAGKLQdNHL7jPr5vAp2THNmWErCVtRsL06enGLglhuv
	E0WKgLTWwhnMpXpkhQkZ6VFxeTYSedwbNQTJIX3QkrxEt9p29Q6hjC9wopLMAahp7hEwDLfO2Io
	8dPS6yU0xiLZwKfy5FYzbaXr365K42bJuFJnRFYZREuk1w2TFlAgfezaa6Q==
X-Gm-Gg: AfdE7cnOAARBdK6vWyUJd8ObBYE0hMre3tXL1bvO6BBKJY69dl0p3+LZww6/3HP3ZJ+
	DpvnjvTOZnDhhs+ftkwZHP8l38Dk01wW9em0HvQNl7dLYvkl5CK0tkUDhUgGgc4ZC2fzYuENBn8
	Xq1Mp9ftkYsdfnPKieFdfxkLCiyKWyKocqFpXiJRhez2rDltA8a9kzE6+iPlpm8GLzG2EBXvl2U
	aheLCgUIkxSk5oG+QVjzcVjAgCmrNQPdJ8CcV3FgXxzTRCUjCe7Cy60gaS+gAd4ByJmCCeCrA==
X-Received: by 2002:a53:ac88:0:b0:662:c4c4:dabf with SMTP id
 956f58d0204a3-6679f00484dmr1743919d50.16.1783511165108; Wed, 08 Jul 2026
 04:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqeche67lr.fsf@gitster.g>
In-Reply-To: <xmqqeche67lr.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 8 Jul 2026 13:45:54 +0200
X-Gm-Features: AVVi8Cc43vl_UuY9UmA-WlpV1FujX8LKuQKxk3PuvNAeoAIXmHDFjC1t6I-UG24
Message-ID: <CAL71e4MrQ25WJHp-08bTS2=y-gd36zs9CVYmYGeRv-6iCpdfdQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2026, #03)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 at 19:19, Junio C Hamano <gitster@pobox.com> wrote:
>
> * kk/commit-reach-find-all-fix (2026-06-29) 2 commits
>  - commit-reach: guard !FIND_ALL early exit with generation ordering check
>  - t6600: add test for merge-base early exit with clock skew
>
>  The early-exit optimization in 'paint_down_to_common()' has been gated
>  on the queue being generation-ordered, fixing a bug where 'git merge-
>  base' (without '--all') could return incorrect results on repositories
>  with v1 commit graphs and clock skew.
>
>  Comments?
>  cf. <xmqqa4sdw55v.fsf@gitster.g>
>  source: <pull.2162.git.1782739162.gitgitgadget@gmail.com>

[snip]

> * kk/merge-base-exhaustion (2026-07-01) 10 commits
>  . commit-reach: remove commit-date ordering fallback
>  . commit-reach: move min_generation check into paint_queue_get()
>  . commit-reach: terminate merge-base walk when one paint side is exhausted
>  . commit-reach: introduce struct paint_state with per-side counters
>  . t6600: add clock-skew topologies and step counts for edge cases
>  . commit-reach: add trace2 instrumentation to paint_down_to_common()
>  . t6099, t6600: add side-exhaustion regression tests
>  . t6600: add test cases for side-exhaustion edge cases
>  . test-lib-functions: improve diagnostic output for trace2 data assertions
>  . Documentation/technical: add paint-down-to-common doc
>
>  The merge-base computation has been optimized by stopping the walk
>  early when one side's exclusive commits in the queue are exhausted,
>  yielding significant speedups for queries with one-sided histories.
>
>  Expecting a reroll.
>  cf. <CAL71e4PgcZDK-gJziJa_yjEqX9TE+PFMwZn0xbjAUzuUDDDBYA@mail.gmail.com>
>  source: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>

Small note regarding these two - kk/merge-base-exhaustion is
(unfortunately) dependent on kk/commit-reach-find-all-fix
before a reroll.

I tried building v6 of kk/merge-base-exhaustion on top of
kk/commit-reach-find-all-fix but since that one is based
on kk/paint-down-to-common-optim it does not include
the changes from kk/commit-reach-optim which I also depend
on.

I thus think the status of kk/merge-base-exhaustion should
instead be:
"On hold, waiting for kk/commit-reach-find-all-fix to land first."

Alternatively you could rebase kk/commit-reach-find-all-fix
on master (triggers a small conflict though) and that would
also unblock a reroll (but I don't want to generate more work for you).

Thanks,
Kristofer
