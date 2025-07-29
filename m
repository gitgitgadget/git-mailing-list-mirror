Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C01208CA
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753793608; cv=none; b=Ihc9sW6F3h7mtXGc0XX7aSKreuT2LOSqm1gUr+OxL0Wvwy4Q2Ts7/PMQYVdaiEcirXilLHszfZSmGHYDnFkCRWkuqtwvpQzf1lL+zPvKC3DluD91TyxunSq4ENIY5uiUSAVs6vgqXEHuF/JTQU24g9CeUYrX3KaBaZ6tn+F+4HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753793608; c=relaxed/simple;
	bh=9zMM/T/5kNUroe0wQ3UwCW8VBghFekdUbFv6yaJgB+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyU8w/EkUNG1Xnzq4LYirnKl3TXuSWW+3rGpmJ3FgaHZRISDEdCjv2F29ORImfiHiIkNtbrD/PxgWFzkTvUBIb1Vx1t1ujQVDj8lz/ESe0V1Lr0efhKcp6XCIrr2dQpB4tzrXgDiOOkGjXY5N1X6izunJb4ReNVREDc3eT8Iky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvwXMJ+G; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvwXMJ+G"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-31eb744f568so2296295a91.1
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 05:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753793606; x=1754398406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zMM/T/5kNUroe0wQ3UwCW8VBghFekdUbFv6yaJgB+g=;
        b=jvwXMJ+GuAs8n5/KPFP+MxHYUPQLiKLFOvVgUKfPIbC7dY+7a3ATCsXYxdQFa8k7Op
         V6/ZsubaSouRlurCCTCh/5wAHKm8Wp4+Cr2EOoj/AOb2POLFKeM1k9VFNWt2IpCOQON5
         nE82764NSieyLeX3TAPCsAp4HS6j4ArMR1zlDJZ0fcWlCjeayKoPlnBGFK11t7u00pQz
         wVPGi2eJYGzOjQAkuqO8x7tjKkwglv3SLikU4KcYT24RNjN+4tJN5m4shHsUvY6kZx3t
         9Elep6X+AdHG7IZmPJig4f4Vx36d2c3YfJ7mf20UsNIh7/BIY3GEOxXeRj81640QdElg
         6yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753793606; x=1754398406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zMM/T/5kNUroe0wQ3UwCW8VBghFekdUbFv6yaJgB+g=;
        b=nmOV6JP3QVznkzExjQNCFaBnJgJ36p5SCSV4oT9Bi3sgHhkiOKfV3jfMvW8old93En
         2Lb97IbsrCCvV3PM5stRbkh8P6l3dZ+WaOzVuN0rFxVeM3CbO72GKZh2ehNufO4H501L
         zof/Ka7Fv/l1jy1EM8lFczq/IlioAshYb5tI5dYEgE9qEjJA6ZCKgOvH2OKnAFtAtuXo
         oyJTmE1IPMMV5TmFbdvHPnVh2X8imd7xgq9yNaFbY1Bb3+yEoNX4u3kCc/6tHB/HSiew
         lWrc5YNaiog9G3UKgSOZHDejaNK8lFbquN3rqUj357iTEBrL1YZyyNeVjRxTC+CuAaJU
         +bVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3kTB3q2Y7mHJSWPU6DFn0PsNFh/mKY9GqgTgMdl1KzJhuzo6qDPs4LV9RIL5L6Nr48mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylViDEeTo18rZFnwfxYkx2YVHmmGh98wKCzheGP+dA/SMBToId
	Yutly/UnPbOAMHgMUSy0ySgS9WmMx60t169UM1DFTM+Tg47DhpipcTH1FnDbzs5uXSuMhVELFoQ
	T1G7q4zUPBjDximcMblodUCVMfQClNoA=
X-Gm-Gg: ASbGnctkLQPy8ci6C3JzWvLEVMaWMt36SKtnNRrqq/cBkFObX1P45Yzdw03Pmed+sR6
	JRNC7V9rMYLIDtdOUMT5Lv34qZeAHRY90n//yaXFPhUap4F1L0z1Ska/raRKEH8NDY8g816q3+X
	Y6L0OYV7zW7hocWnuksJO74/0h6ssALA39h+jBkKFBHj4N/rVkPySi67uKFccCjNWqIKqJ8ihVP
	omFbJt4
X-Google-Smtp-Source: AGHT+IGnxAY8GypAJUqO9Eno0RRIlgCSDwIXgtWkCb2A2Mxd0EH4Fb0P6MpuDbzgThS0Y+E3QlcwPMXezEl+PJvt6D4=
X-Received: by 2002:a17:90a:c10b:b0:31e:c1fb:dbc6 with SMTP id
 98e67ed59e1d1-31ec1fbe19amr10761608a91.22.1753793606056; Tue, 29 Jul 2025
 05:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
 <cover.1752882401.git.ayu.chandekar@gmail.com> <xmqqcy9qlfm8.fsf@gitster.g>
 <43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com> <CAE7as+bnG6KgA8X_n36pqP15bmyM6re+xEb1MOXKvZSUdJ8Arg@mail.gmail.com>
In-Reply-To: <CAE7as+bnG6KgA8X_n36pqP15bmyM6re+xEb1MOXKvZSUdJ8Arg@mail.gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Tue, 29 Jul 2025 18:23:14 +0530
X-Gm-Features: Ac12FXzyh-sCy7pS876QSZqyzgpiAl8zjlHRqSddrZ5nYaXWmRyeQNonszVyeoA
Message-ID: <CAE7as+Z7mxaMSWb8jrsFP12KU9NPxFu1W-8YhCF-TWE4rZ+LAg@mail.gmail.com>
Subject: Re: [GSOC PATCH v6 0/3] environment: remove sparse-checkout related
 global variables
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com, git@vger.kernel.org, 
	shyamthakkar001@gmail.com, phillip.wood123@gmail.com, ps@pks.im, 
	ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 5:06=E2=80=AFPM Ayush Chandekar <ayu.chandekar@gmai=
l.com> wrote:
>
[snip]
>
> Oh, that is the complete opposite of what I had understood. I assumed
> that repo_settings is used to hold some core repository-related config
> settings, especially since there are already quite a few stored there,
> and shifting these to the struct repository would probably clutter it.
> Given that the existing configs in the struct repository are mostly
> 'repository_format_*' and having Patrick address that we embed the
> repository_format in the repository as they were increasing[1], it let
> me to think that we should try not to use the repository to store
> these configs.
>

It seems that I missed out on adding the reference for [1]
[1]: https://lore.kernel.org/git/aGPcJMfBCJuQLdtu@pks.im/
