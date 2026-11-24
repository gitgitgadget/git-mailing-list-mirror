Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478512;
	b=rSBG3mN52m29vZVitNIXgmiOtF6204qTNdjJzOnHpqJPpB4H/y1hGi2LD44NgnWHaGg5
	 ftlimS0iPVGn666Yak9iLeY6hbN1/xClJty72z7syK5d1v735yoqsg8YrYASUkT70hOsW
	 gBNwu7Sl7wnUDVFV8x0CEGgOQriBS1s42mRsdnmFQCrAWnrX144DccLOT9+zRrHIDWAo/
	 7HCz3CYd8iQuePsB0u6CNzeXWfKamrwDuZgWVUU1yT6W9GESRhueOJk7bsnSAXDWM0GfI
	 PUEM7oAPuF47cqgbyHkSywKrR8C9HfUI1/HVMRGKreC+zF0qDJZUKRQNbZCrQ2LwZ1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478512;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=35Hn0UqI+aOfmWBDGHnEGbzVsR9ygDPj9Nuj7WwsauM=;
	b=p7KcWrGc0ocQzeMZmEePqv/M+v8P5F2sh/ooE0fayhAokpCZhwHs6OjTcZZnIkZCm+Xy
	 EJRAlMRdHBK1H05Wh62537PCmwKUrB3NwjkulaaoK5NaEm4iax7ZDk7/PTT3Cj2Zaq+Aw
	 s/1//7a6hBI6ByGZNCSahl8h+U0MnyzvxdEjt4hQtOTk9F40s6pYl4zANjsOMAzTc8i5H
	 mVlC9YWttNcgL158vIsKstmwvZ0Rw16z7S2cEfifLaa4SaBfs/1V09KCeF5FiEK8+uFh4
	 Rf3FSvTZHVteBMD0qHrzZkUtrThhKphqjaP8ytA4JMMvbBZrQdLE4bdQEnaIrP+ZqZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=U80biKnV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=s22HSoVf;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD83606A321
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 00:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DD83606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=U80biKnV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=s22HSoVf
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1C90C140032D
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 19:01:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 23 Nov 2026 19:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795478511; x=1795564911; bh=35Hn0UqI+a
	OfmWBDGHnEGbzVsR9ygDPj9Nuj7WwsauM=; b=U80biKnVmQmfX0UCbLrSPIuJqu
	iiEyz0l7/EqutGeaGxy+1EyId1N/b4NCzcFIXGMASl36l6bbRC9DIb1/fHe7F7ql
	IUiMcUVxIL3X0mgilgENkud2BNhi0xJRpx7j70ttgtp1rwWubz6e39MKgCYPdBCb
	waI6n6A2hTgSN83NRsp8P/CbD6ZGNiOGI9cci+sNzxanUL+FUepVmRx3tCCn63gu
	6U3kqkMX4UPKSuqIGMTpQ8Fd5Ba87YuQq7BmY6tuTi7syKZTt4VzM67vk0quQ0ss
	/zUQBqd4xi+fTWDRUiwaJoqG4J7wY+bjoafd4XkkCYYfTzeggIV3fFyib0dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795478511; x=1795564911; bh=35Hn0UqI+aOfmWBDGHnEGbzVsR9ygDPj9Nu
	j7WwsauM=; b=s22HSoVfTe7yTywwX0tDDr4F6U6eUvwUucDHOLqQdj11YPxAh3E
	amVdx05i9eA5YOJ4Dhmv0mYtThzCs42BqIiB1UfRolrcVZ+v8h/isbxYW0pZ4GWg
	oZKbLsJuTBUvP/F80zFVZRXegxwwRb+H7bJvRXUako3aKBwzkCxy8F1mZue4qrqi
	tpRqCKKjTwtTOkpIHJMgLsywi4xpYgz2+uJ9EAXTipDcPqbo7IHflR4gguTnEuXu
	KVbi424A9KDFDpuZjISlOxA67uNL5Xku5jKTu7EVSF/XmxqZzwp8+Q+uO9VdKl85
	ST2pp2BPZY3YR44j6+R/Kdad3519Q7Z+peg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795478511; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:O9fGHNGhL/+jUMGNNnKSsL+/oaZRv2WgkSHoGj9RxzcbZKi
	79mAirwHEG0A7AGaWArWyzPlNgDIXNJld7OjuWAcmO7YlvA2Rt2q4oZXCqz5S+Nm
	rZ+QdWm1pC2PbXRntj3cJSMXQrsJAnIRPtyK59DZgiQ2+6vjO/QKTjoCs8bHa1uG
	qdESu0UuJa1rC2htYFPOTGZsmDU5HG6lLLVoi6wSZHtj0jj28ANifpwp23e2tfKE
	QBbnDNjfpvs0Ac7uDm05gTZuFdXzr4ua3SunjhWbl3gThr+40htzcgOZikDrpS+z
	jXTte8SiPDC5Xwhodple22feqSkoYC7LeiouvcA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:bG1bcENkCCpyYUxY4/fkTVsctUSlz3d34Z8o5X1/A2Y=:/VR7cVOeADdBCGiZxUSEt1/KOX98DAWfwxtL3D+yROY=;
X-ME-Sender: <xms:7tMEa1DT4OMD4i0hxedwHBlokDjqL-O5pukOeS0tc4Rpsv2ZNRy4bg>
    <xme:7tMEa6a_gE3cc0srZEOcs5C2r6eTJj-hJuwpuxcb95PxZozFGGVt26vvJdQD84ZqB
    JLKY9AlPFTSUhYJglfqqMvtbNnCBI7nj5EOtrJJh4vhLwpn4MjY-bM>
X-ME-Received: <xmr:7tMEa45QG_CsawlqbmQIzSBZYAAWTLxMl6kfnPUIM4xse3U5GK80x6SFSkyfDDfs8XB4-TqSNYFv6Cg7EMfx6Ro9QHTHEKYYYb_fH_Q>
X-ME-Proxy-Cause: dmFkZTGIyi/pF0cazc0zx2si5w63pF3BZBWB9Id+KriAVrEwSubsUSxKp0i/MbhUeQwROm
    vHNwpQNirj+dzGK0RroMkQQekS8Ks0i2Y+hb7El7mrLWmYY1/jhVjnAsNkdslKA4Irttue
    o7Pnb4uRvSGE8NKieQlXJOpFKqxwjgJ9IJI2q8Ew3YGeK+Fqd98BDXgN3ipvCl1laX44f3
    LT6gMU658cBwHsgFTfMTVQiyfgpWofh6IYcs9P1URLnH1D/tG1sf566V+yyY7aay4Tfhi1
    C5oK1SlrKO8rWzMXMe+BLaRUJUASlQmbgoPjPo1dJodosN35wBqSpIfgt/qzuuYCmg3Qru
    nACLIDinRMYb6mDPhuWxzquVVAa5HA0MRDjoMbcjZ/sURl0AD/0Z1/GI9zvbZioQM8SQge
    gGr+ylQJnFuxHSIhb9fZsy9ShOrJUy5sXAghJzuY0YC53asmcrs6SwLHkgHLQGLyxWYLB8
    ifYM/4EDde1b7DjvWf/PnqhFTPdJoKzoISdz7KPEmJdyCnPJgyALAZ51OypMbSJaAnP5RD
    Je+aPYD7jegGMWAru2Q8xe9CtKgmF8qmxHyJO8J9WZM/HK8grbiHbBKHEWKLTtn99GkKom
    FyEmUZes9sW0KgBlbEdQ/OXKXecnOPQ04MbCgOCo2kIJIodfSGDcqhqRlsKg
X-ME-Proxy: <xmx:7tMEa7YKirJtdbZWSZpHe9S7t-9sQNctw3uFzE7omzO83xBxKCtnPw>
    <xmx:7tMEa3jQQ_MM_mLEIUmCMgk-MdL4ODB_lCK7UkmR4pL94a-HL_3qmA>
    <xmx:7tMEa8_sx8Mfo6wRvwHGuDFSp47l1eaajfhpQikgORCRGiZaFysE9w>
    <xmx:7tMEayoW7yFWmOAWsycyuyucl0jJr0vaVeZ5GHGc0nGqac1Wa8vwYQ>
    <xmx:79MEaxoQTjifcbaCYeelZYWQVSv-4z7sk0Y8jSNeTcfmnqEWINiOGA9E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 19:01:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Adam Dinwoodie
 <adam@dinwoodie.org>
Subject: Re: [PATCH v4] setup: fix hash algorithm detection
In-Reply-To: <awS6dogRASLU3OVx@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Mon, 23 Nov 2026 22:13:11 +0000")
References: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
	<20261123011403.720209-1-sandals@crustytoothpaste.net>
	<xmqq4id7bjmb.fsf@gitster.g>
	<awS6dogRASLU3OVx@fruit.crustytoothpaste.net>
Date: Mon, 23 Nov 2026 16:01:48 -0800
Message-ID: <xmqqfqwr3xn7.fsf@gitster.g>
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

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> I think it is test_config_global that is getting complained.  Perhaps
>> something along this line would fix it.
>
> I'll do a reroll.  That only triggers on bash and I use dash as /bin/sh.

Yeah, I run my tests under both shells exactly for that reason.  Running
tests with dash can (sometimes) catch unintended and unnoticed bashisms
in the test scripts, and running tests with bash would allow some optional
test lint features that are only available under bash.

Thanks.  If this is the only thing that the reroll would change, I
already have a fix-up commit on top of the topic branch, so you can tell
me to squash it in.

Thanks.

From 0064676b1a1b4263a45c168443849be4520b2ae3 Mon Sep 17 00:00:00 2001
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 23 Nov 2026 08:23:38 -0800
Subject: [PATCH] SQUASH???

---
 t/t0001-init.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5def3f98b7..58271c8fac 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -638,6 +638,7 @@ test_expect_success 'init refuses to reinitialize with different hash' '
 
 test_expect_success 're-init does not modify hash from config' '
 	test_when_finished "rm -rf repo" &&
+	test_when_finished "test_unconfig --global init.defaultObjectFormat" &&
 	(
 		sane_unset GIT_DEFAULT_HASH &&
 		for algo in sha1 sha256
@@ -649,7 +650,7 @@ test_expect_success 're-init does not modify hash from config' '
 				other=sha1
 			fi &&
 			git init --object-format="$algo" repo &&
-			test_config_global init.defaultObjectFormat "$other" &&
+			git config --global init.defaultObjectFormat "$other" &&
 			git init repo &&
 			echo "$algo" >expect &&
 			git -C repo rev-parse --show-object-format >actual &&
-- 
2.56.1-774-g531cf23297

