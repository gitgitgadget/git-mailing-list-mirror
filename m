Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8700C78F2F
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804039; cv=pass; b=c62zp3tUvNPwF9ZgQbQtj/DpR0FAXhc0zXeQCdn+kvgMEpFUJyIMzqS/X8Jq713h03lVEb5adUfHoG2nVe+6IN/+oAlJRXTiYFpbZ9rdM6lB8MhfxczpWqTlSNCKmvEmpy7/8lpqHXpLJzUBnKLA+w6ePyQitYlOHZDSVPEu7Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804039; c=relaxed/simple;
	bh=4/3m61EOba4W99GuqCr14a63RmRPUDllDMKjkzyzVP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahzYtYjUegnVQ2qstcfkNZ2oxj+py6pbkEpGXcUJ7kvA6QiPQLFLh2gE2WlnrhFxbfBW0m8NmgFIik5SD+eG+tzwS0Z4SBqGxwl7JpW/al94R+Cs5pEPsUcxfJwcMeBWpCTrVNRP4DMVUma6DFmc1Rct5LPhHhkRlDtAhw1nC+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkRNL8Vm; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkRNL8Vm"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1276f8414bso185932766b.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 00:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782804037; cv=none;
        d=google.com; s=arc-20260327;
        b=oShV9ynyOux7sqqo/QXvCDAmYItafpVgvVJyyiMKsOo0j0MvViy/QHztVXRapM0Bcg
         ihTKXKb2I5YccZKFbgoIljb3h12+ysmgoS3gePkJQDyX10qg0yJWJ62vK0k4Xs6E9OVQ
         /GR+ZEe6ahR2hLf132rZstxexQHLzcIFgWJF5s4Nd1/5Poneu2P9lMF7dXuooQj7gGlf
         IeeqMkDOUJcWLRdQfQEEJxkE+OKaJyqSY4l/RvJ3+csJA711Gj/Am7Y6tWiAO1CEykVo
         NttpBY9d302iyv/G5G9kcj8AxEzpRo376MHrUqgmw8oCxRfMBgrcI6d6cnbModES93y9
         zw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yG4SFGkL443P1x1eOn3E3EXNC/+9be5UFP7KoZe4GD0=;
        fh=kmI/ww2vmK4oJ0CfE6N5YFYnMAPiQ5vDs1w14D4FBvo=;
        b=a5We3miBEjjFsu/J36SX7lDFdvZrgaTw8F9Pfsq3oBPb6uJdcYqVgWDCb33y4vmwwQ
         panRMSE/GxrvPgMhkSikYnnqHZT1pNcWCp2OR8eZ1l06gItRausGQwH51SZv3NVIg0UY
         ZNdKvJt5u9u6tJ3+I5SN0ndRBiJViHe1aqhNfdcMLLpA69xfdnFS7SKjnPEwBrLhUTqh
         GE3qAlzoTcaDC2jdXd9LGws0QahERgIup8s5bhkWZKFnjS7rJlY+BQe7D6x6ug6bEjbQ
         DzPf4XrPg2VRZDtIPFDweGTRsy1sxKFB9USj84HET5W9VRlV8G+hc98BH3OJi7DaD0uc
         rr2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782804037; x=1783408837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yG4SFGkL443P1x1eOn3E3EXNC/+9be5UFP7KoZe4GD0=;
        b=BkRNL8Vms3EOEKc5I8uA81D3sHGzxMUOSTr2sTvNmqJWW63fP+dBkZwVkwtcoBvlz4
         ktm6pr3w7dgNdjJvnwUmXB5Jw+nA+pX+ccfP9SJKkrRD5ckpneeMd11WgMNco6zLCjog
         RKQsdG1t42+dxT5VkpfF7cf0aFchJhSiftTxxU3osYAfnJhZB57hvNHG77BlAhyEWTky
         Sa8BOKE2/UfNDADlrn9G3LZM7rf9FTr/qC8OR7yK6T+kpfPlelGwyVPE/qedXoJf0cva
         XbvEjGFRYgmN+bBQk9RKOJRdFb7KcaFx0QT/Lt+AIcEPq5VVHdp/rvjNxILHTj6XnJcP
         3fUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782804037; x=1783408837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yG4SFGkL443P1x1eOn3E3EXNC/+9be5UFP7KoZe4GD0=;
        b=O3BR1QtH3mgGX5eEs79rN/ZcsZKoGyGv1aagMsvPESHF3KKCGsOpVHpghtrqOxe8x2
         Ve6OVyv4B0YYv54s4V2k7FOyfbGPXJzxKi3CmRwMi2zxoXJhh9hFMhfuaRJqS0/QnXP0
         SopE7LtjUvJPLCKNfHhSfP3svngFZRCJC628W0NyAomkRig5M3li9oXjmPKGIZCk/rfZ
         1Yp6dQC206BHuaGbvVjQ22vbns/ohylUh5feq5F2cPcb/ncHnMmx53VqPIVh2Ny+poQN
         4YCTDx9zVlNBMNv5L7usobwY5mqSGi62q2xUUY/jhUwCrbAPIbVfXR+GArZplAIwHyU/
         1gtw==
X-Forwarded-Encrypted: i=1; AHgh+RqYnXwgPC+lLMlMhGDmzZHJX1V/FVkzGfbIM/p8NSILiZY7Vk1JEUCBTirxApCQQB0pahQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+C/bsb3K2JShuk+n36J7Gu571YXgfXQBeJmafzkgf9vGJ7/b
	i/+z71loxpvNJkg2aGiAvYIdKbIpbUsqV9TTHE8yqdwY86Pam2pSO2I4onL4ZBDlqHGe3iOawON
	xMRgau1HPnSSFu6R6mKWRmdMsLLJBvV1i371llPc=
X-Gm-Gg: AfdE7cka4kHLHYtNfCrUWsRI0ZswlCQ/VQ+tK1VBH3kMoVwpIAEEwpVt7FPsl304qQq
	GhQPUlLzLaHJ0Otvt1SmuBZfjbOkuYFjQudR2EADTXb3A+70HCi6iulKU11rqBlGcxv1xdeyGWA
	GYqswdQNNw9kVOrUxiXxN/XiMcW/Gy+3TiRQ4pp60MpHgk4oJisW/Cud6RIyO0t7AVmc/MjSwCt
	Ef2C9NyWMuL6DCaNVayoPuyaoiDbMzZAt7Y1/x1Bf8Aq2JVoWSQwFgxyPnyOLFp+bNDlNWa
X-Received: by 2002:a17:907:980a:b0:c11:f4d6:48fc with SMTP id
 a640c23a62f3a-c128731bd76mr93074666b.45.1782804036744; Tue, 30 Jun 2026
 00:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com> <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
 <akIQLM6xZTHBudWT@pks.im> <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
 <CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com>
 <dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com> <DJM1N17VMUM5.3V5Y6YMFLIFQJ@lfurio.us>
In-Reply-To: <DJM1N17VMUM5.3V5Y6YMFLIFQJ@lfurio.us>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 30 Jun 2026 09:19:59 +0200
X-Gm-Features: AVVi8Cdpok2k5vl8itiKEXUqiWZ_cWHFzzJSAXQaZuGGMG-StfnIXgVwiTcvqa0
Message-ID: <CAHwyqnVBEOm+FwD+i9Aa7edTvdnDPJom1zubcXgoExZnp--vWQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: Matt Hunter <m@lfurio.us>
Cc: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is probably a larger question, since (according to the man page) it
> affects the other 'git history' commands as well.  When I run
> 'git history ...' and discover that I made a mistake after inspecting
> the results, is there a fool-proof way to undo the change and return to
> the previous state?  My first thought was to run 'git reset --hard ...',
> but the default behavior of --update-refs (moving other branches) can
> make this more complicated.

This is a larger question: But I would love to have a reflog that is
more human-centered. When e.g. rebasing a series with N commits, it's
very tricky in the reflog to find what was the state before that.

I feel like branch switching is given too much space in the reflog,
since it's not a destructive action, I don't care about it.

And when handling multiple commits in on go (squashing, rebasing), I
would love to see a visual hierarchy (with indentation for sub-steps)
instead of treating each action as equally important when it isn't.


Harald
