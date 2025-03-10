Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B61DF996
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639905; cv=none; b=j5KPTl8OmO14BJeVJchcWEqzvunZYA1vJMzmaApK6cDKQ6re5488rRcrIeYLEfeWdi0vTiIw1TpWzgQGszhVrHZw0w+0ee9PctiQfH4wV/jMjosHK26TxXc8WjiCQkL73ffWRl6u9dJ9c8xdb/6kdlYW4RzdNSo9/RkyevcXyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639905; c=relaxed/simple;
	bh=d/fXyGegzc8UtY0WnfvLnupLGdUUGPc9O/iQnnYtHlg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JwpNRr1A8vKKfMlx+yQZPjVMiK1J18DvkeaVlCoX4/6Dz7TadOafjxS4Bc1mFEMX4dQyKTkbmxpHQMm8Ynx61E+rmXhoRbxHIjqoNw5vy635Yh7ghOQHqCADv1ZiUE2CbqDlkjhezXOJQEMRBAFniLUmemC7gPFMyzM6H1dJ1Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benjam.info; spf=pass smtp.mailfrom=benjam.info; dkim=pass (2048-bit key) header.d=benjam.info header.i=@benjam.info header.b=W5PRt8HU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BqwwOYq4; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benjam.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benjam.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benjam.info header.i=@benjam.info header.b="W5PRt8HU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BqwwOYq4"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7BA76254024C;
	Mon, 10 Mar 2025 16:51:42 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-05.internal (MEProxy); Mon, 10 Mar 2025 16:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benjam.info; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741639902;
	 x=1741726302; bh=rQG4IeybhVYj64GspdUD28hwBVgTN9QeemIQDy26voM=; b=
	W5PRt8HUdNafYI4gMbZEo8KmRAvwxb/okRsOz/yI6l2EVE5e/3vbXR14NoRcNSQV
	/VvK18EnB/DGvETKdAmtl4ypJi++X41JZLxy3atUq4oruabNAK2VVrAd+q15XKxW
	Zy6pbEuiiCS4/Y60sBq59S618SvtlcFp+Tfr8Kl8SaN1UL+e6EnHPRz+8PJmaSuG
	dQbd+yvMmUXvRTUDpOFay5LxrzWnd/O/cTxjy7BHC4Hnjxd01DetC+H3xt7p0b/c
	m/7wwTsW9TuwbR/sGQD3vQxJ9hjK7lN1JUHd1/R/TCdtns+6exmtHN/maAjWFgqB
	zzBi2We8pONReWs/nNITFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741639902; x=
	1741726302; bh=rQG4IeybhVYj64GspdUD28hwBVgTN9QeemIQDy26voM=; b=B
	qwwOYq4oVHuV6o5KAUh+/j0XCfVswmdf4/pPgHTGQtYcf1Uzsl0AsWE5ey3bb0BU
	D88uOdhaQBkAsg1SZwgmNbvmxO+JrXRPKcCjdQO7zBEIhu4XYlVK061kjMvDSwQs
	MFPipIMRKh17BssiJ06MWscV23/LX2VZyPAOwIW7VzdidobeddCdrd+yTnCh9+bV
	LFhDn7RntbN1atTtbDdCkJOYfoq2f+60Vg3ll1r5SFFi9rXSzh4m91AhM4B7npsr
	lwjSdcf2IZ/mPW3HM5xpObypwRKBAKwWXkInWptFOptWW+orlHPRnF5jOBIS4no+
	z2vrDaTFbT7k5fZmzNVjQ==
X-ME-Sender: <xms:3lDPZ6r20u7zlVoMeBWbnuCYwykjLcrblGUp60SXtHABh-y3_xNIpQ>
    <xme:3lDPZ4reHVID3wKiL3HN2Reuok8wAXjWZW9erVacySeKboR21Hd6A3X_ZSg3wJaFe
    ORt9xxOlIe2N70ZoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfuegvnhhjrghmihhnucghohhoughruhhffhdfuceoghhithhhuh
    gssegsvghnjhgrmhdrihhnfhhoqeenucggtffrrghtthgvrhhnpeefgedtgeehleevhefh
    gfejteefuedtvdfhvdektdffudevleefheeiheegvdejffenucffohhmrghinhepghhith
    hhuhgsrdgtohhmpdhgihhtqdhstghmrdgtohhmnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhhuhgssegsvghnjhgrmhdrihhnfhhopd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3lDPZ_MUQJeuHL6us6J_0PcCj4IojqMojEkkcwVF0QxrXfyrAPJtDA>
    <xmx:3lDPZ56pAkgvAJggZZ9-EuEo_Ng3C3TGe-jm221ssOKEy68VIaAa0g>
    <xmx:3lDPZ57wcavy-k1pn-a3IC2vE8BzcAZwtYye03lXn6j8pSJ-N0wRpg>
    <xmx:3lDPZ5gDQLQr1EIWav9Tyqt0xDS8TNBiORAlgwEsPtDRChQx3_jMbA>
    <xmx:3lDPZzlEHNGfa9A_K-3K4Y_xmP6APsWag0r4oYkhoTJJnJoxJeXxYPdq>
Feedback-ID: i2c704235:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 029DB29C0072; Mon, 10 Mar 2025 16:51:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 13:50:36 -0700
From: "Benjamin Woodruff" <github@benjam.info>
To: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
Cc: "Benjamin Woodruff via GitGitGadget" <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Message-Id: <bbc8a0ef-737c-44ba-9786-f5456f5ce71b@app.fastmail.com>
In-Reply-To: <xmqqo6y87m4d.fsf@gitster.g>
References: <pull.1872.git.1741240685.gitgitgadget@gmail.com>
 <xmqqo6yejg0y.fsf@gitster.g>
 <20250309033908.GA2361799@coredump.intra.peff.net>
 <xmqqwmcx9io3.fsf@gitster.g> <20250310160837.GA26308@coredump.intra.peff.net>
 <xmqqo6y87m4d.fsf@gitster.g>
Subject: Re: [PATCH 0/2] describe and diff: implement --no-optional-locks
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 10, 2025, at 11:53 AM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> But maybe that is lost in the noise of reading the files to actually do
>> diffs, etc? I dunno. I expect it is more important for status, which
>> probably does not need to read the whole file contents in most cases
>> (and which may be run a lot from the user's prompt, etc).
>
> Yeah, and old timers who run "diff --raw" as if it were a quick
> analogue for "status" also would notice.

Thanks for your reviews, Junio and Jeff.

>>>> I must admit that I didn't imagine "describe" is something that
>>>> somebody would run a lot in the background

It might help if I start with some more context of why I wrote this
patch. We've got a tool that uses the Rust `vergen-gitcl` crate to call
`git describe --dirty`. You can see that code here:
https://github.com/vercel/next.js/pull/76889/files

We use `vergen-gitcl` to generate version identifiers for an on-disk
cache. This cache stores results of thousands of functions and has no
backwards compatibility. We want to invalidate it when *any* of the code
changes. `git-describe` felt like a good fit for that, as it gives us a
unique identifier that's still reasonably user-friendly.

However, we discovered that we'd frequently end up with stale git
lockfiles. This appeared to be due some combination of IDE tools that
run the build in the background (i.e. the rust-analyzer LSP), behavior
that causes builds to sometimes get killed before completion, and the
fact that `git describe --dirty` takes a lock.

I've worked around this on our end, by re-implementing `describe`'s
`--dirty` flag on top of `status`:
<https://github.com/rustyhorde/vergen/pull/406>

So, from my end, there's no urgency to get this change in, or to add
support for `diff` (we only care about `describe`). Rather, I felt like
this might be a footgun for other users, and wanted to do the right
thing by submitting an upstream change.

>>> git describe and git diff may update the index in the background for
>>> similar performance reasons to git-status.
>>
>> That is a wrong reasoning that is completely opposite, though.
>> 
>> The commands at the Porcelain level, like "status" and "diff",
>> refresh the index for the CORRECTNESS purposes.
>
> Right, but "status" supports --no-optional-locks already.

Does this mean the documentation in `git-status` is incorrect? It
implies that the background refresh is only for performance reasons.
That's where I got this idea from:
<https://git-scm.com/docs/git-status#_background_refresh>

It's also worth noting that libgit2 does not do this background refresh
by default (`GIT_DIFF_UPDATE_INDEX` and `GIT_STATUS_OPT_UPDATE_INDEX`).
I think that makes sense for libgit2's typical use-cases, but it is a
divergence in behavior.

>> Yeah, certainly it is a potential source of confusion to have a
>> conceptually read-only operation take locks or modify the repo state.
>>
>> [...]
>>
>> It seems like a big and possibly risky departure from what we've done
>> for so many years. I'm inclined not to rock the boat too much. ;)
>
> Certainly not right now.  But adding a command line option is even
> worse as we would have to carry the support for it for practically
> forever X-<.

What about if we reduce this to documentation changes? That alone
would've saved me a lot of pain of trying to figure out what does and
doesn't take a lock:

- Explicitly document that `--no-optional-locks` only changes behavior
  for `git status`.

- Document that the `--dirty` flag on `describe` will lead to
  `status`-like background refresh behavior.

- Change the documentation for status's background refresh to indicate
  that there is a subtle difference in behavior caused by
  `--no-optional-locks`? I lack sufficient context on how best to
  describe or explain this.

- Leave `git-diff` documentation as-is. I think the current
  documentation of `diff.autoRefreshIndex` is sufficient?
