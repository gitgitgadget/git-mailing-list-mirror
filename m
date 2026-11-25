Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628359;
	b=oY3vRrg9UUkydTOEGISxj2ex/8LKShSDyEk24hYJNBDB7ZNBdQitmwuPa+hmVpO7smKu
	 cmePpOuZ7my2lqBi7PTVpSMk3tj29LuGJDnO4hrXsMKiqL1ce+F13S+qKPWsJC07w/xMg
	 W3MHcdlD/i4PIb1NDQUGQpvcWeSFw3Dua12VITcenLo7MABAmHOz2eF8zCRuAJzQ4QhBe
	 D0E7lximLWwNpvxCZG85OO2d3+Awm/gWbu2H2kocMoIhEdEgdIEJ86KlRQRRjPFEqFyl9
	 kfN+ptjuC/z/tv9vo9Mkh2zgdbvWcAdV41AAmqTw7O4gGONCiL7YlqDm6Gkyc+UCBhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628359;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ZU7meIxhT4XAJSsAiaYklloOgiDmzwkD5YVlU856U0U=;
	b=T8JLae5efwbXl3lH86dmJ2uH9Oqh5vNk+EKABqTco2cklZio7SjfF9ER84BNdzQtm8zu
	 yZUwK85zC9DlWLMXwnwUCj8V6qNVy885o1nByRr5A6QkNOw8JNxhK5PG75dovaMxbgzZo
	 9ty6iOzrNuNsrv67nWzZBR/TKPMMimI8Wg85BmgtNCcA3ChGrkYyBjp+DMIfytDy7hy23
	 l+0dmUducxSuMdO61nVE5p0xDFmWNfLpsBuTw1b5y4jbUYg+Kqd7KhpAQAjmoDR7arA6R
	 aZDOqg9CdJ4+pwAZtBjT/oiqMuhwwIvs4M4NOAdkm+gLWi9gx69AlTROdweGcb1fuoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="c/CmrONA";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=De2bwVJ8;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4E0606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 17:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E4E0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=c/CmrONA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=De2bwVJ8
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5839BEC0BBD
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:39:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 25 Nov 2026 12:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795628358; x=1795714758; bh=ZU7meIxhT4
	XAJSsAiaYklloOgiDmzwkD5YVlU856U0U=; b=c/CmrONANhXNAGz0dn20hspvO5
	yKKQ9n5WG6dd/kTtllS3qtybnrRwA9cViCXpP0EBMuQ+PkdMDN38NIPJ3hc2XLOf
	qjUMGF9Yf89Ki722bo/vuRN4hyCi+lRU4cFQ6yCc7i2+62f5Nad8YDMFktz2xsZl
	3ou6QePih3DJ2QJC/z/N9qBiaILgjp1iiaobpCbl4s4P/s6zypm3n+BRk7aDYP9o
	zGbtYzaUC3gTQ/S3V8/MZnnYPh/DgprGYFouiIQAuACukwyHIBlz/KJ6jJn12MHc
	N1itLWpWzuOWM9KUO9PCIcbvjPcQZ8M3afFa63Soe7uwrnvnmQrc/kGQhPwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795628358; x=1795714758; bh=ZU7meIxhT4XAJSsAiaYklloOgiDmzwkD5YV
	lU856U0U=; b=De2bwVJ8LLCkmfDoADRhe39rjqncwvUipjffHG+SiBiOVeIxktE
	7LUKrjFUn5KBPGEjCSQzsSTSAEn/srri5/vLAzkuUeUKN8pwLanVmVeagcYPpRQ2
	FNMLbEcx6QJGaTsErfO4FzpQE6k65ZhlW9ySB6yZBjz4yteB07XZB2+Wr2d+quf/
	rwd46E/N7A2Zzs9f5AD2R8HVxiubmqhAcAI8vXQWjteaAt5rDM7wdLB5ZPanN7Ed
	oqUnAdN6SO847HIhfRjiS4CE8ROuZeVJsJKRUYeeeeaKsZhD75wVHv3jvc/JcJ/4
	Fq93IUViFCc2lXvDpEocAkwFOFe4desdqZA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795628358; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:W/Yc7ljYsPIvsxR8tdGVSJbexgMd/t3t9+4zkuMZcR+dYQj
	ypOyRPpnaNX9arZy6bNsPacBHsTWZRvRbVnL5NHP8Zv34UWP13pc+qc3gGYltuZl
	0KPKgYPPhPCPD8uppB8db77GqCCHJKsFJYha2twyV7rzfZiu22kq7kLJUvHHUfsG
	bgkeYKpp4Cxlu9Aw9TFjQsSaJrxilW02D+wRjJZh9h3pmWVMsxfxsVbQP/H66tgX
	/Yv201uIF3B6p/dlwlzM0+f00ry1TQcmS97EhbwsQEqFvcRTAU/CXDD4JSFz6349
	lDLSJHNTI0kjypOAQ4loxyEZzNLexqpK2hAm1zA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:GHGquNjnd0d9sLp0e9eyww4UYAlmluQiP5ntNpmsFvo=:nRGyNb5AQVrLvDQQ54Pn2HImHzE7+X8onTSOhsh7gjI=;
X-ME-Sender: <xms:Rh0Ha8FSYVN2gjbUb6aGi7MdHS7OM9lrCgFWjMcYpf9QCgHH3225lg>
    <xme:Rh0Ha36CacuUGEXMR9UuYHXWarZWTfacAivwUU21RlmJvzHCfzVtFYO7ivgr2tbJM
    oS1MXsQuuxtBl4JiIkm6M4MU79UZREbbYNzhxSLDJ1Kjwnr0IHvSQ>
X-ME-Received: <xmr:Rh0Ha5yYb37nb4-epMw8xuAtp7VJ9V-km3-Za10WAWWCx5p0E-zKv9kK6ZV1yJtxu1MQUey7Xg5AzW74386xOYo8Q7mtF-8z28b_oNc>
X-ME-Proxy-Cause: dmFkZTE3EhOeqWmILKEUElPeeeufv6oO2OU848lllJSWYhf04/W6cbG0Gzjh5cN0WKKlav
    MTg0YzAnAR/Pa9PLnmh0EgQCm/yrMj4uRLDZ9G5EMIpIk+foLnwLlRTcyo+jDa93EKFGmG
    y7XLczlZ6RJkQ3hstI6WtjSVxLZ7csekj6L06ocvIe2jGgazpZLcXQBYiLws6gOmHRYwZl
    0OyzSK2kKxPF2qW4jLbDcgIvBXw2pDinBdIQFP0qu9ItaPvDKYq+UzLeESYgHijGjMshjI
    QPc51pp8wiClKImWE/+wAZq12S4ljqnyY5buxhspcO6pcbXFzMEb0vtygkzWuJOkdm4JPY
    RL7z/7M8b0iE9kZloWr+pNejwLQHCyD/bXZrFF8Ybd48HHdLQgmxaaWdyyDEKAOJ7ejWQW
    3/wTisclMCgk7Itey16wumZiZi8l4vRkaoNCokH3640WG1DYKkhCZQWdEoi5sT46C+FU3+
    /wf2WRCQCJQPEHxIZ08ZPdwT0mFi45NRlkqe7GtfDhQxuH8/LYtpK2amMcnJNCKG+QEdWr
    3i9XmCJB7+Ws1t4t4SY2TasP1DkdBp76rjPho87K7wL5eYE2oAAcEtRMFltGZoksFAe7+t
    5GWSQIw7/NiBQ3YyiZD4rbzxlyMLPEhC0OwtbSd6FM3f3Uf/cuj1e4dbe6DQ
X-ME-Proxy: <xmx:Rh0Ha-PX_B0pnDPP5CzYv-GhdFzEgSo5YFt_2G3B--cAv3VO-bc3OQ>
    <xmx:Rh0Ha3kNYk8OBlYF_NoaC-jQBsWs4-4kgxA4t469vOtm90obcwnw0g>
    <xmx:Rh0Ha7QoCFCLbj46uPZFxxNPifccs5Td62n8SFOsRnzsbU_xKoQf1w>
    <xmx:Rh0Ha-UIAs9g5fkpe4Jg5TcyIyG-EqQSeEXS97RPATNEhh-7J_CQFg>
    <xmx:Rh0Ha8_Ds8wGj3McSIS5g34R0D4sOjC_hVmW6tlklGFi7sjl2VuWPe8U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 12:39:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jeff King <peff@peff.net>,  Karthik Nayak <karthik.188@gmail.com>,  Shuqi
 Liang <cheskaqiqi@gmail.com>
Subject: Re: [PATCH v3 3/4] convert: use size_t for buffer sizes
In-Reply-To: <87qzg9rqmh.fsf@dev.null.iotcl.com.invalid> (Toon Claes's message
	of "Wed, 25 Nov 2026 14:24:06 +0100")
References: <cover.1793352943.git.gitter.spiros@gmail.com>
	<cover.1793439137.git.gitter.spiros@gmail.com>
	<1617177880b7cbde051bc4295f1fbd6ea2be457b.1793439137.git.gitter.spiros@gmail.com>
	<87qzg9rqmh.fsf@dev.null.iotcl.com.invalid>
Date: Wed, 25 Nov 2026 09:39:16 -0800
Message-ID: <xmqq5wxk7quz.fsf@gitster.g>
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

Toon Claes <toon@iotcl.com> writes:

> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> Use size_t for all of them.
>
> I checked that read_blob_data_from_index() has no other callers than
> the three converted here, and that read_attr_from_buf() already takes
> a size_t. With Christian's wording tweak, this one looks good to me.

Thanks for reviewing.  We are getting closer to the finish line and
v4 would be a small (and hopefully final) update?

