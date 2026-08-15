Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC6564AA4
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786817006; cv=pass; b=nCeMYCJlEY2ucCjKXVKZ7Hh7N9CWiuFRZ0xEaWNpwkc2ZsC9og3KMmI8exWqEFfJ7z/oba9ggHuqYtWwWCLmhssZGi+TKJTN8yLixIhMqdNikFCVLWqL4VlVw9ZINnYmiw+ton1+IgbZhpWXVV2QGZL7PaU6anmTnIP0rCtaluk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786817006; c=relaxed/simple;
	bh=clPHFpzT4AJvg2oKnK0xFQlXib/yN/yduXEoDwb9Nn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=m9yIe/L/Kd+BjgSG3GleBN9IsSjvso7Fga1W0HHOD73ToU7An+YNIF17jAxcuIW9HF5CrFWoJcKsSJZtCJwPBqoJRWqXmk7sgExQKN7AkhzlI9Ri+iTIdyO7Tr+GY5laIzOSfDExA9VN7HmgL6E2hTwNrin/wGtDC+ZpO9c1U4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwoeFOFB; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwoeFOFB"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-448b89f700fso1457314fac.2
        for <git@vger.kernel.org>; Sat, 15 Aug 2026 11:03:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786817004; cv=none;
        d=google.com; s=arc-20260327;
        b=m6OD1q3u4iREGrYC0TLJlAD+IfS4HjgCgAdjSSc18yc6YSSKy8HVgIVyH3Nx74MIoW
         Ew2bHTfikRRL62q5RTZ3bCwRo9Drr5GCU1KrmOT4xXDMqxtaKggjIKErbOXQc1vRn30e
         vInRgJW8gRYQJAhXgVEhFtAwjc2VBN/ApBzGxCiCTGkAzE5ZIkfJ+Ap2YNwuyoOXrvon
         oVz/PvVpv/RVplIEvVG/qKhtZmiKGPDwHVngLZeWmO11tQcUP+BEsuFfqc6cu225NbFD
         PT1Givju8Il80yrCUJxMi0GwmTJjT3mohlA5rNafDhyF8EM4G31S1sHJC5TjUG0bZ6Y/
         mNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=clPHFpzT4AJvg2oKnK0xFQlXib/yN/yduXEoDwb9Nn0=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=FnwTvrJsXYQCF841XXQtozLhux062vqllcAQHsxJrDQgfi66DihKz1VB03VnAkEhIK
         5JH1HAb1di7a5dZMmRC17e4qvV5gjewpJYfd9/ZE/QKVM82ery6ZUmsxlwZsbqRWnnS2
         cHCnBDcptqzSWJ0lxwn8Wcqn3uDiOtylp6RQxZ5dpVNU0z/Ruep8QRZo2If7rSQkgrYM
         tRiyFbIMkhz/K17v75e0/3ULn3iD/MCnnHcNmA52Lg912fTnybsJ0QYAobtAEqwR9CBj
         R+CFaF0SZM26Em1j0IHE0JrM1E8gR1YWTtClRh/6JXkonhC08tcOsqBOR5EhGZArtrYL
         eA3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817004; x=1787421804; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clPHFpzT4AJvg2oKnK0xFQlXib/yN/yduXEoDwb9Nn0=;
        b=RwoeFOFBA+uFnRxuJCA2WuFsWKq9BpaD96orUl9ZPR+yrq1d42/6CRvMXFaTYCPmaP
         IbBDL3UA1hs72IO9FnNhxsF+YBoQ5Rb2B9CsVvn5vtxyhJB6mqS9SSRfb8mUleKiVVtF
         COuUWxNu7twBLI6fgD7+fe9BFnifSC+mj/6adaIqCjC+9stTO1Wd7BJP/6zBV7k7AJp2
         /b/O3mEIJIf/F50uyKGxlx20sYEZfZCaubv/7gYpM560sG1oGfZSf/RGYWMoVXQJS4h6
         rx45aPbQh1nAVN73EsbFp6S/Y/l3pNAiIK8miFYnKch60Dja39lDaDGO1k1/SGy/KJuz
         joeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817004; x=1787421804;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=clPHFpzT4AJvg2oKnK0xFQlXib/yN/yduXEoDwb9Nn0=;
        b=PaEDZ2L1dQFDFm/nODyWWUO9SDHil9ZuitbHb6EY24yFQarHKeU3kLkLUChP3UftFB
         FHYWyT4G5SEEM2udQhEDwH0XFOOvQ1+0HchXe4H5ko217d/rF4gTTqZExSeO6lpdyjx2
         sYFTb6Qx6j18LiwE0KOFKteZR13ymfcgZ6toeu7slwe9mfI+yXK7WxlGzwIRtt4vbB2m
         R280URqeMOKLGBrsEkexcJmVsiwTdW57KehpUsQ1Ko2xhnrXMN/r8wd2IlQ19/1FDNve
         CIRLu9mMeJTBeklXnSYRM7l1irAavGYiLNIfVzY5Tct576lJddRf7Kvf8okRI6gOfxx3
         MqNA==
X-Gm-Message-State: AOJu0YxiWPxPqOSoABh/lAHMuR75VyO7ERhlm3C5amlqaxWEFPMGj0kv
	pi3PLMfVFf+pi5v/WHHx4IcQLKiv3PkKqa9ipVjqpR+96/tgvIByzNw4VAeQ/wK36W4G3yXEOah
	USsbgBScQtbWMrDxRAmZLB3j4/AmPTZnI5DwVokE=
X-Gm-Gg: AR+sD13Vx4B02+LUofEl2LL/ASmzWQfwiVDJAWxdwhYC2pqRFmbYKDi2kd0DzQmj+qX
	rOHApBkinaMMKCOKWVKvye0N8HlSTrx4qqy/2tMjHm+f48erAR9+1T5GXxgLbiniEQFTxsTouvr
	2uJKgso9omDl8nYYaGLcKNcBsUzTjlQmuP2ZJcpJEYjpFSyIHvc7i+xJ65RJAfj4lffcenLDPxC
	P8p/C/MIwNKcHDlKWEdpMukFib/aDTysjsygJzwlxU2Ny8JVAHbKaZsoqhmz0vwOACMRBCCr3g4
	wYrSl/I7MGoGQO4gpdUbTSdqXEH0MFNRErJHKZyLgz6iGKkCYL7mn50Wlz0Rub5i236Lc2siA2C
	aMBQ=
X-Received: by 2002:a05:6808:2f0c:b0:496:559d:5474 with SMTP id
 5614622812f47-4b2414f5f25mr12883307b6e.8.1786817003633; Sat, 15 Aug 2026
 11:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOqWQbKn88m=OBDF7W8bBPjeOxtRsvNmhsqNy9AryMKrOKtLUA@mail.gmail.com>
 <7d0e9933-1a5f-4755-8bc5-fa4fea42f61c@app.fastmail.com> <xmqq4igwpswr.fsf@gitster.g>
In-Reply-To: <xmqq4igwpswr.fsf@gitster.g>
From: Peter Morris <mrpmorris@gmail.com>
Date: Sat, 15 Aug 2026 19:03:12 +0100
X-Gm-Features: AcwNN1VzV-q6RKBGdEcJ4E-rHuwWjZqleFad1ZFpACBzBeoB98AQsRj2Ux-Bv10
Message-ID: <CAOqWQbKuD_u5d8XbZ=6x9qc61EXNj9hDQjRfe=XE1FkWCp45bg@mail.gmail.com>
Subject: Re: [RFC] git worktree: use filesystem cloning where supported
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On Fri, 14 Aug 2026 at 17:29, Junio C Hamano <gitster@pobox.com> wrote:
> In that thread, Brian makes a good point that you cannot "copy"
> dirty working tree files from an existing worktree, and also that
> you cannot have the same branch checked out in multiple worktrees at
> the same time, to avoid making other worktrees out of sync when a
> commit is made in one of the worktrees to advance the branch tip.
> [snip]

Hi Junio,

Thanks for the detailed reply. That makes sense, and it's useful to
know that the approach is technically viable.

I'm afraid I'm not sufficiently familiar with Git's internals to take
this on myself, but hopefully someone with more experience in that
area might be interested in implementing it.

I've seen lots of complaints about Solid State Drives dying due to
worktree use. I personally have a repo containing over 80GB of images
that never change, so currently worktrees just aren't an option for
me. I hope this will change in the near future!

Pete
