Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795469046;
	b=PSXBpbi6YkJD2eh74zJCy1MhqYviwUI/eI3KTtCwwbaQ7CjrCmMexlHjWdnbKzmcgjtV
	 U3R95i1nRykoo2NcQ/G8uokKnCTePWamM44tOWOBwNXfyqzPbzkmgJjhAeSdAv6EyDvoi
	 hdCOAxZpYWn1jDBKRf/aIuwg4nEyuHafWW+4+SZQdcxTgpkdb6polX0YLO/u3zAIcRz0R
	 8eZrOxZ+EnoKGGF4D3LT1KKVL+i1taGfzUQc4rnqM0UcnCdrXYpS9qk24m0QQx7LqomQc
	 LWvVFRiYX1fqPgAmTNRSmkVOK3ztnvGSRtO2ItFvV6TRpKoMvgWrqCjLFRXN3MYT7dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795469046;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=5gI4VwRJDq+2DGilmKg55ZUR0Ad1yFuZ0wEZEZVH4lM=;
	b=KYiKABUzpWIT6W4cAqJnJX81Iznh4xOQcZS94qV7kfx4juM5gl3PelaNKoSbP52cwxj+
	 idDZV8e7Ue7guwzYJqw3hoVB7KHl+ehxY/qzqs24Hq9hrEoD64arbJ6/Pza+RKano+XoD
	 8BU02ypMlLOgoZYbjdFZsdbgpvURAxpIjlWdTsHHTEzAxChF3DnPi8+tD2rHTy4GywCDn
	 LuC+sJskMoH8ieHRtD9tUoUh6hQK/2Hgo+Llqo04UbD/X1vZuEwf3lqB1knb760i/MEzl
	 9lX5mFoxalZ8q/HTf1TtwBVpmAzTVzXwvEi5ciDPdIZlU4DrKlieOeNaUkPuuT8GGrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=GXbOjVyE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=U2eSeJrW;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24201606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 21:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24201606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=GXbOjVyE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=U2eSeJrW
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 279601D00659
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 16:24:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 23 Nov 2026 16:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795469044; x=1795555444; bh=5gI4VwRJDq
	+2DGilmKg55ZUR0Ad1yFuZ0wEZEZVH4lM=; b=GXbOjVyEwVPIA0nsgfXt3lrvXW
	idxY2TcszUdznU9QuEVIAXTc6G7UunimHl5yWpJJ90tbMXC6EL7ri9M9qxte63DC
	Sly2zIUcmwqYE4R/fzs7liJzcZVlW0rTahvpAtiie4Gh1l1mtxRHju4Uskx4VzJb
	Vx4p3juGHdUDbLHGJt/knISS6fV1qBqrpoeRh2G4zMgYZ5WhQicwpr+8ulb4LHil
	uAyfTLrj47QQhGIbuSFwC1m/tPp3vO/Fq9sJt4OHGQFJ00DEy/BG2DP7JcbyIhC7
	ieZqu807K5gvmrfpiJUqI9EGeK5V2D8tScCULcXmwH6W8x/WR0aX+VTWaJpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795469044; x=1795555444; bh=5gI4VwRJDq+2DGilmKg55ZUR0Ad1yFuZ0wE
	ZEZVH4lM=; b=U2eSeJrWr3HFsxyFtyYrT5XBs0vlRl1CySkq8qtjJGJ7cBVAbgT
	/75gkwWxm7OOIFVEW21GJmtzsl3LO07K0zdLM7OXgSQnXRBt6NZglSnnT3v/8gnG
	V1JaLzXQU9+t+FjxTAfJfBzLo0pAPyYgdb8pqooWMYxcPapnjwZDTHiZ0Oh5CpCa
	SCWh7a4A2AM8SBYVcSe/npviBwiv/fxjBp/pfTNGK0V1y9NALk+wrEqLdOBjZxU0
	7T0dCB12iWCT6K5tK/dV2fLRvXX2BImSGTlm+oFFwxk9Vg5ckqYiXZGFyLaXcq9S
	1zcKMFol/yiLEgGzTh+NYHbkSYDpyhpREJQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795469044; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:GGpgZ5dOeqTM7xB6Bi7a2CN8UfFqu5RP5bYrH5KqVJ8NXzd
	OFKJw9Gtw/4PgtcwxtWb0Te9tG7j8H6hPWryfwuTxVpgL+cUMb5ddNN/pVYpLUdg
	o3kvxB74EfRvlHmqyJOecruGPenIzCOTPmotaoHCxjYCn1K4OVY7ujqP6X4qgRBt
	RmSDoC0UenalAj84nG7YegMB7g89HvvwFsaJJgpk1QDWxSkFYPaNaUX+Fyp0cju9
	zJT3RqTHfx3gBBVZA0BSSZozrlGtbYzUx6kX/uJJENgfctKZpSS6dpZZbPelFi6x
	ElcAuwZ7myom22HWnxiqQwxUdaF5EHGBPdt5VIA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:MN2biNMXISle4Ll9mGO/zRmi5qvsO6n2PF0c05558aY=:zdvjUA9s3UZH9v/UL6qjivMytePt02EoECTd5C+Dn/4=;
X-ME-Sender: <xms:9K4Ea5fYURc6rNIh6f-py5dZl0gtHVAwMtGJBM1it0b0_ldAHECP-A>
    <xme:9K4Ea-HI0S6GH-RRGKgpBp_g24M2__lTj3LeUTYtvQJcMb0u-KEuaqnzmRnqacwUL
    G9Z8Eibfru4XZJrQB2nHsuqSlx4VWj4_suK5SGcmytiQjRlHUH9c6U>
X-ME-Received: <xmr:9K4Ea61AS1pmeaMpZYFvC_GbOgDbbSQj99fA9bE6KWQuWZomnoerBJkUBNipgl4fmaXUDsSNp5y_bhpmkyLd4zK6h1TeYmfydWXbSqY>
X-ME-Proxy-Cause: dmFkZTEykD5oPGTXJVvl0oPHN8NrTD+WPoSOvDr1d57RHDgH6Paf8/YCy4JfLr6wKXAGfm
    h6lFTkJmAUMpHq8yg1qlb6yJ+x4y83t4A0dQTVoV6aLAkbUu5BmzvO6Cpy84D/h727bF8v
    NjplgH3PNG17yrz7Vf5bIcjtzRLTvOa3UnQ+FrmwuCMZwvqRUI6RHj1XOaUXRIBD1dHNM3
    bNWSykOs/md6gyGLZ4VvG64oiN4ZhHnVRHSgtc/gen/wigRA/FD/orSeFzdZolGNXKG4at
    zUCl7Y6SX9YOSiJkVEyG+2Lo8/H8o8rctgEO0IR6mTkwtenlGi2JM9YSJWRn3uTUhFHTlf
    XNGiAQ7a5EbzsZRzls5bfxlNPP50dWfEYBDpTTdl7PkueySTpI2miEtD2pTjVbKnM/PWg4
    diKsEDQ7qlLUoRzbVNJgR9NOX4bTRej/H/yfoXweJGvRvpBYCQFsxE5QQ7TeAljfGtWymU
    8xJRCOlUs/fHoJtc0ICIT4XVGYhQzVJOfEgtkJUjmW+immHbuoI0OTNs28aiLSMr6a4UXl
    LC2gvX8YpnPI3wimQSZnBdOMIJg+rbesGLDgleq+nZdH18PDkfzeysWOzV0qC1fLv87f0r
    EZy02XiHEmJ0gFqGw1Mh/u9GKUKvg+4uvOcdt+LBfTRLiMxQApfTk51BG/lA
X-ME-Proxy: <xmx:9K4Ea-khQzlHYUIz8K_jvc59r5vfAYyKeXG28dJ0Z59fuV1-zUgmIg>
    <xmx:9K4Eay-D7jeD8VXmkKQFHlTnZrjPeluvHyGKxdoJPTFzzZaFA8bnRw>
    <xmx:9K4Ea7puus9T-UgLdsPzfI9Y8iEhB_hclYuO0EmqFYkOSQ0zmg1pfQ>
    <xmx:9K4EazmJjadK8zM3lrM6fN7opdeR2tVChTGO-IsBnssn8krghxsg5Q>
    <xmx:9K4Ea8fG3mus3UVb3ZAFfQggkLLv3d-rU-2wkHI5Fw8ZralkBue2kGzZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 16:24:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: Wasswa Edson <edsonwasswa54@gmail.com>,  git@vger.kernel.org,  Tanga
 Joris <tangajoris@gmail.com>
Subject: Re: [PATCH v2 0/3] credential: parse subcommands with OPT_SUBCOMMAND
In-Reply-To: <20261123165231.58660-1-laveeshb@laveeshbansal.com> (Laveesh
	Bansal's message of "Mon, 23 Nov 2026 08:52:31 -0800")
References: <xmqq5wxnd0k5.fsf@gitster.g>
	<20261123165231.58660-1-laveeshb@laveeshbansal.com>
Date: Mon, 23 Nov 2026 13:24:03 -0800
Message-ID: <xmqqwlq344y4.fsf@gitster.g>
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
Content-Type: text/plain

Laveesh Bansal <laveeshb@laveeshbansal.com> writes:

> I applied the three patches on the base named in the cover letter
> (37b3475fb5) and built each commit on its own. t0300 and t0450 pass at
> each step (t0300: 56, 56 and 60 tests). On the final commit I ran t03*
> and t04*, t9902, and t0300 with GIT_TEST_DEFAULT_HASH=sha256. All
> pass.

That is not a review.  It is only proving what the test coverage
touches.  Testing is not pointless, especially if you are running it on
minority platforms to catch portability issues, but the CI runs these
tests on popular/common platforms once it hits 'seen' anyway, so it will
not serve as a replacement of a proper review.

> Why I think the approach is right:
> ...
> I also searched the list archive for a competing series and found
> none.
>
> As for how I review and respond: I usually keep my replies short when
> a patch looks right to me and works as expected, which is why my first
> reply was brief. You are right that a one-liner does not show what I
> checked. I am still new to this area, so I will explain my thinking in
> future reviews.

Thanks!  Your write-up above was really helpful.
