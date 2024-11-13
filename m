Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FF1C69D
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460055; cv=none; b=X8Vd8krTL/bhcF/3UbpZVsIRYjOC2qp+9xsnzLSqSknr2emHLFZEBDpP1H37oQoNck2vtSTXqgKosJ4lima9lDoYr52l7XwDzKvtMc5WWYtFuctamjDeAv7z3wtIO6awvDT89m6nrFcm9K3KxhOgQTS9COR5vrMpjuWS52DsTLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460055; c=relaxed/simple;
	bh=xJXZG5S7IKKRonb977zslCIVB39kp5aL5KR5FRtcI1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K/okf7y1TLLSWxh4FCgXXCIbG+I30cK179c8cwR8GPA+HzXY6TeB7Lpd9QfQ5cqvMXgfRlOBP9H21/9drIzzoAn//estAZ6V46lLYcKanw7W17bhl6vY5nutHrYzjaLedbifpRNmF2x+U62+QporYanEMfWnr3oLQHJBBGGuUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fnm5I2ux; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fnm5I2ux"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B0CE025401AF;
	Tue, 12 Nov 2024 20:07:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 12 Nov 2024 20:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731460052; x=1731546452; bh=Kn2qWVV5fhNSAH2jpVkMA5S8NWREY5Mbx/b
	1/H2g51w=; b=Fnm5I2ux3TPVQNYjJPeDmRycgVuam1vMbuAl3WL5NGZ1/2vziLj
	zpSwfHBUWcV/EpNz5rj52bmVckIZ0ACrdLoJGNTbIkNCLjWsxeG6YSd1L6NzXGCh
	oJo0qsOODFTXOFmJtKcFs7vuqKsHH0wdYy+l66clbrDB062/KKtdNQV1kGaf59ts
	TIbXwW/RC59jZdRP3/ho5jAkD8s23kbpNGykH9Rf7KeRmgE/BzQcCiZMemq9I1l4
	YNA1tYW/rrQESbqwRLQeuUEhpXFWcLkrnISg7Yi5OBHW0hoFQb9zNO6ZWSeAHaey
	/8U0nbZab1+I8hrAwjhfohkJPmEiNbfsBpA==
X-ME-Sender: <xms:1PszZ0wDMWyOD5stYEn4yhLWRdQHLuDbBrxzYhNzuyGivyE9q5iXMQ>
    <xme:1PszZ4TL2lMHTY-2t-GQx2rPtoHU1ysUPXJmwO07NRbBXDm0gvpp53Bo6ZTvITAjT
    xEULOpi-lH51Asa2A>
X-ME-Received: <xmr:1PszZ2WXEVSulNtbj_op0Ht8SjykfMTKSG891MQ_2zPy-SDt1sAXOZSvpIRTM7wUpb97xGuOYTS3DjCtG3nUUb-ilcIsPO3-_aAk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfurfetoffk
    rfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkf
    gfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehg
    ihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejhe
    eugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhm
    rghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1PszZyiggQWTWD-e9_jGh45lXJeylN2CZCFJG-CjLu4OEJnbkQNIrw>
    <xmx:1PszZ2DlOF8RT5wJzmdn5wRR4JiX7oN5Mvup9XJDisLskZ4ea67f_w>
    <xmx:1PszZzKGtN5bNh5DmvxsooT5uP60OQpT0ra3Jo2qHeYzGzwArEf8nw>
    <xmx:1PszZ9CgI4gTwfFraDHhRJVbF2Z_teHhbyvW_mvZkBrDPjycBTI9VQ>
    <xmx:1PszZ8A-XqrYHXap-IzJGkYuMedz2E5Ztz5U5T8A5-p0R5wrD-HcDTMQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 20:07:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  stolee@gmail.com,  phillip.wood123@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v2 2/3] sequencer: comment `--reference` subject line
 properly
In-Reply-To: <710c5b1a3f6bf8dc112ff13f27a8b2165274488d.1731406513.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 12 Nov 2024
	11:20:12 +0100")
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
	<cover.1731406513.git.code@khaugsbakk.name>
	<710c5b1a3f6bf8dc112ff13f27a8b2165274488d.1731406513.git.code@khaugsbakk.name>
Date: Wed, 13 Nov 2024 10:07:31 +0900
Message-ID: <xmqqbjyk2b70.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> @@ -2341,8 +2341,8 @@ static int do_pick_commit(struct repository *r,
>  		next = parent;
>  		next_label = msg.parent_label;
>  		if (opts->commit_use_reference) {
> -			strbuf_addstr(&ctx->message,
> -				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
> +			strbuf_commented_addf(&ctx->message, comment_line_str,
> +				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");

With the switch to "commented_addf", we'd terminate this line with
LF here, which means ...

> @@ -2352,12 +2352,13 @@ static int do_pick_commit(struct repository *r,
>  			   !starts_with(orig_subject, "Revert \"")) {
>  			strbuf_addstr(&ctx->message, "Reapply \"");
>  			strbuf_addstr(&ctx->message, orig_subject);
> +			strbuf_addstr(&ctx->message, "\n");
>  		} else {
>  			strbuf_addstr(&ctx->message, "Revert \"");
>  			strbuf_addstr(&ctx->message, msg.subject);
> -			strbuf_addstr(&ctx->message, "\"");
> +			strbuf_addstr(&ctx->message, "\"\n");

... we'd want to terminate the line in these two other if/else if/else
arms for symmetry, so that ...

>  		}
> -		strbuf_addstr(&ctx->message, "\n\nThis reverts commit ");
> +		strbuf_addstr(&ctx->message, "\nThis reverts commit ");

... we can lose the termination of the previous line from here.

Makes sense.

> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index 411027fb58c..26d3cabb608 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -228,6 +228,18 @@ test_expect_success 'identification of reverted commit (--reference)' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'git revert --reference with core.commentChar' '
> +	test_when_finished "git reset --hard to-ident" &&
> +	git checkout --detach to-ident &&
> +	git -c core.commentChar=% revert \
> +		--edit --reference HEAD &&
> +	git log -1 --format=%B HEAD >actual &&
> +	printf "This reverts commit $(git show -s \
> + 		--pretty=reference HEAD^).\n\n" \
> +		>expect &&
> +	test_cmp expect actual
> +'

I guess this fails by leaving the "# *** SAY WHY" in the resulting
message, because the stripspace wants to see '%' to start commented
out lines to be stripped?  If we inspect with this test what the
temporary file we give to the editor looks like to make sure that
'%' is used for commenting, that would be a more direct test, but
without going that far, at least can we have a comment describing
how this is expected to fail without the fix?

Thanks.
