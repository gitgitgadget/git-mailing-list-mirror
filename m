Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73B13EBF02
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771083279; cv=none; b=COII6HYPXN/SWNeip/HXfDo2omhznvgwXD6E3JmTS3glvQ6QDDYfa9nWPwCjx+1MLh4LAJKfL+g1zgYzOf5IfDDZ3RhfX25tgIJ1+O5cxwTLtWMp2LUxcGSWdoCy5dkxfpPa2Tz6GXfrzAgXsrEsjRUuhGwnTbxQFGfVyV/qB+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771083279; c=relaxed/simple;
	bh=38YAgQS1wxm/tc65UgSZ3r5AaBL8xv7qj8J/fW197ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TkmjauOoHKzo54//eTNZh5F+CGk2BxVeJIJ7CftlYN/UdsAqSvgNAsHa3RqB8wINdnD+y2ecLArYS8acje58VRh9uDP+I0dHjOf9mH4nonm2ubJfB16Ix+/DJNO/2KzY1DQPVpjbrU5J8EA5TwVoFdooy5Eu4foL+Za4lkP7I1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D2WBnEBt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EtSwiD7s; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D2WBnEBt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EtSwiD7s"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE1B67A02E6;
	Sat, 14 Feb 2026 10:34:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 14 Feb 2026 10:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771083276; x=1771169676; bh=YEpFYMoaC1
	N95RltIuns4yKuB2Wkpr2Sh5xBkOVR/CA=; b=D2WBnEBtEuCcAM5Imekqkzx55B
	AX4uGR9e/VWsI6fMnULQDxNfyP+DD0+iLenT+nUZ05jLqgTk7sZmd++e9N9p0ULF
	7fKlDlK+Zjkfr18aLGX4AZRRDUjTELEIEMLxQqfd3VnPS2ofy5BtsfRPOeYS5OpM
	XkoDJF8KVuY7JsgtsSC34yIMjOvJxvRl5xktX7EzMCZdUjRm/qLQj85Ku4elq3j9
	KK4ofTRyeAexOfFyf4CCtJvf46qPJSbkYIMGVGPAQaeejwG5LRuIZC0x9uWAZigH
	z6NN0nFKvO7GwoRPtuJaC81Bg7CrAvcDAcqYWZE9glLLAIuxKN2MLMf27ccQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771083276; x=1771169676; bh=YEpFYMoaC1N95RltIuns4yKuB2Wkpr2Sh5x
	BkOVR/CA=; b=EtSwiD7sYHEiKZQWeXKpvU3llBB1MzNmbc4lzumwwSn1AneJeFQ
	vl+rRmJIIzo7u/Kn3nOEC5ZbAP52GwZuwSSvP07kHdkiAoZNhGxwvW3Kxp3DM7wB
	tLcFIVw3cakjO23thtvJAbOjq/CYLYMIB6agTwchyRU4Iy44sjaTtbi1Q2TsGtXb
	XpVublg20Yee/aXkVfxUkGX8gaTx4+GX3OzuHH2ViT1jrNTowHatwgfskU5K8dRf
	fhQIyeSIsAhVVxhsBvBnz8b05IEQcsnsl+gNvrnm3O6ApLXCx+JlBTIGmnHZKkxp
	+ROeUsZ8WePiWuL2n4AysogvB62QO+U/gFA==
X-ME-Sender: <xms:DJaQaZbd2bi2Tl588Qn-4YOel09k230LLBawLcGxJcVlHyYJzVz_fg>
    <xme:DJaQaUFekcPTnYHvvvEQxU65cbsL2PAA_ODkeYPH4Q1shqO6IfE6rQBTm20N3J9-N
    _u0IosftgjdTIuDNhkkZp3pAL51Ei0lVXH1Dg3JevHYzYb8CAS5>
X-ME-Received: <xmr:DJaQaVziQmpL9OyX6Dzj_bwgWSaSdlDEtjH_BpF3yAlOY47HXNQ-_gLl5OpC-wKe8GANFFf_RMMHomRcsAUoyCSHzF8et3M0Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudduhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehshhhrvgihrghnshhhphgrlhhifigrlhgtmhhsmhhnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DJaQael4lq4Phc8OqyDAutyB0UmzLk6tPTs_jJruXRWJqG6v9W5FnQ>
    <xmx:DJaQaWmg9HHiTtZcILSb6WQAmBaL_BWiVal_bZLR1DdS8BWCNZCVOw>
    <xmx:DJaQaYzBQsvGLd_7FMt7PCYEW4U2oq19HmHNMLZHWDfhptG0iaBM1g>
    <xmx:DJaQaTqnaGjPjOHiZE4b5_UmgEBezH0sKARSqUeP9Dq2u1YbuomdzQ>
    <xmx:DJaQaRnfm-KzaIULlbBYVU6fnsLvhFR8wyhv1WkxYPUIuqnBtPmmmfAR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Feb 2026 10:34:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
  git@vger.kernel.org,  karthik.188@gmail.com,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [RFC][PATCH 2/2] worktree: stop passing NULL as primary worktree
In-Reply-To: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com> (Phillip Wood's
	message of "Sat, 14 Feb 2026 14:30:22 +0000")
References: <20260213120529.15475-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260213120529.15475-3-shreyanshpaliwalcmsmn@gmail.com>
	<xmqqcy28jmzs.fsf@gitster.g>
	<ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com>
Date: Sat, 14 Feb 2026 07:34:34 -0800
Message-ID: <xmqqqzqngwz9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I've cc'd Eric for a second opinion
>
> On 13/02/2026 22:29, Junio C Hamano wrote:
>> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
>> 
>>> diff --git a/path.c b/path.c
>>> index d726537622..4ac86e1e58 100644
>>> --- a/path.c
>>> +++ b/path.c
>>> @@ -408,9 +408,7 @@ static void strbuf_worktree_gitdir(struct strbuf *buf,
>>>   				   const struct repository *repo,
>>>   				   const struct worktree *wt)
>>>   {
>>> -	if (!wt)
>>> -		strbuf_addstr(buf, repo->gitdir);
>>> -	else if (!wt->id)
>>> +	if (is_main_worktree(wt))
>>>   		strbuf_addstr(buf, repo->commondir);
>>>   	else
>>>   		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);
>> 
>> This is curious.
>> 
>> We used to treat "wt==NULL" and "wt->id==NULL" differently.  Now we
>> use repo->commondir for both.  For the primary worktree, it ought to
>> be the same as repo->gitdir, so it should not matter, but makes me
>> wonder what the reason behind this difference in the original.
>> 
>> We have been assuming that wt==NULL and wt->id==NULL both meant the
>> same thing: "we are talking about the primary worktree".  But the
>> code around here before this patch seems to behave differently.  Is
>> our assumption incorrect and are we making a mistake by conflating
>> these two conditions into one?
>
> My understanding is that wt==NULL means "use the current worktree" and 
> wt->id==NULL means "this is the main worktree". That would explain why 
> we use repo->gitdir above when wt==NULL and repo->commondir when 
> wt->id==NULL, as repo->gitdir is the gitdir of the current worktree and 
> repo->commondir will be the gitdir of the main worktree. If we look at 
> the code in wt-status.c that's passing a NULL worktree it wants to know 
> about the status of the current worktree, not the main worktree.

Oh, boy.  If that is what wt==NULL means, the above confusion about
the original is perfectly cleared.  We have been operating under a
totally wrong assumption.

> I think that we should add a new function
>
> struct worktree *get_current_worktree(struct repository*);
>
> to worktree.c that constructs a struct worktree using repo->gitdir etc. 

Certainly.

> We should also think about whether we should 
> change wt_status_get_state() to take a "struct worktree *" rather than a 
> "struct repository *" instead (I've not looked at the callers to see if 
> that's sensible).
>
> With that, we can gradually clean up uses of wt==NULL in the rest of the 
> codebase overtime and eventually remove support for it from worktree.c 
> rather than having a big flag-day patch. I don't think we need to change 
> uses of wt-id==NULL.

OK.  I think wt->id==NULL vs wt->id=="/" is about correcting
inconsistencies between the worktree.c and refs.c and certainly can
be done in a separate patch.

We probably should think about how often we use the current one
(presumably almost all the time, given that even wt-status.c API
functions seem to take one), and if the current implementation is
the best way to signal, among a list of worktrees, which one is the
current and which one is the primary.

I do not mind too much about "the primary sits at the beginning of
the resulting list all the time" convention, but wt->is_current bit
looks like a disaster waiting to happen.  To find the current one,
you need to construct a full list and then iterate over the list to
find one with that bit on?  What if there is nobody with the bit or
more than one?  Are callers prepared to notice and report such bugs?

As you said, comparison between gitdir and commondir is sufficient,
then we can lose that bit.  One fewer thing that can go out of sync
takes us one step closer to a cleaner world.

Thanks.
