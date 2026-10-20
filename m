Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520781;
	b=4Xco5TVH+K2+9nbSjQrquzttFemjzHm4ZdABQuTQMzHN1wIuIb5b5Rj/bvfvjOrk8ZWF
	 nDLFN8+pkSp+sdCxeAUn1akrSrY3RA6zCOapD0/fpUN5rTwV6AX1aD0ekRvMpix7SEMTl
	 Yq6orE+G2VVCaYF1tDUmr0pA4UUKmvflupSsQ9J4c/ucdcPRYmY50zI6/sezJqRR8yuAf
	 LoXUOHs8eJSgB54Cu1iFUDEGeS3gygkNJoKBU2k6rwotSgKKW6SveZyan1mRkB74uhGPW
	 CDNT3zAvMDfrIxIkWIcWBcZaygmmlqv9WDmJPTZIQP1hYiGTEAeQizjvmA+FECgiErA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520781;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OT1rMqq3N4zn1180zKUDJ0hVRa3+h+3xbLQii2ho0Ok=;
	b=RUaG4AT9EFFyogvIM5qjDYBgZO5GAJxNJEjod3ESoDa+C5PWpFVtrEjmKqS4aYbw9Nq7
	 BYFHv6Y8eEUJUPPgmoWT+QlfCzXLT44U5BC6gJfNM2HmMCQB/ZyZLPZhUbVz+E8Vc3pI2
	 7A+zA9+mLLg1wBk5rWpPqefeh2Fsb1kNgxcKoQUPK1G4Fub35sT2VXq8HFrlFm2erEn+O
	 GFuM3VehU52bsCcZpX0yDGjkz0S0gpKnXOKwmTcHs0RhkndTBh+hePEY1PRea6Wn1WBsp
	 UvPQSU2rnJtb6sAtppOYxamY8t5hfJ9Fh6KIjJX7HPghLqQnIpzoSmM4toWHIOLpKkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="KsT/IIHK";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=V59R2Tcx;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A63606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5A63606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=KsT/IIHK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=V59R2Tcx
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F76614000DE
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 14:26:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 20 Oct 2026 14:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792520780;
	 x=1792607180; bh=OT1rMqq3N4zn1180zKUDJ0hVRa3+h+3xbLQii2ho0Ok=; b=
	KsT/IIHKN5YhE9i7fVhDMgRpwpsJw8sJHm/y6y9L69EEz2JHLHs8WjCmMw6qveK7
	qFo58TotgVOjfOZV1Ab05w5oZS6pZnm+CAR1C/LUlW7BDAUPtqzWIHm7kNO9loBv
	uqzU2As+9bt0k61Lljs2ZStKfYmMKioqdHektxdoHoItZneVQW2fL5t/v8TI1+ql
	FNsiNmqiRjPveHsT1j8911vrZUMhTqiuZEGb3dhZnglVpmCOow/Wp/akxzUHm8sq
	X8KLUGxEtkaIdML/yjhEdxZrRt2r9zNt9AbFidATdYuEFzcAFJX1KfM9Kj4I3mps
	xYf8/lHxLn3Aj6ToiD4t1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792520780; x=
	1792607180; bh=OT1rMqq3N4zn1180zKUDJ0hVRa3+h+3xbLQii2ho0Ok=; b=V
	59R2TcxP4E1mrc9t76JLprzdP6IyMWv5ruGTWCMqox9tGizpLSLsmjvm5L9A5JwO
	fqRmD+wBepYw9qbk4Lq+HuqsV3NRYRO73JIRr3cqbodAF7F9svShAFdUAgHWbB7U
	wFp6guUZD4LpBdvG8lJBlMrx+ooleSXPH92z3h2SBNDOS7OBmR/8HdmQsV/nnt2X
	6g9nPdx9qm4x+w/u2AX/S2INdCKGrJabPoL28kahaY+oR0rTV/tvHttZ9XIjfj+/
	QdShV+PF45RGbjbRxFPtzw5fSqNFDf7LW746B7p/D79pE0heVNKJ+CuoA40ExOBf
	RNVANomMLQrK1HFYi1wAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792520780; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Goxsc6dwXqBOJ1QuC7RGYEjcL85bOgdQz2kuPtsiLGXHGGt
	No/VXlRE6dKdu3fYH77BBcIooieXBBeAfiVs2mqGy4zFvSDPzHlkV6PhhIsxRblh
	c/HmHYFTfxbQQ8ocutSrCCSHVZK7KphiU61xZu+Pvzhh5KjBTUxgl1iGNt7xzmNc
	CZ+mgwavt/+TZBZFiarD1WvJCrA3u7aSA+mZ1Yxb4JhTxqljXZJ0sg+U4HtQyoKv
	8dAnEHNUICEQfyi6GbnNxO7p8O1EPRNGJIhviz6dXGIzHbAT9r/NB0tHkAmHAEwd
	DBQfVn/UBQu4Wy3Ql18ILq/M0PM9Fxen3A2XFTQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:bk2dv1J9RQU/23ex5eTfNHtDEIWNVfThRKBpxEGubpQ=:FhTv/3TxGlIL/QiE53UMfGhwVAmoqx5KLsD5cMCSYr4=;
X-ME-Sender: <xms:S7LXajfuWsPCEuKg01ST8Mmt7W-4DbsKAWsTCyouG8Sbd7DG9YT5Mw>
    <xme:S7LXagOYn49YATwJPgvV6SN2ksSuzYL2LXpT07EDJ6GSFsFm-Zo4XyvokrZiMZDh1
    yp5FhBCn9-CeYe8vCYOKZm2bdaB5f9oEovfpcrNXTLFp4cgrtyvbg>
X-ME-Received: <xmr:S7LXahh5NLTnVMd1MoiDcndo2HesFoplq17bq_-K-bOGP68ezhL171DXpNJ6becSnVkjwTy4rgqATDoKCG1zEdHIKf6dO0a43SVv>
X-ME-Proxy-Cause: dmFkZTG2IH0SWVwHf6V4AoWVQ8RD1fi7VPZhuMytPe//Fl4mtUL8GVAxzfzvx+dstzvaa/
    yIe2H25+b41mItkmIDTMdHJohq+LQKz5OwCrqzYSnL/nru4A4jkntsnPDVpEzICNBH6gGm
    YCniLEwB0OXI7UejEKmUps6RbGZt4okeW3rLg2T2F1mo5Vohwqyoff8cka1Ubhl1SArr+2
    0BsfuCddgwpa8UACSzFiC5aNnfi3dlKADSrlPL0MvU7c3yFnSnLungZCS4bv9/t4O9cvnW
    zXNWaDSvl0RMp6nupGu0yvmeOvc69SmfqdVg5GB/ACCo/U8WCsi2W9X0qwweUpTAICsAIC
    zdvKeg2jmLLKhxfCYWW9rcCkx0V9oljhuNirCgdhwBpFlfyzP47oiP2UtLHDuR+kF3FNqO
    udAx/ZPh6rY/0QWRBAgXADy+8lEa0brwTgOXtlQ9JOVUD2+R7pcP4LAZPCIf4ergZ4h36N
    i3TKBcX0MQqhWJ3MQXANbrKMZg8yiL/L0jx0jl3CXByViSZ7JN4bCmGJQz3OOCzvWCFxap
    my0UBoTH+qwM4tJbYQ1ek4GogI0XYXS82RIZK4sNzysAGSwCSv2LzrTQCBCi2DveHBoJmn
    HseR7Y14WEsTKJgId6KNxle/z749/7ThwSKmQDqBaw3RCpUH0bO1WriqKhTA
X-ME-Proxy: <xmx:S7LXaj0tYyqi5EcJhvRBMUg60_JArlavPloHG8kVWRyzsW_2vfM1MQ>
    <xmx:S7LXarhGXG4HigLJ33kBDmdkuLletqyAjJK4WubTYATjJ_DKpB074g>
    <xmx:S7LXaje6CfVuilFfTKnEuMD3zCoG2wdBF5GNsAL2h2gZuFtG3ZEv7w>
    <xmx:S7LXaunGEPfQq6XtwOT8agyZ5L_C0KmdRqL5zmbQc02dE_Zbyh_YDw>
    <xmx:TLLXalDtqFdLV25InhYPZDsa015vVGW8hi5A7aL3fmkDZ9deHVhEph0J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 14:26:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Julia Evans <julia@jvns.ca>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
In-Reply-To: <CD1E58AB-4884-4433-9AB8-460FE9A882FC@jvns.ca> (Julia Evans's
	message of "Tue, 20 Oct 2026 13:59:28 -0400")
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
	<41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
	<xmqqzew8wb3g.fsf@gitster.g>
	<CD1E58AB-4884-4433-9AB8-460FE9A882FC@jvns.ca>
Date: Tue, 20 Oct 2026 11:26:17 -0700
Message-ID: <xmqqld7sw7na.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Julia Evans <julia@jvns.ca> writes:

> From the release notes it looks like ed25519 has been the default 
> since 2023: https://www.openssh.org/txt/release-9.5 .
> I’m not sure what the default was before that, though I also thought
> the default was still RSA so maybe it was RSA.

Changed in 2023 in upstream likely means many users on mainstream
distros may still be using the old default.

> I’m inclined to suggest that people just use SSH’s default, since as we move
> towards post-quantum cryptography, openssh might change its default key type
> again, and if that happens we’d want folks to use the new default instead of
> going back to ed25519.

I very much agree, but (1) you described that the goal of this
document was to get the users going as quickly as possible, and
giving them the securest possible setting is out of the scope, and
(2) we would need to think what to do with the example in the next
step if we leave it the default here.  The answer to the latter
could be to update it to "something like ... but the filename may
differ depending on the default type of the key".
