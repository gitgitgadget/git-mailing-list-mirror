Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394CA1C6FF4
	for <git@vger.kernel.org>; Sun, 20 Jul 2025 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753041127; cv=none; b=hC3yZVqqXRk3CluHJCCAdLU73NHnbfPPH8aP/oTLtGmJuvcPEpCYC9dCOUKHyEdl3Rf1bUzJ7HCyyWtxsNgBgFUoLJ0Zf4xso7fLcYMz8R8TNN1wGTTb3NnQbrrZ1PfutJIydqM3o6TrVX/EDpwRa79FrB61Zgda1h/1RsCzM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753041127; c=relaxed/simple;
	bh=Rwjm/uJ6YZSFOKwyNwCsaIvTXeKlg6ZbBmxU04Wznvs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pAx7/qyPUG0OXisl37nbfnShtYZbfdP3Pm5S/DV9sl06wZyYsCLLiHhZxh7u98NvMxrQlTK5Fc+eYClxaD1g4s7B4ZSevlvooBo2G5JAW+pLLtjcGiv0dNAfUEhqySBWjJVmpORSxnsGw36o34aPi3k3+cCCnMSwfxgyYdz95W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1sN32wo; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1sN32wo"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-88173565536so5341098241.0
        for <git@vger.kernel.org>; Sun, 20 Jul 2025 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753041125; x=1753645925; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rwjm/uJ6YZSFOKwyNwCsaIvTXeKlg6ZbBmxU04Wznvs=;
        b=O1sN32woaSaK9N/8HLBpTpAWXtXV+o4X2ueSgm4OcafjVqxgQlWByvGslkGnn0/6T3
         u7IwLbRlfr4iXZaCb2EgjSJA1y375mf5aN7bseU3tKEBRv0xSTmcgLeUIcmfU3X456lg
         6tRI1uhmcb5Hs5yLI7ew7iksPcmqO+Qq3eFvQGt/XHPnOtrmD9mLwdL49tGFWTsOw6Lh
         N2X9rNjAJFn4dK3cJaDrjRM1lzFfyucw3EyP6m8xwK9tVtZO76zJD4amyW6KizgV12ir
         r3UTJNi/NeFhm3CTz5jB2O8MqcSZWmNgA65bO9qJ8wfNPvMa/L4f8lwY+VjS9c1BN9J6
         Dczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753041125; x=1753645925;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rwjm/uJ6YZSFOKwyNwCsaIvTXeKlg6ZbBmxU04Wznvs=;
        b=qgjw0CKFPasgjXmOpzsS8xZ5h+mrMzOzz7TqqLW/iF65R0mXxDCV/lh3Rjfrd0icv5
         wac0wMz4wcd506Z3qQdrcG64w3+OIrdsNdeaIla0OaNhj6xL6Bix7uSrn1xc2f/oJoBQ
         /6cTk3mv0LrSjY+cXfY3c96KweSuwfAZU2l0jh5cV0KF8c79lCxMWjq9LaY2kU5caDkl
         0yhu0Y/IF1hWiMgsTPfyDx54fBj5XroI6wiPs+Pj65133Kg3sGhCdSRzyANPz8itsIhd
         0XVLF/ZYcE5+pF2+ttGso+HFwtMmtll60/jXgRVfH9OnYFKJ/ABEN1lBu5iGiQr/kfWF
         pNsA==
X-Gm-Message-State: AOJu0YxD4sqkkewYn2bk5CgZg8/2mkcpkHe0MgD/sRU66GgGOdr596W6
	cME/Gra/c+nKWM9Ipwk5RlPFZGjoZFJFTIvfWAjJR75d5s0Fbk9O41hO
X-Gm-Gg: ASbGncuPj0ai63NrrRbArJSzOp4T6v4Re65VQAseab0BIf7v2bhWd/G2MYYB8mnhmEJ
	HBgToEfJQNjcBnMCVCYqKvQCFux1YMo0yUsgrGL1203WKRyCYRQr8PXCqx7wUTO0HjQZfA+pUWN
	lNGkycEY76FLfZdkqCIHOpUnQYfV7yYqXEUg9JPXKDkKhIpcpYC/eKulkLq0Zdt6Vd3QtV0AmJH
	iXO5EIJ0mBf/wrNoLEuuDvNgLpo1BA2AcFsRW07IySnvkQs+hyn2UYJtVDjXWAtzGqz5itmQUhO
	RIwLBJn8MF98uXD2lSrjL4wDgtIJF7PnPaGO+pVEs9CDiJFu5plCwuUtjTLkwmtGRdlUUnWfaND
	KfqEKjyMkiPokS15a3Jsr0msPvQ2j8XklaF6fv25A3vKfAe1S
X-Google-Smtp-Source: AGHT+IFY9xH83GylCLCqa+i5gqjVzlmk846NdxzXHnFJwjsF6hKrsL6t8PYFsQZqdn+GUGDDwOJPbg==
X-Received: by 2002:a05:6122:2051:b0:535:c816:74eb with SMTP id 71dfb90a1353d-537607edf44mr3676208e0c.1.1753041125023;
        Sun, 20 Jul 2025 12:52:05 -0700 (PDT)
Received: from smtpclient.apple ([179.113.63.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b0ad87c37sm2310154241.22.2025.07.20.12.52.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jul 2025 12:52:04 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH v4 1/4] repo: declare the repo command
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aHZChXPTbk_X6xDK@pks.im>
Date: Sun, 20 Jul 2025 16:51:49 -0300
Cc: git@vger.kernel.org,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 jltobler@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <34671B47-21FF-464E-A811-32759D077A96@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-2-lucasseikioshiro@gmail.com> <aHZChXPTbk_X6xDK@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


>> + argc =3D parse_options(argc, argv, prefix, options, repo_usage, 0);
>> +
>> + if (fn) {
>> + return fn(argc, argv, prefix, repo);
>> + } else {
>> + if (argc) {
>> + error(_("unknown subcommand: `%s'"), argv[0]);
>> + usage_with_options(repo_usage, options);
>> + }
>> + return 1;
>=20
> I think we need to print an error `if (!argc)`, as well. Otherwise the
> user wouldn't know why `git repo` without any argumentsdoesn't do
> anything.

Actually, it already does it! The subcommand parsing introduced in =
fa83cc834d
(parse-options: add support for parsing subcommands, 2022-08-19) =
displays
"error: need a subcommand" and the command usage when no subcommand is =
provided.

Actually, this whole if-else can be removed. When an invalid command is
provided, the execution is aborted in parse_options, so it's safe to =
assume that
fn is a valid function.

I'll change that.=
