Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793424106;
	b=QuCQYXY5X36Qql4ektWvWNDdAtlpr1XHYKeUx4L6ZCZt3F6VhL5I1YgwohFr5zd11ILh
	 OA11wG4Zughxho7yp4TMbk+8wgFzXr5P9ghNQ60pW66phSYOzTTxYJ6sgmvU64noB++yV
	 WPst0gT+LgIYZMKYZWaZfGx02QS/TOQbu6kCTzm6Km9zSWIcSdO3A2CtPwCWPcAsm3SK1
	 ZiF5VAkB/s7A2eLojdPjAiPetxbX3R7vhBZk92aeGAw1eBxuOpRQ6L4S5zSx8fY7mfbDS
	 dH+4RmLmJrLPec9FVf2z0wEIoboGhwRFqnW/At/DuM8Fu5DAGY+oOJe4nXkX0DR0hvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793424106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LQwXlaeMRUlDIvUYweQOh7StOpyMl2JsvlnAsQSzoWE=;
	b=YFz0Fef1R0YU4HR+iiW/mmORnYep9UQbfdBFoWVWmd3/I5dwJoY+B6gfNAzB4DYQlo3C
	 4AippqByDyCnxFa/K4v04s0MsoBkexHdlyh9fUUa0YeJWTViSH6/FALrQuHbFDMl0WRt2
	 8jeLAIdsUrnBI6fY7Z0+E6gVGiK1tod4agY/E2It5exiaTg+WXhslOz7F/6Tbich4odD/
	 vvFVfbXL1OSgApFq1Db3TziY95Q5fokGGrtgLofXfYzr799qGRYZ+bQ+vnP8a3N9P46T/
	 fM4b5uvcrysxyGOvYWwih7xsE65YjMl4j/WddIy8a2TrRJBQeo5B68A7D3SCOz/gcOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xm2QtAc4;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C7C606A325
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 05:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09C7C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xm2QtAc4
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so970001a91.3
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 22:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793424104; x=1794028904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:references:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LQwXlaeMRUlDIvUYweQOh7StOpyMl2JsvlnAsQSzoWE=;
        b=Xm2QtAc4kBD7wLZMbcYQW3gDIxRErQBJG/kBg/V3bTBCN4nq3SwVHBa+xiZgroMCdb
         ZI7MqZ0hTA9asrogZ1mME0JanBpJetGhn49JYjkjbJEs4TSg9y5pI2xxO5a3KkfKZtC9
         2r9wzoe2KkZeCMG6BmwPEElH1lzOCc24winLOmF8IIh0GpBfcuI/ZMQM53OYfAm/G6u5
         ks4p71H59Ji/UwL2lsJXfn3zO8JsX11u+nx/7LfMtgROwLK3OU49JRrWPbm326lZtB0E
         i1NBBFrBn6IF20gGONHYrwjKeh7V/nClLbS6qnZ28VPxn3Ckil0NnmKb1O8qFM2MHZAj
         kqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793424104; x=1794028904;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQwXlaeMRUlDIvUYweQOh7StOpyMl2JsvlnAsQSzoWE=;
        b=X6Bq70i/wwwfiowzlifRwIL5b6NhpLYsLTvsdCIAH3tcIXkVbsu38p713DQK8/DNFo
         BvQ34AOzxea+hmM5G85t0pbve32RykbcMwmH2UTomGEk29zWR4GSCkPEwyapcaKVpEQR
         u5Z/ItA+qU/3T2tUuNcukuys4eEWXNXS2B/CABK4UsyzzJMg1DrgeTyy8Kk6gT5pJWSi
         4DJed7hhKDZwxHan3325HcMRSCDF67hBPqCVIOoBPSSKtIKaVl7HyBsjFaiddI6RNoUB
         vyOf6xu/7tk0s8sStNYu5s36emzpa5d+J75z/NPDAzI0D5YAqgtex4ZKtJGqxs118JDa
         plSQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNQM4MRrPxDflv/jinh++I7X4nRZjzs6ULFI+egG5S0/yTzMadjo8y+sW5d3iIX8NgVq4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsJlqx0s85tttaFAzqPVaut15C5H+64TYrIID0MYWFT8A2H1VQ
	fXS0hmMfC5jzPbEF9P54onPxTrLhxHAo0h+zGObLczN/eSNEotwydLirOBQTB5EN
X-Gm-Gg: AYBFou0sdsASjJoH3FxfvrBwWyp+EvAAoq9tpgrq1i5Gut04ZRRNWZyzwXFny9o2K8Y
	a+Cakl0qJt5AOusm9Wuz9x++3aeK2O+8aNjEc1jztdrjb28O6LVeUTCCTNdhqNe2z0NiCchQ9LL
	gW3fpO/JF557g2DLLbd+hBVCadDEuMuZAjhn2BYjqWGJpjZnvhOOjMm4fU6hLETMvkG9Xb3ChV/
	9ynTdVfPKDatDsMlKUWb8A4ANVHu47jM1bzPJNvkJ57dgygUo1z2zi0Vg3D4sSzIeXoHKihnz14
	vTXb+c7tYfBrat8s2ba6QDsVik3lHOqr7NyDlD8TDQNwaaZORaH/NjZSjY79jVwQTVvZJtdgvaP
	cdt7MmFv7Bp+72zaFl6C+vnhPEXYmwLyYEHeN5tpQ62WTDOzdvIV6S1zx6igEX0DVjUTJqLjpQJ
	W9De63faohoAaNYXT6PThpwC3qeAZAun7sduUQbyLJJgL0sWR0FTWyqz8yC3uX1lrPTkDvEyxOh
	CFQgwx53xYlpHgu9s1r66Dh4utVr8xWCADe3JcR2NxuCEn4QxnqvkE/93CL8E9/Ls9aW6o/pZ/w
	2eM7Kh3MiQBO
X-Received: by 2002:a17:90b:5603:b0:3ac:9a03:20bf with SMTP id 98e67ed59e1d1-3ae8985b551mr3785563a91.55.1793424104275;
        Fri, 30 Oct 2026 22:21:44 -0700 (PDT)
Received: from fedora ([2601:646:8081:1c1b::577a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845fb9f6sm6119707a91.17.2026.10.30.22.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 22:21:43 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH] t5702: be more resilient to env quoting
In-Reply-To: <20261031020318.tLesiElF@teonanacatl.net>
References: <20261031002550.GA626623@coredump.intra.peff.net>
	<20261031020318.tLesiElF@teonanacatl.net>
Date: Fri, 30 Oct 2026 22:21:42 -0700
Message-ID: <87fqxm5tsp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Todd Zullinger <tmz@pobox.com> writes:

> =C2=B9 https://github.com/coreutils/coreutils/blob/v9.12/NEWS#L118-L121
>
>   I'd link to the main Savannah cgit or gitweb, but those
>   are currently down, thanks to AI scraper bots. :(

I forgot to mention, but the only people with access to that GitHub are
people with commit access to GNU coreutils and/or gnulib, which contains
source code imported into coreutils and various other GNU projects and
then compiled as a static library.

So I wouldn't worry too much about linking or using it from a security
perspective. Though, of course, it would be better if the scrapers
weren't trying their hardest to kill Savannah and various other websites
that are used by free software projects. :'(

Collin
