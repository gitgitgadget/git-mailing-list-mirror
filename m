Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987DF318149
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294931; cv=none; b=O1TeaR7h/pxRaYwpOzusKFHl+rSpkoppCForFFMkzZxmRzxPP1QmuzdHYl1/8J5C3isYssdgWf1BpBhu4AOd6vsdUFDptY2lBc8dZniUEGwn58lBMcbYVejTEObu4SqtH50w+M1LrDM4dHP5+npebynXUzWhRhwEqRtKHfroqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294931; c=relaxed/simple;
	bh=FQFTfK3jkPfs5v0CkosbXbh4buCTEHnt5wo6mOSNgD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+SmCegEQZRaokY4L58ZJn8s3lAF7Fscv8iIZhlcyS8od4srdLaTkJCvbD3kZ3NLWVdIp/RH/rAToY985lGD733VREcrpB5osOHTB7sLs2BXecI3/uz8wuBRdX5lKxhy3vqmhwqs4DVXEBz6FeT0Klh6Ur+JJlkL4DmReOqZjY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9hPG5MV; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9hPG5MV"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-35ed01a7fc1so17706891fa.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758294928; x=1758899728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+m4jQVSlIkwdclw1T31Bytkcul9MkXAYkfcrIGi+vA=;
        b=B9hPG5MVHLmfBoaHk4B0ku3nZduVvUPZUSP16LUNUVna7LQPxqYpVjFP8eDlTS1pAf
         7jhrEAcWCIbrSFQ3jal1yH7sMQc4OY3fuDZDD1fYkZc9ZwX6Bbx2YyCGc8bapR3fXFir
         p9jH4ywY85xd7uyJFxF7JtHuCVVPO6OmhSh1Ckqn9FpoO5PhX2ao7z5pMpQIusIh8tLK
         P9V27kwSmtCDC0qQuzP8S8uljosTubFqX7lRsVNJqDY/IZvFdT5CUJbEUhkHuOhX1mL9
         CSN/C+lLwnjtC3OfI9AMsXE7ojSga7HUCTvK662HJN7u4xePsPMY8tL6s6PNlj6EV6B3
         6EUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294928; x=1758899728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+m4jQVSlIkwdclw1T31Bytkcul9MkXAYkfcrIGi+vA=;
        b=lCBjJx/ks2anst6/kdCBVqwZj+y041RyGnFCsz7pdVEvJYRRrfbYep79PYb3wY2deP
         NQTZkNRR8w7lZsCXBRE0WpkAgZDdXG6Ob+bpw0UZbgMdeibGJht9nO/OoIZ8JSq42nCd
         DK88rzuqzHrnSGlC72X13jPB6WXM4NZ5JRImjYrUko/x0ukZlh9JK33WmjBQxRV9e5OV
         muaxcGj053tDSb1CBuSNEtYVwZ4m4a1nQo/t/4tA/Erv5nT8Ldjim4SNdvD1cU0uHZdG
         px+MpH+I/5rd/U+d4rsJxi1qJN3EyKnabwbHQKsUgFLWpGvtMJZTWWykNqpfgsvyEah2
         3+8g==
X-Forwarded-Encrypted: i=1; AJvYcCU/56gN+0diEczYY3HrB0uVLWPSgmvahmWr+M2wK0x/WbvS5k8l4Ub+79YrwkoUPM4y7R8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaQDqXa2c/yiXLddmxHjeXWbOBEfIim29hjojR1R8LCkvBnk+b
	XcBS66vE3dPe8igH7YAg7gs+VlKsm0lik2OD62vTe4JVK9kWn4xM98qB57uTWry3MM1K8ooCc1P
	/oQPg2wFvdS8uutZOiGt4WhlIbvizJsfcSzTU
X-Gm-Gg: ASbGncuphNMOgDNvhndlK541ei6StEcgPwuq8WBWSOPxQJkmgTcWTtjrYpqX5SBCi+C
	lm+644ANhE06J1s+5LbJu74qcrEnscovNqgW/Rak3H0Kc1Ncrc4Vha53uXqjKqwcW3abutTTNOS
	X7Z3wWeBu3OkB1LUdGRyVHEnxan0AN1M+nI7q1ThsqMS1DjkwB0lIhNNSKXaqfmpqwn/A4QMYNE
	eLt/wPE
X-Google-Smtp-Source: AGHT+IHwm9pihODYmL0oy2wdduazmrf96pOz2tP1VF/vk98ugd7vKPAz70EvKJCdyFbxjHDZnclousdmUOEKM85JCpw=
X-Received: by 2002:a05:651c:439b:10b0:337:e0e1:d11e with SMTP id
 38308e7fff4ca-364147bbbb8mr10035841fa.18.1758294927437; Fri, 19 Sep 2025
 08:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
 <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com> <xmqqa52r702e.fsf@gitster.g>
In-Reply-To: <xmqqa52r702e.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 19 Sep 2025 09:15:16 -0600
X-Gm-Features: AS18NWB78nM5TDcFQJw4xN6LlZbqeMTgiXW4URRDXLpXwkkENC_7_dOyyy81-fY
Message-ID: <CAH=ZcbAjvOxzVN6NekrjwDLzuuZq6eTMFF2Oum=phNxmHLSkcA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Use rust types in xdiff.
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Will see if lore.kernel.org catches up in the morning and process
> them.  Thanks for working on the topic.

Since patch 9 hasn't shown up. I'll resubmit with a slightly cleaned
up cover letter.
