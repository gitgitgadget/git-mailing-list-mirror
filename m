Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461246;
	b=sbV8GwxTWLt6TZhii6Cu1nZpPYJkhYQ99eA77gmSf5P0SDdpH/HAmkDjxE+HiF/sEqev
	 Rvd50JubM/F2oOEq+HEv0hJi1Msz0PG6D98duxHMmnGTF0p2gV8+U4xfNsPUZCprtFDP0
	 Llhn1bXXvRztR93vC9DlagjLL/cHVlBpV+/iwI66j/5nCB0tLyMmetToBY2JmH+qIWH8K
	 qkvdYzUykTgmdRMUSv60ZVzhV2akQflaHIDEnTukpiHjxCpVVkMkK7CyWp4JG9T5J0/O0
	 /duYcrUmUPUlP/BBUoIjwHSUBv8pDXAECvqamMvqpbipQEjeojfKgZYJx2B1xkfx9ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461246;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Cx8fD/8W+Scx+HnUQK9iKfjn2s5QC2tx0yMyD/q4Gcg=;
	b=gH1UMMCzMNgh2xrRn+jPL6bKRKKjcg+IXF79qgqAEtCA9yBDI7c265kCQ44A/GAtjyIl
	 twH/fIkn8zvUgKoQVMGVGI5nnxNdG/yZ/VdkNGs+cvTPAdOdQnQvix4pKlEr28KBXUvxC
	 r/VTRqI1eVm/t2gtjhgMaJjMaLk2jDqaoZmqZaPENo1gMQt65yWhA0ypCuX8teFfp2N6/
	 Ca2pUBTy9b781Njs6LBMDMKmsKxqWVUQECzZQYSz91SYT5IEsYjA+YLDhwlgSZCyQRILU
	 FPsvWVe3L2+NgRDYSAfUAOPqOGd3In4bZ/VICWHgf9It6cdiOQGEnnRREbljENUKoyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LEQDMGgx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="JL31/INR";
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4C0606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 19:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F4C0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LEQDMGgx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JL31/INR
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 391817A0656
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 14:14:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 23 Nov 2026 14:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795461244;
	 x=1795547644; bh=Cx8fD/8W+Scx+HnUQK9iKfjn2s5QC2tx0yMyD/q4Gcg=; b=
	LEQDMGgxlIRACCuRDgpPQWwBjtcvpvKvOXVF6X3uBc5iCGKsM5KniGN6FMzjk4uL
	2OO+cMEAK2xsqLfYVpn5Ni2L+B4H3DBXLANRBeDEHL8ulOvxy2T8Mk0kXGSBGeSs
	LYCu5HQ4PsWefg+8tTe3qozZ1cDjgxMW9GJ1WUifhRkb6V1EAcZjDNGufu9V6sCt
	DckG0g8TLAEFTmb9XTa2jyYoc86WoWl3l7M+4geT8m7N3C6RRO9NLKsmCmzyMRwW
	14xJp4UfxhqTj/DYArukZVQk9m5OAXDadjVapgx2hYTM9VPhvHtZ7AOpsayukUKL
	mk5wojhxPCx9TYwO72GYhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795461244; x=
	1795547644; bh=Cx8fD/8W+Scx+HnUQK9iKfjn2s5QC2tx0yMyD/q4Gcg=; b=J
	L31/INRY+N2aCKjQuaRnCtmfigIxeau2yrqDgplQIEro3y2FeOLcTzW4XMSnqVnM
	7R+GsPiHprsvMpK8uamZEFdLNk+mIdpw73P5e9KCQmeAXyyk3WKCs+U+coDxYrk5
	jWBOyV5yfo2ozI9h39rUVcDatKO6EEPoT964X1t/aGdeTsk5gPE1NrtaxvIdPnJr
	kEvm9oO630+PedJ904A+78h27evHKb4q0V/DaQhQ+IyIixTi41635Y3vQckQp5SB
	Oe/CpuHIIKLcHFbNv8Ew/Xk7EHhL+IZUmD0uKCyzfzsMGk+tgET4n5Ja+to9zoYm
	OvkNqel2k+ZaUiELcR0Ng==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795461244; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:c/SDNYFTOpUts/JHztzXY/8zEf/5m8R83v5DJalyZyXX9Uf
	1ZEJCWGiylg0FGhWQ3ns8kLjkhvCm2odS4/Yuxj7nsX/zIK9YSPJahQHvgGPxha7
	BycgCIqoY/i/tPB8tNalcInzKbSWLjsO1drgW4excfV7YhHDVXBX3ouYDr+UJNso
	Y2JPzjIwHAw3H9luJHVq2iTN/yuwUGYxp8cyd1564GTq2RTWCAvpWEa3efoHXx98
	3JIbpH8vY6UsOrSk/2mX/I/UcFtzfJnbdMz0EjQAbLQyPIyhJ3oMAXMp2zMi+97B
	2TgnhOaembLVtENtkAQXrXzRKhJm6P2YZ6D0/Ww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:5D6hj2X0UEtm3/V33vDdhUD2WF3mrJhCetB39BHINx0=:z+8dAq4EkCtV4lFXQhmCM4ayydmCQwNNhtnfVRi6lhY=;
X-ME-Sender: <xms:fJAEa7qb9yM7px4GrvCjw9W5d-_ZNGLhiq1vi1DvLpOP9f_BzYE1Yg>
    <xme:fJAEa5WrP5k__QJ19ZokMoCpypT4ajhwaseu0GTalVEyUzLHK0cZQdVo0rHz8d4_u
    S6IjIGwps7daj5GPm_nDUGy-DSBs7IoEqS_JRptdyZzRmN8qhEY86c>
X-ME-Received: <xmr:fJAEayBHYyC8TpXqDCwHWCr7ljLNDHng2-SX2HOvxmtVZEIYnbdQUM9N3ohSLvrpdvRFq_mTSR_NzcdE2vptbKOAe1euC0jdJsSTT1Y>
X-ME-Proxy-Cause: dmFkZTEy2suNs8m5OvjUaUpzorUxZ/6jUQvOAQN2Smwug9yUInFBFec+k0Atblk0OK/UcT
    UdBppawo0hfYi4hTUvADFpzPq8L7NUDUDrWWa3SsrbCBMgFyhgLugxsb9aatuIBkSbgy5T
    CZgE32H175zqbfYskRgbj0dPuiae1dQg6awmqD1n57EJpa606vuy7hS+yW+lDIltGjuVgW
    UFBGnqIiBzOoZR6p4G2D3fbeN98xBE46V8rMf/tQZXtJGFddQQ5ErTxlSoQ0Ma6KYwYYwV
    yOJGZr1bflR6kc525OuDm1DolUT4tlL2qEH3i+LTFXcSLnrQ2hN1EcfPkHljtkmzZmzNJL
    xoaRRegdPwzsXEAywx5hGFpAjnQKf8/f1D0RAE7No+cACOAXJ92FQmD04ZgOsyx4PWP0hu
    osbwkUaNsmAO9C8A0Nqx7oi7PCWS9Y8d2D4t82hJ0+XZXgbHmE3+AxHOW3orZ55QyqtGik
    XDyNJrVtjrpvhbWbSiXCd2b7Y7qNFZjFzUPbLq1x/sG5yAJifwS7oLMgA5A79TyzLoHfNp
    elcLUNnHVBR0eLlauRtUzQUFjNwj7MxC4Xv3YZOylNstJUJOBhb2iNEHKpHHgOnITh43ZY
    s1kEnK4y77t2uVyQ55NlIW0TjJf4lxoAXS7DssP46GSYkehOF5nSqlFdtHLg
X-ME-Proxy: <xmx:fJAEa114mTEHBLTXgRdd7T3GmQBQu_IJOs4w1JRp8SpmM3rKQHUCDQ>
    <xmx:fJAEa82crQLQWPRW_i9jkKk3I3Ve8HNS_B71HFIeXUS4Q6UwVspz9w>
    <xmx:fJAEayAQ-AArrH-XoV6YcrLb5aEmCfJb3e4N0XMhpCx0I2lPP6vhsw>
    <xmx:fJAEaz4UpPPDJPwglRjdOBMFIUmq_AE_KT7MKSqwAXDHIPVrEKA9ag>
    <xmx:fJAEa8t5th9uLW5e1SGGuTY8_3pC1juv1XBUazCbnvQk2MNKWN1TywP8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 14:14:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Kasper_Lind_S=C3=B8rensen_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Toon Claes <toon@iotcl.com>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= Avila
 <jn.avila@free.fr>,  Kasper Lind =?utf-8?Q?S=C3=B8rensen?=
 <kasper@portchain.com>
Subject: Re: [PATCH] doc: fix typo in git-clone --no-tags description
In-Reply-To: <pull.2325.git.1795428610006.gitgitgadget@gmail.com> ("Kasper
	Lind =?utf-8?Q?S=C3=B8rensen?= via GitGitGadget"'s message of "Mon, 23 Nov
 2026
	10:10:09 +0000")
References: <pull.2325.git.1795428610006.gitgitgadget@gmail.com>
Date: Mon, 23 Nov 2026 11:14:03 -0800
Message-ID: <xmqqmrqz5pj8.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kasper Lind Sørensen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?Kasper=20Lind=20S=C3=B8rensen?= <kasper@portchain.com>

It is somewhat unusual to see the in-body From: line Q-quoted like this,
and it is especially curious given that your sign-off is not.  I wonder
if we need to tweak the GitGitGadget tool?  It has been in use for quite
a long time and I am sure you are not the first person with name outside
US-ASCII to use it to send patches to this list.  Puzzled...

> The description of --no-tags says "the option will be become
> permanent". Drop the stray "be".
>
> Signed-off-by: Kasper Lind Sørensen <kasper@portchain.com>
> ---

The problem and the solution is clearly described.  It is clear that the
original faulty change was submitted, reviewed, and accepted without
enough reading, and the fix in this patch is also obviously correct.

Will queue.  Thanks.

>     doc: fix typo in git-clone --no-tags description
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2325%2Fgoibon%2Fdocs-fix-type-in-git-clone-man-page-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2325/goibon/docs-fix-type-in-git-clone-man-page-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2325
>
>  Documentation/git-clone.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
> index dd3b44817a..0a68872576 100644
> --- a/Documentation/git-clone.adoc
> +++ b/Documentation/git-clone.adoc
> @@ -301,7 +301,7 @@ corresponding `--mirror` and `--no-tags` options instead.
>  `--tags`::
>  `--no-tags`::
>  	Control whether or not tags will be cloned. When `--no-tags` is
> -	given, the option will be become permanent by setting the
> +	given, the option will become permanent by setting the
>  	`remote.<remote>.tagOpt=--no-tags` configuration. This ensures that
>  	future `git pull` and `git fetch` won't follow any tags. Subsequent
>  	explicit tag fetches will still work (see linkgit:git-fetch[1]).
>
> base-commit: f7de81456940dd6f3274e461149bba12965de609
