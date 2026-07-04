Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8730D41C
	for <git@vger.kernel.org>; Sat,  4 Jul 2026 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783154823; cv=none; b=RgH8vbmQ8cR6FA6zt2gs36Ws57aYAH3aoLQegUah233NK+2j4X2xfM5Ks07u/ROKA4AvCoMCLOF/8mDaVbf/D0GWcM2RFHByNE6KgdWrkxt8xaR9fD/tmiOC8mJaSVq7xceEJixpDHbtiXIBBB7cb+E8DiuKwNTUkGLXmoyrvC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783154823; c=relaxed/simple;
	bh=qBOKcrVUcyKVUTbfnhI7V0H69HHkKRBggP4Q76+nS/c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tGBB7IWQh9GXuXLFXjaHVC9t/Oxg9wYVHR2OImnD+cNI1ZNJ/4+mySboNcrmej1sEvRbT9J+GSVsxdkE+5pgIXfCUzYm11pr3DqNqQaB4P2602Meu9CJsB49nXHK6wM1bIN7GTXEynQ4pRKhezEL/Xozq4TKv3vuVeS/yHBTKGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=hFnfO/Ap; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="hFnfO/Ap"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783154819; x=1783759619;
	i=johannes.schindelin@gmx.de;
	bh=3YqhouOiK3VosHlT8xbdyj0/qhdSLFiup3qpHax4C1I=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hFnfO/ApnzMPnkcSLLy5dgHfPhJckBuxCbkSBNwnW0ixyKR1a0NX9ghD7oVl09P9
	 acDp2XYkyWpr7vAnant23+/cFvrGvzihyJnDBvYhKvnsfHpJwSm4rTXOWx/yFYSP/
	 7R+WDfTQ1QyeE64QWhX4YOhJOpoBuBSyVWfvd1vAXlLvU2C/F13i8VBiIeFNhKLu9
	 /t13NM3kJSQwasP78AXuNFAqv3JmUGH+NrMYGfxt7kyPes+Wk5sbOQiiBWrrNGSIG
	 C71xUACB/xHOJWpBzwQO32AaUoCAUEUk97hoEPZYzzrJTYaSOdqW5V013kNw1MghU
	 nByC3PprMm/S5jYYqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjjCL-1xMRr60QgN-00bGaB; Sat, 04
 Jul 2026 10:46:59 +0200
Date: Sat, 4 Jul 2026 10:46:56 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] ci(dockerized): reduce the PID limit for private
 repositories
In-Reply-To: <xmqq5x2yps4c.fsf@gitster.g>
Message-ID: <c2986e77-1622-a148-98a9-2f7ce6717827@gmx.de>
References: <pull.2164.git.1782889484346.gitgitgadget@gmail.com> <xmqq5x2yps4c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:m0c+TvvrbqByt0cSjzhM3OMRFYtxX2SIGUezVAeGCTTGliN3j1X
 bHvd8AWuD6bXY6x4Xj67b6GAEojCw5mmj18jq6PDwfhAMnOtrDd0Gae+VXqRWjBdV6dtgO4
 Q+1WwtrqlF64ZtE0FTQdnWB80vcd2A+8+hPdiY5H5IYAJHys8E7iJs/S0TPvs9O4bQNHPKO
 3whniJvrjBAyGeyb955/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P3UkfJHuv3o=;vzz0K0XDFbNfRjixoPMpAPKH6zM
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 1 Jul 2026, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > The underlying reason seems to be a substantial difference in the host=
ed
> > runners that execute these Dockerized jobs: forcing the PID limit of t=
he
> > container to a high number lets the jobs pass, even when running the
> > complete matrix of all 13 Dockerized jobs concurrently.
>=20
> Is the "reduce" in the title accurate?  The above description tells
> me that what you did was to "raise" the PID limit (i.e., forcing the
> PID limit to a high number), presumably because the default PID
> limit is way too low for the tests to pass?

You are right; The subject is wrong. The patch raises the limit from
the hosted-runner default to 16384. The subject is a left-over from a
hypothesis that my experiments refuted.

v2 will retitle to "ci(dockerized): raise the PID limit for private
repositories". No code change: 16k remains the sweet spot between the
failures we saw at 8k and the slow runs at 64k.

Ciao,
Johannes
