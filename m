Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021178;
	b=NrbJRHqumLAcBg1cHN4AgZIymGJtOx50qdLvYcvRu70OVK1zoa2OP+mWxGFd/Yl9bafM
	 KhRlZtm1ftET2ygn5M/FfX1iqkz+TSlHlHlvQBls3ObTHgQL1omvZGxoShmpYx06KZ1DD
	 zDS9g76u+WY5XO/Y5PetKwTeReD8OdTzIhsVNOKDtrqmD5ILUL1jWuXHxwnaQiAlXnMZA
	 9Qlh/ZdMWxH3YSxSKw4WuXbJLdFh7ME1mGTYNPTb96WaZJI3cxkrraQUMpkL5+lMaNnz7
	 MOnnd82Cxj6Ak2Xr7WANMPVjv2ksH50Ylkzpkly2oEwcTRBV74saTKNo0IFA/MsIYNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021178;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=0frgJ0wFE55GahGCuvwB2AWZGQPqNierMFQlL07MIXE=;
	b=XUG3sAO8ogM9r84QUzcp5/UGSJ8aBC0l7501sF4rDERPEyOVKHQ19gtUmiQeyM6Hqo27
	 wiJCtIL6welmdxgjK12VaxaYgATGZey4fdV5KLdeRRC2rHrWeEHz5IwIxJth8avK5rUyt
	 Sy8rmMT6iS2+K0MWgtWEHtLReYzZuae0moalP4yABF0pqX8DyUeuz/v0SBDv32PSXF4i9
	 cLMdkk8Ar453hs2PTeWDeJcT7Ry+Q3BeNTAlUNnZaZ2D4AGdwu3yvE8F0MuppG+tgg6h0
	 22De2l/ONG20hFW9+dPKFYXoOOckiS+jwE2aIeBuJ53+ghhEHAS9iDu5MZbmkhbCtXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PoxK6Blg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sTCG7UJY;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA8E606A320
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 16:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CA8E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PoxK6Blg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sTCG7UJY
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C9B6EC0309
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 11:59:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 18 Nov 2026 11:59:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795021177; x=1795107577; bh=0frgJ0wFE5
	5GahGCuvwB2AWZGQPqNierMFQlL07MIXE=; b=PoxK6BlgsAq8QuLGbE56rbq4JJ
	bvRnf6J2G4fLuiaMWSoeoeFMJkJD4IgQyVXptLu5eCd13aY5Pla/AU/FguEvr5hk
	RXqDGkFr2YdPNyQzdsdiNSaJ5UrsXH+s7Bg3rUI6y4JgyCSmrUqji9dCBHDmpBF9
	JuUrFsxgvtT9wCXkaiEGa0ZLOf4qrb8SbSEwFCf4wP8e7PUM7pLEzC5n5SiUnh7V
	OXhm/d9xP1ZTXce1Uve+TgHzW/J6HrprZ6J3ARz7NZJXK9BzDASgQQkkJyBjguvF
	SfY61DOACdGaANOy49ZRQkbrN7ZHtsXUClIYOKesp5ryWRWVoVVDCBm4l2xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795021177; x=1795107577; bh=0frgJ0wFE55GahGCuvwB2AWZGQPqNierMFQ
	lL07MIXE=; b=sTCG7UJYZBAy1FN1mDACIS+57bJY1YnI7+pow/+xfwDS/cbDRLU
	qXGT3Sdiyn4Nr4+9JnUAMa/Vxf874ymLIF3vJWBd0ekt0g3bucMz4rEKMFnf8K5D
	eZUu3tPKzJsEIm3025W7jJwBgD2pruYdmHFc6CpaHrCsFz31NuoJCEfRcc62fFiu
	ZMm7HaVZydSsXITZpGSfK4kguRQnbJkdCVAwp6aPULTFVEE23gHvUJiSHjuRy9pJ
	kgAVqE1AKjNOyR9nhnLh09xD89Yz93dqAVp/Beo39DTSlmcop5WEHXa5/41TVdUL
	hcjJ6sRYzGfZP9FnS+/lUfWpRf/2GS+6FCg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795021177; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Q8PLa4jQYBQavBLftEbj81lAhp09zcL/6VPEO5AwMqhRMNI
	R04LO1MAefYOIPyALv0z+bKXuqVib5Z4YCbEstTeQOOpv1m3thZipPxPOPXG9r9E
	6TrZslDh8z7lVcAKrT4o3pxyDdatbumtEoEnWQ164lCXC+vaDCwL3ROT/ijL7XEf
	81lIBj2n7VXuM/eH6Uu1AdhkJPfdHFClk+Z0J7B9AXF3xmXdYz4y6ZEOOTspR4oq
	X22i5BHoMokzx/JMGA3v6kLwU+mLzLUVQQpm7T5ZOv3maK9x7rnrvmwnN8im+XK0
	3+9uZixSzKHM//tHlAoatgA2lnskFBWqx1unHzw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xji/8qNFY3recnTdtY+6hL6Igs5T+AOr08M1SAcPWTs=:LtjEdacIOgMzrsUnlrQQ9Cd2Dpyo6wX+sLznVcvqLMM=;
X-ME-Sender: <xms:eNn9atZzrwuCvlYlWGYSLNycWtZsWnka6x4MsPVctqwMDJNyUfI7IQ>
    <xme:eNn9am92witdzmafkbO787qlddywFQxLmQs8LfoHTr2fCS1hIe4I3MT0Il7l4cauo
    wYmhOh4i3h0KSaTmsQ_cLKj3THw1nW7D6ZX_ebQFDO1iDPkxrr1y_0>
X-ME-Received: <xmr:eNn9ajn8pU_HuMt3973hodmI5VLs6ZiSxLx4Os0FuPPQBMyAXvjnzHOinwUDvPMlwqv77tnxVctaRA-6eW73G5adX9y1YPyPS3ri>
X-ME-Proxy-Cause: dmFkZTFjZ0yyhplBWlPOi7rEKsfHc/LqcAjBsrkLvJKi55R1wWrxp0rsqyVRffE050jLEX
    2gRK6ucPTrg4dhIZybKgcIn0gFENJwHxO0yDQ6vD0fjnUJjI8qya9vZi7U3cFe/+yb3jW5
    bUkjZueR3/GLZD7x51d6gToXO3O9M3m7dUVVFtZgCXSVNAWE9Du5bR3cia5kKXhhnre9kD
    ZZ39UnnoYgqmeD6EkdrcHnc5ppfcbldsYakdFPQvrx6DE1iKLJSkt574xotX7IaPwDKQES
    iO/FTePbs3KJeh2baBq2IxEAb5jdruVk5oO/M8O8PS1VAuQhPBEA5WKaCeCB8bG/O8tFQ2
    jkGxtqNoWvNfP/jES+HzlPUK5LGCyjNLc3pAM+Tpi+3U6fHvyiKifVNZZ/Ps6IdKds2MMv
    GQK9dCut4tPKY5jNwxjy3RKpBDH2sJWWGqQvbX2vCkZLXHd5j023slabOGeWMr8Da6Jn6B
    np9o/MuIPhEmwcpJwutty1ofEWfi2HDlJwAXhvzuXOv11Ugy2e1mmSE4OLQZNdItz20ZEH
    hd0wb5s8XdlaIutXVUoIctvLPact5T2hoAJOAq+lH+ieF7jLy9+TKzQlru052jK46Eys6i
    i7Ad7+/p9kbO4FCKKovt8sCkmWzc3S3mDOFkCm96b4RXAXioD9yVmdo3HAhw
X-ME-Proxy: <xmx:eNn9arxPYAr-WSHime-3Bar-nAQz1e_ornTrf3QfmWlOKp6cE5UaIA>
    <xmx:eNn9at4Kdf2hXfYwaNoQjIrWiTTTtTB4RkDNnUCxPlSjUtqnrKN3-Q>
    <xmx:eNn9arXK4qxKYJm0xZSTybDkx17hBfJTK4ItxNJG_1nfeiKMR8FL1A>
    <xmx:eNn9alLpkfwoyhTXZL98ksr-6HEevxF1NzhJ4MASFPw1yml527cNvw>
    <xmx:edn9aif_0E0vNWv0K3t0rb1HeCq_XvJI5nbaAA-jpqCOjIHVtaXSxpZO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 11:59:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elia Pinto <gitter.spiros@gmail.com>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Kristofer Karlsson
 <krka@spotify.com>,  Han Xin <hanxin.hx@alibaba-inc.com>,  Han Xin
 <chiyutianyi@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH v2 1/4] unpack-objects: use size_t for object sizes
In-Reply-To: <av2pBh7vLj5DVDha@pks.im> (Patrick Steinhardt's message of "Wed,
	18 Nov 2026 14:33:12 +0100")
References: <cover.1793446357.git.gitter.spiros@gmail.com>
	<cover.1794984184.git.gitter.spiros@gmail.com>
	<b2c3d349a4ac73da7e1d066ac43754d3e6939b9f.1794984184.git.gitter.spiros@gmail.com>
	<av2pBh7vLj5DVDha@pks.im>
Date: Wed, 18 Nov 2026 08:59:35 -0800
Message-ID: <xmqqwlqa6poo.fsf@gitster.g>
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

> What's worth documenting is the unexpected parts in your patch, and
> things that may not be immediately obvious to a reviewer. But you also
> document what specifically you are doing to what function, and that's
> quite obvious from the diff itself. So overall I bet that this message
> could be condensed to half or even a third of its size without losing
> much information.

Good observation and matches my impression on recent proposed log
messages I see on the list, not limited to this author but by
others.  Perhaps people should paste their text to their nearby
faviourite LLM and ask it to condense it down by 70% without losing
substance, and notch it down if they feel the result lost too much,
or something.
