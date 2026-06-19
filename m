Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BB1224F3
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 06:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781849154; cv=none; b=C1/EJWCgj43g4iUDYFwDi6QoNERNNrrUIBnTo6Mromhc/vi0hnYjwqKl3vT/bBjE9RzF/1hp27PDMivHdOI+D3iQvyhn3NGCgzoa2WeIXpuf4Jns98aMPjAIUvyBo+6tLcZ1XBuL7aX8Y4icr3+ixjhE/xhQWagJ5P0gdAYk7Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781849154; c=relaxed/simple;
	bh=0iwGzaWEsrF7agp/OFwVnUVfCGpXklDxZdZbsna/28o=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type; b=YD7mE3/w9YUYi8xCHGuBYLQuO9MTLGYiAEjnasBeyoxvs3DW5hml9lDUaaEtIVemvW4NI3/QsyVJ76IxZLEXL/Dw6SEpDAuL49BFdgU5OvBkqz0lN1vKjA1sYZ4vwhcJiu6fNUQXqsoiq3O5ARo/Jc/VPfeiL03VQ0HAXpbAVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNWisxvs; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNWisxvs"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8454c5a280aso521486b3a.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 23:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781849152; x=1782453952; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yMAtayVK+lz46CoqaCjGWUJRcHt8drfnfP+vtjrTszU=;
        b=aNWisxvs85E+nA6a7O3TUwg8l+XPG4r+enuNkQNAsNgZ1DR0j+pZD5FgFyHX8iYCgK
         QP98LfK5/2e6gjpF/n7NU1Xh3Ci5cLu41FXRTzieZcH5Gg1P+qh1dSSvZdm025jFDlqn
         gv9hBqqRPxCLNY/tdnKKG9DaQkxeZzSfDXTypd1FBZeWIzR1QDJnp6SuOkiZck3MpPdP
         gL85nDikpSuXqGYe3sqvV9VsS5bByp9QG3kh0bGRA88BUOV8iVfKRFIZE0fOMyfAmUa6
         sEQ+uN9XGuUFjA+UiNgoxaFBCpuLYe1fbYfMMHSL8UMiMTKmuYATAzlipbeJJl35SO3w
         FQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781849152; x=1782453952;
        h=references:in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMAtayVK+lz46CoqaCjGWUJRcHt8drfnfP+vtjrTszU=;
        b=cmhGCy+7oLjMIAQ4Z/aPk52+MMkagcP0cSAtJ4AlAeh+GtZMl4GP3hRcP6HedRGo79
         dFzUX0I1IIBLAcVJufsmyigWnBrohJNov3Hv5YxKh9mxQUkyezSIsZBA4fZ39GStSOmO
         zorgY244K7FepAhhEDvngTUG7NGDbkqyusfMbGIeFIrmEJsWfEUvDQ5qJmL17I1dc4w/
         UndcFZWXqiFpQ9GuaINr1iIvGiCMEvFn90uxGvwhhENoPH4ogUeHcdMojzLeKEvv2/P4
         LkD6/ekwC2ciu6AfQFKi6TG7op34fv7dqgJsRtOIN2pFYp3D4t3eP5zJaAEisj4GjLEn
         BCMg==
X-Gm-Message-State: AOJu0YzfKRxv/eVTHnEYmFln6G0k7xQ4kYv6rpA6mOeUti01Iq3LgW4P
	CPqXgzp226okH6GZdPg5cnN8Z50ZuLJExrIArEKNOkrdVFzydi5TcaVA
X-Gm-Gg: AfdE7clvpxWiZK6WoBL3X6Uuezn4Ht/Ewfgypshn+5ZOGd8qXJ9qM5BHSyFQnxEKxV8
	qdlWSoRaf6ao9e9dJQpJR+z8EKaPZsi9/htTS493J3xIl13ZMlByuz/B2PWDiee32+JcGm7cL4X
	6pbfqSO24VJjBOvGkkzyt23h0iIjUs7BmfjqOyc9BBDh9KMzA9C7ukk3Ok+huVxuCxe2knwPC/m
	MqkeFAOoNqw9szmIc0Bg1NOK5myhEKE+3wn5YyKwYJZYzHVCnoEWvjMVoYyMLG+gqqf/ipv7M1n
	MikHqMhu9BsDw+FyrMhyAtARCSZbTjUPZHc7xSHALvm67QxUwUXbsfZbSCEnS4Nz2erwxh3ubcx
	j8lIlaXUGW62sR1dJZ5zW7y+2EBjNTuSe50hBPYd+u2p/JqmEMCFrMopVLG4R4XRZV/vfB8qX9e
	BB5GoUIS22to/y/Hw=
X-Received: by 2002:a05:6a20:1443:b0:3a2:c9a1:2c22 with SMTP id adf61e73a8af0-3bb33c3fa24mr2134791637.6.1781849152474;
        Thu, 18 Jun 2026 23:05:52 -0700 (PDT)
Received: from 11 ([111.92.66.172])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8a891a22b7sm1321034a12.27.2026.06.18.23.05.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Jun 2026 23:05:52 -0700 (PDT)
Message-ID: <6a34dc40.2c570c9e.381c97.203f@mx.google.com>
Date: Thu, 18 Jun 2026 23:05:52 -0700 (PDT)
From: Jishnu C K <jishnuck26@gmail.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] help: prompt user to run corrected command on typo
In-Reply-To: <ajQuqTB580gqNP8D@denethor>
References: <20260618142033.15216-1-jishnuck26@gmail.com> <ajQuqTB580gqNP8D@denethor>
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>

On Thu, Jun 18, 2026, Justin Tobler wrote:
> Isn't this already possible via setting `help.autoCorrect=prompt` in the
> config?

Thank you for the review.

You're right that `help.autocorrect=prompt` exists and is similar.
Our change differs in two ways:

1. No configuration needed. The existing prompt mode requires the user
   to explicitly set `help.autocorrect=prompt`. Most users are unaware
   of this option, so they see a suggestion and must retype the full
   command manually. Our change makes the interactive prompt the
   default behaviour when stdin and stderr are a terminal.

2. The prompt includes the original arguments. `help.autocorrect=prompt`
   shows only:

     Run 'checkout' instead [y/N]?

   Our prompt shows the full corrected invocation:

     Did you mean 'git checkout neo'? [y/N]

   This lets the user confirm exactly what will run, including their
   original arguments, before pressing 'y'.

If the consensus is that the default should remain non-interactive,
we are happy to rework this as an improvement to the existing
`autocorrect=prompt` mode (showing args in the prompt) with
documentation updates to make the option more discoverable.

-- 
Jishnu C K
