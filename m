Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730628;
	b=B7NDx2BMCK0iYivG8YjP1KNKHl5veqloZ22G2dWZrg/SEZ/sXs5AwDYuIXwc015Hhr3f
	 HwPHQ3FkqJaE3nehGh/WIDOa8eq6tPqDOrq22fTjU6VUnNiUJ5V8Wu2RV65PfH3GmJH9i
	 rl2CRBnZ2hjwLeAx5VfJBNpjB+ozemk+dDTdMaZphmpZ3oglpWwgs47k957dCOmUMUI1s
	 fE/0ixNvfTP0/6USxp6KcugO0GTdI/9LjLEjvtoC0XRCieewzOrzVAVSugYLljdN2gccH
	 rKQoI6rxSXLwecAhZALmqadhFs4NJgg+XxdoTinJ6vd8IDIO7ykOelXvV5uHt0FD+jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730628;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=O4HkHzOT/4axWuDJFjbRIUoAiXShDInnEc9JR1VJhbA=;
	b=Bgt+g1+1VkbjulNoOQx7pnr36SPMIrKhnyQ3vf8+jQqdjQs1v7m6K9PXq8kiQjkIBiUQ
	 R7Imy4DWgHz0yZ8kFlGX9ibiNiWets1zFlo7RrjKqEHlRTT70d+cY62hyuhlfZySUkmdS
	 hBZHX5DLRAObKkAb/5wS587JqvrUo0GeN3+SCNqqMgKmcHHOOtXgEIpAh3+ztvqsLQuSS
	 aNAqDjrDE6kB/vyckVxSJTSqE7ZN3ezb6FOgnjon3+fv3sGTlBthtogjxyZYI1IixNjOO
	 CX5KbEA800UryigTzV+EzzFmkpKS+zTOeCWASkelDV6BL9slQtNBEQogh6/Me1x9l3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=N6VXT7Q8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bmL+Ys3I;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A5F606A32E
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 18:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1A5F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=N6VXT7Q8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bmL+Ys3I
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A884140011C
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 13:30:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 03 Nov 2026 13:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793730627; x=1793817027; bh=O4HkHzOT/4
	axWuDJFjbRIUoAiXShDInnEc9JR1VJhbA=; b=N6VXT7Q8JypPSQkuswfs2sHKxq
	/ChvOZOpAPtY4fuJKGPMRFVlMcSsCbI+JDFI313PEdUtRj6ENQ0I0y6a4KeG3CHr
	dkpIvKXWRULGtjvGG9LTd2BvT+l/hAPSW3RKEtUPqit3DGfli3OKeME5katR9F2W
	KN8gRCMNaxQbWkXaXwfEh/nUCDNExgtPlr9gi739OMvOPpIyVXDV7pfC2HKWg7Jk
	cUfknEPNtefHS5Lkh9YKfixRl9RwuXk7d3Z3KJXGON358R7VJ7/aAljB6LY/hpN6
	z0LkRjgJkIXBcUaaIgxTgTCEDPgOTIjK1kWM9UrmqbMA5TApH9fQRuEsq5rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793730627; x=1793817027; bh=O4HkHzOT/4axWuDJFjbRIUoAiXShDInnEc9
	JR1VJhbA=; b=bmL+Ys3IXZhiXc6lsuOEefOq7Xt4+gGueuI2XvA7EY/4y7fSgM0
	X8XRBg8lHzzJ+la6ucBBMbThpqiB374u1DVFt+HSWB6jCJN5e0A7iKsCukfd1AJR
	TQU+WG3B6YF/Hox8jDN4GRPNgvE3Jx5NR7+3QlVpLc7EXE/y6AIQhR8UooGCjef1
	liBU9YhoyNOKRfaaclgeN5HgDGhLg0DH0Yn1AYH9N9T0xOlpp3WHf16ezxl8WCO8
	+aQ4CSNULwsvHPOkum8SuW5mk3tJi7Zxn9oQdmv9DwPdo2hroBIEZvyRega6aZNP
	F/4sLGSyl6UoKJqtFEvY/955GR6MHy6J4+g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793730627; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:knzq/a9/igJDh6jWldXMVdShZB1zP931UbFuw+4FhmsOKDp
	A/Gfv9gFfPc7SAkfwdyeAnSKrVICPCaQBsNvehwvlVUuO8DHlXB2T0rv3PcgD8FL
	bVV9mJUhpXoYMEykDxFdk8Pwbzw17GM0ibm+rbQ0RYZD7KmUvQUZ3cP3jXMAlBXp
	XQ4ycbfHYv62XFQlvG0B7kllgUsOztZGlvo5wX+bdfZ8/cLGKlcdlkMkiftcL9nT
	4N7dUjOiULTG2M1hxPS4znMqyR0XkSkGbEX0XmR0lZCtVR+ERhZzFRh15LvRpeBA
	cCvX2PaXrF8H0RxHIs2EjYIItytuwo9EIBBkLhg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:f2SBsZyDrK8bMCzuDSlyt0uFhTmgfUyK7N0qOzKi5UY=:DHsoOay2HFwSJNhy2hfezwfXMLyU38y0/951TuCR3pY=;
X-ME-Sender: <xms:QijqasfQhPWOolH3DDuRrgMiaj-zVr8c0q1KmtF79SUp_cGzL7UYIw>
    <xme:Qijqah7wBN5LzVkMNQqQgaFGOUVXKs-T_jZrsLXSZD4LaqWB-eKjpwJUFUO_i-9Bc
    lxfXh7hu26NeOivn_6xGX69ptWpsUCcsyM3l3go2FzrOtWDEZ7g594>
X-ME-Received: <xmr:QijqanWLQKAmzeZ3dFEHcv4Z6HVZTAXMYHdB3X_NtuCsIYkWqJiY-NLFWKQuOw3hC2SyCFp4rl0Z67zZ7Jd6KBxinlwhfH-jiH8I>
X-ME-Proxy-Cause: dmFkZTFUh1oRo59MPDKgA1+Mch8Uc9YFziqtF5y8vIgPSRcBYx8KkR6BjvJv27/FVhSwJO
    84hfEz1B4hYdBHojuJ1udBUMo69ID3a1jfL3tg8vuKSKf7ygkCvrY/aTNYhdRWLZuomaE3
    JK+JnLYFHDdZeoXRSUFoqmG96TuBqrUuA7E25NFyZr8s40iveqM4WDUCjRJFtMXeZGmZwB
    YjFTJMlWllRBHRH6ko6WmsZqobUV1np5R9RLqBhJC9N97M43Sd0DZHYsjRudBFSOVs0ZYd
    6+5VUio8nENAYCiuVcVH7lmqO9KuSAV2xIQxSE8Qou3YquADw948kuzuuRoqCZDhWITxa4
    smvaYYMmar9DtxblJ/0y+d1Zq/RdjfOnU31HpZR6uYVr/+/OcFx3EcFEETbj1pkZ2w4n0T
    K8ZaT/CYauGklQLcapQjRULhqTc0UoMGS3i0mq35P7pnDKNjTnwvyf3fnlvTxHLxU1YrAz
    1+k6NusP4xl23LPLhEuRkj+vPzbhizZhGLMdt8h0B3ab5dKzpdwTc7oHUDtYY8WvVzFGl5
    C/tKqHPbcMbcHa7Z49s6urmuM44tGgoxK7qqAVwRQArUjw0MCIjyZMd4weOZrFMn/x2Gwv
    RFI4UDVroY2yCuHt1sc8QAcD0HaUCuahxaf1wvmlL4bobfg9JQcoU+g/0Grg
X-ME-Proxy: <xmx:Qijqao7ujyLFFkOkNYxUmdEDyykcLR9Kd6jnMUPKFkrtckxe1qMCxQ>
    <xmx:Qijqaqr1-Xxk1IfDuhfhPZKZFBAc8Fi49_96xO5PLwN8moiopzZtOg>
    <xmx:Qijqajl0DD3ND_VdeSpSA4AkZncrc2grQvm1s9lDVAM7-D7wyjyMWA>
    <xmx:QijqauMoTc82qh3U6nCmTi9ECubCudUdJHtpqLlFqXal5Gwpguk5Bg>
    <xmx:QyjqalCSxd26x6MJdNf9O2Od6b5ow5TdGw3preOqJgqQrCKDMEB4k8OY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 13:30:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Andy Koppe <andy.koppe@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 1/5] doc: glossary: add root ref and clarify pseudorefs
In-Reply-To: <aunFqykTV0QHCmV3@pks.im> (Patrick Steinhardt's message of "Tue,
	3 Nov 2026 12:29:47 +0100")
References: <20261022212903.177261-1-andy.koppe@gmail.com>
	<20261101230326.3675597-2-andy.koppe@gmail.com>
	<aunFqykTV0QHCmV3@pks.im>
Date: Tue, 03 Nov 2026 10:30:25 -0800
Message-ID: <xmqqecd1939a.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> I'm still not entirely convinced by this change, as it only focusses on
> the difference in storage. How about this instead:
>
>     [[def_pseudoref]]pseudoref::
>         A name that can be used like a <<def_ref,ref>> to refer to an
>         <<def_object,object>>, but that has different semantics: it can
>         record more than one object ID and may carry additional metadata.
>         In contrast to root refs, pseudorefs are therefore not stored or
>         handled by the ref backend. They can be passed to commands like
>         linkgit:git-log[1] or linkgit:git-diff[1], but cannot be written
>         by linkgit:git-update-ref[1] or listed by
>         linkgit:git-for-each-ref[1].

Between the two I would prefer yours.  I would replace "different"
with "additional", because a pseudoref can be used as the name of
the first object it contains in a fully compatible way as any other
refs, I want to avoid "different" that implies "there are additional
things it can do but there are things it cannot do" Venn diagram.

Then replace "carry additional" with "carry extra", just to avoid
repetitions of "additional" due to the earlier change.

