Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771598;
	b=zlBAq2YVKhWjN0mk62WiZPhLeDbK8plJWlVHj2a+4SR+F8qFym0tK2hy3rpBBJmq2UJe
	 f+P+7CT+ktNSA6i22y9mZs+j89QUWoY1KAAqAiWbWNt/J+kG8WdZPIXdqP/QOhFJpfTiv
	 TWNwzqgGtQkdhG7nwFD5MyhaHjXwy/GSVwjkAOAz4JyEHq+IKAFqw3UoIB5JgLKdHqP2l
	 cLPVp+TlGSVFFQLB4uWcAy/yvZMepFELvtPAqTN0D05R0/HM0QSLPVFIV94WTYdTXvg2l
	 P55WuGtHBn56ssYDHF70tzwWoKTv0/FbeOfGCeMkHpVifUILgKHVnsirOHv/vn30eHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771598;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=07BdcqtpthOvQUVVOKqPGw8j7OjHrOKZ1X0jANnOVZs=;
	b=SQYP4b+hz7nKg0x6JEDK1DqoHmcUm/8ZkbM+Thwu34WIBcvEIXMYNezASXjrSfvaDmvP
	 IOTTjw98QNe8/gp6LK4n9pme3z9b8TfTKlbJB6D7sQh/6p86Z6sB/3v83d8l19+TGkkw2
	 0tdvsefr519o343kw4wCWd27FkyKOcLqCVqGw41WIQ+6uiSj1OVdCfHlndIfbVfl2RjRm
	 8Iu5brGkCacumCp/kxOwRnqfdIdzTJm9fhqlx/YCn+UnlQcjIIJXlU6nNkuHOePCGcSSE
	 kQ1sYfdiGiD/BB0VUvG00s8RYoERAZUZ/3tqF/WvQ8T5KUaI8Gucn7wPC1KO5zvVz0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=aZjkJdch;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=G8mXjfvA;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFC4606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 16:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DFC4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=aZjkJdch;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=G8mXjfvA
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5DDE8140008E
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:06:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 23 Oct 2026 12:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792771597; x=1792857997; bh=07Bdcqtpth
	OvQUVVOKqPGw8j7OjHrOKZ1X0jANnOVZs=; b=aZjkJdch9K+9s/ImMwv8p7mijk
	ack6KNbGHOMLtf6CDxnbQgu+o9u+qa2BKr/nFXBXDh6xcQAyJ3g6tK5koOOKyu0/
	2xsiJUFAyeps7sWYqiePqC96ngPETaso/76b4eCwPvHlw1HX3FMjBtzkRN3uW0PO
	DViO7M/V9Whn/wqMKLYZqAJxWDAQm4Lf8rkbxfAsGhbum1cQTsePnrBHDD9WqBbe
	0TNfj8xvvQiNLH7dU43NNjoPoNWuwA+/8kl4UuWrxXPTe2TeqGJpOTpPFGLW2kTc
	OKXelnkDODIMi3xDybm/FLfYIzvntPUX8AhGiEYVVzfLpyEX9gwuv3ePFbtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792771597; x=1792857997; bh=07BdcqtpthOvQUVVOKqPGw8j7OjHrOKZ1X0
	jANnOVZs=; b=G8mXjfvAiinRz1eMinV0KCaRR9zPwjqpTxaINfV6zyXniOpOi/e
	CtUQ5OBLvdEUiePKSK2noL33fL3/+rBwa+5Tzc/XKNJzNlAVXpI1W3MJt27BTsVn
	rtK3ys1KIHl2ky0Qb5HhdrXepT+N7nRpZkYF9rIN5xzVU+RD4JQLtkCbyekr3z45
	l5pQIbQg4LJHfyPcmxtgX21FpGf8AIz0b4KYebIcRgyvhd8k0zQnStKwVGbraILj
	FbZPOM8ue34VkHpTXxe6jLxJJjh4rHR3d8QwPw0Rzq0mZUOOziutP/IsOPqA3HGY
	jDxSBlc2J5trLLijEFvA4h+ropsnz7+NQYA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792771597; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jpmBedOHN0UPGdCOxj86yMfFW/Oaaq7aMKd4G4WQdix9Np9
	CV4gHr63p+VL7I1JtljaeJYawncGb3FktzfhkbsBSlMywB789G4eUeyDzHP8HutP
	GyFsImQfKy+uD/75gEOOFIdBtm18WY5V6UM1Avbupf9+hTrdfNeUt24/mk1fj3hb
	EkkgUO0MGOtenwPJ7jILdOEVx2gm5wLgiwBFZYt+dPGAGaixbJiSq2VOFRcdoY4v
	Z/dC2KYwxLwvIf65+dILrJZZ0RZw3TzG0OdbQr40xQrW6QW8QHk12NSbdXzXdxaH
	DXFwUBFlXuEkSVs/fXfNX+eDNunPfPhvh6KfyhA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ihOMEglBgd4+MzpvELXHYN7mkTt+uCdlviDoYmfBgs0=:qOzcK0eVJF+SLcJHYNQQ3dXCfLGBwwahE6iBF5iIVBg=;
X-ME-Sender: <xms:DYbbahHqe8pz83ys12ZgtiuXB1-oHpIzGRWFk90zUDQLJC65HnfQaw>
    <xme:DYbbaonzhw9b2w8peGZSDPAm5w9dyuhNLQxLkkZ7Twh_b-mv1ePD1jIQsTTgy2gen
    Jsd6rfYwkYYQMG3U0GJ8pa4JaUPJIHB_lAdnxzsq9LJuGcKOyh2xA>
X-ME-Received: <xmr:DYbbalajP_0vae5epdKtIn9Dn2Ax0_jvPQvMUGgNfDSHF3imVhQuIp8fjTZF1erwaFztPQeIawqqFR546arMv1Kd-LYxzy2_Sx0d>
X-ME-Proxy-Cause: dmFkZTGylryrVF4Vb+PHGWxyDKXBgTL2pQ+siHJv2IbLbqmhyJh1XJYsVGoqrMB8d639pS
    NsAC8sMvu/dqi3019WG0K2PLzjLyn6zQ+lStHCP/4vn06CC9tPRkD9yz9epMpL+Dm/WQ1Z
    eE3f2wLDcCBG51otd9P2LYslhL8uyz9NTxnE5njSr9mA29HU3gcgaqp2vloy1Bnv7yuhfI
    GCf1e7csQRhloHkWo0ljIAfD52OHOEfkgwWQlDIYzDyZrzEfmNH64fJs60Ekl+f9VRJwu+
    CwEVwbczu5c/jUN+chgJWAvtFRmqSPLFVDuwztingRD48GfdPp8JLEWkqf7f7GE9PBupIS
    GcP4gR6dFWGU4tEvPNG6qhY2C09VA+8Gs7DJ2I+fBoWG8R4wGzFpLrZGfy386P/e8x7Lef
    cIThbao+msgbS/2TfNbBTJY4jJKaZvTYE2/toLjGvQrsP918u8or4Ne3Z/RD/LV5hayXg/
    iZ0SsoggzSywtG09MdLSJ3GmDRYK3XV+6sFS3ziD+WziY2c6RzzhO3iOQaJ352D5WE6lBi
    jWNoTghmRxm8CtTHdEvjRez8iLbOKvD2p3P5KzBkKDzbKyPcEHtPE9B8Rt1oFsdkFdgoPX
    bK5WwfTIthjt5DNpvfJlCVvo+wbTeGG270ELfmsZCj+B8aO1zPLSGdUwi8xg
X-ME-Proxy: <xmx:DYbbatE9z7ZwTYLgN67E3xS4AWCP2SbDHwUAvs-02q2Nh7enIiu-KA>
    <xmx:DYbbamLsJ4rrIRBHZJqWYQhdkzzr8eUJEaxTRBYy5DXLuPJHFyso3w>
    <xmx:DYbbaoMRBeoqgyiHnwPhqwe0aHCVvdBAapWGUkYXBjoKFkVqPnRd2w>
    <xmx:DYbbammCgmRb9w9gFLRc8neKUDfE-kNpP8zmUKMd0WKoPORcQosuAA>
    <xmx:DYbbahr7vtMvr3oF-qYb4zyvpSuyXhgL03YGrgUGArzx3EeRgT6-8Vo8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 12:06:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 0/6] [doc] Add new page on merge conflicts
In-Reply-To: <pull.2237.v4.git.1792764293.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Fri, 23 Oct 2026 14:04:47 +0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 09:06:35 -0700
Message-ID: <xmqqh5ic9zas.fsf@gitster.g>
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

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Handling merge conflicts is difficult, and currently Git's guidance on merge
> conflicts isn't giving users the information they need to navigate the
> process. As usual, the process I used to write this was to collect comments
> from Git users on the existing documentation, and then address those issues.
> I listed the specific issues we're aiming to solve in the first commit
> message in the series.

$ make check-docs
GIT_VERSION=2.56.0.rc2.6.gf97f562a2c
make -C Documentation lint-docs
make[1]: Entering directory '/home/gitster/w/git/Documentation'
    LINT MAN SEC gitmergeconflicts.adoc
gitmergeconflicts.adoc:339: has no required 'SYNOPSIS' section!


