Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC41D346E4F
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404525; cv=none; b=P8LQNbEskXdX8qhJk3uXo2xYDUD9F5a1zOYkeEXia56eRiQGEMy37+slHMedAuIHovxQ0i8PSP2hKvUqvr0MPmCVsRLt0+fdTElLg9iTVkcLfrcigK9n+0eeHrY4g5dfXJh+9wL+d32r0LJXP1E+MlQ12YOzZHtOm4NuZNGQtro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404525; c=relaxed/simple;
	bh=olNwR12lEkCPYrpps5nUEulYIrRMFNZwvviqAuuVEII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DjVl1/MWBsnl7o1qh+HKfSliUYNeDP+tWMC5hlin7uzYi0jDkdLx2NZN3t5xel/VEcfYgo6qOSEkKSEuh0ryngX1s+XprX8WtmnHEwaQ6n93Ukul+/wL1T9C8bupmUlT9LIChBmV25zj0F5bX0DeaTQ6HBQO5qos7DZBH05G2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W75aHnWy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IhkCj35X; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W75aHnWy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IhkCj35X"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3EF851400052;
	Fri,  6 Feb 2026 14:02:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 06 Feb 2026 14:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770404524; x=1770490924; bh=OYM0wc9X2F
	o8oUEpD2j5+Kvm8kzHE+UEMn6HQiG/Aco=; b=W75aHnWyAQo1cNIqikDC4z4N5m
	3tJ/FfpSa58uwlKldAJllSkUQ1jjTTs6yZBNjozwosJm39nhqnXUB0Yz4Si+2o1r
	C0IlrxYbcSVyCxpSXOSSD3TQYmgYUAS1VjwWAAS9O1O3iTdaWbifik/LiFVem5s4
	vi9GYh+BIA9AqnaB6umDTStSdY0hi3VULYJSMr+z5ztgsPeO4kzwmpNdD49I8Aif
	eAQ+Txw7K/5rOl5hZkNsV/6aRiTpDyUm2+RzmpSomgQCWT+QX6xHSgyveFREjCMY
	yjah3+AQP3avKTWHNeCoCPCzvAhDmWDWB0jS4FWFsixYbebkvvfHQkEBH+Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770404524; x=1770490924; bh=OYM0wc9X2Fo8oUEpD2j5+Kvm8kzHE+UEMn6
	HQiG/Aco=; b=IhkCj35Xis3anBOpx0nXMpQ2wiQvIiIbPoxjhJNTKkPrfQY6H9H
	0+SNlUb30kkchlCTaAalxXc4/iuua51qOzokrl51zBMt650Avf75WZlWRDxpqmlP
	ehwjA3hlF+CQ5REuQtYLWOuAQDSz5YUIaqx9YL75oaHVqpohLcrKVquMbFFgPOL5
	UNZhE2dBKXP5B/Ws9rEgC8iyvZYcLqAriVUOz/NR4br31l1cF3+ddcoyjqg/6sTx
	frak2yYZTwXp3ZzDbiMg5j4T6x95BCX7Z+wDa0BJk6Ciz5h1l7vnS8bO8wmcSQvz
	LAJaAk4TYORXH/g+tD1/D03HNEZedjw0frg==
X-ME-Sender: <xms:rDqGaTupJ3RyjBxYOconlzeVIODai_g8yeenfyV9jeEfpknP3IT2pA>
    <xme:rDqGaQJJ-LZvQB-6CJFtR9PWqI-1NQ0sMzWhEHfGYdsH4ScoOhvMo797VTtXmCeDP
    qXW4v3Pyca7RIYc50q3y8H7GArdMb_MPSyodxLGG-3lK2c3zqQhzos>
X-ME-Received: <xmr:rDqGaTPjmzOSxYfP-s6PC9WZs-y-VZs7Aou7FO0JPuyDoHCkSScd0xSJV3RkEWUSEHOnsWLU5yN5QAQWjUFa1os-tGx9K6-Mfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrsghrrghhrghmrgguvghkuhhnlhgvhedtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:rDqGabVmoRB1rzI8Ags5Xb9I1P42yhYzJS_6z6LRY8qQIIm_0VuHHg>
    <xmx:rDqGaZnQ3ZTJ5bLnWcV0EN2R2GFngM_rGekl5kmPbJD4GUF6ug-X5Q>
    <xmx:rDqGaSOwpzpA6nfYaA8CIZPsWz7Aa3RRy64F2yAcXKK45NXL9WKVSQ>
    <xmx:rDqGaZKBWx4vILONEvjV-8Seqox-2-PnuOhUZ4vZqh_BPj_y3UeF9g>
    <xmx:rDqGad8n9GGw36JbiqlhOEUuj4Gzck18-Z4_5aoUvKzbINsfv5OFxyic>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 14:02:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 3/3] add-patch: Allow proper 'git apply' when using
 the --rework-with-file flag
In-Reply-To: <10c0a4cb36534f5ed1ebed783b37d03a56007f97.1770390576.git.abrahamadekunle50@gmail.com>
	(Abraham Samuel Adekunle's message of "Fri, 6 Feb 2026 16:57:35
	+0100")
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
	<10c0a4cb36534f5ed1ebed783b37d03a56007f97.1770390576.git.abrahamadekunle50@gmail.com>
Date: Fri, 06 Feb 2026 11:02:02 -0800
Message-ID: <xmqqqzqxelw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> Subject: Re: [PATCH v3 3/3] add-patch: Allow proper 'git apply' when using the --rework-with-file flag

Style.  Downcase "Allow".  Applies to [2/3].

Avoid "proper" as it is not obvious to everybody what you find
proper and why you find it proper.  Applies to any value-judgement
adjective.

    Subject: [PATCH v3 3/3] add-patch: allow all-or-none application of a patch

or something?

> +static void apply_patch(struct add_p_state *s, struct file_diff *file_diff)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	size_t j;
> +
> +		/* Any hunk to be used? */

Funny indentaion?

> +	for (j = 0; j < file_diff->hunk_nr; j++)
> +		if (file_diff->hunk[j].use == USE_HUNK)
> +			break;
> +
> +	if (j < file_diff->hunk_nr ||
> +		(!file_diff->hunk_nr && file_diff->head.use == USE_HUNK)) {
> +		/* At least one hunk selected: apply */
> +		strbuf_reset(&s->buf);
> +		reassemble_patch(s, file_diff, 0, &s->buf);
> +
> +		discard_index(s->s.r->index);
> +		if (s->mode->apply_for_checkout)
> +			apply_for_checkout(s, &s->buf,
> +					s->mode->is_reverse);
> +		else {
> +			setup_child_process(s, &cp, "apply", NULL);
> +			strvec_pushv(&cp.args, s->mode->apply_args);
> +			if (pipe_command(&cp, s->buf.buf, s->buf.len,
> +					NULL, 0, NULL, 0))
> +				error(_("'git apply' failed"));
> +		}
> +		if (repo_read_index(s->s.r) >= 0)
> +			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
> +							1, NULL, NULL, NULL);
> +	}
> +
> +}

I suspect that the extraction of this helper function out of its
original place in patch_update_file() should be done in its own
patch.

Do we need new tests to cover this new feature?
