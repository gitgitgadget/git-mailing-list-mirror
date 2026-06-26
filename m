Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2B2F8E9F
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782444470; cv=pass; b=FKHZWLWwEhewLGSg2JeeSy2opWKzHIBXPTlr6FIr4eo692F4YU3WHz695vwjhvakK8QW6Wef1keJFf0lPnqSuZ6xdN2/LI5M12kiDbQOVTG/KN1UDebAIKAh8/ynYjamT3d0DfOcpDd0CybkxQmhK39jUK02WeiZTUSJissNA1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782444470; c=relaxed/simple;
	bh=+mll+lwtmCflDj5RSyY2vu7mC5W9LHxcTykBBKD/gh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzaPQMApELviPy6ntxj6pmTZmEQMPehGmfri+MtJb1SjV97RtaVupUcrCoF+ij07lNk8OjVDHfDMz7or/9qBfRzZ00lrCJKXtWJ6xnzVa69JbYYYgK29Fs7a7KdchLDKAVJ39qkfgGjJqFCdAhLvyL3Gd2BTSA/uDkNb2uWPILA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pkzB7aqJ; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkzB7aqJ"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6a0a38a013eso451909eaf.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 20:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782444468; cv=none;
        d=google.com; s=arc-20260327;
        b=guOp8b+ozPKXn2ZqoOZunETp/5rSI/VK8wr2ITFs+TFhCky/g+5O39Kpua4gsC6lfz
         SULwljF8jq9AfbhoUTH3f3m31e6Z5n6EIMGRdBwExAZ0Bj0LsTXWMeRfJxxJOktw/Z5c
         vCGTQFMrfD8bxKhY5xdg9xpvvvnqDWFhyeYH9k3lBvTvPz4UymEcniQu8lVyhhNUCryK
         1kOc75vKcdP9inDjqIWPeOEJ0jMt2jSHk8i31dL6UVh8ndSvhVshNsL2qJK0nkRgps2R
         cN7ngnS1GqRyTHPQ6ik2X1pYxh5Lf8EYSKn94NxSP6yZpWymBZWTV01fCoEh9+fwrLsr
         OoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Dy+C9nLfTC+NYwPw5T6YTey/cTIF4NLNkkwnbOutteA=;
        fh=oxC4UZZEqn2u41vmkxiyphdim55WFafbbrK8jB9QwcQ=;
        b=kpsQH3SFSFT6WVAeoH+LDpnjo3FxCjuEiH2khOnGJgspKtq5BxRKXeCq3Yypo2G/kZ
         WLBZuf7cYMv7aeKXtvsxpXc9/B0h0weHyHzUWyp+3z5n2qBhxm0gmVBR6H5QUPwAtkJG
         6LBF3OKhxBDSUAtQTYS9+1+eE/M40FCo6iG+dQs1sEZIuDfRs3UuDK993IAzGDwE2RYW
         7zLhT8ccWJBORrvPml0veAEvq3DVpUy1fKw9CTK4WO87K3Awxf/70gut6mmgNlf5vfbe
         wGTGG694kF2VsaDSqAQzHEL8dmNvRyiWCbQsfS5ooor5z5egbDQQ6fRI+hcAD0WZZ93s
         eJDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782444468; x=1783049268; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy+C9nLfTC+NYwPw5T6YTey/cTIF4NLNkkwnbOutteA=;
        b=pkzB7aqJFGTAVlZh/Xj8bcWN9MOeUgqpjN6mJcG6ijh8/87H2ubuAixCHj8O9MaXmt
         0U1d6glX7oUDQEJwvRDNrdJjOXOuI4HzlxckzBzKrC/oJiu7kwzASfLevgV/vzVa4gxj
         0Qm3udAMiOBQOWG1brp36VijZ9JMUL3GTdkRF7Z8Z9yCntfKE2LKFT/hkWOtqa7s81GA
         SFrCplS4LiPU/EdbnE5ieuDxSEXFou8Z1OpaIiUp3S5UWjaP9dKqcn8jibs3sflZFMz6
         dIuWgdQOPoAf1X8SH3SUaJif8PWbWHe5MS86yegUXLtVTC8RGu14YGGuGmWSjhbnqQzp
         O+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782444468; x=1783049268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dy+C9nLfTC+NYwPw5T6YTey/cTIF4NLNkkwnbOutteA=;
        b=A0noO4IuA1J0HhoRqzYEjJgFO3G1v7LPjZFVfG0eJxgM5IjUgaWvA/UCETMbMECIXQ
         tcCJpjvUACd5g9IpxjOe5qOQj5bsepKye2GR7TSe+xuFPFTiHB3MY1PmNamevJcfhIQZ
         mQMUuZvQ/pcgqBqcvI7EThoWAQQuAZrC8x7V5cCpOLHkIkkNHm5rYtJdhU0kbXV/5bwj
         26aSaVm/qJD8vdKE64ESYURZ335xesvWYZqoS1UD9z4ND6MbWc2AdJ6bXgoTMJKz5z5z
         yO+Js0Oql8dMkFau5rFnnzLZmRCuN2oGlwHpmOVh++Wbz/9aqZl8BTLGw7eYo5JZuKRc
         5yfA==
X-Forwarded-Encrypted: i=1; AFNElJ9i8KMKfBZ8i+fnXS33rGiR8AlGV2xZTSCIDIHrFNTbf1SzJv+Yu7qTrA6yeFBTJvNgQZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCARKiTNaqRqLCZ/Hi3f1ayi5JDBy+RBieql8elv50d00L/Y3K
	DpRB6ZqUlU4NQJvXhfjUjEwL75PN/cLZYnscjP3wgFNwPJPf61zrZDcE/Q965nYwEBeAkTRQxLO
	sKbpVTNDmUgPaU7PVqSMkJaOAsx1KlzNMJ8gs
X-Gm-Gg: AfdE7cmXGfraVmHnhXTxjz4s9jopq9r2dYE07E6aUZcmGNycHI6NUU29C5wr+MXN1Eh
	HHCISH+PysmwRJ/xc0JxBBwnpyIa3sGP0c/hPspFhBAgC4+nm8zE7FQ7+xJlPcoibS0wBvvWgQa
	xCNcOdK3hAeJt704zDheHAJ/+o5fQ3juFdnB9NM3eXUa97kxDcr16+VhL9gH3Fie3FjxCl7ua28
	MYBS90AREfUrKnoGNs1rFrOUywac5qhvSq9CG+2pIfyIZiZu9X1VQ2fFLLcNokOnt9pZ2r1AQEA
	gNAumuius3JwjByRdp9E0OoM/XIO6e7ujg8vPWatURqGet3JksNE20XvZf2u/+G8VKhomE7rTY+
	meRbATRsORyUZXDA=
X-Received: by 2002:a4a:e905:0:b0:69e:9af9:ab47 with SMTP id
 006d021491bc7-6a1127cc75bmr10446522eaf.34.1782444467638; Thu, 25 Jun 2026
 20:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC2Qwm+9sh=ks1fuux415JGdDJ38Jq6eZrSH7-qzQxYCoy+Aug@mail.gmail.com>
 <20260621213407.GC2297179@coredump.intra.peff.net> <aji9MOE-NTHKXYqn@pks.im>
 <ajkEzhdqzmAePk_P@pks.im> <ajkGkB2ckf3p43QR@pks.im> <ajkOoRhqaAcy6gBg@pks.im>
In-Reply-To: <ajkOoRhqaAcy6gBg@pks.im>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Thu, 25 Jun 2026 20:27:35 -0700
X-Gm-Features: AVVi8CckuHTdz-NWh3fbUjF6QOdkgzcybo-0KZ33HVJ-S6nxQ1SgsQbE9LoVSPM
Message-ID: <CAC2QwmJA2TH6BmO0O61qRYvV2pqURUk0dTXpkJtb9e-TZNZDZQ@mail.gmail.com>
Subject: Re: [RFH] Why do osx CI jobs so unreliable?
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:
> I think the issue is rather simple: we're hitting timeouts in Apache.
> [...]
> This is because our keepalive mechanisms aren't helping [...]
> Whether that's the same issue like we see in macOS sometimes is a
> different question.

I think that is the trigger for issues we've been seeing. I spent
some time investigating the Apache side over the last week and maybe
found a mod_http2 bug, which I filed upstream with a potential fix:

  bug:  https://bz.apache.org/bugzilla/show_bug.cgi?id=70131
  fix:  https://github.com/mmontalbo/httpd/pull/2

To Patrick's earlier question of whether this is a Git, curl, or Apache
bug: as best I can tell it's Apache. I could reproduce it with no Git
involved at all (just Apache and a small CGI that goes quiet past the
Timeout), and across several curl versions (8.6.0, which is what the
GitHub runners use, up to 8.20.0), so I don't think bumping curl would
help. It also seems to wear two faces from the same trigger: over
HTTP/1.1 Apache closes the connection and curl bails with the
"transfer closed" error (which looks like what you hit with Timeout=1,
and the recent failures on both macOS and Linux), and over HTTP/2 it
does not reliably reset the stream, so the client just waits, which is
the six-hour macOS hang. I share the pessimism from earlier in the
thread, though: I think the real fix is upstream in Apache, and
anything we do on our side mostly just bounds the symptom in the
meantime.

Given there could be a potential reliability issue with an upstream
dependency like Apache, I was considering what mitigation strategies
might help:

  - Enforce some kind of lower bound speed limit and a client-side
    timeout so runs that wedge fail fast (and loudly) instead of
    hanging.

  - Potentially provide some affordance for retrying flaky tests
    that might fail due to upstream dependencies. Git already has
    some HTTP retry support (http.maxRetries and friends, added
    recently), but as far as I can tell it only triggers on HTTP 429
    rate limiting, so it would not catch a stall like this on its
    own. A test-level retry is not something I like that much, since
    it might encourage papering over flakiness that should be
    resolved, but it was a consideration vs requiring a fresh CI run
    to resolve the flake.

  - Make slow tests faster by optimizing the test itself and/or
    the test runner configuration (e.g., job number matching
    cores) so wedges become less likely.

For the first one, I think Git already provides some affordances. There
is a stall-based timeout that just ships disabled: as I understand it
http.lowSpeedLimit sets a bytes/sec floor and http.lowSpeedTime how long
a transfer can sit below it before curl gives up, so it would catch a
wedged connection without punishing one that is just slow. Enabling it
for the http tests might look something like:

    diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
    @@ GIT_TRACE=$GIT_TRACE; export GIT_TRACE
    +# Abort a transfer that makes essentially no progress for a while,
    +# so a wedged connection fails in seconds instead of hanging to the
    +# job cap. Tiny limit, generous window, so it only trips on a true
    +# stall; override either var, or set the limit to 0, to disable.
    +GIT_HTTP_LOW_SPEED_LIMIT=${GIT_HTTP_LOW_SPEED_LIMIT-1}
    +GIT_HTTP_LOW_SPEED_TIME=${GIT_HTTP_LOW_SPEED_TIME-60}
    +export GIT_HTTP_LOW_SPEED_LIMIT GIT_HTTP_LOW_SPEED_TIME

I went conservative on the values on purpose: a floor of 1 byte/sec
should only really fire on a true zero-progress stall, not on something
that is just crawling on a slow runner, and the 60s window is generous
for the same reason. When I tried it locally against a stall-proxy it
did turn an otherwise indefinite hang into a bounded abort (a tighter
limit/window brings that down to single-digit seconds). It probably does
not need to be suite-wide either; it could be scoped per-command with
git -c, which the http tests already lean on for this kind of thing
(t5551 passes http.postbuffer and http.extraheader that way), if a
narrower blast radius feels safer.

I only dug into the first option in any depth, since I wanted to
sanity-check the direction before writing patches. Does turning on a
stall timeout for the http tests seem reasonable? Are there other
strategies that we should implement?
