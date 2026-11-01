Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793495373;
	b=mgSA1MkPwDuM5+6edhQJUaL/z6ITyOosQxqlOoYV2yfCvwT1IMm/ZOXGXKqRObU0cBjZ
	 u3JQL8CDGpNF0jn9nOGWs1jxT6pP3XTPAPfzsHcjhBMV6Cj1E5B/XqJ+J/eCchAITLRuT
	 0t+xgqbCYdpWtH/y8LCNmdrI83IVs4QQJSim5syi85AuQFtOy5laKOu0uwebV1fu5Ty35
	 o02zkfx3/A9iUkJr02jJnWYRQlwmN7WuMAaVy+s5exaFIuhvROKCfsxxgPN2x6gf79Fwu
	 05ODVRWJBp2yk32VAG85bs5W88xfNn/XQJ8Ml3vOu3B3du5i/73vbFCZPDqNnjH7+EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793495373;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=1mCbkJfV5iUKOWnB10cuJ3RbMw7JasqfYiXPPQZrizg=;
	b=CMEe36y7rROjS8oGqn7D5lfdaNWgvW52mNEbSDoL1NN5/tA1nHYBozVfJLjJESxHxDk6
	 9FtM984qAcu1gbRe4CDZygL/0Ns7tkxQJOJI9qCfh40OMAa0zPpxAN4eh3e2CRADYmn0t
	 L+1Vb7xPHNwMNReYQ6jbPQ9OypR7lLSfdZvnzdktaWroWdlRox+iIKnZWDrLS8/Pvcqjw
	 Rrxv4Wm5GQeEYNgbkVk3wl0+vfTA+8085zYd1Wln5YJ50SSvGLSJFrTdtSNhqd871xyRC
	 5Ui5tZFrfGhPWU6pskoPk5bmdPvt5LeO10FmYAMhkLnuPTNjdWUh8/uY08BL3FOiUAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=PFzGLRKv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xRQm2IvS;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7752A606A31A
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 01:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7752A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=PFzGLRKv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xRQm2IvS
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 89755EC01CA
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 21:09:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 31 Oct 2026 21:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793495371; x=1793581771; bh=1mCbkJfV5i
	UKOWnB10cuJ3RbMw7JasqfYiXPPQZrizg=; b=PFzGLRKvK+P0mW6rbRXsTCoBnH
	tNV3Prrw0ylM060xxM/UoYYB5T5k7hQ5dGZNms0gHhSWydlW/iJwcD15ujkRaVS2
	za3ayFcOPclewH5d0Q8idIyqcEX4RkRrjIxU502ntUbFz6kyN+EeBZo5jq2Spl3V
	e5t1v9CjXgaA7br4AdF6SiAzQ6aCHDmu/3HkX8keNjKivivLaqVd1MASlDsCGq0r
	AcCPhPAQDbgO9TKRn+1BGAUBdGRMuw1fxHmn5HoQaT8gLNa2XblrXRlKbQC6vkbq
	a3rPgkg1D3Q5HzIQYCLPN3iAJl3fVI2Mrl+U2KmR+z5J17QU4b8h8xEMUsmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793495371; x=1793581771; bh=1mCbkJfV5iUKOWnB10cuJ3RbMw7JasqfYiX
	PPQZrizg=; b=xRQm2IvS27h6Z/MwTeyxyoVfbyx++a0Ow+VayT29Chpr4nrZB4h
	XCjUCI5DgazDcI1tS/T69x+Sc0HsYFRV9Q9II4sVc4uvqMP3EGBPPGh40ilwFmPm
	IJDkfuBnzcw3NxAX5zoSOFxXbdyXz3LfGBEhoG6xP2tPOnYySzqrgNFi/YyFXIgO
	edci4E9v3/b5TLNbHGMIEqDvuqMEt+xdlN63FavNxinBJRbYP8H2PwAiovK6O+ri
	liUKg4N9DTxN42tx4JP/4abxdVJKHRPLFWsCJeRw4bYB4c3hcqivqvmuNbq1Aadh
	1ZIIhqz6Z9sUinekInDFpml0/cNY9e28lKQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793495371; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:okVB67wmE0y/+UVSPDwsh8AFayv+/v42bBrXM9T6nIVw5hD
	j0IJXYQzG7a5armqMgiuesrnUeXrtbMgwAp1BbCVP/RzaBxFUh8sQIULD4D+ggCU
	xL5gFk0ilBG3LhhT5toPPY9QHGuLz7OEKRDPuIUsTaIzppQS8tRY0bnLjykvFuzR
	dpU4VJSbCtrFj9/pSE9aRu+TCLYyxTMHunLJgPoRTqHxoKRoLXkgtfn5n4TdWIPR
	4+lgXijef8kd1GtJ2gTH4+6negBDaWzjMV0Tusgwq5LJ66zwk97CWqT68qn8dsQO
	977BoPghwOaVFLMdjDm8x766JSnKk6l7EvpAmTg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:dPH7pJNimgwhgoNwueZVGNy7yN+7B0beCluh+GFVA0A=:PX3zfppONPzMkvvy8kKe8hjpasc/DWTqZRAkLD4xd8I=;
X-ME-Sender: <xms:S5Hmamw07CxWoAz26mdGjqK9ZZ9WUz3yT0TFgoZyIbEEa2apE-mHDg>
    <xme:S5HmapJAaG7F1IQtN8DF1PaTr64WUKvga4UmdAk6WChQ8KANrihL925FutSNF5SvZ
    A22lbA3_rjSBii69K3nz6KVZlerp4OM3gQPh4qnSJtaCc03w1i9SD4>
X-ME-Received: <xmr:S5Hmago9EXKOjiWM30anyUO_ZdaL1Pbe68pg8bPMOIJ4cqViwsuBxmDT6a7NQANcu07tEVp3wyneUYQBaxtYwuGqXGdMmfetX21Z>
X-ME-Proxy-Cause: dmFkZTGTihJT/JX/9RPV7KLB85qH4zRGNgzu8ng0xlaqtMgiaNLerW5USXEw8IeCF5kARF
    JTGm9EOUmE2iXyWpP5U2rg7PoM5BENeHExuu0UnolAhIfap9nWP2NJlWaDrztrhmUjvH3d
    WJ8cIbIHn37QRKVcZGMq4SNNFV38Ssw5n3fZ3QWvPLjQyiMmyjhI1IgPiJod2MfNDSnruX
    2o5J8+mqo0qLwC/THzSowugLVWNbO3kmBtrD6jvTZmrXacAwtU3riLC2TKSEDWai152AHQ
    0jzNujUtGsWmNZlHWvesjNzE4kwdq+7mVf+az8siC+/z8qgjGnZZODTW1RRcH5q11fAkUQ
    jl6Zx1rp5jqcJxemfqggepue8WV/hWZ/NA70i9F2OB57nCiqSltNFKAdtL89nZAqM5peim
    hgjc9W6xijz9uShMiEzdRtcczMpwcGI3szD5Vz9rtD2ds0KCYfoaD5zpHNWuccV4P8egA4
    B0Yg3VIAx95Y3yIttKzT3kMczoUs+NHjArQQkTOzKK9jbKBpGnIqCcUg3RBmRfFWgAF+pj
    TFjOLWanM4jN/4xFgGjGvlLrQC8F/IObi0AQ4Nxj9qBxSJKRtUY9Fhggl3xXh3pQXTmSNU
    5VBxd4LG6zemLBtq7JZ0tKth7DRcXrUsHzTT65BlpWW9D4PMHqu3n6qDyy5A
X-ME-Proxy: <xmx:S5HmaoIjB4WsoZelQ19Uog6uCTGG6pX2W-UEwzshKVV1AgVJgc_-bw>
    <xmx:S5HmalSn3rp2jxSlt9qI5TU_wsG1Ci8RLHrzclUKg4u3iVbpvubcGA>
    <xmx:S5HmansQj7gljigK16w7UBXyQ9kutKHTCgplfwJibibk55vTF3mFAA>
    <xmx:S5HmambOVU8v_itWMsxLdmbO7_zOVZg-1lCJsSEc56d_2FZeM5KOJw>
    <xmx:S5HmajY8YgogbDLVmmhJXWdmiLRVIThEeZsWjVKzfL55Jx1tlEeyeE0V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Oct 2026 21:09:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2 0/2] remote: resolve "simple" @{push} when pushing to
 another remote
In-Reply-To: <pull.2466.v2.git.git.1793433841.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sat, 31 Oct 2026 08:03:59
	+0000")
References: <pull.2466.git.git.1793105039624.gitgitgadget@gmail.com>
	<pull.2466.v2.git.git.1793433841.gitgitgadget@gmail.com>
Date: Sat, 31 Oct 2026 18:09:29 -0700
Message-ID: <xmqq5wyh2w8m.fsf@gitster.g>
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

> With push.default=simple and remote.pushDefault pointing at a fork, git push
> pushes the branch to the fork, but @{push} fails with "cannot resolve
> 'simple' push to a single destination".
>
> So git status cannot compare the branch with where it was pushed. Make
> @{push} resolve to where git push goes.
>
> Changes in v2:
>
>  * Moved the "simple" @{push} code out of branch_get_push_1() into its own
>    function in a new preparatory commit.

Looking good.  Will queue.

Thanks.
