Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505818;
	b=O/cZXcb+E0TNHDI1pJ9nof8NImUd/fV0EfMfiYZBLg9SQMuRhRTGE56hWOWSrVlMRoNL
	 agXR9DX9+5XvntmSzVti56rU6i6cqSYqYaLP0XNdRG9HlL+Uao/ykCyyrYupzlDHhvGnU
	 b5/+C0kmhEn+xo5pP//t/OSAJD1uN9h80kTILAnqzTW2AK3WUTgmbINnEDMPnUZtodU5G
	 HXaLEAMV7nvJ7KTl+abbbBD4AIJzMir5YTgRKkaoNbqDcvzsXKn2t6VLTCHqQZR/HmDV/
	 USmLkIK0DKYSqmdSGO9iMa/qIT6E4S7FG+ujOf91PGBANfi3PYMCjN3uB7S/LrKUQBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505818;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Sf1Fdr0Ws5QXvrYGcZKorLDyEXQ0dC1LjD9+WKWZljg=;
	b=kMddxG48gErAN4Qhy26huPPvIbWckD48kE5xU4ivktWAxhV9GiBb9YgcBrJTqgNogZs4
	 BhQkY1pzRTRIAMrG6UHPGnBgjoLE1LtUShtmf7LNYwbBDa1p2BRm+MB0z4VIXR63Ibi02
	 pcd0bSonFKlI2kpNUEF07gxg2pnYSK/AVa4eYPvqVGbTWLImzwAqIRa5YCYFKaC8WHKly
	 TCWW/YSvSb4lkuR2QqNfHwH77x3weEtOMD9/zRgyFDqHkocf33ROVbQwoNwqwPPOyjTV4
	 czTkeWjj1jPAksKmaslsTu8Z9zQFZ3sTdMyNT7aVdK7kqDwHyl+Iqs6YzjTSqcAjc0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=HFlDvrji;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=uoGyPXL4;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85551606AA02
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 14:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85551606AA02
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=HFlDvrji;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=uoGyPXL4
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A1E4AEC01C1
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 10:16:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 20 Oct 2026 10:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792505816; x=1792592216; bh=Sf1Fdr0Ws5
	QXvrYGcZKorLDyEXQ0dC1LjD9+WKWZljg=; b=HFlDvrjiIOZAv8UW9ivLHV5hsX
	JWoqU4RQ4tkPNb65R1EWMPX740k6en8R/wqTHEheSGhPmCId9hbv7+DUkok53aMB
	o6DY9TV3X6nr0zCBsVbs0Phva5FMSEV+KgjSwYlXd9kRCOiGbh6t3TMKaZIk7IrL
	kqLDuk7TVz3wfYaNLsq3Bl+HIOc+B5E62dbdxaXrVnA8tXiP1sHwxOUmUKC3ZBG6
	HIkBumCIjtY/xtiN5G7fHla7FPL+6273r7MG8Wme3Z/tknHU4J94ZMmfWvvVglCL
	BYimLr8ICFTqgZTCwQo35jfZ9DQ8+hUGIdNUTVzKJGSJQ0c8lDxyTxBYsQ7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792505816; x=1792592216; bh=Sf1Fdr0Ws5QXvrYGcZKorLDyEXQ0dC1LjD9
	+WKWZljg=; b=uoGyPXL4epx4A3wbezxTzvoLFEEe4AgGIESwvTh5+mBBOYAkZDs
	fpftwJGPwX+zaYyepG3hiYH8yZF7ZPWCuVU5wtg1OQ0lu/fkpRVd9SEnh3PYw+oE
	d4XxyWN3FDzgLKqaUEdcPIkn7RQPpslq5Nav/cJjNhm+xDuuYDyU0zTl2QwRpOp+
	A9ECxGyoPgtGa42WK51rWf6W8uJFgWCfMvUZ0M1oB6dvso4y1I8INvAX+9eECxhd
	EUVRtAtSGCyqE9uy7j6LmOMLZ6/ZrThvhEGifSgT4oaOMy8H1stkCyXvdYrO0M3U
	gA3mWouPhEEoaa2xjwsNcxPpEAW4lmi+4vQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792505816; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:blGMfQbRU4UyTQY5Qg3TcJKyrxqpDvrY8Tinxkbr3Sbtwcz
	Cdhbp8ZhYN+QAbLjSRghgqy0Y3UJU5DCBvNUS1qkE246Veme/ZB6ouuNgwVACWjr
	3anVCDMwkHBWXl2yc2D+faZ+QPEsqMpJ/1Ib35/XtLmI2gukmLTa7yQ6vUj5hiFB
	J2V66xD/OeGuJDtC1fD21gUAb3RPLi5JzP8QZKvxPU4OpID1+Ul/lBN+4s6hO7lC
	W0R365ZkXam184+s+Gt0hBVM52CMdbN1pA9Om+N99SNtO0pks/vOCQJ48+pmSnxA
	7I86RTYYIf2lleuRxvAgWBEEvvyU0O5zYuQt9+A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:DbGbPMHHHg17Ca6yfeChXoz9eGqB+1n/6AvQF9xrkIE=:pk3/7PuUapTmN1ybIXO2iQiElIQHGo1rGGpI2SIJuoI=;
X-ME-Sender: <xms:2HfXajICmfXV-6hzBcXNFfSsUx_eZC__1uACQ8VhlVwEIfZ1OiZ7tQ>
    <xme:2HfXauKbZc-Ah8R55Wf0hT7sArVywMaI19cR4nNW_fmc4_fhkEPRWVFR65mF0pTgm
    EPTnQ5AXgB8aTO1CbfYi_2a_LvgysaNLn9dkcnpA8E94Cmorbqd9_0>
X-ME-Received: <xmr:2HfXagt5krZWtsOLJeVdl56uFBrEBxCu9ZiX3S8YE8wQguwTmYJ_L3plkMNKwfvFZ6e_sxCzUfSE11an_2h9xFlUrF2bjojNtpJQ>
X-ME-Proxy-Cause: dmFkZTEM47rg6FjGikqS5X1lKj38X0dP7RnLJRO1HPWyAMIx+Jtnf9Mb1D0RalxbfL+I9M
    rOx0FLOUj2nhJaKqsE4yl+a2oDMzj79qbnYU9oZkc4XOsxQ+JQah1VVvyREQyAhmSkNB3T
    F2lovg3hIXAfOzKu/+GFZ/8GLNgecsj7Fu+5H4qj7bWX9vavSecX0Ko66/Xc6BKNS3UbSs
    3bdND0UpGkEiVjxc75qRuZkpE23/n5v4Fi86XTE+B+QMi9Z83zq5FAK0mBBUgSKHaKol5P
    yYoTkHM5XZ+bNm1+iNsS8Q+MSaENhZg5+8rfqypBdMiagN1W4xOpHMergTQErgPUg2jhg+
    LQu1Vc1nWobDEWgwF7nNc2jKHSW6LzL0SvcGdsYOorLXmAlbSq4e9QrvswYSjru+Cybhv0
    1svB8VOG0g4wXvb9XCji6YSpnADt+2sUffTUMmEXA16sB3iYYJgVG40zkTgzaYpJ/nSFLu
    M5ZayUvobijCYWQHFi7vFAEsndHEuNSz8h7ClQIyYG2Sgo9a8BcO01EsUfaMzw88ik/1YN
    nz0/kNviTkwl+PcnF7BcgIpfW+GnID6rXslFY/VBXyrtdUTBxyA6yxib5RfEzD97QLUe4J
    Ya87DA3kDMstz7cYi+EjT50up0Dxa1KTLYmOryS1JKV+X8pn8Obuxk+uIWmQ
X-ME-Proxy: <xmx:2HfXarR5YU6_rfD6sel9Qd5ogf3gx_5oGLzwJsr_wVyG8H6lJIq7bA>
    <xmx:2HfXamO_CerQsxGbUBWtBg-vt-YFAyTiJi8sFafJETC-_DeTKU5JeA>
    <xmx:2HfXaga98_-B62XYGEpcQlaJmbf-iXhOlwzfH-qDqThoL6B5ovTyYA>
    <xmx:2HfXagzzDfRqaoJDG2w21uhMS55QP8ZjKvbHZzHD28frV2Zknx-9HQ>
    <xmx:2HfXavVOUMzYN5LzMM-xuCfLr248FexhX3Rbhoy_13BlKRw-Jey0zVeA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 10:16:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Todd Zullinger <tmz@pobox.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] github-ci: update macos jobs to macos-15
In-Reply-To: <atcBKeaaEAfCez9q@pks.im> (Patrick Steinhardt's message of "Tue,
	20 Oct 2026 07:50:33 +0200")
References: <xmqqfqy5clgz.fsf@gitster.g>
	<20261019194152.907881-1-gitster@pobox.com>
	<20261019234724.H0mV3jqQ@teonanacatl.net> <xmqqpkx5yxz4.fsf@gitster.g>
	<atcBKeaaEAfCez9q@pks.im>
Date: Tue, 20 Oct 2026 07:16:54 -0700
Message-ID: <xmqq1p9kzcbt.fsf@gitster.g>
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

> So personally I'd keep it at the explicit versions for now so that both
> are in sync. We have to bump versions for one of them anyway, so we
> should make sure to just bump them both at the same time going forward.

... or deliberately make them diverge for more variety.  I'll drop
the v3 patch and use v2.

Thanks.
