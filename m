Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B835E8C0B
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732064445; cv=none; b=Wn0vNkDbN3q2m7psbHZ+AhAncJDnqTi2FBI03AVn7nioJx20yXfJZNAXAs/RFHnc/zPXIWT9jFBrkl3iJ6Idie/c6xXtBqOa1dHs87e9fBWNo8/MgIBU8EK2VyZRkjDqMm+UmZOlaHLOwmkkoFeqTzZN35ZNEFpAHciC/q98r/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732064445; c=relaxed/simple;
	bh=tTjeDqe9qmbAofFfO9gxJNdyw/JHizPYk+lm2HCEzLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j/2DtKBc3/tqLGE4yh9TBGOgArVF+17VO+QeA5OIf0pU8Bga6I0/LanERSoxdji96HZfu3zPbk3FSkCpqGQ/ukfOJRyXPKfoceTaCNGSv2C8C+4/fMPLyKJhsYcCuE51FYUc6paCO0Reb1okRcNKGUbKUiftEiFsGAy3f2hrxms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eQyMAKsp; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eQyMAKsp"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A48A113806DF;
	Tue, 19 Nov 2024 20:00:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 19 Nov 2024 20:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1732064441; x=1732150841; bh=c9qirszAxrBVSUDZwkh5x82lrVyeg1VJKJZ
	8YhI0k4o=; b=eQyMAKspIqKeAAdhTJgFCHVOW6D8HsFjS5cqpto5I0pKSRwR/93
	OHU2XcIQ3u3XR0eF9bAzVvWfsqVSoKASpkPzB2EEEcXhZM7zJqRhHs3YlDYOgYjF
	FW3goMQwn2Mbp/gNGwRppZfHpibvgG/CgBNT23dR5ptkcKiNosMe0rpb0yaLEZ+/
	jA7vE+GWC1xo08GIecR3906f+vtAZxcdWq08DsxNwCgpP/fRT04Hxn4+0l5lrpTl
	5BRAE9fMJ+Hcob/udwRlKyMyGfbt2oUC6lWTPiAx5VqIhzE+avPwKV0bYzUbaLCH
	mpAMvoLOQ4wyuBNs9Uvo6xv6PGbyWVnqfkA==
X-ME-Sender: <xms:tzQ9ZwhGsWAFT4JzNKodunIweOe3dCRmaNOg1u_04-BqeqdZv6v5Mg>
    <xme:tzQ9Z5AdvDf9BZNTN7WvCqlI0aKqttX42c1uz6OSuJ9KRE9VT5G28LKDl4rO8gOD_
    6qMqPvD4PX4brHzxQ>
X-ME-Received: <xmr:tzQ9Z4FOyNUJeEDvTlfaJxnLtDsPhD1R2vbgPvr43aV0bvPwCj_PueTuCQ2FnEz1kh4h9XGglIi8P4yNhnaiNJ_7bAv1uUH9gxEj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeevteev
    veeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehlrdhsrdhrseif
    vggsrdguvgdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tzQ9ZxS_oH4DLtfKpvChUnyUC9PYx4EYjk7wDYiCq5plCdD4ErRV4g>
    <xmx:tzQ9Z9wX0RAB8up4uOuhJtbpMr_G6PGGj-T-Q3KZeA14J_d9xBRRBQ>
    <xmx:tzQ9Z_5sLUywO6m5i15SDUygmKTw8TWCWA4NvE2gyEuIod_wpVnDsA>
    <xmx:tzQ9Z6wtCXDhHkkoocFLyST8j3gfG8yRNwDkMHSnG_d00YwylE5qIQ>
    <xmx:uTQ9Z9fMc5o12-9Gt20TOXCFPztuoI0fc2klV-k2TTba83d9gbe-5dQp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 20:00:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>,  <phillip.wood@dunelm.org.uk>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
  <karthik.188@gmail.com>,  "Taylor Blau" <me@ttaylorr.com>,  "Patrick
 Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v13 8/9] fetch: set remote/HEAD if it does not exist
In-Reply-To: <D5Q4AYZ9WSPP.3KOENYK0R7XB5@ferdinandy.com> (Bence Ferdinandy's
	message of "Tue, 19 Nov 2024 12:27:25 +0100")
References: <20241023153736.257733-1-bence@ferdinandy.com>
	<20241118151755.756265-1-bence@ferdinandy.com>
	<20241118151755.756265-9-bence@ferdinandy.com>
	<xmqq5xojgbfl.fsf@gitster.g>
	<D5Q4AYZ9WSPP.3KOENYK0R7XB5@ferdinandy.com>
Date: Wed, 20 Nov 2024 10:00:37 +0900
Message-ID: <xmqqed36btxm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> Your suggestion seems to be the original tri-state configuration that came up
> in one of the original discussions. It was recently requested again for fetch
> to just do this automatically
> (https://lore.kernel.org/git/CAAHKNRGv19rhnqCkJMpE2FomNQBHvSS36aC=fh0UwO+9-6RRfA@mail.gmail.com),
> so at least some people would like to have this fully automated.

And that is *not* the only option, and I am trying to help others
by preventing unconditional warning messages from annoying them.

> On the other hand: considering your points in the linked very early discussion,
> maybe "warn" would be a better default?

Those who want to stick to their manual choice would have to do an
explicit set-head once, whether the default is "true" or "warn", so
their inconvenience would not affect the choice of the default.

I think "warn" is a good default _only_ for folks who want to verify
and then expect they will follow what the upstream does 99% of the
time.  For them, when they do not want to switch to what the
upstream says (which is the rest 1%), there is no good way to
squelch the warning other than dropping the configuration, but then
they will lose the ability to notice further flips at the remote
after that, which may turn out to be a problem.

Instead of "true", "warn", and "false", we might need "if it is set
to _this_ value, do not warn and keep the current setting" to help
those who cautiously only allow the remote affect what they use
after inspecting, but expect that the choice made by the remote will
not be outrageous most of the time for them.

If we want to solve this completely for them, that is.  I dunno.

Those who want to blindly follow what the upstream says 100% of the
time will have to switch to "true" just once manually, if the
default were "warn", but once may be one time too many for them.

And that is why I said "clone" (and "fetch" setting a non-existing
HEAD automatically) may want to default to "true".

> Fair point.
>
> This series has a tendency for growing in complication in each iteration :)

Anytime somebody gets swayed by an opinion to add unconditional
warning or unconditional futzing without considering that such a
move may annoy some users that are different from the opinion giver,
we need to make sure there are escape hatches.  Under the assumption
that most projects only flip HEAD very rarely, and considering the
fact that we have lived with manual setting with set-head and
nothing else, we could drop the automatic setting by "fetch"
altogether to reduce the scope of the series without losing much
*and* more importantly without harming existing users.

I think we could make it a multi-step transition in order to keep
changes to "git fetch" we make in each step smaller, which may go
like so:

 1) Let "git fetch" create missing remotes/$name/HEAD.  No other
    changes.

 2) Introduce a remote.$name.followRemoteHEAD that can say "the last
    branch we observed that they point at is 'main'".  Set it when
    we clone, When "git fetch" notices that the remote flipped its
    HEAD to a different value, warn and update (which would give us
    the "warn only once, do not annoy users by constantly warning").
    The user can delete the configuration to squelch "git fetch" (in
    other words, the repository does not remember the last setting,
    so we refrain from warning "it has changed since the last time").
    No other changes.

 3) Allow remote.$name.followRemoteHEAD to be set to

    3-a) "always", which would squelch the warning and causes "git
    fetch" to always repoint the local remotes/$name/HEAD to
    whatever the remote says,

    3-b) "warn", which would cause "git fetch" to warn when the
    remote's HEAD is different from local remotes/$name/HEAD,

    3-c) "never", which would cause "git fetch" to even omit the
    "copy if it does not exist" we add in 1) to help those who
    deliberately want to keep remotes/$name/HEAD missing (to force
    themselves to be more explicit, saying things like "git checkout
    -b topic origin/maint" and "git rebase origin/master", but never
    "git checkout --detach origin").

And we can stop this round at the first step (plus any other changes
outside "git fetch", like "set-head --auto").

Thanks.
