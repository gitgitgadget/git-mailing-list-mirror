Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EAF1FA1
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 05:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712380303; cv=none; b=BAhh28xGc7p0IB9uE36Dj6YnMX/JINX0BPrpYyA4w4Bu8OGJhmZ1qkeEITL1yD7zfWAKsW9zX0lhqTV0UhyouR3oaVid7qWoLxPWS+saIegMSf1uRFqZROwDnf+OxpXh15Ep5kBB5kzlmutRxVXR08uDyTRfMKDoTf6gMtx1xiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712380303; c=relaxed/simple;
	bh=kuahLDQuXGA3B5r3Al6UTi97gIAoQJZFXDB2M1B7xYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjywdpKB9MaHmcb+Wo4GOFnvb6m6U2CLjrgbYvlrOK1eoKE8aViS8NsvJdZe6aacee6ZCM7t9gajXVMCkU77lKcghUQ0YGCvOsRSktSZm6aVs2sbvd12ojNaXR5NHIsa7HnRHl+sSmo8B9mhzj7InCyW08Kfvoj6k5RzrDfmMjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b09d78c46so543496d6.1
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 22:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712380300; x=1712985100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ghsag3/xQHKqnSyC933BNFoZ7x3kkzqtMj79WaSJIQI=;
        b=bqKLnlRywdafEZQvIGgZZyqtMTGyK64OKwPU6PBdnnFyfFlpo7rbrheH9XS1EZTvqS
         d9wG1dOVJyBxQYfLR6mKHOJtCa65gVhVhGEWmFcA99WgjL3P+aCAAEQc1q1GNawSlOJf
         szvvx7B512Rj+wlo2NWBwT+7CcTJxPclEq2hOZW3mWaReMK5p2IxHBlffC2xugj/JPpu
         0a7edUFmhxpextxND2Ej7skZ3ckPvWOEZs+DNcE+HCjq36Ebt/HI0c+zL61uXB3tr5vz
         ep+3HA0fKZQAtIvUfzoQdvpjJ7cg6HkMCPQDs4GMHpZzyfMVeBFTaJ6rV1ekf1KqPHwF
         EhVQ==
X-Gm-Message-State: AOJu0Yz4BSb04qpyKEqtZLE8Wv2JpykzcFyiL2PXhHzS2yvLUxL9uWJY
	d7op4DYNCJIoU62K+s88eTySrGo3tHtsyQkG4usuxuMfjM6KZEgRoz2U+gumDvmJrorP2TDHYE2
	A91s1ltSv5cRyVxvQ2RyIX2W3MKk=
X-Google-Smtp-Source: AGHT+IGA/kIu5daXLyqLO30innrcTfr/h+DRJkLVQPEI/K4ly8MaJTrh7NfiqBgYDaI1w0I+JnwQLphBFKbq/TQpwvw=
X-Received: by 2002:a05:6214:c6e:b0:699:2d47:585c with SMTP id
 t14-20020a0562140c6e00b006992d47585cmr2942513qvj.27.1712380300139; Fri, 05
 Apr 2024 22:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406000902.3082301-1-gitster@pobox.com> <20240406000902.3082301-2-gitster@pobox.com>
In-Reply-To: <20240406000902.3082301-2-gitster@pobox.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 6 Apr 2024 01:11:29 -0400
Message-ID: <CAPig+cRjqe-rgYf5UZr9KXmfSw98ZoYjPo5PKhwzRaC-svwshA@mail.gmail.com>
Subject: Re: [PATCH 1/6] CodingGuidelines: describe "export VAR=VAL" rule
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 8:09=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> https://lore.kernel.org/git/201307081121.22769.tboegi@web.de/
> resulted in 9968ffff (test-lint: detect 'export FOO=3Dbar',
> 2013-07-08) to add a rule to t/check-non-portable-shell.pl script to
> reject
>
>         export VAR=3DVAL
>
> and suggest us to instead write it as "export VAR" followed by
> "VAR=3DVAL".  This however was not spelled out in the CodingGuidelines
> document.

I suspect you meant:

   ... and suggest us to instead write it as "VAR=3DVAL" followed by
   "export VAR".

> We may want to re-evaluate the rule since it is from ages ago, but
> for now, let's make the written rule and what the automation enforces
> consistent.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
> @@ -188,6 +188,12 @@ For shell scripts specifically (not exhaustive):
>     hopefully nobody starts using "local" before they are reimplemented
>     in C ;-)
>
> + - Some versions of shell do not understand "export variable=3Dvalue",
> +   so we write "export variable" and "variable=3Dvalue" on separae

s/separae/separate/

Here too, it might be clearer to swap around the pieces:

    ... so we write "variable=3Dvalue" and "export variable" on...

> +   lines.  Note that this was reported in 2013 and the situation might
> +   have changed since then.  We'd need to re-evaluate this rule,
> +   together with the rule in t/check-non-portable-shell.pl script.

The bit starting at "Note that..." seems more appropriate for the
commit message (which is already the case) or a To-Do list. People
reading this document are likely newcomers looking for concrete
instructions about how to code for this project, and this sort of
To-Do item isn't going to help them. (If anything, it might confuse
them into ignoring the advice to split `export foo=3Dbar` into two
statements, which will result in reviewers asking them to reroll.)
