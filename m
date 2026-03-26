Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F918635D
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563071; cv=none; b=CaJZTW9N+VQw2TeRQAvK9GVIQAKe9RetP2Yl7WBGIDmIZFPiu4gY6tWq5dTz92Lom4K+InSaNhPRV7G4smLgyg+LfBCdPPtHO25G2cjN07phsHalW6L9593hSKj7y9X9pvNxGYyE1kp5IYuNxRm4YyqHAuq6kHBkSRT6qIVesaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563071; c=relaxed/simple;
	bh=o5nJuX456YAKemjtwz+2QvA2CNSJ94CNWubG2Hf+6Sc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MvG8w9NXvmZeff4ixuEKt+rk1+z2nn3JOznF/Zi7EvGylU80RzWwRWwHCzByOZhj30Ser69G4fv/tZWkkdO10W8ICQdavQTrEVOVtMNWRR2roLmP/NM3VlTStA+guSep+owTLpZdR3sGWNBhnoF7DGPvYt9fMDT25PIZQdauguE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YY/x7tnq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CZZAQJt8; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YY/x7tnq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CZZAQJt8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 00B23EC0203;
	Thu, 26 Mar 2026 18:11:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 18:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774563068; x=1774649468; bh=BQhR3VBe43
	1o08Xhx8L4Gj1XFqyDAUVY1FlraTzhqtU=; b=YY/x7tnqt3YKmlT9aSGkUKxpCx
	tpU08xNEHdAaxwpksdYmE8mrMOqhROFS4c6bEBmvPu5BeFO9qAZn5Yk9CmdTj0uv
	Ui5uqGGhY/Ao2DUgiYWz4lbhTke2QO8eGVoJrnSpSUhi+UaU4EvUKiM7J8CCe/Ti
	64qmo5SU0NKuaR08Cg+X93yhygr2lTyN5JeoXoDP3t828B/ePh4YiNNMlkBFbDIa
	aK9zn5OKNgsBh8vQD7FBmDFxGfpdpaZXs3rGEPACkvl36uIlDkvhN+tX3OBPiJVH
	iGF7bTlX/0CNih0YOjAQhZarwz1GOYenDN4zXHt3TK3tZp8Q9GUjeDOU2eDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774563068; x=1774649468; bh=BQhR3VBe431o08Xhx8L4Gj1XFqyDAUVY1Fl
	raTzhqtU=; b=CZZAQJt8QLe39yw42JNL/jmZqWHCuUyW+TMxndwXZaBkAV9bMs+
	uaFGyW/icYE0oi48YTCQ2+mVfc6xtV0gZEA36xcfS5azH6kNVyjBDYnVK/kjwymE
	VK14XuCJv++MNcxRJ8LdJlNiw8iEZzUG5xG2PU39AUhm7E7T+AWB7POdqAKTNdAd
	3oNqXdc9E5oQkWokkRshgURrvzRRCH++Epzz/jd1DK//oJHzzbn4ULUIfHNGqZ0K
	ulQ/AqI/viZQxGFTjsfi8V3twMae8SBVYijGwAC8Ie1odgq2/+fg/Qh3H+Yx639s
	Xb9r2kdFlrQzOnIKSUqmIwlXxwPJeWxvEPw==
X-ME-Sender: <xms:_K7FaeswyhzVlC_MFckVXcJVXy_UAl6NASNyl8P6zYm3aaPDEe1WiQ>
    <xme:_K7FaVv6e8vJtJ0Y786nN9Ns_IFeCSlyUqLzwvYdRS6VjxbDivE-i78FsOwRy8H5m
    o-hgWUE_PGKIG2wKWhxIALa8KFZ9B91Y9F5cJLYDFNxX2Dw1cx6SA>
X-ME-Received: <xmr:_K7FacA236dxWZ_4e6IFaffk2vHLz8iVWqIBnoxVBxYygRUPVy7FPLLSduUii3d2L2jTuhYc8oZ4RUDIZkBLFIE39WxzC9VNXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_K7FafM96oyKFGknAtJwE-6G4tWU-uzgs8aA7EGE8FKokN-i_ZhxXw>
    <xmx:_K7FadyGHZETAnEsaX-3Ejk_xPKY2J9_TIm7bMC7Y-DEpOBhlXwSsw>
    <xmx:_K7FaXVz2b1Gl7gEQK3RTZn2wYsJ9VnsffBl1Ecj4z4j4ydH39QUYw>
    <xmx:_K7FaXOiB40yV0cWUv52Wt-r2PXQfeJarqkFekPzjlPKglE2h2GmEA>
    <xmx:_K7FaVu8JAn-cvse54Wma37iMAE0DPE1bdtNum8DdpyYTDwWfEqDJV_x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 18:11:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Elijah Newren <newren@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 2/5] pack-objects: refactor
 `read_packs_list_from_stdin()` to use `strmap`
In-Reply-To: <acWoqXUwVUB2/65T@nand.local> (Taylor Blau's message of "Thu, 26
	Mar 2026 17:44:09 -0400")
References: <cover.1773959041.git.me@ttaylorr.com>
	<cover.1774482700.git.me@ttaylorr.com>
	<d5cb793f0eb0028f1f521fec4723ad2b00592638.1774482701.git.me@ttaylorr.com>
	<9e320604-7367-4f48-a943-f7d22feb2672@gmail.com>
	<acWoqXUwVUB2/65T@nand.local>
Date: Thu, 26 Mar 2026 15:11:06 -0700
Message-ID: <xmqq8qbensw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Mar 26, 2026 at 04:40:00PM -0400, Derrick Stolee wrote:
>> On 3/25/2026 7:51 PM, Taylor Blau wrote:
>>
>> > -static void read_packs_list_from_stdin(struct rev_info *revs)
>> > +struct stdin_pack_info {
>> > +	struct packed_git *p;
>> > +	enum {
>> > +		STDIN_PACK_INCLUDE = (1<<0),
>> > +		STDIN_PACK_EXCLUDE_CLOSED = (1<<1),
>> > +	} kind;
>> > +};
>>
>> I kind of wish this enum wasn't anonymous. And it matters later.
>> Let's call this 'enum pack_input_kind' for now.
>
> Hmm. I don't feel strongly about this, but I'm not sure I follow the
> reasoning here. The enum is truly only meant to be used within the
> context of a stdin_pack_info struct, so it felt natural to keep it
> anonymous above.

The only thing that makes it beneficial to have a name is if a
code like this one ...

>> 	const char *key = buf.buf;
>> 	enum pack_input_kind kind = STDIN_PACK_INCLUDE;
>>
>> 	if (*key == '^') {
>> 		key++;
>> 		kind |= STDIN_PACK_EXCLUDE_CLOSED;
>> 	}

... that uses the type to define its own variable outside the
context of the struct needs to be written, right?

If these STDIN_PACK_* constants would ever appear _only_ within the
context of talking about the .kind member of the stdin_pack_info
struct and cannot possibly appear anywhere else, then there is no
point naming the enum.

A free-standing variable could use "int" or "unsigned" as the base
language C does not differentiate different enums as separate types,
but let's not go there, as -Wenum-compare and other warnings do give
us opportunity to do better than that.


