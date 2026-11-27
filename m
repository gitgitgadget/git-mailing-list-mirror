Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806998;
	b=5DS8y9GSaT4PFI8uufldDG9lQgFwZkcokpQUgb1zVxiKacZF21iqmcpsEPZjq0B5l9cr
	 m4L9BtlKprdfxNAlf1kyBXmwYNB3S4LmcqaZ8G4Uu1i8/+Mse9Y3H+t4WF+BgBSSTSKug
	 jblYVvHIW1Ub9IhgiiRTN2ijcVHQ4hIT7vXsoNeLbDAmVV4ZsIpISSqOql8Yn3Bqv4x32
	 JihivM23ollWEBE4N8ckEr+cTNlATGwudTAcLOJsd23OIQH06g63TCz+cMo1Qo+yJu3zT
	 iSXaMTZCiuJiEN1S00HzCU6F6pCXEOJJeZxvVWEwntAPG/Ont/4s9w9K5mDXE9cc7hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806998;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=CmGtwhKYJdIqCriOh/OJaRH6XwBqnERLtUuZv3Vd5fg=;
	b=Y7OCMUPOY0eyuNNP+xmjwgX5H6bvV1hOGQMrmGc7GIrkV7qyqvoXu9t08pBKaUEFW+39
	 BaKD9WVlVql++B5LfWb3r+/YF806PiZ+NXdeEN1q2LrxJB9ixXH/PrInZeoQZroT7zD18
	 N1dmdb2KYRnBBtp5zZYPlGli43X6Y6BGzFGMYH4F39zUeOdUl1CE4omH3gIa+r96x9c/s
	 K11rXiyd/QTX3qjiPrM5onIJHY5wTmyK9xqiqQH4UHSJlejb6KdfHxkgy1sW7NgeuwKw5
	 F5X/Q2vA2gySN1wq6t6oVhF24jpdQtRvgY5/Rs5c97879EhUjGFrE5bjzImcEZ3zpYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=miYGtp1D;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dJKTV4jI;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E6606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 19:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 581E6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=miYGtp1D;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dJKTV4jI
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D9BAEC0C35
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 14:16:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 27 Nov 2026 14:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795806997; x=1795893397; bh=CmGtwhKYJd
	IqCriOh/OJaRH6XwBqnERLtUuZv3Vd5fg=; b=miYGtp1DtZCnUNemBZdO9T3qjS
	O384tEd8sQjrxQuAg9XPGs/nVQx64V/9leRFDEuNzODTzpNZcqq2+oDXRNzrxgHU
	7iwjk5bjXWF/ckN9LOYETzhBWcyUEo0DXTnGp0SwztJi5urMElFo3laDlkDQmqcO
	B/xehY2l4wmDViGIfFgoIE2Vzrsu1WX+868mKr/r/Y+BJjqrxsn5lcmYhVSsxzZK
	FRW5dblcx+yVoRqt3wm48A50CjWKuqM64bgLE5CsKEmB2mr91a6qzi//h9g6VCV8
	k55zRbs8WF0ZTzZ6/PFmKFJS1s1hbZRI67trt6nuIJV5WWQb/3ZpFCQaLjYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795806997; x=1795893397; bh=CmGtwhKYJdIqCriOh/OJaRH6XwBqnERLtUu
	Zv3Vd5fg=; b=dJKTV4jIRQFu9k3aNSg31n9sIIBgyUpYsH5m7hqTdpZWff3yHoE
	GOHBc4ZLdusI+q10q/brtrwdOkPw1OZ9WA0x/kGSKKzIHTH2F7/rGRwJVbVbsvsd
	roE1DlmZr/pOWK40rzvgeOFH31Euk7zbuCj9Ip/GofhKiY1ReE8x0o40Tf0nN4nI
	N9yKpBSadbpUaZcwudyr9emVxGA36BIlZAWgCHRU/DMXCelvxFI1w4hUOCv/kzHP
	Hv/eyW2tGIaZAFzR9cR+BDvl6O1nTvxE5Lhb7kWld8Z/YlBl4jshn130Piq1kdVo
	91P0e9zSpbkf+VyCqQTsZJTFRCQOAJodr9A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795806997; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JBB9KXMTVSuTU373XK89ehcGYDuEE0Jut9EgDdmDCD4VhYa
	lkXZv5aohVP68fyUCl4QbcSrRf3uf51r3bkomJ0etntgy+1X4EZLy3ahG+BB9ezT
	R4U8KQQtRfdYeZ0aniNLFKRmpdaEoFWnWHiQ2vtXOQc5+FXEBVSY528ShVInQ4Ed
	gblUeqJGWW/5I6qZ19FSlKq+3CAVoJRX6+UOmc0Psz3oY9Y1bvnqCPu2yVbZzHqb
	IfXRDBDiLxtmhknzXSdkB++XT6k3Mj72ui4U9lc3ncposPq6kzJ9gRRWouymExbG
	ain55vvfbPUli8rCeD3S6LHnhFA9evEKZJWAyIw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:GVXGGEXi10TkKxXjCPi+f4yzT5mZT5Hax5IHLJIcGgs=:cnUdbD1b1/UMk/owyeiALJpnGNTy0J+rG2p8o/ebE/E=;
X-ME-Sender: <xms:FdcJay-W7HQScenKBtJzqPNgDCaxF7c_VZoK9QjwhbphSWIpyhK7KQ>
    <xme:FdcJa6Ij0D4wkMBd3RsLf2TxPLJuAiUIG3sFogFkOILsJafz9PC_LJED4M8Vy_82S
    UstNoKxhwavSJGbESO6katVVsHrGBGSn4TBauKgAevhXlce-tsB5Jc>
X-ME-Received: <xmr:FdcJa1bAeEg2ypbRn4hBp8eRsh7EXpzAMOJUHsvlcdns7Zky-lj8by-S3_uuV88BQ5BrLgbtVmFNC952Aj65UXUciYUrBqcAdZzxU58>
X-ME-Proxy-Cause: dmFkZTFHXExacu559IDNaSXu+TAW4nnZRyrOkNOHopubBznIdztD4e1t7k9IJ/0IV791MJ
    pZ1CM2v6Ak3KIgNBxpqAEuuZocfhmXK25N9C/tm6ALxk/5WKHoBTmSWxJALjqcR36v6kRW
    BXLwae8yMh9/rCVjVLx/gCAktbLGPbtI+1qDLa1m1tOdxQRoL8dWz8O3gIBLlgdJcZzZ7x
    NNZ4ufbnRkSOtHx9UUwnQkciJiISuyRB9TEx0BgvuYwEgXE9cHQu4xiAtEAt2IrI6pIJtl
    Zl0KQUThTchH1n+aElifWx2ZN3lWirKtaqLShaT9X0vC/nikMOaW1RXzQVkPqeW+HmpIik
    3lS96uuWQLm9ipgXkHnTjpEsEROL097Pz6oXd3gvlc7dQTPVxq4lZVW6rnfDnd/VilRYAH
    ToQUL2udoY9HvUfTe0Xoz7Ta8RmerUOWWLKchxuBBYgbdb4hjDTD7VK2WN0T6pVBkwc6Hp
    /aaDcT0ycJujqjTwAtx7svOIIUEoOP4PkQQVNs722I1qRwwX72+jBAqXd5LvZH8SMRvH0W
    +zBKXY24O0EJeYWXL0cSL+3RuC1Ctd3T/gf7W1EzeIqObIq+g19YcwYboLzL5/bCQ8BvRR
    idZNdhumJl1EzcW0/scdu44vP5zyIUUoxX5M1LnqwEMErCnxXxAHAUw6yhTA
X-ME-Proxy: <xmx:FdcJa0KsSST09XxZ5aYrUyktmLXiZdnWA6mx27ByqK-RvxLEdLNdPw>
    <xmx:FdcJa7AfWxcVAG1uU2F0YRjCl-F7nHEeHUg_OnMvOGo0fbb8NvvfEg>
    <xmx:FdcJaxofFrHx1l6NsFK7Q9SxFTLhaG3O5B8p54wq0rafuRQ6CLX0Dg>
    <xmx:FdcJa-ijJ-zUQluqN32Dlk9b4_crTq51bHmWMdj6X0Ap6_dXOvoD0g>
    <xmx:FdcJa2LsTzw1IL-KGIpfrLbBM9YhBDss1K6dhc5yuHSfqbonKKIvqtZF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 14:16:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Hamdan <hamdankhubaib959@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] git task: grouping commits into named units of work
In-Reply-To: <0AB3AB52-1F14-4C72-ABE8-46B635F463CE@gmail.com> (Hamdan's
	message of "Fri, 27 Nov 2026 05:14:44 +0530")
References: <0AB3AB52-1F14-4C72-ABE8-46B635F463CE@gmail.com>
Date: Fri, 27 Nov 2026 11:16:35 -0800
Message-ID: <xmqqmrqu84q4.fsf@gitster.g>
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

Hamdan <hamdankhubaib959@gmail.com> writes:

>     git task start "add payment gateway"
>     git commit ...
>     git commit ...
>     git task done

Hmph, isn't it what people use a "branch" for?

	git checkout -b task
	git branch --edit-description ;# describe if needed
	... work work work ...
	git push
	... work work work ...
	git push
	...


