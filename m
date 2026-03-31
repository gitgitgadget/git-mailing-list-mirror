Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F92E401
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000726; cv=pass; b=Y/j6/jdTFBR3c1t/qKnd+tDPgBa4kzb69ByOvhDmPfy89JpYH2AID9SYi0N/7DGnz6BLNLoG6R9iauTO+BGQ84w36BGsdHhUDCZAjUjYYMDGKbt0nLzoRyLLkZngj3vT3PQtGyQfa0Wm3hGQrHY78p4RXR4hASIOkpunvdMAVxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000726; c=relaxed/simple;
	bh=pAbmbMthm9Y09MLAQ4p3nD/hu3L1zvoX/nRC+ljH1LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTZrEobgsTCNq6DGG45QLxPwDozgNZhJXLkyiXFEDCW/eZC5NgWgddmKljYxunKko1bfsh+ERwv9MF0T0HIrDhcy5vb2J5HJvr65u0myuKGBvngNOyHxWkw1p4JeGUCMpYAPQNHZ9TooHGN3BA41vgQX1xYGXGctTM7jgsxTbZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igLR+fhQ; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igLR+fhQ"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-6054aa7f6cdso331617137.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 16:45:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775000724; cv=none;
        d=google.com; s=arc-20240605;
        b=SjXDtirYTGU6Jgku/lb8VIm9FykUVAeWzKwXRKd7j3kcmcJ0ofPQ0xB8KXc4dFTFYK
         NlyfDxSMZw9joOqR3Rzpf27fY6D93iZoMRJYQHrfxQvYjQI6C3IeJ0/DzMRjtiEVh042
         TOfR0hAA6B9Gpe02n0XGIClPE1n5FI3XxfXO7ozkEygamVBNzu/wr8rK4j9mt+CAZB/f
         OaBwK17yAvZULYKkFn47oHcPj308p48NlbRPQaqGDx7NGaECqOT1uDCn2JEhbwOkaOUb
         BtL0VKuL8+zE8+P4yoOxXGrwJGM9XN3FD/FcH1Ixk8vazR8eICtO1pfhfNa9qM4CcXqo
         CpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pAbmbMthm9Y09MLAQ4p3nD/hu3L1zvoX/nRC+ljH1LE=;
        fh=/BWJdIGMgupatCVOre5wYS8ws30z05jSsIAnXExSVTI=;
        b=c6UZttpOPOR0oeq3S3V5h0u17V85vAoAs2qYNLPSHfxap9gDf90f+FiqjE9l03hdHP
         kvN5K46Uf/eWxCO8nwsiuokoeWAznwk9VbhjyDRzWOuATIcOtV7iw5ZGXTYStcjQRWdD
         mTytdxXDAv2SujM1XGapjO9qaAr+uVPL0jFMlMGhU+m6/LO05UfBqHhp2EhaVksIh5m0
         gnXP2gnf8nS33vBhAITFnWJNYL9Z/QqsGazMwZwA9yk/5KQKJyW33aafEKNgALzJhssQ
         3xt7vwqJXT2y3+GZZ5tQkQfxs5AcLeQ0dZRJDvtpoCglhEdqj6C6Hizd+uUzKRB9sIKS
         R03g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775000724; x=1775605524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pAbmbMthm9Y09MLAQ4p3nD/hu3L1zvoX/nRC+ljH1LE=;
        b=igLR+fhQnHP/NZskSOXRXkB2jUgUIS7wznuHuUiNziG80ya3rVk67nsSiJz515xwym
         ZHOvhZAGqSeQlAsLSLkWTPqbe+mM5Nf7SoFl6X+e1ODq/2SPhV2XnUWchoQSuts3qH7l
         2RjExObJ2J3bDQnwckyPbqd3987KjECW/eX4yqRtkX1F+I3M3pCNayzngtj1YrKTm6mg
         HJlkNTJinzUhRVWn9B0VnAGxaMDPD/YFkhKE49XcD7W8P3gvTuuIWLs0vN1R5gG7Vpk2
         02QHWXA6xCbLUNHNZ/+XPnU6usYnU/MAQC/ziiVrnOfNyGG0j7UQc+7NxS0qnN5ykzO9
         gfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775000724; x=1775605524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAbmbMthm9Y09MLAQ4p3nD/hu3L1zvoX/nRC+ljH1LE=;
        b=cZmiD2FK8Gf2xXDWbjKlUvhWv34+kxVypHJC2sMhio/Nklm5VrWctyNxtPGbCYjsU8
         Uc76MH1QF2ZCaLwsCuo9IrbM0DknE1JiVSNgXHwjN/S31dkfabZ4pxl6gZctEbIKfUop
         Fq6uEfoc6I5X5Pde+Pf8FwmYJePfxjZX1Vsw1OwTTwGQa+z/QlMr4AF3Itsce82jyESz
         tDLvY6v8qO61svPdgJ5ITHiviPnX0r5J1gbQN7bOCep8bwtsD57tBIYKOIlQGvJB8aIM
         wBP9c52MhjUNilvYlLP7JVcdxI/j3ZHEsyPuvQR+Vd35po0qidJTdUGcWGHqlGzSN1QJ
         k0zw==
X-Forwarded-Encrypted: i=1; AJvYcCUA5Gzu6KaGS5MFcNkJlpVfvwSoTceA8S2B0VEzw3YW40Xbcxt5lQTgdrlUGQ7pe3y0rA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkRTHDxeOeMeGpHk59eslDB0edPDAbKWL3+9tKYnyg1UZTI2jw
	buoXCEIpEYpy1DMAHngunO/ij6JPREpiD3y/kpmUp0XJbAIZTxEw1iq1GshHu3jgxWpWQKAFo5c
	4bwKRtWXxrXWPYIM0lZVjsPmLAegrSe0=
X-Gm-Gg: ATEYQzyGCjuYK8ryApwls34romWVxjK4otSkc8duG/yHoydCybHf1dGzJtD5fEMAKOZ
	u0fpmEORlnx6hLmtQCB4dmjRRlsbb8F+DB1g7ge2KnUVdh/P0bXyeqnmjr63fY2r4+z9grTLiQV
	/4iNA/livOx+ozTmiPeDZ8nXXc/+rwS2hAVDJjD+m7IOLjLF03s2NL/m/ekVOStGJ976bt8qTjo
	0uAogk+h4HxkP6AwcHtxNVe43tXN89AktJ8QYHgqFjl5P90qCX+S8zAazUCrIjRQiIiEgIqNuHC
	pbCeuLc9kccp3/bMnQTWzXzQKGFulc39YY/dPB8gMa1RnbjWbQY=
X-Received: by 2002:a05:6102:370c:b0:5f1:4fc3:855c with SMTP id
 ada2fe7eead31-6056744df53mr476694137.7.1775000724421; Tue, 31 Mar 2026
 16:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318204028.1010487-1-usmanakinyemi202@gmail.com>
 <20260325190906.1153080-1-usmanakinyemi202@gmail.com> <20260325190906.1153080-3-usmanakinyemi202@gmail.com>
 <xmqq7bqzu1xh.fsf@gitster.g>
In-Reply-To: <xmqq7bqzu1xh.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 1 Apr 2026 05:15:12 +0530
X-Gm-Features: AQROBzAP8NjcBoZIe9f6DVUNZrViEjW074TCwBDTSDbqmDXV0qGQp3sUh0-A2nE
Message-ID: <CAPSxiM8Nks16nJCB9N8_bi-ZmQFF71UQEzACrF+pFXKXNuVdKQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] push: support pushing to a remote group
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, me@ttaylorr.com, 
	phillip.wood123@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

>
> I would personally have designed to mimic exactly like "git push r1;
> git push r2; ..." would do (not concatenated with "&&" but with
> ";"), which would mean that there is only one single failure mode
> that would not affect interactions with any other remotes, but I
> have no strong arguments to choose that design, other than that it
> would be easy to explain when we later start supporting pushes to
> multiple remotes in parallel, where a failure to talk to one remote
> cannot easily affect interaction with other remotes without getting
> affected by timing issues.
If we want to have one failure mode i.e continue pushing when there is
a failure,
then, we have to use `run_command` to spawn a child process for each
of the push.

Is there any other approach you see here ?
