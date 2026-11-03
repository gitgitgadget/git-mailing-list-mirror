Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731617;
	b=5Yq5KSrb2NKaVl8y4W2rdLeyRNIKSbVnCXvNw7x8U/vedYdTC45xVLMP2PnXZYiiU/jN
	 QQlMfZm7fbHhvEyAQnRfu806nnCR3PfFqv9GC1SnKNZR5u7L8DGsdMntE9GUVKPNaBceu
	 ImkPdcw4d/aoCK/LQ7TShGlGu6IyVhej+4RVJD07ogCmhREKyKWkFz4+vpmmzFo5NlJ9A
	 Tb9vLhDsoR121gpiboWPwI8XXOThfKAzWdZ7J911ajvU3lAU5oAOpXR5z98CWQNIqM2Dy
	 f23xSPH1neXJsx4lOFSTP+oohutYrlm33bRfmJvWMFZqaUZjr2Ac0gb9hCyxASDDBXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731617;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=SjMEzPFjlA1W8GMbt7z5bTx2xY7JdcB30rTnyy6ihX4=;
	b=Ruzv6DvhMGXa++sgskQTHN/FXrx0jSRN4XnXtDHbE9ERGEolEtQRYhyHj5JyTzlGFx70
	 mmDpZr30fWgByMDzZK5ixW8f3jfLg3c/TK6XiV3xUsxoW5uVOqM+4f4v636M7kZYqb6b/
	 CigKxBpG2RuHf8L3A50wzK/LYxyUbkKUrVruIR7SglK0dSpd5TjrvU91/W+M8mj+MA/Mv
	 UvEvY0BWGtOiLBdCa9S7UBFmJYTM8jpDLoCX8zyfdPMxhBOqzqZt60NtbrZzZndv9Ajjt
	 hbzwKum72HKE19n5bLiBxktn1n8fyeK/DHk/9Y//078hSbe6DqyWGTlB44PvF7ov4Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=R0lC3DSX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=l7Vw04PY;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0629606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 18:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0629606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=R0lC3DSX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=l7Vw04PY
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3C1F1400094
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 13:46:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 03 Nov 2026 13:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793731615; x=1793818015; bh=SjMEzPFjlA
	1W8GMbt7z5bTx2xY7JdcB30rTnyy6ihX4=; b=R0lC3DSXFqxKUrBAuTxPNsjLja
	Zh2kH2e4Mhm973AgXHBSznaM+YL6BECdisHPaCs+UpPKHKaa4Lw1BpO0GeQ023h8
	9Q45hrweXT8zj2HM4E+ImzvHolhxO5m5w6UG2dIbQkakLBdPWynFP6rwcHrCqiNY
	TbpeZGEN8vGwn0PckKXlO7ruHSUELIw+GXa6zkKLiZ3fXwpR8FQ3Ce58uxmXPzLl
	PGCm1ur+DL75J9z3Xq53oTyxSRGkfpUMIUePQc5iN3RqOC++QHPITnviaRJrtQVg
	eHZdnCBQ0ssBZPvyB/qiS9/KyLAXpPobqFZ+lBh7/QvSFizrcsJVH7W80ApQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793731615; x=1793818015; bh=SjMEzPFjlA1W8GMbt7z5bTx2xY7JdcB30rT
	nyy6ihX4=; b=l7Vw04PYnO+uC1F2i/p8BdZ/V4Fd1WvNf8hrkbsfPs8HGxNBIQG
	7FawPCPzkcO5GjhLc8yzMeFJ7FRkupZVcuVk2s6TJuQPhhT0QttK/zunp7XxmAKc
	zkVsGFeb94daVICsH91pzZezFPhRxG+d3Sl0PrPrF9yS8kVPVWMlTKGT7h3wk7rZ
	YNlcefsw4IWOhXVzQfSKz2Dzxscb5jbZCF3aVqJIzcGqKVE0Y2kte2ucrdZgsM79
	6o9P175PKhQEEGtImzJIPvesQRQ8Pn+oD64eQg+EQEIHcUfHiN4CgkacsAo4qF4S
	xgQ/obiDecFVYV1Jz2K8BccHZvj5ah1oo2w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793731615; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AkkYAL7p21dj9jPP2DeS12Kp9cEua0+r9gyKY8LMT68tijg
	kBauZaFYzwfM9vgKv4mmTgB3H2QNkEfn6jlOVsmykGxZH46m9zpHHeeR7jH9H1b5
	jrze9Vaovv3Gewgv9SLzMj/1x+QM78jvwAAuECLmpTfK7oltdoD+kD6DSKn8fHIW
	xRmzKOizL6lV1Z40frwqfO2pKhANB5LGdB08E9PolY+BDD/8CO416ZSmx9BixXxi
	alQGM1vIBKBJ5U1Uacsn7ZNAyz5e1jlXKcDZMkIEhU8mR/CIQqEXgSxU4HpEQ9on
	xCvbJ94g4/PoYqwgPhnTFcz/5s5gkw0wKQs67bA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:saY8rRvP26v2+B8HYWWX6GEMsZqqKATZ929DlVV6PME=:YmAeaYPHBguKl/Q0pZSLOUXj07ScA6pTw3x9TSMBMjg=;
X-ME-Sender: <xms:Hyzqarm_B6bKBTOLjb5yEqOFE-VsujFlJVRKuWGLmBjxf_11zxoTIQ>
    <xme:Hyzqalu-Re8BjLpkRP7CQfBz0wrDkTa19EEFBP1pprxYC2n8NMSFhfOTf8OXc2UdW
    DLY8XxJ6Mu1jex5QYfqMHRm3dwrIjmatk_Xjwg_gC4trluThPmK8DE>
X-ME-Received: <xmr:Hyzqap9hrpIn870ohsGQNtQzqbaBhFg7cVn3U4SI04oR5WLuPHjabji7kPXl6BIAMDjEGVZcODMjkIBr75496FRgO-K4rC8_wp8G>
X-ME-Proxy-Cause: dmFkZTEbRCg2eAAtObFdhUUjrcbgjzV4ds6b2E7nYK4OXXS55Yy6ow1dR0LBUxwo5s42Ne
    Kh5yZJQujJXxkNk6mchrVhsq9/rc1TgEOlaWb/q4wzthXWEYC8vsj8aGPlJ6tPWr7V/3lp
    CG6oB8MHIaH323Nia9ZXF3zRDz9CQQ2k5HNnQ4NrQ24BOE5+A4xOpuQPncFPKE9ov/GQIq
    brqMHrn03+wm8QWvOd2CgziwqSLtlsdWJzKTEwYJ9T9W2Z8Y8ZfFGATvlF7UdzfnXkK+VN
    28v2CFVKN2DU2V8joXyFvyuzzR54HxeB0Mgfkpzlu/CeI93gav0Dk52xSz55bxoNSpOqkA
    4iivhMu64HO+uBz/R0RmkZrBsxGXRocWlm/PzFLwT/CsnQu+2GPIxNI5DTmZpxKHm+7jLm
    ytwyqxRIVgtiVV/RY1AcIw+UeIz5eEo04LbtqvACZfkWNTm/PDZcDigGV5cP5hOiM6Bah1
    pb8accTQHjWI3GVafd5CEvFQJSEK9lQdC41wGNe2XWUn0woE2Vt7pYpADX/eVBchWHnNhR
    7MDQ0lWzoshBF+JAHRDWJyTgOGUpe/CC5etMtmi8qHKOh5QQo3otYdVs2MZSY8+TBLqrv9
    u61KPnZJtJsNBYc8muud+S9P5cpYA2/86lYpFCBFtpR0Bn5CWJ/EODxcLFug
X-ME-Proxy: <xmx:HyzqavOUKYYct0tflCF5W_ymumUtnRGhnZfVkCaH4PUFSHelKBhIBw>
    <xmx:HyzqanF6oLrYG_HS4AADrhF373ed_ASRM3uzNCXiMPYxjSWn0mjF6w>
    <xmx:HyzqatQBfoZMt_hZZbfzR5oVexYQ1RXtTCsLSNL2klMAh3OuOIZqAw>
    <xmx:HyzqakuH9FauQXLRCY2kp-qQNMYREd2xrlZkHtoFZ4BtnjeUqoyaaA>
    <xmx:HyzqaueEZUrsIQHDAs3R2m-GUYFQaITda9RdeXqcJV4Y6uKys6jxjNhM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 13:46:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Husain Sitamuwala via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Subject: Re: [PATCH v2] check-ref-format: use parse-options API
In-Reply-To: <CAOLa=ZS3ULcNVjV1DMO-iB+LcC2Gnw+9oU2_7VXKoLvgiVRnbg@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 3 Nov 2026 05:00:59 -0500")
References: <pull.2470.git.git.1793298807397.gitgitgadget@gmail.com>
	<pull.2470.v2.git.git.1793694813386.gitgitgadget@gmail.com>
	<CAOLa=ZS3ULcNVjV1DMO-iB+LcC2Gnw+9oU2_7VXKoLvgiVRnbg@mail.gmail.com>
Date: Tue, 03 Nov 2026 10:46:53 -0800
Message-ID: <xmqq33th92hu.fsf@gitster.g>
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

Karthik Nayak <karthik.188@gmail.com> writes:

> If you follow our 'Documentation/SubmittingPatches' guidelines, it
> states:
>
>   It is often beneficial to allow some time for reviewers to provide
>   feedback before sending a new version, rather than sending an updated
>   series immediately after receiving a review. This helps collect
>   broader input, gives reviewers in different time zones a fair chance
>   to comment, and avoids unnecessary churn from many rapid iterations.
>   Waiting also encourages you to polish each version before sending it,
>   so reviewers can focus on substantial issues rather than typos or
>   other small mistakes.

Thanks for bringing it up.  Also MyFirstContribution has this:

    After a few days, you may receive comments on your patch series.
    Carefully read them to understand the reviewers' perspective, and do
    not hesitate to ask for clarification.

    Reviewers may also ask about your proposed commit log or the changes.
    Answer these in your response.  They often ask because the patch needs
    clarification; use this feedback to improve your writing, and update
    the patch so the next reader does not have to ask the same question.

    Do not start coding, much less send the next version, until you finish
    discussing the current one and both sides know what to expect.  This
    saves time, lets reviewers respond before you write a patch they have
    to reject, and avoids forcing them to inspect 'v2' only to find their
    concerns unaddressed.
