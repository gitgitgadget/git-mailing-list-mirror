Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793465195;
	b=Jj0UKZ3TN278H4X2CRNASHAoAKkL6VEOwfr4alFhC2eODl+kMXu7vA85gu0QU+gKRW54
	 M01jYvL7HMyB9k7iHPHGSFWujznnAVOlsS/0q5xHuXSTWKR/EozmqS6uGKzRd5gBzhy7Z
	 d2JdVZ/vO8PIf+J4KvcfmYutJa91Q3nz84tCCc8nn3grH+8BPYwl9X0FtGRJM8vDv44N5
	 KjKWvWvJuTfwVl5A9bBeKA+RoBp6pQNDNWuErCJqDM6YtuSaVU1Cswq+eEWzCiU8Oj+Oh
	 UK8U2Q1a0u5kr93YlTOep3kLPpYqUC5N0XIenoG+EinJQIhtzdnVLmWPFBAxTXR6J4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=qVtu8uEOU1ulSTG/VPCG6EFmkl9O9yX9egW/Vkvu2cs=;
	b=QgfrQrTAuLR7faNfSfGTGDfb9hjD1p7Lqy3GoFs82lQVVVkWAKmHB6EkaMXMM0/AdDWp
	 Ngtui8WYkDDVn0jQXdLFAbmZU0YcE2AEOeQ9x80iurGZBwfwv1zEqMWI/Ip/kIO9FXu7G
	 x6kI8MfVWs0C9D8zy/IgpGGgkHcSBZQeHdALkR8RBVKkc9MFf8L6ISW0CLjrx1SMUiyF0
	 8zxFK4MbF15sXAiQTYwnC+HVzgokmXO7cjDOG/GSj0nyijPRJ0T2gE0KWTg1VNqszdidY
	 wKR2cR51FtCXj5HX8CZFjJl/XW5tF4vk6W3H6zC8I4I8BQEbiBMFw3X9MxRJBmyzyaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NU9HchJD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C257606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 16:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C257606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NU9HchJD
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8ab43af5e97so19178937b3.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 09:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793465194; cv=none;
        d=google.com; s=arc-20260327;
        b=a0AwxHXJAjL1nFcsOTZ3BxKtVDfJqF6+PTr7UQVa0Xs7kCvVEQ0aUZw0JdXQoPWsjw
         Q3U/cgkjNMZPlo1nJwDVRyoaJcNxdLIsdp2g4Pd3VVS64CejZefri8jYLuqx08HGbi1E
         73C9pZRFA5SmAGqyUzGWg4mPvkcYExULoLTy23mPHsop/nsLUIEsoCdlls5gjysTPUHV
         p2JRRzLrclPO92JIbhtr8eKI3cst3JFYj7sT5y96HkD23bjfUG83y5AYtG2V9IKC0NRP
         Ceqn6LhfxU9KEV9Y2adQom+SHx+KzOExAdmxDt5ZCigqLqmuoPuW03fybG28AxxZhjmO
         EZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qVtu8uEOU1ulSTG/VPCG6EFmkl9O9yX9egW/Vkvu2cs=;
        fh=GV+q3+xoptdzTjdo/fAURyeoLF5hkow4oLuqL90b9Bg=;
        b=kSz7S65hEPkXLOlLvNSJsVrnkC0GQZsf94jIlSQ2iuths5mIUwfej2ETv8APM0C/T/
         ThO7PILNrXEvBTk6meHC2n3hek1cKsbxKg2O+3K/U1PNdbzcuxldpjLIBAOrwGuwGnDD
         fbJlURxFcuHCvYBAz5RfKK6tLK+sDntiEfxQKXXp0tWjGn+j81hx14/o02A90DIDboPq
         lEmF/IKRBInLPxlx01X5wt54idZoumryuRjB0tVlAOpsFdnO1hlgk9BIu9eAtX3gAR56
         dDWM6wTGZ/8pkdKni1M5fkwumrR8P7l6cpQSCqCf8f6jV1Ok6h5xXHoV885nuyO8n07Q
         JkdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793465194; x=1794069994; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qVtu8uEOU1ulSTG/VPCG6EFmkl9O9yX9egW/Vkvu2cs=;
        b=NU9HchJDVCQOFULtICG4anfl6Shw8tWZrjy0mHYvbqGFgb/xOZv+vSHsLDv1AB2Uq+
         tL6mqEdwZ/zvPo/FUJn2D4vZDFzM3+T4OtECim/0vl4SO6V3Df2Dj9bEmSD2qWyFhtQo
         FO6ziF3R9VgjnQ5w8JFhsM9B9ZT2RrugBUOtDcHAYcMEnVxi0eRSulG3ONDnTs7Ky9jl
         ltmIFPxUAws9cRDnEF3n5nQ3gszjAcaU3TLwHY3Tm4cEZgYXHVuqzcN2mqJVaXZpFUgN
         BuHu/BRm1QsHBCxZJIak9QL9qpqz+SgTZkIOyvo/Xo3imfpEb2bRI6/D4zcpel8H8TvP
         wexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793465194; x=1794069994;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qVtu8uEOU1ulSTG/VPCG6EFmkl9O9yX9egW/Vkvu2cs=;
        b=kjr4dc14LLs4ffWhTXsQpp+G4hdOiYq7gBfX9Y8aEqpgFd3YUn5mMTKEMR7T5PpW36
         2VzPNDEJnIzGFkyJ9ra4uweJ9oAeKviAx5ev8ndcY2PyvmtxnoRfNpXJ3tzsE8FRS9xP
         DrCZm40IWlM/F6c5a242ZMn8rYkwNnsJka2i7gdtd5IDZbvMmhcsOO5Om5cY+hffrsZU
         sCFdaG79+iXoASuV+Hq/hOsUNuxzIHGG8C82fqdArOwkJOmPF3vWJStf76rofxNZY50b
         Nw+C1vhR1Pr8z98rj2Uw31JmSMcgo5KF1JiPtsBrzwWqSgjtuY7vI8A6YQdVRxauAV4k
         MZtw==
X-Gm-Message-State: APuU4Z/Z4XR/Tc1e3HKomQKnIE6JFxAAmyKrlsFAxAfMaKik0rl3u6Q0
	bDokymYhkf5iNQMxaAcmICdCDo2pN8ClCtrrqv3VP+L96lJhj5XLhlIGTB+xnMwGWftFrTfakln
	njCKy3Jqj9nIlI00QZQwoFH3+5LQzcpM=
X-Gm-Gg: AYBFou2sspF/unoF/Mq+L1DH0XoBVq3PfRDzipJ+NSKkgP27yDaZU38ywEVgeY7aoMV
	UJgnDzMbAs4Gm9/vQdcyqSkmFAcfVn3BUXe+Ob+fVSreU/1Xz+Jku8kuCg27FrcAvXmeuGBojH6
	wmG8tkDCok+8WYLofMzNZa7N7ows6+wcUruihTVAjDbfTw3SVEijo1B2/ZD8dSiSVKRY7lrfIQd
	kj1x5Q9u0e33eIfF0uS0X6C2NF3sOuy6dgCvzPNc3TRXgn1qXyK7xlO1o/TDH4iXpFfpSoM50Yi
	oCZ7y5NyVbxhFOzJJgU/xCaycBC2y1NdeMcgSVNbQj7JzAiORLwXYPfXaGlxMZ6AmXIca/oft1c
	cZdjAkiGFN4Q/kB7a8XmRYcnKzYuSYTkvsDkd41/nFjkC3hIIkGIfem7aIbcmWtvTf5pUGrrQaj
	oxouHI850zWrKDIenZ7tGhBRvV40MBBw4bbzs1vxSzyU8n5drgmfyqPLr5tqtmAD+pMzxkY1auk
	t83eyxMcJoXxYgF4/NK5fhFcnxqT2M0zGeWsA==
X-Received: by 2002:a05:690c:6e84:b0:8b0:ad16:7235 with SMTP id
 00721157ae682-8b2b6751cc6mr35962257b3.21.1793465194256; Sat, 31 Oct 2026
 09:46:34 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Sat, 31 Oct 2026 17:46:21 +0100
X-Gm-Features: AclHuK841JQ1pV0uPJ5yAGHOZFl9kpwXnS7aDVfW5eHNcYoO2FfMaBmhSrc97gI
Message-ID: <CAFpMFfALb1KbEw-dc4wYCxS4PXfDBwzQOD6YPRe52_bpRnGt9w@mail.gmail.com>
Subject: Re: [PATCH] [Outreachy PATCH] t4041: use submodule repository for
 commit abbreviations
To: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Srujith A Poojary <poojarysrujith@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Srujith,

I applied this on top of master and ran t4041. The new test fails
without the submodule.c change and passes with it, so it does catch
the problem.

A few small things:

On Sat, Oct 31, 2026 at 9:26 AM Srujith A Poojary via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Use the submodule repository when abbreviating commit IDs in
> submodule diff headers, so uniqueness is checked against the
> correct object database.

It would help to first describe what happens today: the commit IDs
in the "Submodule ..." header are abbreviated against the
superproject's objects, even though the commits live in the
submodule, so the abbreviation may not be unique there.

> [Outreachy PATCH] t4041: use submodule repository for commit
> abbreviations

The change itself is in submodule.c, so the title might read better
with that area, e.g. "submodule: use the submodule repository to
abbreviate commits".

> - strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
> + if (sub)
> + strbuf_repo_add_unique_abbrev(&sb, sub, one, DEFAULT_ABBREV);
> + else
> + strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);

The same if/else appears twice. Maybe choose the repository once,
at the top of the function, and call strbuf_repo_add_unique_abbrev()
with it in both places. I also wonder whether the fallback could be
o->repo instead of the_repository, since the diff options already
carry a repository.

Thanks,
Okhuomon
