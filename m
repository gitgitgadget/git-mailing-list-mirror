Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792453648;
	b=huIjlspEzVAiDiMlt6kHKPEw6okRqVthWKkhN6s7mVGkTYuZRqIXbBAEkeu/uANSuKjC
	 OxJuV6CqfpzBHjvJzYjX72jwarDshK2TCwoemM3ssk+t3yLjv+BplgKxGw4p8RJ6r3z6e
	 l272l20uORjCh6m8aCga4U/zT8EEZAeuiLgWTMTZrjryR/Nh1vc/ov5LjbsMT6MogR4cM
	 8oyFZZ41lefqwn4J78UrFCk7XY0uo+6DMT8xoCyKRfnOXBdDKJoBHPWYNQEd/LeY9I5DN
	 mXvm1dnNJSt48CJxhjjuKTm27ftX13mwwyeq2R/6BtdFq2TGs10p95UtlmdbfH4mAcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792453648;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=6JOESh5GAOHTYWNTRlHJ7nR35QLm+hr2BOJs+qBLNAU=;
	b=HcONhFFZqM56t0ZHExXHDFFesbvaGk+IFVXmFwnTAB8tikQ+xe80IOZ8G2UPWiWJRLCg
	 CehKeRwLrkBXup/Cb54VkPA4HA1/pGhE9EScfLBBOQvslT3E8UugwART929NWdvbt+CVk
	 tAi4i7/ErFrxzhyowtmLv46JCXtKor1B2rUDRn+jNMtCorzXGdlpbcy3wt3dBGqDgDbdX
	 XxB5UVEejC3uNr45FTt/6bQM7SfLHJKzvyCZQjXjtDWmqaAL3uHyYe+5W/34K1srDxYyu
	 MPQXmqYUKyUHg2GGBLkW+0EHvh36I6BhFafWfD+4kluSvA6Qq6wJheG0I6/SG3W2tsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=m4ziBwuA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=azIkBHcT;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED000606A31F
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 23:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED000606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=m4ziBwuA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=azIkBHcT
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 39F1DEC00D8
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 19:47:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 19 Oct 2026 19:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792453647;
	 x=1792540047; bh=6JOESh5GAOHTYWNTRlHJ7nR35QLm+hr2BOJs+qBLNAU=; b=
	m4ziBwuAEvjS9Fl0uZG8Wb9BttSvgGsMT1wiNPFbx9BQ1E+Ckkuj12F4b44iquP8
	UTjlWYLRv28pyM6a0odG9JOh0agkE/+un0x8xJmBf230lLJHoqOyTzwxtWmC1RBV
	I0eCOUWUI9ZbjIsmM5I5D/bCQ1Jmfeh5L8iP7Ewx8zaKYoJKDquh/nqzBUu2GuGH
	yQ7rwDeVPJYFTgxB1pfVQ3q5vEk2XFSDfAg8UOiRB81VhayqFPHaiz3vEJAuKViv
	KXZzhd9fD58XQJc+IAurwNVcUtcXDZ9JQWFeWASvqr3WFass6wtSKW/lvn8kKiCq
	Y8urucrNv8F4hchbKXVkvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792453647; x=
	1792540047; bh=6JOESh5GAOHTYWNTRlHJ7nR35QLm+hr2BOJs+qBLNAU=; b=a
	zIkBHcTvZOTJ34vkEipi9mJyhvhnnlq4VsHxdBoxHmwAqhI1XuOxEWspKZ2eQmzV
	FxufKLvl5v6hXqFp8d0Oao9v/TqMslPBwENF1ZmIUtRkTou+jWgXIxMw/DEa3cMk
	OIyK4rIZsZDxjv7YeaKqagYMHRd54dVTXPqNL6OFq8yf3rvKtGe0RtMXv1THoie+
	l0dc+ZQIvBBB3j7k9tGJQ91YmzH6WOQRi5V4NSUP2oBT0K6Bm5fyPZif4HzrAhju
	2OWHorOmLe6++48UHCHO7EyOY8Ke0uYW4tFbcpXIkjZeiYJBkR0hwVKGa73tYvys
	40v2I5jz9uelWXzaBsTLw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792453647; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CLmlHUrzjQUSSx+1e4FJ+Xn7ZfnSI5ohLVxVytEXhBcOrNH
	A9z1ibaMIurvrdboJOWgCbEwUE3RYbeSmth5AF3rZ+yaWfYLzib1JxD7AgZqj/p9
	+D64wYYJCsPKM7/sTkpOnqbfgpVEoWO8mOGH7chagc4u4Wf0G5LD1YQt/p720tdQ
	w6zaoQH4jC71eu3xOMkvOdXolRevVGH2e4IcuDiQRD+vatu4pM0VSLo3i6OyhXwW
	XI6dUJPPv9xLI8OSsvvchktXSADiIVY3IGXeJpOULTY0sRLoLH+qMCaHP/ZaO9YV
	+ezgQMay2isd13XFcN7Rbxd+TOlCpBtUmNJqckg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:47PmJmAYFj3NSzzcY6THAYrIOX2L4rvKI9o9Z+DNmQ0=:e+r+1Que/Mq8zWgbFfQXRRSq7GgrHumcsiJtOSDpJS0=;
X-ME-Sender: <xms:DqzWaiODahXZtlEgw6ESMgV0iL90OHk_3tFiVhrerKy9A-402ss8hQ>
    <xme:DqzWaoY_QcCqzHU3psFxLTJx5LXw25InQaSIxTuC9SOIglMBhh5AFO-I0yKDbkeNm
    NejscX-NSA-9m629VxRYb2py1x0hX3bdm1d5BQeSXPerafj9OhTADw>
X-ME-Received: <xmr:DqzWamp44HJrG9rvKZRcWmAiCGXd7OvsrTlaOMTwTFQbubKiLkjx-OiQoHByvcB_GBXtz1H00fiS86R01UKxmllAx1nukSDnBoOOWAaM0O61KFPYsCk39ow>
X-ME-Proxy-Cause: dmFkZTFA418D5z0KSvHbuiVoFYy2aDWMFt11U3cF27ZL6opCh8H/xKW8bs0bble1EnGdtb
    Ya8tsXq6TM6oLCnMsqEx0o3oKRKzuxRCYIYKDkDgO+3fBElHHL/y7TCDkuYnpKkrMZFXen
    K4IbAypZ+uIJ4ed372dPMTBn0Cgoxu8Z0qgBEMZIGf495IR30yHzLUNL0F2C9FDYZcWq21
    8DGZmHSTp+bQ0Uf2lf1y99/0qYxWvPVFJyEts+bPD5jW1PcQwMa4KgZA6VFeqHwU5xzFmC
    HdvP7BQbp+k8pdz3WVLPXZQIhi0BPEvAjFCBRY9sYIiLznrE6j2hc24HnvHN0mVBjraYFw
    Mby7W+RfU2EOfeu7n6vqOL8mUH4ifvgg5ZT4JOFvbUAqxNc0BJU1TuBkYgI5G3lpvLdbHl
    xGOofCKIg9HdyXy7eHehGWkRCTZb50KiTYMh+CyJqFU9tElzWGF7yYomtPCzCSbphrew76
    mBxDI2IHJi2LnbwzHHec1I2ZHLBqHz00JuchozFMewpajoqP+WtOLJsUXL8dK4eqHFkFe7
    K6tq5SYA6VQWK+U7cNidmQSW5Wlu/tkSpJ1G6DLygn0NQlzeVjbghrTBtsMLVl8f3dG+lR
    7Sx7IZzto/GyowsKx54Oy3Nn6FpeJJrVVmfNGn0gTaOHyFk3JlMFFX5IoH5w
X-ME-Proxy: <xmx:DqzWasYERWwNJfsqW-5XzPcEK15ozJzrz3C8HST1QWKtfwOF5IR95w>
    <xmx:DqzWauRnlqCJNZvukXHu6QRUTg2hqJm_4JfvzNCRv6wkFrkBBvJ9Tg>
    <xmx:DqzWaj6VIgpPKqpIqCJZyJnFWhZSA8a55CDoI3ZDX4XVOSpDozGCLw>
    <xmx:DqzWajxJyikQoRqxz0v46VSfoxs0gCiHIWGgotbuFqEq2AYEYs1K9A>
    <xmx:D6zWaojoICn3G81-QHnY2w2xa8mLGpbq3_M-R4N5Tq1XJ4HMDWeIaJ0w>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 19:47:26 -0400 (EDT)
Date: Mon, 19 Oct 2026 19:47:24 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] github-ci: update macos jobs to macos-15
Message-ID: <20261019234724.H0mV3jqQ@teonanacatl.net>
References: <xmqqfqy5clgz.fsf@gitster.g>
 <20261019194152.907881-1-gitster@pobox.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261019194152.907881-1-gitster@pobox.com>

Junio C Hamano wrote:
> GitHub from <no-reply@github.com> address keeps sending
> 
>   Subject: [Action Required] macOS 14 hosted runner image is closing down
> 
> and suggests to update to either macos-latest (macos-26) or
> macos-15.  Use macos-15 for two of the four osx-* jobs, and
> macos-26 for the other two jobs.

I know very, very little about macOS (in general and with
respect to Github CI)...

Is it worth using `macos-latest` instead of `macos-26` and
letting those jobs move along with the current macOS runner
as it changes?

The documentation¹ links `macos-latest` to `macos-26` at the
moment, AFAICT.

I don't know if that moves to the next release too quickly
to be useful to Git or not.  If not, maybe using that will
be a more convenient way to get macOS coverage where we
don't have a strong preference for the version?

¹ https://docs.github.com/en/actions/reference/runners/github-hosted-runners#standard-github-hosted-runners-for-public-repositories

-- 
Todd
