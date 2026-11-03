Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735186;
	b=hrSe4M/vNHNJl3XEHX0tOlusNkg0yPAqV+FaBzeLCk3mOHrXTVQ8JEs8QHiPwHoVwuQc
	 fPqyWZsHLC4N0V5ILEdDpsiVJrXXDQsDY9/Ts1q80nhNzcZY1BvZ3g7jBPjrHnlLEabOb
	 ntmNXtImOEi+jVDrMqazH2iDbMZwJfJ1UUBWfrPu/RRwwJd0sDz4SOUyQovbKJCVYb42L
	 H55ADhjMjSxgfuxjE9TaMK8thB3IIBS0jz8+r23XtChsOOpSODzqlqjixuVMNcVrunHoZ
	 jGWcjpVt79PjaTprqvsdO2I1taGZ++0C9JZMWw4aNZY2gglwhhF3IPzPiiRPe4D+6mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735186;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=bLZ2bIsd3XMZtTLmJXiP67H7Ni8vtLXe9SOlNO4ljVo=;
	b=IKRBdhv00x/GV/26YqnVTWUKohg+y58PorYTtaqAEy35jVvSPDbvJMh2yD/pfdU+agcI
	 lYeuy5dK/FiCks0VA3dNK9LxoeHnW+mGrFsTFLmTtTi3xDL9DIZazomVc5rMsSyPWfpGR
	 ncWfFNovYsRDu8o403dnrWtpa97vBJTiqyrHeH7Jad40ycVyna37hOGlnZoISg3dLrJej
	 jYeJ7rmnjUrvv14F3/dD/E+GXe0pAHWQ1Y280kktgigp02FBwbKvgNBEIMydkrMv81mAw
	 yqRy4wfWNUauNhHy9+3vOLZhAiYrT6tatHyJGfBO/HC6WInrjKqdvoLdRoAYNrc/XTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Um318CaW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ReGOP48X;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87554606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 19:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87554606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Um318CaW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ReGOP48X
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CB7F2EC071C
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 14:46:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 03 Nov 2026 14:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793735185; x=1793821585; bh=bLZ2bIsd3X
	MZtTLmJXiP67H7Ni8vtLXe9SOlNO4ljVo=; b=Um318CaWLvfIbH/73Meip+yPQK
	qUCFg2bg4EGEw89og07Dd2zIW5Hlcei8OdEhjWvwpf4Y3QmGktwb4KQKH+f8/7Pt
	3qvl4xuPUTbAnsyJFK5eFFK07N4DQcQuLNpllglv2VORhi1eLuVzc/t0XWwo0TDy
	pormQ5mqcyisO9i6YLYngE+hG+7hClzvVFQUsz0eq+noW3mbMptBKpHq9dWn/8+h
	O3BoVqVwrpVFWuvsriRtubzl2wpPYDk0sTHS2rlVM+yelBkQCiCVSnWB8q930nCd
	5erhJcN0w/LymQq1i0XUnULdCA8um5UanPUR62o0x/Pxu5ggK5LbyyyUwSqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793735185; x=1793821585; bh=bLZ2bIsd3XMZtTLmJXiP67H7Ni8vtLXe9SO
	lNO4ljVo=; b=ReGOP48XLQrChENbKp1MuQBfi6lrMhmBWbNEqJbViNaW7ZqSFbY
	otBONdToTltWdRwEru+WfNfef+mK/Z/8ejoy0qBSSHA64fC1onVl+1rBAL+Lniwe
	NdDfciGG9R/MyM0hA+mY+JnCSk5kgdN3kx+ozi7Dt8hs4AFUFtp09ht0uXL/Dj3M
	HyAV3qs1hqaFSenILtQTWt4jt5wbObfV56d5/8UWZTDvg6oZCG3QiQs/Y35F1Ef1
	KMUlyNLj1G+acPTBd4a6T8LlwtRZhQ1nRHQ6r7X540w1kerrUBxecMu0SIdmVRCV
	RS9ordnEdQnMjVJua22fJJ4aD5TKzXAWyDA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793735185; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lSQwOdRvCa6MqLxJypzC7XrpjqD2JCqDz6+es+Bv4lZvIBJ
	6vbre70IhvS4xO+WaJls8QCT3U+aCNDfAvF5roK5DfWY8neZCXI7CHsIN4EpnEmf
	8SmZaa1Dl09IRcgBuqxq4bwoCZGEwoKS2ajPYKsXRYdMSp6Nik0RH0dZ8vY9OVtA
	tnHKyO5LExbZyao3eslH38fJk7BNnbsGxf3b3V2hJ/1LUK1opnVeD92m3wbaTFOW
	KYwpzxrtP7gXJMpt5E/9aC6rO/+X6IhpwzQsUPlvf2Sc1+AFmO112WmiKxe60lRs
	nB4PogaaU1ZWRaJTO5n6ZX1mdTzyWd/8RWIbCDw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:EPepTORcYuK4De/WB6nLp4aR3FGzXDoky7ynhgma2mc=:Xvd7GbfYOIksQY6Qkhr5pdaO1gzSwxccGev57Nbh3O4=;
X-ME-Sender: <xms:ETrqavgXDXMOU-UB6HGQukZCx1qusTqmM-bBgPyLNMX8DpT1Ypnfyg>
    <xme:ETrqajf8jZp2wmO8jKftj92THEjm4r0RvOf6A95e4WkgGzDbJXygCWXpB8VBGY31Q
    9QVrCM5WDwnld2vtl32AD9hw5HdxhqZwAFduFknKet6rpE_Pu29aXA>
X-ME-Received: <xmr:ETrqasfVP8jNQWwuQlZHPRaIfmaMR4EXZ-MiWbEJkJNIRuYQ38cvSQs6F84LIlFHg6OBau7hJ909L_wGYQvaiduVKItPfI-FIcW5>
X-ME-Proxy-Cause: dmFkZTGbPW3LNEGoKNiALgO0RYEiWVFQLgDVp72M7L9BMxENXzGXxPkrEBT95HxeBHFyhV
    Rz88Dkvw7tH2ecl9EMCgPvPS4uwtWCZ4e0XRYyDGuNAkMCRtH2ED4ACB1gDFODJIwDQNst
    fUdxhu5N4+44h2JOpFei93Xq6mj+y1CgHQ02ejRZ7fFvtjKD3XlZlS5MyMQ0RIoodtpkOO
    nFVPpSEBqByHNWih2jLqdkZ350MPO6bP9d+1Ltvk4hDMJIgpUxMM77Ky3nX3iMjCnTgT/y
    JmglMQWCwKHJD7dwrWtBP2IrtRLym3oWdpGa40YDFnYL0Jq+lyWiYnIsK+lNWA4oWQA3Z1
    qMP0zJSubSaQ2Y8/dr23tT9VghYqdki9m5wZs5AbnOgCt2/BJlgQe2dOoFgb4PHGhloWil
    MpdJ6TQqulkdcF93O1tTBymqgK2IT9sfKP1NaWvC166IPgz/pYVWWRQk6KcskOcmyP4QFP
    8nXjpU0C6b5eDKsrr/rvL1fcZ0rG7DK/UhhpwEzhLlGntzuq+MsLRQQPOUHS/SBHbjFZK/
    AlPP5zPp5PHlu8pJBL28Lah8l3KVUQts8Z870vaPQOWNFH2Td6rOoa82jCANBGRBrfBn2c
    aK4zblmsLVjfQ7ZFI4hvxC0X4Z5eNgXJJ4lGobX1GWtCt9Pc/beefs8IzO2g
X-ME-Proxy: <xmx:ETrqal9TfSuridp3z4YzvYAeKfrNvjK2HJQCAeFzW-bu8b6H4H1SpA>
    <xmx:ETrqaglVOcXO3SSEVMMulbz7_s6QsRDg8FdFUyApK9BQjK3OlhTsaw>
    <xmx:ETrqav_LrLif_tr1nKPu9DwJ9ySQPdpkO2IV5lwunU2MEdo-dOb5mQ>
    <xmx:ETrqamn_wH_CVdL-Fpatg_vsRyFUfF_-Bu0IGJ52tuuSnFtmAPsXZQ>
    <xmx:ETrqajdx5T5fqKNfTfmJ_hZhWX5_OUFA6CFCUSHkHtEB5OiFYj-sUeJa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 14:46:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Welsch <johannes.welsch@googlemail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] git branch: add -s/--switch to create and switch to a new
 branch
In-Reply-To: <CA++gwosYFaOLD5nZjKUUFtp1ryezikqAsD6vu=uqBzOwyszASw@mail.gmail.com>
	(Johannes Welsch's message of "Tue, 3 Nov 2026 16:34:09 +0100")
References: <CA++gwosYFaOLD5nZjKUUFtp1ryezikqAsD6vu=uqBzOwyszASw@mail.gmail.com>
Date: Tue, 03 Nov 2026 11:46:23 -0800
Message-ID: <xmqq7bit7l68.fsf@gitster.g>
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

Johannes Welsch <johannes.welsch@googlemail.com> writes:

> I'd like to propose adding a -s (--switch) option to `git branch`.
>
> It makes sense semantically to create a branch and to also switch to it.

Why is "git checkout -b <new-branch-name> [<where-the-branch-begins]" 
not sufficient?
