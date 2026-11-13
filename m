Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570403;
	b=3rPvwdN61c7a1s7RS33aEeQ95YZ3KDqTOui+bUnNo10artLw9aMh6b227LHjAEZMEvVV
	 h1TWvXyGTFX3qn1eLOFoYfrC+14vRYmz7qMqkK+XQ2xSXHQUbdm1C67DXS4fyg7lnk02l
	 g829pp2Pn9nwNqMIgsvJI0PdHCZszT6djH5zKELfQqYRlu8XubQltx+EP2k1TqRCDq74N
	 sPq41/Kc5VETzhhwcBzhC5Q7Sl6LqO2VmDxyHqsct4J9cmSUdA/2Dpmxlxmcy/HyxjI1c
	 xN4LKQHhEplskkmf1J9mYE1DTM83xEG6/P5R0CN0FDwRrjBHWQ1PM1qqDbiUbxLWN4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570403;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=NgcMwytKK7BwsYPSotlDLAdZu/uv1X0qluvh1+ulqsQ=;
	b=ET5o0cn7MgjBEmkOMz/swSz5/jPExflK0FYmvPFFhgzNZX8F+2j821QpUdwFsRcOVSi7
	 t1ix00Kl8pXHc/aBNzFp/EZGTyzgRJSjSK/wkgMJVULL0KcYf0pvm5ahr+QocMUEPSOBy
	 +lU8k3A4/IjeUNFtpei6QHgtTR3aBFNVvGjWgL3h/Nll61rwBFAry1iqsqCoiT5ipX9Wj
	 /3govAZdnSjXyMKmQQXrgH/FK/r15c/yOi4NJPFsvbNEhZ0lobzRKMpe4UL9v6Js1i6Pt
	 v+j6Cqx1hneJQbU2j27J0RP9Vq2UhNC1rnaMFfMCOj1t+urGZG2cxBuAQpglYIE4MWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=vVbzD09l;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lPLhkQ52;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC21606A327
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 11:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CC21606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=vVbzD09l;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lPLhkQ52
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C7457A02B5
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 06:46:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 13 Nov 2026 06:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1794570401; x=1794656801; bh=NgcMwytKK7
	BwsYPSotlDLAdZu/uv1X0qluvh1+ulqsQ=; b=vVbzD09lj9e+g0kHGYU0YzpgqD
	HpXC3fXRpqMX93ttqiTCYV/N4l+jVj8YwqeyAXXtWLO8Cl4L7WR78cyo7GaMp53o
	0ZNnp5NTwmN2hURbuDdKv9kmz1ye92dzIec/Ja6OwczXRmJIpYq5uSm7bU1wLsJj
	yQvOaIonLvDDBrNWnFAR0vaKqypQbrrkQfgHqQ0LCknfNnAy5i4EOF4Tc9YrsEIQ
	WBP7nZHO1LKdT2pO0tgj1xr/ef62pOYQcQQa11CM7rwx+saox+16NBZr5H0M5hXU
	1FTa4dr59L1yRJVo2d3e0IBvBAQeoNbXsPdgeTvAPFwxPxruaJlidntjRA/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794570401; x=1794656801; bh=NgcMwytKK7BwsYPSotlDLAdZu/uv
	1X0qluvh1+ulqsQ=; b=lPLhkQ52qfP3MbDqLZiY+NWN7DJSn/+2Ua8wveoRQ25/
	3Z/IpOVxZm75p+i7grhDaNEvSWhzqODDvIpJyBBNpeSMkw4DqV+SPzEvf6RWtQQ+
	420+EZ7k/xvysf1B43EuyktDN4U6dVjweC7eLa+tCGX5T98J9xz5iOO9eFMrJs/w
	z3I6jItrIHv3nyondHpFwLuW5WdpbT7ZZ/MqoX+wEDdwJ6zdaHonvHSlTkFLw3+F
	UWdqTtf5P44T3ruoKQzyCSzzuL3VEGWzmu0twylJFvHgvu9HYALUss/fe/dHJjia
	A4cTqSIZgUHAUb7pVCk95BcCtTQnpngghldsquDHSA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794570401; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:SkvBqoRpjZwn1C7RdlsdGQq8kjN53PmWEeQ/PC+37j2v8uo
	9o563lH8st5mFlnuFN1T6fCZmMbM2ddhRF9jcK7K7BPuh8w5/2VVFC4jdta6DWGE
	wAb+BY9Ph26SIG0o3UvKbzkwxtU7HNzN1bO7eQ/UrhtghBL3DRJY8BLowK6vE4Jw
	8bWOoTKizB3tXaP1KVp9NjedZE8PgDu+jvmwY08UcOq5HI1Py4xeIv9x5F9yBDJy
	23oR0oGyt1umU6eYAbed1mm4dWbnXX0aMZbCR1LbyZT4R3uHnpov8h49xrXoXj4t
	zAj1yYG3d+w4LC0KWOUfoqUxv7vPt38gqx6I15A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:cZA5OX08mnRUIFedZHOk6ktwKbKhyYRMZtqizdlGuuQ=:Nwb0TaPxr3ff44pQd6T1WPmVygl/SxzVCKKHaMrJc50=;
X-ME-Sender: <xms:ofj2aoI5d3huOF4CnigxCTWXtENPGLkO2H3nLZ67GDz-hQjUuhgFqA>
    <xme:ofj2avFc5s6MzKJr9Nwsvd5K1da7gy34oL19IbePZ84VVwTY_RraDVbRq_36Inlk8
    xr_efTYdVNuwHPq8TGlkxdAn4j0mKaYW4Q7nzk7512SjebLX9CQ58Q>
X-ME-Received: <xmr:ofj2auWD5DdJasxVtj87GT4AUSSksCfQs5dh94XoPLTjg57bgdbi-Q>
X-ME-Proxy-Cause: dmFkZTF56hPfYUY6db1tP1Jy+0u8moFevoK0Y7LyYTeMFimTS/o7FM1fVP3VbYI6NuviS4
    uAaBMJNB/K9BMQYDbLfjyeAfPi33PuBCEX8BqK4jH22J02tbamZ/y0hlQ/Y41oa1vafwT0
    f52CSw31pgoEwAq7GgGw8y4InQHXKRURFf3AuqSd0G4/XAZyVIW+SgMPP5NR1qmoqJMeZ6
    dbZhuQNNZeKUyTaZpTWcB2wJP2yW0XjU7Qw0m9peAgMuSv1GByFrievnbwe5PtEGD0OzHf
    10T1Ddhp1QCRnSYtSs2NwNgrTi4XBniVtXLJsf3IDl8aul8pOC2UyPt2M9j8BAaeMz3Fcr
    +R/g6jSasFxHcEOkmiOVjuEbftg6LNPQg7Nya+QNMaN1kxCu6ogIE2dKdhpM2IB1zIC4Uk
    sqvZAeI7tFeVjzbTQHe4vmH7Hbf5avbo0ZPyMhpC3XpmznMFTvC5MEExk45dVJZ4rJ3dXA
    aaI5Ze4uXYjVQNGhtWexFx1IYMEEsMkrnpjF5TYfOJD+DAemyFQhGYmJ1SkX2DjElqq8KL
    TjJHVHh5nEkdOVtnoN29+DOLPbW2N4v1Q/xXSAMVbAPE323jmLAp3f6mz8ePZvDzs1+8q6
    xAJbS4z7yGH4JA7H+gE4SAAIZ+8qNDu1M5FJaLpwfgPDY7+dDkQhXTDYJFMA
X-ME-Proxy: <xmx:ofj2aqhnXbCpM_ILaTQB8YgO02eKFgTfEgCvthgTuOFEUgoUGRl2qA>
    <xmx:ofj2avQH6-LgTJ1l00by3Jt2gmPI_U5yo43Uc5K8OgBoXbPfD1bunA>
    <xmx:ofj2atGH0nXY8xkLIkTDd7iZjZy5hkIoUjTYOxvufLKPbRqHRM0bvg>
    <xmx:ofj2anmjVNL5zBcOqS_TThAB-2pYgRcF_Uto-7NHoXPpJN0tjmUz6w>
    <xmx:ofj2ahrxmtxaQVG8XvnVcPedlTXOq6M8VL1f8DixFVStU_1sN12jifYb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 13 Nov 2026 06:46:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 733318c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 13 Nov 2026 11:46:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] builtin/repo: improve counting of objects
Date: Fri, 13 Nov 2026 12:46:16 +0100
Message-Id: <20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQrCMBBFr1Jm7YAZUcSriIs0/a1RSIZMI0Lp3
 Y3t373Ff28hQ4kwunULFXyixZwauENH4enTBI5DY5KjXFwb69u4QDOHXNPMuX8hzMamwFCVz3L
 1/egEXk7UJFowxu8WuD92trp9/lZa1x/nJ+vlggAAAA==
X-Change-ID: 20261111-pks-repo-count-objects-speedup-528abf12ea23
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

I was recently using `git repo structure` in a very large repository and
was eventually greeted with an OOM. So I had a bit of a look and found a
way to improve the memory footprint and speed it up a bit.

The repository still doesn't produce results. As it turns out, walking
33 billion tree entries takes a while, and everything rev-list based
that walks trees is kinda broken in there. Oh, well, a problem for
another day.

Thanks!

Patrick

---
Patrick Steinhardt (2):
      builtin/repo: only parse objects as needed
      builtin/repo: don't fully parse trees

 builtin/repo.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)


---
base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2
change-id: 20261111-pks-repo-count-objects-speedup-528abf12ea23

