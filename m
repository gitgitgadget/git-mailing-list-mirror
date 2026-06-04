Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E913DE446
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561670; cv=pass; b=IdZ3XZu+f89uJcEKaU0n+HaTQoqMKOA50OLur7KIa+qEJVXrYqy9UXKGEqIFHBe8viP8b0uz+Qq6+0a0t+82rz7HiUjvccr2IC9U3TjDcw4rWzhp59YVx5pRbkSHBD6GsVZo4dbJGXSM9ah8dFe8bqBE78fC4tAK3RMT8Btxn00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561670; c=relaxed/simple;
	bh=69oPKRBnmddXJJYjTh4yCO5g7bg0E3S+qF1gQ5Gd5Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hhpyn4/M/ywWFGVhkgm4lntzQIRc0cbTI77QUX0+svKQ6Hls+WgJ1PT1YcHL7Ibo8GpbwJ/WC524d8vG31RygxijIxSIorCEmYeaaX6+IoAIK+Tv3IUQifTePsFx8qLj5ezU9gnLJRFmHS27Aa0GeIKGaojxk8cSIjBLLlWE8Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwfnsaov; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwfnsaov"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-137dd4cc208so236511c88.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 01:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780561669; cv=none;
        d=google.com; s=arc-20240605;
        b=cWEqdYx9Fc2HmZhSXshXGHOxWPm4WMEmP3gr8Y8Y5B5BkP96vdSecPlxh9a0CjCx16
         +9GGE7TtikDjmszJ0EFVZT/6stYMaiEUzqIqduirGx3RFFYGY9qXNN4HvNPsQKLWVTgc
         g4vBXm68jG8GJcDBXnw8c1ZWmXU6LoF80kc/LVvgLCR2h152CJ5hqKoIcQiihbQ1T+oI
         HfbEx25ea4YAHa2r58JUutidsaaInQZHKMfBKMhJjddcT6j3iIeIfBn3nHeMxRVLmXIy
         j0is+Cbo63Qltd/GP1R4bu5+wc5Y0Xqq6GAs9RyEaGEeDjLNyLnMdc1U8xeYCnwCxGoY
         D7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ArfaDLABoeh3XArIx91cqBERKz2uxE7+55UhWN8YYok=;
        fh=Y/d59sITq5949WwvU3zYdo8lHPNrZ3W0dZRkIOr+ZHY=;
        b=iOcGf0qa5CNV0s01H7YzlP/ZrKglvYxo7+dSA9EC5gha8OpeigFaJW1X1z+DRh2zq3
         dv0WLLxs5bEWhbSH4D0AezHMmBrw5fT40bJCMzZwjJVVYhOuVuH+Xjn3BHXONCzy9jHO
         eEHo/3R+ePRewmP/1/pslvptIcGQIW+Een09/gPSF/VATjwIjzGYL6s3Y3dPuEa82Q/w
         VUpgunCp5XpMqE/XuV0sgWGgzIpmU7BE49Q24dAzNfeZ9weXVoSeDJEc++6PkjBMO+/K
         o6nFRmBpKZ4093rAZY0HQoIo9q1vtQFwBEshz8fzCp7qxpjrBQdy97AWTjZzBQ4vroMS
         ul0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780561669; x=1781166469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArfaDLABoeh3XArIx91cqBERKz2uxE7+55UhWN8YYok=;
        b=lwfnsaovaX4/3pgdpbfw1WpcPwzWC8bc5qX3UGq5zOV5Q9IaxjwQtbA4tt3HSxRkCd
         YNKzCjmfXf5kWjV0s+aJ1IN0359Fsz51T9WWJeCrL7IcYljLqxXqQMMfR6RByxHebtjx
         Cx3KLammmt5c4hc2MdBgDQpDP9sVjLaV4f8bnTLA/QJb3hYhv8jzZmFVMBpH0qmivOVn
         EsVvZ/3/Jz1mESB6cgZqgs8svApZURNfEGB3YlQkn4vKreclSt53nObAgKKgkRl8ec38
         PJxRvC+a0/1DhRat8j1Zjy2/FkE/2gwmXUTzj1/kpA989MxImDhrucZT8ypPcAAwiJGK
         8IuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780561669; x=1781166469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ArfaDLABoeh3XArIx91cqBERKz2uxE7+55UhWN8YYok=;
        b=CsV/qH2pSINi1Ds91o5+MxUqh3uEKn2VI+NNFC6t2GRieaPX1ZeFmMFWcTSxo47+Kd
         hHO/W/rRRu/zENmrOLEafS1lYvgzPbHDKjb6w4rKbZ6EHuL3bfFH3RkJfo8Olr3LVwfm
         Ue0Oyle6Tybz/ii6J019KZIcaUbSEekbJF8BxiF98w8Zs/nsD0kDfx1+Iu+paXZSqQ6h
         Zp0skKIOmnIvJW0iM2KpMXGue3JHd1Na1n4KqMM05GZfL9/fCvGcgFwS78r+ful6moWJ
         X/NbQArrq08C8F/EZZmlHwVwaFlDBGVNNTmorD/KplhjsAvGEI8oEJ6otdB7MUEeUztm
         7ltA==
X-Gm-Message-State: AOJu0YxEP8D7Uzmoi/AcMaFvJZBTidqPi9OoxWLLv2URTJScsVn6upI2
	EXND5G6t0+OxbSmZV1KtBPJTtzXMoHqnmLeNazVV9uqNvYLjXY+aJlfqnR+Gs87jXx9SzDPMaKH
	5rnbhkGvXHPHPdiklx9SbLIOEREMcQeA=
X-Gm-Gg: Acq92OH8lczc7c7PRkKBoSCJ6wF1vRMKNk9zlpz95GAU4Hb5+LFi32InTYHaZkT6OR8
	3IREeCxmokLEiNYa4lkwt2Esxz5ZAnvzkU2Kn1/MNICeAdwjSzUJBqwCoD9TpxTOP+WGroO4wrj
	NFQxpCz6GjktLVE1N73dkKtpwMuL9VtEheSwFl5m+rBhpTAxFldjpJdORxr9ZKUnaxn9ET1KSSj
	OC53fgBQNQf2hbqu1I7oRHZVz9hyEaDoDZRkz1pahkcjGoFHapsFu4xZwUEGB7NWW2i3P02Hg+n
	/2X1oi48mRqCoY4LlXyWJrjWr0OvkBC9AcYnMgqJXxQ0xoTcY8R1ON5Yjk5VAMmgLwZf0ZkMmHV
	hlLU=
X-Received: by 2002:a05:7022:e0f:b0:137:fc2b:1ec4 with SMTP id
 a92af1059eb24-137fdedb4camr1238543c88.3.1780561668613; Thu, 04 Jun 2026
 01:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603111044.39116-1-r.siddharth.shrimali@gmail.com> <20260603111044.39116-3-r.siddharth.shrimali@gmail.com>
In-Reply-To: <20260603111044.39116-3-r.siddharth.shrimali@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 4 Jun 2026 10:27:35 +0200
X-Gm-Features: AVHnY4Kvm4MdhYgmrisW_5UDPK8gkQ0DxR9xicCfVih0BVRL7x6sND0lunJQuaY
Message-ID: <CAP8UFD2A6GGwt0=NQQu9oUM2fz+dQzRkB8oHNwE-PJsFdh9wsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/add: use die_for_required_opt() helper
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, toon@iotcl.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 1:11=E2=80=AFPM Siddharth Shrimali
<r.siddharth.shrimali@gmail.com> wrote:
>
> Clean up manual option dependency checks by replacing explicit conditiona=
l
> blocks with the newly introduced die_for_required_opt() helper function.
>
> Specifically, simplify the prerequisite check logic for both
> '--ignore-missing' (which requires '--dry-run') and '--pathspec-file-nul'
> (which requires '--pathspec-from-file').

It's a good idea to use the new helper function for
'--pathspec-file-nul' requiring '--pathspec-from-file' because it
looks like this is tested a lot already:

$ git grep requires | grep 'the option'
t2026-checkout-pathspec-file.sh:    test_grep -e "the option
.--pathspec-file-nul. requires .--pathspec-from-file." err
t2072-restore-pathspec-file.sh:    test_grep -e "the option
.--pathspec-file-nul. requires .--pathspec-from-file." err &&
t3601-rm-pathspec-file.sh:    test_grep -e "the option
.--pathspec-file-nul. requires .--pathspec-from-file." err &&
t3704-add-pathspec-file.sh:    test_grep -e "the option
.--pathspec-file-nul. requires .--pathspec-from-file." err &&
t3909-stash-pathspec-file.sh:    test_grep -e "the option
.--pathspec-file-nul. requires .--pathspec-from-file." err
t7107-reset-pathspec-file.sh:    test_grep -e "the option
.--pathspec-file-nul. requires .--pathspec-from-file." err &&
t7526-commit-pathspec-file.sh:    test_grep -e "the option
.--pathspec-file-nul. requires .--pathspec-from-file." err &&

You could mention this in the commit message.

Also it might be worth squashing this patch into the previous one.

Thanks.
