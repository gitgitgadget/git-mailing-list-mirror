Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC60121D5B2
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517829; cv=none; b=kQiNP9K7bmiYdeERbZL0g//WJCuiqodmN3itKu1/8I1jRPE1mSrOj5Xz8lQQHtKzLkryKD1BW3LcZv7hKGCtui2coaxJQTSqQn5mFVpHDnfiHE/SdpQuXHVcf/UVGJRWpseY2HRHDkx0wUtv2KeA+rpkv96wBgfWFTRdF1vUlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517829; c=relaxed/simple;
	bh=AYoOz1teWdJITTKzAm86AXwv1TDV8BhiEokEtyk78+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7KPclPokFgMQBk0hzz2ayUhNgMzQhhRdzbHBcGhbBIKEfMnQxxoyzZaKJinYsGLpid1nDqcHFyAkC6u19IEYDyyBXeaEQLlagXdPU3okziXR/RJXd6R/PWVdi+xyeCxQoHXECpCNBa6anB5JEJu12jNDzc4EOlfQpxvSfHTojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CILBGf40; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CILBGf40"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f4b7211badso7832741a12.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 00:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746517826; x=1747122626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYoOz1teWdJITTKzAm86AXwv1TDV8BhiEokEtyk78+8=;
        b=CILBGf40ljSMPpBE8NPGOhlsh+KW/l6R1ZMefWAlAaBCP8EswnF4X1WT03m7QKjQVi
         Surt8HeaE3E6a3Wx35tMIRvivB6L5e0s8OdjkqzG+WOj+oAjZIcj0QeIGMoIY3HQespI
         gtHD2WMg7mV8wCeqlzpx7sk1RjcLZZqGZ1tA7cPB/bQ+dPlQf5hOloxoqjFe1bRxZOIi
         YYZ/qewrrsOGYMrcyVbUBSt3VvvcALPg+LTTCanOOY+hvcrI2fEoyndUM8Ud9ViKcLZG
         2ui0AEqWfTLeQXTgkHpwTFPfs8SuuN/X/0F2lRcR+CPkWq0VTJLXFg4cmlKe1p8VgQx9
         5kOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746517826; x=1747122626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYoOz1teWdJITTKzAm86AXwv1TDV8BhiEokEtyk78+8=;
        b=vk7v7i+zzoE/+lkul1bhR9wt1bxsm1tm/wDuu5Fqp7tfQLkU8B6eldoOOB1Wfc3rJY
         d1qL8DAZP2IHmVci8LlPNVa1icTLohWvq3ZPvE288rr51OO4+uKdrGqFWRXaQ/1OBnKl
         IK6biu/KEfYtoyiBuL05Ind1JymfPRB/KmEixm4RBexKU198KsFMfAE1s3Tj/rQs9OcL
         RrR6FauQ5M+ZHX9sUOVEUbKQKhanhwatclqUKBEXH1eCT9uE8Dss1LOp8v9vFfxaUBbL
         WxCXaJafM63n3Bs89rRKfvJ/9uwMGGWVJYjG3we9GHKlXMuVKsB9pYm+ICP5ZaUUL7+k
         VuFw==
X-Gm-Message-State: AOJu0Yxx2Sey2gC5qi7OQcCibuE6cPCt39XMFcrvdfOoFUpuzYmg1m7r
	qs2GEhpCL6b9ydOCsboXOVZ5D9npejmrBUklCcgN9k2pOgkDfUZ2qC1rEcs3yZVruHmxWBiBiG6
	wNHC7jg26a7YqcqZEYPsqJAZdC0o=
X-Gm-Gg: ASbGncvUBPuf2SxQXQmxlirPv9ohlDCvZlYh2P0T8gCzH42jNhCB1cTtP0PKRkrwsI4
	EPgtHPedzhV0O0g5wRwBSkhE6Xv89ijmsjmxVvbW4GurkYVT8gDhqMu7TwDm7icWru/5UX/9nWW
	+0K0ptMMLKXOg2qyllvVvor3EpxtAstA8MdPDKzNepbqMUahWsDBPiKz2LQxxCpcke
X-Google-Smtp-Source: AGHT+IFLdBUu1bA3SHxTXYbm5uYSezSIdIqJIxJmc0HSi0rcW7Hhvj63Prh75GfJsw29z5PlCHksx95jiPj36tyqaB0=
X-Received: by 2002:a17:907:c305:b0:ad1:766a:9441 with SMTP id
 a640c23a62f3a-ad1d454f502mr187982166b.23.1746517825676; Tue, 06 May 2025
 00:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im> <20250505-pks-maintenance-missing-tasks-v4-3-141f4df906a1@pks.im>
In-Reply-To: <20250505-pks-maintenance-missing-tasks-v4-3-141f4df906a1@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 6 May 2025 09:50:12 +0200
X-Gm-Features: ATxdqUGkajlSnHm2EuHOFLCoe-JwrMGyNePhQaBC8YOSQ4WGL7FUNlQ8rigLn3w
Message-ID: <CAP8UFD1ZtYMf0ja75AV_jGJgzAL919zpHoGy0v-G2tNV+OEDwA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] builtin/gc: move pruning of worktrees into a
 separate function
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 10:52=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Move pruning of worktrees into a separate function.

Repeating the subject at the beginning of the body part of the commit
message doesn't bring much value.

> This prepares for a
> subsequent commit where we introduce a new "worktree-prune" task for
> git-maintenance(1).

I think it might help a bit to reword in the usual "describe the
problem first and then say what to do about it" way. Maybe something
like:

"In a subsequent commit we are going to introduce a new
"worktree-prune" task for git-maintenance(1).

To prepare for this, refactor the code that prunes worktrees into a
separate function."
