Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743482;
	b=AurgcNS1lbT7OglBm1NvM0msxk9rjQgTQB5XWTolE2H17KSpn1BHGwrB6YDYcMXqNLta
	 AyxRhF/KwttmpZSdOdzr4BFHDUiy/0xgjlkUNlfnwtN5hYQwhfrtHT+VKgy2p8VYpLuFl
	 OaX6SvHvjhyNO1xG8wQOvouf/l8ggxHvTC6dvlGhEieDYqoTKb7LAGWjcDWBIaBC7MTXi
	 BVU6KSNAwsulVLyLrjpjq1oXQzoxI2qSP+9OPoqUgpoOfKddELTDlViohqURDTDaB99KS
	 A0bv4o8TbkbdITeI5WIU/+3NJPYR3nqnsaG1KdPfv8bLKDz474XboIsVisZ/J6kV2Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743482;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=8SpyV0g81jkmc0BkcAbdbw2ri9bclx8x3ghPJmEPtX8=;
	b=TNW3QeHKu1WQ39f9pRnFC2Vd0UalX6HWEy6wRpTnRDcmPIsHr7l7DzfJRasVP0ykyFA3
	 juwJkPidiZPwkuzp6KX8kzsTTwV81b8ZOKtRV1T82nVBSeWOdVpxzfOydz9tLOsLsFtBv
	 fXyj7yhHlIMqlMA71uYddew1T4XmLrtcSFoEkpmBavzPZAcvKWdZrF4KSynriFVWFGQeU
	 fxlG1P7FTED2mps5fxUCucr7GokliT54UTaM/6uv5AMPRPj3eGs475FUCbKrbqMz1UGPR
	 b+0wue3scXXTh+DbiWA79t3TiEZ7AhjgFwrlpSOtALg6yflOESd1WX9N4X32Jzp8Ozw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=R1bDqU5d;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=B8pH204W;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74A606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 22:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F74A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=R1bDqU5d;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=B8pH204W
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A54714000D0
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 17:04:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 03 Nov 2026 17:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793743481; x=1793829881; bh=8SpyV0g81j
	kmc0BkcAbdbw2ri9bclx8x3ghPJmEPtX8=; b=R1bDqU5dQ8DDf72cAwXQzU8i/F
	2kFpGYSBrzGG7IDZJUb5Iqslcgq3P5yUQkGHfGWGOk7/76WvJhwc/YJUy1+4bX9+
	Ifp6ETfWKVkcVp0U5eX4XWd8HFqRKzDfdrYYBr387YO4/geH8Z02TzkI7J3T43kD
	XkSu5ogBgKPr9/+OYDd8lE69ZpFhulNLJtdTHZaybyrvkLnLjLXUuHIveeQDkj85
	/SJE3TAfqiKIYOoNrkLjIisjH9Xw6rWiV+kUHA+rOCqJ856d3kOjkXjEfmS0ccRy
	zfj3MHBuQrMBs6tjL5kHosaV0M9gigz4KFpuU+2+tYKlheKl7RuosVBjMn3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793743481; x=1793829881; bh=8SpyV0g81jkmc0BkcAbdbw2ri9bclx8x3gh
	PJmEPtX8=; b=B8pH204WRnJTU828TK/BncnwSV/gWGUfrduDugiyX2C4AQeyCzM
	MBg4Wr6vzb05NZbuAB8zQcfHn4KQmTum21gSKLP7HoHdWdUgfFOVX+3gLPjpyNL2
	xJ5PPMSZvRc7fuEjoI37Z3JUYyRCwuJNgjXEHinlCzsIdkwg8WTeHqYT3WKk5qwq
	nH9SQBfoLdrb7xV90Tlr7k5ATQ8DOSLXmFvHAj+/ox7BBlp2hd077UQykmP1qd23
	UuZA1/y3V4GoEJPnryXT4JtkX+D2e9bW3AO75TnR3kZGe38xUQu/89Xfhx2D9wkz
	mA6ZYVowflJUMj2koKMYJ+S6CXV6nkDbv4Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793743481; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Sb2r9qp1cLtnDIvqgQxi00niBrKXzDO69XEeyhzKfE6+zNE
	Uecb7zironddhvD8xrc9bPKwQTlsQgFVAmAEn1Nyzohw8csek1XBzvKEJANuj64p
	XqAEFIv4Qz10niquAKco7lmFxjN8/dabfpul2lF3YS5/06y5VZDrFjD8IN6FgJJG
	AgzOdrkffRiGuSVFXeCbqsLU0PF/MvejGi7V0HCHwDH280vssGJ3kLqn33XAG59z
	2HOPpzy9cObyfkQobpxN8SozgMcaDOBw+7cfmXbnpn8uin2rqqW91KKJwP1cPaZr
	1+I9sqvev7LTZ7t1O6p9OwdRU8NYOnTwflYOQqw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:fzPVAAHVjlCpbcweW0oNg3A9AizICWY/0ZmqDoAx/+I=:qanWPZkXsCwFTESjkjUjUvQppodhTZDW04ACZRKkDfA=;
X-ME-Sender: <xms:eVrqakFL4jmz7q1TPPrTEqiErQbQAlTR0Ma4NVFFgP_8pQQLUKkqlg>
    <xme:eVrqakUxERb4_WMu55CjUlKVKjjQ8peLYr8haplUY8jUTz1XbzS9MNxDB4yeIh9Hi
    LffE2nM3eHP5tDT1wa8FpJVdOb8Q9EEKwhQuNw36kb4JUoAwr3hfg>
X-ME-Received: <xmr:eVrqajIGHIfBpeAZ5KR_L3UeHQ2N7cOe1u2L1xY8Y6BRX1s2wHBio1vy1Uiq6Yz_R36rnh3fudfT7U27NGzb6ASbWi72cZMnTfy9>
X-ME-Proxy-Cause: dmFkZTFMeAJdee9Zvw2Lqgsvl0NJC3vltq1oBQjrVNHBwL14lyuPTazrsWW5jC32wEjjba
    Ogg0lO4jaDOYHbI/t1gBMK0oIHQPTDpPWBqA7I/z6YsUysV/+pn4NckmK6m6QllZHk768I
    rNseWe2ub4tg+qFSxh4S2cj02onPY9sbtdn3HKcpDkMvJnr/PXbq/7mONe70QMZNooS+Fd
    uXQuhUdZsArL5jGcAhS3rbHsMlSIwImgFBdrMG3fFjfdDs0SvgTgoogokxMy7r9FnJUJHZ
    LOHkSCo5Z6kurqz/yJFij1/iyk5Vq8QdSV8iQ4e1nJhAPJoYuWlzVkfuycLkDlDGDQrCsd
    IPOYDxGnES2Nx3MFxB4g6vDn6t6rxukDe1oY3/SrCJAepy+cM19AQRaYHauOfMvSPRpjTo
    MF7YVgvBMkx8dpR5ewd6tKVaT1t4jy9TUpbflcFL7WNNHNCoDoAevw1lrAUjvECdalMBm/
    Q1XpMSd6+AwJo9VF2QFDDJR8t9Oxmw0DLuI7QhOTYOdssmNbrzMe12YX6hN42A5mPpXR/j
    06hOFfOy3b2QBaa2Y65wsCIMuHfVVL2rFkIWBhUdIRld4qq4pcCPX09M5gHfziSMJj+LqB
    fpSeSSm9AWB89qVSacRUxN9k4YVtKRSJj4b/zE1x8LIt1TCg5PVunnc4+EnQ
X-ME-Proxy: <xmx:eVrqak-dt5-NwBjnYKWGHyqQscj8X05wQLpX7Nu1ZroF1W9i4AC-WA>
    <xmx:eVrqamIqmCzTKAVizO_xmZa7nrrtuxvYbnfcFqiM5NRbJ0JrEt5mTg>
    <xmx:eVrqapllzA9nNx6gV9HGZdBtf-rj4ncowopt3RLad0XHHUeOsS1cbg>
    <xmx:eVrqaqPLRTwNN4PkndExJ0DCtbev6NKsr2UB6MTaDg9Saz2ZiOiqgw>
    <xmx:eVrqauoeQFF_brka8gJDgNhCdn8QKuSOQG2Yrm98w-3PAbPAubSS1vho>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 17:04:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 0/3] ci: fix jobs failing on Ubuntu 26.04
In-Reply-To: <pull.2478.git.git.1793530936.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sun, 01 Nov 2026 11:02:13
	+0000")
References: <pull.2478.git.git.1793530936.gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 14:04:39 -0800
Message-ID: <xmqqse1h4lmw.fsf@gitster.g>
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

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Four CI jobs fail since ubuntu-latest moved to Ubuntu 26.04.
>
>  * documentation, fuzz smoke test and static-analysis fail with ln: failed
>    to create symbolic link '/usr/bin/dirname': Already exists. Run the ln
>    with sudo.

I see this breakage.  Haven't they corrected the Rust rewrite of
dirname by now, by the way, to make this overwrite unnecessary yet?

>  * linux32 cannot resolve deb.debian.org. Pin it to ubuntu-24.04. The Docker
>    update in actions/runner-images#15205 fixes this on 26.04, but a new
>    runner image will take a long time to roll out, and CI should not stay
>    broken while we wait.

Sigh, but this one is rather straightforward.  We need to be aware
of this change so that we can revert it when it becomes unnecessary.

>  * Use apt-get in linux32 to get rid of the apt does not have a stable CLI
>    interface warnings.

I can see this well, but it is a warning only, so I do not know how
much value in addressing it would be.

> The first two are based on Johannes Schindelin's fixes in Git for Windows
> (git-for-windows/git#6473).
>
> Harald Nordgren (3):
>   ci: use apt-get in the linux32 job
>   install-dependencies: work around a permission problem
>   ci: pin linux32 to ubuntu-24.04 to restore networking

Will queue.  Thanks.

>
>  .github/workflows/main.yml | 6 ++++--
>  ci/install-dependencies.sh | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
>
> base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2478%2FHaraldNordgren%2Fci-linux32-apt-get-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2478/HaraldNordgren/ci-linux32-apt-get-v1
> Pull-Request: https://github.com/git/git/pull/2478
