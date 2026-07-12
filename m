Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ACF26ED59
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888896; cv=pass; b=MvCosCk+U0GsQ4OC6Q542/CTFYx+GhFjYFA9BGkVT7XcE+D5PqeUd8TTNWWGQWeX3Vr7m9FtDk/ZupjBcFHFdAg9oZvuR6vzvxasuXhgbE5ZVAoLLM3DOh3fKic3ktQ/Gx975GeHCmOUAQKqqXCdLI3KvPn6dApf1tY3qErEF9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888896; c=relaxed/simple;
	bh=qADGeqON/5g+RcBI0YzpF/L3GZMlnCk9fvB79LVOKjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taHh1CgSOO6355pAxNcqWDWkNsGPl0lN//JP11Xxt6bS+/6188jUN5o+R3xgGxLomq+Mzyx+kI8wRLR/3lcs6pnq9Nk3Ec3b/A8Ff3ucOuUJRXaLPxO6bvpIDZ2ZyHkHfDxOfgyUON5MdZ67sa6NVpv/MEq83G1CaInMkx2M8dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKqqkqGZ; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKqqkqGZ"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6a1160a2c42so1619441eaf.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 13:41:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783888894; cv=none;
        d=google.com; s=arc-20260327;
        b=SY7ZA0p6CbVcLhXyKKvGe4q0o589wUiPjKOpwPvalFsgGXVC/vAPqX17JRCVzD8GNw
         YapIEXM75CC4H0IlyO+7g6TwFNXgFIqY7OzCLXuDgc5BR0keBzu/jPSVK/ly4Oqu4aSg
         XLsOewd8bVkkQrauLd6czLbLr9+cv4uRoebNk+coK5cLbvCEBd6TEmO7qn4YEgcyz8+i
         Z/ER7yM78DQmclwb68/WClAhPB9WO7peXjmhZ28w5gkDc/5baInkkrmM4GuNfEK+8z5c
         2J70LA6xf+ZSj4gvGNGAmEJYqdpT+M3SXKFISrivLvDJ6+jWLFyA4M/FDG7Z8tjOlD43
         I6fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qADGeqON/5g+RcBI0YzpF/L3GZMlnCk9fvB79LVOKjk=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=K2+2IwYEVBzBkgh03wbbhF1zC3mPDvwyv89gmtTtAIj979wVPk5CoWM1SboXbN3dRt
         aBy46o9wkPFb09xAuG7GrIkIiBAm+AxvT49HWJy1G4CuEQ+lXYbS9RSdz412NbJs0A05
         0cVhXreEj2Yp9yBlXeVqCsz9vzxAhRYtTiYNR43IzwkimmEUPoLBkd/GNp4zmN62NK+w
         B/CxPlqJUqEIWnXMle3JkA5jydxQlpINnVv2I/xykvX5N+5EV2Eds5jbafTwEgkKRgTo
         W2OObq+P/G/GizbUAHnH0TBzrdheNph2cwET1Azsu0Y6JCAOz75WBdXlmjX7vDtjYE/A
         jj4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783888894; x=1784493694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qADGeqON/5g+RcBI0YzpF/L3GZMlnCk9fvB79LVOKjk=;
        b=HKqqkqGZw85JikOltdSZA29tr4+feZWuvL1G66hBXFsIypK1ghNihkx9XBhsnS8enI
         A/X9j8ybpwjvkOZjjvukLK3HJnG1MAN1XumkmVz3sQlbC/ZYCBDTG5dCSZg721kHmwfI
         xAophIhLmgmkn6jhej3fJB/R3RbPMpqw8vBURqVxgXjKQcBvRu/KOTMZM4LrKpKUYmNk
         c1EJt8Pknxz2LwW8aQ5NhTRGF+F5CVJJoSEC+cH5QRo9DDr5Xe4eYUUFhL7+Nhh89T0g
         rol50tbU1BwGKiXwECuySXqyP1fix1YslvQ+4w/x4S02DXAtF3qIcSeCl8VBJM2MavwT
         OZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783888894; x=1784493694;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qADGeqON/5g+RcBI0YzpF/L3GZMlnCk9fvB79LVOKjk=;
        b=VAnFNu9SZpF2dB8f+99zqyaejxu15z5v9FLXWAiqvg4ftuKAtrWaoAWjiq7jCZ0LVq
         6WQDEDZf8UX5g3OZUAylWCxBuGrzALJXKpvMZirGNMCqK6MNxWlRjli+aFYh/hqj4/sK
         nAHft7a7HUKuBQAqVZ4h8dDoTrq/xNEgQjvMKCvGxCHJKbIZ/SSODAN30Ggc9naHfp1h
         cgVWsrUCHIFYodODa5fGY/OyDNLK3fouJdUv3IzkbnumXIuQ4u9p5lPl/nCVJAdpQYTI
         0vHeZYA7FIlQikr5tN4PZASxPFYWR0vHI2LAFpEofMv2wA4+TPC7anNdZiL2K9xxhOUq
         q4+w==
X-Gm-Message-State: AOJu0YzzgwepaR9+O50RjK9O0Rw9s9EmOGzPVA64H4xB3gdcdsrhViRw
	52X6oKG6HoX8TLhY+ksZy+oRLTWZW5QBepSBj94ZMjmqZKJ1vZZVP4XIT9KnknGVnIadwaWb3v0
	P/Ml8tlHgDKgaRvgjf6Aa7C15iBtHZqyJcg==
X-Gm-Gg: AfdE7cmdh3EbWF7YgczCshDLubvsrNoRQYOxaq8bmQiT3G43mk1A68ocrtP5QNhT88w
	vnfuWObW5Q94zutJzqklqddsoSzgegBvVp0J+ML6qnaUN5TJ6uMeDrBdzTU6VaxPm6L3mW+/28I
	Q6QGlcLSNaU7ZLJcDLeSEz/UYcstSCoq+OafaiLGNZoDBcuntiYPTMcJTfYtrWKUT5ILRbJvMy3
	PCdtzdkOZtA2Tm4qX/COXUEeXu1bTgRgds+Ngb9eBMc16L2v87YUoXPNjCjHmFGt3RZvkW4JcQD
	B78sVBBes9WFZLKpAuLUqkGYm8bRHcJCDPVeSEFYSUMWuFH45t1DN6hCLdMsWKw2kzKy06C4i2x
	f2KQUzMkr0GwDrJU=
X-Received: by 2002:a05:6820:1519:b0:6a3:83ee:6338 with SMTP id
 006d021491bc7-6a39a5bdc3fmr4204067eaf.26.1783888894020; Sun, 12 Jul 2026
 13:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711192650.2417665-1-gitster@pobox.com> <20260711192650.2417665-7-gitster@pobox.com>
In-Reply-To: <20260711192650.2417665-7-gitster@pobox.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sun, 12 Jul 2026 13:41:22 -0700
X-Gm-Features: AUfX_mzEKABfmqsk_R2aG-vJsdUSEI5FSQCi2ZdugmLhW8EEq5jd6fs6FwPLB8Q
Message-ID: <CAC2Qwm+30zeMQKHc3onqhXG90wgrdvba28TadF=N3-dD1Ah8zw@mail.gmail.com>
Subject: Re: [PATCH 6/6] SubmittingPatches: clarify the writing style of whats-cooking
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 12:27=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> +TIP: When proposing a topic summary in your cover letter, write it in...

super nit: It seems like the precedent in this file is to use "NOTE" instea=
d
of "TIP".
