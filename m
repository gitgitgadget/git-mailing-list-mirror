Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259495;
	b=LCQmOmm/YeQixfXUh5tucec6rJrw8KRcFYHaxupiWMPvOoyoO1sKSTTdTnPplYdxw8gn
	 EUmTOUUtCS9WSX5rS5bsMz+rKCWkIk7n7GB8Oj80gfCKTDJW/1jBC1LURwnNP6VCkOd3H
	 LD0rIRle0g9+jyQrkKOcj/+/fVy0TXerqAWRD+dkL9p+jKZ+aUXIv8GfqOuexiN6jRpBk
	 M6wS4YTZmN7CUJAm2+ZuhMPDkZSR4Szn080ONJ5zwMGhh1kZrQnsU82xOFQcsZmaIiqhc
	 ttKDgx/qyJWytpS6289bzg+rc3RB/Eq4PbQXFkQYk+qVztlK1Zz7u9nWgxz+f24yiLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259495;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=JrzIvVkzCuqrYWstZn0DZqEo0DF8vd6J8Cps3NSLXSE=;
	b=qPy2WUlDGzE90U4ZlDXH+83wf5upZYwkMktysl52XaK8dH6aoryfmXJvKS+2qLw/ajSc
	 8+zCRIu+2R/EMkNM6ECPl4AGbbrbFurmcCmxVlU2/7iDK8TdQ+0yGY8qhSASjJIQNs1Hm
	 0/3o+2c6FosS8YvSHDqTHzC3D+7P69ERyIJX53XoyU/7Jds3Q7ARluurZlpEbovnWWIDf
	 BvU/jlc5S9HVRPRxdfgobpEDbnrmU3bhsXBnT9NF0ez8L3t3AqvQedO67eAplUZkvaKdZ
	 Ihv7pyIM2SjcZcX8sHg7npReoZ4GxO4AXeqxPy2ORiHcn71ZYSyCuY0I/P2/crbb2Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Zqx+33fc;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=AcWjzyXi;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19560A2602
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 21:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C19560A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Zqx+33fc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=AcWjzyXi
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CCF35140017D
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 16:24:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 09 Nov 2026 16:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794259493; x=1794345893; bh=JrzIvVkzCu
	qrYWstZn0DZqEo0DF8vd6J8Cps3NSLXSE=; b=Zqx+33fcA21ilQZ6hqW4JGCym8
	68MiHLrq2VzSPL24cC8EGdJ4ZZJKHtJnW1Z5f2J4NtiK8IvXUmy9GWTPzROgSnxg
	nfTlfvggjmjiZLIQwQ51SiFSkXjVitfxx+zM7RoIOEegZmtqI+pQipfo4ysjhG7M
	N+UAPdC9UPEFStgyxLQU4Cpdh+GB/9x6Hb+WYYKnjDGYVLDPLK0ixKfyy15u3B3N
	0MVHs+a45hdKYCO6Ix6iGTCfv8EKXiusBmYJd2w4WkTyXjqlLjrge3tVq/EbcmcS
	asdHqiD1Fa1H61v+pl2d4IpZYYFxfKcMSIDjsWU9RJG8queKqyzZD/9ltXZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794259493; x=1794345893; bh=JrzIvVkzCuqrYWstZn0DZqEo0DF8vd6J8Cp
	s3NSLXSE=; b=AcWjzyXiACcNhRZLe9o7hsz6h5Yvn7buexrZUjzoktgsoFAPhUu
	DFmH+I1sYH+uSdXjH3lw9GVeMciT/0NNutIi4grZeUkjucXRQd8rgqOhAVJOFCEM
	rI2o+ItJWeBqstzhWns3XEuET/0dKdT2e/pbYUCntyx31BWTPXi3IsYDxAqF01/n
	qq1sSPHa3gKw4h7+HXZqE3Yan+cC3nQ1/R8lz651xtoEQq3PhqRwG+KXyRCnIipd
	k0o+pOVHPxSG3wpWAFO5itBlQ9MpQMA0p16M0LIMQFRhnax3c/4Ufhvku57euzVx
	pnl/PmGxkXXtSO97nJErczh8+m1CfpnEDxg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794259493; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:YHriviZFzA6d25phwnAAJkWVzvr3AMNBL+XA0xchF2uNKCN
	CtlLtR0xfB01vmmHaVXsvXwSq2HJTx0UmuUB2gMqSneP7LC2EjrCCcbmHwy8koQT
	oZOam7kt+U9ISvWJXQaDjwnWdzW9CaPfj+FI9NEXS5aJYMDYelfOcPwashjlCk+T
	vg7YZ/73grLqH9t/S85+btDBbFq38ManpsPaQE9zLV+tXJGdNhY+1ckB5mPCRaZQ
	XJYoTtdMgu11xc2T+RWT+r68XNTda2bPbs/uNIElNsjgXNxPXnDOlT+GgLhBNQ2X
	Mii1azLNMNlp4KPsbvm9ohgB8rwjwDK4S9+yA+A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:oafUSrwgRXiky115isuJoUhqeZeFT753pzR4xl+BQAs=:cCRBWnneLFvvTjMd7MzvJUFRHQVvRPBRlMMPvQrNOhY=;
X-ME-Sender: <xms:JTryam6hS_0y4TJZE_huy8BjWZ9qjL4-T4oLrLEYjE2CasuqV_PebQ>
    <xme:JTryau-KDZA8OaGBYiwioFs5OyeVX3d15dFflFSHTP0CTnj266wIqz9j_mIQxP6Xj
    a6XDyiP3TQcHaBG469HOohgu4ulQV865mYqPZ5rl1TE1JE7Nqgyj3o>
X-ME-Received: <xmr:JTryarqfd2owGNELiLKhjz6Bf1DSN_plVVWlG7rIgzYd5XO6bGZxtsWuzuGG-NYdhVfhHammRdEGC9jqtXu5ofTqoTFqX81KBJ71>
X-ME-Proxy-Cause: dmFkZTGoa4707TyDqfiUgsaEEuHC6pzLKb3VpLIHWSCy93TadnGXqnn1FyNmDFT+2PVRZ8
    vo/ZtPV6ZV/lhglL/Hh/hcjbmBbUNuodY2bwiXZj9+srPU0a6fqTv2a5u0e0Il/OSiR41L
    RAyecphgxWQrB8OiOW+Lmth+KZzxtg433tjSvPjej8z7vPjzeGnwxnG8KPDF+w96Mgt4px
    67YkjlROHcv80jvLKZAMSYvjInvRjN5t20TQRbC5NRgFFGOghOXSXxGzgfXnTVZM9Zk2VK
    wPidBrn3Z3IvvsBCJnsIm2cFraYa/QjSLWa8CyElIZN38MMeQVoyImRD0gWHefdZNBd/Mx
    PUSmV4gUVrQls3U4dae/Fh9Dodd/aXzbcjAYlpmzVHNXWph+trKCo2BogAr0uzIpi76Xv2
    BVHX6myn5Sz3vRaqkxZRSncqqIAkDXkgvjt8J9tFj4K7OoXeo0VEH5CftOK9ERdH7PZc6s
    uByaQIvuY4N3p0ckGd13b9iM6wD5afwuogtqG3ZwtY5etvtdcaionzh4V3YWGYIVlQ5GJG
    cEgInauQzCNA4jAQ6RSz3JlOXYEHn+f7/aNv6gsz1xRjU0DJV9C5kIEKO70rd33xx/as+M
    7sZpMRnUHFyG3ibl7/oTdsxbRf5Ll9xgyZEFcCI6DH5YfcKh/wh1m3H71xzg
X-ME-Proxy: <xmx:JTryavo70c5wD3NGGni4fJ3-h8vgfY7iyALk0GxVeitKWiQgJbQO6g>
    <xmx:JTryau2zr0lUHVt4J3fFv36TOS-3sTKuM9KFVEXQ-JcnSiKH6d6rag>
    <xmx:JTryatGHqoD6hvog3NuyD4RGwj_25_FDmbtkPQPwL4oF8z2uG0gV2Q>
    <xmx:JTryapHqEPStDklx0b5_J9tQjf1EVHkLTtnSrhjCsFW-a55-9wkpMg>
    <xmx:JTryaktTvhzpK7VeLt5blzPcM3MQTNNHgDEIuUpUtdkVpd4z6xBRWoug>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 16:24:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Farid Zakaria" <farid.m.zakaria@gmail.com>
Cc: <git@vger.kernel.org>,  "Jeff King" <peff@peff.net>,  "Patrick
 Steinhardt" <ps@pks.im>,  "M Hickford" <mirth.hickford@gmail.com>,
  "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,  "Jeff Hostetler"
 <jeffhostetler@github.com>
Subject: Re: [PATCH v2 0/3] credential-cache: fix two races when daemons
 start at once
In-Reply-To: <DMPJNBIHZB35.1EJF34BS6RR9@gmail.com> (Farid Zakaria's message of
	"Sat, 07 Nov 2026 20:27:43 -0800")
References: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
	<20261104-fz-credential-cache-race-v2-0-ddccd0831eba@gmail.com>
	<xmqqik2bybfk.fsf@gitster.g> <DMOCMXGWSKK6.13UR9RHCJY3SI@gmail.com>
	<xmqq33tc84rk.fsf@gitster.g> <DMPJNBIHZB35.1EJF34BS6RR9@gmail.com>
Date: Mon, 09 Nov 2026 13:24:51 -0800
Message-ID: <xmqqwlqlwvdo.fsf@gitster.g>
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

"Farid Zakaria" <farid.m.zakaria@gmail.com> writes:

> On Sat Nov 7, 2026 at 5:56 PM PST, Junio C Hamano wrote:
>> "Farid Zakaria" <farid.m.zakaria@gmail.com> writes:
>> ...
>>> was meant to say: I did not address it but I can if we think it's
>>> necessary.
>
> I'm not sure how you want me to respond here; 
> I made an attempt at a fix for an issue I came across
> within the context I felt comfortable to contribute.

I was asking why you needed to question "if it is necessary" in the
first place when somebody points out a potential issue in your
proposed solution.  If it is not necessary to be corrected, I do not
see why anybody spends time to point it out.

"It is not necessary to worry about this case because it will not
happen for such and such reasons" is a very valid thing to say in
response, but "I can address it if we think it's necessary" does
not move us forward.



