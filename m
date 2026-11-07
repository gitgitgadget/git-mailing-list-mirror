Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794029128;
	b=iPWdLLH2d42STbWtMMW5TDD2XoxxpU1kwgoqe+M/hyWWN2b9SsZapGXpAmVbrKiOMAtQ
	 /0NQqbopauCLwgGfcc2t0vthTle/ksda3DfyzRSXwyGDyqq5IkT5nkPUX2m5chqWpq7j7
	 Vq8Kow5K0Xu6gPCFN+NDmM4xKudoaj920aCSlGkfoM2weVZ7F/aN6qeNptOuKFxdfoCfj
	 bVG3PiiiuLCLiJ6QGSayS4aP/7WFbbd5dhqaYbTD8rKNgbUfWAgxMconnHnFVJ/a8/rND
	 WaZFF9hkcJ48Fx22RLfz1EFmYsXnvYq/4NW76WR+HlUBIR+q+qTYDNvnFNvDhTLnQXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794029128;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=vAKzHzDZ0DztWFF0iXXj3DqewoZ5eJEcSCBfwcdrc24=;
	b=MuClpoDIM/2CSnk7raFrxNWVIESC1zkwHDp0Mjw5nfFPWIeSflGe+e9jVQjGjJRzRfce
	 xzAMzu02bwsM0ZE7PAsf02OV6yG7YdoeMYM6tw8X/ngNvkEMs7mzIdw2Uey3DkXjz4u/s
	 ngc6WIDtq3Q8Wi7HtqwFjDFByzqh5g6kzDKMvG1aOJ8kR7M0VbZ0Mh22m2BlQIQZq9y61
	 +prM15xMGy3s5sdORRIbVTmWlBuVIoOQ5uoaH15feAKwltGdDJeQ/zzYQLfAfR9YTKoe5
	 AfHXXHYcT1Tj6zcwvBIPEyh8PAxedxy2ByHCr/UWLT98ATUXgbJNOJEabm4a+dvFMJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=G3bCO9Vl;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YeDuB1O+;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8141F606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 05:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8141F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=G3bCO9Vl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YeDuB1O+
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A6235EC016D
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 00:25:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 07 Nov 2026 00:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794029126; x=1794115526; bh=vAKzHzDZ0D
	ztWFF0iXXj3DqewoZ5eJEcSCBfwcdrc24=; b=G3bCO9VlHNK8NepVF0zgnEXzny
	zvHHFBSH7O8mwz8/TQ/o+W/qrYNpZBHK8fa4UIWcrdgjQKNiKXueI3P/Z/9f2z7F
	knDjFa8v834sBQW4rvAKnpst3r0OcXDhLn3/kGkf5ZRWWvtUDC4kdBbL5y7S8XbX
	90RK6tno0v+aLm1PpzGTwuFnqaPETZ01s60vqGWFk1YvEPrHLOcMG4pGGedq8kyI
	ctzUhjrleDiW/VHV8f+ufSUZC0K4rBowD1Wbjj25MTdwcp/x2m2/mZJfA7rHzXKI
	AZn1mKYWcYnJlmBnynQRFzfVQ7MZKNV40JRSkqxNWmzPY9FzoXUKhSwjsFEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794029126; x=1794115526; bh=vAKzHzDZ0DztWFF0iXXj3DqewoZ5eJEcSCB
	fwcdrc24=; b=YeDuB1O+iD85zRyx9xd83YjcXpy2/KUCnOSKfaU7OKmPVqSsS9x
	CGy+3/BgdiKdxWfb9fjvYe8aEcpuOsU0Xu7PX6kTaTEjNMaSseLUFVmTQTMTFXqD
	/ESs72EGY92GS5XwdTvtSxyqoKebIvlT87yJn/Nl10Olo8VqNhyEAWj9ZZ+ZYBo/
	RsmRihvFrZeF97nYHrAPlU4FfMvQ4E0JT8584bjIBcEIfJlNkUTvsHK7hJGCs9OK
	XlafXsby4e+bcI10lKERYD7T7iYoD7M7NaYFMuuj3/JXm2kOFatzHvA5Js46AhSN
	BshZL1L/Q5yejJyhaaHvGmVHFFbzxF6UgCQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794029126; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:A9I2mpsEaP9KhJ7hMFI8W1vvIXOw40QwG2BrJbLT7zXzaN5
	9r5H25Nd78w6YZinMrP3ZpRmfFkhYa6lA/UPa68VSjYa3t51666yP4GdJ7s+tVFg
	pQxh+D3crg9kxKVvoYW9b/cW7ERCv/XVuGB90TTxsva9CmvtdaiST8m0aCrlysdo
	GMzKifYVa3tnla3LnQkzPEdv9XpTGC1qCQ01d8nMxw2sPoUlqQ/vZpvXeoJ5gW8X
	6E/zzh4AGz6vOV2ca+/JiDQgppjXQau2p4d4u2emXE/XsLHY55Ks8s/jA1m8LRfy
	KRZ6EVHM/AHn3Wjs/+eSy8YedIDxa3DHJS5Fnbw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Sap8ToS/nCo5sR71d2mYI8CLjx/MsQzjuSbOYHqFXfo=:zRYlRpTg5IE7+1shoAJ5bazwg0CVECz+IbLWNIsfg6s=;
X-ME-Sender: <xms:RrbuagqTsfcIh6tniJyaRd1fgwbW8nSeTFT8FtY_p32KCsUrTGIWzA>
    <xme:RrbuatpXHZ15rl-OC7pS8uKfxmNoouU009KtctAMGRyhylylUx_l2bWsUt4GmnjJS
    QvzjlMCadb23oeQy956TtSdskih1Wi3clQRaabavB7Qqmvk6VbkceM>
X-ME-Received: <xmr:RrbuaqNRTrlmQqBTT0CXaP-Pnby3PqANgb3eKQaQqxbYf6uCdedA03SXvMSmTy6FJ0lAZueGwow4p9bJw0xG29wfQgGl6pib37Gn>
X-ME-Proxy-Cause: dmFkZTEPvzCFkqz0LJdJVzkrXCaPb9wkmB0qx41qx2Ibqh24F2WmD2Xev0vldzpur9pJja
    9rrOo3WtJOOO6McTZnd8ou1eQ4UtmJNbgUCJkK98z+4Ul/2v2pfnk7FBzMpnBFutgk9eYe
    bwPJYxVRETZbTlckht2t1LBLHc0peM168JlvKF2IMFfaFnrGuB2hC1P2u+KdPIcqgcfvZ4
    RAk5wv5sGt/3iZJiF2JJZ9cfwzG6oQFSYnnMEpswyz71sSxlmly8OLyjuE3TcfZruDzbD5
    V7TNobglIcnvHKV/1mWfAWCvWWQBJwlHgabH/w++dp6RMpEp7/8isOXRn720kcS2w3OJix
    R+xyyb7J/fAT6IArAs0VHFvrsB7ADZiul0/3oqvW4jf/F3JjA0BKxORfCToU7MJMpVDFBe
    F0WWtj0VM8GeGN2OppbzhFbOmsYY1Z5BSpA+WgqT0Vxubh9pzgKHzViyiApldu1FGTTVrp
    GeM5vuENY0hoazcYZd+LbdLrElBG99VFBXyVaYiLPUw+e3Xsg1ZAjgEEJtihSrLleygo5Y
    ZOr1g1M/no1w3bSPmvMgBKAmPsF1ImAbmL0ilXZ5S+mlm2kLfCnRLllAUIIPGSXVnA+9/F
    TDCsXrGdgVUfg9SUX+tJs4va80wtIn2foKiJO98W0jq2iFMUjCdF4N/dWzbg
X-ME-Proxy: <xmx:RrbuamxCFblz44f_zf_eWQY8vtru1q333EzcUGihEsvvNFNDOiY_jA>
    <xmx:RrbuaruFi3hCka5oycbNCU5TaWyaP6ycubYTaCQnYrT-T0SNSSVxPA>
    <xmx:Rrbuan5AiG49xMVOZgWOSnF3Q4WbQAvoOjbw9vjdbDwp5s_wzQxOLw>
    <xmx:RrbuaiS9B7rarO21WP0Nva1Gx9gtn1txsR2Wg5FoyfFpll0vmIV3wA>
    <xmx:RrbuajYvu0OYnphGGJ6bYiqKAF-M88yN3HgOGa_6MPqluVCX6Oln52aj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 00:25:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: Hannes =?utf-8?Q?Brandst=C3=A4tter-M=C3=BCller?=
 <hannes.mueller@gmail.com>,  git@vger.kernel.org
Subject: Re: [BUG] git apply: pure rename followed by edit fails with
 core.fileMode=false
In-Reply-To: <20261107040715.436-1-aniketgupta3001@gmail.com> (Aniket Gupta's
	message of "Sat, 7 Nov 2026 04:07:15 +0000")
References: <xmqqwlqpg0js.fsf@gitster.g>
	<20261107040715.436-1-aniketgupta3001@gmail.com>
Date: Fri, 06 Nov 2026 21:25:25 -0800
Message-ID: <xmqqfqxd9pru.fsf@gitster.g>
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

Aniket Gupta <aniketgupta3001@gmail.com> writes:

> The series in Hannes's report is valid input which is what format-patch
> makes for a commit that renames a file followed by one which edits it.

Do you mean these are two commits, and format-patch created two
messages?

If so, applying these two patches in one invocation of "git apply"
is exactly what I was questioning.  I would understand two separate
invocations of "git apply", or "git am" fed two input files, though.
