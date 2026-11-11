Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419445;
	b=bBXdEIjQaEsrjFxTOJTNV5lZx7NGfA9sDGaikCw0cOKgSR0ql4ESghe/P+eM3V83r1xV
	 5vlovq5CZTnN5HMdhl/enRYX4QvKYBxBkCZh8gpeshEQUABnNcGRHpopItr5+cRFiG7UP
	 fQg72p6vW+hXkHef3MEaSshAkwCVhlon5aZ+ZSkAB/8VAkCRhj7ckkNCAh+vjYpsEwoqs
	 uJG78taUGpdMb8h3imn+D9Pgr8hBTZCSFmi6JFmkn/xZmJZQJ60WxJtgEaiF/broZrnVL
	 bW2kNJJdbsgV5O5Y1/FNb5sU8JocmC+HBwSzpcOlp+g5TnN7Dqble8gdpXwmky9tKyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419445;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=PfvsA5CactKla77D6vn94H/Mb/e/I7IgqjxQd3hCvcM=;
	b=m+bHN79abmW+ez+4PIykt93+hPZNGqv/zJM3eZtCh/rlW57c3S7wEmu76fDo+KrFZbuL
	 5p9+JQuNxbyC2EnjLv68gQ/KS444tgnQ8OiP65l7/srhi5wKMlcyj76vsfG6W5nIp6QFq
	 d5p2ZseFHN+jhBB4ImxbFq/KoM/GVnRAG0tQxyFs037E8xsuTFMV7WoMZRKUbxR4kgNaP
	 NY+GVY1fH/C2zybRbTYL3yF/T+kCSRmlYigQh6eIZXyipv46CsxktAdC0vUR4sQwvsAqH
	 8h7LYmGGvCnOLzamnxtMnQR0vOb5lCHw/FA4Rl13qchup5IoOQojyJKIwCMaikfrZXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=nQX96dEk;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LGLJ48mt;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1FB606A31C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 17:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB1FB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=nQX96dEk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LGLJ48mt
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ECAF41400177
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:50:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 11 Nov 2026 12:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794419443; x=1794505843; bh=PfvsA5Cact
	Kla77D6vn94H/Mb/e/I7IgqjxQd3hCvcM=; b=nQX96dEkeL3/Qhn0d2k6hAI40C
	WnxBg0b7L7hg/hWX5WOMsS3ErqY0gVefFDBWJt6F/NngwPi4gdBcACmkaXI5b1K3
	PiEuCcYy/geyOlpOHXsshgjKWaipxqy1YgaMkL2qdbBNR10mgpA/kyYBkK0ThzeP
	q/xD9rLBuiqeayW969ylQP3gpNIKHOvgWaMU8ILG0IuovVzU9m+waUXnKtSNnCiP
	nd2+vNHPt4mf9Vt0GIP0TW1bXDvRjmvE1D9yfNCJ0yUJgGm8dNoO9Mqtldn28iyH
	hIfqW0RufmFD2qo6cmC8GzLikZ1Ntgl2+Fqj8T2mtT1hLhRXt5VSzt5/2+Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794419443; x=1794505843; bh=PfvsA5CactKla77D6vn94H/Mb/e/I7Igqjx
	Qd3hCvcM=; b=LGLJ48mt6/hfYu4SBws5blMKnsqew67MfpFTMqtRWAemkJ3GhFs
	sgyXvGxuNnb5lhcUrxXdLiUroEsuUX/Y31qJYbECGlO7f2geyR9v2nf440D8U8ga
	Kzdl9ce4VFAzlZX7lDufffIM8V4iGmXgGuLVUVxR+/wZ0Md+Uxs7/mFmBT+nDKy1
	VJU7lL16oP4WPsnmrxFeKulW6coURt3CiOXh5drb08kBP6QWw6Ep3Angs1oIoqGD
	RxKk4TQgkWj1B/rFBIKp2ywIgS3Gn8l8WV8wVKwKk2oYWkZ+aviz01i56dOkIuAu
	duhwJ7c1mMO2wPc0z0vwy942OX7tLrSNnCA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794419443; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:I2MsJeW7l695qWj5QZ46iMJ/vPt41UJh5HhkTf3czjqiluO
	DH+nwCoB04tyD4ioq/xPOIFbjpd/3PsU1yXwfZy1Qa7rUujEIfZsO9ycA/u9MtUe
	eHeBS18a3CYoMql2qM7C3yYJ8a5rp5UqxjTzu/pT3xWr/q25X7A3w4I9FXv7zdGf
	pO+rFfd4Ygd+gH7RHb/Vj/CQd+CAefZ8xXlgMGPirR+s7ndbo5F0M79hpOrO0C1z
	qnPUF/gKeJsyZTpphfWvFuH7iQk6hRuHXfY/mj/ctPSu3/3vrPNbt7rIF4O0V55n
	+wX0IenvwDzZNMQxWboLLNabK1RzhILrx8q8pMA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:c7eHEI972ydEgjKLCf+J9mHKdOB7XOBKGC8dTgtSTGw=:mXS9MWOFBPlWKRLrnkQJzB3EjsvL7EZJJNxYvfL7ygg=;
X-ME-Sender: <xms:8qr0an9RXLK20V37h4E-D4tnejNWlbTHZBjCi1LWReWNkYE3lZ0UXQ>
    <xme:8qr0auHhz6x00EiKhUJnUabB2ps-HSuCNsUCrRbqVnT1QryiP1da1Hp55z0HhhuOO
    ECFDE13Nowevc3WYxyQPoc40jBejz67KwKvaWtjUKhs-q6lSA9FP9BV>
X-ME-Received: <xmr:8qr0arLypV-rMf5xJQSeBA27A9i6H9aqe4TJQwlRAEFjNt22ftB-WqHjJ4-e3JSboMcJl1qA2sgIes5bqlWU8Tp5_vkVrrg68RGN>
X-ME-Proxy-Cause: dmFkZTFnqYZ3+c4X54VbQMgnEyaBvwfuxyMs6amGIpJIeXfJkU9cWzck7IaKPKvyxQdMYR
    5ZAWxWsbmcvw7CilURZUnTkdMkOFeeYRgsVf8J2snQFEFEJ/2XFFc6LcAkrPTZmDY9OMlG
    EAy4STsKeMspqPXYmo9sqreYo/N/Onv13Ak/zn5DVtJbpPnGCrsbHfCDmr4uBuTC4Fazmt
    3Hj2qTzQtQfe7+J9LewTcdwm4djuCEWowKcaKezOcEFiJuIS1hYwYmHSSM7bOhcUx13IAa
    wBRQvHUqd6Sf9TiB25UPToFXAAa58SvvjbGVLGlG5Kg/hkmHjgXHPKCLAODkE3uneMgZTQ
    mRqAUH/Zh4UB6ODtpQuepr0B0NYREA0C0bk2htPbRHZiM9kmz8ncQv+CC8NRxbEPXI+Jbq
    4tOLAP5KPQvwo0S2GDld24TyNcrM/qiBgMPCkSow9/TDmah9HrvdgDoQjN0kGEC7uUczAi
    Kmms8QNWIWjROi3a+W5Pg5xYVo079wPxi4WFyK5c8Wd9j2/h25a+Au6dsfxhtWhmIgzU71
    nAFjCvGpIwn443Si7jmJIWalJmDU0zZDHJ6ipkfTCKktb/A6RyoJH5/WATQDCd2fxfqXej
    PrMgjWV9j6xKDHr6Rt7FSq3wZ0lIejaaeloXzxkxeHVoD6Ggri7A/deg7I4g
X-ME-Proxy: <xmx:8qr0aullMwXuPrm-af4f46sL03qrgCPyImbwEAkqGdU1bMLhPW4WFg>
    <xmx:8qr0aky_aPn8Nhj7WkTNiP8l0qqleaoSuf_FM6PUgz4MGRFTdGmAvw>
    <xmx:8qr0aosuMsMp4VSCiCM7kT7Br8doZxg8zs6piNJw5ZNFIL3G83_BSQ>
    <xmx:8qr0amEjNgVU7BW_hNAAZly-OUs5bNpPGppxmdM2GIq38uH_cX-H1A>
    <xmx:86r0ahFHnuV1D6mIRl5v1rH2eEEVrbphNUJGqmMC5TRiD_yADTWP2YXa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 12:50:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Jeff
 King <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Derrick Stolee
 <stolee@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Colin Hinton
 <colinlewishinton@gmail.com>,  Matt Hunter <m@lfurio.us>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>,  Miklos Vajna <vmiklos@collabora.com>,
  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH 08/15] merge: handle NULL value for
 branch.<name>.mergeOptions
In-Reply-To: <b298dd66-49b8-4019-aecd-e6dfffa2f89c@gmail.com> (Phillip Wood's
	message of "Wed, 11 Nov 2026 14:47:26 +0000")
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<e10f1fc0ba4084584e11834ea98b8d8d8e353244.1794040968.git.gitgitgadget@gmail.com>
	<12def237-2d01-404f-b7aa-b4f19e033cdc@gmail.com>
	<xmqqcxsctyow.fsf@gitster.g>
	<b298dd66-49b8-4019-aecd-e6dfffa2f89c@gmail.com>
Date: Wed, 11 Nov 2026 09:50:40 -0800
Message-ID: <xmqq8q2zntov.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> To me confusing thing is that we don't treat those two the same way - 
> I'd find it much easier to reason about if empty and missing values were 
> always treated the same and booleans required an explicit value, but it 
> is too late to change that now.

The "valueless true" was there from the beginning, as can be seen in
17712991a5 (Add ".git/config" file parser, 2005-10-10):

    From: Linus Torvalds <torvalds@osdl.org>
    Date: Mon, 10 Oct 2005 16:31:08 -0700
    Subject: [PATCH] Add ".git/config" file parser

    This is a first cut at a very simple parser for a git config file.

    The format of the file is a simple ini-file like thing, ...
    diff --git a/config.c b/config.c
    new file mode 100644
    index 0000000000..f3c4fa42ac
    --- /dev/null
    +++ b/config.c
    @@ -0,0 +1,222 @@
    ...
    +int git_config_bool(const char *name, const char *value)
    +{
    +	if (!value)
    +		return 1;
    +	if (!*value)
    +		return 0;
    +	if (!strcasecmp(value, "true"))
    +		return 1;
    +	if (!strcasecmp(value, "false"))
    +		return 0;
    +	return git_config_int(name, value) != 0;
    +}

So I agree that it is way too late to change now.
