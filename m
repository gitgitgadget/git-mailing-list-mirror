Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B258E274B35
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568033; cv=none; b=gxxOYlW8wOCFP61ISv6Zj1wjAFYRwk7TOXoZZHQlMHRDaSGcSxSZ98wTMllqFNmyKzjVupQsdW/eWBMYt4ngSvtfZjp9CltAlZVx7QFdg7UAkCb/JPSYvRtGBYo0THOsv1FBVO2di9BQObVwCglVubVcQGOHUbBEsbehiDVCros=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568033; c=relaxed/simple;
	bh=JcrruJd6BpvrYD/3Vm1PwNYPkjuzq1JhYGs9Q5OsZtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuHeISAE43908Z3RTAWuSxLMhOgXXEIGYpzdOUllnKCsKqoomn6iu1q9AwX8w7j7d8dMXM42lr9HosN972uruvr11/ocx+AzwDpwVsyF0UL9AGiX9qu+Ucggi/lgKSLFI40Hhs3Jil1JwQ7RcdxJ1d4Q1oXJPOMX1vKHcoqmM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qSHFYHmY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RM7gl1NA; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qSHFYHmY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RM7gl1NA"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DB92CEC02A5;
	Tue, 15 Jul 2025 04:27:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 15 Jul 2025 04:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752568030; x=1752654430; bh=tPGw5RUgMM
	kY1yFLrRj1jBqd5g2TV76iwn7gF5ucQlE=; b=qSHFYHmYIMJL7Cxw+5xLGCcJPQ
	BdPAM6nh3TWXo9FdlfhXhz9uJDKXD6ZMzocefcruyc0xS2UJaa04n6AA41ANH5GW
	egVjHFcfSX1OxQnfwlJ/29Lr0sJtpK4/G8PcNuaI28GjcImTJ5bXFl5AJf46GGIn
	j4/vfMbr7Q9GWJt0uSqcg5NWcHBsKcnFntlHS4W7p1uBAyPbeiNreR+owfoJt33a
	n2C1XpU4lY5NJrhgLxth80xU8mqQEmvuhhlPCJQh9sTqQUGhLkEn/Z27Y3h3V+Ur
	ynY5xEYWfURHvAA3R/IFDv8GYxP8Izi7HjNmP35io+P2msRcYol88WV1kR0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752568030; x=1752654430; bh=tPGw5RUgMMkY1yFLrRj1jBqd5g2TV76iwn7
	gF5ucQlE=; b=RM7gl1NAUB0WsCTr55hYtqaqucUWXzx7Sn7bymVmewcyhgBZG60
	AmPbbcP+4XGZR+svH5AHs62DxtAPGua+aEAK2YbD1kQBJIYrCUUjryYhxeDZgckl
	8cY0zSsrv/FxiNrSlNwqANGqWguDN25pWSVcz1r4WaoQIEwB5eq7AsQPMBdHsqCf
	3Ihx8BTunTi9iqo/QaeSUnsY9Hcwfp9vBbsPiFZT4iOhu49C4X9sQgOxptSKlj4f
	4bUxrWn/Aolt2D8mPMhFzKzNt+B+f4ciMwOMU0ndX4sILG086nR2ps9hm0UEH1o2
	kFVq+IIXPXmThb/VyWpcuP5mS99QdwsxoVw==
X-ME-Sender: <xms:3hB2aCUiwQxXWfcpFZMs2KN-HTWjdC5axUNb0yEDeoxFU_JdEFf7Ag>
    <xme:3hB2aOy9Tbean364dqziHESomupLLuMj9RBmqnu-gIbobC91Aenj2G3hXr9V1mooN
    YfvFDxLnzIrBQgnjA>
X-ME-Received: <xmr:3hB2aIMuJspD1UVcgODl10YaHILql8XdM4xbF7QqSJkUQRc0gu-h1zFMd1Z9crS_gPkNaw3FIcE2jQFtLQTMlX_Jx0jpwNmabX3Gs6EAhiabQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:3hB2aH79lcQPJISd18jTH5KiY36lNptZs7M9icGx5AZd_jfalG5ggw>
    <xmx:3hB2aBMOXAfbmEQIwY5TAJQu5TRlKy7O2G6ZUoRCFlAQxrzXvYGfoA>
    <xmx:3hB2aNnC7yV7ezBO3xIeORBeMNkFIp40_T9fbiPPqX35XCG18m5GVQ>
    <xmx:3hB2aATkAhA-6vBLF5aVqfBFx7rYYIUvEd-MfgD-yIuO7s7koTcVNw>
    <xmx:3hB2aPzuowv_dpu8xjw61kt_tEXmaVWBUI4Rl8FTCchTuA3H1CRt6SYI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 04:27:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8824ac26 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 08:27:09 +0000 (UTC)
Date: Tue, 15 Jul 2025 10:27:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/8] packfile: refactor `get_multi_pack_index()` to work
 on sources
Message-ID: <aHYQ2m2_uv8L8ZS9@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-5-f31150d21331@pks.im>
 <aHBTLFvL+eQcw6J0@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHBTLFvL+eQcw6J0@nand.local>

On Thu, Jul 10, 2025 at 07:56:28PM -0400, Taylor Blau wrote:
> On Wed, Jul 09, 2025 at 09:54:53AM +0200, Patrick Steinhardt wrote:
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index 9bbf032b6dd..5956df5d927 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -218,9 +218,9 @@ static void mark_packs_for_deletion(struct existing_packs *existing,
> >  static void remove_redundant_pack(const char *dir_name, const char *base_name)
> >  {
> >  	struct strbuf buf = STRBUF_INIT;
> > -	struct multi_pack_index *m = get_local_multi_pack_index(the_repository);
> > +	struct multi_pack_index *m = get_multi_pack_index(the_repository->objects->sources);
> 
> Is the first source always guaranteed to be the local one? I assume that the
> answer here is "yes", and there are certainly other places in the code
> where we make a similar assumption. But just wanted to make sure as
> this popped into my head while reading.
> 
> >  	strbuf_addf(&buf, "%s.pack", base_name);
> > -	if (m && midx_contains_pack(m, buf.buf))
> > +	if (m && m->local && midx_contains_pack(m, buf.buf))
> 
> ...hmm, maybe not?

The answer is "almost always". The only exception is in case there is a
temporary object source added via `odb_set_temporary_primary_source()`,
for example for quarantine directories.

Generally speaking this patch here doesn't really change anything, and
we could just as well drop the `m->local` part above. But I think that
overall we're not doing a good job to track the local object source, so
it felt safer to me to add the above guard.

> > diff --git a/midx-write.c b/midx-write.c
> > index f2cfb85476e..c1ae62d3549 100644
> > --- a/midx-write.c
> > +++ b/midx-write.c
> > @@ -916,26 +916,8 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
> >  static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
> >  							const char *object_dir)
> >  {
> > -	struct multi_pack_index *result = NULL;
> > -	struct multi_pack_index *cur;
> > -	char *obj_dir_real = real_pathdup(object_dir, 1);
> > -	struct strbuf cur_path_real = STRBUF_INIT;
> > -
> > -	/* Ensure the given object_dir is local, or a known alternate. */
> > -	odb_find_source(r->objects, obj_dir_real);
> > -
> > -	for (cur = get_multi_pack_index(r); cur; cur = cur->next) {
> > -		strbuf_realpath(&cur_path_real, cur->object_dir, 1);
> > -		if (!strcmp(obj_dir_real, cur_path_real.buf)) {
> > -			result = cur;
> > -			goto cleanup;
> > -		}
> > -	}
> > -
> > -cleanup:
> > -	free(obj_dir_real);
> > -	strbuf_release(&cur_path_real);
> > -	return result;
> > +	struct odb_source *source = odb_find_source(r->objects, object_dir);
> > +	return get_multi_pack_index(source);
> 
> When I first read this I wondered what would happen if we passed in an
> unknown object_dir such that odb_find_source() returned NULL. But that
> function will never return NULL, and instead will die() if given a bogus
> object_dir.
> 
> So this is fine, though I would have imagined that we'd return NULL
> within odb_find_source() and let the caller die() (or not).

Fully agreed. I've got a follow-up patch series that does this
refactoring.

> > diff --git a/object-name.c b/object-name.c
> > index ddafe7f9b13..1e7fdcb90a8 100644
> > --- a/object-name.c
> > +++ b/object-name.c
> > @@ -198,16 +198,19 @@ static void unique_in_pack(struct packed_git *p,
> >
> >  static void find_short_packed_object(struct disambiguate_state *ds)
> >  {
> > -	struct multi_pack_index *m;
> >  	struct packed_git *p;
> >
> >  	/* Skip, unless oids from the storage hash algorithm are wanted */
> >  	if (ds->bin_pfx.algo && (&hash_algos[ds->bin_pfx.algo] != ds->repo->hash_algo))
> >  		return;
> >
> > -	for (m = get_multi_pack_index(ds->repo); m && !ds->ambiguous;
> > -	     m = m->next)
> > -		unique_in_midx(m, ds);
> > +	odb_prepare_alternates(ds->repo->objects);
> > +	for (struct odb_source *source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next) {
> > +		struct multi_pack_index *m = get_multi_pack_index(source);
> > +		if (m)
> > +			unique_in_midx(m, ds);
> > +	}
> > +
> 
> Makes sense, though now having seen this pattern a few times, I am
> wondering if it would be worth it to add a utility function that takes a
> callback and iterates over the various MIDXs. But perhaps that is taking
> DRY-ing things up a little too far ;-).
> 
> For what it's worth, I do think that what you wrote here makes more
> logical sense: MIDXs are tied to individual alternate object DBs, which
> here means that there is one MIDX per "struct odb_source". It just is a
> little more verbose to type out.

I was wondering whether it would make sense to add a looping macro, but
I ultimately decided against it as it doesn't make too much of a
difference to really matter. I wouldn't mind adding it though if you or
others feel strongly about it.

Patrick
