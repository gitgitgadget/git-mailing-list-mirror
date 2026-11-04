Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793774190;
	b=oKJaL3GJik5hpoY0Fn7OJOu65gVSUFO219jWEJ1AOMnWRcEXiJxTBtP7RK1/YSyP1CXi
	 vgUEw4Nk9ILDG2iwMt1YF//izjC4PgCNAOvBx0RuZAo53VtUsQH0t+Hvv9F3r2wjB5Qbt
	 q6px2IXExiIH7n13nbp5xNgCT/Lt1jO2Uek4pcyQtPdwGiOSTy+MO0dvb6zmq04hRIwki
	 Ai56OK9x/igkNn+C8GkmABG2z4crv8xLTr2Q/3m2Ro2GQuoyONetzyvrnF8TkddI33NqB
	 Q2dcKLjo0nquiVCW4HJBFoWZZ6b/Qulsc3qOBwiRAqWjN5XiQV7tNBzzWqqBJIycf7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774190;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OlKK8paNgLduvQ9O3ldHBf6cDnaeP+T0iUhoCIya3OY=;
	b=wD7g/0T5e+HUxD92sgnGNblQoww/WEWKMRosECFOyOqTRQUYfv+bpSOfDbWwd0SpB0FK
	 vexIDvoK9mOAhZQXghiGBDqZ8r1VfzLWdXqZ/K9C6Jg8E/ERMJVWkhTTzqd6MJiSuZcPd
	 9lHX6XYGn9HzwUgB6CLKtu7+6VbSJZI4urpdjq7MYx3oDWiykX6DHd66IU7U+c82e45dv
	 fXmXvGeu8JOB6liYu5HmFUWXRA3U+K8m6JnoCzbe4OytDVfLy0SoXcAEMfW2l7JirTFic
	 NRnIU+8uyoPsb4v3Ua7nvjw/GSdLetI9yDl3xXKWlhT49MrooRkUATw7bi8zctY1wTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="QtPhc/XM";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BKWFyThL;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4D3606A328
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 06:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C4D3606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=QtPhc/XM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BKWFyThL
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 683861D0027D
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 01:36:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 04 Nov 2026 01:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793774188; x=1793860588; bh=OlKK8paNgL
	duvQ9O3ldHBf6cDnaeP+T0iUhoCIya3OY=; b=QtPhc/XMsgaEh2r+bW/tVTFgNK
	NAHms2pypbmdpS56Rr822hu2+ywf9uot3APVcBDf8hyJ9Tu9ejGEQhdMj716N7v3
	hmoIXOp+wMRJo2EZhOeXh5Uh3UwdiFmWnAbqYbKe2pZof2CBBN2JZA4N0j49yy1Z
	pJ/C06Pv1BY1gp6/mJx9ntz6ZzHokXbGgTPujT+nW3Gnd422bND6poveuY9B4ptN
	lUcZ1plaKUkBocS+PQNAVQvbcHsmPD2xxb6GNsqvdQ4Kb2Spcq2yD5uXx1nnd8+8
	wMOlpnFeDnFelRVGPVDvAUP/xAVd31t2NB9poGATkpyuyTZz3RVhawSF28Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793774188; x=1793860588; bh=OlKK8paNgLduvQ9O3ldHBf6cDnaeP+T0iUh
	oCIya3OY=; b=BKWFyThL6i7bY2L0FdMhUszGFIgUe55hf3lGOBXhq1aiLvCaagG
	RPDflRupFkv7/62ZwASY1UIxw/UE5rxUZpPSirAPt09ZPYyIm8ik8zT0CjM2jNbv
	2Ao2MGGzGvaMqgX8J1I9yt3KmDY+th4vqw9LJ7vewoERjbOPF1+eBDepkgi0XyjT
	SH897eFd4v/kv2qdHTEMbVePSbQaSJpPnfUDOCbnJZyXoc/Cqqa2B4PKvTVBkDUd
	/bF5CrlImiKyZzWcGrgKvFi8/5ZY7V8tIzB/u8IRAlKg9HsEKbpy7gjzSqnkxwM8
	3XrSGiRGJMqoDrkBmwbUzAvux0TLhEFswzg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793774188; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:P63aANBBfElBcQiOBmkX3VesAmQJSm3zm3ibY5Sev4slZ/R
	+IiDMXmzs1DepPiOXeewZLV94+QF37JEMopdpQnUiOTJYQ2VHn7mGTbxo+cxuB5O
	liWZDz9fxh8kU1nkySFOxWeijZHqmZ69CzRj1wLE75VqDsbxO4dSvEgJeZ/6wX+s
	nuV+9ytQIwlzEvBIiPl8+P7LGnxkjC8tVcUWe1QUjbKTjFk/c9mdUwr6E/doFtpN
	4lCQSXWNewq5GHN5j1p1raXLG74EqyBjK7EVg3W3lQIOxuMnNtnDhXPSUxp8Z1mS
	1OwkxqkIf+pYBNX/8LhLQ2xqFoaUd2RCbhz7OgQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:EDqbualTBu5YJGayYwEphMSLSHQVnkuai/eX1QzAHDg=:4TbjC6KXBcpGE4IKeXFgEikYWZL4xMBcMSnokuOwsh8=;
X-ME-Sender: <xms:bNLqan-27lkHFORoncSSpYEK6yx8cZHoXFkOOsvmKL5d3S3iY7alXw>
    <xme:bNLqapttQfoXUegNoBlLCilqOIuWTW91_gF_lntbzhJ_tYngkRl0_toTOPOq1dcQp
    oHhMvNyUQKpk0x5oTZN_ZLr_0phhGrPLLEzJRc68Q9ubVN-6MvNFg>
X-ME-Received: <xmr:bNLqairjgf-q4QW8vumizYYJfyoTBqIVdD2jbogfUnpyRf47qA3NzRWR0mHVK5gCCEd3jtE>
X-ME-Proxy-Cause: dmFkZTGwLyoWuT4Rqasye9uf3uhYOPDc+6klBL8mbK3nEDDrnpQr/8DyxRxWeLqv0jU8SQ
    HdUSrRbhNJUxAPWkdR//g/8/I+A7rlonvWNXKpmZLoldsxp0jt4MPtz+QjX4NUZdztbA+I
    NOGgBe8uDdrWY3A9E+A5iNPhQk38eaqJwzQb78sq0YrcMovxE8LrEmQLxRRfmmGMaa21ba
    tvs3UFeLHddH1yJdXQo1tolNoAYLsN4b6WAQ0366zJmEh4IKfO8HjIamMSAPayGclC6R2I
    cmAjlTuLe35OSXPatCRvUY/7x+PYxr7o6iQ5Fo68X/oLGGIVRNQ4VsKrsNbIGaDmbfRTAM
    X5a2jSEUCO0VdMj+uKm7p1XFrRiY13HJpEEg4t+o2brvaBe4CGTjGBLGu0y77ivwop6pfB
    Tn+yhCQP4uyi7gcKh6Ur+VHU3SmDuaFNqE4Df2YRfs+BMqzXmf+EpnZ0d9j7gnHJaNr77h
    atVtxZeILK2EvRCI1O6lvF/Rh5Y1l16cuZOB2fgRD/P8kwto9pfcrAc7yJZOzazq23KVR/
    PNdrQdmtlDZ9UKW5bzsi4iLfnMwJU9bd5JuZTYf6vdiuOhSDtp2uT6G+Pe1l8E97spCSiI
    pK6ngH5nfZrWZDxU0RRmbwE8lwigMF6Uy4IoJ5b+yLZHdSvlx5+C4bzqiRTw
X-ME-Proxy: <xmx:bNLqaum993qo_1kmjalrN8fGvjgZuDQj0NyhtSiWD4h0Z6qHDViSGg>
    <xmx:bNLqauyvrfr23l3qX3BT3Q5W4ZrK6zVlj4fXNlMee1JBW7_jfvx6sw>
    <xmx:bNLqaunaKTttiEuz2olLEnJdrlQ0Jg48STOnxN5PG6wqCMY-bfOowg>
    <xmx:bNLqavc94INBWIm_LoMdsxUQZguTk-PNRHpzTfAObrZPw8ifCnFc2w>
    <xmx:bNLqajXwc8efyo06jrgFQjj-VBJ_y3e8Kv2VDbNa5sMPG57wY1EQXhZF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 01:36:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f1433b95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Nov 2026 06:36:24 +0000 (UTC)
Date: Wed, 4 Nov 2026 07:36:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] repo_config_values: freeze the structure for now
Message-ID: <aurSZcNENBrgxowu@pks.im>
References: <xmqq1p917kwl.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1p917kwl.fsf@gitster.g>

On Tue, Nov 03, 2026 at 11:52:10AM -0800, Junio C Hamano wrote:
> The configuration and settings per repository is currently in an
> unfortunate mess.  Especially given that repo_config_values() cannot
> work on any repository instance other than the_repository, moving
> more members into this structure is unwelcome.
> 
> Acked-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

You already got my Acked-by, but let me state explicitly that I'm happy
with this change. Thanks!

Patrick
