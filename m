Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721527;
	b=0TCUuAVspe3wPaly6/IW1MxvPYjyury1aL0dAmF3V2Bp/MYRZYfHK6l+RGVPp8g6O/8h
	 q5jwt3+hV1SkERZNtH5LDbXo6r3wwvebY8XrLRlkqZ4xanGPweZZu89DaV+tUY66w2FAh
	 Ne6xMX0qEXbAasuT7Ys3wvpRxLJRKY5WDwsabz2zOPFFAG9ZyCfUz1FXI7jAXAZsBD1A+
	 TRDvSOSbKB21XKj0mUSRXzmlqYeAtJ8fo5h+XTvvVKhPrB0pkCYh43HRZvIZ/lo4R3MhA
	 nvsuOlozNHgXn4AkVn+SR1ssTe7LVUiIo8vE4oQrpVp7Uy+1z7LWTH3TVEy/lea2Pnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=hawjom9qXS4pwA3a9tnSPWowyFFFmEif13RNRy33bW0=;
	b=QmW+dASPMwwuqaUi0eXGE0h5T6WL5inlRZFaFqn2babIcpMVp3rTo+0G3cchOa+FX+Cx
	 KjJQ1DFi8SJYyHsg+sJ/KSvyGnSwy9DSTz9N2hRhrf0orNV4k7sTcpaSwGt0gZxdTXLK3
	 gODy3+hy6ndfgYXaX5FLAPW7YRh9cWkoZs/CrAuFKkeL9P+D3cMhXLYoiOcdPuWtJ+qN7
	 CGeRqGbPFfKHp0/3MHbUzcxTVFtAt7KzGNk5m49nSgPoTZ61NkqI9pAFIQa079vrVRjmd
	 Eh3nUv2+o58qzRnOrg0OLBYVgdVbTqY7WSpqBEePf/uMyBaHrr3maHE9bH1wHBeA0XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Xx8IuJrU;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA2A606EE81
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 15:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BA2A606EE81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Xx8IuJrU
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso2642058a91.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 07:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793721525; x=1794326325; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hawjom9qXS4pwA3a9tnSPWowyFFFmEif13RNRy33bW0=;
        b=Xx8IuJrU27T4XW6lcomwy7e8nuTGrHkAVEZW+aT23JBVGSpjVAhSRVduP8TMLsa+lF
         I54snnjkOKEv9pr/9wQ0elWCiUuiyh2nxeoMPTW1dyHwy09H07xilPxe3y+md2I5Nmxv
         lxk1AHJfLqVtEl6aK8jGuRM2OdljVmyfnKCUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793721525; x=1794326325;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hawjom9qXS4pwA3a9tnSPWowyFFFmEif13RNRy33bW0=;
        b=bJHd6GXRHj/4rzHuXC+KrejGZp76PbhmqN/UpvGEcMnl1lYycJ9DuXeCExwP1qet4P
         OWA239S3uhNPubopNSYtM94Au1II7Lj+1iuxVUIJ/gJGx3iFU/Jb58Uz+H8hkKOSnVKp
         f8+J4u9TGpMSanKZHdTJOK+ncRkWB5muGZhkC4K/DhI6Lp1JpciBJVwonuMykFsjJQ9i
         3agrv0jGqP7UvmvIk3qsxqqsNMxX2r6MS8qK9G4wK+43fg56a+sssXFoNszGE0v6HuNi
         3U4hoKQiiNmzXCelrfwyo0yTDwUrjWaoIs1VDiBkQpdW/hyg9Q+p9AP3lbL8urz5eyz0
         ouqg==
X-Forwarded-Encrypted: i=1; AKwUvBymnvkIGB366ZFyugXmf0Sa4YUkRp/dFCPOYPXTKiIBjvK97e8xDoZiOEq95biZr3KwPi8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9fnAozZa0W2bRzZCrPXSrBRd7d37makpx/8RtKfLiyvnAhwSJs
	R+mGVYRDbjFWjWIjP7oZ/Nfoo2h3SreitIRlYzrMlpqelcwiKFbimbMz59aWYbWGh6A2Wj9Cz1C
	9tyCUNumTOg==
X-Gm-Gg: AYBFou3tm2hHWzt64xSgHwxFqvlNANXUYQxzLiZlPWqMyDTZBxT7PoFMgVvzNtsS1qu
	vPcCRGHVhTNjdg9m2CamMGFwl8L+zcNToQS59lAOcq5Q2/vRdGno9hEIzCD6qL5Wzv5dTZVVemg
	wkY69nliJxxbIyX4bb+pAuuq+IPvBEooJyuG87RDFcSfZmzAWc8CWwyegKte5T6qRtDf1hS5xix
	6kyqm2bgosYDum5LnMm0YVDG4e8UHX+KthiLIjYJOACOPwlrcKboMmU/cKNs7bwnu9CJrJH+AF8
	TxDtyzbbsQxqNw+22WxsooHtOSBCwnJjFmbZgXTsHEUMx2/8/tdrVYnqlwLM/F41BpCe9hfXOL8
	28DUn1TZ0EpcD49zKhIvq3vwJEkCwGlIU8bh6TFpfBrC9n++krYETP3KdI6QSA5EaHd+HHy8fox
	qEX4rRMhVA05JOLSEPQGAadqA0VeyytjoNNcwpbU66kVl/0WKI6rM9Qnh5l0gOOApfsvb+uVBQ6
	qBFGdvYKaYLvoJZEcOd20ieqiyr12a5j73QN+wB2sj3nah1oPTQzZpF+MEhS5mlN0kHqaUTivPX
	dNcqXZv2ylbwbKXENGenMdw2bxwXuF1fl3KmGwvq7gqAT6fRIkxyB7XMczBrMSOSwzlMbb/2bVT
	6wzrxPA==
X-Received: by 2002:a17:90b:2d8b:b0:3ab:c80:9370 with SMTP id 98e67ed59e1d1-3ae89724ae3mr9836709a91.20.1793721524693;
        Tue, 03 Nov 2026 07:58:44 -0800 (PST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c2ab1cdsm5133070a91.0.2026.11.03.07.58.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 07:58:44 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd69954c755so3147245a12.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 07:58:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzOqG+VPP9NEKcdUSJHkqBvOD4mQJv3loK6ZPwZoicUYEtRfj+0r5cyzZu13k7ovg4mqIY=@vger.kernel.org
X-Received: by 2002:a17:90b:4d05:b0:3ac:7c4d:8be1 with SMTP id
 98e67ed59e1d1-3ae897f8a31mr11211334a91.62.1793721523304; Tue, 03 Nov 2026
 07:58:43 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031065525.19883-2-torvalds@kernel.org> <auiGP4XhObUzC9vD@pks.im>
 <CAHk-=wijLfduoJyOM+AW6FS6c02cuEFRAuQWLE+uf7SGhj8jXA@mail.gmail.com> <aumKXUS7_x0i7ZU1@pks.im>
In-Reply-To: <aumKXUS7_x0i7ZU1@pks.im>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Nov 2026 07:58:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh6X3V49_RmYadHe-9+vEML1jDp2coy2YGBzrDqyDF1rg@mail.gmail.com>
X-Gm-Features: AclHuK91-e6u3RKDUljwfwapKZFEjdWlUdUJ0iTwehw7qRoGMdeJUcaVKSNtiGk
Message-ID: <CAHk-=wh6X3V49_RmYadHe-9+vEML1jDp2coy2YGBzrDqyDF1rg@mail.gmail.com>
Subject: Re: [PATCH] describe: count the distance correctly when commit dates
 are skewed
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 23:16, Patrick Steinhardt <ps@pks.im> wrote:
>
> An alternative that might be worth considering here is to instead make
> users opt-out with "--no-exact", and then make that discoverable by
> emitting a warning in the case where we don't have a commit graph in the
> repository.

That sounds sane - that way people who see performance issues but for
some reason or another don't want to do generation numbers in the repo
itself (read-only legacy repositories?) have a way out.

            Linus
