Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677461;
	b=NP+/aXQ8CxCo3nlFHapBAQIPgTU8reTPkwm6kuC1AnR65RxNtDScpEEXVscJEULDkGKM
	 3xc6nJvlYYMOectOLC6thfkyWCqlEmaMTIcaOzIr5c86zcrO+EeQZNgnBkBUX6iN62LUI
	 YqikxnunYHlAV8qS2oWRjsH+0msitaqMYxtxq2VgbfoF1nvN5lRQ+j+p45g9WL0XD7AND
	 /0zRbL2XL/2+7zapw+ZuYnRkq5uy1NW22PAGsPUxOvkqk9H1ELnJ+u9rYU7mVuiUbFybH
	 I/n4pReuxs3o3y3AgzAOgha+blvfFzi2a7kckg4dHKTy2WV9rC8ppu/Zi9WL+ASz2OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677461;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=+mc7AXfU43t/f08zR8R9HcdWLRtNAn6P9sVG6BobC/A=;
	b=TOx4xTDw3IhD6YNKrRZk9QHcGxpfwm0KG9brXJiAQiGzxrYJfjX/+nuHKhxCAXfZ+PT8
	 KrbJHe9ggv62H/b9IJhkkQFqtvYguDuwRNiVUrHfrK7j5N34zKdYWs1j7g3i5mfbt6WQv
	 B7e8FPexwGeRNUMgKsHo8zqc5VV/ipYM758L1yCWeRF/pdnxaFGRxidCzCsLaigGFZUi8
	 GhRolMSG5+4oznGS/qxbzqOnQRO3NAnUsJHzDqvFeMV5W86n7UqadpKA+ZylbS/EXrBwE
	 KzR5hSSRFgPo4KLGyLYK1eBUUeTbyDEJYqntpTpfPUDnqtG2NSexTorkos8jXCkO0iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=SJzdwC08;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dlavYBOQ;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91947606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 07:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91947606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=SJzdwC08;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dlavYBOQ
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC819140026E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 02:17:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 26 Nov 2026 02:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795677459; x=1795763859; bh=+mc7AXfU43
	t/f08zR8R9HcdWLRtNAn6P9sVG6BobC/A=; b=SJzdwC08IKY+ZD7ECaS6lKrABd
	BVchvoPgAdGFxfwEhffHcu20Eh1LnlkWIXIRSLKmQce/5GZfmyAchwXS1xkMCoHA
	+LFd3X+pljLKabxadcngm0D6dOZ+ZyfDc9WR2kFTmWC5y0AdjOuCK7CS15QyJoI6
	SKbCZi8lx2+iIPAV0xxClHka8c8RD9Bm8SiAC1iFIPlKQ4j9E3TSo3RQ59jaD/+d
	6f0d5rEHA7Jcyy4V8BI5NxlcbNe0wQUHOkEDrXYVW8mJmvoCJETgdID6Gbm6NjmL
	WnqgAKooyMyg+YZK9o7eWZ0CKfHToEdww9GB27JWuDy1aSfrF+WO3lhRThRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795677459; x=1795763859; bh=+mc7AXfU43t/f08zR8R9HcdWLRtNAn6P9sV
	G6BobC/A=; b=dlavYBOQpCTHdXQVhyJJ7WOeAI8K1ZuXYGUmpEAtZRLuXL9Cn91
	WtVbei5KUlwbDvE0JwKdEqWB5HQbXF6l6FK2VYyeCAl6Buh47W97qt/+9ADRZkDP
	/+f0fKL5D/YDNgzKZJAqTp6AGFRz7SRoAKSxAh4lJRQPH53C4w3/C66QejY4ipba
	Zq5/qLO9ncRyTtZ8qGyh80GPoe7ia4E6piQ3SEeCPbNOeDNxSlphdJbUpgylT/K3
	ZwM7qgLChV7wJPaMsD7WIQhrPihDmeHkHIgidRIZye1v0Czdhcnp29bRmzt6SxC0
	l+LgWAUyKzMpQf1FOBVEYZaAWI+v/Gh6S4A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795677459; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KDhxYYpyNd0zQxlBtWjnHmEQtI/mhEIwJ8aTeyQB5ENvAtc
	rBDXzPODhQ0TgBcSuFLx/ZPrHfYKVnhi71lpQmy55ytcEWxzUmWjJiumvFZ7B+n1
	Hb/nROpgaiJTvvYqZmWxtywzmt3EQxriWNgcUmDxI7BaMk1qfkBG7X9NdRwqN6hV
	53FUPnwixKI0+Noi1D+dmnt3lmdq1mMtS0BX9d4DlDcRCBY3NqNCq+0KOBB5jNzk
	qeSIp6jo9MPhAzhd7WEBoO/seLFBvbb8EuyEmD4SAAm1PBbZRF4i541xKn1q/mSN
	JrSOoDZ52lQRgTCYyXqTdPO1dxxZ/YPuukB9COw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:igaAhjbjFkIdl7wKbwz9DhnA4lemFPhNnNDLVAMtNQ8=:uurNrr1my4n/gGjRB6Mjdju9v1c84ZEZ0NsoObTpEgY=;
X-ME-Sender: <xms:E90Ha6YlRtTpiISGJsiM2viKzBpBeV1dQfRDYnWWPjOch9f5X-6HDw>
    <xme:E90HaxFtKghLXMJe6elVQ7bmgvgUzvzAQfjwSuzQgvLKV2NJ67dKH-cPwTj-LeGT7
    _Jft0w4qNRo4JT0pgTj4sf1EGATJGkEcJ0s7tY4mlMJXjLRPwmQmN8>
X-ME-Received: <xmr:E90Ha-wQfSpegO2u_Nv8Wy6v0fWCxKbDtY1WmveBQu-KqmKBF7czas9zmjUXoZTP1IYJ5AdjwgsRFdrLeDBr7GwFiYstNawKygo18Q0>
X-ME-Proxy-Cause: dmFkZTEydCKSiy7R5Up3WsYcjVoTEIcXl0xYOQUvL0a3owI3N3+xnLTTULeeT9rW0VzYNB
    /o6gJjfgp7HDSsvi5e6SEFa3MxZi1qkCyC6HOv5GcvXPaPlGBQKAQs45UrjsaN2Z65U7bq
    wmw82FYUsMrI8l7cZbrQhdZjM6V73UeTCDxC6SM93yBh79LY/m4gmfZtMQf3S9aBNiSCTi
    zywfWUKjECTcQtEvRLvUMYXs51dNGnEL6qiFzmkvXJaS/P21jaQcwIqIUp7ZAGfkD3EZlZ
    xotm6OBh7sn6tSWOIy5Hel6VDDFKMHErF4Ay6eGBwJBvD5AFCChlXl1cjHDSOEmpWcI2cW
    IJ9kwKjK2KzIYZDMePj7+AwvaK0bTxyUhUUEOhDYOvcz7QX8WJAOWjGh42YDQ5J98pUPoA
    u6CWWbX8PIZ3/qIRIeaJ5W+wf2THN07jDamEWIujKP5NaI4CbtyfHtJXrPXsjat5eTzGva
    ej6x9uI/wtYTQLt51ktwYk/mcBEnIbmMvRXnOftf/GLCC0ASnUA8cFpPIuAoPWgClUODyi
    bK98J3hPCF3ovywf5ueyR6DyUSr7xnS9y9ckkqY0dHWgkInAorC5Q0ghRajDxLHuOVw8Fx
    ab5UTjYKSIAa76CKe0wfmZozpf8rm1KM72vF6tGcbRqa8Tiba4nn6NoeuNnw
X-ME-Proxy: <xmx:E90Hazms8ZnTD9ZLE4WWbEJPSbitSnDW646I0gTgEWLeB12UgzO2vA>
    <xmx:E90Ha3lZo0XwwoCx_sqcR7czSbnISfXe1LXV-odf4LHBOuvwQkL33Q>
    <xmx:E90Ha1ztq2GuhLn904H4-45QN_Of3L1p5SwpfNSj69R33jeeVXkaBg>
    <xmx:E90Ha8ouTbQK6smv-Om71aY99FU_0cAJa5K_fjddihnUBY-EtulRBg>
    <xmx:E90Ha6mjw58y4FaQ7tw6HYfEAACWfBGzVMa99vat9s4D4nlO5IJdAHtB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 02:17:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dominik Maier <dmnk@google.com>
Cc: git@vger.kernel.org,  Caspar Duregger <caspar.duregger@gmail.com>,
  Pablo Sabater <pabloosabaterr@gmail.com>,  dmnk+artist@google.com
Subject: Re: [PATCH v2] graph: do not fuse merge parents with the column to
 their left
In-Reply-To: <20261124180557.70212-1-dmnk@google.com> (Dominik Maier's message
	of "Tue, 24 Nov 2026 18:05:57 +0000")
References: <20261119192247.2671852-1-dmnk@google.com>
	<20261124180557.70212-1-dmnk@google.com>
Date: Wed, 25 Nov 2026 23:17:38 -0800
Message-ID: <xmqqy0agnjsd.fsf@gitster.g>
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

Dominik Maier <dmnk@google.com> writes:

> When a merge is skewed to the left and its second parent is the column
> right next to it, the edge to that parent is lost:
>
> 	| | * M                | | *   M
> 	| |/|\                 | |/|\
> 	|/| |         =>       |/|/ /
> 	| | * C                | | * C

Having this diagram makes the visual breakage much easier to follow than
in v1.

This only happens for merges with at least three parents, correct?
Because a two-parent left-skewed merge sets '.edges_added' to 0 and
skips the shortcut altogether.  If that is the case, it might be worth
saying in the commit log message.

The diagram already makes that clear enough in context.

> Only take the shortcut for existing non-parent columns (idx < 0), which
> is the case it was written for.

Small wording nit here.

In graph_update_columns(), calling graph_insert_into_new_columns() with
(idx == -1) happens for existing columns passing past the merge, and
when the shortcut triggers, that existing column actually matches the
merge's final parent.

Instead of saying "existing non-parent columns (idx < 0)", phrasing
"existing columns passing past the merge (idx < 0)" may be more exact,
though the code change itself is completely clear.

Looking at the two callers of graph_insert_into_new_columns() (both are
in graph_update_columns()) confirms why idx < 0 is the correct guard to
add to fix the issue.

Let's queue this and mark the topic as ready for 'next'.

> Helped-by: Caspar Duregger <caspar.duregger@gmail.com>
> Signed-off-by: Dominik Maier <dmnk@google.com>

Thanks, both of you.
