Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612690;
	b=w5LbIYtJNAcm9pHCFc9eaHhC59RpxuqZaDIY804l+LzzpFk9kVPP4lQvet1h+ciQMYSu
	 GCtxJboqwkTPjNiZKPiwQOuuT1avPmrvQ8RSlGR0gJNojwkueeLOjXQKHHUMw3kERdO/T
	 x1mdTVN72W6xVSlWHS3PgNw4+feU7jU4yfJDETtS3NDQxGNEkcVV/zKFefH2EIwD6GNR7
	 z3Aw+D693NxU+j8bmJfrbO0F+qjB74zpJTCwMmofN7wXqR+PkNwP980OnL/lH3yU0CoB0
	 Kt8uzXiCUqqwMrMa8z3BKwAyoHmVaQThnL8ObR3uc0IJBfGosV9HKspZ8lJ1iIipfRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612690;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eP720fiG2dP/jYFqM/a1zG7Cxw2S+5YtP4GC7cIRyqo=;
	b=5iZBhUVZR41CO4fLlD7nsdBSdRJ73JXSeXfPcueUx7//2Pi7T/I3hzptDYvN0ugLN+52
	 dHoFiCSfuQNh0B/oHKrgVKTO3AJ90u3HgqofotWF+XJxtxH9KVJdg3l47fMeCvHz5Sg/U
	 XxTxVTbrf49D5V+nRBb4tcniDOQ8akXCSlN4ASX1aNXmh9LfP2CJ4Zc2IigsuR/NfR0Du
	 hTrDDJf8YdveiHZjKo0VfD/a55vYrMolFOtiI1pEnrhV9QvxJdrfYdF2qX1Svja/637iw
	 ssQwMmr+86pQbFQ5dDyTohiaO/X2jNB6UscpJ4iAPMXnbhXS+EXpoKYTjVQjKAy6wAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=kgacoMJK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=sYXoxHVE;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD3A606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFD3A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=kgacoMJK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=sYXoxHVE
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C4E81D0020A
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:44:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 02 Nov 2026 04:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793612688; x=1793699088; bh=eP720fiG2d
	P/jYFqM/a1zG7Cxw2S+5YtP4GC7cIRyqo=; b=kgacoMJKfhPYxMThCqZGxXoBUf
	ioUKHJ5IWqwe8wu2BkIF59ysv+rvkDWHGusuPEF/eLHHMxShF0Y2/oPDCSh1sfEZ
	7a16e7rfVx6cRxr3hEBSSsTPpDhjPKveyt3NGc4wp6i6GcstrpKRcAo5VnqIKHFP
	crJO/icoMTWnOxWBuVCAw96Iime+vIbgGjkHMhXXc8ofjvH4ddkvBoiLgWjYntPR
	rCMnMUUuLtSkikYgBRkftk8FkmTI+u1MSiwWywOQ0V9VzJd8RnNBJhCMrm/kjlfI
	NmiXBp2ImJwPua1FnCqGJJ5R1+Bs5aCvpat/SkOFONa0lxJPHyzvXlKz5kEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793612688; x=1793699088; bh=eP720fiG2dP/jYFqM/a1zG7Cxw2S+5YtP4G
	C7cIRyqo=; b=sYXoxHVElZ/Jo+457NZJolMSH1yMU1HgjLUhsZK/a7uHF/gPAHQ
	bjYlmKX08dNAPueRZ7CKZJKy9axQQ4FqzIjDY64Y8znslqsXh3xw4Mp4CHj3xyMt
	ceGNeqY9J0vvfJps3G1MmLlnHGnTQoHckwEZHAhSWxNhC7gB0cXaNddB5rHyPphW
	sz4XCXCouZBvNpz9Zhza1mKsiN2FFFhz2fCTpl0GuMzf2/EjqrZfc6FmGyHYD50m
	2loK4fJH5A+UduDPbE9/fMPy1/ZgS52lW9En+u7LnnO1wnS5BT2m24nGflAr9h79
	DGgJ9zAyVxcpwOjXWsQB5/N/MvdRmFgQrdQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793612688; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:gh6hLufNhTwIOQkYrLHp5PvSb4KP1rky2i/LcduHr++BYau
	WoIlCk/EsM+cDjxpE06u3W2VgMwXdhBySTtktNN9wBkmErpmI3GNHmxa5PIoV2z1
	eGPjpbuNn5GOZPLZtiFjADWI60QNJxZwP4MtXhLf2/7p9MhPPaOAgIs7z1J9RRGG
	tY9CiiElGMFNWZcC1U3q4JrcgBAhfm2wjzFdhM+QKkZeX6HD4vsEoA9QVj+HC2eO
	FLWFvVNNyjc7Gfapfis+H3vt4ggwsQhTj7FWaZ/uufvM0CR8bTLsyq+d9LprUGO6
	IJ9HTBJdV7OMS9bhO6lG7oenKRenYPBXVQK+Gyw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LXuJC006+qemyLwTBRvX0gp4hjHtaD7+wMi0ctt/v9U=:ukjVxBpMyzFgYNDI0yFdCobmIwfHJ0QmHAZ67BWUilU=;
X-ME-Sender: <xms:kFvoambRLhogiVwOWE1ru3clnY-5I1zQGu8rzScYlGvYDX7Aqb9k1g>
    <xme:kFvoavZrrIz5vQqbchyo_pIX2jBW6MNOAmokCqqzgXqj1K2ni6PIZilVIM-SKgU_4
    lJCorcdmOjr_VHsBiBV8JFRksTYcZUFnwyuwSE3q2r48janCr-3sC0>
X-ME-Received: <xmr:kFvoaunxed21zIXRYZouwt8QyYfSgwP25CJ4DybuZDdkPeclkCmaLSKnySrUbri9kchscg>
X-ME-Proxy-Cause: dmFkZTFmsdtEk8TGrrQNcHFrnV69JEUCziAmBlEmKZFOyBPUs0DOg8PT+jSvjfHwpOIpvl
    5DHNbwsBV//Xasaz77PQ/m1ulCnsB7LWbuFq7TY7sM8ei+1eNspIujwBTT/176uCaGV8zq
    MH4FC/oTNtOeQq5dmJd/+8G5Ifof8veKp9NBk7rJwBR9NTiY00KmX4KvT43QCNVP3EvNRy
    Ct2aXV7diq8ZePKzgOD/lALemXpiGUOiYSjAF6APl8NZmqWAaOLbTB69d7DSYCjQAqzYjJ
    GA2RBBrBVxe/fGsnlj6NRpDQelrw8gF7ZKxzbIro0erBbaAzWGa5bslli1zOArtkl3AHm/
    O9VNkzcE7lUYlqlSdX0H+XVm8346zfR5b+FJrNXLeBZbiKx5kiOEND8A4nL3ADJVwq7LRf
    72i+tu3fpmsIjrEYD/toehjVYCEAMOVjcWCb2O6flCEhc32n8CNRVpCFXj1kQ9x63mCuIC
    Bqk7eQ4fKWGvmiQhWdmJaFqKskXch23weDQugz6zGO59JW8eEPe6p9GUzWRM8HbYLs3afy
    y7RTb9nw+iPituGOQ0TF6QeDXul4mGobkCiUCFITKqeGYob+xMGZHcRfrw6jIRcW1harXf
    aBxx4GXvAYHLrqmbqdn8UlSUAccSG9HkO5qFXaEq13DF/8qmndFnMrobi3Eg
X-ME-Proxy: <xmx:kFvoajyf6RTSQvVenD5YdZp-LaRuFXWOtui5bSNJlf-23xWBvWbVUg>
    <xmx:kFvoakMyn4l4nE-dRKHjZy9SXYVmG9kBG4TFk_vRZBO5jpmoPr--Bg>
    <xmx:kFvoavSDTK2Sr09L_VbzBOfEp3VicctOc6cVRGGZcMJU-bYmlEaocQ>
    <xmx:kFvoaqYZpqBT8aoDBTiBLKjqY0FVUcMwyUr3kZ78BAVLH4tLydwsMQ>
    <xmx:kFvoapyKttfkaYCjB4PHf1s_0Kx5tfc4kjnXVtB7o1wkZUreaMUVH3Sw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:44:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 883d0184 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 09:44:46 +0000 (UTC)
Date: Mon, 2 Nov 2026 10:44:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] read-cache: hide refresh_cache_entry()
Message-ID: <auhbjFvD8CNXYcgQ@pks.im>
References: <xmqq4ie58syl.fsf@gitster.g>
 <auRm0Ohkg3OQIbWE@pks.im>
 <xmqqpkwrxkbq.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpkwrxkbq.fsf@gitster.g>

On Fri, Oct 30, 2026 at 08:46:33AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> Hide the low-level implementation detail again by making it a
> >> file-scope static function.  The external callers would indirectly
> >> call it when they call make_cache_entry() or rename_index_entry_at()
> >> external interface, which "ort" (the successor of "recursive") does.
> >
> > Seeing all these patches dropping public declarations I wonder whether
> > they should have been part of the same patch series :)
> 
> Perhaps ;-).
> 
> >> +static struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
> >> +
> >>  static const char *alternate_index_output;
> >>  
> >>  static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
> >
> > Could we avoid this forward declaration by moving the function around?
> 
> As refresh_cache_entry() that has mere one line in its body calls
> refresh_cache_ent() that is a screenful and defined nearby, both of
> them need to be moved upward, so it becomes a rather unsightly
> change, even though nobody would care when they only look at the end
> result X-<.

Well, people probably know by now that I myself tend to err more on the
side of fixing up stuff, even if it's a bit more on the painful side of
things. So I'm not going to surprise you by saying that I think that
would be worth it.

In any case, I don't feel strongly about it.

> By the way, I tried "history fixup" to make this change, and noticed
> that the subcommand ignores "[notes] rewriteref = refs/notes/amlog",
> just like "git history reword" does.  Again, I wonder if this is a
> known limitation, or a deliberate design.

Yeah, I already replied in the other series, this is a known limitation.
I've created an issue to track this that we may have capacity to work on
in the next release cycle. But I wouldn't mind anybody else beating us
to it.

Patrick
