Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9422318
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 02:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752199549; cv=none; b=G3JoqwZ7c+MgHFEQVs8VEBUAHW61XF6VsEbkN2mZ5PzGXqlgnM0atahocLOM38pa2D3vgidIvAbsew75wxwkm6ZPN8nrJjTf3pLx196qcE/8bAo1bV0miHyRhkah4DUwVVw99WV3GrNQg03mEQf3YmWD1DF1S3aybp43pzQX7EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752199549; c=relaxed/simple;
	bh=Fd7mtMvXcDgS1E6ouMuJgNdxQCGZB8k91K3BlzB+Y2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYoubrTEXpEoLidWQ9ojqfSfL+JS+bb5ZEvkUAtNBEGe+45hTP6W86p7nK1Zm7sBYLtN/bH4XdN3wuV1EpLyuX7vZsr9pLOy8bHCVPWvj6/hdLTBT14UGM6RrNcu53eunb7hTWsocIt05csYgaXMLFd2FDwxduHBtQ6FZ/E72XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kv5MfgPR; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv5MfgPR"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31c4a546cc2so656942a91.2
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 19:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752199547; x=1752804347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hot+ohH4+uphVPA7yq6e2FzSdqX5i0WRHdhtKmEThrw=;
        b=Kv5MfgPRYTrYcorTUIT1IX1nJTNGtMX08J1Y5FGCQ22vndP1++7Deo+b8ly4KrozYI
         XaW6tUUwOdgSbGWZqUu9+5rufnCkJ8lfn8ljpdzay8A/i3Oy8vSdyOa1+bfpZ88RhSzD
         /cYXRMfTdO/cPHpo/VO7yN5DcgEPoftW26hRQFJ7Se0gogQ9ZJxsghsTxQLCV8HDPx8p
         LC4YFDi+cbf7Sgsqo2hKJ6PzpO14SRB3b8B4vjho86mUJvREYIDjbz/nzTRrJ4+XQkHi
         wSPMRS4TzSgaxUzuacDJYjXqPHFA2cvzRsyTdO17D33KFn5gweuyd3IzukTTXA4fgAV5
         yzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752199547; x=1752804347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hot+ohH4+uphVPA7yq6e2FzSdqX5i0WRHdhtKmEThrw=;
        b=m1Qhui/T3h7Eg2TkaYAWGmyXz7I+YHTAdwlJrd6pyzzrRaNguEpmjX+WHuOzBECzJ+
         MdsGu7POrKEIdAhkeTnoJCgBoRV5JTMrtFsdbrktY2wuUWk6Y2nphm6dKu2pt6WPe0w2
         vbUdm/OEME9pc3DVUehBp6daE6SzZeAtfI4nLsFeQjKE80fqhLEhSvnIFeLILmqDnGuV
         N+bKu4HPS7yqVHqfv3c339I4CVSwFn9zeBT0u53+QXRPOTfaB4DvPYi57IGGRLjUt+yx
         Sgt98RVinLvlGcqP5U0OI03y/o+Z47HW3x6uvPitf2RCDQcyI1KK+tfp7QGNsLLrvCYj
         j4Sg==
X-Gm-Message-State: AOJu0Yx9P8sKhfpiH1fTU9iqxlMSQu+a4aRPy2Y0S3UET8i9X3+oQq1w
	coa43J9aP9q880rlsUXcLem6sQCev35PS1I5JuaOaHE89TQpNp3/ZLyF6rApKrgwCU5OXoxw2+O
	V3gEjz2JY4Vre5rdblqSgc7MsaZrOUNc=
X-Gm-Gg: ASbGnctxhqOTXFpb73Vo9UNMocRQQqBKLHzy7hQr2GJgDtsn8bT0QUaQmqidUPOYOeJ
	gJ1INIVIg1YS0gKc1Un6GjKrpjiGXeaUTh/UiHtfYhDAG5TA1FV/cqsRsq/TkOG3qFtbwwqg5y/
	pE7efyWHhnTg30/LLDOGa7KNpmwNI8jy4cOZq0/HZEe9IvoBml90+6Ik3fYJrflW/r1S4hyftR/
	uLjaE1z54XnEV5PczflflC0QatDgpEygaPDLa+Exw==
X-Google-Smtp-Source: AGHT+IEoFAy9HtV9UGFGvV/XJV8Ul7ZtLinN6TZEe5thWIxO+Sjc1BOvbZGpziIe6c3q//mME6YJzEAQVDyzafJmrwg=
X-Received: by 2002:a17:90b:5144:b0:313:db0b:75d7 with SMTP id
 98e67ed59e1d1-31c4f54a12amr1219964a91.27.1752199547425; Thu, 10 Jul 2025
 19:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqv7o08ocn.fsf@gitster.g>
In-Reply-To: <xmqqv7o08ocn.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Fri, 11 Jul 2025 07:35:35 +0530
X-Gm-Features: Ac12FXxm8enrJy8HboaGJrbzPrNVKPpo3n_QqaEAGc-KKRjvWQ9R6nJY78X10Lg
Message-ID: <CAE7as+Ze8EHda0wMfRKC4z9jE0OLsxxSgckBLisJuoxasgzTaQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2025, #03; Wed, 9)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, Jul 10, 2025 at 1:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
[snip]

>
> * ac/deglobal-sparse-variables (2025-06-30) 3 commits
>  - environment: remove the global variable 'sparse_expect_files_outside_o=
f_patterns'
>  - environment: move access to "core.sparsecheckoutcone" into repo_settin=
gs
>  - environment: move access to "core.sparsecheckout" into repo_settings
>
>  Two global variables related to sparse checkout have been moved to
>  the repository settings structure.
>
>  Expecting a response.
>  cf. <17b7f51c-0c3d-4d63-a501-47ce829f7345@gmail.com>
>  cf. <xmqqbjpuqkrj.fsf@gitster.g>
>  source: <cover.1751309770.git.ayu.chandekar@gmail.com>
>
>

I have responded to your message about keeping the topic in 'seen' or not: =
[1]

Thanks,
Ayush

[1]: https://lore.kernel.org/git/CAE7as+aTBTx8rZ467uv9QV5Wiqnyed5ndY-+smJ1a=
yYVx6qmRw@mail.gmail.com/
