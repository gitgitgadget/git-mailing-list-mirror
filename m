Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8134E1C4A1B
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786117; cv=none; b=AYCw5kxphjBcgU2/Y4JJKrwmT4v1OBNe9XxnaZ49Rt8KUunLyvLWBg9x6bKkOg12kDx362FSg0MQGsnzLvYLZR7okE21C8N3lGxq0eekNBCLBj5FLHCjnpUGDiyh2pZoJs4MflRsC8VYBt2LBSle9HI2CQw3kk3cwTtCCF7z0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786117; c=relaxed/simple;
	bh=27N/BsT79RpU2okVSt28xJUbeWj06xhHHWZqM7UBWy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxoGrv3pR7O+KUdeDOnA+4vO6gWS8UnFC+zVI47WC7GUhnPE45L/fKHpDexSBJy8mKM++3t/MiLdB+U4iyntOtsE/tJ16209LDWMDprL1MB8Tc5GU0289/t5RGzTQBIxjuFrQBn2kPd4mpTqTjzSmczGur7nR/4Snf5sNq48Gj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YkyYCFKg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mlhtnL2/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YkyYCFKg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mlhtnL2/"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B7923114016A;
	Tue,  5 Nov 2024 00:55:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 05 Nov 2024 00:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730786114; x=1730872514; bh=jSukZfYOjr
	esg/fLAWU4Rhg4xiNWzqS77HyzKefUZ/0=; b=YkyYCFKgXaWCD3Z1FzpE/Qp2DD
	+s8Huevs+tc7fScnheroCgy9aRUUHy4pWTNYlySR3h4GbKGF45FGrzpNQVzgYmL1
	7PUDVre1/kCm7gwI9FBBy5eNsdrwfXqIPsbcgEyWvMO0vmmDwf+S2KIDPB0/5kor
	k61tRVKh2dEttg3PAEtjJ9IjAPeGAsf6c4SOmGJQwVc9/b/RCRmXk1Xs8LxCz8VE
	yGucPmZWRNPjnvIazJ1mZdT/O5CjU95ojR06PQ42qN/f02zhIjth3CcPrYnNdJMz
	wrth4VzvUs8TZLPCZbay1EaRcrf8Du4+zMUPKhRfmTHr3d5PP/WaEOfIPwdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730786114; x=1730872514; bh=jSukZfYOjresg/fLAWU4Rhg4xiNWzqS77Hy
	zKefUZ/0=; b=mlhtnL2/lrsGOPu4HILRMx9/RNONn1HFns4BJ4z9DaUv5c6KPP/
	4BsjMefW9gojOqj7pzOlLvsjEWRaLS77YyKdbQeI89yLUUCp3xrony+hBHlLTSq5
	9P47os2+IomgsI7kFasXuEHd+y6YK3JR878sCwpt6s6nHfphd4sKzwszKNqAvRD6
	qQvUrLreqPwyAVAugQq5brB7XoOs1hxQXy2cTN3LWt3Bwnsd9BlAypltd6MkH/Qy
	MxJRboWIbzlyVdQMhMEFRpMtREfIhOpdQr4gn17S4smRcbsVPV+7D0xFXJjlzgCa
	Tt/H9+4Q4u1CSckFcmqkUifhBsBL4t0oICg==
X-ME-Sender: <xms:QrMpZ4BoOIx81qjPzzFOrVh57V2R5_PGcu7nJ357ZcmN-5agOV-c9Q>
    <xme:QrMpZ6ia3f-ut3MU-7r4JoJ-Xi-nNA2Su63ENguDnL1tkzcjIol7pVWNOfrU2EFWw
    Oxa6PNb80LplHYM9A>
X-ME-Received: <xmr:QrMpZ7khjkRnd7rscS2_FQ2tXvjN5cLSMcyCv6j7czWzwOIK4S8WLXU1tbFna8XHzVcz9Bfk-hc1lQqQp-AXxEoIkb5klhAacyFpL6iMtEuGDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:QrMpZ-z9P6zb8zsVELTfw4io6oB5tx_Rg8G8VgVo6rm0UrPvBEf9DA>
    <xmx:QrMpZ9TpNM80YJyJP6sfi7zet_B3O2fPlPggP7sn2GWyqx88ICM6bA>
    <xmx:QrMpZ5aj8qsgHJ1I3J8gvp3xe9bm6_AV3SYnAQSLtYiHJcuIUeqPoA>
    <xmx:QrMpZ2T8LYqBTN5ompnLg5_TFat2tObum1PXD-9KaT3tWag98Xpo8Q>
    <xmx:QrMpZ7MzFUsiN1SennctRaGC8S00Cd-tsdvSGcf6QhhTRWAeOhKL4mH3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 00:55:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 698aeff0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 05:54:51 +0000 (UTC)
Date: Tue, 5 Nov 2024 06:55:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 15/22] combine-diff: fix leaking lost lines
Message-ID: <ZymzN5TQK5cpGw5Z@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
 <76bbcb3fe301fe273578a71849f99953ea94695c.1729502824.git.ps@pks.im>
 <rbjmoxqrfpcpz2b5oqxcchuwpbvw4uz4ps4j7ctkd4ux5h4xwj@n4mngoog4ffd>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rbjmoxqrfpcpz2b5oqxcchuwpbvw4uz4ps4j7ctkd4ux5h4xwj@n4mngoog4ffd>

On Mon, Nov 04, 2024 at 04:43:38PM -0600, Justin Tobler wrote:
> On 24/10/21 11:28AM, Patrick Steinhardt wrote:
> > The `cnt` variable tracks the number of lines in a patch diff. It can
> > happen though that there are no newlines, in which case we'd still end
> > up allocating our array of `sline`s. In fact, we always allocate it with
> > `cnt + 2` entries. But when we loop through the array to clear it at the
> > end of this function we only loop until `lno < cnt`, and thus we may not
> > end up releasing whatever the two extra `sline`s contain.
> > 
> > Plug this memory leak.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  combine-diff.c           | 2 +-
> >  t/t4038-diff-combined.sh | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/combine-diff.c b/combine-diff.c
> > index f6b624dc288..3c6d9507fec 100644
> > --- a/combine-diff.c
> > +++ b/combine-diff.c
> > @@ -1220,7 +1220,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
> >  	}
> >  	free(result);
> >  
> > -	for (lno = 0; lno < cnt; lno++) {
> > +	for (lno = 0; lno < cnt + 2; lno++) {
> 
> From looking only at the code, its not very obvious to me where the "+2"
> comes from. Not really worth a reroll, but it might be nice to leave a
> note with some context.

The code is quite convoluted and hard to read, agreed. In any case, we
call `CALLOC_ARRAY(sline, st_add(cnt, 2))`, and as a comment further up
mentions:

    /* Even p_lno[cnt+1] is valid -- that is for the end line number for
     * deletion hunk at the end.
     */

This explains the +1. The second +1 seems to never be populated and acts
more like a sentinel value.

I don't really think it makes a ton of sense to explain why the sline
array is overallocated when freeing it, and we already do explain it.
But I'll touch up the commit message a bit and sneak in a fix of the
above comment to be properly formatted, which also gives the necessary
context when reading the diff, only.

Patrick
