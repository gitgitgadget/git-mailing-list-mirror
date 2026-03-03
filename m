Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6979A358D00
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557654; cv=pass; b=KQY22YVdmnnQ4imI/nQBJ61oGQd9D54nhDR51poARjAfHdQhLN1sIP66bdWL1pIvmYoNRjYLXP3zHz+dpHGd4PuBSZdueZvy7i8JOrKc/hXLh2Nq5Z6RDa0ZQJcEWcC7gbXwBu2QM1tmJTBXP7Q+07HzlSMSOl0X1+faeaFbZgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557654; c=relaxed/simple;
	bh=i2urB7k3z0juvoxha2sXTxvXo5wq9sS/Or8Tu/ZllS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWV/Sg2J46VAFPQPTTpH2SPHmmyqWWWUK4j4e/SQrPz2qXmD587fjUx/BZIel3KiJJGUEIPbNIfR2kDxi0vUd1rpLmB1ETb5JmAQnZNLsF7qHtsi1V0WnE/Win5ZvM4AhvaaXdJYm0kAiHB8AIwzfvSmGC0cWwd0Eaze7LXzMZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1bugc7h; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1bugc7h"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7987531082aso56884297b3.3
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 09:07:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772557652; cv=none;
        d=google.com; s=arc-20240605;
        b=BSX3u03L/U4KQDEIoudqH4gSaYMu5ryuTwW2H83R4TG350FnUuUM1Jejfy+9gHYmw9
         J/oE0MNf2Gusrs2CuhXM0cD3Scz1p+AJdTeJS+oQnVannz32mGuKHnwJWKcLRjddA18q
         BJLxxEp+gH+KQrf/kaHVtXo8/xtDKgUHqlv0CRqQdZb5VU440aKO1OwwwdyA0ARl7LyV
         qW7uGgJvJzv2UwntEVUV5lA8xXJOB6L8j0X/hEKcOTvDNUhLTRmsrlWlb45z9edfRQP4
         kHLlemVFVns+HR9vV8IHreUWr8WAmkkihxPjJuBlhawxEyh48Fna0wgjfsCaJezeUG+P
         An8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ltUC160UBPR+84SwhkdswE5Xt7wX/fH3I7Xn4g41vKQ=;
        fh=4YFVeLm/heYb+JoCNJvZZfhh5UsF4v2f6VHePEKeFjo=;
        b=C7IeCl6Mt4Z/ENAVrrIYgZ6JF6Aa9hjMj6QvlFWCgdStV9YMcxjNwtJPnQoQwuZvON
         XvIrxEn5eTAIiFD2FPmwp9C8sie/ADD8aVwzsM95IYaXYmv+eoC5NUrBeuLlzFv/FkNE
         LpraeTT5Rqf20NykPiJzh1hvRsJ80lQX0BperFGuqufBZc3JD6UhROJ/JBbFLyl/C9dI
         Nyzeh2mJWRxS6cmkQEb3Imn7/VHDkMU5HK2vQ4OREyQoXRKWLw1BytdYEQ6ygKF9N9DF
         tMDwXAk9zTFaEINVDRuawe6JjnTOx+NoEC/pjO2s9Q/kHRSmW1fIvpMu7iJ/gN3j6CTb
         x5YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772557652; x=1773162452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltUC160UBPR+84SwhkdswE5Xt7wX/fH3I7Xn4g41vKQ=;
        b=T1bugc7htpcbSKC6YwTb4pKGTcgEmMxPo6Ysb8gMy1UmByGxBMKBP7f+1ZOVfMxt4T
         V6uEQkMbRsPbzfzlZWncxWIop3uQycENI1JeoEdamVvpdn3GRUFNB7+v5faScPQ45/yz
         gy3YfMkJP7/eX87RJdBdNwYNxxbxAURUlH4DUzeIZmLirG83M8X6RNYkvZzg98W/vHO3
         nSFuxP3W1amBdEgYySck24wtM1iC3H8bC/L06PNJdsCpO1fGOEOLZyK/ofONA32ppfRx
         Dlnn+Ib6YGBa5koXNq/Sqn/UBI4CZ7Ya1pZ7XLYP3U8jfaup/c4b9X7n9cBH+zb3J9sT
         W0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772557652; x=1773162452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ltUC160UBPR+84SwhkdswE5Xt7wX/fH3I7Xn4g41vKQ=;
        b=lUbWpngyKApyX36AmA2PdSTrbc+5XHUzXmtMvlE6rt5ygDo0s6BlcW2kSX8k9LCQIs
         9DuW0yCyyUjmlGpnmyKyQviXi5lw52IPDl183WO7aGPiNcLzp1PV/lVLSW/LNW1mLwej
         dKdVEj/Mn98EbTQrqVZV8tBTxcslltKJWSNd8MWqKVxGIYaPFZUVCRfq2inBlZmyQnRU
         7OilM9GcV2zoHuFd0a230rydm6nkopvJZAYodgwzh3M3buYUvu3HvDdV0ES7sJe4pbrj
         Lqf3XTT8JMSEVLiLoDWtuW4gGBGkJgmIm9agC+WPYPRxaiq5MQzpJ3rKD1LuIFc/vnrR
         QsfA==
X-Forwarded-Encrypted: i=1; AJvYcCX8yc2XUPNRiPOwSttIBSxwGxHLxGMLPsNNTnKNgs0g2Vkz0wwiRxr0eQC+v6TMQ016qss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjNwaOpW6+JJv6xIBQBcjZ2odefRSUXw5FezKvtnNu6fxV10ac
	zZOS5+GLESLNyRfF3/6OS+/zQJJfAMKDawS4UKrdvrknZgrNDMhh9hv75y0pZXrphzkIt1sHZ9M
	OQ30b/UTrioKStUYk9RGLEeswatW+XXA=
X-Gm-Gg: ATEYQzwUK6ixbHC5CB40Y8yDm058HOqTHUplBiYAfRsM/te9qRg38U8vfRXYhbgC5pt
	6ZkHLNTe+pFmA7cKDhRLZ2Hu7Ib0mj52qA7ydlB/XW/nShXfLgZin3FncG2yl+haOOEDdMc+Mgd
	kw2OlWonqwlvNjVxgXGSBthb91s+iG/DfFr0pqCYRgnyeMJVJMSBTtaUBBhofVINalwyTqksa7Z
	jduAWkYTF/WPzCe7Q4YT3JVIDWqvFB7HpI5I6/SObXmIRDCowRwvbnTdcbjbNQe3FK+zRhR5sFb
	Zn5t
X-Received: by 2002:a05:690c:6d03:b0:794:ecaf:c4b1 with SMTP id
 00721157ae682-7988550a903mr156159587b3.25.1772557652161; Tue, 03 Mar 2026
 09:07:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2220.git.git.1772479907062.gitgitgadget@gmail.com> <xmqqqzq1x2lp.fsf@gitster.g>
In-Reply-To: <xmqqqzq1x2lp.fsf@gitster.g>
From: Omri Sarig <omri.sarig13@gmail.com>
Date: Tue, 3 Mar 2026 18:07:20 +0100
X-Gm-Features: AaiRm51TuM2QwpIBTneDPCwSFqoYnGYIA29edfXWrtlSrJc1tbBxjf2xGCrgUYc
Message-ID: <CAP9es6vwDccuY_NC+q=ua7u-cwORV4-eLhPf3dPDrBf+JkAT0Q@mail.gmail.com>
Subject: Re: [PATCH] doc: add information regarding external commands
To: Junio C Hamano <gitster@pobox.com>
Cc: Omri Sarig via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the reply and review - a fixed patch V2 is incoming shortly.

On Mon, Mar 2, 2026 at 11:56=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Omri Sarig via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Omri Sarig <omri.sarig13@gmail.com>
> >
> > Git supports running external commands in the user's PATH as if they
> > were built-in commands (see execv_dashed_external in git.c).
>
> Correct.
>
> > This feature was not documented in any of Git's user-facing
> > documentation.
>
> "Not documented in any" is a slight exaggeration.  See "git help
> git" and look at description of "--list-cmds" option; "all commands
> in $PATH that have git- prefix" is mentioned there.  Also "git help
> help" talks about "--no-external-commands" that excludes "git-*"
> commands found on $PATH from the listing, which implies these things
> count as available commands.
>
> Nevertheless, it is a good idea to make it more discoverable.
>
> > This commit adds a short documentation of this feature, making it easie=
r
> > for users to discover and use.
>
> I would have expected that under Environment Variables > System,
> next to HOME, we would add an entry for PATH that says something
> like:
>
>     When a user runs 'git <command>' that is not part of the core
>     Git programs (installed in GIT_EXEC_PATH), 'git-<command>' that
>     is runnable by the user in a directory on `$PATH` is invoked.
>
>
> or something like that; I didn't expect us to add a dedicated
> separate section for it.

I've added this now as you suggest. I made it slightly more verbose (adding
information about the arguments for the commands, and about it taking
precedence over aliases). If you want it to be shorter again, let me know a=
nd
I'll remove this information.

>
> Thanks.
>

With Kind Regards,
Omri
