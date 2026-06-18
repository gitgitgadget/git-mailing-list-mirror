Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D253B7778
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773071; cv=none; b=BRafziSRmMZpOGzjJuDrNoVLwTLbRPlrfjupeQNVUNQkRK0utPTFTZ2ClHTGMYv8l7ZEIB3KCH5RhwGn0yDnRwtJiQoz7R8cUw8vX5FiZIyv1MB/IMXDnIye0mVyvMP++nZjZbU9S+aQwz+lI9BIP8XHKTxzDE4vRTnUkIaLW+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773071; c=relaxed/simple;
	bh=MDQVaJpWyEjp2IEHq9y3KMWoYfQkpYM+k+luTidhqaY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=b8qe7tLEZQy4WHEpGOlQE4EMI0s2Gpj7fv9SLnhXf0YoWJzk3UF23BzgganlTftm2L89TtnVay4BIaYCA1aPZwuVZphfY5j3/8aTXSB1JLN+Ji1Nh5hzWA/ZvqQRvbbRgfqpBMw6blQGRQJDdGg/5+ACCqcZN5/saic2bJGRPs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XH73RiTq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bQtH4UkB; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XH73RiTq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bQtH4UkB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A38851400079;
	Thu, 18 Jun 2026 04:57:43 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 18 Jun 2026 04:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781773063;
	 x=1781859463; bh=MDQVaJpWyEjp2IEHq9y3KMWoYfQkpYM+k+luTidhqaY=; b=
	XH73RiTqO1AYMBGxu261SrwzZwja+HNjNxuXtsu6zJtFYRKfgjsppuMk+TnMpSrP
	IWE4Aie7phOv+RcfohESpDeamEzIvDSD/lNlKThJ7fjXaCHS9fTNB1LINArd4yHq
	k4F2kyUhJpOXltakta0xEGUOdvdXdhct6KA9RCeYe+rfNH9l7SLYPi2y9avIouBg
	wRvDa3j4xBGJtFdskrXqZk/suMx82/TNGh6vWWaZlNRqkGFTMzXgwnjnDODUEbGp
	UbRGmXXnyYZDvaShIYr2z9XWTHuWp4ffDkOapmEwGJ3OQ8SrDY3xGfAee0mmQjin
	cl/bOEEHohxLMBwjQemmuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781773063; x=
	1781859463; bh=MDQVaJpWyEjp2IEHq9y3KMWoYfQkpYM+k+luTidhqaY=; b=b
	QtH4UkBJxKusI0w5jNtvl5ZItEAaxNaK/VaNJsAAcgmweswQV+EuthCOHnPutJ65
	unCHudK06T+ytXl+aHpOWvKDgOspn43lcB3qMrFGg/uC5cfSj09O1Yi/Mxbtz638
	x6R5AEmZrWum1l//tLDqcY8icpMuXf4ze3bdbdBugBHD7VR38ltehBsVqIBG/F8V
	9XcjqIGnBGafpq5QpiYRwwZcllXl0AZhHLgWeSBz+6EHw+5t+R9YNuktb0oHWfS7
	jE9gNG6b0uROAEsAqb7+AXf5tz+VPiNZKbSYQasdU5Nh1n7EYcIax0LLgyFr9he9
	l7czjMpZUwqTCrsYVcY5Q==
X-ME-Sender: <xms:B7MzalKXi1GE1rFdMwNBuBEKIBylbh6auTLqWgfBtlBeiK3ZoEIGXVQ>
    <xme:B7Mzar_tiZn2xGB3KOegrAQt-txTCSVfALxC7oKUGRBPM3Zv4QW6eTqQg0WfM5Z5j
    VzWFpyNyVwfjfytMCrG-UF9f8oH5s4z7eDyxwUt1nCe5L_O-AHzbA>
X-ME-Proxy-Cause: dmFkZTEZLyaoJh5ax8RsShtcTOgOyNl/1pbSTJtJ19ZP3W8XOQ5qEkBCx8rmaG5UDsd940
    F8D+U9U4luyims5czeKKieNmYrdHGXoxQjGazFlx4zkB2fS4QhFH7FlYJ6f3siOwGuzuRG
    NpSezbMyUGmorSa0+0zaJ1LyUz0iPQsMieL2FrEPU78gezm+csDXqpX9FMN+7rQUiXSmU0
    MiT4bMZbpgL1MADTQHhHFg0Cutldb57HfjER/pLwPMWgYcfRB7XIpSjIejBDcKvMJnlu+K
    usyS2JOUzljqZ6rqnSrLHhFKQ356E1FgMAhzr7V0isUuCKHgzyz9CZoSJUdnaFwqvnMmhZ
    W97VofA0RMs46U42iAtIGE14koRYOruxUzjAveIqqoPIbZvjAkRPgpmwtO9BtU/2lpPxvX
    PP7xWLKoFaEFGp497mL9wqW9Pgt/UbDQ+DbOIw1lpyHQQgfCeKDfDP7ogSqVCOskgEvQoN
    Q5D/UTMaZt4eToU7CifYoO8v3r+QoopL+9siZX8m87JGsHBDTTPCtIHmv8TJsdd/KfYKf/
    Xvtkkreowq02zsettB5iVOjuoxJ5lBy6u95FzOp2bBFgzUVtKfJjaIsutFPFJb5xhpWvSK
    fZLk/1QKMqvrD/kEmVov5Okgq0rQPGMMo/v0tfjPCtNHpOqmGffqMO6Sc+YQ
X-ME-Proxy: <xmx:B7MzapnOLyvMLGt_L5KATv127bz4rYT8LtmenipLO07nW3VmF1JHSA>
    <xmx:B7MzasnwzmLt0MP208hPjQ4DAjkb0W8wKY6ALOay9LPYA3RfURoKnw>
    <xmx:B7MzaiuXHrACPPpcDNCVit6jpexjEDP0NuHF2OFLM1xtEtXx1atbVA>
    <xmx:B7MzanmADCntudr0u_46GP5yPVceA0lnXnNMbyCB-H-6LNePGCQmuw>
    <xmx:B7MzarB8ta8OdxkA1EA3ExV0iqa4h-IefStjnldrnwhozjhsZEd9rj0->
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7DC383021B5E; Thu, 18 Jun 2026 04:57:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATk8gt0lp1-J
Date: Thu, 18 Jun 2026 10:55:24 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Michael Montalbo" <mmontalbo@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <af7dea68-59c4-42c2-afd5-708a3068858e@app.fastmail.com>
In-Reply-To: 
 <CAC2QwmJdF+YzAQE3WDEaUrurLVkYcAA0Cgs1YAqyxYcQ0jKfqA@mail.gmail.com>
References: 
 <CAC2QwmJdF+YzAQE3WDEaUrurLVkYcAA0Cgs1YAqyxYcQ0jKfqA@mail.gmail.com>
Subject: Re: [PATCH] SubmittingPatches: address design critiques
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026, at 05:53, Michael Montalbo wrote:
> Junio C Hamano wrote:
>>[snip]
>
> Two small suggestions: open with a direct imperative and replace
> "effort in the implementation" with "effort on the implementation".
>[snip]

The threading doesn=E2=80=99t work here. This is in reply to:

https://lore.kernel.org/git/xmqqv7bhxiby.fsf@gitster.g/

But your email has no `In-Reply-To` header.
