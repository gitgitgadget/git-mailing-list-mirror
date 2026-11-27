Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817671;
	b=IHSczaC07vfPeOd5N+dK1y8GMq/dB5F1VWXm3sLrlfkezyZbFYfxmGnVOc/s9wkjcRGz
	 QySc8+mmgqyfNN0yWpkC+sQOa9rwvNH1Do17koml5ZkBh1TLMFTLV4YztPOTSTN9Ac6GN
	 2o4nDQxqWTKS/epbXgX67gXh7XsOu9RkFb+9kfEpZdQvdOC2imQ9+EVH72a7tvEoREuEg
	 RtzIkUKf2UwUsVGva6nHtKEgu2rwz6i3loZLB7KjTJlk2GQFk60H6Tpd5KkcdgrXwGhWR
	 4KH2erza3FnWTIaTubtlc1FOY7A8UDD0AiNLbdwnu5nyVHzKlhRJUPaO+nBMG5UENLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817671;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=galVTmyVtHKaeGNRMot/rXIVzwngSg5re3IB+t4Q4Dw=;
	b=3jYG/tfZALnLatUPWug1mhyfYP0vb+u9GrYm2adQ7frvmO14VDb65Is3u9ek+XlVFZ7X
	 0ln68NF916z3VyDn06HIogdve5uLHvLOWgc6ppoi2ci7WqFZMsmQ3cB3ceHxOM6v5OQkL
	 FKHt21FfjLnl6D8iHMB0hRowkecT2kpwX6VtsHRQx9KInmErLwVQ0UbLgCTsfpTmbWa1D
	 ibLFF8IS2PYwPMY600viECPcO6/YnYZVa1lR4mZDr+uTgsFcckbNyr05Swp3ABJlFUGvd
	 ZVyuTHokAXsdj1JahU20UgPgpohi6ydxAv0PKQOGntet1EhPApKvPDNw8Z6QDkCTXxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kfN9NvK6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VuZOVQF7;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD83A606A321
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 22:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD83A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kfN9NvK6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VuZOVQF7
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B0C7B1400313
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 17:14:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 27 Nov 2026 17:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795817669; x=1795904069; bh=galVTmyVtH
	KaeGNRMot/rXIVzwngSg5re3IB+t4Q4Dw=; b=kfN9NvK6yAP3xca5ClknlPjXf8
	wAAUQyweEDdmz8MYOoFc17dH7Ada60vx7lv/vJQBN9/v505E+xt2JBE0vvb6wvXw
	X6+yILXNBuXvJKpBBQhdF17GDgBe+jy2r/FFCWgZT2nH0GcXGE5ZG+c/WzilRIke
	oAAk6UfCAYVWPVRm26kfW9F3bZfGUhrOveFR9ghtmINbT07kJxliYb1p9aXPnzEC
	QzUrkv+Tp6V5L//CC8D2um4gt4PxBFZJ9mkHpNLY1z3+MjmVbSQ+TIHMwbzk9CJC
	QqqnL0c3VlhSIMXiw5U6mnNUgcs+G7dxwTNpFGjPiu3ssCPfjITuRpeQC/hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795817669; x=1795904069; bh=galVTmyVtHKaeGNRMot/rXIVzwngSg5re3I
	B+t4Q4Dw=; b=VuZOVQF7LB4jTvrrZfjMTm94XZAEZlT3zTbaot+Z6jckVZ5bf2N
	8xZpbVNi1NEVW07TZXDOB4Ba9oHQ8apv28Bxt5B0pUNrjw1jUGJwtEA7b/OdL7RT
	EEpaEN4tN/r5aehBVaLpYkwD2VM28zWqLb3ptQMiJWaic0h3LdsUT3jIhXNxiExD
	Se0O2XkOLhGLvto9M75gUjAGSqX9xPXL1TNZOfiT6zcMBqt6PnIrBq2muA1DzzTj
	gAHiV93cu7OIsTHlOttf20eGARyhgHhjAOfRRE5t4jIVtdNag4EiuApo6tBKBvfd
	+HO2Lsn8xzzpRrGV77a5fNNaG9Ts2ogmjfA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795817669; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ghtir1LfQ6HU1UxBgdrV+6EaBs5Ucr8hnFb/LJDD2QMBsgt
	Jz8nXbNq7Ea2kz2RmUa2189siZ3EOfkzh7QYY3XSLiQlpecEeRyhVW8BFc03t9/e
	roArpRe479zVheE1nNtivifpqX5ErP4bWgIDZpXL/osA4AQewq5Gd8YP3fLo4snp
	/hi4ChEiFao3Y2r01/BaweA/6rtIPVGg/PQB3czNyumgtKmMHKvVeJOQVcwSb6Z8
	GuUUhVZIcbcYynJJit/iyFWYdQGpsxrkM7Rzhjww4Mh79ni85qnQuCaXvvU72x0d
	eEJCuN8bYpC+SwPASVD48cuVr+EPLjDR/BBL+VA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:3IdoHgIkM3zrDiQbGoZMvFimiBGo2clxuMmogI/QLMM=:r66zIcF1Tf7zlD2quOINWIbqYTCVVibklp1zu37EIX0=;
X-ME-Sender: <xms:xQAKa5RUBSMFHZpVeTbqZ7xLXI5PU9pz9WLs_EldkO_glThMV0P7zQ>
    <xme:xQAKa5rh3h58AT2Xz_zPPXvj9EMMKEh783ew6EAVhJaWUmnaY1xA-2TAlRye4Ic0Z
    PHpWSI5-vAm60HkSaIY83oe73F5QW-FazGHSH1CL9d9VImTQz7EREw>
X-ME-Received: <xmr:xQAKa3L9oIwttnE8oQhmKRdgz1TJCOxchmj8USUaauM5KMGQ1xDrTbYKqTLEsFbhtgoHA7aPdRna8KBI7veZFdPdiApgnKQbSCxvIJY>
X-ME-Proxy-Cause: dmFkZTELbm35EHSfbRKOF+WdZ5r0M9sCa/dyQXKUCYqWykRCZaK2smUQpeefPt+jYSmNXN
    BPrMdM/Jai+G5aZJNDb+KjabPUPy/LL7K334nu7Gi+AEiFQl6LrCKV1Hqf7bGCMARBuZb6
    Vn07BhApCbv1yyhruHAdUg3vb8SAnLSWDFml2XwxiIu53bQmm6h1vf8v+7+6uOem8ri8M0
    jhFT6O5dkdHoA13lvbqyuQFehBTe7nEF2kg8Z1iPcE84S8hvh0Q5nfcWUTq9sXt+ceM0ev
    ZUXNFuFteSbMkgH8/xaUD+vlsV5lsqfR7ubkJ0u6qYhs47R6RkHidtIXlMasaUzA96g7Is
    Hj7QPHK25kEqO3VQNac+Au8kiTLU4pvEGTLZfVF4cfAZEz1PHDYigeXdiLAt81zar9DLvb
    G+vjZRC7iJFLl4svTmQ1p/bAkM+lwlRHJ3YQNLts+QxPjRSqVzQlK1TOIZutoSdqqENRKx
    7wi7uWIa6bI6qsH1xNH6NbjyC2G4iE9l1gyf9CBkNmKDVeObA21Y58Y4AGnfqCKaaV4ZlD
    gzGx4OMFtYGLy372VbQe1uyphUP/IA5DyjUsiYi9EBSWSA6NvfnervJLWa1cFrfENaxBRv
    0AgGYQjAn8ojUGFBHorL7rylX3ShXZhA29ZrQ92RcTlDRJZ5RLGooVQ4bRuQ
X-ME-Proxy: <xmx:xQAKa8p_-YqCQfd_febd3AE0YnIh3cJXFQcUNG8qhJn4dYNH9J_t2w>
    <xmx:xQAKa_yhWISlklLSWH1CnhEkjWbEVW65D3gY3-qitmZsRvtMggVT_Q>
    <xmx:xQAKawO6kdty9tZ3EmeDkt21h7vg0Aqmb-PlGYsFv5cGc9h1vdbesQ>
    <xmx:xQAKa04tKNUpX6gtCcITGwxhhPqD9EN0d0GNhdaYDH37ck_PqKVOeg>
    <xmx:xQAKa3CI0mtH9hSRi0AVfs0C6vg5p9IgOhjviGHb3Q5hCabqmQyl1cFP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 17:14:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Tuomas Ahola" <taahol@utu.fi>,  git@vger.kernel.org,  "Julia Evans"
 <julia@jvns.ca>
Subject: Re: [PATCH v4 1/2] command-list.txt: add gitformat-loose(5) and
 gitpacking(7)
In-Reply-To: <faf10eb1-bb8f-47f0-960c-d54c6fad01d8@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 27 Nov 2026 22:02:57 +0100")
References: <20260909052501.8448-1-taahol@utu.fi>
	<20261126201110.9046-1-taahol@utu.fi>
	<20261126201110.9046-2-taahol@utu.fi> <xmqq33sme4u5.fsf@gitster.g>
	<faf10eb1-bb8f-47f0-960c-d54c6fad01d8@app.fastmail.com>
Date: Fri, 27 Nov 2026 14:14:27 -0800
Message-ID: <xmqq33sl7who.fsf@gitster.g>
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

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> By the way, plain single quotes 'git help -a' instead of backticks are
>> preferred in the commit messages.  Nobody passes these proposed log
>> messages through AsciiDoc or Markdown processors, and they are supposed
>> to be pure text.
>
> I use backticks in commit messags for my own personal work just because

Surely you may have your own reason to use whategver in your personal
work.  I won't try to dictate what you would use there ;-)

Thanks.
