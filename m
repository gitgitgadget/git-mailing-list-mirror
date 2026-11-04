Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794789;
	b=yTr4dv+bt0zJvOE3++sGp8b4fHTmtMF0RFMhrSeEc1DDaxc7jGVUE6aSewe5FCLcZBjq
	 fwcsFzehx9MWzwR128iwA5J34JMAE997Vdwve3+m/OGxA8XCfjcx5BXx0zf/0m8ogmR1O
	 wvdonwEKc0I6Mb2EQWbZ3lRhNqSSlocde63X2Ut+JiMr9cAlZhz/gjLLktksIagibH1Zt
	 B1Ggbov6LLJWm2XsRmKvpb5R66YH9zzHmIbmxCKKXHr4lDAHsLiyrhrlbCU7cvA+hxvbh
	 7SFR7kD6oB8meazA2+H0tptdHEhK98G0B7PQk4HPvCEnGOv4HnwJGndDjP6c3oTIxbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794789;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=jQszLJLkalB2quNvb5dBMvKtH1LxJun4RY+mI+0Y5YQ=;
	b=WTeft3p9LDcOU2ZrGRVwjPTUEIocBZzcqVe6Z8ixXCOoa+9TtlzyyJ4o+NxvCFcqf0/X
	 aEPBN9IJDYLnZl86dXt3YfrKEQr9xjqBAQCykELNGO+HW+W7tpAzwdIX+g7WhncShXrHR
	 sy/mXYV5viZhHbF7ZPA07C9PJGCQRDtFpbcVzzzvYN7lfYUeBIoG2qqeDrrZ9EPiJSMkH
	 XYn1wO0z/cuUeIjopx41xiQQJHEp1E550Mwxq/qu7V7QGtm/PH1Oy0g81PC63twDW68WU
	 AsYnSRV6pr4jPnX2pa7Vp3kbmd19HO9d5/b/rpRU4BnCAzRhWupb2kaueIs33WXVu9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=T1wNaHMv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vBXa80nM;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6C606A326
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 12:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FF6C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=T1wNaHMv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vBXa80nM
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D5041400057
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 07:19:47 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 04 Nov 2026 07:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793794787;
	 x=1793881187; bh=jQszLJLkalB2quNvb5dBMvKtH1LxJun4RY+mI+0Y5YQ=; b=
	T1wNaHMvB6KacX1KkGX5QhP2n+egA4thY4hVMrdczf873qpC8c6fPQy8ir2HWJde
	8WvTONA6eyvajUqMuJe5XOC/wFxJ1mxScb5N8SLPScHzjXt9s1cqiYecjVG2mdkj
	7ZBtsQgHtVAsYAT+pp/7bSt4D0Qb+8O1ongiUcptDjKtPof/4KuQE9PTCB2jJbvi
	QXM3w+hKaTo1s0Qid/WVapb6Ih5V3v0jeTsQ3ZLY5wEvAOcf18kCv36ueImP/Tqj
	MlYYZwM58+0aIAkdFmwJR0coN56IBxWkwrkgj3vx+yeSAeOEz32aEfC9w/XjvuZj
	F1U0N5Mhb40nlQtFKp4pkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793794787; x=
	1793881187; bh=jQszLJLkalB2quNvb5dBMvKtH1LxJun4RY+mI+0Y5YQ=; b=v
	BXa80nMUWKnJJ4V9seqFpt5MT4xZ+xYKzjoHFUBSDLVB6LorpP09GYPsIdYHaZXJ
	ffDeecTdCY8lk74ciRTrWGJi55E9f5ne3OP+y/9YJplcHbRL0h3htfhJQlTjs3gw
	BGnhjcXe97GOB9hHpHx38CZJS6yd/AsBxN6hbRTVVzli8lylSYy0+NOnEywHb4Jv
	TB8dRBmhejqm69CHb1JR0WzpONJYLnaWohK1o+b7vnWGyzUxrzla2Zzwo1QbTYuP
	PV5o/9e6z0U/SNWRcwnwGMXAllNBm5T6GGH86PUJ3HnVY9Pr8BQzTMlq7qmI85df
	Uco24de6f6H5EM3lpK4GA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793794787; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:bz2jTgZqqYC7a7sx4gidF52eF/YnRxYg3NAsWl9Vbj1wmt4
	MYQWtKP1NFpTuT/GumvVaMK3edV7QxxDZFeVqh7qH0z/vVQN5KnhWxWHVXa2DgWZ
	R8H8d+3nmysTQuljlhfDkLGajwKhZf83kinaMTmAYfu7exGPITX2KguYhgdE2g6B
	16AzI6BcB5BytUo3Q6xte3EJYq+3YA39OyQqO7POoMPsGTUdRIp53lD1MHqM3FtG
	D0ZvSx/MoZt1FZdJxzvM8Ks37zLMqlpwyLatOwjvnVYY8XESsDlQyh1ndleMQ05B
	P8H4UYc4twbyjcf0uFQ0E4ams7LuNz8dQq6YDmg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cVLQXAmR310B5AiHKmEZltaXkjLB5O5tC5zFfv8iM4g=:8IM0nb2cKyePWX5clfas086K74TtDA6yP8DYae21TCs=;
X-ME-Sender: <xms:4yLralfNCRiZLnFxZk19-4l92LI-STRZNtSI8KyhLlE4wpCUNbKiuA>
    <xme:4yLraqqPrnoHdZ25h-59g_BExWt_cNmCoEZm61qPljIaNL9lhq0KqO2QXw6D_V2RJ
    SHrV3-0JJjj8q3TBBVcLMIINBVZuCOJQeaXtHC5KWTLpPbQh6X3lA>
X-ME-Received: <xmr:4yLrar7vmyJIddD0zck8M76cswIhOi08CypeRl4CoTbVrgTteMo7tbZraonq3HelhNmgmHY>
X-ME-Proxy-Cause: dmFkZTFJg/Yt2+doCePEosti0AE4/pteDnD1K3L5guobbeTY0WNAUlZXI/4bMI6p1NKtry
    OYAAYyZ9qWMM60MqtIyZ4WhK2gyOA8klLp7U4XVlROGYqd3YIGoM5cNskhPRhfDgSn3gcY
    BXe7gcpkJGnX7MTbBJmdZfTgDVaI6fWbtuXkBuldNt1ezLxwcdC6dO7WnXtLI7HZ3ymQ6r
    5dRww7mv+qsqXAF1F7ElTezanBjJwuxYIKE+5H2EzwA8fRWcZeV89jt4uuEaNWL72nVcE7
    96MP7GAFuNx2KdbcqRXxWHy4731gU2KFSsJNLfWN8Lp1jpKNxv3Ur9Hk+zXGavdfScW8NY
    UnhxE3cADQfSopVj+yg/sRzsneT1Ou0sZmQsgU2oXKWVU99/ACX/CFjqmQvP93D2WJ3hR8
    7PEjLtlYzpad2m+bc46hJluXiVa1F/uaetH0CZKTTRsI1byZqBvcf/v5mitmKGH+wIxEX2
    dW5ACY8jwmkEsCLz6djPgH1q6OHN219zcdDYRB/hn9r5Fmev6lSbA8vq7WbWPAifdOsR/B
    hZjTRQBcpK7bJS4596IRIAaxzZ5G9T+spaVKtlAVgQGWXtvMjCTggv2eDDtcbKBDcPtmv8
    1LK9Wj2NHOM98vokfUgJOst5GPyhftS5ExyRPW9D0qomny+SWBeh4V3C8nWw
X-ME-Proxy: <xmx:4yLraopLvIWV7hKC-b6bVT6yzH4j0ZjVbdgpJfBJ4J0S9Hip5vm-Pw>
    <xmx:4yLraliho9aIP8GERjlb98zW1Z1zEjlXIcXYHUEDyekv6agbgQMqLw>
    <xmx:4yLraqJDUn6Wpte6a0PH15e3RwrRNM6FZoClc9Q-tV6rhfpNroBrZA>
    <xmx:4yLratBh9fRD-SFCmwSbHKUhH_A1xnb-gDrKmayhowdqT_kfHYRR1g>
    <xmx:4yLrajaYjTDAeZC9290HCLZaYJA0fuEHBh-VhW3L98pinjBwkziNGVzy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 07:19:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c30b7e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Nov 2026 12:19:45 +0000 (UTC)
Date: Wed, 4 Nov 2026 13:19:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Lazy fetch in partial clone fails with "not our ref" since
 5946a564 (odb/source: make read_object_info() pluggable)
Message-ID: <ausi3vZtRdB_40Bc@pks.im>
References: <yrjh1p92qc7w.fsf@pohly-mobl1.fritz.box>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yrjh1p92qc7w.fsf@pohly-mobl1.fritz.box>

Hi,

On Tue, Nov 03, 2026 at 02:24:51PM +0100, Patrick Ohly wrote:
> Hello,
> 
> "git merge" in a blobless partial clone fails with "not our ref" while
> lazily fetching a missing object. This started to occur today in the
> Kubernetes CI, completely breaking the merging of PRs. We should have
> been using git 2.54.0, the affected version, for a few days at least
> without issues, so it can't be ruled out that this is at least partly
> caused by a change on the GitHub side. We are about to revert to git
> 2.52.0 to unblock the Kubernetes project.
> 
> What follows is an agent analysis of the problem. I'm not rewriting it
> because it seems succinct and useful as-is:
> 
> What did you do before the bug happened? (Steps to reproduce)
> 
> git init k && cd k
> R=https://github.com/kubernetes/kubernetes.git
> git fetch --filter=blob:none $R 6575724b63e50cd5dd454e774bc293c6de1e4e12
> git checkout 6575724b63e50cd5dd454e774bc293c6de1e4e12
> git fetch --filter=blob:none $R 787dd27af44c14c22d3bae46bf62b4a0271efc06
> git -c user.name=a -c user.email=a@b merge --no-ff 787dd27af44c14c22d3bae46bf62b4a0271efc06
> 
> What did you expect to happen?
> 
> The merge succeeds, with missing blobs fetched lazily from the promisor remote.
> 
> What happened instead?
> 
> fatal: remote error: upload-pack: not our ref 27b64cc863187e62d8b47196a78c045412d32ac9
> fatal: could not fetch 3c804b88bcf177a1435ba770fa9054c25e1315c3 from promisor remote

thanks for this well-written report, I can reproduce the bug.

> Bisect result
> 
> I bisected v2.52.0 (good) to v2.54.0 (bad). The first bad commit is:
> 
> 5946a564cddc0bf471f27ae4c3fe205441e3ef65
> odb/source: make `read_object_info()` function pluggable
> 
> The parent, 3bc3177ad7 ( 2.53.0.185.g3bc3177ad7 ), is good.

The root cause of this is actually older than the commit you have
bisected to: we never update the loose object cache when writing
objects, so in case we have already populated the specific sharding
directory that the newly written object belongs to the cache will be
stale. And as object existence checks are answered via the cache, we
will now pretend as if the object didn't exist at all.

The commit changes logic to not flush the loose object cache anymore in
case we cannot find an object. But the fact that flushing the loose
object cache fixes the bug was pure coincidence, as it required us to do
interleaving objects reads and object existence checks.

I've sent fixes via [1]. Thanks!

Patrick

[1]: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
