Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C28D1DD877
	for <git@vger.kernel.org>; Mon, 18 May 2026 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092131; cv=pass; b=L2wv7zaeWeF0AyyCwUGnO9qhSB8xyRnYxu3dy551SILJPSBvHFElTH6CN9xRgpRipaP5LzWEBcXlTaKMU0xtfhRj8zYfWRTWcXMMliFztnxvrpcu39yfTqVRcqQoDGMCHoE0XRE2LIjwej3Dzm3hcsVdI8aYPRS+VKx0pzv+E74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092131; c=relaxed/simple;
	bh=BUcBtiOzQffR5QfgSDI8XdiQD8stm+DkFkyCw1ntHqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJC0TemUKCpPjdRtERQ5hpOOX4wk0oQ1h8xqRWOVyvDBwe9A0h07TpFzYI8kUEVe1oTZYDPqNAOsZ4EVTZsPP7o+Og3nIxMuW8TjdsKKTHm0lS4ErirkHra+10cF6g5Wz11ovF1B0xpJjNrArqjfBh1pSj1oOc+NmJ3e8OKsiIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4JULuIB; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4JULuIB"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd4f81505ccso318715366b.1
        for <git@vger.kernel.org>; Mon, 18 May 2026 01:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779092127; cv=none;
        d=google.com; s=arc-20240605;
        b=InV1iC93S3sHbCVsMjgYift0TTr8rP9hrd2pMWMYJLQVm+AmQ9MrXG04hbc4FIxMzN
         5owIWeoYxI5q5CUWA7EWDkasjal4wtU4UDEeEwtwdZu8hposZGCDUkvxJuqt2mBpZll2
         030NYe9yXuVLy9kaI0ooc3Z9EfKGpLXww9/XKIxzc7Dyx6SDgnl8ZmBAO09cmnnpmQmi
         nBznV0/b/4SPIF/Gi21u3EHU96UhTjkguA3E4xbVGmBWimONj9O7xY35KaQqabGRAioM
         pd8+dq9X3lle40Llf96kcBKbmtInq7lVNamwJGfXYHNagkXJ4UUbuMD0aMiByoSzF04+
         oqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BUcBtiOzQffR5QfgSDI8XdiQD8stm+DkFkyCw1ntHqs=;
        fh=DadA+Z426OO5zwuvXHi+3r/qyuEsh6r6/bffTzgfg0E=;
        b=lRftJ2yb16x+3H5t8DMxW1nJRjOsBAh749X0JCfxGWr+A5pcjbR2Hts7iqZEDwz0wY
         W9OfNfDnqe4hqL0J+gPRtfB02fsfupmMajhZQwf4UXRzIgFpJ0FIG+T+2Htc/C73i6yA
         bwYXCvBemIx+qlCIaioqYDpD9E0BUlzFVD66SPpDEJWf9pEKS/cS37Sfx224FMFub6N1
         299ipha4ZsLLRRSiQgosZcZPrFpjOlYiwAhCpV1auMlVqCydLZIeb11N0pjb+JZIKsRv
         P8kDDVu3ovAMXEWDX0Fqo8UXRarW4MjcW31ZejmwihqJGTQ8+mc8iXuqN/7kE9peHSNx
         KV8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092127; x=1779696927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BUcBtiOzQffR5QfgSDI8XdiQD8stm+DkFkyCw1ntHqs=;
        b=X4JULuIBHc9B2g724hfQXFOg4LkTHmKqbNdQbZZS0LLPzdw10F8A7UUMK1asBputa9
         Uuzb4Sv78qSPnlh24r1FSiwPiuVORCzjF1N0hDT316LbaPWVZsyOmBq3pi5XbzA1o9DE
         uIPM5oJ6pnFPAjE7hUYbH6QuNCgkC7pLcDd8OfEyZXGGRw1ZWUCWnoW+KQU+sKSj+Y0r
         Xp9MIYo4X9yOMvuJPjKswYMk8bpo1m2h51TeU09cv2CYC/ZO6aq9/ZxC0+1LH8N0jVXY
         y8XAj2lRNJfPiF+jNN+6f0XpbUqPYoSljmQ8vbqCUcity/4eNSw0T8Fen4FJHEE5Roif
         i/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092127; x=1779696927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUcBtiOzQffR5QfgSDI8XdiQD8stm+DkFkyCw1ntHqs=;
        b=XCHXsi79Qe0q4D+GXSipW5G6NSqbTM/JW9eoNnIiKCXgnP/VbjnyMr9xBlVY0J4bXX
         SsN/3OeK3/3oiw/McOTT3TGipekz2mxse2nzGVC7c9/788f2lN61NbspA2LHGJ6071/a
         A5TTTjVtT9nFI0gAvUj856s9ARkU9pr7EGslY8yL8FM4sngTXJxcI4pCBcCuR0RMKkG4
         2m75TNjgQfl0+tsaHud3lwBBiinYLm+07nm8+96IRKGENsnrGphAwcW/+gTts58/kzFK
         1m1wUhwTLiAD0b1vL532O0TXBAYZ2wKkNEHQjDRuv2bgsvbFXTijNHPxWxZgPoST25ht
         spXA==
X-Gm-Message-State: AOJu0YyVmjw8esrlnePEUXB+ZekN/D5viw1rdjMKRtEzVhh9XIBdIaF8
	9jJanHkIO4EEp7byC4C4vOk6+zLRw6vgsOrSUZYs98h3Mbt6SNqLFGPc1ToAr/ZO2Q+9AJIeIbf
	1EBSRzhBZCH9+u36CcOBQmupGJj+PVMaVPXxDgNY=
X-Gm-Gg: Acq92OF1L8ptashf9KJIPp5U0qJEt6XHl5QvF/+KxSWvxuK2ef3lHJQXsZQD0MyaKD1
	4+VtvDjLn+HJGItg7Z86EbenDaKoBPl9AhT3ViFlNhK6Pvv2WJ/TvhZ65ZyURlIfVbXEGAalped
	k8zFUeL9YQMwW9gvwsXrG9d635rwzCXUNO957V3P2MxTexiKA5STqP4PhJbj7FmtpkXK5DVNrIJ
	/+eMTqaz2LA3hUYNxgZqJG2qdckZiN1bYdBOSnTP4d0EKAyiLqfioP2jvCXNuhofyr4wW4iia6G
	rZm8I9ow2WbAudy39g==
X-Received: by 2002:a17:907:c50e:b0:bd5:2e4c:40d8 with SMTP id
 a640c23a62f3a-bd52e4c67e5mr540771666b.49.1779092126911; Mon, 18 May 2026
 01:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com> <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 18 May 2026 10:14:49 +0200
X-Gm-Features: AVHnY4I7T4WU_BP7GZvJU12Xjdh4Ye2DjJjmhySM54BO1AW81MZEDOLDORve2fs
Message-ID: <CAHwyqnV3K+nhPoo6XMqYqT3FUkXge_DU=i34gzdEOjzVN6C0NA@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] branch: prune-merged
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

Can I get some reviews here please? It's a bit less useless after
removing the nuclear option, but also much less of a foot-gun.

Harald
