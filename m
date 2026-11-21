Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795282090;
	b=tq54KkUmAgJC0oPT9+hXsCATCl7NI4yb7zdSmfR3qLFJRtIwFJMazhFgHJN85ZgzZD1r
	 QYF5AHcfD01hDS2SO5NlcG9NyoYhY7C96BBNLNzsg/kxx3m6D1maqNumG+i0Bu80CbOCu
	 9Wx+Puos8AR8USgxlOUuOHQKp8HxP5yAWhWm7NADQ+x3f4xcrLYNElt+IdQdR8rOr6CbL
	 tee6JZ+kAkCrXmN+T3hSi0NKaubN34C/jYineMUmJoGHqd6wKIJMbITQN7JZwagc+2QaJ
	 Zk49ehxATMCAoBdwTgvVk4eudEi896gLz9U4Z1/8EO9MbMAaTR+wMewVlR/fZLKwVkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=VBJcRHV4/VgxfLthTmZbdWhNh9pwFJjcff5ESPnHVZM=;
	b=Nq/+nNZpEwD+T+dVej2F8FQ6nYQyLikhQBEaY3YLOQfJ0kMF+hbc9piOT+Qr8mJOYHFC
	 DW3plHDVl7ofoc+jUD0y+Q8YSfcy1/sHkkDMmHOj+yGlLLo5u80RVaHlYkfqUs0u4XMIm
	 yzlU6OywUbIYjDaOpIOr+kCX8eKNUr/TOJqHfmowmehdyqhmbE4BuItwuSA4Mw23wjmhT
	 aa0WPvkL/Y9o6B3oB6smB4Ke+F8H102wAqevpzBSkeoeaGqIVeQDQiQsqYHqSXNmESCm/
	 Xui5Z6Ov5aqV+S5T38F+d00iKH9RVDI8OUGWsndN/C0eSup12GnUvtsFnu05AuZx2wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YS77EgV6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65EB606A32A
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 17:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C65EB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YS77EgV6
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b3a914e4c8so1063920a91.0
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 09:28:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795282089; cv=none;
        d=google.com; s=arc-20260327;
        b=DOnnOujC8Q/I76P6Mx5mNSSQofkO/7GsiU+ucQpCzYz+hgBt7SVc7wFLR6YfBaKZb3
         /rRqia+X0tCB86NA2n+9L8oY+rggwOGvzPjYhM0r4ZoyqJmqGyx7o73t9ReqL8/03BVy
         qnPoRBIIqCvpmAupVOk/XtU2SMyNSSqMXp1nh8Ep2TL5Wo+3wmprylqQfoAkYFGm23WP
         ATmnHtJb1wO0nhbpCU3Vo9eHkgGi5hdQdGsS+wvOvwbftTYyolkc5f/axkXgV6cfvaT/
         cXEOwNn8a5aJ5EnSxtVzvEfz8dvHENNrGxtHdB5T6fNITaEU250arbYJJVHGGPSKHQ5x
         tlBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VBJcRHV4/VgxfLthTmZbdWhNh9pwFJjcff5ESPnHVZM=;
        fh=kZvEvI/iErNiVh3Ry7k06uXBc2Epyg5sbSQt12mwY5E=;
        b=R21iBGg6GS86Dwn41P0ACB6iGB95bwR7+HIdmjJc3HSmCCi1IjOc+bz9E5BQkfOEOl
         IIEplN1QjgFl59wxjHT8UuhPZRf/cWGNu5v5RWvtBj/yo95Qb5O+xFivWJ5wRyg/3lKz
         BubdvvCH2MK1IrXtD+XgOKXXnvLjROgQtsTY92zANDtYmAhjjEz4q2VJVNdH8URLu7Tr
         zHR8/qYStQfRHYraL4dlXTEMG302/USUWywYiWGJTtXJAolVeU8XczheKfKpy6Kd55i3
         T9tS0sGtENGcogOIqNVuoDO7rK4+tqeOsZB3W3uKfweSyl2eBWDd4ecwVJ2DFYRbXoKj
         06bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795282089; x=1795886889; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VBJcRHV4/VgxfLthTmZbdWhNh9pwFJjcff5ESPnHVZM=;
        b=YS77EgV6Hj0GpMlhmdRyzQFpFhXluNh3ARP5Sqi57LpTUkiE4H4SqHgDNdv71hR7uC
         M2CuBWKzxy2xe+xRHnkW1X9vaLLTmi5V3xcF3cHbjkl5c/GC6VoW/79PG5cJyFoUhFvB
         Web7u/W/Z6hY0OLrkJKmHpSU8gmtOBHNRN7pUyPzCEziW12IT+vVqi1qU9hCKYkJFTGf
         e7W7VYOBccSDJ3GMWwayZBDwJiojQameYtw3pTYy8hDsq3Jg5dfWjqhvLricrLoITk57
         ULDns000BCFG7NRb+ziV83vAwRnSjb0FkcTNWxZrmQ1qnDfeNno2tWW4hmrkaWjBzydj
         aw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795282089; x=1795886889;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VBJcRHV4/VgxfLthTmZbdWhNh9pwFJjcff5ESPnHVZM=;
        b=1wJWcvIKOYRyPT35pcjqdM+e7vV+b1f+aX0FdOyCE5/GjEX8lG2NMPRtuw9LAOQcZG
         3oh6ceRLAagYESLjWcubRhhw/wT2IwYxAPgDEYvfHSDjHwQEvm441IfiH1GDKl9hZb38
         yJs+xooK0U7BwJ4/v1SQhhCNyFNUFcLqGbuKnOpSfuYmvyHuJB7dTffRXMQh9U30777e
         khD/v8c2pck0WWXTnFnupVpo3pXlfvv/fNNDLDiN2LGtsI35NbylAXhJ5EJp5iV8zLW2
         zUo5x+BL8e3FmaN6MS4le/iy0PXF85OOofxE9S0MhG028fs3AnT9KorlyjmF/3vW9riE
         tbcQ==
X-Gm-Message-State: APuU4Z8w3wcWmKc5gsYjLHZaK8QwRBuvSnNw6iAbvOTh2r2egAmGoW2/
	pXgpfezxNbKWQWo1b4SBTLpresZXuWVy2+ihshMvh02X+I1sOKe4RuaZl4+I73U2WnKc/1ysTAQ
	Moi9oE4hCpjqoSsP6BETEVB/K1hwHa3Q=
X-Gm-Gg: AZFdTZc/vFZKcDYnhv2cWvj41fTqw2JTZGSN4n3s8iY4J+fpLPpxLzzhU7mGS9m0w3X
	0ZKaUw6MnwF62p5jcwKoYm32/BOTvrtWWHuG9ftmJf2Mqx6GmgOuEl/ZOqTYKwN3uNSh9nxp7QP
	QHMtPBFIfDW3ZanRCwZs4h0B/IyjePx7U7lZrgHxkmzTiFWgSL0JHpzuxjvaUwBcNKhlPk3aRbH
	2pfnPbkRrYpRIy2qKMjTt/99fVcjWh1feGwoTE/6fQAGzvAhdM5bhIfssXP0CGTROty591A44QA
	3UAchob5MNkZgIvGYQ7/zRW7CyS1OLehZWsn6MkTreL9OxD2gAFOfljYLumso5xoHcb6WK725qa
	3Xs3iqPCmEftCLNowaCeb5hVFomGUXAnGNSnqs1SDCw7bRW/rNBeqicAzS19pwTKHPo3nVIZ2Up
	aOM/BnXV7VygADFjN0pdZ6GyYTv9z4Oqfeabcr7Jti/YkVBN9TZ31x09vpJIkQMbs7
X-Received: by 2002:a17:90b:288e:b0:3b3:ab75:c94f with SMTP id
 98e67ed59e1d1-3b41c92a098mr6011864a91.31.1795282089099; Sat, 21 Nov 2026
 09:28:09 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2500.git.git.1795279741855.gitgitgadget@gmail.com>
In-Reply-To: <pull.2500.git.git.1795279741855.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 21 Nov 2026 12:27:55 -0500
X-Gm-Features: Aa3M54rbOmh01c-LjmqSE065PIvtI4zFciVeEREpdXFqLoF6Y-LIL08L1e6fdU0
Message-ID: <CALnO6CCJO67E+QA6U4b_p6X9TRwFncc_S6vTs_f6YOX11m0YXA@mail.gmail.com>
Subject: Re: [PATCH] setup: fix grammar in code comment
To: Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ophir Bleicher <ophirble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 11:49=E2=80=AFAM Ophir Bleicher via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Ophir Bleicher <ophirble@gmail.com>
>
> Fix a grammar problem in line 271 of setup.c:

Is it a grammatical error? I think it's simply the wrong word.

> will only complain about an inexisting file.

What a strange little word: it comes from "inexist", which does *not*
mean "does not exist" but rather "exist within"!

https://en.wiktionary.org/wiki/inexist#English

> Change it to 'non-existing'.

I think "non-existent" (or "missing" or "not found") would be more common h=
ere.

> Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
> ---
>     setup: fix grammar in code comment
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-250=
0%2FOphirBleicher%2Fsetup-code-typo-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2500/O=
phirBleicher/setup-code-typo-v1
> Pull-Request: https://github.com/git/git/pull/2500
>
>  setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/setup.c b/setup.c
> index cedc031c54..140f1926c4 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -268,7 +268,7 @@ static int looks_like_pathspec(const char *arg)
>   * diagnosis when dying upon finding that "name" is not a pathname.
>   * If set to 1, the diagnosis will try to diagnose "name" as an
>   * invalid object name (e.g. HEAD:foo). If set to 0, the diagnosis
> - * will only complain about an inexisting file.
> + * will only complain about a non-existing file.
>   *
>   * This function is typically called to check that a "file or rev"
>   * argument is unambiguous. In this case, the caller will want
>
> base-commit: f7de81456940dd6f3274e461149bba12965de609
> --
> gitgitgadget
>


--=20
D. Ben Knoble
