Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A9218ADD
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 04:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792174; cv=pass; b=OX2QAF3+MIR5FcCoh4OcH5ocoKNvy8oPGM6yy/vYEbcJy+yIv7AnGxGs5ZXC6BM0GvkV26PMbm90rd9SjMz9gZcl/hRtyDAOA9CQYQAVxiZeMW0cUzGide5pUU5utWXXW0BiXiQWVFukmGhZ/FRtYhFpWTv/hQxS+oH6fdFcjYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792174; c=relaxed/simple;
	bh=v8lvh/j9nzWaL9JPVkCPzQNY1XC+2NPoryrMNDhpnN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDna2KCnuYkMrhkEHqP+uyoq7/7+IL6aHpGRHLgSu31QzI13/BhQIie5rGdDZCkyu2hMxZdLz2cLg4TroD9mWcDe0ZkPVSHTVY0NiPeMpWwAJ5uD8l634IDdHWmEiRU2KHx+jIkQK/H6pjJ6g+/IeDQB7EsBKuAhWEyDPgUWdBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGELvdEm; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGELvdEm"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664d78637f8so1628997d50.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 21:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782792172; cv=none;
        d=google.com; s=arc-20260327;
        b=ASon+VFbkxvG+QpG0ppeeiO405cuGQ/6UzG6i2MUQI60as+Qmavyj2dZmBuuKrodiP
         U46gQPh1NvCW4Z+vye6XRLP7fi8+319rUCD5XvaidEepcx/VR4pfviw1lmtpDptRk5ud
         RPBSMotW70+I8qbwiBtC2BmuxiODDVwY3L/u017CXjpMI9E6/StrxyCNYiFMsKxDXVWk
         L8Q0wblTolRIL37IPQFl3JnjKQxqOd1ZyuC+t7VU+w4ryD2VODbk2GChnygFEZv9LuDP
         y7+yPB9S9M3LW++afrONE40XHVX4TWZdHyprkN1WRFXTPVPVHOWewShG5qg6YwYJ7744
         g4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=v8lvh/j9nzWaL9JPVkCPzQNY1XC+2NPoryrMNDhpnN8=;
        fh=C2tFeZSjQ5U2DbsKPSTaDUz6Yew+nfnvrCXoFTYwlBE=;
        b=KlUENIRkgIJGyrApLgPN2ztcSKbhLq1lxqaI7hb7S29qvxO14b/f4rYTCkuR+fUiDH
         bigASdTsJy1sa/5ePtE57h3yfQEPPtCZQHSmiRrARBPIJeY7DBF054+T7wPXljTt/fLz
         vNXu7CYVLazRJnaRx/sWEbhtbRkFaawC1oGHXowpRTnmZispgcDmcnhtZ3fvWtahM+CY
         Cip4u57uwK7SkAg71bg9qPYzXFwwAsoPC3zPnGTedXN35N+3wFy3Vyl/x6BkIopg7Zw6
         5tKs8OuJrgUHiUQQGubaLPgRwvnxYFcbkbFkQ2jce0GCG6XQpEmYjsqnyAmw5Ijxsx7U
         VlIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782792172; x=1783396972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v8lvh/j9nzWaL9JPVkCPzQNY1XC+2NPoryrMNDhpnN8=;
        b=JGELvdEmle/c6WrnwxgnEgEfW+UaDdb2LRK1hn+on0wdIxtH6mo8Oe2+DT0eHr/NuI
         1vPONFBVwAie+vhVITkgOXlXoMvqyZCM+263pDbtwN8zCnncjPbysiEo26EwqZXqJlA9
         Uri05RXfN3LKyVMxwhbRgsaUBh/NspKyH9rMQYb7dGu9ueKT796nHAQ165DVQpC0fH6k
         hz9oXQbcw7c3MUPqytLRddrj/XO44A4HiWdxxdHUCwb19zxLwITPBGf5Cv6T8FIstwN3
         tAvebZCQtVmy3KnYObWcdnYir4K3jDVqvcbNgX6wUMhD1aPcqJKW233ngvqiSA1n8g7f
         Pu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782792172; x=1783396972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8lvh/j9nzWaL9JPVkCPzQNY1XC+2NPoryrMNDhpnN8=;
        b=M6vgCd9LkHGeYNezGS9ftx4AcA5P2jNxg1/8U+cWEEbSwsN5nGu4np0dMmEC6FFbRc
         2I8QtEOxwCjPV1A3eg0EWYjiNiAd02qWA3J9CWR1rPWuxZ/SeixBdzsnOrP0HYM5B2B2
         PXb8l9gcLbyxHYhhPzukxSVe4VuUjXc3jZmQIfLEDcQofr/DrodIinxf1Ug4NVkNb8sl
         AzhfGFBIeqVtebhjbX/hA/0Lqdr5Itd1mhIF/ZI59OQRW1jGx63+U0P7O7ghAU3AmOdT
         jRb0R55zmXROKHWrb+elyFH8FxGNW9hxEN25UAdZNLpyzGpzA0BsRqXVexVsFEOYQf/z
         wDfQ==
X-Gm-Message-State: AOJu0YxYmCK3//ZTZOwHc6kcH4cwAD/TnzzGhSx//EnLzL/aHPdTYp70
	v9Z1rqaqchVdUuqDhjhkuAEljz59GBj81FPZ4r0wOHP++Vg1nxGnoSfkILNuZfFRnMR6MPZmYod
	xYGWXr/xGKoALxH3C0ym8mecvZpip9M7y/8xgcXg=
X-Gm-Gg: AfdE7ckMYek9ykGRmkCMKx9R5PwpTQHPOQy084JmK2PlvXmpI7i4FdEMd9vWVGwlcU1
	9r3aKszd7vpjQ0hPiQjnDaxhWUG50NHpI7qzGKT9VJNnpKPYms8MVNlxD52cygJi5c5eSCJtixN
	2BMKuFNaHul+xI5cLZFwfpyMNvAmEgdV7BOm5NRwuqHRr2SRl0fBTJ/UY9MM2u12iuNkqKSgy4/
	IVgR2ke5hvwJHi1UBHN1830FgepxOuLtrMN12zLfShrduIFV9/sNAag3G7HcexP7assZwBe
X-Received: by 2002:a05:690e:4287:10b0:664:ae6b:b49b with SMTP id
 956f58d0204a3-664f9b164aemr1717953d50.80.1782792171718; Mon, 29 Jun 2026
 21:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALE2CrTVVQF4rGhGG-9kmjweFHHYw+xnPU6Jtt=QmHpq7L6P2w@mail.gmail.com>
In-Reply-To: <CALE2CrTVVQF4rGhGG-9kmjweFHHYw+xnPU6Jtt=QmHpq7L6P2w@mail.gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Tue, 30 Jun 2026 09:32:35 +0530
X-Gm-Features: AVVi8CeS7dfRdIsNH1rT_w5OyNLSkkVqoDdaLA6bXDIoO6um0GytrQCc1uYqkWg
Message-ID: <CALE2CrTZrwYPOXMkXM993Bjo=bVGZeUKo3kDyuM2sBYg2VC4yg@mail.gmail.com>
Subject: Re: [RFC] clone: allow sparse-checkout paths to be specified during clone
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

Hi,

Just a gentle ping in case this RFC got buried.

If anyone has any thoughts on the proposal, I'd be happy to hear them.
I'd mainly like to know whether this seems worth pursuing, or whether
I should move on to another idea.

Thanks,
Pushkar
