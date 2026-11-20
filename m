Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212141;
	b=ylKGO4q/Xz68FuHSGbyfOKzN5/NeAfIzwgP1ctzbQ61PAD6jvxJYZoQjEiS6sQOBUflh
	 Ts2Ce5SHLqf1zpCYF9Rv66J/Og2lw681iLRPHHWuKL4QPUKocMvsUXkKTi4aWY/MOQAac
	 Ejl/vi/b1okMViz1MTW9EkGwc2EjaRZq1nIrmlYjKE4T2P5HUEHKddwZUDhASqaZUJCbG
	 X2a8i6lOFT/ZdMvSp6plqtzPxghLKUp66+qnpeFInYXXuTQVAfxivvt/l/CisQzkIN2Mj
	 OgX5RBFhfLNLbLekWVfWH+mM7ay3+iXWdyvXtuxXf+oSYWW7XR5SlW+BGxJ2L8clpgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212141;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=S7DrcGtc0NMKC42nPOh3me0LRqiMexxCCDbOkD4KZzo=;
	b=rsJ2CkJtmJj3nphLs/RbjDkJTJ7IJtUV3LAnePkMlS9hy15dsArfpkr9VzVZB8egUqG+
	 4Wm4eXtlo9jqnQnYGYMUUiM8JneRWDEYDreypd9Rgx7z0cZpp9Xt82RI6qX8yzeEbqeM0
	 ax+TPqFfRDvc2WeTi0LJ0tXfI+1TWD8o3XYVmWcIJBMIWp+gjZ8jav4gd2DgeIhnxDZC5
	 N61AleqM1yLM7Q9S4B2sY/tm/9nqfNxIpG1LexZs9JqpRMxncg7KzIIt2nC3A0hmWXRi+
	 JjvLWuiwX2W+9SCc/9ZGp8iNF00hrzDbWkfr13iGNzZUV3BUhPe4vTdGI8AaqeTo6cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VPwp8q06;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GngQLmyO;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B0606A696
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 22:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 738B0606A696
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VPwp8q06;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GngQLmyO
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 93F0D1400190
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 17:02:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 20 Nov 2026 17:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795212138; x=1795298538; bh=S7DrcGtc0N
	MKC42nPOh3me0LRqiMexxCCDbOkD4KZzo=; b=VPwp8q06URMz1AURCvYGkIupLW
	lVaQDc3llCFIlzDbobGNRRm7Myb4vm+SdXOD0z5XDMTqsXEjnqS+8/zZ/JzW0Bn4
	yDK0bALdNya4Gv5a25xQ4/M8qKT7gDSDPfzAEHtnJV/5vwobQsCHfRu3Ai8jIsRA
	NLkTA3Ciccq6dX+ai6r3RPy6EtO0Ne+UPDU7qPv4s3dX4eecU1q7DcLy0Fj3U99/
	Nt6UirvRT7F7I3DtbAJrpEEbULrpV4L4cEfV0zIfCPIY3gGi+RFT4HNq4uvaVL73
	DylREBnL6lbiOppqHUye2NmbbvVncQ9IJNzAniav1+uhchULbwIgzxFTX+ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795212138; x=1795298538; bh=S7DrcGtc0NMKC42nPOh3me0LRqiMexxCCDb
	OkD4KZzo=; b=GngQLmyOq4O7ggO6BmII0YRshOb1wXYzsJwUt2UbZCoqGc5Ebow
	NsUJI9KHfxusRddu9wNn1nM+ronFFO/ob9IlQXVPFJUKtI2U5MHFrtHlCe3HhU48
	gL09KlFFyVv+kPU1zkUjIzbvHuzPytU1wOB0uDU5l0Dm5/G2JDgh5858x0SWLdqn
	ohMAHg3CiNzfjLnx2c1lzNwLwwR9Qh8YvS7FleckG7B1TK7rNh4CVkHLLTky7SEg
	ToAkDFrV4et0HbA1mMVsHUtKhVVuAl8iP/mKAp1KlJ1tA0YyWJyzJQ8vEu3+Hopb
	whrxU2lyPJfzQcpHPjTV/9XaKdZMcRVS19w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795212138; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:gde3MG3JRtzOwqA9CIXJvgAlQDmW91uh6YwYvwGibHXD11+
	k88wxug8XN0DXRvdYDlKgPAfMJKcXYkAyKGYPYSlSYgYhzGqm4p+3SbxvnFj0dPi
	GyPw2Zw/soxmp9AwQP27on++6ieK/rsAXTQN5sS+hKaOGm8E9Kke08ljQ1P3/GEv
	EWjWA0ZHwgFC0PV+gaX7wIN6s0trCrXFkLgLcGI64uZxI/QwjYzNOiGrNs98LIPI
	MTqefRjUcoyRFoLkW3By5gnOfe43oh0ee3A6KCzKJrdnugtriRNQ7AWsaPOyvEki
	Ji3xRqro03eZLVIj/e4PifmayTkHCuuqwQR6CBA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:JtBZEWXtXjWnNETXMaX6+P6AqpPeTkPdXj0DZydOeuA=:ybxsU2/tRfW7MLlvprG2SC8iKJS0uRbTFCU5JcnkU2U=;
X-ME-Sender: <xms:asMAa8g4PqWCct6-mXdA1sEFU4ybsLsLJDCmwkT9TXYI44UOuYbZLg>
    <xme:asMAa8fUs7wT8cHv5i869uZkNH-gztT9alyV3nA999u39e7gFbMtsYgmDzJlhjWJX
    aILGFru_5vw27_haSiQGnf0dumeBYJjL7u71niIKhJftfgQVqLFMMo>
X-ME-Received: <xmr:asMAaxdrrtfRW3-TTx4svkLyEtaPu_QnCJk_i1Pd6p8qoYKtqlVVLnsSNcecaVEOrYHKyIFlOmEpmkBtFPh-vvipcS88yDKc-xYR>
X-ME-Proxy-Cause: dmFkZTFCBIqEtoBDktFt5WZfDIWeeje5HiWBnV+t7pvM/NYenzgc38Vp+QYbB1jq1lcRpe
    DLSuuDq9hjr0zHF+0U/ZF3kiZ5pMiWcV3G+xCadAlSf/u7MtQrCZfPzN9NWuiyr+ONqFaa
    7dG7PtCM+coJk9wM7F+5ssxAZpbQaiYU8odHdA54ZijmksKz9MmJdp8JC8UKRNXiyEMDu3
    Xi/VMagTBSiN9xsmYiNo/ZkKaDMAlv86YNzKs1MzToDa85Wr0tPncWfZcnpxmKyKqny6MB
    aSZmqR0X11odfUGcFCQR6tYKb6qDnATNOIZquEqbzhP0UgYTRfeiERrhQH6DT9qWKnlStR
    p0MBpfsE3XH2B4vNMAmBvJTURz8zO7pUg72VGz78ltPZbmf1q3MD1vDnT1kWSoBYgD8Ofc
    dV/m5i5RLttHwrBes/w5MS9SerJLWFXzeU1W/zALg3kuUAMhqGlMFZ6EQW/OMS0ipA1vzT
    VG3Dxykx8wML6/8g5ukPalNFi9hNCSAWBYzWmU/zwiE3mFU8oCEnC2Zy+7i53wW/99ZD1i
    tw1O9bJ6PnM4OsoyUaZmIl/Xedvj7T1BoPR9Bc43aWVTX/Lo12QgIPD713YnKTdmYrvbdK
    +g89eA4Bi3jZyq9i5WKmhICSmyu2NRnKoIOAkDFtZBT4HOME0puGYQI4mp4g
X-ME-Proxy: <xmx:asMAa2_GeB2uF4J3PLMa3dlv0X6vCbbyAQ33P4SBsDW3DMTFF5IUzw>
    <xmx:asMAa9myaamhCF2xyMMINsIYFCDlsnv3qNZ3Qgk3157MsNpKYU7GxA>
    <xmx:asMAa4-dTTEHYN3kwTe-NrU17AoUL_q7_Bq3QWLSmDxFArgFqCxIYw>
    <xmx:asMAa7mZQWlxPGP4KHFqaPoIiG5OpKGl9XjBGN57QSQ_drvRGQXwYw>
    <xmx:asMAayPMRR695eVHdLD7D7FX06fmRP8LXIGDx7WswJmqrinV9Qk3j_Yv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 17:02:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: git@vger.kernel.org
Subject: Re: Prevent git reset --hard from losing data
In-Reply-To: <20261120145444.13061eb7@gandalf.local.home> (Steven Rostedt's
	message of "Fri, 20 Nov 2026 14:54:44 -0500")
References: <20261120145444.13061eb7@gandalf.local.home>
Date: Fri, 20 Nov 2026 14:02:16 -0800
Message-ID: <xmqqqzgfnouv.fsf@gitster.g>
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

Steven Rostedt <rostedt@goodmis.org> writes:

> Too many times I do a "git reset --hard" in the wrong directory and end up
> losing uncommitted changes. Is there a way to add a configuration to have
> that command check if there's any uncommitted changes and ask if you really
> want to do the reset?

I do not think so.  Castrating an existing command without harming
others is a hard thing to do once the tool gains more than a few
hundred of users, and we probably have more users than that.

I think you need to go to the root of the issue.  Find out what made
you want to run "git reset --hard" and see if there are less drastic
solution to the same issue.  And come up with a way to package that
less drastic solution in a form that would be useful to many people.

That way, people would start using that newer solution and less
often be running "git reset --hard", reducing the risk.  When
somebody really needs to do "git reset --hard" or a script that has
happily been running "git reset --hard", it will continue to do the
destructive thing as it was designed to, and everybody will be
happy.


