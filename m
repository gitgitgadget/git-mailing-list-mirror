Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257680;
	b=NlbtA7r5eh4TEcZ/HWFkONbBHUiYTf96+uq18oPQmx7XogmS2WrNW3YwAi8MoKACRJwE
	 7GLNHQwRtkOtjY/WKjuvZ7c65IhMXGv4jFTAxzYvUngFU51ej6nyvIISv/rYuIEuQInlI
	 rBNu+8Q03/kl+sHMctH6nvLrltmWkNtBvXG9cRT0kKfNNrUffOUKn8r15AEcawmfH29Wm
	 5wtp6/Hb+PxFdvP48UZ/QB8/egyeJFKELGrGFZQvYr09y71wO/Eo0DxB9M5CvkyZggcSu
	 Hn1837ldDsohHs6YZKsRdQf43eJJTLWCJALuoZMtRTj3vKYcNyj+1NelvB4RwWpBccA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257680;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=zn2Giid/aAN9oCOOqfFF6tEvdf8SKBcry/0LvLTEJuc=;
	b=oOSERPbIKfcCUo4eTZVa8ax2s8bld3a0mYKygZTeyUpl07OoE7x1db/kfts64SuP5X/5
	 1McOJg3lnQ2EtDmTC8hUY0Jm9nHEJ4N0hW7bc9Sr+tnxt/7Q1rf6JNuQu2EIpP121rmZi
	 jfAcz/MsudIUd4XxqmW4zKfsp6LdcXDISdo+aWbhyaQZWue2FWOU03P/ACyZ3cgDMYHCN
	 tG/EZ4T3Wp0c9q/qc75s/9zimHY0loI1xlzzq8YoljIYOSg27wUrjBxZQDo/edxWoXb5j
	 kdviCNgZ8LLehuzPgQ1EBFUDRCRzO/nDg7iYJQaIih5Ls4p0GYMldHbvEgpYdxiCMDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Z2l99ohp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NqyXKKqh;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807A7606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 20:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 807A7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Z2l99ohp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NqyXKKqh
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B89181400017
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:54:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 09 Nov 2026 15:54:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794257679; x=
	1794344079; bh=zn2Giid/aAN9oCOOqfFF6tEvdf8SKBcry/0LvLTEJuc=; b=Z
	2l99ohpVKJtYB1h8O2xkbzAPp0fI3RKdlnEsrg2+wMD5VG+Ghk+Ew19/TPzm/qVM
	dA7Xh0uMFuRUwXRgckSmcTKiQzDyOIxKpZNNhAuPys6iOWEBJWkXcuvDjnDHhJhI
	xXTTZMp9LGVpMz3TbgXGb+5GdAA5aUhbrUmEul3LUSL2eFeo8ZYniZGr84Vo02Ub
	WrWwfZV8KyWTVkkDP4mWg57ll6H58XKNSLbWmHYCFV3SEOyic72s4iCm5dd6o8nd
	59bJO+qYZfyoHQo2V+jPhI++wVsJLAfOLDk2aqmTK1hDuXmjhOl5iU8JT1yUXuX4
	HFgsEmNGqjNvMkTOpwDKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794257679; x=1794344079; bh=zn2Giid/aAN9oCOOqfFF6tEvdf8S
	KBcry/0LvLTEJuc=; b=NqyXKKqhCcrQ3/FzEWUlZqBaHrTNMaAROEhSG1sASVuD
	zfJvBxtf5UbPcAQOsSz25j6LT1/OKqsCd6yKjUy3r18roG8ZLu/H55vNKa8VmlBf
	yeFrsRPO27972j4OhbnExqKOWm1nLuxo9KE7+yF+iMPzIGy8WQq6QjwaDncCnRF0
	08aYNosdTEQifg4Fq3k0IkTQ/WsU9mbma9UMiFK58JjgnJiA+OJ8Lxu7qJWIrcTn
	bF3DqrDzS1BvCDtvwNyu0bbCzZzIT3yI+MmSsIfM0zWOX5VvF2QS3jwP3onwWH+Z
	DrhreTzA5mqmoNjgZkILAiwmr+Cg2ZvG2QU9+h41Ig==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794257679; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:YqsHEoOPoPzMxEqzzxdUU1sjZdxk49LKyYWc3oZ0l7ecDQE
	iaz2Y6ybpPxhRRLaYpvqLI48p+l+7VOLdtef6G4nSAkv0naeRIZQJ7tRatvl7Ela
	HxzsD3qgr2dLVqpFBh2TVq+pF15jnmE2OjRrVXJ+/MZlsc6HViE5uysQftAWadkX
	GDc5hP7pK/657OVKbcCtqG9PnwRbYeoOTECR+W26/8pyDu4WA6ZPUkCF7t2khshE
	jCTRzX/TgdHEzeI6W+5JkcpWiu4EbzaQ3gGCATImLRCtwgtLs4b9tmDzU7PjV0Pk
	ntkb6dbrxptmqpptOQkp4yRT1xtOzhzc1gnJS1A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:GJByDsn1feJ+gxDAhqK2T/YvwDyCgVnY5Y7c6Mk5Utg=:Glm6Gr9OUZef51kH/lLBOPszOukKFr0/N7ILmzjAozs=;
X-ME-Sender: <xms:DzPyamrglHdYEYs3os1Ovzv_5FC0iMjWIiTLWDIoHorRVz6QoBCNcA>
    <xme:DzPyaqpoTlLTrj0e7PVf-g3htbVsLXN6z7WAGc1Cy2cJ0HrczDX_55PIIayEwgLMq
    rYDq9W-eWHUKkJ-UOkTbDux295RUc1rP3C2xa1LDfBYmTC8v_SlNPE>
X-ME-Received: <xmr:DzPyao1CbJp_jJpB7uFPJUzBfuUZmev3trwwd7qUWVzqkXE4QdKqP0rqLWCbAOGOcOjJk4eNhkKH5_1bdAz8ebIJJL2W8Q3RtECS>
X-ME-Proxy-Cause: dmFkZTEFCjW3xoEOxHFyHXRVVoOX7vKKhfEIzfAKppZdi97o1Doa0qu8JXe9wX3mS6Rz3s
    dwsgWUyHVWTFjewncrIdPq5g1z+ODh2ljA/W7KL4XDNq8JsUD44Y0VluaB4xFwdZ46VkU8
    U2NNm/tWWz2ewx8suF8LzKDcVcnJPNh/rVoJAL/lX8hJqep4Y/FU4Mga+21Nmtze2FzyV1
    AwVnNKvTokqQDR3tFrOWI+onBpq6tY2Ls5oqPxywmrJj/d8FcYEdvaCVRr9HKQIWXrdBSG
    jq7v0QuuCXsse082+sPuFRInjLHnIHWEBalFkPxMhG4HBgiZfAzXhxetyZB8sw6eDwRyTE
    e2RS9b/54y5g6i2t9p8cjJff8gzLE0vd9ifpPy9YKsF+eyZpPO/u8/ndPbY1umRX32O4WF
    diBJK7dXwvrdZvD/R4GsiX1fC2lmNS3+cdsV8wd66VhuJtiKStCLbmN/h8qLUqvorC14d3
    thxzV5mp6oAemZRRSpYkPzkzjMLSV5ouZg26YYRkyqeivQYMnOd+/Abyb4OiJLydoClRk4
    TJ7eeNuCbsBebm6pElwlMlPw5w9nqETFvVSBkZIjBgLUYFq1QMiZiT/zgUGNS4MOnLREsm
    +6QDy19Zm2O9fukLJhkBYIn4mtgU2GXn/wu6kgpvtICdR+RYOeyTwLZkW4tg
X-ME-Proxy: <xmx:DzPyahBNucvl-E8AuChK1-moO6qZyZv8H0vzEKBKrAB385s0IjDqXw>
    <xmx:DzPyaoetqA2LQJxPSiyD8S8bHS4aMV4zGlhfUHRhTsp6KiKNG356qQ>
    <xmx:DzPyaugXxQQuc1GBhD2C0hktFa-vC9wvrJajuQqEbyG-jIdkh-t4Sg>
    <xmx:DzPyaopQ2jDGaSQRTb6p8MMBhKvQLdadNnU9IiQssKYiN1aurNs62Q>
    <xmx:DzPyaqBrBPDO2qWTwFlha1LQlKek7C8rWExKDqr3UjRNjMCJifGs7pNS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 15:54:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 0/2] unpack-trees.c w/o the_repository
Date: Mon,  9 Nov 2026 12:54:35 -0800
Message-ID: <20261109205438.369060-1-gitster@pobox.com>
X-Mailer: git-send-email 2.56.0-626-gaba6dc7e00
In-Reply-To: <xmqqtsltbfdv.fsf@gitster.g>
References: <xmqqtsltbfdv.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unpack_trees() API serves as low-level functions to implement merge
and checkout.  It heavily relies on the_repository, making it clear
it only works with that repository instance.  We however can use the
repository instance pointed at by key data structures passed
throughout the callchain.

This is almost the exact copy of what I have at 

    https://lore.kernel.org/git/xmqqtsltbfdv.fsf@gitster.g/

The only changes since that version are removals of two blank lines.

 1/2: unpack-trees: lose USE_THE_REPOSITORY
 2/2: unpack-trees: consistently use "struct index_state *istate"

 unpack-trees.c | 180 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 118 insertions(+), 62 deletions(-)

-- 
2.56.0-626-gaba6dc7e00

