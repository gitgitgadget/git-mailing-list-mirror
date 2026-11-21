Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288107;
	b=bx5YQXrlnTzUxshAk5OvNAJe165iSmvN0IjxNHMOQT+eHQYP8eLaE82ndLiOjB3g6Eyw
	 mGww6Ur2KtyqTxrKv8rAXOooGmV4aKwnBqXOcJxXnwNEX2IerpU+9D2pgs2XIIA0wMrY6
	 Q3e+mvdXAvWZY9SoRoAiNPPnoft/XVL0tZRCWnTGAJK1ulIZuanPVEuKCqyWlXrAz3nWn
	 Rb57+wodqgiA5XdqKmmJz4dqzJS6A+ut2tJNrajk4kU+BOKzDSJe0gh2wrWd4sJ1OfyZh
	 zOOcS0/Ykvny6TEwLkUAvpHG39YezQHqjcUIpkFgJwCwm21RNZiS3mkRep3D0R3cYHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288107;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dfgL1vxjYC6aKIsH+u2CMzYJM0e0AdgSkKuG6QQGKQw=;
	b=lAeVxD7E0Uy/DYGgFui+kelJ+qPNGjX1T/Rn4UxYa1D2LW8/JWqqCVZ3cAC7heHOFSUq
	 bdbLtiU2f8+vHc8VsEVvFWIt46OQOt/3VKTInLRNiwutcG4uYsHyGWKvtULf+PjcMOxby
	 V4XXl6VjTVdYFk6ssMouLdGKQ6y2lbUd2cEoO5lZnuQQI08qp9mYFLTIsRrH3uVZgyJX4
	 Z+axi1EwxCfv08JpLx/TYWacyaSF805tqPaYp0kdFUMbQ2OTqK2gOCBnZ5XYRyP9xvYku
	 fojV1Q94ulGEGrZhen9UUVFeYu1ty8ZjO8SbMnKVMzcMqaN7IRVSlvjJg+Ib9pKXH1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=h3TRL9mn;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KfFMnf6L;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD316606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 19:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD316606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=h3TRL9mn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KfFMnf6L
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C4B381400366
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 14:08:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Sat, 21 Nov 2026 14:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795288105; x=1795374505; bh=dfgL1vxjYC
	6aKIsH+u2CMzYJM0e0AdgSkKuG6QQGKQw=; b=h3TRL9mncWCko+K4oynwnGPEUV
	16VfOC1jF0ttD+0SFPaz7TGbHVUANmvnVBUAXEiI4q3tx0N4KmqbUH8rosCbxOyo
	huY1oxkxhBUNDpx87RnzJxaiJ8ZwXQRibSY1tughP1088B1zFVd6uecuexnEHyb7
	N0474RYpyXrniEcQHYGVIP17rL7Ad6y093dhUGLO+BDJ27SfCoIVsY7dIk+jMVNd
	kUBhys1b9fmi7bpVoTU5HEWKo3Ga9kZnToeXxl9JuvNnUjIZe82/9uFlUx+URhg8
	n22iPzYaoayUuMmNqf4ykarJm69xq8Z+PKu+IMZH0cSX66kOeGZ8RvCB9OKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795288105; x=1795374505; bh=dfgL1vxjYC6aKIsH+u2CMzYJM0e0AdgSkKu
	G6QQGKQw=; b=KfFMnf6LuMHOK9cHw2//yGPPIUT/+KumeHKecXHr23woXPMiCdi
	k4Zd//nA17gUyFuoSy9sVVHWrqod4ZrdtoU2xAmh+bP02/JJsGcSOHcxyCOTWqsl
	w2JTi64dIgdVFXP/J+X4rSiwynN+ezxqxQl07ROGWwzgAGNWSJoGgI1Dz3OLHQ+c
	VzCUh0VaWlcDJxXmyl1r08SB6uzcFNeuBNFrFvapElFChFk2u64B5uUTW/v/cJN2
	8RfqHZ43oqXmsY/EghYBdcYMOxp+3DNvcQpZHgMKOXt6pK7F5BHfTfDgi9s9jRFI
	nQhrENc693xVAOQ2ss2YNcWUqiTDHraZRwQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795288105; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fw9SSWJ0Y6CIRB4PuL3ayzFDxFySQVz8VjYj0rA1lCYUn7v
	/rW95yrY5DqRIl5hWpWx8c8VecenZJYIt9Ady3jCxggaMYEM1sTT26aHjx3IZXWp
	RyED34uD2CgURo4svmMP1bvh+iEppz/uFAahfbksK15WPvAqGR4E+YwCq80dEvoj
	WxFBxgOKhoAW91khkaBrUa1NroFr+zSGiTcUklGSOHXq5M9f9UWKGHafgGGZauwL
	Qr2DZJdnCnaUSiQC/Hc8+W6AeSYGeDDJVhAqk4Qee4JzBAgA9K9ET/+jltsBPcme
	iPNtarwYmVBN53S8/rT3azA9caPENLoP8JUzZ2Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0e9vVI7snwkywhoDeLtcun8yRJvam+6kySLrQAN7ZOQ=:QKxvkxxNvtYoL9Wi1n73SnMYSqxlBucOPOjS7Yuziso=;
X-ME-Sender: <xms:KewBa3xdr6N4b4yGJlAXsfhtedCVoHWxoWjbfMgmbQSoVEWVIpXfKQ>
    <xme:KewBay93ae0h7bN_Q7-3jMCZKj8oCkm5UyzhQFeDePYVl20cXoR1zAzeH_qveZZ-q
    haB7RaZyDMwPfe9FYHSQnuDWsAJDSL9Jc9gJNFyJ6kYBxs5tnRaRAc>
X-ME-Received: <xmr:KewBa7JTE8HKDsbubWEIZfGZGv5imthNPs_LeLz8GoE1bEIlo6KKKzqQze6QDpKZhSeqeTVbDlN-K96cBRQXJKWubN5lCPjyf9wG>
X-ME-Proxy-Cause: dmFkZTEYXWw+9CQvU27WojLzZBsI65rKjaFYOYjpOC4R+dp6X0q3QSgOiAPewZDfa4NScQ
    jNI5KhlfMC8b2lWwB3AusDGHmEbxwusqzxHm7mTuyA3COTCNKZdRn1rwX8o2VuMHx9LbeN
    cVrV5lBrn+7F/0ISfjnFHywLn+4ylbu+oYCU9Az9DwHB1MTMb4ds6/a+Nb2hl51jeeLwf6
    nuK9hVoN0+ZP3dP21awJxNrPZahQZ8yOMp1KBgxX9cvdtSVdg2Oi3s/LZsJQAZqiF26DST
    /v9yzl0OKR/0qiy9adfHz5SSSWI51xuwR1Yw7fUQgbdE+7CGbwi3W3GijpPEfQWfqBGcIb
    HEWJr+pPbGUglGmbGqBZI5SYUrcH2LFcYGra8MMhak0oi5H/bPbPmYjGz2q7aCKyjpVbU6
    gNyWz5Q+J3Hv3VZWMuqfLS5DtVQlBV4VM+7KBWwdnQHZ4lzXQD7lCiQxYOF+e5IGuxaHS/
    M3RUlrEY9MpEOnckksjGcCKXPeCGoOUjUEGxVmFniCNOYF0OkPWtOvplBM3uvziLLXEEji
    4QMFH2mnC7WYUFOKRp9crpAK1MFRc2McAqC6Jjgclj/T46NDtzQxl6ddGrj51qq5hcNJNz
    XR8CBeNklvEK2Bnz/qBS8jqvsXzXmInZMLdq/e8kjN12LGbMfINsJAzrv39A
X-ME-Proxy: <xmx:KewBa4f-cfo4kSMRqgWGP8NnmTK_9xTmLe-CffYjzfU5XrcyvXYWzQ>
    <xmx:KewBa694ICo5YxL-3hpMlvm_mBI2eACUx-k8r_SINwhR0Lki4PEeUQ>
    <xmx:KewBa1q7xK4FKe4msSn-p5E1XDyHA3ASncvOPGcHVEsOTMslTv5DvQ>
    <xmx:KewBa_AXF_vc0DuLXe1dLzdS5QbzMZtWRguxdQJH5hUlrLCFd4XA6w>
    <xmx:KewBa9IV0I-rvLbZGJTNqovuFvSZs_-rAuLOjDI0gFkC6-qTbtn7tMYE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Nov 2026 14:08:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "Eric W .
 Biederman" <ebiederm@xmission.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 3/3] object-file-convert: copy unknown commit headers
 unchanged
In-Reply-To: <xmqqld6nm3fg.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	20 Nov 2026 16:30:27 -0800")
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
	<cover.1794932695.git.adrian.ratiu@collabora.com>
	<26080a7a386bdd0ae14725d2e731d1be81774d49.1794932695.git.adrian.ratiu@collabora.com>
	<xmqqld6nm3fg.fsf@gitster.g>
Date: Sat, 21 Nov 2026 11:08:23 -0800
Message-ID: <xmqq8q2mm28o.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
> ...
>> +			sed -n "/^committer /q;p" ../${hash}_commit2 &&
>> +			grep "^committer " ../${hash}_commit2 &&
>
> This "grep" used for validation will be flagged by test-chainlint.
> Use test_grep just like the previous test perhaps?

Sorry, I misread what this block is doing.  Your "grep" is not an
assertion.  It is filtering the data.

Your first "sed" stops before showing the first line that begins
with "committer ", but otherwise prints all the lines it sees (in
other words, it shows all lines before the first "committer " line).
And then you append to the output all the lines that begin with
"committer ".  Which I suspect is slightly looser for general case,
but presumably it is a good enough assumption that the input file
contains such a line only once?

If so, wouldn't this be equivalent to these two lines?

	sed -e "/^committer /q" ../${hash}_commit2 &&

