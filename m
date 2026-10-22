Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686806;
	b=FBFY2Fm9iD7l1xH5Dhr16kkAP29uxxXrk/EN9jS2MpyVhBJ8khbcPoZVnmh8FXIA7MnX
	 /H4RsYFo2TvV0TnqFWLEaLnzjGuTPB95mfdTKFFo/KEBfMJwWhoH6HmeTIf0PtRdgsZGW
	 64Ldeeq2zLm10ue0TjM8KpeHvq3WeIiXtHE9xxUyGnmuSlDMNk7n/0GbkIIQwtJcOtPLI
	 25fa7OD0rnjbEuRQDQhLuASLu9ILO31z8oob1ie53Q3S4da2y3pDqijXs7udpw1zpyX7A
	 WIJPsrJqCd3i19ZBkPbTEUT4E55PhWSyiXN3OlcaPv08pmjXW7ogM6JJFiJlZI9FUyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686806;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=UuXYF7mopCaCkb9RE3Ohvkr+Xd7gsruXGABwT225QbA=;
	b=JiXC0N9m9QcNoLUzknLbhNrXSgV3pz7jhz29vPhWBwOTqmp0vrVGWj8vcTy1aJ35VdUU
	 FpoiffQP/UZarC2vrrnSyIHiynY73tLFVdgVeUfbLGrhzp7gDhlytH2UO1OkvBFLXZaSd
	 ozEkiKSezY4XfGiNdCbO8fdtSQgFPC2LEBi97jkAeppIiqtKeO/N0CNdN9quvnVgdQiho
	 dhWVB5wRhYv85TmwdWaLtwHPaiA2rhhtQ7ljw3H504ZTHm7iA+JcfTqTSTtA5vLZNOBX2
	 YfGr0g1b0Z6WJKrnNdI8OcHW0s08GzS7F+yEAcpmH4+NclmWnXSLj9m5tcn9uerfs4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=BPoGRY4c;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZKzWnAOf;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66354606A324
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 16:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66354606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=BPoGRY4c;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZKzWnAOf
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A1D791D001C3
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 12:33:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 22 Oct 2026 12:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792686805; x=1792773205; bh=UuXYF7mopC
	aCkb9RE3Ohvkr+Xd7gsruXGABwT225QbA=; b=BPoGRY4cTy34ZtfHQ2wd7hwppz
	qp734qvvsUN0O5z9TKSEoV+JM872J4LLQmxlLdVSpnQH1wIyqyN/GsKibH1FJfGj
	8UpYAzHdYpSYvXeJwSwYm8grwAQlKawzIFhSWb7QsSsthqhfJYxL9zxZAmg6OSIp
	gWJE9piMHkYjfjic9NkaU02XW6bFLCglFWKSku6cZMuDO2hsd4C7vm8lJe2xiNgp
	Vm1hvXzaUuGjqiOG0VFB6mymhbGg+cqYO4RDdv3bJBu8GtjbWJASJEhK+wEAwHk3
	D+Fx+T529JDAbLXKpZumV9AJKfCqKLDo811okXiDjETidmyR1s+gvVeRTOSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792686805; x=1792773205; bh=UuXYF7mopCaCkb9RE3Ohvkr+Xd7gsruXGAB
	wT225QbA=; b=ZKzWnAOfuCGEhdefyImNmqHwKLvOySicZN3V6wgo2RS8PqhBpZg
	jw/WW3oy/SZewSlRXdyaWbEGr2wvv+3VGduhrKgjP1jvoUteSdqCLoSC5guV9dFB
	GUUB/KA8h208yYbpwAYp64PukzpcZrPjuCgP4ruZsw44YTuzQIkyE/y/kAjUmEBW
	QQSh29wYldYzytbmw69u/mZky5HCWLIFjdu2OIXrO3F+ogs2dVLq3LKFdV9KUKk5
	OUc5p8LNDlxpjL0bJOryCS9o0PrOCywP/AE7D4IyxLeSiEWateO3DsmR6yZrVriM
	jJm0AlPftIJmzec9Rh/kAwJVzD3/FP97KZQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792686805; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:n08E2MxVhslS3lIsI/aPDff8qZ0dxRzwye85lpzipgxahvT
	yHdSklHd3anI9Ohp/8wv7Li4iujErGX28B/Q8PXqcnew47N2CULQZ1uDOK16iCOD
	O83MtBbr2NOcv+HVuGV164vx2MVQFK+2mLP/MEnbZ83UHjXTfzNpAIn/qOEpHEIE
	zoDKc/Pfq/4rBfllvyT1qoOcKckwQ5N1jizOS239onLaTXHvjTZe0srm6PpdUC1n
	AaqL3tCMysBNgpVra55vaJ7WjKhhwqcfrsa3vWkaFHjJxNyunAiZe25+Z96Fi3XT
	35XgFtB+ivop92SQuvP9OuTFp2BHYmDFbwJtSRQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:nG03Cms1wZ6Vd/ovuWfm2KZyi4xXTswXTB+NNhzOnZ0=:r25C/EYMsx34Hp+wACIcuuWxHJ2OiRXyG11rb9rII4k=;
X-ME-Sender: <xms:1TraathhkvC01LCWKbPYz3jD8JVN_gntB5jn1_KUKe_185JEP3ERZw>
    <xme:1TraahG0xAMHDpmjjtLtXOo_auIrzV5UIGp6JPY_MVf4KUpDYDM915vSd5uYUbygm
    b729e20M0XX4kOplaPpOBgApK8y4B4z8fw1guaB3wobXRoIcbzitQ>
X-ME-Received: <xmr:1TraajSvwKXTYpVkMc52-RJbSdgjspGDO2eycClYf4SbO3V53bbgyYGS-A-7akLKuRVoI5Se02FVfKmQRjAhP9I9dfjlix77wWWw>
X-ME-Proxy-Cause: dmFkZTGmAEtuFbnhQuQ3znrTK6USROxy4zUkB4pCNMrCPIac/zcIqgp2GLArwp+X6pMj+Q
    hqD9l+LbmAlQVgje84gbFqko98FC4NiM3a8yNB/mFWZ1Jrz3JAdUx3Zca9c/zlXUJ0cErt
    w6AI9SsD+Dp2mENmHSteBuFtxxylt4dzSmHZHLoo6ZDzHOY0Lg9wOzdUzb5HfDGTCz8jmG
    vNN6BtJm1sAW0baCbT5HvSTQg+9h/gK1KXSyM6x/I0kmUBlxEyqIygTqwqIhNQpRnxVR6R
    nO4//31iNmJ8kQ7OwyWDkq/QhFQIhHa2+9WSb3DcTA8gJiSgXpgKaIOKncXpPKGglIB6c/
    J8hBnLSO3qNwBtIGFY7So01Tv5N0U7UT+dwQIuzXI1zvZgUMJljdT3G1cHzuM8ePa2swsO
    PBfgprCscfeJZF2vD4D4qy6I8HClAe63a7DCc6Ggr/4F8URU2RjoXr/1of3W3qTdEjOfxI
    bd+Z8w/uqStnhPvPSQroWMPZwtNdIxxSL+RUEKSHdhdNslwKvG9vctznhqASMmTJD+6gdS
    6Q5CBE9+j4bEfju5c8jKNmfQ8mR7Vu2ZtUKlYeuty1RWn4DREgmSjhoPRkFwnXA76FDo8w
    iszGM8yxI/8ctVOXXbAwQNwQkwy1yrTAz/h59KqQYY593rDIzr3cdFpSUZ7Q
X-ME-Proxy: <xmx:1TraauxuTMEH3Y1tzlKYuzXtWgTRzisdV-tZP2DkzIMw-qMO1cHJsQ>
    <xmx:1TraavfQAQtE3IpNGR3BoYHMB5KJ78uU77kl4L5V3ZMkxdlXxf-hHA>
    <xmx:1TraahPh7wcxh6KpekC3-Rd557Ch9BLPj7KYsaY4Yxn2UXofvtwh7w>
    <xmx:1Traaqs3oV_59yiKyrjj4eARqraAgh457nhSBhxNiKOhrcRo_MxEhA>
    <xmx:1TraaukdWPjsY47HJ7Y6Hh0Ur8obicJ1X2Ki5LsdsLoqFE5JZjQ32mCM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 12:33:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Jasper
 Mayone <me@jaspermayone.com>
Subject: Re: [PATCH v3 0/3] branch: let --delete-merged find squash merged
 branches
In-Reply-To: <CAHwyqnXcdgzRnFgFhTfhQFFOgDxUUKoPf2sGViBTiXMK1aNttw@mail.gmail.com>
	(Harald Nordgren's message of "Thu, 22 Oct 2026 09:18:40 +0200")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com>
	<xmqqjynajndt.fsf@gitster.g>
	<CAHwyqnXcdgzRnFgFhTfhQFFOgDxUUKoPf2sGViBTiXMK1aNttw@mail.gmail.com>
Date: Thu, 22 Oct 2026 09:33:23 -0700
Message-ID: <xmqqa4o5itkc.fsf@gitster.g>
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

Harald Nordgren <haraldnordgren@gmail.com> writes:

> So do we go with `--delete-irrelevant` or
> `--delete-irrelevant=squashed,rebased` to give us two levels here? I'd
> rather do the former.

Two comments.

* Naming

I would avoid a negative-sounding word like "irrelevant".  Your work
is almost always relevant, at least to you.

The purpose of the new feature is to find branches that the user no
longer needs to keep because they have been practically merged.
Perhaps --delete-integrated?  I do not know.  The naming matters,
and I hope somebody watching from the sidelines can suggest a better
alternative.

For lack of a better alternative that I can suggest, I will use
"--delete-foo" for the remainder of this message.

* Option value

Another point is that different kinds of detection should probably
form subset-superset relationships, rather than a Venn diagram, to
make them easy to understand and useful.

When you specify --delete-foo=squashed,rebased, do you expect that a
branch that would be removed by --delete-merged (i.e., merged as
identical commits) would be kept because it was not squash-merged
or rebased onto the upstream?  I doubt users would want to make such
a distinction.

I do not personally care about the distinction between rebasing and
squash-merging, but users probably do.  I suspect they expect that a
mode catching squash-merged branches would also recognize a branch
that was straight cherry-picked (or rebased) upstream.

Perhaps the options could be structured like this to be as easy to
understand as possible:

    --delete-foo=merged      Same as --delete-merged.
    --delete-foo=rebased     Above, plus rebased.
    --delete-foo=squashed    Above, plus squash-merged.

Would this be a clearer way to present the feature to users?

Thanks.
