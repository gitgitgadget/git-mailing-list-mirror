Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466046;
	b=5DaMPVeeFMenicNP3hkFbaZgouu6MwwFkt7aNLpd7idzjiQlPjIu+2JWPLifHRQBwrbr
	 xxvvPdQ0sc/LXJnCm6+31FfjrqO9VVp2IrwKSnIlaC9T1xr28eeQJ/+JW1ZfCc9UdrIo1
	 Pq2Un2AJf2CCqNLWHpimNcURlDS9K6MLC6fkQTMvEMqSliAh2CwEcE06aS6N/fbwCEOJ3
	 eCDWrkUJUjaXeHN6i8TNe4NT/0DRbP1wcI8Cp8Ub6k4SnSxor1peobecSXZpMraNQfKy0
	 ULv+Oc+ktlDLBct1BTDNj9capxdoqhdQ7ELmFXRGbRh6i+uiXYg/Bbw8iJAp9pCLqlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466046;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3qmnQZhfzAI3dhfR003S0jLIa36vM1izr66IkgaWNi4=;
	b=od7cqkDBBHOSwDMs4XL0Vaw6hoWDkfssLsWsUN767QRugLG2sCWPQiZ4rr/Opqki8Dru
	 Film6Ya4zpHfjHnAIJwuNXVZ5wMlxy8vLW8niGFyQRGxcH6eACunLirS2Wnsr+JbPadhn
	 IRckz8HF/bweniHNeYIR/M5mvwtEnVC3hh7JszGS7a/cas8vymZ4iJfqkpKQN5rBc2lNn
	 OxnNSAF/XDQv/RRpbGn4QfRPkPXyTaVQHFfLnXJufxGiJOQmRkiMEjKWovpMxQ8Cz8zwo
	 9fqcC7fcIWPXmG7EEVuotAjr0UgiImUHYCvOURoE4nlJ5UyTGNQ4sHbTjGsFo3pesRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ny95x7Yv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OBfxJjfd;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9978B606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 20:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9978B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ny95x7Yv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OBfxJjfd
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id DC8901D00671
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 15:34:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 23 Nov 2026 15:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795466044;
	 x=1795552444; bh=3qmnQZhfzAI3dhfR003S0jLIa36vM1izr66IkgaWNi4=; b=
	ny95x7Yv1n7WsB21aeon27FZp0f4C7MtYasZTa6hElJboQQQ09gAVXFAEmCkMdSE
	RNQNlnqXpRdxAlBugWrkPmmQdlIKPX5RqxnuDJTKFqV8650MLBbDUFIe9cqZ3fqp
	DD+xm7/qOsEMxeEnSOEY6dGqHUXW6DUt+LH877Mo8lx/N23idK8melCvMJ2nvpST
	Fa7cZxq+ZoOmEQ9sWNPgD7v2bVkG+VaDyI9NeQJXzDTKx/OVVuX1TqO5Y8qGwotk
	0eBNS++jiojZCJ8If+Gdhv+E6FAKthila/U7+nQhaEtZ4ngwlK9xk8A3uFfeludx
	ujtbhXaiuCwrCLc2yVO0Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795466044; x=
	1795552444; bh=3qmnQZhfzAI3dhfR003S0jLIa36vM1izr66IkgaWNi4=; b=O
	BfxJjfdWnlsojYz25DzQE6tbOtsJqS9YddWmGr0nJ1BZ7pvw/ooz9z+ynDPG0sE3
	76n671QKfBLoCtcPoryjlmliSrfsQLf87OMW8nu6E0wZPFKVYaFB+Xij72q9oVmc
	IIiejJnskq0iI4ub01fbpvoGY0uI68yDf4/zu+Nh9E5I08aCRzBNECgy2+4/FC/q
	QNNWTOCqcTQwC2WhTDI11oBru4fxpf+Bm/7NvEq5TFnN7S0sf61pg+QYv/TvSUGW
	QyvRAS0C/uUGay9SFHdn5kSJTfKNf9xIAMi9sBQ/hpIRSKOUheQyFzC9UJlS9qiw
	ambOACwGiz2tIpU+sRe6g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795466044; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:m4HnyqFd+/EGoB/SKwrLLfPnFlslHvbVFpj2Gm74vkudoi2
	DGD4Cb1J2gvicm+K8RuzWNe96/26IO1bBYHJ1NWwrFsVvKbUjTN91rIuFz5tRsnr
	PF3zCcFKQmc3c0DhaEqjuQI1Q9SCYrO4UH4rmg4H/cyfCf9/u1ZpDh6LA6GNmbgb
	eOn3jUbiJ6reJVZcTp5OiBRM6Qyu9+oHWAbaBa1WQn6KZ/MOaM4WHAIOmNkVYtzR
	puzrylINniyyKtLLZM/YDLMT/QpVV+GyL9nVeMCP+UpTfhAOTPt3N82oP+mMSCEP
	KCqGXkrxNNnEPPRkmkJZ/KMnI6LWWBX/lHYi8Dw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:DZbZI4oRoq7cVW7neVdq2UpxhzvQsNb97Ho5ggO3OV4=:2atIH6w/IqZFII6TGsO04+Nuu/4BA/MlAxBxKmOvuvs=;
X-ME-Sender: <xms:PKMEa53PpnpVub2FP_2lh0ZNbjXJOAzZ6D5SB9ySyyWlfpD__jHd4w>
    <xme:PKMEa3hrG1RdZn1IaZE6kfYF5DLvCZQ2EW6gtR5rKUKQIERluIc_RNndFjMtPFubb
    W81prWc3k7XW2lkxSsvy-G9dmU84NDvYqCrOv498DD2jzBHZDWoFyw>
X-ME-Received: <xmr:PKMEa3SaWMnqzQl0mmmc62Sp89caON_agwu_z1LAMauAXqUeJQeCrfvIC9-3NlHX3kxDo1hnC2wdYgGG0IzD2wA5XgWtWxfowaiUKZ8>
X-ME-Proxy-Cause: dmFkZTEAxJBYjuIHI/WflVLxIEZtcZ1TkP2QysFF2b++L2o6pGXeuOQ8KcrpagE4R2+W8Z
    9ciujUjKPCYyE4vir+nyvdmktfnRredE7DzgaVOn64wwuf1/Saha3eWibtH3NOOkwuYKRg
    u+CwHxTpfB1A2FbfUSwgCQexBpx8F/7VFs+pNYheLNfTkLrBS0BOzNkU0IN9jdtdjvbPyU
    DSHJUxWu4HBBPy0p31L3naRsxBmHRWq+53+OjyrMewPIJDOmOiaJf+Ar3z0T2p2iDWfu7F
    nFfDP4XzkxAlBCdAUAPnXQyXjE56vLeEc+DvIDJ9MiaZX+HC9ZcUxQniKRaWiQTSQNUMfd
    6pKyP4pAmGbV7zfTrVEaetdGy93C13b/Pshpm+XZJKmfYAoIkxd8qjUJvD7KCKIdEGfrz7
    zLtQ3ZNQCmGSIOCrJWKYELcgyUKFtvW9frKWsL5sLSpzOQkIEJO80gYcOYTpgAL1nVlJbi
    bta67y+VYgNtuVg9DFGCPYLCLmPrmr43BWxBsDHZTBuJIIftFdOIn0UnhyChRmVt9998dq
    OhU6gX5/VRk7jhJcXlDHDaYy2mm1tj8Q0p5VpDHgkepoNTMT1CVc3NRGLswyUriN6jn211
    rIuAWhG2WOIpL04R9ir25RSq+gSyJggKR8hU0CDrKirYLM4wT8lFguLkdoPw
X-ME-Proxy: <xmx:PKMEawh_ODkSU-aEFl6FoZz5TZFX6aIhhQj5JuDK0cni4tnyhfr2MA>
    <xmx:PKMEa_7B8JQfRnrniRVHpeYL1RTY1XShIP3KgWaSyCFLr2cKTKIllA>
    <xmx:PKMEa1BOht3mRS-JSwrpl0ONaLmqbtGUbkoTwzBjGsebl1wuJmn0dA>
    <xmx:PKMEa-ZBHvxpbEc95YMI_97oD_h6ld1LMKwK2eWLKFHAS4eY4ItUog>
    <xmx:PKMEa7gb_YsdT-ib9JmD9h3Ku7mBldhxc5jGozGLkzconGOTPy8ChO9j>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 15:34:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Omri Sarig <omri.sarig13@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: update-index: Format options correctly
In-Reply-To: <6954cd53-43c8-48ca-82da-35c673dee260@gmail.com> (Omri Sarig's
	message of "Mon, 23 Nov 2026 16:32:20 +0100")
References: <20261122152538.107580-1-omri.sarig13@gmail.com>
	<xmqqfqwsk4a6.fsf@gitster.g>
	<6954cd53-43c8-48ca-82da-35c673dee260@gmail.com>
Date: Mon, 23 Nov 2026 12:34:03 -0800
Message-ID: <xmqq5wxn5ltw.fsf@gitster.g>
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

Omri Sarig <omri.sarig13@gmail.com> writes:

>> you would notice that while we typeset `--refresh` in monospace now
>> (which is a good thing to do), we should also update the enumeration
>> header "-q::" to "`-q`::", and also "'git update-index'" in single
>> quotes to use the same `backquote`.
>>
>> Also the way these changes are described in Jean-Noël's log messages
>> is quite good.  You would want to imitate these messages.
> Thank you for the reference. If you still want me to update the
> current patchset, I'll update the format as was done there.

Yeah, that is very much appreciated.  The update-index command is one of
the oldest part of the system (it was present in Linus's very initial
version given to the public, committed on Apr 7th 2005, under a slightly
different "update-cache" name), and documentation update may be long
overdue.

