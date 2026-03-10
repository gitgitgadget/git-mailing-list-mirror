Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB23B6341
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158897; cv=pass; b=dLShZ6Ns+zpjfgXxjwEpe8/1U5TOqg0qEAQmV8ThnLbnJjpab115E83liuPYS/GM9uoJ3Cvygpkq6xSRHmgUs+CZM9MQUuyosSuMbMCSqjAULtPWdLx63hhv8hHUWx7AgsWS4uJKb6REKM0I9w8UiYHCvEWbXtgMlpKhRe+KSTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158897; c=relaxed/simple;
	bh=mC2QT++mB/zbwk2AModNU8nNqx4Zo3xDdyVyM3QZ96g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhtPEVYZf/k/MJXprDa2qvG6G8Ht4g22qllVF5iUVB3x7m8wFT5BY7iLK98+imaEw0RfPnPiHUFlDofVzaD77F6i43Ktm1DsTa6twIWUg8mqg+MLyXcnsCP83zZQItY2yvVlPtj16g6DECRP5sMIm0xPcGVuWyP4sR0Y/TL678U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJoPZUZQ; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJoPZUZQ"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5ffe68892efso2865609137.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 09:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773158895; cv=none;
        d=google.com; s=arc-20240605;
        b=NmtFBoiAoMptKmZ1x6KGbDqpKS9GJTq3eM1u64xlqTnFD+/1Iu58NXUMR92V5BYfDo
         jGl8uGbRg4WAiIrkEHY3UA8/sXqKbSjW3v3VbhACG8/1rPzrlLOjE6ll5SJLJ5eycoHM
         YeFTAXMTeGKjdmH1KxP9KENxWXdoM3mt7ZnI0S2ohzrnIGK0km9DJ9BJQVU9pJRK59D1
         d/wRRLkCfjckr4lWMyqGbljZgpxySKjS0mQjFGGM30ZPYvsaqf30cMg8NQceEjKD9C2c
         3hlLGBYxbUU6yDd+g3IOl0Jl1FL5BmNqlDIRLNP14UUK2GCBL+y18Ch7rBpb8bdEB6HW
         4SWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mC2QT++mB/zbwk2AModNU8nNqx4Zo3xDdyVyM3QZ96g=;
        fh=Md81qCbOJdPIdbXpZ2lU23rRSkVkFbNzabGXRBLAn3k=;
        b=M3c9CJoxEbCYDiyURji9rHGkdcTkqladIJh9zN12VzOykdfPoe8aIu8V9IV6kXZE+K
         BiIAiHeRUWvOSVi2jJIwDjWKRt8b6MZygEzvs/Ob78QvrwJff3VOCFyE9+0xZHN8QTxr
         7n+en6zG5jPV5deiDyA9Jw1A/gN1J1E6tiODw9l3AIBLUmbkp6gBQo+0VYp149blPCYJ
         XW7geCuf03SkpmUd9Ce6bIgf9H5U/OaRPf1qJk9hQZ7VX40PM/pYuGyGwi30Fc9NQ95h
         5SwNRqPXvOe1I4mTyJDePRbeuavzZzsgwELksc7ghObdg/hCFvUjvo+OECoJpUH3Vqqi
         qoFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773158895; x=1773763695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mC2QT++mB/zbwk2AModNU8nNqx4Zo3xDdyVyM3QZ96g=;
        b=eJoPZUZQh/1NG4VbJbOjFR+UjmZ3LgkMPVj9h9iKTYyCOIDLGJ+L+BpRT2CgFB0+qW
         IyDWmvZ8E+pGrVpM7G7eNymxxQ4ine4RpUN2MIFvT25tG7yHEAh5HEUioXH/t605MIdU
         VEgcwCEi8ZpHYHAwJ4vdg+HQ7iGnDS9e0KJXpD8ZBrsMAQtQMhHcYJSugHP/fzlp4lU+
         MEPM0x2e25/IKJ7WVwYlRYYH9zlFHJmIKBHar1z/5tpn6M0dp4woqMfyV4CQtrC2yLQm
         ZZxtgART5Nkwx2h3EllydAEGem03tI+XzJo+fz4kwozzHaC1395lD+1pR3KS9v2CrRly
         JcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773158895; x=1773763695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mC2QT++mB/zbwk2AModNU8nNqx4Zo3xDdyVyM3QZ96g=;
        b=AuQVmrNPcK4o0/icRwT6vaFtFLTvtXWC6fUq2ZZ0z+N+AkpDtDNR/9ePIrwba7BZMf
         m3g9Z2nJN+xf2zHO86odbLMdktyWm1Wg+wtiNRCChc3hhC3DJpLEIiHDRy6nlZtt+or5
         m4Fk45yh3hWpypnPIxnRCnvbiRU55Km0l4fmj7EBPW+KkvjnHNdWMuEuv88oaFE2BYbR
         Q+hGwu2021k9S16jHsxDzsEraHd06xJE0hD+c/RLtldvCn1z7yoyBbTrWun62D+qeBGP
         XpIOZKy9zc7YaQ4lx7lioganVkBF8zJD+P9hNzaVLpptR5LBKv9ag4+bL+9sD+LOAuzJ
         PlIw==
X-Forwarded-Encrypted: i=1; AJvYcCVzPvxofAucP2rKMu+rP9wKSHXdBCi+vlE2gXWhZmktzcury2IZiLB+UrVu9TNfWRA2zzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqPNO3uIC+XEVfoyWndrf3N9edZ4R+wN6SPN+Ln/Lg0Y05kb6G
	EJO/0dhvcpVjnb0NygCt1bm5tr5+FcqpS6AgpgV1rmRbp7LkDnneCVCcyO7PSMqtBlUalULCT73
	Lm5faCFaROVoQ/BPBjhi4y/yow9I1Nl4=
X-Gm-Gg: ATEYQzwLHdnZn+Lf1CYsw6NQuB+/bEEHmb/nVWsmqbHrNmKiZK1gGFmmiPULer6hsUL
	Og+MLuHRVbxoNQVYd+xajL2ioTYFKzHRuUUwl7KlId2ao9lz2aSZ74wGMe46WHUAXz8XZW6jRqX
	r/etW0cyZIOIxKR7jAEm2a0HDSAjqVuPCkpbW5yz9Dwap/cjWoVXOWmf1a3tcHlogqidc433EVU
	9y2k3CbKdwKWVi5vw/SroztoQH5MW+ObTOezPzQzuUzMZNbcewfGmDnadIHxhOXgVSd4lxVWEgJ
	Nsc00MGvk2aX43GwGhoFOfU17r8ITYD1La/2QFYlCru+5TzNUF3zyycFLfxkcz0h1nuc5Z2MURm
	qxQ+TT10kR5x8DcT/UiQ=
X-Received: by 2002:a67:e00b:0:10b0:5ff:f4ae:a17c with SMTP id
 ada2fe7eead31-5fff4aeb8f0mr4345828137.3.1773158895497; Tue, 10 Mar 2026
 09:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
 <5f100fe0-d601-4ee3-adb9-a2458203d10d@gmail.com> <xmqqzf4fx0vo.fsf@gitster.g>
 <CAOAgETNoQuju_RWbe=jo8JF7J2+V_pVoyr6FeKw8LwYKi_HipA@mail.gmail.com> <xmqqv7f3wv51.fsf@gitster.g>
In-Reply-To: <xmqqv7f3wv51.fsf@gitster.g>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Tue, 10 Mar 2026 21:38:03 +0530
X-Gm-Features: AaiRm51X3Jge_l8MqxWmwUW8GBZ68fUp6c5m8hQWT2Zpljl86UzsUyY0tyNGnTw
Message-ID: <CAOAgETMw2LdTpW3XjE3nDF61T9Fixa0r0tT+fWpc6DEXsREAmQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Advice on checkout dirty files
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> It is understood as author that I understand.
> It is the users who need to understand.
> Potential risks for the user.

As informed by Karthik Nayak <karthik.188@gmail.com> and Patrick
Steinhardt <ps@pks.im>.
My PR seemed to have redundancy for which I will create a v4 for my PR
removing it and giving it proper description for users to understand
the possible risks of using -m.

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>


On Tue, 10 Mar 2026 at 21:10, Junio C Hamano <gitster@pobox.com> wrote:
>
> Arsh Srivastava <arshsrivastava00@gmail.com> writes:
>
> > As per the recommendation of Phillip Wood <phillip.wood123@gmail.com>
> > I have changed my files and added git checkout -m after understanding
> > its significance :)
>
> It is a given that you as the author of the patch understand it.
> What I meant was that the users who get the recommendation need to
> be told about the potential issues.
