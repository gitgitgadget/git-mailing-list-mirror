Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E70A47
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 05:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753939930; cv=none; b=EUC89A8lSrnbsat/pckkU7MS/86dNhdi2SjqzW6pwavfPD7OWPp2aQZpDuyJjinhCZJC/k8yStlHsuPZZyePwhyDTPAZA5gPdc5Y7y2fq9yA07zrlBp+lnAA4gy7Ot1WjMrCQXtcmpGb4Ndv2qgYCTfpqCD4MgIry0n/mTx7XkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753939930; c=relaxed/simple;
	bh=x+QiETV5GjsI57GTZVH0ocnzLwmPFiMGePCzf4FoF2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpkX8hrjaHZevVGEj6qw9rWw8zGxp+t/hBmseXaAOL3eZRTPsbYkK3boMlheQMyYu3QDiJZMLUDJn+Y1MUikfbpF0oV74/jijFH+Buq+YwxECBdu3Leb7ekFOG0TdHHYtUlHSIB8l4vHpIUeTvrhqs/1Z7Bruq52jkFEVrJS/Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QFJeU0Yl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CyQedNvN; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QFJeU0Yl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CyQedNvN"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C7A001D006A0;
	Thu, 31 Jul 2025 01:32:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 31 Jul 2025 01:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753939926; x=1754026326; bh=OJxXhf6L1C
	je00ML01GrdDz1AOBrs9to+f+8qliMQx8=; b=QFJeU0YlpMXgbXHG1ZZZJqPi+C
	xoOZI0REdB17/TKTWE7Vve752PKPqfqXvRWxlCSZKhSZHvMqRmukmUb0ri7+JeKi
	+NrWevge4ucqg6NNdPDylCc257eu9R7LLk2BOud7b4c4cfQKCs56tq0jGbVIBXIY
	iYAi4Vmu+pe7zXsyE4dr8o5cP9C4vbM+NHnOuB6DTXMGRze5NdpmRsn+w1Dge0ry
	mCroiOaI9B99q0AGRupE4FrPgSnEO4NPuamTo4+T0QDp1WiAwoJ8MXtah9lNKuAv
	XW2PMvEPS7bv0KsboKTJM314jSuyTPn1I/X91TH78Tb7tNK4XN8CERFbA/UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753939926; x=1754026326; bh=OJxXhf6L1Cje00ML01GrdDz1AOBrs9to+f+
	8qliMQx8=; b=CyQedNvNPvqS/bKhmQpOZ95EDCHHJdVRkx8rzu0KYXcjr+4kCln
	tkK6Nd7ODUj+STixC5w0smacSBN9DRrZz4OonEfPLEtVi45krqFAr+FuWrnBLdbZ
	qpUSpU52tN0mL/pbgIQzGMS2oRnc8wMghH2zTlVRod2pZVvcSpbPRuqk8dJSU2ym
	lp5PwHAx0s/95Jnh4jzILMdz113ZHe3CCtmM1T0bvCV5HqY1ksztpM1gpH0h4J+K
	dieZSxXqSCpou6iutc827VhlYmGfXKpA4pWc0CEJKb0aufUtF0qqfcm3/Hvf2xOP
	xt3+RPq6eAoqXc6+Me3KQb/b5CnfYwwuiOg==
X-ME-Sender: <xms:1v-KaOsAtBM7KqkBaH3ZajeJ6DdTCASdU7lTZqgFlDCoAipY7nFdjw>
    <xme:1v-KaBbP9eZ_QStI8RrJL7cw6ldkh1GMjQosjoL6fk3iXjNf7ZIU3QWg4tqjW3asb
    7Oo8SyaqqIv0-Tfig>
X-ME-Received: <xmr:1v-KaBVuxRRfCIL7-nihIYCcyqhjUlniAs_9m1WhA371DCll9jOfVxgn_4cTflMz5ZweaTdEP-SJ6-M4k82BA8NiUF_ZoD6cEaCoamk4AQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelleelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1v-KaF6o6odfvaf9WxdR1hsd7FOpMy8urdGOEOIIr8GNNIn4Vr3Ngg>
    <xmx:1v-KaMjWakiPobcJvb_Va6ghlDF6OJy3dkHSYRS0m0VwT2rZjHGggA>
    <xmx:1v-KaMcap_RN6kgY-0azwYtLWsNKKo4OBx5sLH8PwCo6oqhLOcxbLg>
    <xmx:1v-KaBc5J8OA0g3WGqPOVekHdayOsT4v5qFHggbrKwBG9xw0eznvwA>
    <xmx:1v-KaBo8fREFCPhkcWX7AdsxSKKPvqswwgOPezeivuzi0VT45xs2q_ld>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 01:32:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eca57d7d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 31 Jul 2025 05:32:03 +0000 (UTC)
Date: Thu, 31 Jul 2025 07:31:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] clean: do not pass strbuf by value
Message-ID: <aIr_y3DM3kS09kKq@pks.im>
References: <xmqqseieogkg.fsf@gitster.g>
 <aImv4kZJS4CUqmZ3@pks.im>
 <xmqq8qk5ojcv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qk5ojcv.fsf@gitster.g>

On Wed, Jul 30, 2025 at 07:15:28AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Tue, Jul 29, 2025 at 02:03:27PM -0700, Junio C Hamano wrote:
> >> When you pass a structure by value, the callee can modify the
> >> contents of the structure that was passed in without having to worry
> >> about changing the structure the caller has.  Passing structure by
> >
> > s/structure/structures/
> >
> >> value sometimes (but not very often) can be a valid way to give
> >> callee a temporary variable it can freely modify.
> >> 
> >> But not a structure with members that are pointers, like a strbuf.
> >> 
> >> builtin/clean.c:list_and_choose() reads a line interactively from
> >> the user, and passes the line (in a strbuf) to parse_choice() by
> >> value, which then munges by replacing ',' with ' ' (to accept both
> >> comma and space separated list of choices).  But because the strbuf
> >> passed by value still shares the underlying character array buf[],
> >> this ends up munging the caller's strbuf contents.
> >> 
> >> This is a catastrophe waiting to happen.  If the callee causes the
> >> strbuf to be reallocated, the buf[] the caller has will become
> >> dangling, and when the caller does strbuf_release(), it would result
> >> in double-free.
> >> 
> >> Stop calling the function with misleading call-by-value with strbuf.
> >
> > I think the second "with" should be dropped?
> >
> >> 
> >> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >> ---
> >>  builtin/clean.c | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > Good finding with an obvious fix. Thanks!
> >
> > Patrick
> 
> "Fix" is a word that is bit stronger than what is actually
> happening, as the code is not yet broken ;-)
> 
> I notice that there are a few structures passed by value in reftable
> (e.g. merged_iter_pqueue in pq.h and string_view in record.h), but I
> only looked at the output of
> 
>   $ git grep '[(,]struct [a-z_]* [^*]*[,)]' \*.h
> 
> and do not know if they are something to worry about.

We originally had a whole lot more, where we passed `struct
reftable_buf` around by value just like we did here. I already got rid
of a bunch of them over time, but we still have calling patterns where
we pass a lot of `struct string_view`s around. Those are all benign,
even though I don't particularly like the calling patterns.

Patrick
