Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3793B27E1
	for <git@vger.kernel.org>; Fri, 29 May 2026 08:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041901; cv=pass; b=O3Fl7UWm0fJmzvhZ9/c5EKOHWosWH/w6Hh4ckCgE5uQJ1FUKj7QuANO8x5oGHip1Gs46VJpfQ0KEe5XpmyIv+YlSYiwwK9A1GtbVZPBcWlCRrMAAeq/upHDHoyr0wnR7S6QJDaLELUxGiZbc254wZenTm+UF9vlYM/HVjZHmmb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041901; c=relaxed/simple;
	bh=ajlTJwQe7in8mJTEVAeYDrWXb4++rog6TL7rBatdROg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePTNH3I8HAolIDvztmMztP0M4i8raVq3CDvqk6fv/JzzS5hCCDGOmTFxemCXjxCgiii7K0bl1pvcl4hjOKnD/sM8J4AyGPM1jo1tHuguRAoKcOm0efBhV+iB9kn3x4IrZnuYJZamNrCFY+UiOvHxWX0NSuMDrPO33VDCbz1Bj4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Fcq99juf; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Fcq99juf"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7dc93d02916so15464977b3.3
        for <git@vger.kernel.org>; Fri, 29 May 2026 01:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780041899; cv=none;
        d=google.com; s=arc-20240605;
        b=V9vXXb9ct9I6F/bfXk0PY0ZyD5eH2Cvr6V42cDSKYqrJFt45FTaQoObsVVHKQ+rx8+
         tM3iKHQyc9jd4ZU5JMNI0oWK7E/WJ8YKO/euQ1/W00BzxME6N+s1ge+ehIXT+NtFCjeL
         5tStS4mCtIEzzjP4SRHwaD9JN8OkjZIMTFErgLb18hoEBZ5Xkfm7Wy6R+GBWEUsyDXKZ
         tRuUU2vDXMrYnCVaQFEt0pJG0xwhJJosbRT/NOlSxrj+o01v6KwqX9DI/PyqWZMD586N
         6D6xVYPXl4/FAKIP1BwNgPqizCpgIWln4VOPqhK/wIjAMcSaId/LK/SiJAel7u/klSLl
         WV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uPJlznJXub+I8II0N7gD3sV+0dXf9hXb9bEMiSz5xG0=;
        fh=JXNDmPeMBx9iu69BUiBE+lqQngBgrqm2c97KJcFRyzU=;
        b=WUcLc55cxF9FNxfYQgwE1yHYH89fotDTS49cjwABCg9z7r0TcAaU1DUeS/GYKDccEl
         o1563aRIuEdrgj2K3WSUMjuLVo+uRB9NEx4X+QqjFhcaqStQ0V+b46zEzP3ecVJOdTeU
         KfewYxyIv5DY7Ll4xp6+BrX0kr2/KiwmHhys+kc7pKOOlFfFKCsPUjLcLTPPvwl+Gk5V
         Eh5Btw1DOZxg7YH+wCBv2DQ7R+m9jcKo158NK09nHJRFrOrZewBSSY4VlDtuvROoTYnt
         Zsc2svKZHsK8zOXUxH3yRyqi9kFbN/pF6TlpIzKqI/Iuu7KOdVpS4EKkt+aXkVuvC/D2
         pXZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1780041899; x=1780646699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uPJlznJXub+I8II0N7gD3sV+0dXf9hXb9bEMiSz5xG0=;
        b=Fcq99jufn2+KDGV/mLebwRLGSl0J1Ob3/42yHwDxCVjRTxPVh2qC3BLl6iuJMHpYoO
         b9kCBhu/m/f2L99KagEmY1SipMAh52nI00stcEcw/CKcmar1NWiV8GGYgGVkK5GrKNL3
         JJHmFmCJm9Cclqn1P6V9B77WabIXWULdPg+cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780041899; x=1780646699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPJlznJXub+I8II0N7gD3sV+0dXf9hXb9bEMiSz5xG0=;
        b=I+RRViVoD0wKKZ2w8gpHGQpcN6ocXLYHMKEVU7zjeSw9lo2D+tGPfV1ZeA9uRXXr9p
         uYSwaBySLxwnvBlRioWVoVx4jLeHctf/1aF+3LMxKCB6NAOmM2VoAt37C9bIlBS7ZZQE
         jBXK1FF5KXwmRqErSNJHOBYqLuV7mzfz5dvOOyNkfntuV9xLICnRT3sh/AqmbMxBoBnj
         /2uP+Q235rxdK6Ys/3AAwKy0l38tfFu0xqazb6uZDbhi/SCT5F7MrfU0GIoiBB4y0n2L
         orEPg+bU/pWzz3SKXn0iGb2tnJH3vZM11zv1Uxf4tKL7+o38am0OZQJQ43u2Hqf1Qivj
         GJmg==
X-Forwarded-Encrypted: i=1; AFNElJ8eLJ2VptviQuuThlMkhxmRHTdt2qsF340Q85h3fT109aREd61Zcg1mZPla/TSBIARApes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8+Fkv+1LiODgHYsmaQDqTaG6nGttXDCvcsVZq9nqHtuqEV0h
	nugLMG0ta6ZcN+4LJ6T+NgjkIAvsnb83L+QS40khuBliILFJMBLMbJSAcnmX7YfKNs7UxDTp3Fm
	2FlA/JS2WVqvKmz36R0NztlIXmQCNFbhEOXEiN8z8dg==
X-Gm-Gg: Acq92OHEWFHyUfXUTlx9X01vzpAbY6SIkMB4Wggv6wpI+w1Rbqu5EbtYpFZpbwNa/w7
	q/83s/aBWA+dF1VMTj/RYrfdKHUqNsCI83PutLp/hwSNkMRd5MswJ02Y5n6bobjMIcJ2WobRVSV
	FT18zc2L8HKBj95NKh6hT7nDQiTBIlX05SWgQmO6NaaUAdlylJ5+4s2fk3Jcpkjo+lH8LYaOLWG
	asE98aCx3NG9+M51S8/W777G/ICBI59RSnu7JdKZZ4m8xl+HPeVaJ/stJzfE7weKKnOEt8lWcy3
	BChsBpUoU2YhY/E=
X-Received: by 2002:a05:690e:1283:b0:65c:7636:2b09 with SMTP id
 956f58d0204a3-66052cb1ce1mr1108530d50.5.1780041899184; Fri, 29 May 2026
 01:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2128.git.1779958849319.gitgitgadget@gmail.com> <xmqqecivjn7k.fsf@gitster.g>
In-Reply-To: <xmqqecivjn7k.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 29 May 2026 10:04:48 +0200
X-Gm-Features: AVHnY4II5FeTi3-a_HebaWwCH1HwlCm-M04AlJ-qE-eETsmfKETp5dSw5vCtzsc
Message-ID: <CAL71e4MLyEEWtrHvB2K+stZUq6s+5sQUpSjmos3F9aVo3ej=Fw@mail.gmail.com>
Subject: Re: [PATCH] t3070: skip ls-files tests with backslash patterns on Windows
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 May 2026 at 22:26, Junio C Hamano <gitster@pobox.com> wrote:
> Two questions.
>
>  * Has this been broken on Windows since October, or has something
>    external change on Windows recently?  I do not know.  Anybody
>    knows?
>
>  * Is this change a workaround that sweeps ugly breakage under the
>    rug, or is backslash inherently unusable as an excape character
>    when handling paths on Windows (which I am afraid would make
>    wildmatch fairly useless there)?
>

I am fairly new to the git ecosystem as a developer (not as a user),
so I am not sure how long this has been broken. The backslash patterns
in the ls-files test path predate 8a6d158a - patterns like 'foo\*'
and '[\-_]' have been there since de8bada2bf (2018) - so it may
have been failing for a while before anyone noticed.

My thinking was that it would be good in general if the CI results
were green and did not include false positives for errors that we
know cannot work on this platform. The risk is that people stop
looking into CI failures in detail because they start to assume it
is the same old backslash problem.

That said, there is also a risk that the real underlying issue does
not get fixed. I am hoping it is sufficient that the BSLASHPSPEC
prereq and the case *\\* filter make it obvious to anyone reading
the test what we are skipping over and why.

> Will queue.  Thanks.

Thanks! It felt a bit heavyweight to add noise to the list for trivial CI test
changes but I suppose the process is the same even if it does not
affect the production code.
