Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6CB3B8D4B
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765102371; cv=none; b=dQBiu4owVVY3MtIg9cGv70pn+S3HljYFhyNDqtfJWEVyp3lJbBaadoZtNSDjnogLtDVY1Xv/VgpeytXJBjXy750gdc4Eqx3QZRCdjmFd5mRBaJqNBUjiGmm2xIwLFrGIq3GnCOAzK9vwNLRnV7FCnIyWqnNB0Wq9DPvN1h8n3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765102371; c=relaxed/simple;
	bh=mHJVwtrI8Ee3vzrXZj1iB1/9UChsDi3KG/ZNQnghp2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=b7GqZk4J9mlG6hCqP09Dp48wYQ5pIwKRulpDwgvxIIf96GuZdfH5NL/DrNpn8lae1m3wj9kNae+UOzhRR8Bk9787EdHAjmuQogniEsPKyZWJGLgDgDHtKzcX4MxGIlgzwxXVbr5k/a+4xAbfAH33OZ16GiW/2RwHnCF/3OC3qPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dj-djl.com; spf=none smtp.mailfrom=dj-djl.com; dkim=pass (2048-bit key) header.d=dj-djl-com.20230601.gappssmtp.com header.i=@dj-djl-com.20230601.gappssmtp.com header.b=yfU5b5wD; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dj-djl.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dj-djl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dj-djl-com.20230601.gappssmtp.com header.i=@dj-djl-com.20230601.gappssmtp.com header.b="yfU5b5wD"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37a2dcc52aeso31646251fa.0
        for <git@vger.kernel.org>; Sun, 07 Dec 2025 02:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dj-djl-com.20230601.gappssmtp.com; s=20230601; t=1765102368; x=1765707168; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHJVwtrI8Ee3vzrXZj1iB1/9UChsDi3KG/ZNQnghp2A=;
        b=yfU5b5wDC2yXBLklzc245SatQDuZoB/owswdy8XfsVJHztts73zHUbYB+ptASwUa5G
         Us0SWaAuCjko+kqvqSMDTsUACHRqRja2HJi4gXEmeV9nSuyOk5mBFkUvbv/VbvvDQpIo
         N5vzsAdJBp4MWSjYPR05o2fwGIFgJTyCvLCkQZUXSvHAjzcy8hKua4Wtk/xkayeiLC0k
         3XZvy7dZ7nYGZkqsx1jwFfldf4BhmHgmnjWOOnaX505sLP3oYsk/ehoLp9R4Lw1DBOp/
         EKZ27cIbd7w7Q9xoh95hDqerAJEI7MsXslv/e5tvyxC4TWujwBvUpPiwzFoNC2h7awnn
         32dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765102368; x=1765707168;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHJVwtrI8Ee3vzrXZj1iB1/9UChsDi3KG/ZNQnghp2A=;
        b=Il8h0tTiDDAcgq3C2sSJRbdV42QRaENpGtrwjp/MoyO6UVllKpN1/Lh1g246RHMRXs
         TFr5L/EMJsDGo5SajvXeZt73V/JpyltTi0k552azGMIb80Gj4Zx9+BfFVN41kPfxdJCh
         cBSRFznPa4SALTg3UXU4fJQLnsIhAaH54321j65EaXmKm6fHOejhnKwhs1ruRa4BbzfT
         PczoVMiYHatwz5qbmAmgKDCQ6vur9NXQ9j0HUK2bpU9AmhUTdh1+yHxyJaK814lx/yOu
         evhX8s4YC8a/RqEoTlcqKFxRtbJDavkBLgfdH2kq+pRQTGWtzuR0knt7B42wUfVgXKBh
         kppw==
X-Gm-Message-State: AOJu0Yxwinel8k5pvzRq4FDrl/FJkhfQLbxI0iOwTzVsiAWbi+UuO4zK
	xF055js337tK2kyYYl8lQw3SigW2WHoxGoVzShaWaE5jDvAc/QgS6exwR+vw/Ma/Ek1PvvenVhF
	CcpbjqYDNma1955wa9qVIUQu5bQyw8ursjAh08YSDFuub+rZ4atv/
X-Gm-Gg: ASbGncubAnzaMKEF4vGc+VwoGRhuA2OeACith0ltdSxGVxWmWI2OnVs2cwzKTxk4drH
	xQ55pSEMp+f+lkD+GQhnZeIVW4RUeO6eqTfNCIp0vur9z5Ng/9Z1VN5Y78gH/xawbjVAaAicUr0
	YcVPLdrub00RrBsRu6Nyqk86ocMLBtfdGdLLiLCfAEOhwkDccNtkA4Z8bYmGIdBKRHgj7dz0hkQ
	Y7BR9MTDAqUspSY/FhOsmjRedEVEdBzrBey11z01Edf9wN469J4AZgt2qlQCDQPLpaMOkTefA==
X-Google-Smtp-Source: AGHT+IHpufR3KLZx5pJZiuN3oKcvfHQA9krf1CYatRKrIXH4+jjamVEv9ZT6yAOfVTXyUlmVa02fNaeBGeSkAxsmuuE=
X-Received: by 2002:a05:651c:506:b0:37b:b9d9:396f with SMTP id
 38308e7fff4ca-37ed840a2e1mr10530171fa.43.1765102366771; Sun, 07 Dec 2025
 02:12:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOFvV7kFm-A2_i2URg-2wgfTet8Dv9SMAD0Aw1AwStCJm5WOLA@mail.gmail.com>
In-Reply-To: <CAOFvV7kFm-A2_i2URg-2wgfTet8Dv9SMAD0Aw1AwStCJm5WOLA@mail.gmail.com>
From: Lee Smith <lee@dj-djl.com>
Date: Sun, 7 Dec 2025 11:12:34 +0100
X-Gm-Features: AQt7F2pbWOKr411ZBq2CM-jqZR-LgWtQw7jAB2F80gdgM49VD0pWr4_FsEPpqJE
Message-ID: <CAOFvV7=DjmWhdoRK=f7ON7gRzaHSGWct25SCo8T_34XBj6XFHw@mail.gmail.com>
Subject: I still use git whatchanged
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I use this regularly, despite learning git after git log was added.
Remembering all the different options is hard so it's useful to have shortcuts.

If it's difficult to maintain I can understand why you might want to
remove it but I recommend adjusting the message that is shown to
suggest adding an alias instead.
