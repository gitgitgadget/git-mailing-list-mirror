Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795291793;
	b=xFwcZ4Ovu4y/5q6u/Wh4Qkuqo2KQgR+TE3YDjcZz8peAHwxqjuTuH5YhVN5QLn+ztjSz
	 itmEX5lQtEjRvfTzHBwuk6x8T1PmJnnnOS2msj2gjLCG6B3Ua5wUiBdwUzIIOv4ZqYshg
	 pKh1dRrX4fB3ZXhlpw+nkC5VhWcdt7J9qiKn/vOvUF8WWbG7Y5XZ8gv+WsY3agpiB8NhD
	 qo6nF7oh5bRr13LsNe62lxd8WWrn8o5XThJj3baFG3XFoxj32g7UQ6mWfCUZtUtm0WsNC
	 zUWxoSwuKxX3z5yzt07+SvyBfTif8cX/nbzXa+9WEfpXnP0HQI+w0QbTGkFlfy3Sshg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795291793;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=fVaxE6Gh53Q+M2oODwBN+bEbzfQ2rsPK5UUAGKs97qs=;
	b=RNMA4hTYvoJYNQ7BE4BVwXe5F5zQKZbSkJ+LHSGuTpihnzk53Fx0MhBs7eO5XD+lihlg
	 uJGt01JVhy3sxHWau4bVLQmo/B4/56BuQMz3/OTtKmCI8gcBr+SDxIEa6o5GNNmJHLbHI
	 OTozyBnbJjqE8e3v/tnRNtN/ahxnkPW+54jdC7FteDeTPK+ys2bhU7sWtUNM+D0CFSYHE
	 xmC8oAm3S3x8gi6ChY3C8od6oijdU4HJZlT9Cxo+DcMI2myAVGLnQLZzETVM7W5LTAMi8
	 ez1aKA3clmrfy2ZFRB1DkIMzHqRLd1hlQ58EPvVJ0nWcglRvtn+Bje+SHlEI5N+5i/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kvzlfBfQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eRU0FaGX;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EFA606A32A
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 20:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1EFA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kvzlfBfQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eRU0FaGX
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7F91140031D
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 15:09:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 21 Nov 2026 15:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795291791; x=1795378191; bh=fVaxE6Gh53
	Q+M2oODwBN+bEbzfQ2rsPK5UUAGKs97qs=; b=kvzlfBfQQw2BhV2pVL2/uyqoqh
	nhh92glSfhL/pQ3z4+aKZJyfaT2gmR1H4hPtVWKuw+lMMVIsPAtDId1L4akKmWon
	avBWraP0jOnqhEmuZgPG/Sj25eZIZ5utgMCHlXHF3i8ayf1vxzcs6/YwrfAnhrWQ
	UxZQStUSSjdwAO7mbXGk5yxjQefypI52eHEfrYwAIGgESppQ/ttUQI5uJHSLe8KD
	liJX4NN/47fqgAUqpOgpKVRJunelDCKFJX6aXBXFxZGIGqu1XBL5dLN5k3flLT7o
	ZZ2Saz+SLXtob1pQuM21duCV3Jbainm3IbCibQyfFMbb8X6VJlfblweL6YRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795291791; x=1795378191; bh=fVaxE6Gh53Q+M2oODwBN+bEbzfQ2rsPK5UU
	AGKs97qs=; b=eRU0FaGXAY3mAv53nglJ/HnfsL/3+tqMzeIK1wJYbPFyw4yzF1I
	IbQw7clePrb0lUcY7yGFBBl3GcDexuP72kpU/rjvCgreUfJaU4FNBb99T8cyW7+e
	pbfpGfiHlzxc0UoaJo3vbeezS3m8+Esy/gxKDgOqfT6WdJBOiGOiPbsmcnviSpSh
	mSx1VKygmfSwqAilIzP+9JTzzQ2nyKb1AlEdqWTWnRBMhbT/YannWnDPivIHfPlA
	eK+CQMP0h2mgvzXezoIR393hFWXCjQYv9knMbuAHqe+rafqVoQf5xWeRssYTEpjU
	8jBFRvJBodqngv/HULycwLzCy/TS3TKcN+A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795291791; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SpNnGBSF6Ut300Rjy2TDlmpfUMZd1HwWIkvA4jOL4Cvhfdh
	M46Z/ntRY6qSxHTya1F+mo/kFFjni842FgNNlh1NY1dntSJiN+ddri26NAyEVnm/
	5TOmTo802iZwgk4FfGVej0JIywP0Jk+4KKoic3LUT9O5/n2HZShWDZaocEpmSMIu
	m6apD+zER2Mqmfyv1jOztYIcryB5IR1PliWiVindpkA7hTUBtXzP2hgkaQQdCVia
	ubL56eIOUpAG3TkkFA+q4tZs7bwaty3cczThuqB4/OFOaA1Valp0FuHqHiRmRasg
	Rdb4DPxuEOGKugRTXncCb5Z+o6+WL+8YcatWpfw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:w4nxdsqqcFm8Fft5aXFYvZCkp1YJ4zGHTDZDfIIE+ak=:fVaxE6Gh53Q+M2oODwBN+bEbzfQ2rsPK5UUAGKs97qs=;
X-ME-Sender: <xms:j_oBa3s-AgI1SJaiDFi7nhsSi25CRrHPLqT9FRn3ClJ-jcnLOi8ljA>
    <xme:j_oBa8Jd7BmSDZdwgsnuFOeuj-b0G7zhilwSyoysM-98aZHI-XnUY86CfAD5jJFLg
    -v9xV2TK-f9wHqVOXUVq9RZWglHBtki-PC4IUTnG70uGL7d485mokc>
X-ME-Received: <xmr:j_oBa0mSe1mAE5zaULfrHUKlX42PaiVM5-QgHrJsT-kwfV9GAigyXeCQekqWkQ6Lvmo8VoXYOeP71GtXwGeCBtklsp7d-fhj5E0C>
X-ME-Proxy-Cause: dmFkZTGgJabeyhQiKnq5r4DPRjgPlNmoqGDa5qryK0r3rdlKVO/PBFyNAEz4U9BM+KNXIF
    VNVQG+G6zPtXpYKcpeZ2ry0pVYyLPwXsETrUze4r1n/Vf7SOlDgpkBQ1BtRweeuqqSqKrs
    PBIVzum8uYn4ZjXoW2wWrgi07CKI+VD2db3xOVcXK7j7ny0LrKCuIPMowyz0oQrfsAO9aH
    2gM4qhcLPegxzByMv7xPqnlN79oIwY6dfBCWZ0tvhRQxaV8Xp18I7uTzTlvu9n5YkT03Py
    ZrZdHcyipFDHmVmqHt5++jhE09NWBDHlBjd62tgFpsJCy+MdPAn1SlhuZkvfxBTgGBJ/st
    +OQ9UdfKhPjgnc+0WUKOjPGSl2VIDyTlA6uzLkVL+KMPvx7OrwOSRZ1/3CtX9MeRRv9rnH
    k1KrB1Cs7qfUEAKaoiet5yRVF6EII8o1/rPKvEjvYo/LZl8HPFHa5Uap15rIboPXBDi4sa
    i1SRQuHqBdvyoksFqCSvZqeziO2vQ2ZLS9unpniyYqG70gz9HTnMbjqh1B4cCh1tRrmEFO
    aOgWA6pYEVhEVTJ275gVWCdYUZOnSPCZp5tylgIQyY5Ox3sM1XCUmLTtpdgNJ0sp/FPyxW
    sQbDY5NHQNh7xz2HEuNKEQhaED5K/nKuyfz7p8LrfYY3PEQENm8/LsI5N0Ag
X-ME-Proxy: <xmx:j_oBa9JORCyCRDCz277BswOCbES1c4eBNNTwPmoljDmX5t3dEspGfQ>
    <xmx:j_oBa54K9GPtwFJH55M39097_Dn4gh10hcsny0GUe1EY0YQz-At3eg>
    <xmx:j_oBax2YSi1r4xg_cx4nGsqOykKlv2XKMsZKyxr1B_drEtSHnEPyPg>
    <xmx:j_oBa_dIMbzusqA7I9zV1YnNolXZvoV9ZC6GHAGBTN0oJOd93Js6dQ>
    <xmx:j_oBa5KSrAF-M0qoRLVrBaHpbp-ecOaVYMMrtoj5CPQr8sUzTsHRNSeb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Nov 2026 15:09:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elia Pinto <gitter.spiros@gmail.com>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Jonathan Tan
 <jonathantanmy@fastmail.com>
Subject: Re: [PATCH v3 2/5] object-file: use size_t for loose object sizes
In-Reply-To: <awBKj7DjFg6i0kVj@pks.im> (Patrick Steinhardt's message of "Fri,
	20 Nov 2026 14:26:56 +0100")
References: <cover.1794914210.git.gitter.spiros@gmail.com>
	<cover.1795069177.git.gitter.spiros@gmail.com>
	<c9facd8b3b8a60c8516075616f66da4308380684.1795069177.git.gitter.spiros@gmail.com>
	<awBKj7DjFg6i0kVj@pks.im>
Date: Sat, 21 Nov 2026 12:09:49 -0800
Message-ID: <xmqq8q2mkktu.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> AI is very bad in writing good commit messages, as it tends to ramble
> without conveying what actually matters, and because it has a very
> uncanny feeling to it. A reader _will_ notice that, there's a certain
> vibe to it that is very hard to miss. I've been saying this elsewhere
> already, but because of this, commit messages are now the one signal to
> me whether somebody is investing their own time into a patch series.

Another mechanical signal: They tend to overuse colon as a
punctuation (yes, I am trying to make a bad imitation of them).
