Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794385791;
	b=QqQQbJ2efqxrOZiuVT/DGktm+11+eHwQGgYHXIo2I6xHKePVQuT7PzoE296qpIhyMNzT
	 L/R3fQiW+hvGwPeBv2dC0KXwODuOhlR7UX7xsBg0b0nfPtwuI3WXIVGqbclkcyGqyMtCL
	 53GNlMJ2oFAE3oo4MSynXFGfSc/dBQpHXkfhpc3MsgPcT+vbCmk9z1B/9zXf5YU6OOe+D
	 fxwdtqXkvjknjJ3juN7hETJfEEJVWzPtaatf3tdINnLy/7Zor4Dh0rEHGt3jGNuPGhetM
	 QsUC9zoqTTNZMSZJ3+ADcQLyJ5CPH+89ps0Ygh6tZxQhMsNCWaZc44xJiXAevUQh/Tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=j1P+1DmJMT/SGyGfKzbmCdQqPW0eYqgQcs54wcOaByA=;
	b=PmbVMDX5vNKqlrJl0/oPg4mU3LyTm88jLFg+IK88HKzxlkrlhzvaZdxsnsm1N9be4hCv
	 k5zs+8H7xloGfTWASv8hV3qfHiSpBq+CB7MSpzgrVBDrPDFYkHNt6SJNEf3IOahycoYtb
	 Vhwad/IdB8Odu6la0qJciuaXdkEUZ45LJFf6ujUEofaRQU7ivR3NPlhWc3zPH+pnW7pAV
	 lz1znQCPr7fT5Utv8CaRPNxQdBRavCEP/b5qY1lfAqAh3tMZXD/NU4zJU1NGW6JolNVZR
	 nIq2nLi+KcoggmXSF/srcWKoSW3SvjtsdhViqcN0ROADm3uX6zSUS/lOYAkDAYemh0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HZmeUzZU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726E606A31C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9726E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HZmeUzZU
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4cdc606b47so445215066b.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 00:29:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794385789; cv=none;
        d=google.com; s=arc-20260327;
        b=Ipl7ShH4LkcSIbgX6/WDqUeqOYgE3dTaZ31/vvzBSEGDuUGreNnfFwqajaeeBiRWbl
         c1Z/C9+R7alahyAM1s8K6iT7ZGcoTx4EAVNVCGoS4QvFj9Q9ZHnAsWYl0C3wx1BFhnVc
         H6Ca74zo0GATzWDun0WmjJW5bwpUW1Rin/loywm2SNs8iBIVDrGCgT5+/qPp8H8eO6IM
         2i/TrohOr4uwsJDs2ViX7I4bs9QknkD6epvmwgdAUb9fbBzHCx9jvqmoSm0QA6ubQqZm
         E327nivt6pBRqX2Se3ytfu2oaEoCnq2a5wAU2YjXIMt9DEYozAA6pYA3ofUmKILnwzRW
         QTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=j1P+1DmJMT/SGyGfKzbmCdQqPW0eYqgQcs54wcOaByA=;
        fh=vCtCv7hv8GWsaO2N7nNtjmrqWJ3fpdt9g8PYfrI6x2s=;
        b=Qhv0seCKb5fowgHUqSAInpWuKunpaU6GT9ygSFXppQMKFUPQOZQgnICeVQL8kbNWyU
         L/xzYPpmPpYVaD2DF6ZfhGvAk9j/U+seDfHyu2IWCDtEn5IBKuqeUmwdYb6aVLfNdqnD
         euuIyr7913MzPm8bL7rZws8wO3nX5YGFfmFAeVlQwHR3RiOmkoC29ToHK8823nEkpuSV
         tOcVY8ss3vjOaeXcRZiTez+uxUxxWF40eRs4E5gN86QjyUrov2PyTf2AvK7T+ewtEmbe
         WQhiNrGZmgkSOdEYmh41NtMzrGn/NXGe2fPh663p2l3Jc/4Pbv9mVj+kTrcvN3jOu29g
         Kt4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794385789; x=1794990589; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j1P+1DmJMT/SGyGfKzbmCdQqPW0eYqgQcs54wcOaByA=;
        b=HZmeUzZUiAWZoMds+YvdxH56mIFNqie0Oqg7D8lVcz9JJzCwqECzIiQLPeoTsBeXPw
         286MCioipR8JLD11wUp5sqopHqCDDjRLHg0mgDNQd3K0O6saSM2S7ks3N1oGqootSAoM
         CWUbiDL9zMHmlK4skh4/H2iOXnhrPSdOosopYyYIbIFigXf7M6KI53vUMCuC5Gedtl7s
         Ig5lBOxq9BuT4Tj+RwccRt82K8dXZK+fDNCnq16ZTahNMfW0i/gRiNInwkl8FILAk6BO
         rCTqwvLBdjLoUpmyRnBxIbWOOOwPoFVwREwPHAn4xwO90GVmc7uqIypPN4sYEkEwXQSS
         FMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794385789; x=1794990589;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j1P+1DmJMT/SGyGfKzbmCdQqPW0eYqgQcs54wcOaByA=;
        b=2LC4MfsG/pW7hURlrCp6U+my0nlXc8EiItbWwrflRG3nrlz7zmcRxOEVIi/XGcZ3HZ
         vRrEugej1aRUJCk4tf5UwwyqFwqWbrtX2lItVM4AGtO8fo/GOsgFxQag9oNA+MpfhCIm
         mrHLIzQSsNsMHC9V0V77oRuy1FiMGyHXXyIa/6sZ1aNbsPCR0xo2kq0ucjYbiAFDsxjo
         SXj6FeQ0PWRC8IGOLLn2remuFa4T63BUGFSA5mb68iqj4VXqfbozKcS/iy9u+U9nRTpw
         upxGOwvIHdbJ7inweUTtPMJ18keYgg+emYBn2IGmi2y9B4zgS16aj/fPzg/BYH9M1QBz
         rBBw==
X-Gm-Message-State: APuU4Z/c77k8xAtjzcKsfhbAJipPt8uW3UxchRWahurbb47iGVk1FxiU
	6XJs6rPJLWWzZl5RUZVQ/VOawetOwS1uk66mbXWq0UR5/2S6jPNPincqPgzLFdh7NS5f2dwxuB/
	6s0F5Gf5fQHtopXIjER2OPMQqIgO08ec=
X-Gm-Gg: AYBFou2e4+qKhn+o5WNNL4Tjwt8e8aip1AqdkeC2IomyONNON5mymKIWHl93Mk8gt/d
	uJ7yqSabzPmf1NWlQCQijFFmcFQB7UMh7qeTU9xDeQ7L5IAscozIrPVHQMPste6PdWRNjHsAnDH
	qVTiN1XvMOke0ji3sqaud2C1zDRnxwhIzfRmoYAseeyVFSL/IexlRFDmcIz3rPaLFD41vALuxPV
	6Bu51PzGYtYsIc23e8BmojnCUh5xm88sBLSDScbMdRBw3lR62RTM+UqyLTDIBiXP6eBncqi1TNP
	3f4EyBhbYQlQHRHObhbVhtQDvtk/O5twABOw7h/96vzspGn/nU/38eAhux7Ret4Pyix7af8RI+0
	ZwWgUJ4thdOrZzqFek5S7pOX9MKGTRUaQ8abr
X-Received: by 2002:a17:907:2d2c:b0:c4c:bff4:200c with SMTP id
 a640c23a62f3a-c5066b322efmr122328166b.32.1794385789047; Wed, 11 Nov 2026
 00:29:49 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com> <pull.2456.v5.git.git.1793521297.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.v5.git.git.1793521297.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 11 Nov 2026 09:29:10 +0100
X-Gm-Features: AclHuK-VL7yJpHnd6EtxOd00RARo7C5lt7PXXvPN4Sy8pcfTnWLRkPdxDYZGeRc
Message-ID: <CAHwyqnW2h6UMCfU6vaKvUGTtPJX3xwmguqtJCf-XUzMcGs9fyg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] imap-send: fix with reordered message headers
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

Hi Patrick!

Is this ready to be merged?


Harald
