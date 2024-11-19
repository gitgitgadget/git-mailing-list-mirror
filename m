Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885BA1876
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 05:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731993036; cv=none; b=hzEQl3fWr4r+ao74ibfR3zlzu2i82j76nHQYAkMRR5TNEuTu3//ervx4yRjl/cive9jqjLbA1QrBrUAaKDh8hde3I+6s9fDh5ie84Fj8B8eU7J3AwJ8km/bsKWgd1QlgNT2F/u0hwkvX1hpbqQrK4s/qucPweG4SEe65GGHlx+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731993036; c=relaxed/simple;
	bh=amLeQXzPY5kGiSOdfPMB6H4nmSaePV5TbokXQL9C9rA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hfGbol0Qz+iIQk5gUTtBpRT0ZFTGe8lGKr5Edk7LfiLBZVJRoSgDlyx8Bqj57bnAXBrzYBA+1xMUWRIxjGyQ7V0DwfP+xWVZa6onNqsGX2M7i0gGOfEF26DkNdJseSFJ/e0N8keE0EDbpIycJ4231YrooPDIHKEhFAVxABM7mGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RBNCaSuj; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RBNCaSuj"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 69DD311401E6;
	Tue, 19 Nov 2024 00:10:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 19 Nov 2024 00:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731993032; x=1732079432; bh=3I2JCJ4P2/OvOIosmYaeuGI2UGxZADQCGYD
	0RPraNJ8=; b=RBNCaSujCfjRWm3/NuJ1SIzH7fQZEva+f11IgOEd+1s/h2Pbebg
	ZVskcox8p5g4DA1TSY7G4Wnpg69JGk8YAtTXnV03lBm/Kkq4XuSZI2u9XAoxwcOz
	DqK9suJTzHqpnsA/s6dRLDK3zXQHHbQ4Iq3qa0zs22/uE1gsTOZsSm6YhUO2Lfvg
	cIlo5ysEVo1t+0oJ8ZSg0yzRLyzYe7+7wHBhwaH2jm6hHXsBqwIsXRs1JfKJ11zl
	kAHoM4huTN6B773sxG5QoAgxTlEGUHN2YGC7uzdg9PLRTGudm4GZuv0zZwiM3zLB
	xVemnR4ZsBinkZNHgEAmv9VRp7KpjwuhmLg==
X-ME-Sender: <xms:xx08Zxw125lagpiiKcUxV_mnDBf3lNrjyNLYVJwuxWoIPNnWlWRT7A>
    <xme:xx08ZxTh0vlkR2cm3-xIFNT6Z_7MygvH-vj5vIdV-lnpGWSkp-Ai_ukfx9MMt5U9M
    DODi1TNiVxV3zgGCw>
X-ME-Received: <xmr:xx08Z7Ul0qIk-6NpkB9DTagOwna_Nl0VdibF1Wolg3l2gG-g2n2LoHuU_2WoZy3Z-oTBMA4ukFXz83CpgeD9vi5CZLzSzDKMzwUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeekieeiheekleekfeeijeeiudefiefhtedvtdfh
    tdehgeeghefgfeeileejtdeggeenucffohhmrghinheprhgvfhhtrggslhgvqdgsrggtkh
    gvnhgurdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthht
    oheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:xx08ZzgYGh_lzjAEpwtfXuXe1XMMmhM1AYCvP0Jm-mZU5CwPp49VrA>
    <xmx:xx08ZzBkws-U-7_WKqpG_TX1tUsodfIcDgVDlebV-89pmg1-ejPpVA>
    <xmx:xx08Z8Jk7piVayCzdTOm1t78VqHQbs862EeNJrjWaEq6SGJ0OwtI_w>
    <xmx:xx08ZyDEfN2YlZq3hoEIT__oRqS7fuu1YdoqzbCCnEOD9-jQX5GwvQ>
    <xmx:yB08Z_u2RTAwNEALJUd2UKdGH9iVmk60x-0GG4U6ftLunXhmf1DhzNnQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 00:10:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,
    phillip.wood@dunelm.org.uk,
    =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    karthik.188@gmail.com,
    Taylor Blau <me@ttaylorr.com>,
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v13 2/9] refs: standardize output of refs_read_symbolic_ref
In-Reply-To: <20241118151755.756265-3-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Mon, 18 Nov 2024 16:09:21 +0100")
References: <20241023153736.257733-1-bence@ferdinandy.com>
	<20241118151755.756265-1-bence@ferdinandy.com>
	<20241118151755.756265-3-bence@ferdinandy.com>
Date: Tue, 19 Nov 2024 14:10:29 +0900
Message-ID: <xmqq34jnerlm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 38eb14d591..60cb83f23a 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -830,7 +830,9 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
>  		return ret;
>  
>  	ret = reftable_stack_read_ref(stack, refname, &ref);
> -	if (ret == 0 && ref.value_type == REFTABLE_REF_SYMREF)
> +	if (!ret && (ref.value_type != REFTABLE_REF_SYMREF))
> +		ret = -2;
> +	else if (!ret && (ref.value_type == REFTABLE_REF_SYMREF))
>  		strbuf_addstr(referent, ref.value.symref);
>  	else
>  		ret = -1;

The ref.value_type can be either equal to REFTABLE_REF_SYMREF or not
equal to it, and there is no other choice.

Wouldn't it be easier to reason about if the above code were written
more like this:

        if (ret)
		ret = -1;
	else if (ref.value_type == REFTABLE_REF_SYMREF)
		strbuf_addstr(...);
	else
		ret = -2;

I found it curious when I read it again while attempting to resolve
conflicts with 5413d69f (refs/reftable: refactor reading symbolic
refs to use reftable backend, 2024-11-05).  The resolution has to
update this part of code to use the new implementation that asks
reftable_backend_read_ref() and becomes a lot simpler, so the way it
is written in your topic does not make much difference in the longer
term when both topics graduate.

IOW, if we were rebuilding your topic on top of Patrick's topoic
that includes 5413d69f, this part would read like so, I think.

diff --git c/refs/reftable-backend.c w/refs/reftable-backend.c
index 6298991da7..b6bc3039a5 100644
--- c/refs/reftable-backend.c
+++ w/refs/reftable-backend.c
@@ -920,8 +920,10 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
 		return ret;
 
 	ret = reftable_backend_read_ref(be, refname, &oid, referent, &type);
-	if (type != REF_ISSYMREF)
+	if (ret)
 		ret = -1;
+	else if (type != REF_ISSYMREF)
+		ret = -2;
 	return ret;
 }
 
