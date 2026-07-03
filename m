Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69533CF1FE
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080599; cv=pass; b=S0eFdMWCvPwcClmn/fxj+8ZZGfUZifK3kJXeA1+C0MvWkAw6+MHKbMFos9K2SGloxxN/I6wlAJF24CFvVjLbniOm/LAdiE3WVS1MSfAR6cCDZOM8wpWh1S8SAMl8ILXy2lZnzvHZJGHM1eIIbVb9DlhMVvT8q071w8G00Y3N6Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080599; c=relaxed/simple;
	bh=krs+JoXUsOlwOShMRknvmgk2jA3PXXlVR2WftJq78Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATD6ebFWXDXkqFXH7xdE5YvoceZixZbz6GPijEpD24knmVZ2T4v2elS4B/JwYURYmiZE2Xu0rujBn8It84pnZNorBouQbSoQLfyLLoVbR273ZyC5POj4+xFTNPEhgR59f5SuzAr8T0+I0ZsayLjHQFrGbmMc8ooR5qq1BvFyaXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=WUqFIQYn; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="WUqFIQYn"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-664c6304683so466329d50.2
        for <git@vger.kernel.org>; Fri, 03 Jul 2026 05:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783080597; cv=none;
        d=google.com; s=arc-20260327;
        b=VO02J4ErvUhG9mj9TH2pqF4V4tJ/YTt5q8iRR4s8iknP2TRyHr8SOX1ral9Pwa5YsF
         o/RYiYXS8kJS22ISa0SgSdyBOKcyQxKDWGuXFKTMHJFhI9bxNirC+wskCjCXivKZPRpN
         2l3KxLvGFZk1QYshvzR6JjkwsUMDzXNN+cWnDttEQUTsyJ68VVcutf3F6n/ytzEynou1
         xIPGk0xYBaQf1qpLqoGqwgmXXkVGLSYKVkx55PqZNfWZqZDRWkh9A3qH4dWFKCnm65A7
         qaNLDMJCEV/QaFWXSHgH5t+kY4Yf7JomhdGRI7JV9V6j6AgsW1WlbEg5YUsAKAmvRmZ8
         WWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=krs+JoXUsOlwOShMRknvmgk2jA3PXXlVR2WftJq78Ac=;
        fh=yzLg3vprUz7yKtvpFi/TiMan98RthxzznLIBhKMGgWA=;
        b=mm5m0vRID0JTNHiGeW3SloZ8oYFAP4QuE0MpUDiWK1oDe4ZlHjddksz4AGuP3KdiKY
         qqkWqLR3NTfx75cf7pfBCkrxA4XDvEBxbbf0EcM354kPMb/3AypCAXcomBVfnsI6kgmd
         3zYcQFDr977Pbs6njEexf5K8Xqd9PLN6A/xEgFBHoKc4MX9qKP0xN//DO+0ZsC8UqsOg
         RZumTP2+R2PgCWYOSu5+/M+pkqTENqQmgRWJy7k5N+sdmIi2b7CipiywROBAeG5n7Rqw
         /trgtwrUKamsrvR8hO2wnDqyFUeoRLt1a52W1S4ujGVEWrQc7UeDZeEiL6FgsoEXpXKD
         wzEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783080597; x=1783685397; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=krs+JoXUsOlwOShMRknvmgk2jA3PXXlVR2WftJq78Ac=;
        b=WUqFIQYnhUvn4kyQsLUkHjLgsesMafuf9h3qNM77fJ/dJmTEK8xCC3+yyap2f9tpSk
         gn1p/Cg+NPRnLRVUX8Ftqsuf0qof/gepCFX0W0KTf0dsK7nveGPEFzDtXHJ5DtuApqmZ
         jMPlUu0WjFykBqs9r/Iw9a+PgetvlgAgll5TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783080597; x=1783685397;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=krs+JoXUsOlwOShMRknvmgk2jA3PXXlVR2WftJq78Ac=;
        b=Lqi7Zv8aXMhG77H+B11ZbT2UI2Ypu+5BbUNyAOqgOuo5Codiz12VkhfJatK5msbdLp
         KwgmKHbkv8IaKlD1Wd7avuEapPGz/fU/Zog1wMRGvzyGB6tOpK6kGIrAW2I4/2jThKZ0
         o3xbDkRVEXyw7IU91i3vY2ExU1CSdV+wHUsavTS1kgPad49tRQil+PdwEyKjX/Ft5FJw
         8U+ucSLKF3FaTLivN8LkoqDaynBnzZGABcuOkQxwJZr41d9+HBy7KL/TpdDzmWLXHEbA
         w/2KFKxSTL78aQhVcKklyOvSHEmFfwm+XAKg6VYDBtJ2sD6CskXhScRtnFXUOPNxEjME
         iHPg==
X-Forwarded-Encrypted: i=1; AHgh+RpyN3F9Q4nlBVrR+ONPmZaVv3qyDPS1h1nzjPsSuKIU7WUp1ArU8dJ6QNqgC3OdnhX5liQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUkL1uESF8o00WSRDz1Q4ipgVH1RKAq3b3cTr+2HzY1sCcpY1o
	fSbYA0a+L/MNdzz3JJJW9vBTPdycAlVgeD2wFpd8QPbmycn51RUOSSVovBO7ZEF+XUnjqI6sycH
	/iJi2yMP74ZbdGLPwXq8G0PDFs6dUppUqtnFfoSqrBg==
X-Gm-Gg: AfdE7cnUUp/cCFYETa21CrKRBljOPj4DHLacgfQA3DgLPZMkhFyNqsRS1eVshyfeoQ8
	cS+Ep/nMOrUukNTOUxXXLuXt17JjAhya2AikhqilFynejqXrjnr9VdEfc5K2u/Du4LFjFuBWGO2
	xk54EnvHgDhxXTfVxWrkzEnDDJK1mn7H6evUsETFa8BKX80tOcn3/th/99P+eL3bm1xjlpUet7F
	oJlUMtYFRAlgTOyNS+L52/aBDiSqcs2zULcNl1NePDn7ccTZXF+wOBNuT0V1E3kYJyfjG4=
X-Received: by 2002:a05:690e:e8c:b0:664:c8af:1910 with SMTP id
 956f58d0204a3-66596526562mr8700718d50.26.1783080596888; Fri, 03 Jul 2026
 05:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628075716.GA3525066@coredump.intra.peff.net>
 <20260628080710.GC107826@coredump.intra.peff.net> <akIJQbOUbdBbkTef@pks.im>
 <20260629203527.GA1895313@coredump.intra.peff.net> <akOG0oMu2KTqqyW7@pks.im>
 <20260630234702.GA3759976@coredump.intra.peff.net> <20260630235850.GB3759976@coredump.intra.peff.net>
 <akSxCUfm2P7ocLJX@pks.im> <20260701080014.GA3748390@coredump.intra.peff.net>
 <CAL71e4PfXA-ixKR6r7fu_7_QmdzK+rTRs29mOsUYKaq+_a5q5w@mail.gmail.com> <akTm7BDohsy85sN8@pks.im>
In-Reply-To: <akTm7BDohsy85sN8@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 3 Jul 2026 14:09:45 +0200
X-Gm-Features: AVVi8Cev2ywPAcyOerwKuiwURUFRTk62pW2-1tJrw7Q5NCOHL-e0C9-R6Y8SDG4
Message-ID: <CAL71e4OavgfXtjN7QxkvmctS3fTpb5MtDsi-iUg=2izZCG5yxg@mail.gmail.com>
Subject: Re: weird quadratic reftable behavior, was: Re: [PATCH 3/3] t5551:
 pack refs after creating many tags
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Jul 2026 at 12:07, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > I can send a proper patch if needed/wanted, but I might have missed
> > something silly here.
>
> Nice gains. I certainly think it would make sense to polish this a bit
> and then cast it into a patch.
>
> Patrick

I have a small draft here https://github.com/gitgitgadget/git/pull/2166
but I am honestly not sure if it's worth submitting as a patch - the
change is somewhat small, but spread out, and I failed to properly
reproduce the performance win in any realistic scenario (I had to
disable compaction to see the improvement).

I would want to rely on your expertise to know if this change
would be valuable to discuss as a patch at all.

Thanks,
Kristofer
