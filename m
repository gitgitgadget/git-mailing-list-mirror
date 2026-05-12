Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCA7184
	for <git@vger.kernel.org>; Tue, 12 May 2026 00:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778547387; cv=none; b=aenuyxXSSq//zeJBwQj1z5eiJcWToz8yxFV4adgLZKSIr8tYIsHa0LSbp/OPGX7sXQElgJJJKH5BhyvggBIBCyrMxxLzLOaP/xFZQQQwjqufg6kiXiqoottXeNJpmrOgSSJRrcPankXzdpzqVm1M+qYEZJIHPtx+g+VpEPomA4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778547387; c=relaxed/simple;
	bh=017vJNq5znhsULbak8ME8hfD2Ogl82e9vaMzeGrF0Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cR7+GSsTvj0akVsP3osI0Vk7OJOP/F0+gTr/opO+M1gha7LkWuPWmm3JBgXcJuV0idamEXiVEEa/V8V4uKiwO6ICK9oQOE2U6OyCHhGRmyjk/bwRJcPBBG/qmLiydMGpWp40tOvqsvlxTvhIxlIaKH+3eiBEyrGe1uR42Ec0+QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=nShx+Nbf; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="nShx+Nbf"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65c21049dafso4514441d50.2
        for <git@vger.kernel.org>; Mon, 11 May 2026 17:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778547385; x=1779152185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s5/UkLCDjTgj6HWyxNlcDCld/NtHfs16kktf3pFPxjc=;
        b=nShx+Nbf1y9ytY4eyZ8P3B536xAk08WA77z+7Wv0ATkJOfRilA7IHjRxn3BntoqjIM
         RsrHgNFE63rAIqpSXKcm8c50uodTcZpLIfNrRZqEdTtGVqZgUszYHebrnY5wwPu7eyS3
         3DFKTU32RnDSktYDck+lykqWTOU0OW30qvkUYkkALtr87c+nnrCjvwCz2RqsG48VlnPS
         15FSgJlDxcQtzKzMmuoQmHzqB2pKE3tZW5ANM+pJVyENhbuiPnl7XPWCkjrIGxgdVvN1
         3gEdHN9+Ka+zmCI+SoOfXkFVW4hJ1QZWkB7tkf1B6KWNBPWOD9NmSeHEtKZVy9nRmMnI
         PpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778547385; x=1779152185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5/UkLCDjTgj6HWyxNlcDCld/NtHfs16kktf3pFPxjc=;
        b=olU+XbfaRBjJuG//YYWKnbM2UH8agJDQSCDzY+uLLsO0a20i5mccFitOyGVUFQmvEY
         s6EfC0oONdhssto/Va5C7RAxCV4skS7Z/l26Tr0E3T/rJQcMEIoVU+VomUI9ySFfPl1N
         4pHeZJkbjf60a1GqhRcAmOZ5L55SmQuyuwRoWL2tJOfojIntx4LM7eZzCUbEg232G+5v
         UhU+Q3c3yIYDkjFsB2FfayPfNiWWs/5UPWMJVBTGvumrmlg0nIzAXPnE+eouGvJkCUwZ
         48IfWG3oUzDB5G/86h4z72xDiBrMQmnHImXanJu5bWBNXDwxOxYHB8fdaNOtHfWRSO5P
         n5ig==
X-Forwarded-Encrypted: i=1; AFNElJ9p8MJ0fxnziB/S+W8gPAVwRxKQeu5t3BP/MSnVu6By1f1l/cJphksOproF5xHraem/yJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxToysYPJA2/e1BSMFH8y9rMhD5Tw6NkJPaz8czc/FQcwCZJ806
	dIbgbEHbPlN17pTO6XmqmOyt4HAuW8kE/BBguslrAKfNytwW4u7AOdkrAX55obttTT6qZdBQ6KO
	Zqc6u2WVNUQ==
X-Gm-Gg: Acq92OF/oI8L4w2uMSN2TDS9Cak1xoJCT0yoGNqvpDgFS2sYwPx6Ka6trhExnq4GPnz
	aLOv9s+MTfrwEXRX07DUwmTYVR7eHIP7KF+UR8DHzYiD3wSnQnrvRd8L0VNxhFOY5mIaPcEcQgL
	zC6ASIzvmz8wwdmGUisBIit+ees1rqmLMFbCHWgv/e9SskbT5VQOI0i7sze2LFw/2UiNP/8BweX
	6+LSWMu2OVvt0jwvPYOmqdpphB7tCo5AWDFhK2rzw8VKultJSTpkiYk/Y4V9dWtVmku8CjCQZB0
	cxXxZ6JQdYVuumQ/ogKu3hpP3IiIl5FX+YSz3K2qiq0LL/gdVOp2Td2F7UKrZYegsNB+8ZeuawH
	29YRdnWSQe/TUKXTF5NfLXNU87bG7LZwDvpRo1hzg1nYrxX1YAyMWx5jpC/ZtNDsDo9v80l7ueN
	jzQS5gjq210FRy53oM522zQxMH2CZO73y0Hg3ON3GFG9CiGLwrFhs80TWyxgvw4re7nQNyaBmO3
	Vmq+pCaUZOr6G5yV48nx0nMmll01UqzF6TuJ6I7L4yK36tFpAvr5ywqd/Jau49DCCXG16nJ3qch
	f4sdH0wTCHSTi5z5
X-Received: by 2002:a05:690e:12c8:b0:64a:ef61:188c with SMTP id 956f58d0204a3-65d94c95f02mr15809429d50.47.1778547385577;
        Mon, 11 May 2026 17:56:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96c36171sm6195306d50.20.2026.05.11.17.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 17:56:25 -0700 (PDT)
Date: Mon, 11 May 2026 20:56:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2026, #02)
Message-ID: <agJ6uADR6rVgddIW@nand.local>
References: <xmqq4iketzh0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4iketzh0.fsf@gitster.g>

On Mon, May 11, 2026 at 12:08:27PM +0900, Junio C Hamano wrote:
> * tb/pseudo-merge-bugfixes (2026-04-21) 9 commits
>
> (snip)
>
>  Expecting (hopefully minor and final) reroll.
>  cf. <CABPp-BGkfavqezk2SV3+K6iF8MLm8j_=ijHiPDLmv_U_o_Ykgg@mail.gmail.com>
>  source: <cover.1776801694.git.me@ttaylorr.com>

I just sent[1] a reroll of this one, which should be ready to go.

> * tb/incremental-midx-part-3.3 (2026-04-29) 16 commits
>
> (snip)
>
>  Will merge to 'next'?
>  source: <cover.1777507303.git.me@ttaylorr.com>

I think that this one is as ready as it will be. Peff reviewed v2[2] and
noted a couple of minor things which I addressed in v3. Peff's review of
v3 didn't note any further issues, so I think this is ready to go.

(+CC Peff here in case I'm misrepresenting his review.)

Thanks,
Taylor

[1]: <cover.1778546804.git.me@ttaylorr.com>
[1]: <20260429081030.GA1268740@coredump.intra.peff.net>
[2]: <20260501064640.GB2038915@coredump.intra.peff.net>
