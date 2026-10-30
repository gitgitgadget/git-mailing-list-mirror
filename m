Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352125;
	b=mtv64bw9e6vEpO/r56ANAlzlTsycophGSlJwyU8xsvVjB9YjVPC3k204SyqjGIdcheJv
	 SIfc0nEMR76Y/C6/lh3LPWR5HybW7tFzbBRTyIQLd/cYVeE7QT3kl3zVafnn+IDQSo+IB
	 1gYEwgGKo0eGt/QqRyq4GCiPLcdh+014pNrQL2DHlbOpkuYWrcKNRJVntHOCX0N2zb+tm
	 gWVyvTA34/Ze+oJYhnrXSRE0Mp6N2TmyKg9L9qxrVYrJsvwcvtEwOb1KsSnwQrPWcYPTr
	 kEbG3uqDqkmWrNotlXm2K70iiVmpWC5wti+kRrb7cFZGwgxZtEk51QA+hLeaXIO/1TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352125;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=LhkR3jIHjMNA/kZ1qC9H8u26IX97EdnM80rytbKBSNE=;
	b=CgvWw3oIka4WF+L76Iyd5IdOo3Ql+ck320PeMta9gkK5+oLjmRV8U07+R5zsZqr9WVcY
	 XyAdhxrIByelyWEcf5WIbyfb8HqVFcx/jvHWzBdZuH9JoEi1gZyl+Jp0KdqHqqC0uGVaf
	 cmFvHAKweprC37hE7aquoiuscJTAnE/48JyKPehlrWEEK8hGvqoal3HJieW14vncf9ykb
	 M+Lfr2RoGDZZJ3/umlAXHa+ZU5ltHpXZzhUdcVCaoDg0plyKPHDtwMuOFADaGXUZ/yW6q
	 vNq45kbvMZpM6zgTsSXkH5G0ltLbIp7nqssDtGek3zByglL6QuVFmB/oqpfnwIMlPDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=TDa4Yt1e;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dLy4Ht8r;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F1606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E87F1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=TDa4Yt1e;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dLy4Ht8r
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 100937A00BA
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 05:22:03 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 30 Oct 2026 05:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793352121;
	 x=1793438521; bh=LhkR3jIHjMNA/kZ1qC9H8u26IX97EdnM80rytbKBSNE=; b=
	TDa4Yt1eAGZgvIHnEuFW0eyDnahemDG9kLAZL8DAT+HsYoZUq3bSRBCg4/UnqKqq
	46TiCvuPsRV5bMeBQf9xa2jydnonLY1AsxQUPu2MBqSRaJ+LkhVQHbxd34xLCWtJ
	OvcXdoq7wXP+7S8nGVOf+r7e1g1nMsue+srmqGIotnvLHHpkxLHCV48FtlZ1Sbj0
	31X9pMzcr0YJ8S4zNs4zLjT5ywjISCQB2w6pinidqpP2m0QZVqKMimaUJude7ikB
	yObr4PBQClg4eHnhfiQihaCu3LTYx6hep3j3d7X4kLAHc+nCO2EgXgHVsyKHi4YB
	PHIaqGRoWreTcO8A6T6faw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793352121; x=
	1793438521; bh=LhkR3jIHjMNA/kZ1qC9H8u26IX97EdnM80rytbKBSNE=; b=d
	Ly4Ht8roAxNEpVYsOhcpg+6C9VbY7xe0d2XBh5gvfe6zAE9XOlzq6vyRqNVqsVle
	swOXB0ShqK8pmLojGNN2+uBt6ZiaiFhZwSzt3ABqGOccPcyn+gxExaO0nUi2uCdQ
	ssPyb0cWTsrv7qC6KxCrSFuIp+4B4asyx8jHZhnCnEsc/4K3AJ+pbR9F1A6oNk6e
	LWhGlqNV2adK6KzHT73ZupDUmzXtQROUxT5AeRqe4QCA0TYWMNBgb3cNqvKlmUd/
	BDhX5cEOcH/Yr9SLb7dPICIJ1ozsy/ZRmTIGpOyckzpl/f1u+Hi4UAXANQNsIHxz
	iz0PkJ1Qdvq9hPqUdLuXQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793352121; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:iYVUaNQBsdeTvt95OOSPkI0hf4saAzUbusDFDO3OYfyQcq9
	3UrQcyhLCpaaKnJU5v7EECBw/GiJdcMX18RPkIP3kl1cg1WuIsZHVCyVspqs9pbT
	v8bpX2JDwcxJFtyVy12OCdFn0C+dMfSEeEzlZwBOtO2K1qB6TpuF/t5FPiDIpYiG
	9HtAGpbqScguEDesMNYws4Cucx8NGfFAgYnW6h++Uzkpqsjypux9SC7cI9yr5UvW
	HzXKR1gU7lOJc33jo8Lqi6IJGFZYxX/et8ry53rIhx/t147dGbv5NMPhWzO48YKw
	fIX26iUwBk9QGzU1F/6uKKViEY5lHIYWZKQ/XzQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+WQs1uiXK+3bLzdrr2QLBP1dS/BTpcM8ztLHiobPB+k=:LhkR3jIHjMNA/kZ1qC9H8u26IX97EdnM80rytbKBSNE=;
X-ME-Sender: <xms:t2HkaoI7e9IAPcqq6rJuzba2QwlaH69MXKjUTUaOVoPkZmsuWS8r0Fg>
    <xme:t2Hkai_2VcldyBKHfS0ueAdWUSQv1pfXCT5Nefn2sspbI75Ca-vDaB6q4ah_OI8ml
    uIOsJ45cbTs-gqqVvp90dKiKw_uS3UfokaJzTH9zfz2kPc5n78bOyc>
X-ME-Proxy-Cause: dmFkZTErbdQ/e7U26rm0DWstGBVS1YbmtHrqrgS2O/Ctbcx0o8Np3TlBGcLp3RrcgdqvR0
    qZkStsZg4ZJCVRXePDoDKmztM0QBFuPimv1HFkbi5/jb/cKSbp0PE9r1UtDTh7jDDyn/0w
    I/O5LCEP5WUfpCgk7NCuhGgn5wroahOyibIWUklgq24LOw2xtJPZ3/CyXAAP5FowZXdxHa
    Z63mYZFVVfT8GycGPAasQYXXPciRuB8TG6vpq+rwlWNclFatVnecxFzRzLMe9ENN7dLBR9
    GFXKYyM/fNjwU5qr8sD6aLUvQyDJvXlJ+ONdaxUonBvGp557PIDzAj7kXiFDzPbDOwfjK0
    A4ZWse3KNhWKfqUyUgk9ayCnfmRWNJPO/gD9Vy3RvMGH1DsPB+QI0O1wCXLsGYvEQsk+qY
    2JpqZEep15cgmiYCkfyLKIbjvN6b5m1HsLYOXAiWrCAtv9VfbWaBLiESYPRD1Qjx8isVQB
    dKS/XC4+lLebuo0nHMNHZtxKv4bDpc6Jl5LoGGgHJb2oSQeJtoE2IXV+dpNGTDQxqrKb3Q
    ENdloL+HsUheQ/AGGQhKRK+9JcU1h6mVZfOFKKCM5PNUmqlhcnjbfmQSusLI4IbsidwcBy
    h/yO7yOyIRbZv7n/DTWaHxMmkRCGgvrrxWjCy/oYCdjNdIgUp4K6kB4aJnKw
X-ME-Proxy: <xmx:uGHkagyW1K1lQUy_Rkn67cnki-z_3qOU2oRTxwMC_T0ccZFWu27Suw>
    <xmx:uGHkaiG5gpY3rCX6slBK05yKxsAP8Mbr7AP_mOf2rZa8q7LMOuIgGQ>
    <xmx:uGHkasyuqX0jEgOcuBYXKxuK9DDtlvajh0Sv2u1R2NS44v8YJTxjuw>
    <xmx:uGHkarsC8U7IZUVZ7SBVjcH2emnwsNOBCQLqNzNxWvf4cnFUTBglJg>
    <xmx:uWHkam3t6-Bkx4t2-HkIgSy60eXMh8Q6kv4khlHb8q2ie65y5Tr5Xv1D>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 44D8E22C009C; Fri, 30 Oct 2026 05:21:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AOwTqJ9IjbyF
Date: Fri, 30 Oct 2026 10:21:39 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Farid Zakaria" <farid.m.zakaria@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <34b5c9c8-74d6-4d49-93cf-1d1909d56e9b@app.fastmail.com>
In-Reply-To: <DMHMEOZ1ZXRI.TDMEKTJ9W325@gmail.com>
References: <20261028-fz-notes-concurrent-write-v1-1-3d513e1fdbb7@gmail.com>
 <3c4f3793-07d4-47c7-b503-13a6ae567147@app.fastmail.com>
 <xmqqbj8c2wk8.fsf@gitster.g> <DMHMEOZ1ZXRI.TDMEKTJ9W325@gmail.com>
Subject: Re: [PATCH] notes: do not drop notes written by a concurrent process
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 29, 2026, at 21:56, Farid Zakaria wrote:
> On Thu Oct 29, 2026 at 11:25 AM PDT, Junio C Hamano wrote:
>> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>>>[snip]
>>
>> Or possibly
>>
>>[snip]
>
> Your proposals for retries when possible make sense but I may leave that
> to you to implement.
>
> I felt confident reviewing the current patch at it's current state
> (AI-assisted) and I do concur that it's a net-positive change in the
> interim.

Use of GenAI should be disclosed up front.
Documentation/SubmittingPatches, [[ai]].

>
> (I guess I could try to implement the retry logic - AI
> assisted if you like)
>
> Would it be OK if I also suggested the other two bugs (+small fixes)
> I found on the mailing list (with the same tool)?
>
> They are:
> * Similar race-type bug for credential-cache leaving a stale daemon+credential
> * fsmonitor daemon keeps running after its worktree is deleted or moved
>
> Both patches are of similar size and complexity to this one, with a test
> case.
