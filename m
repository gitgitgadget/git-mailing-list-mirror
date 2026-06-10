Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E783FE671
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097614; cv=pass; b=Crb6ydRnDeuFa7+PC2htQlOyPfbhIdYHySPmaCsdAs+uGupzy7j/Kf5CVRSgUc9BTTYTd3tgHcA4Hcogfj4zhxTC7TBUfX9BLGmynRFRASk5Z2nSbHEJ5ezv+lmGny99lm3DV9dBzedFPcDNA2pALIT72Rgxf0VIvwiYNSdqgKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097614; c=relaxed/simple;
	bh=oX2j73uvymz97G0cwlAbo6Fm4A/sh0uPHoqv0axBVXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6luOtJ+D0pKo7nljSEvblLDd0uewOy9XFW2Ve3gC2o6VwUeGikoOQjQjZBpzgD0QpncKdx8n8llqmCcf/IHgGrNdEzTEYGGl9NH2llnAwqi3VjMrykwdLYeLdJBSziRUQEPb1yM/3TyvTCL9c09nwpFxuecD2r9bpoZjyQd8gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JywOiIa+; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JywOiIa+"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69165354c87so5165239a12.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 06:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781097611; cv=none;
        d=google.com; s=arc-20240605;
        b=TBqFHuMC+V8hr8jWGLi3r8jcibAuc5bSZai0axgvAdT2w8FkHwjrdOyPEKJrfq/P3U
         c+Fzl5quMlA3cbdSfl2WkEIhCvtcUFjxB8c/6f4FvZS+P3DX2w3fo3maO3xYAcSBTQiT
         GsmalypYhRHqM2ZK8kUWfuqWdTgz40Y9JoF39EA5rmxMfsn57kawUS71dDDIYnfXa9m8
         Q/+zmduD4tYVXq5eKoSkppWWC+C7y0LQYQbWGlnL4bCm2fDTTFKaHS4nU4GEQGZB/33j
         qpJlZPkYKmCemXEPu8giuO8G/sCMfdGwuXxLvRWZLfPlLPbb6DS9nLh6XDu+fLrzB+Xj
         CV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oX2j73uvymz97G0cwlAbo6Fm4A/sh0uPHoqv0axBVXw=;
        fh=mZixHP2Ewss2SFJr0NJjUylVjNy0qV/BrWHw1aJTsFw=;
        b=F3kc1bPYmcLBuC5E7V/EMavq+L4DpV+M3kh12EjRajhaVdAAS+z3HdsBfI14U2VA2X
         z6bgLsVWWUslm6X/E8WbFhMXVfvtKmXEErHX8tmQJG1KN1qCfoeyWDu31JOFSy+JjQUZ
         czg2q9cpJTVN1Q60Xfxc3Y0RxBq3MoVHLpIZkIHFDbmgYtvpIZ1/9GTBJkS1yyQOiKy0
         dXpj3/H8Bx9xOuVWA4Jq5VzIsHKzUe+1skmxKxxfdsIYnI8a6BQwM7osGRTACVKbWFg2
         ZZ/sPGgI4kGjYbHlhrzg1d+UDRT8Sg1irv/1VbwEuUSj2mju18VtOytGSLE6fdvCKCd+
         kz4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781097611; x=1781702411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oX2j73uvymz97G0cwlAbo6Fm4A/sh0uPHoqv0axBVXw=;
        b=JywOiIa+wTvIxKw5/2BxzZjZp5clRd7eit0QPwo1N1b5rk9UJHkBvU8+93n2rFyhk3
         9v4RMK6lN0aaHoeMCWc/g6EoozNND9Kzv7k6xyWJxNjNGWnX7SKD97exTjod1OzHRkFY
         dxI9mGPnBwa0C/XyxtBZqChPnfl68tLzLXM37JPMirLj37Jaxvp7mohrzuii7rqsd/O2
         NTynFTJuiQMVK53cuWMN/bVmW0vX1SrqR+c5EBUgBTnIsM4146AYm3awagykRyE5LDuW
         NlHYSiFtmuQsPJQDWwnN7IWlYI0iaU9iW5opOe7NMUgQz6X0r5kQtOjUphnuhzZMs6Bi
         SUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781097611; x=1781702411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oX2j73uvymz97G0cwlAbo6Fm4A/sh0uPHoqv0axBVXw=;
        b=lJRSypBv9WG3zkmwID6ichmmZsYSLC/0PpMcHb5GA6ICu1/+i/xkSbw6Whk1gvQm/S
         vnSJJAE4kcg23H4gKoZdFyzWM9H7J7ECQ4doViYzgpLIyGn74xWrReBc+LsUuVQl6Iyb
         F0NJteQRm4j4BGjMayTZlxgwXJjIXPpibmYr32SOT3GIdsaCKcR7sEa5NToHMJw19yHT
         uYzVGF3aDHu2H58FzWSvsedNxGnKGACBqMQzhrFpzVolGOXWpkqNkMg3z3s1UjlEzws4
         E++Td0Z/xkeRWS1gGwJ5e9hotM8fFOygJNd60SOBYlhxOrjAC8i8j+RJxCbSycAwl86P
         8QVA==
X-Gm-Message-State: AOJu0YwXsclc7d+TSgwWYhAl8Jsjjt3zJxbzh+3/chvihrmYxFzMFkkG
	Njq6fsFUjg8fTU+NGQXIc3ZLvcpro2ISm4rOY/H7hr0MSTwt+q9CmKqCExFjKq2ttBlt2iFu7c5
	yv89iFNdrqbllsT9hjX8uLBRjgRsduHU=
X-Gm-Gg: Acq92OElsCvbja7iGApWNoH73u3ovPBc0RT0bZZF9W0AGxmfINbiSe4rYsYBkWyvlLt
	tHPpeiw1pCnijXROariAbYcYmafvHqKR7f00+HPR9yUT+3sCAqz9Fv9vIfIw8QTpgyL6vphN4ng
	43MdfO4Y3xeVfcON4qavm4jVfNik03kSbdeLmaqu32l9Qj93t5Ks+8vxROCp7XXNxp9YGUcNwuE
	3jinxvCxmdVDcRB6QYoEzn0cH84ogdpWGVtnjlgq2kCFfpXprmGSnMUHhBpLgyikMN0atUhiUa6
	NiZ1ot4O9sfUSSHIHg==
X-Received: by 2002:a05:6402:40d0:b0:691:956a:cf6a with SMTP id
 4fb4d7f45d1cf-691956ad26amr8660637a12.12.1781097610780; Wed, 10 Jun 2026
 06:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2318.v3.git.git.1780555730228.gitgitgadget@gmail.com>
 <pull.2318.v4.git.git.1780742303298.gitgitgadget@gmail.com> <950f70ea-1615-402f-9cd4-3317bf177c5c@kdbg.org>
In-Reply-To: <950f70ea-1615-402f-9cd4-3317bf177c5c@kdbg.org>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 10 Jun 2026 15:19:34 +0200
X-Gm-Features: AVVi8CeY2w0HHgiZH8mEA4Yjq8GboLX1sbqIF8bPFWrqHQYN5CJE6WpEtvgPEZ0
Message-ID: <CAHwyqnUpiWmXo0SVr=7L-+cwA+qhVyqodpV-O4C46w=kLqaLMg@mail.gmail.com>
Subject: Re: [PATCH v4] git-gui: silence install recipes under "make -s"
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 1:47=E2=80=AFPM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Thanks, queued.
>
> -- Hannes
>

Hi!

Thanks for the help!

What does it mean for it to be queued here, should I expect it to show
up on seen or next?


Harald
