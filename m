Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792711043;
	b=vOkJdo0QKoFdb7/RkK2op2O7HOAG2CZp2PJ9dGRBY7X2hGkFc1p/iJXvwoOrGdaP+F3U
	 kJ/voJW3PphswjOt/cpaKwYBzeEBg4ACi/ifQ1L9PRyiF/jUSeIbCeC3/Qh8iaqUafjXd
	 SLttVGOYqABwr91eyq3hoUo+KMYUNIShV7aggv0tb46y4dep/ixEw6P2C+REjWAp+bgNb
	 ISlUDXn4TvFzbVGtSOEY1kza70yyVLTTknb7H7fDfxaQ9zGQKh+ZhHS44eGPWS+Ga1YyK
	 tmcAP+u1+NivJmbwKmDqt57TajSojTViqcXATsHufFqfJZTDgT7Hs8BDsNvwF/ONIqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711043;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=iKBB0HT+KRUx8Mt1gDtXEyxsPj4KEeSzpFiEklzr9Y4=;
	b=1j8TRX6yN6fpTz2m8nb4e8RNs8C6PBNSj7/1IooHGR2FupdDVnIx/0OLK43rE8Er6eq2
	 IrdfqfFEgEAKn53RLw27nlSQObm4VkOnqoE1hlKB7eW2UbtOJWf7Vkst1p586BQroKrOP
	 dtwQNF9vjsU+4Zlkd/396ZWNByeZLpc3uB91wEhRd7OX1b8oFA6DqnzWjK8SkSWXuDL10
	 ylyqco7BrWcGsdGkbHCl6llTUjfFY6tc7dvxuTdWIFKw6EWrU13JhqBu9okqifwDvLpeY
	 BS/o1E7S3lw8hTgFVev/WS+aHf0VZ/ko2AjXiscUqiUkL/5ep/TbHU4oTOVhmD7tU/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=EakDFgdK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="KiLN/+Ky";
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63B0606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 23:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E63B0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=EakDFgdK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KiLN/+Ky
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 387CF1D001C4
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 19:17:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 22 Oct 2026 19:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792711041; x=1792797441; bh=iKBB0HT+KR
	Ux8Mt1gDtXEyxsPj4KEeSzpFiEklzr9Y4=; b=EakDFgdK7n1b+7PsM3LubrnS/h
	l3qx1hzUXkPqLuERA91UZMfZhwyL/oMAeprF1+BBocEOop5RqSf81t97Kjcp5ncw
	qiF+jX+07cu8h4MLWpsR5lgw2gl29wlkqrJ/dS07BjrB5j1pdPhJHiIVIcXxa7+l
	x2M4NxLktVjjFz58BvpWPaVjCxXDhOqLZtjkoN5E5eiHx8J/Gq0uv+tB1sqXEal3
	n4Z4llJsS39mU+g99ISFvVmtdk6JvDTtordq/sqkyUCdfyZVSeHxyvYR1hhKkJUJ
	j2m7yGphMd4Zux4EXVeHxb439ORXtEF1ooRc9N/0bmWqhxHEiw3acbZ8FQZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792711041; x=1792797441; bh=iKBB0HT+KRUx8Mt1gDtXEyxsPj4KEeSzpFi
	Eklzr9Y4=; b=KiLN/+KyJurPLQRTvGc/XBk99IwobWhj7PmZ06/0qxJOx7X9nE9
	1PTzjQlMB7R6P23gUtANeiMcawsCIP8Xxi4V7pUtZ3oCm2xmjsSx4yxU0OBOozo0
	ytpVKVwh59qEZXPh2E3IqxwzP2zjTCdh1hPSSTF0rMs1/uDKuH2d1i5lkbeyKgK/
	iY/8xL/E0md5rC9fkDCPzVUhTpwSGhVDLKEn/sHVCa+RnGBYcoP39/XlVmDyKagF
	uUDoGFHiOP+h8PeIA/j/ZYFwlTFHnibwhRCKZVstlJ3BGsOPabW9Cy3ERaY35fEo
	zwt42t2or5RnJ2hucS2U+8GYb2Lbi1Wcmew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792711041; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:AwnSPdWhHESBqt5Yy4qpu69iO138Y4s6Ttt3CFN1k/seJB/
	8RdGaj3lBnm+xOc0RnWCDZS/3Ghn66vwB2TRp5RO8QjkAjCOvUHik+pQP8kJQM2r
	oyI4JBs5MaD8jR0JoiFE0TEQx7Sg9kwI85kmEFfO8q6YZb3+izhVOifYsgJ98bZ+
	wb1Xly9J4S95UQ7W4BllvadKMmKT/hz81Qrag6ZjuXWkaw0xUAamF9deJkDBk/3F
	xo+bsVQM1ibCy2fC5ZpmDW3aGsgB9uTMOTcH5oW4K/TPPtWK8t6++6K0XAcBmLea
	wqdfajIYzJrKDTa1PlLXIz6Q/fYOfByUZR74+4A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:02g0/5Fbj9NBw5+0MyQKzn8GpM7LBtRSvWpH5QtamTo=:zkFK6R673s6eCE+S8rTeDapE+2exL6LnUPOBYoPYkQA=;
X-ME-Sender: <xms:gZnaaoPGsYJNMXJKprao1J1MKIl-I0yQvpJvcKr3XVDuuCymcdKmvQ>
    <xme:gZnaal0e_BPx8Xaos6Y_bTwbXND9-ZdIe7wQFY7uvvzGclZ3VVC30xIYU86SWHJLU
    TTVdNIhf0kuIjgBcqbExK2j5KQz7VBFUuHqWBom2jSuima1ZxLj4aU>
X-ME-Received: <xmr:gZnaankOb0xVndJNbse0OfGursEWP7-oyhUUw1yKr5OI2e3mI3G-8eSyZa_2B1-BfYJ0fZqYD8_04osR54dDF-yWHw_qoG9NgPOi>
X-ME-Proxy-Cause: dmFkZTGtJQSAj1UXMIJVwZQBXiWmqgvYeCTYQQQEw0zn90yw2DEB6tngadNmO3Zae7aZsu
    1jba6zsUJfF4RwJLRCEbIqDqFWT5354Z1fHwF4V2w6MungWG+HRgG5AkcX1IVOf1eQWFAz
    6/4BYG/w7eVRnJji3OGOCHI/B6Vvnh5Fh0rXiCMQKmD5Kivr9GN/tCyjanO8s5/0rluWrY
    U//megc1DC5mPLaZtSU7S1M2OAMBCB5gXHaLTHnFpF1DHJFK3/KCZBG6ucUvNHLuVtTXDy
    +esVSu5B0gIANhcyNwfvSpNg2scNYMZBwDSX/fa7IBRkG1JOflTG9kGOuSWZaqcU5CW1X/
    i+entNm6qcT9XsbcOcYeDaes76jfzoFTAeShO0vshTlM+fH36urST36wO27ESZoJ+DdCgj
    aCfkaLwLzOUtdvDYZ39zY3+dBUSkwQlv33OMkhby4cMnoav1fU336fDPqbmi+rL0w5UEhu
    NN19ug//D9OoMULEWES+SSQl6pI6RmZKDZ5+X7J2aF2VcbasQNcets1+1uDUEkDRkewKcP
    sznzzmdk2GCjKQibNYwR1uwBFPYQYHoPLjiM/6GFd5IHoN2TVuoUQ6s+UdBSo0t+htFxr4
    jELXsV8wiBu5p2aU3rTiKUF9Gaa2hXXOjrK+QDSvMTop6nzqKSXGuY//IeSg
X-ME-Proxy: <xmx:gZnaasUJdx2j48FRTuSTLLMFlVNahakFzwqjqv8Uq_zLPlRbu38IXw>
    <xmx:gZnaatvjJ4uSWMlkLIgJrlygLZ8nPjmhoAVzDoU7Jluyo2KKrmusVA>
    <xmx:gZnaavYfkxJ7CfUSKaZve7aYYhYvQqBJhvPnvscBdX_9qUMg1RPxkg>
    <xmx:gZnaasXnXDiGefgiXRiKVEnfep0GqzAueEREVvIkWprHTkY10eX74Q>
    <xmx:gZnaarirBFcl0hHtOojGsOkazgNxmQq9G-CWLf5EdIEjIMYikLQJW4Dg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 19:17:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Emily Shaffer
 <emilyshaffer@google.com>,  git@vger.kernel.org
Subject: Re: [PATCH] Documentation: propose community voting process
In-Reply-To: <atqTWKaRQfvH0Xbm@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 22 Oct 2026 22:51:04 +0000")
References: <20261021200341.378978-1-emilyshaffer@google.com>
	<3fe1dc57-5bb2-4e12-8876-a4969e5201cb@app.fastmail.com>
	<atqTWKaRQfvH0Xbm@fruit.crustytoothpaste.net>
Date: Thu, 22 Oct 2026 16:17:19 -0700
Message-ID: <xmqqecdhcolc.fsf@gitster.g>
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

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I think anyone who was at the Contributor Summit or has read my emails
> to the list knows how I feel about LLMs and how I vote as a contributor
> will not be influenced by my employer.  I do think, though, that this is
> a reason that votes should be secret because that prevents people from
> having to prove their votes to others.

Thanks for raising an important point that I did not remember seeing
in the proposal.

FWIW, I do not parrot the company line of my employer, mostly
because I do not know what it is for each week ;-).
