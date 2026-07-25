Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED90B3451A6
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785007520; cv=pass; b=uGVh+eu8iGf8JzcIequOsFBHUM90t4N/a+YPlGC0v6jztRAte3Sr+mupfuXhJB7s2q/LWeV8gsbgcus5bszQFuUAVeKsGK3UzuXIa2ZeOSmdXvgYryncVKycK3dmaoHf4rgMpFzlqOIsA7p4GXKOFgusPMEGnFlTAXdtfQlyfe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785007520; c=relaxed/simple;
	bh=ayGzWR8hsk12UYypI42jsNqfnlmq4UuWgMgcmscyIh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8gvydukfd00q+QbLd1AGcMUsbXSaf6tYgiYGZ+BV5/7k/BblQxKt1i2JoTSqSlwKR+zmdK+IgtO+sx7Csureo0Zfe5xrL+8SNiyJD+l24kEqy7kdGx8XdDjPukpcGc6XUEfoWhw0uF2Fo7167NRN9XQnMy3/QwWPxEWcaJoNSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKvb/9ZX; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKvb/9ZX"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7eb61bbeb25so1134942a34.1
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 12:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785007518; cv=none;
        d=google.com; s=arc-20260327;
        b=UWbKxL8uzD1dxiNb04nCTJnhxoKrKR+dQrQYpLERjhCK18h/OQfwh5THjwuX6OAHAl
         3qz9/YhUbPZycik1gIbwhzAiqiX7VeuQ7rz3cA/Le1+p4k0cwkAkt+/WaSBb3vaur5jz
         HqBJT4JXlamrUBMSUKnlOmLyc3iUjZv9qzT1G7YTmszYrO7RKipTf794ivnlXsI7Nauf
         iVmm/ltfCIqTMEU12WF3buyYb1TkUmoriAr6vhB0QQGchZs2RlCNOqiZZk4XjyyLvwk/
         cZbRcoKCuL+czVEmg23ozQ9y6J6cqcJGHHOOIfWsLUUT57Yg8mm3QLSb6IW3x/bxsmQA
         NPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cvEm/AT5wZRkOgBO1+cvW5zrqjaLMs+NkPR5HG+aJs0=;
        fh=ZnxKeEA0LbaAEkwI/YIB2BJGEHnrlTt5pcZpMBmZvOo=;
        b=qyUtKmIb417vuJTkb9SHX60gawhDGG9BZCVJzWjWF5XLhQHCyqwH4iqy+I/JIjjSfB
         UK3Xn6z1cFe/3OttDAvy3AGV+9dkV67GoReT9DHrOuGcH2PSu703Q7/io4taBN+so8aJ
         jLsGn0igdH5rgHmoe0y9fuT+dGq9ZQtYL6Q8EnyzDnNBiAAoszXk82Vwp3lueX5d6+uA
         doAZywuDlGRBpOsMW3mz4ubChuNMW4m3JF650bBclKB6AcNJON3t15bSUc2ehU9wvKrE
         8+WM43+f9d2H8XkWd/yEvk5mqE1I92394h40ik9+eYLneCUZdhuTERBebhdlf4t4KBF0
         ErgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785007518; x=1785612318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cvEm/AT5wZRkOgBO1+cvW5zrqjaLMs+NkPR5HG+aJs0=;
        b=nKvb/9ZXZVlW5kDvZn3UPi1iu6QdsbQmthNprUFmSfx2Icf/Gz8xV8grzieedafoXP
         dil5h8d3D7uMc31ymgkszMRo7j7nvQyU1PTQ7+3pv7XntueghyMpYPmCSWf77hqbpaej
         osJl3NdYhynUDUeqgLySHbJnHc1dfpA24EM68xZdQYfithWPLwKMMjAURFC0ZuQus8ci
         I8ugDu6fv6U9cU5tLB2NzL8AoBzsaNK8aTYAOYZ8EiLs5AKL/jhstVVJuBo4Dzu8hyqc
         IJCVwKcD7sYonaaz/Qh1wTzdu7DS9dwxuDC2noFl9EUqSbL4lvwnhQKVbfk9FBdz4aAI
         h0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785007518; x=1785612318;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cvEm/AT5wZRkOgBO1+cvW5zrqjaLMs+NkPR5HG+aJs0=;
        b=qtOfEMyWagzEvBKire5zfsmdT4NeZjjqyPZt+4ld2edd2iKjeM2SjnYA1Cl9Us7ipm
         pk9JRFFDgcQkzZfN8mWcT2tT64iCdxGsY1HMwHoiC+7N8n3hpXvoPJz/KH2cJ5DjQGgM
         teBjp9aBCKBXyXSyixU/S+NbhR65DBnVBFA5hK8fF2RBudrqFJNIetipsCpgaxoLI7j5
         FFtcyQgAStf4MCcaoMR4ATPfLBjIg+1fYXt5qIrxSFFdADM7ayad4vSPT02JKfu+j4P0
         U0m3sFQbzQUBLdzEqu2yIKX4cO0E5RCyD8UgEZIo4NaQra8Lcb8dtm9UrgW98Si2pi7b
         HQrQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVwyQML7diLA5ff6esM20/30TLzQU1WyRr8IHBQHdk3pzPWdVBYA8W9pP0j9j+cOTLYgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6GbiVl9A/3OXKKnomRc8hyOc6FHGnSPMksDOww4PHUTosqvcf
	C6DGQ30fPqxl1KvEnMYpqZ1iERvqUKTZQnUg4A6TP+V3UGUsMAHx/rcvc7ByOVu0rv+q3iixaH0
	FMTyaNPSZmD5wicobJGn7EuKU3k7FAk8=
X-Gm-Gg: AR+sD10le3QnPl+Rbqe6EtsZUl8C0BYHPTWETJpskNqX+8NhuYiRiu6GudRqMPn+brQ
	94n/8ltxwuPaqxtKX+OIprR9WKZ+4CZCEtsVH5QGbToBPoCrhH/c7ZdAWaagoviAmX+13T9MiFn
	9VGFIidwE1upoT8nNxD8RLyM/wZOcakJ9nC1l8uFzINNfV0wh7JHF3vguBxlxAljmcZpNuOWVoF
	vb1oyeHFvnqTg3wlXextDDPcvEneiSurcZZCZ7jZHQA/CAJ23P1fUpnyYHCTEWIgyibKhKCaHfo
	y3DuPflli6PJp0NOKXeEo9b2C2kXt54id6HmNwooOTgluVyllxKUybuIWxd0nMyvrF1yjEjQb8A
	K2OE=
X-Received: by 2002:a05:6808:4fcb:b0:495:f223:bcdb with SMTP id
 5614622812f47-4ab69c38bfbmr3557455b6e.0.1785007517738; Sat, 25 Jul 2026
 12:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2169.git.1784143793613.gitgitgadget@gmail.com> <xmqqjyqk3w7d.fsf@gitster.g>
In-Reply-To: <xmqqjyqk3w7d.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sat, 25 Jul 2026 12:25:05 -0700
X-Gm-Features: AUfX_myPKG2SLoyk6pZcx-gTY8YtO23X4fYPKul0M1QAbn3DMvlRFZzI7Yz_xpM
Message-ID: <CAC2QwmKP16cyw0get3hEWP8GjcFkUHB3uXxcQi9hBCCM-B+ECw@mail.gmail.com>
Subject: Re: [PATCH] revision: make get_commit_action() a pure predicate
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 2:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Sorry, but I completely lost track and I do not recall suggesting a
> change that amounts to 100+ lines of new lines.  Are we doing any
> code clean-up?  Bugfix?  A new feature?

A latent bug fix, but I understand why this was confusing.

This was the discussion I should have linked to:

https://lore.kernel.org/git/xmqqtsqxfdl4.fsf@gitster.g/.

I had the link in my GGG PR description but accidentally deleted it
without re-adding when I remembered GGG PRs shouldn't use a
description for one commit series.

The linked discussion refers to a new graph feature that invokes
get_commit_action() under the assumption the function will not
modify any commit state. The graph feature in question uses a
configuration that just happens to avoid the branch of
get_commit_action() that modifies a commit's line range state,
so a bug isn't ultimately surfaced in the linked topic feature, but
it remains a potential issue for future callers.

Unfortunately, I couldn't figure out a way to make a test that
validates if the change is effective without creating a bespoke
test-tool that calls the function with the "right" options set.
