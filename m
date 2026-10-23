Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741325;
	b=rmeOhanO+Ni1XXk57POyOJlsrtNA5rU4ApgWC0pF0w6rwPN0c6TnQUWFDsnj1R3pT/6R
	 +exKZWcakm0aepboT6l2NF9ALa5YYQ5bch2a7ZxpMFNBogQPWy2aE1o3wqM4fy+8PCcX+
	 Kw/tcfwne2p+HhRmSVTT7qg9c95r/faiMFm0ZNLSvO/T8dkT1p55h/LYKAcjeBLaEZFvo
	 2OVQCkqMcQe2Ao5L9zwte8SCU9GTNBwusXaqZLx4hcll/h1babAGcnUvlX+gzsIPMVObn
	 /OU9ZbZq9X+HgBTlqSRbs5n8vIRquixIKMlfS8XMmWN6af60jFKZpJ/kt6GB9j2MR4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741325;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FqXOx6KuEDnyxauu1FqtzYEH43eEmRWrF8y8VLW/MfE=;
	b=1bQ1O6RIVJclPLTO7PMaqLAL3oLkMCz8TXtgLxsApHJRupla9ikWeaIJZhnFKCYEKzZ7
	 LMHcuw3+FCC/qcaVdBVGow3tAq2O2MoooUbqaDefugh/u4q67qeipnh7sju8iDFx8IdPM
	 QwWImHD6qVrGZS7azgZwUGeknV/ERFflsQkwGoAONkPwuswtSanVdJyPe5JfoHpuFw68e
	 8vT5nf3trAq/K6K+xJtJP0Nox1dawD9IkfzhsZzUSIc1Iovc77IAeqHfbbr8Ad/CzXtn3
	 kbW/TRyTOybHOchz/18l8ws8qnzYKWrLWf6PgoSL/276bVpmK+G6w0xYGwu9Amylh0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=AJ0BTHr5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qNEeVCX1;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61219606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61219606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=AJ0BTHr5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qNEeVCX1
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 92F721400043
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 03:42:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 23 Oct 2026 03:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792741324; x=1792827724; bh=FqXOx6KuED
	nyxauu1FqtzYEH43eEmRWrF8y8VLW/MfE=; b=AJ0BTHr5ZJ/BLSrH6E0y2fRNhy
	WgVZ2KE6MqM0ArCfEa62PJXpePeeAaAzROyV4J8D7j60WxXup71riBs8H9kx7HMq
	HPjHVZkyNXqkJLIqHti3ezPLHCUQeKgk9+vtiV5G9L0qO7GXIjScRy/MJ1Fyc1pJ
	wxmzC+RmXFmhmr6oFbcSBP/IU/rOu2T1sYYrEM6MIZjc5IHGps8if4jOj+ronKIa
	abGiFM1L0sDh3ytn83vSl/I2AwMa1Z6TS5/PWfbIfYu8cRsP5zrrh+3uJnJ/7Acf
	FKBPcvWtznpRMY4blmedez+fMYTjdPTulpUJXgvPFAI/tQYetL2E1pR/nDtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792741324; x=1792827724; bh=FqXOx6KuEDnyxauu1FqtzYEH43eEmRWrF8y
	8VLW/MfE=; b=qNEeVCX1Y9MW8aqsJvywB85QUkk8Cap0w68/DxEp0IW92k8IiBR
	m+TgL5mlDm88c43/YQPInRWufr2kBoAgwB6xznSGxynZoR+v42FW4PTbxSCBFqaD
	82BugAF0yPCSpqG3DwjwMdUqNQbFDl97+IqSS0nmE59JzKUqK4LLCMWwWSKQtH+M
	Wa7mlC44MhbE7sk+siVxkLAP08b63NhBEVB9q2bEmcfBa/qOyq7Nt7tpJLoCrBQq
	jhgKO5Pl7qF97RNwcJgz6Q/aANmC1TbmuZfxoWJu4THUYK7sivJ91WvJIRYgFiEa
	GoJdEhRMKzkhVj/wEPKUxe8bfCciFTN5/4g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792741324; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:sB4yiMvtrtL2cDwP0Ci577893Efe19cvrVZV8zocaNB4Qdi
	QJ36q1xAEWMz5bcYalYWO2DEje/E6i+zcx64X4S4nR/uNzpK/TSZih37eDGuVBsp
	gMMmlA6EdGXsfz1iIGRj1Rs0VsEWxm4m+PkiQE4uw6oMWUAYmcl+a5hexkjRtRYu
	fyehVdqs88trh860y3gZ78XnsWdBNi2SsJnP7L08seX8QZU3YZdA/KZeXwsEE69L
	RzWsEeUV6gGSN9N23CjRkfkjsvmRJVRbKzltZS2a62SE1MG+s1QHc95KKcrVu3/5
	4RCWEGf5eMDmp964Iu6FB5c1ko0zxcgQCMyVGxw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:bt08sE18TVcHUPASpLl3xJVT2bNGwEXcOzbPQ+NQTEY=:s3dZS4683NmWhZcWT3Y22WBi8+grW5k40GyVlWR9iX8=;
X-ME-Sender: <xms:zA_bakYprd1nVC6z5V8GSqNXDLegU7cUC5HnUjrQoGk7y4j7CU-nfA>
    <xme:zA_bamY3hhmowx-XYYc0v-8E-C5Z8lZ27Xkg4TvCwdcENZC2soOPfRM5G8idCH_4q
    0ITW0OfXp-QtkTWAhRnvva10_DScjdjDiaj6SbDg9nqeYDeaHjsaYM>
X-ME-Received: <xmr:zA_baj9I3WfiyG8FXOaUkNr2iHVP2DqS61GInshY7A1iXvKFOFmpQrkk0JwQJBQMxMjvZg>
X-ME-Proxy-Cause: dmFkZTFGRgASGGSMCuP1qhSLnRREWeMs3Yjpj2ZQBJa8kbDVqF3OnQYagfXSQeATUsL+ME
    mB8EQccRDceGEZE+49/Ru4CG3gOl8GGpO0EGidIrKLJXlQYN0uwLNaiBFtzDgVNvx02qga
    DAfGNhZoS5KG4sFQ6SI0R65g8yVnmjiaCZG7LUF0QB3zYlIIt1eX93mggc+odDcNH2R4E2
    NdH69ItwYD+Jku4DnnMqMyVSEzvI1ReHij87gbU2mx+6jenxGBd7RZVCThxnNnyHZxeppS
    qIf5KHqObb+L8io7MM9AKROZE3LYckLtTZ1FraXqyrlU5FKCVzo15IKOEewNM0c13XS/kT
    GGKhETJe0hSYhQRiaXpaJ/3SkXt/+kEIkl3UrY5wE6YAJv9fFkMHXcBlesy3jCW3TBezK8
    VFFujeKR5e5Q9UR1Moa42f49Q2+5acM1VncJVDD4FfQnnWCtaJRDOSB7/Z9qbN+bIrf4gV
    TyN5JslOYO1YDLNPMy04uL6DRoqW0k/mVkLQlEogTvOtvwC2wW4IVKI75FUUY2yAC+BiSn
    HkvESXwYb438MIaK32bkU1ChKSF5MG5QFh4lg4qBkzE/UdYA0++Jmacbx3wGX4SEvfB6Tg
    D78pI3Kp5WgVL1v1A2U79Vf/w1tMZphicOQM7j1oSZAVgAFbVmiV31Gq4xtw
X-ME-Proxy: <xmx:zA_bathqVB0Mgw4VqD6utTrcwR5a4rm-wLs9TTeKaD09tyX18YLK4g>
    <xmx:zA_barfDUNHzZko90gPgj6mM8T57P_7LFViTTUDxLmCEQGoxDPxWXw>
    <xmx:zA_basoMhBzqWFZA9erOlY5ytdZjE83ufxIZluhUSgk6_-IPjJ53jQ>
    <xmx:zA_baoAB2kWNkLe8S8pUzW-UNAPWlB6AiO4qM54VJ7bPRUcXVRNBGQ>
    <xmx:zA_bajeTNrMcbULvg3nkh9UXdLMMMB8jZmm7BHy2HpUh0fTiHrTY3rfJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 03:42:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e4dfe829 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 07:42:02 +0000 (UTC)
Date: Fri, 23 Oct 2026 09:41:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 4/5] refs: stop calling root refs pseudorefs
Message-ID: <atsPx0Wn9tyMzpCl@pks.im>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
 <20261022212903.177261-5-andy.koppe@gmail.com>
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
In-Reply-To: <20261022212903.177261-5-andy.koppe@gmail.com>

On Thu, Oct 22, 2026 at 10:28:52PM +0100, Andy Koppe wrote:
> Some messages and comments in the code still use "pseudoref" in its old
> sense of any ref outside of "refs/", whereas the glossary now calls
> those root refs and restricts pseudorefs to FETCH_HEAD and MERGE_HEAD.
> 
> Replace "pseudoref" with "root ref" in the help text for
> "git for-each-ref --include-root-refs", in comments in refs.h, and in
> comments in the bash completion script, including the one for
> __git_pseudoref_exists(), which is also used for root refs.

I feel like this sentence is somewhat pointless, as you basically
just explain the diff.

> The function
> itself is not renamed. There is no obvious term covering both root refs
> and pseudorefs, and the old name might need to be kept for third-party
> completion scripts.

This is useful though.

> Update the description of pseudorefs in refs.h to match the glossary.

And this is again info that can simply be dropped.

Patrick 
