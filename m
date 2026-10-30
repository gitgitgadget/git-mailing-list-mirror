Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380732;
	b=RDdaj0zEBfVChw2BB95FSWoQ97S5BwY3OBSej4oR0dmbDIni97NvbFoFfTfarS8mh7sR
	 RGWAyqu/mNcZY0TY5P1Uuj3GhT3T9rXjISYVj2n1WDC4/txPt3Fm0rFa5EvjjLNKbGsfx
	 vB3phstCnSGJuaSaz4nyusKq7A+vDk1DdWiilYj0Imq9Qh6L0HeA5ND/eoNGQkye34fxa
	 Ml1QjfE19Qv9ZlpsCmG1QT5eqcFFSyA5m3kDDg1M7gEj7zJOMBhEMHiEr8eTss0vNpSXT
	 yEF/8e03KZNWRjxFn8+1rV8tPToAMNVjWeo6U+L2zV9+8OUdC4vrwfHrENiVDM0uSUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380732;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Yba7DozJxKsm6XnBt77YYBCWH+g304YFbxjOSATdqXc=;
	b=gMzmZo/qcZOd8rD3AzOgsYOQwtML86NY7LY/fdlkPlH756NMAr+wCW3bb0AXhoVfT/rA
	 96gUvpKP1i3MtFU40srF+A/rhWZcBpbYQTG6AaEXW7vOzXT1piZSg7nroA1gaJ75ygAn8
	 0mOT0nnxy+lpOWqMUq6JICQ9VQXOOfWew8P3n048YbNlR/rOUXSHXVlPAYfXnzBlDXoam
	 SF1xP2zZ5DzRWAEHQOqIiNjq4JM/pEJJBay5jnxOveIniiB7ExVTofCnWBC9kYOUUhXmz
	 mZVvzXdwfOfaf6VvKszz8TB/jfKmCva0l5vFbdIusByB6BjIrjRB1HRCXaB9OnbAiEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=SWWjSw9N;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QGe2pyWO;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FF5606A320
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 17:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7FF5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=SWWjSw9N;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QGe2pyWO
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F37DB7A00DB
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 13:18:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 30 Oct 2026 13:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793380730; x=1793467130; bh=Yba7DozJxK
	sm6XnBt77YYBCWH+g304YFbxjOSATdqXc=; b=SWWjSw9NFnU/HIWC9hSKVdtElW
	FMgNbtILubdGqms5T488tYogxrCRq2uKipi0xXO//tc1e5A6pA99CqDL9JAeTO0S
	lz/oKdoAUkGpwQtQ9j7m+PTjwi2DN4E2y5FiINlrb8bnqZxoHU/w5YO9W7u9nQlo
	rkm1xoDsk5QGQzHeXn7+FI9wxeXp/j6bNIEEXJ0ePyXhMW2UL7NYgLVSM4IzIka2
	oFoDkY37tQar3cA/sDOwyutbvzIl+Re90XsdGTLVJuy2lrw+5g41u5RoUYZ/Eh0R
	44FTUGUdbx0W4dUKIi9fw4xAE3JbvjH1A5RGTOwxdKmM4+tfV889xb5sEKzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793380730; x=1793467130; bh=Yba7DozJxKsm6XnBt77YYBCWH+g304YFbxj
	OSATdqXc=; b=QGe2pyWOhMLgEOMBSbhQbYIfFFjMoxI44hA87InNx6X0nPE1LuB
	06SQzSYQe3oHXeed3WCYH9hqOT4vV6ZIuOIte9yoQS/N8XDQ2BKTHs8WwbpxsiRD
	h4gCduSVVzhSJw9TDf+kVmmHOwoLcBFwKRKYuZgGHUbG9ANyUlRRnVyldLs3/rCV
	x3OiHPzi3A3Zx+4EsCA4Foa+RxUxqP6vgLYoyhdJIulK18MA6XiZV253mQcfOlWA
	c8CIWmxWWC9wiyVjy4ba/30A/LY3KPVoFNvFjWUduKO3TnNsotWgZUuxrAXUSlrs
	enqImIj7Dr9o5BSabeTdxhQQaehLsm1v0qA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793380730; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:U+DHtYjxgmao7GhIrmVA2bTTKMr12hatYGHTRIpXj9rqI7W
	spc1ZY3/hAR8aBwVvCTF2ZOGiq6wuJaJvdukZFpixXSQoBhcR6UxGQw5I1tBZc3K
	qPiqgVxVZZDOelmj8WbetN/9s5T9AaxW9SSdFCefCwMLMZGwwQmmnsCvHRtEj4V9
	/lp7r4EYgIhxZfsPkeBlWAnse6F7lQ9mwb0EsZj3ffeC/meycGaOnkqQrexM9A5e
	nJmZQOcmpm+V7I8Hp6diWeRBzl04//ifI5cKYjX1wdEiTZq0axKUzJFWlH8hr+LZ
	n36HQNYsEKARSLAYR8rWjMrB6PiAJ29OLFuF1ww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:JuU7yyZdGBWteEKUPITTgY7Ql+jD5Tp9zhMhLtp6rt4=:YLKedmRoeRlZGaZlF5OX06o5VUFSyzJujQXLtIyRdDQ=;
X-ME-Sender: <xms:edHkatjYq7ScjE92x3O98inemKgo9l4UkLMj0kCfj2XY9vSxi4cD5w>
    <xme:edHkahFfhhf86Anct39O8oiw3ESDobJrn_f0_vien-rGAKsvfPzYMXz8CJpQ8i3pq
    jz5kki-XokILkNSSg0NfH-QxAoHBjOBWULTkUXKzocp0gQsdvuUhNY1>
X-ME-Received: <xmr:edHkajR-2LIsDcDXhTO6775X1nhsYaOr_9FzuxVt6Bu1IbMCAK7mWVqo9NQubQgEMBW28eeL_N1JIvUJFak7YHAmnpgJMxqD-J9e>
X-ME-Proxy-Cause: dmFkZTGsopyXb+h1zmf/Qa9Q2LMATmGGquTdc7C7RP7O/fscRGtBK3akd9JCmAlnQdzvB2
    6HJRNuF+YF0Z4jgkeY+t5DtljUFY8KIVUpyrYCZ5aE71+UO1MTFRxbBiGvxj7pyBs33mvH
    mhQ9uNx5+PGkvd1IY+DtEtnEhVs6yIpl8kk8rRIIB+ri8En52nDX43bzhy1/re2wT/KlTO
    tOxwlpMimeuhIs0rCckMLYoEK77SEMVmelSIoK6XW7QcQkLSzBhmFMkPpX4NFNgnl2OxD0
    nmZiqaV7sxGwK+Z98S5/fcIxbTgvYZqJ3NKv3NMPsA8THCOmQMs8Gm2YueB57JG1d3KzuE
    nzOyB4mCsjMUGFnjDecRHQtHBXM4/Hi7uTWNsek0ddYnpsftwnrH9tqJSkdxyo+U/MxdBL
    GhdEYQnjlgBI71Uj2B8Prie7k9aB8i6mw9zIJgV51nR5NOl6NYUKkjiVTmY4ljjFpm657a
    a/QS/0JwyibK1gNGsTl1bXhJuCry8rGL6rLYPLmFVAdYsFos0UBA32DgyoVj8RmLhc9OoZ
    MkS4VkCwuDXIRK16pxLYYTXTF9mvbPBkat7+VsXuZLtDglY8zD/EBdkY6f7+rt9Lwl6T6t
    rzTIKCqEFnzNau6zmr882duC94vzhjd9viJIGkEmkVIsIA5R+RGXxqVNkq/w
X-ME-Proxy: <xmx:edHkauyRaYwDYXjExyb9CYfSQH4sfbyPZisSFLuwYCH7TS1170OdYQ>
    <xmx:edHkave32_eUl3oikOjKydKrFugTYcVowOtrr8XFHZ0wIIxjPhEDuA>
    <xmx:edHkahM8QZq0CzBN5wX2TYcyO_m_Tz_FBVeX0Pw4tT8e_dkltciq-Q>
    <xmx:edHkaqv2BqgKKEIzdL7LqOfZnaXhs_XHr_vZqwstRbDcJrjAFpZPng>
    <xmx:etHkagz7jg3jjZuYtVcV2c1GHS8dU4f2aHm636dhIbYeRejg2YCItdxK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 13:18:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,  Tuomas
 Ahola <taahol@utu.fi>,  Phillip Wood <phillip.wood123@gmail.com>,
  git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] Documentation: propose community voting process
In-Reply-To: <CAJoAoZnqzKv8ocsi1a-nC6LaRnpKKCO0Bxt-Pdn0dDUziEcpAg@mail.gmail.com>
	(Emily Shaffer's message of "Fri, 30 Oct 2026 09:50:41 -0700")
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
	<20261021200341.378978-1-emilyshaffer@google.com>
	<CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
	<b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com>
	<xmqq4iedc99a.fsf@gitster.g> <20261024111856.8s8qu%taahol@utu.fi>
	<20261026011731.GA3575069@coredump.intra.peff.net>
	<at8IBMQZtJP3bQ9-@pks.im>
	<CAJoAoZnqzKv8ocsi1a-nC6LaRnpKKCO0Bxt-Pdn0dDUziEcpAg@mail.gmail.com>
Date: Fri, 30 Oct 2026 10:18:48 -0700
Message-ID: <xmqqse1nw1hj.fsf@gitster.g>
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

Emily Shaffer <nasamuffin@google.com> writes:

> I mentioned this in another thread as well, but for full transparency,
> I'm feeling a little bias here because I haven't had the capacity to
> make meaningful code contributions to the Git project in quite a few
> years ...

Drop "code".  Documentation contributions do matter.

I would love to see somebody come up with a way to transparently and
fairly tally contributions people make that are not patches.  Those
who help end-users and other developers on IRC or Discord without
writing patches themselves are still valuable members who support
the Git ecosystem.

Those who review others' patches without making their own are just
as valuable, given how much their reviews help those patch
submissions.  Those who correct mistakes end-users make and show a
better way to do what they wanted to do are valuable contributors to
this community.  There should be some complementary ways to measure
these kinds of contributions in the past N years, in addition to
counting the number of commits that hit my tree in the past N years.
