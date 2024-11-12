Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A55B21A6EC
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452288; cv=none; b=bRyUyBCWos4ByKGSlsKi1k5ByFLdXONe1WEV7YXlpTEunYcCTyqkqLQqFYDGDKvJ5+zvvROr9KmxcTST6+ti7IngjJOCZvq+qECoMBE0Y7FrNgvcnZ8KTBH+Wlp9V9dr4UTwVY80Le7UwTvx0UY3m0gmkgC4137N0wolXqVwzl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452288; c=relaxed/simple;
	bh=j5KW6dU7GU49r8GG7vldgIekqyiFgaDLuSwzRE+U8xk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gbUyZ9MzALc12bPzIPBfVdH5DJgchmUfKgBM1NnijTheHmfsY03UxngClUa7VbfBGlqZf7fxQoFVyMCR0IXOaAwcZitmNjpNV+Vu+mgpFagbWvmX294i7AyAsHUa2pq4Wso/qFDS7+Zbw17A3058KKr2lGbQeJCzvyAgjR/jKu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cGbLqkxn; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cGbLqkxn"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4458825401CD;
	Tue, 12 Nov 2024 17:58:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 12 Nov 2024 17:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731452285; x=
	1731538685; bh=yS5VTVxGpjD27PqoQaZwz1zegjVU/e/V0/wbmFPZchk=; b=c
	GbLqkxnnrzJ5Snn28CEDqERr2ByMJOsLHfS975wc9eJTe1vu07YA7gy3yEQb+Hno
	xedWwVzkC6NOH0EvQZBQay0SmGjyfx8q8DME3yCVpUodZ8DJPmODnWrkkmKpCY+S
	yzkbiBit65mYYE2Jk+rNsP92VNW3iX3/m7o4+FHGirscSvYZtHAHYNURDraC1KlH
	j6Szug8BgkdA3dUmhrs8xsF7ycM2xuLPxk4ecyVBxMQFYhT0dfMp+GS8su4pHO4p
	LA2xCqrf+Jm5AHptdlE4TslvhKeAFG27lOqnYa5PNglGx3cWVETYxjH0q3kiddSh
	ovnaIsg90b+BpG4j59TYw==
X-ME-Sender: <xms:fN0zZw_ntn57aXBPQ_GrKCO5VgSFWrJcjda5ypsJ3ChXcTxMZAa3_w>
    <xme:fN0zZ4v3QZMYkm_nNSx4AUEdYD9n2Hb8oIqmFm25wgF0W_hk8INQtONMns0ty7Om6
    D5hjfdH8KKGjPMmmw>
X-ME-Received: <xmr:fN0zZ2CgAa2W2d6Fc1kKmcuXuyTup9EUYu3jQJv389BBatviV6KzN6mr0E_n998ZORftmhneidPOE3KcMr9zQnsjRaXHiodR9dgN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:fN0zZwf1Kn2OdrNqi-da3JIXW6f6hUxryx3FpoWLR7OzhehfGYjl9Q>
    <xmx:fN0zZ1NiJhTav9LlVZHWbiEgLYmsm-lw_OeZsoOwX7F9Jd7YQD4eeA>
    <xmx:fN0zZ6kLGTCsUmzYO5ZuOuVKLqpmw4lWActzo8Iidz0WFYjDkOZq7Q>
    <xmx:fN0zZ3tejbv-cwTyFJAMA-VvUX2-Z0vhDJgYlCggZdjJTqL3pXZVdg>
    <xmx:fd0zZxAueJjVNsiuBJZAbGGKi8qqUNZY9ZnTDqvj7my62w9GYnT1GsIF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 17:58:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>,  git@vger.kernel.org,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
  "Taylor Blau"
 <me@ttaylorr.com>
Subject: Re: [PATCH v3 1/4] Documentation/git-bundle.txt: mention full
 backup example
In-Reply-To: <aeb7acb2-792d-4ec5-bcdf-da2eceb49c4e@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 12 Nov 2024 18:31:28 +0100")
References: <cover.1730234365.git.code@khaugsbakk.name>
	<cover.1730979849.git.code@khaugsbakk.name>
	<b222c6787a79c852442969721dadc629ca84cd5b.1730979849.git.code@khaugsbakk.name>
	<xmqq1pzmqy97.fsf@gitster.g>
	<d9b1dac0-5b30-47c8-af47-190f4ed96748@app.fastmail.com>
	<aeb7acb2-792d-4ec5-bcdf-da2eceb49c4e@app.fastmail.com>
Date: Wed, 13 Nov 2024 07:58:03 +0900
Message-ID: <xmqqh68c3vr8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Maybe it’s possible but I kind of want to say “okay just pop your
> stashes and make regular commits/branches”.

That requires _more_ than recording the value of the ref for stash,
as data for the Nth stash is recorded as the Nth reflog entry for
that ref, and the reflog data is not what fetch/push/clone/bundle
commands make available.

> I’m not sure how to formulate that.  Seems clumsy:
>
>      refs are included in the bundle (also `refs/stash` but that
>      particular one won't be included in e.g. a clone):
>
> Would it be too drastic to use a footnote?

I am not sure what you want to refer to with "that particular one",
but the value of refs/stash does get recorded, and making a mirror
clone out of the resulting bundle does give refs/stash with the
value of the refs/stash in the original repository where the bundle
was taken from.  So refs/stash _does_ get included.  What is not
included is the reflog data for that ref (or any other ref, for that
matter).

Because the ref value is transferred via fetch/push/clone/bundle but
the reflog (i.e. past values of a ref) data is *not*, "git stash
show stash@{4}" is not something you can recreate in the copy of a
repository, whether you create the copy with "clone" or "bundle +
clone".  The story is the same for other refs, and stash is not that
special in this regard.  "git show master@{yesterday}" in a freshly
created copy would give something entirely different from what you
would get in the original repository you mirror-cloned or took a
bundle from.

You'd need "cp -r" for that.
