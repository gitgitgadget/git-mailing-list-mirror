Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17E72DCF46
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768739003; cv=none; b=A52xRG1atb3FfpsoQqtzAG+il83QaHVefJuSUzbjO3n16E8DsAJe6ynUoQWKzP/w8YEW8OrSxhhmgJ+ErJ8kRNejxvAH4lS1OWA1yMS5UKjHxlVzub6FyYjSu7RrMD2/88WMmj1VJh9nYwXM4uhArNHFVMHvm8Rk195LfW7gKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768739003; c=relaxed/simple;
	bh=TyGMvGcyLrg7yBqyuXXLzWWxw+qA38YTxKlmevmKzlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0AqJtLUDcSzT1goPTKiFyJYJ2d0tvK9lIqjuWW3AWU1a+ajfumoaWskcrrcbrRUiAP3zcod8AKYgickYIhU0Ljq38XSBS+/WgKnNCSPhcxpSmTSrpBNq20YgzmUWBS6BcxOahTZl0sGWNZ5QZrOXwBzyP/RjwWhs0DcbJGFkRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvHfYkO0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvHfYkO0"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so601530266b.2
        for <git@vger.kernel.org>; Sun, 18 Jan 2026 04:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768739000; x=1769343800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyGMvGcyLrg7yBqyuXXLzWWxw+qA38YTxKlmevmKzlY=;
        b=jvHfYkO0uwWL0pZCUSmjFRPOi+H6Y+Nh7Lb6qSCsn+U9sx7BXu6FG+/JWBkUrFHpY2
         DYizGzsvXj+OevqE93e5ZbNyGUrZwRQUSd0F8xVNrcWYhX896ocMt4H74xIaN+CUT5hp
         2SSspJAI1w+dOgx/8AP+iH8+xrwDBttm6rTG8I+HkbhroogzvJ+7nMWeb9Bu3z46Kh/u
         BXSD5d02ul3+aox+6PqCNsjxiKmmD12VEHygTwreHepDeTS9h1ej2uTBNr2Fa5o0XkAz
         2pBBx+IQW+7q6hCYraTQlBj9L7Fgkz84IC7SkGwmK5V5981FHZpA8KThwXf37Hc9/FVo
         oMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768739000; x=1769343800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyGMvGcyLrg7yBqyuXXLzWWxw+qA38YTxKlmevmKzlY=;
        b=Kzkd+P7Bi9qNWLqBXdTRL9j+bvXWfrLDTqjwkLpwtLtYQxW3+Tv9kHZyDMkqBim0j5
         Eff4qrJOQjm3NvkOywnXVrWteoEYph3F3EtLhwmBBreSZkCDv/RkZgR4Xqh3mmwoymQ2
         +XbBBvsLpkaiZQYpxbQ4hCDQPHo1iAiBnfvuPHEQqbTbp6OQhmaTKh6HvtmPA1rVpWQE
         WGXbRNfzz2huW9XEsFcYOzHakjjo1V3lgLf6FrAmafStEaBMkU34tgU+C4oT/JDAUHd+
         TY2BjPt2pEdcBX+vJ6O0XtLSHKdI/S45LCa2S84UBaWuXx5Ad4Jh2wkO6ycBHmAtKoAU
         DMtw==
X-Gm-Message-State: AOJu0YwPZ9Z05VX5KjyRLc5ybiw9TDUN0XkHFAxrBr6bzj8ybHY2/XBP
	FJS3LzMaXR37RMgPkCX7W+30fGQTLSfj3r3v5QErj7D+DFVRYEI8i6Mj
X-Gm-Gg: AY/fxX7dZC60E1yyonj5+pwK0r+zWzWptKQY/ROJx6ye3724nuRxamiQXUAfjvHozx1
	s1TOblg9OXleEQUr+JsADdOlrqFkhueuAz8y2nDxydDjBEGVOxaiIpEYdEwiq1fXtYmDZaDu0K1
	KqbwusNRMQD4paOKQLneMVFNlsBPwJoVzMhsjUCr/cHCJQj1EwZzaRZkg22wyaVRv9ut2U6gIur
	oHECnygy4qpy78qZoIxjmR/91ParfraoE1qAl/6GJQrmNmtj0aPQS7WMtNVQb1yipPCUB/jwPEn
	AdHrtbpYzEh8MyqEXX/KSvSJqJUrlVdfvLp2M4oQWjtUJFS7ka/Izxtr/MrnvvTTOlfwT2U8Rwh
	snxq/c1hYORXCzWt43NKvZ+aQFFQZpVEl/NRcNtyC8EiRyHayJ7j3mXIwBANiyCWRTaY0383hXf
	PV+sBwQv5CR8bCSp5z1zXWGZyoUkDcYHjMc4VG2B7V
X-Received: by 2002:a17:906:4792:b0:b70:ac7a:2a93 with SMTP id a640c23a62f3a-b8792feb0b6mr832178166b.43.1768738999811;
        Sun, 18 Jan 2026 04:23:19 -0800 (PST)
Received: from localhost (62-165-236-43.pool.digikabel.hu. [62.165.236.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795c38208sm821014366b.71.2026.01.18.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 04:23:19 -0800 (PST)
Date: Sun, 18 Jan 2026 13:23:18 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Emily Shaffer <nasamuffin@google.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 06/11] reference-transaction: use hook API instead of
 run-command
Message-ID: <aWzQtsZCXNPeJ5vw@szeder.dev>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251226122334.16687-1-adrian.ratiu@collabora.com>
 <20251226122334.16687-7-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226122334.16687-7-adrian.ratiu@collabora.com>

On Fri, Dec 26, 2025 at 02:23:29PM +0200, Adrian Ratiu wrote:
> Convert the reference-transaction hook to the new hook API,
> so it doesn't need to set up a struct child_process, call
> find_hook or toggle the pipe signals.

With these changes 'refs.c' doesn't use anything from 'run-command.h'
and 'sigchain.h' anymore, so their #includes should be removed as
well.

https://public-inbox.org/git/20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-1-925a0e9c7f32@gmail.com/

