Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBC721CFF0
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723488; cv=none; b=I9BIDpb8jHvYEHp5JzTEuphNJ4XJbw2dG4tLvYCtS8f2zmz3yN6OiguNe68NTd2jhTzvK+xkOS4mVgL9VSde75hP6ThcBEeJauJbhzFN7lCKyqobUbDKfiDNNpL9KoQBlgOpXFE1fS3+tNU3z9MKY9UV8mHpn+j6hzJXj30VX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723488; c=relaxed/simple;
	bh=nqWG2sa2Whdl3vUJrQay1WLAyLfRgSI9fq0iDHg41Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9adHok+8E70K5TsJJEYxdaMvnouwwQVxKdl8nMO2vMlxzsxGKVVyClr7lmcyCbAmZxCrB82VDLXRJhbEUUZyG+cMMp4X4Lqu/l4WztZWMH/lH6stteDuONPukfrtXo7KBNm6puEwXa5EGO6Zf1qHS+yBXoBZKq+FHIbp1HDJXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OvTsgV+v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VaCEzy1G; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OvTsgV+v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VaCEzy1G"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 39D26114012B;
	Fri, 20 Dec 2024 14:38:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 20 Dec 2024 14:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734723485; x=1734809885; bh=oicAFRBmYY
	FeK5aFtgrAxrGMmnWoWWxod40Y1vnjtHs=; b=OvTsgV+vnH1G7gjg4rXTdNRDb3
	Snkqrt/agCv0/xbUEy6pfr5FzmPl4lEpjkZ+tZElkEiuCHY5Wk4FV78xQ4aJr+/2
	fLlXWALayTD3jMS1ipwCr6M34Uh5gRuYIn0p4tq6YO5Vif4NA7uN3CGZzy52z6KJ
	h+UqSAmCVy+eDElSI1eYvXUWwZIMRZTeuZ7SB1cb4pZzVN1ptXr2mLUKdu7/mR/T
	/dWy2eDC26lJlKk+u9nCBQUxr3Py/N22N9tzpsaYkTyOzxQiLdT69qyxO2mNGJXK
	ky2EClCfvnGv5JymUzerrp98D/ZQmdIzDUXiBxUQWNvnCuO2MalDntS+54Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734723485; x=1734809885; bh=oicAFRBmYYFeK5aFtgrAxrGMmnWoWWxod40
	Y1vnjtHs=; b=VaCEzy1GKjJ4o8Bc8TzEHN81Hv+xcAfmB+dqkfRKF54Ff6i3LBR
	uEI5lb7VI2sw4W8SW7hKGlvTXiwkIdPW+SBIj632Gq3hFroAdYxgOa1dCVliYdpW
	RyuTVti7Hal9dZg9Rx6egOt5eekSeZbhUNEAY/5FDqaau9mU0rQsOitJ03uq8r0I
	wpw4XLrEVg0UOq9+hiFWrd/vUw+puxO9J5G6Bu63ZSCzPLhXCtdeNEiT85jLK3Ya
	P9TChE2ZBNr3oqb00/lt8QiiLJLedJ0/yiD2CL8He0MNCQuP8FuGHQNfs+XeQZJi
	DgQQ/8JNTc3/qsxSJzruKipvNIKAK/EZdeg==
X-ME-Sender: <xms:nMdlZ68OZlelPep3g8g8Ko9t7HOFLk9ikDPO6iTFlpvXr2BI03VxjA>
    <xme:nMdlZ6uW73qMQNYKjK53Ru-7H3r1gEC0NF0-d9kHdWtrT64rVtEzSfsyWSgXOEDgE
    P30k2GlcAPdwvyX8A>
X-ME-Received: <xmr:nMdlZwAhZcCDrDN3V3pCBLkvfUyVEhJ4TF-BrpMkd8n_xN3PpdFTYEVeAhmJziXsLSfIXdb_6NaDnQvZs_ibuT6J7bV1g6cLpbwjlEY9GbRMWr0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggv
    tghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nMdlZyd5mHccQapfy7J3jMAegLLFwfh41d7X1YhBIN9iZb_M3Xckmw>
    <xmx:nMdlZ_Nj_KYDr4hkVdM92ccRwaJxHb54VrNJddAIHxOvDURgZrJQdQ>
    <xmx:nMdlZ8l8LTrkyIyUPOznIhgXbNjXWR5Q0Vdpt-qMdgrisROUdXIeeg>
    <xmx:nMdlZxtJZG2g06ZrYoNOrr9bkaqSGqG6KWGyuW19SLtyFulDqOrPGg>
    <xmx:ncdlZ4pSE4bw9jfrln_WLCsSCoBQTdQwrYg681X3fLBMyZRZ0IC-HkcB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 14:38:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dd6f56ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 19:36:08 +0000 (UTC)
Date: Fri, 20 Dec 2024 20:37:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.48.0-rc0
Message-ID: <Z2XHfzLEBUfqygBq@pks.im>
References: <xmqqfrmn4hr9.fsf@gitster.g>
 <00ad01db5017$aa9ce340$ffd6a9c0$@nexbridge.com>
 <Z2EC9rq3F0rTljff@pks.im>
 <010a01db508a$4544d750$cfce85f0$@nexbridge.com>
 <015901db50b5$e3a7f6e0$aaf7e4a0$@nexbridge.com>
 <Z2JyFB3CddYM_LP4@pks.im>
 <00ca01db5257$12708d00$3751a700$@nexbridge.com>
 <Z2UX2v8sc-DELaVm@pks.im>
 <015501db5314$b61ac2a0$225047e0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015501db5314$b61ac2a0$225047e0$@nexbridge.com>

On Fri, Dec 20, 2024 at 02:23:49PM -0500, rsbecker@nexbridge.com wrote:
> On December 20, 2024 2:08 AM, Patrick Steinhardt wrote:
> >On Thu, Dec 19, 2024 at 03:46:20PM -0500, rsbecker@nexbridge.com wrote:
> >> On December 18, 2024 11:07 AM, I wrote:
> >> >All tests, actually.
> >> >
> >> >$ GIT_TEST_DEFAULT_REF_FORMAT=reftable GIT_TEST_CLONE_2GB=true sh
> >> >t0000- basic.sh --verbose -i -x
> >> >error: reftable: transaction prepare: out of memory
> >> >error: cannot run git init
> >>
> >> Any updates or hypothesis on this? Our test system has loads of memory
> >> - I cannot figure out where the allocation failure takes place. There
> >> is a limit to how much memory can be allocated, but it is very high
> >> and our virtual memory is extensive, but this is a 32-bit build.
> >
> >My hypothesis is that this is caused by ps/reftable-alloc-failures, but I
> am unable to
> >tell where exactly the error comes from. So I'm dependent on your input.
> >
> >Could you please bisect the error? Finding out where the error is raised
> would also
> >be quite helpful. It has to be one of the reftable functions that returns
> >REFTABLE_OUT_OF_MEMORY_ERROR, but other than that I do not have any more
> >gut feeling right now.
> 
> This is what bisect shows:
> 
> git bisect start
> # status: waiting for both good and bad commits
> # good: [777489f9e09c8d0dd6b12f9d90de6376330577a2] Git 2.47
> git bisect good 777489f9e09c8d0dd6b12f9d90de6376330577a2
> # status: waiting for bad commit, 1 good commit known
> # bad: [063bcebf0c917140ca0e705cbe0fdea127e90086] Git 2.48-rc0
> 
> git bisect bad 063bcebf0c917140ca0e705cbe0fdea127e90086
> # bad: [2037ca85ad93ec905b46543df6df4080f6ca258b] worktree: refactor
> `repair_worktree_after_gitdir_move()`
> git bisect bad 2037ca85ad93ec905b46543df6df4080f6ca258b
> # bad: [6a11438f43469f3815f2f0fc997bd45792ff04c0] The fifth batch
> git bisect bad 6a11438f43469f3815f2f0fc997bd45792ff04c0
> # bad: [f004467b042d735a2fe8bd5706b053b04b1aec65] Merge branch
> 'jh/config-unset-doc-fix'
> git bisect bad f004467b042d735a2fe8bd5706b053b04b1aec65
> # bad: [e29296745dc92fb03f8f60111b458adc69ff84c5] Merge branch
> 'sk/doc-maintenance-schedule'
> git bisect bad e29296745dc92fb03f8f60111b458adc69ff84c5
> # bad: [5b67cc6477ce88c499caab5ebcebd492ec78932d] reftable/stack: handle
> allocation failures in auto compaction
> git bisect bad 5b67cc6477ce88c499caab5ebcebd492ec78932d
> # good: [31f5b972e0231d4211987775dd58e67815734989] reftable/record: handle
> allocation failures when decoding records
> git bisect good 31f5b972e0231d4211987775dd58e67815734989
> # bad: [18da60029319733e2d931f2758a8e47b8b25b117] reftable/reader: handle
> allocation failures for unindexed reader
> git bisect bad 18da60029319733e2d931f2758a8e47b8b25b117
> # good: [74d1c18757d1a45b95e46836adf478193a34c42c] reftable/writer: handle
> allocation failures in `reftable_new_writer()`
> git bisect good 74d1c18757d1a45b95e46836adf478193a34c42c

This is missing the last step for git-bisect(1). Right now it could be
caused by one of these commits:

    18da600293 (reftable/reader: handle allocation failures for unindexed reader, 2024-10-02)
    802c0646ac (reftable/merged: handle allocation failures in `merged_table_init_iter()`, 2024-10-02)

The first commit seems quite unlikely to be the root cause. The second
commit is rather interesting though. I wonder whether NonStop's malloc
returns a NULL pointer when given a size of 0?

A quick stab into the dark, but does below patch on top of `master` make
things work for you?

Patrick

-- >8 --

diff --git a/reftable/merged.c b/reftable/merged.c
index bb0836e344..7ae6f78d45 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -244,7 +244,7 @@ int merged_table_init_iter(struct reftable_merged_table *mt,
 	struct merged_iter *mi = NULL;
 	int ret;
 
-	REFTABLE_CALLOC_ARRAY(subiters, mt->readers_len);
+	REFTABLE_CALLOC_ARRAY(subiters, mt->readers_len + 1);
 	if (!subiters) {
 		ret = REFTABLE_OUT_OF_MEMORY_ERROR;
 		goto out;
diff --git a/reftable/stack.c b/reftable/stack.c
index 59fd695a12..1b6b8cc9ea 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1612,7 +1612,7 @@ static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
 	int overhead = header_size(version) - 1;
 	uint64_t *sizes;
 
-	REFTABLE_CALLOC_ARRAY(sizes, st->merged->readers_len);
+	REFTABLE_CALLOC_ARRAY(sizes, st->merged->readers_len + 1);
 	if (!sizes)
 		return NULL;
 
