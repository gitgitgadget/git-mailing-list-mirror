Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0AB1FC0E9
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 01:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742692326; cv=none; b=d9kd2EOTH4/mPtrmWsKiLJi7azDH53TZ08MHURQldbVplVWrxnGKujzPU3euqxiUpLRXzJGoOoZx8wcDwZa8iTwRrcIupEjbduEMYNuwBW+21K/KJPcSMcVm2KjTh3UavWzlRF3eGLWsSbYA1dQDJMI/WdRxMNXWvULKaRs4tmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742692326; c=relaxed/simple;
	bh=cLLUg6IArN200Mok6d3Fi3FXmh/HqUyDx8LKyei/Q0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMvuroAHsBFOfemTbRJNQcm2GlcKXuCeIC99m1UR1TV2pXUXTyLPcA3ylqe7nhxZEjXnXX+e1tGcOWeI+VUbvd/ZbiVYR2zHQXWdxfjfa6wssTYgBL42gGchRh21AmU33On+kjdNt0xXV7jXMcq+sdiCdmI17puu+kKUCTTXdYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lW1X4kak; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW1X4kak"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso31325211fa.3
        for <git@vger.kernel.org>; Sat, 22 Mar 2025 18:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742692323; x=1743297123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bz6zapKBtVc1qKWVGTzPYdApR1KpGhzCQ201zfDBrqo=;
        b=lW1X4kakbSbrrZOUtE0nlxq2rSVT6JDO6nJd/mIUuk1Dpu6sGc1JStyLxqDdKJdcpB
         f3J7qUlzIef/3Z7n6+S5VHZI2dcjNAYWfXiJd2CHJomahuKd1iQW8fFoT+uCGGS118Dc
         QNpPyyw9BDFGwanNPBBN3O6BrCw+WPjJAAlfi+ZGVBDbrAECYzarXEg4fFNreU/ApsAf
         abNaZreoht6UZ9/CTVxPGTvgFF2rP9ndVmCf0C5Zoo5jOcw03UWD7gCOTMCZcuLsXe0e
         zIjWWeNn5yuIbVyzdJc3J8DsDyCnnpEqyWclAqrsxbitQw8TR3BLqQvKceITrqro8emj
         3h8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742692323; x=1743297123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bz6zapKBtVc1qKWVGTzPYdApR1KpGhzCQ201zfDBrqo=;
        b=ODKq6bM7MEOrrVPzP7eCw6uQJJXjtDxqvu1JD+b4IyWSUIB9OHRMhmcEXSOUqlOd99
         B27aU0I3L+U+dgYoqUQ6B3ufhG5leIJZ78cLGj2tJ3LnBEs6Zkmzqwy7pkcioDYf1d4w
         XAhmkGTuY8z3t7f+LTBxYk9VuXS4BcShIzOycXxR3mMOlzdoHSAkbimdXgAirb/Mxp+Z
         IyEPO4/80IpUi56+1bJGKhG1QO60tbfRVJV743f9xf+QziFcN+PISCDVVywrthMkfQnu
         GUb2TcSBs4JeRO2tAHqXGY4TnJV1sjjNd9yCK6DNdBfkcrA2BioWZXj/FpaORgyreeie
         VKrA==
X-Gm-Message-State: AOJu0YxC5Dy5hRYQBT9QPYdOOXyyI6Fu2TLpGEVEAem00g67WswNFBVH
	Kz+q6tyfVbWarUunlJGROdLnA4IBwenanfm7OgCPF8v9yACzfGMRRwkMILhddfaazfs/Y8oKC0j
	irpkzWb6Yv6bPley+UG57f5P6SDo=
X-Gm-Gg: ASbGnctMx5qwdPUs7lt2vjghjk57t0QJyZy58I4jw5krYynyXmjy9CwsfB88ciKwyax
	lAlcy+Y6r4kduRD+Vkr7+pXgoy3TeefahvKgbcKb+23yGDlFbGOJ+f8YMLaO/gB9Y+bcpQuE7Mm
	2+KTwo2IGp5HFONTVhay8c+YorEdE=
X-Google-Smtp-Source: AGHT+IFIzGACDoH44ZijNGNu0r2kgm0vE6bBdvJBg95J8fS1OGX3Od4NdKhIzCoBvuodlfb9g8wsOJBdipEyea83fQw=
X-Received: by 2002:a2e:9087:0:b0:30b:f924:357c with SMTP id
 38308e7fff4ca-30d7e223dd1mr27711071fa.15.1742692322528; Sat, 22 Mar 2025
 18:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1930.git.git.1742637713157.gitgitgadget@gmail.com> <pull.1930.v2.git.git.1742688740650.gitgitgadget@gmail.com>
In-Reply-To: <pull.1930.v2.git.git.1742688740650.gitgitgadget@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Sat, 22 Mar 2025 18:11:51 -0700
X-Gm-Features: AQ5f1Jq_95yWLQYOV_6LtRkHoVEzAeS2tH805Y6IJm_wDMuK9dKE03br8vmvVYk
Message-ID: <CAPx1Gvd+0XBVm6N6Vrogczhqy8hARajoQ+zDgaaeKMTcSskmeA@mail.gmail.com>
Subject: Re: [PATCH v2] shell: allow overriding built-in commands
To: Ayman Bagabas via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Ayman Bagabas <ayman.bagabas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm not at all sure about any security implications, but aside from that, I
suspect this:

On Sat, Mar 22, 2025 at 5:13=E2=80=AFPM Ayman Bagabas via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> +               if (!access(full_cmd, F_OK)) {

should use X_OK rather than F_OK.

Chris
