Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F6924679F
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913714; cv=none; b=OKHSYb1GMDzEiZsB+n/okIuzyzQE/kYJ2/Tkfuv0mQ1nr8S6bSFT/k7P1quZaCH2c6qIsgyus0p1/8ao5HDmeVGPvjbiAm13X9fY1HYrIoTYrAJYd4mu744bJhwap3tAJ2c8Lo6Byl1r6PGHeOGCuT+MMlMkdQB2qZ2yr4/XXuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913714; c=relaxed/simple;
	bh=s9zeI6ZyI9wTRry1si2iLlTKEmPtXFxjUoUn74/z5xQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tcRveuXM5T1bNOuvPYYMsjobBc0VR5dC0LpocTOA1MLu9T7uxJAR0OM/dxODUAGod3U2KFb8sqXSZh9ovxBy5hP6n/Ne+H7OKfuMwKDqHQJOmZHxERxg+2wo/XVjp4CijGacCYQKFCwbwEW4MsJ347uh+B99Mcwh8FDqEwAkfuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mbuki-mvuki.org; spf=pass smtp.mailfrom=mbuki-mvuki.org; dkim=pass (2048-bit key) header.d=mbuki-mvuki.org header.i=@mbuki-mvuki.org header.b=EUFUunTx; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mbuki-mvuki.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mbuki-mvuki.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mbuki-mvuki.org header.i=@mbuki-mvuki.org header.b="EUFUunTx"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d60528734so317447b3.2
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbuki-mvuki.org; s=google; t=1756913711; x=1757518511; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s9zeI6ZyI9wTRry1si2iLlTKEmPtXFxjUoUn74/z5xQ=;
        b=EUFUunTxNKcjLtW5W/UvG/8/QyD7q4Y5mlRQETbbgoLdvP51Bm6ndgNE7vvYHrF4Ih
         E9T5hRsUxPWM6l8XKOS13f8CAJvqIYSsqu0nHjx8pUZdfwtS7ldQ1IjI8c0N7gBe4CHq
         qZE2UUWGoZQAdWPaHw5gnRuSovCy8TlNaFPhvXCAIqhsQGOypXtaTjr8lG0GlqxigcYY
         kwF6fNbC3S/1zccg82WqPnPFsBN8IsDXxnLkAOAkMDnujOOhlQm1Vr0uFPVhzYouMXKb
         NFTva60oOgW6oTx+yZ0BYVlMIpHQ0h8MEM1c/aNxEX04dDd2PDpvj2nTvFUsQeJjIL8/
         ATeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756913711; x=1757518511;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9zeI6ZyI9wTRry1si2iLlTKEmPtXFxjUoUn74/z5xQ=;
        b=q5Qo5HqW5+ctwVAGWBtIuMhSPDia60j8C/L5CE/dSD+xtx2xW4id36ikSWEVLSMZw0
         0/LngGNhDn7aGOA7rA2TfDH12Zh+4z1y7YgOIj2gypmawdOBfcWoqa9dt6LdyNrsUmYp
         wIhYFbS8ehrqvzX9+c37xqbqNFG8zwj66T0/sbiqbkpk/oLv2VGVi1xz+oWPm0XNHKBs
         bZPc4yLzukJNx4tngyblk5yYs1hD9TbznLyHR6CrGxHo8LrFQ/hxnWlnaL1ABuhzir4P
         cHMRJ/34Ke5Tf5trBEg2hm0ZeNjYrdq5J7+m5EqDoeP9uwztkovWsI1i42u0/YvoXh3M
         cxGw==
X-Gm-Message-State: AOJu0YwQHGIqxUDtFoeb18eVSrdierbkjGyPlOcQoDbNmPFs1Dx1ZSls
	eC67PKzeKP30wEjUnBHLWMc6+7h2pIUUhMYhM8PePQ1Ok04Sj68EdHxyvflNZqvVsRHpuLuS4BQ
	L1i9SPM8mtF6iuOo1mxfwviOpXg/a9323jq+icHf9hWGzXbN2kJOEpY0=
X-Gm-Gg: ASbGncuP7IhOj++qytnUBFMMye31/ilLGrZheo8sWz6xcWAIALSu+W3UOJSv1agaYnW
	uUMddR5k8O/GCk+JfW6x42Rcgh1ez/YKS5lJMLt1g2Az7ZBKLUn/Vxeb+9Uf80jWjRPMrKedTDr
	tR2ZdnMLhq6eXIHPZlHnWKLJgYkv0bMKgmOJE8xLWN4XBtomuzi7BJkMKVz8A1TtOyC2b0z2MI/
	I9aXaYrAvM7jg==
X-Google-Smtp-Source: AGHT+IEj/uuLZ+tb6Lr32zeGhtfsoW9axp59PfLN05l6DUWQhu7b0u1tCujBh5d1rOIdmnQDfTPSWeL9omLaCAoFMTE=
X-Received: by 2002:a05:690c:f86:b0:71c:40c9:b0d1 with SMTP id
 00721157ae682-72276134719mr187853937b3.0.1756913711172; Wed, 03 Sep 2025
 08:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jesse Hathaway <jesse@mbuki-mvuki.org>
Date: Wed, 3 Sep 2025 10:34:59 -0500
X-Gm-Features: Ac12FXyy-r_DjSJ6yRia6Pn7__edpFjC5eCnxDp_CCHdVhPsFDCbUYrfM7POiaw
Message-ID: <CANSNSoWZNx3j3eLAayW64iC+bvC9XfetV+wZAkK6Zy8Zm0DWSw@mail.gmail.com>
Subject: git whatchanged
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Git developers,

Thanks for the wonderful tool. I still use `git whatchanged` I realize
that `git log --raw` is the same output, but it doesn't have the same
mnemonic resonance as `git whatchanged`. So here is my small vote to
keep the feature. Yours kindly, Jesse Hathaway
