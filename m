Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60F1EE03D
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 05:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775192677; cv=none; b=Qc6506Ya2aAXvHjpc/AB69OB3cMKFMGGSK0FCc9IJnZLbZQdhPzagZ0icltdZvWVlQbDnnpKI/MkEQO/ttEDSXMjB8SNk0XtWMO64QI8kLTh+HoOaBbvIbvcWKwFDiDRajc+fy/HKFBOm9oRS5Enwwkix0ldXMJcYiDtZvIEiyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775192677; c=relaxed/simple;
	bh=fSsn3ykT7ZtVyXOkac2Yc9BhMaC7wooXXkBBXO4VWoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ap6jhQYAUdon39UkW4TSrCdegILpUmw5VWnN5bxOJYRjbBzbgWx4QpGf/lkBjjZvWKYdbh96Xkdp+eovIkcfxH0E9VC6kz7CraJ1nffoTFj4gr8cfn3qVbMDyX4QOCMGrK/NMotNeS6jIegsWAecovjJtb7HUtPo/nXy/7FjfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L0dqhPiF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ku4n0aFt; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L0dqhPiF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ku4n0aFt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E5A667A00D9;
	Fri,  3 Apr 2026 01:04:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 03 Apr 2026 01:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775192673; x=1775279073; bh=vSVcuwiHdm
	C7CI4BUwfLdhdon7OFW3hle2S9koHAVfo=; b=L0dqhPiFD47KlM5orQb/f/oFT9
	8GQgzSy+IiRoOvEe1k5Fxi96WjSFd9x5ySjjF75KyDGVho3wkmrh6vRwcK3qrSLz
	bLJbfPAsiDYWXv+ac+xez3Ue035kJ9cwa6aSnKEZyXONeBphE4fp/Fm++29AYY4j
	gLH3Q6rzkX5rE1dcVkqP+wpmSNp3GchwLToxoFKwOdkT5qiFULGK8AE+f6ePcFee
	hrhK3zS1DQZq3j2xiFyDUUy3ERSciBL36tL2jrf06mW4a3d8i4A91JShNcxNzKL7
	6ViGSC23hQbh4vj85uKPqkBYttFmwvoWq8l6yg5jpr5ga9ZFTWf1WGdasyQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775192673; x=1775279073; bh=vSVcuwiHdmC7CI4BUwfLdhdon7OFW3hle2S
	9koHAVfo=; b=Ku4n0aFt0srJXmHMmanah8Fsg/rtMwF83Kg7QERdj3yabODL/AV
	y+CknlAKWvHT5fcHl2B8qb6MKiN4B+Bbhl8Stlca+hrMRSD22jtPkPQqCpob8BO0
	pLifSUXc1+TQd37wwjMEUs4XYTg33Db7hk2MxZ3TTjhc9G8zYmKz4bfd6/EfjKbY
	RLhNktKukumPdyuaJ2zsIKUH/kUKnm+9FAXPCtwHfnU4KWFdnb19VXOVjpIEkoZ3
	vykRV5vGE/7j6mXWeMtv+WQt3mZTi4/u1LAZRDl1b6JWkBCYyLUZ8ph5u5862vlA
	zNiCst5ISaYmByZn84xGareXELx9jXu10gA==
X-ME-Sender: <xms:YUrPad6dXeskfoZ26lmutszsjHmn81pxLElUE2pQ0Da6eKk7NfTz0g>
    <xme:YUrPadeLDZLn4NC-_wtmwKusmaBXkckTQ5lq9A7RKgo6mVhyN96QDv-HzDTEO6niW
    w1rEijKut2qpeteDJJNv2ZOZzh664ONVMitv84K5PPTRc5KpjOFig>
X-ME-Received: <xmr:YUrPaYGJuT4dqUUFzlk46L8Wp1gLvXSdHijEF5aPujG0d-_NHRX0E1o2qnca4kekgDiHzptNfRK6_RXNhRXRh3sOBS7fY2aLHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefke
    evteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphgrsghlohhoshgrsggrthgvrhhrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghl
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudes
    ghhmrghilhdrtghomhdprhgtphhtthhopegthhgrnhgurhgrphhrrghtrghpfeehudelse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YUrPaWQnAhX4cOOAGQla5_ycHfpCZQ2ldhTor7xDnxjqp6SLnxl92w>
    <xmx:YUrPaWbN_mqAwiF72N4MQQYAZ2MCQuf9-KA_xwGsHFj2cgCUVECbgg>
    <xmx:YUrPaZ3OsFrfsxRayLf5598IPepS1yW4UQExTsfHkx5XffOZfc1WeA>
    <xmx:YUrPaRoDrN41curU0C16gQGZISVCxvDnSX7V8-SZfKVsmZ0Fsziq6A>
    <xmx:YUrPab__iZ2SP5ioOnSmyplncWgULsanZN72xj5tRVTxVliNL9T-lFS_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Apr 2026 01:04:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  chandrapratap3519@gmail.com
Subject: Re: [GSoC RFC PATCH 0/1] graph: add indentation for commits
 preceded by a root
In-Reply-To: <20260402211717.3604688-1-pabloosabaterr@gmail.com> (Pablo
	Sabater's message of "Thu, 2 Apr 2026 23:17:16 +0200")
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
Date: Thu, 02 Apr 2026 22:04:32 -0700
Message-ID: <xmqqpl4gocrj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> This issue was reported by Junio at:
>   https://lore.kernel.org/git/xmqqikaawrpx.fsf@gitster.g/

You are giving me too much credit.  I just knew about previous
attempts and the gotchas.

One thing that we may want to make sure your solution gets right is
the issue depicated in two graphs in the footnote of this message:

  https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/

    Stepping back a bit, I think concentrating too much on "is it
    root?" is a wrong way to think about the problem.  Suppose you
    have two histories, e.g. (time flows from left to right; A and X
    are roots)

            A---B
                 \
          X---Y---Z

    and doing "git log --graph --oneline Z" would show A, B, X, Y
    and Z.

    But in a slightly modified graph:

          C
         /
        O---A---B
                 \
          X---Y---Z

    if you do "git log --graph --oneline C..Z", you should see the
    same commits listed as above (A, B, X, Y and Z), and most likely
    in the same order.

The way we draw A and make sure one raw below A in the same lane is
vacant (to avoid something that is not an ancestor of A steals that
spot) is applicable to both graphs.  The reason why we try to keep
one row below A vacant is not because it is a root, but because in
the graph being drawn, none of A's parent will appear.  Obviously if
A is root, none of A's parent will appear in the graph, but in the
latter topology where we are drawing C..Z, none of A's parent will
appear not because A is root, but because all the parents of A is
excluded.

