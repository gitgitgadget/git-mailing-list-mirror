Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521016;
	b=WgxrY0dl0Mpv9a8s2EGYC57P9cADs8Qt4/HtDfzKn0lWKhBf36sYIgUahfs3oWb9PGdB
	 Oqx9FfpcDSOlJg2DNkw9ZzZzwg4BXu8vYVZc69JJipuAsKLNvtIbKbfsV8JMOVB4pr0fV
	 lOcMtUt2D5e218cjqgjhN0mAiiEwBwWfevGEZCvMR0e4GCLhApodY0w62uRty3O+VOPBo
	 6rbH9VZxRZ2R7Iu9JCZ0zQNd42SWc30KLWkWkGEc7GikUDeTjTB4iRfZJcWeQlodS7Swq
	 X3gGgVyYMFLwmSKu4xvi//ZDwx/X5Rbn14vPq9IRhdPfh3qFMW00ecOtiefH+TF/Q8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521016;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bP/DlEd+fDSvWKcBEGSgH5RLLuUEChgMeEQXpsyg3Fo=;
	b=jZqsWSMsaOSPaRdk51xlry6vThhLG9hZscfXyiWOTGypxPMGtqL//no1jlwOlAgr9e2G
	 wI+TYZA1p563yf8se1QuvBq6Pj8mPwc+NqTc1H5pWRYKQRLPtzUu+2hPsouSSOqj2S7+l
	 hKEZ27xrHZpwupQJ4EoVA/unmWML/QY5G9lQybHBjh1qxrDoou/mF1vwC5GbHBbx4BnaH
	 VHl4/y2o1P3f/LYjZykTPjLBdWgPnEFykFdS1fFUUKrf9edHz0BJQPt2+zQw9oIHVyH5u
	 Gcf1oNRV1MW/DoNpNlk5WnDBuY/Uj586n7e+LgMsrDkbRd4N4yEaEC5H2N1HUOUodmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Z6BxTLnK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=OnFT2xUE;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E444606A322
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E444606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Z6BxTLnK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=OnFT2xUE
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D68C5EC021E
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 14:30:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 20 Oct 2026 14:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792521014;
	 x=1792607414; bh=bP/DlEd+fDSvWKcBEGSgH5RLLuUEChgMeEQXpsyg3Fo=; b=
	Z6BxTLnKrL1Ffx/fdLIWJD6fOJQzDkyzLdezzfxQf/dLVEijCbU6WqhZJ20IfQiV
	9i7x+KVZEIL4SfxIo0QmOQhHvKJrGE72AnPHyH8Zzt7fKczKsW1PSKRCcgIXvX4+
	2ncVyqL14FsYKzCeU6XQEyO4jPp+KME2SsV/d8fKWs4kp7Okl8E4V+479F5K6y/u
	u9H2JNwxKX77+wFgHxKCF1quyHCXrO9wbnEcLXt0HJ9QBub24NqZL+eT8A2+h5kK
	iyJuvf7CPhWxOWNkzULaLBFpZUFbqnP2MdPTx+vcrvOOzkruf8MKVaUhMXKQkI81
	IyjhfZHXvl6RFoZNrQVGvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792521014; x=
	1792607414; bh=bP/DlEd+fDSvWKcBEGSgH5RLLuUEChgMeEQXpsyg3Fo=; b=O
	nFT2xUEcx+dSmonGCCqcmb5dBYVUVutpRtjGHEmwlCzE1hdYCpVYDLFIvWMxxPYY
	kMqOGfiLb48H+lUY1iRf073VF8F2RHHq3gvYqtSSHidcg+YVoETmfc2e90nOveGH
	fWYnkmtDR+XWRZ7C6lc57QRYcnBv9zzFxFCprUkvc46z00J3uaGzfj2qnnNQr5fE
	LK8c26uFlO22jwFh7PoyXXV6sZvUxp0MBfrApCzSetuhS9C57RqWa59t5SVA86WR
	YGx/Y21DyYIyJJF7nLYUMtLY80Cu4vz1k3fkwRpymZHHXd5dSfxMey9XANeSmFnm
	UTThZ7IpdFpskyo7kr83A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792521014; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:URYgSeOsURgvBjr0rJSSxQq0UgFKfKvg95o55SVaMwoep2K
	oU3Y56H5ZeraQcnLuR54ctN5rTCzf560AeppNpycc/qQr1hPqaYUd0OXINThpf4U
	IRMfyZzG1TjatLnzc/q6FchHBwPOsgP1E0QdJOAVHF5wN4x2gW87OJBWTNtayxRS
	RYIRh9lc0oG8uy22zwzk1YyXc3r7yKtzRQ4JMNT3R/vE4vkh+/gPxE6/SPf1/0XY
	hOjmL5wTFDJ7/MIDOZWioBw2FABzDQTNnb4bVsgbC36S9QKrPFxv2pEUbroWCRzi
	loAnU+yoyQJbRWsJCHPAe3iDDILoB0m7rNY9WZg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:j43I6yrFFxuCsxot7zUsQKdK1H4UIzLIF2A7OTTP6u4=:BL4HYMtAQp4uYyhCgf9gQSWrZg6FqCMPhsQfeCeqotI=;
X-ME-Sender: <xms:NrPXaow4KgVCyqIx9v7j_bEv6EAOfP4_BlY2fq_VtMyW0mB3KXVoUQ>
    <xme:NrPXajScBg5YEnImuZ0gMveaDEdNuKl1sc9ZlO5I1nnIBHAnPcTxeHJTuj_fNV9uQ
    OC67aXPoHxESYQfoAchgW3eLkfJ5j4ki-lcwn8HEfryHwt05fR2Ams>
X-ME-Received: <xmr:NrPXavVHAW9Lw977veWVUBFb2wMi4WB_0mTAaEx_Ey6fvItH920AsdQJVJQytceaZxxnbt8aASNWkIL-KcRwXANpMLW_tSrJsc-n>
X-ME-Proxy-Cause: dmFkZTE48oYAMsyEU4s6eGJRWGAnZdA3URAfrKEA7SFfSuKToQjiLdpU9saolJDY/ResQT
    VdAPuYh7vB87ZrG7S4igCpv3WJfiI08PBidRW91+NEyBWABMdSMA00ICPjdBR4US+Y4qTG
    0O2mPdljpdyCyriit6WQTvO2FfCOT0EMCTgnEHSzEmbFKVSRehoL4HHzRQe9pm1rA3H9UY
    pJvGlIj+IgJQUKOFnEqwd8Pyzcfq+XNqRTqpXTU9DcOasRdBCos7960Q4snirmiaulavtI
    Zf5Ewq2EIORtS9SGALwaScfW8nP+rgIvqroK7N8bmD4KmhMg5NIyYtEKWJ7aOJgGNcF6VY
    WEClT1L6UZaul6XaGFr4EV5zU42ngp4fp4VmEsmmaBbQskjj9qDPW78hZKOAB2yHpul5v7
    7fEfC8R9QWCrpC1ov7mZv7pScyOHT3+zdxwgh0lWEZcf7Cw0tVQsBQnYvGEl49KuvS+sil
    PDwWabiyr73kOWc8YVYTHMdrCe28YUO2VB4F0Xf8VXE5vPexiwHYxbsvLx0Af1AIgYU/XR
    0SocQus2WXQBLWQcE/meCoWlzoVJbb8peSaGSpAaBvFnfznR4dvsoJayaNSQ5DwNDWpgNC
    +QIZblR16Wjkq2quFjwvTzBaHOUNCzKT2tRa7AypDMNZK/+feAXGa36wl7nw
X-ME-Proxy: <xmx:NrPXalbPLQ_YsCk-iyryS-2N9_RMV7ZkHnQ8P72_5N5FSo2sOupUPA>
    <xmx:NrPXal3BUQPn3cm7BwGIzEi7qhTdQZ8XWYc2_mdBg8t1GmGUKN30jg>
    <xmx:NrPXangw2xPjaKIwa2gjl-O03pNXIDFLQj0VMyhaqUHuqY9yaWujFg>
    <xmx:NrPXapaGaqjSHm6trdsCk-SqQIGYwSfOzjsqiGRY3zPCaoHYpZhn3A>
    <xmx:NrPXaqBEA8Yg4FxxBXRvJaxU3ok-EZ-lxFzWFkB3n3RZE5olfXUNMawz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 14:30:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Julia Evans <julia@jvns.ca>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
In-Reply-To: <60D4F9B6-0858-43FC-8C2A-B6200640961E@jvns.ca> (Julia Evans's
	message of "Tue, 20 Oct 2026 14:22:59 -0400")
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
	<41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
	<xmqqzew8wb3g.fsf@gitster.g>
	<60D4F9B6-0858-43FC-8C2A-B6200640961E@jvns.ca>
Date: Tue, 20 Oct 2026 11:30:13 -0700
Message-ID: <xmqqcxt4w7gq.fsf@gitster.g>
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

Julia Evans <julia@jvns.ca> writes:

>> 
>>> +Step 10: Create an SSH key (if needed)
>>> +-------------------------------------
>> 
>> Even though AsciiDoc implementations are somewhat lenient to allow
>> difference by a char or two, but the number of hyphens there must
>> match the number of chars on the previous line, so add one '-'.
>
> I meant to reply to this one. I wonder if it would be better to
> update all the headings to use a different form, like this, because
> it’s easy to accidentally get the number of `-` characters wrong when
> editing a heading.
>
> == Step 10: Create an SSH key (if needed)
>
> I don’t feel strongly about that though, happy to stay consistent 
> with how other pages do it.

As we are getting rid of the old contents altogether and starting a
fresh document whose name happens to be the same one as we have been
using for a long time, consistency within a single document may be
sufficient.
