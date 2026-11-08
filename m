Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794111939;
	b=HceasiE4lVex0M3BXg4b85g+LG5ZH9z3fbs3XPHVdhjvcTrRp6IKNkgIOiTHP8ckTz2e
	 K9yRkRuqIgeRxLzRJbM+oX5efY+PW1TCIvdQwKYMpmycSphSiNKa3bee65OZLTO6xvgPj
	 kfDJCCG0qiYIGrcGjcRGiD3HUorvmscD5ISpZ/XrtQUILyuAsOJLSYC8hpNM/g4Vv2FwH
	 nZFnt8GuPBd89bwoGQfDTcDIXZHm3oIyauNRFzQfO0CbQI9HCA9yVONyPY8IhwUeeIGCf
	 LDiA0edcydg9GDczbvWzlt5DYk2clK2sBDKxRqJFHWc+dKoHXBXwftqTcT9XmcbR9pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794111939;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=xJGFHWQDcltmIkm3CAulxrLSbcKWpsZfjXbOBQjQO08=;
	b=iaXCAKucsGcZEhf6/2BfsLzIBtWAT8F52J6jkvfmyKUFzL94wYHIfdbnfF9/0jvlqOiH
	 odS3y1Hfh/PLuJXRvVLfNdnNNd3mCW3nTOGY0YxnfJ7bA6trGFHT8nmz78KhHA71CgqQ3
	 iJYWAkFRoWVfu9/FoGR7WXNKGfVm/+zLmEN/3Ra2/T1wpoUmxzz/SLLJ7Zu++r9h2siNB
	 bZus6iM+xInDdlWmclWYbn/u92jZtogR2bt0rmC7wtdDOBAhSw9zAysNHtJxwt4G6jZJu
	 lW+iARPrbqcd5C+hx1OIeo8AQMNnpjkbK7OB6SHMWda/e1njmeOBpU7fUDKtih8MzVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=jUzbskmf;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ETwN4TwA;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7409F606A31A
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 04:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7409F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=jUzbskmf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ETwN4TwA
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B2EC91D00109
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 23:25:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 07 Nov 2026 23:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794111937; x=1794198337; bh=xJGFHWQDcl
	tmIkm3CAulxrLSbcKWpsZfjXbOBQjQO08=; b=jUzbskmfcqtjFvP4EJW/7L7IEE
	SapH6wceoc/LWKhzlGtUtf2AH5icYLS9v+/iTWhTWIT3p+fpuW/WqVCxue0TqiHU
	c4Gzhxnif7b9WdDDDJHDEjGm4xJpLkKkokiaE0dsx/ihAQ1g1tA/lvX7y+n2qiXG
	5YCkN3e0/g65ElNK2enCneb074RiPZPI9gejD73c8DsvSBp++zy0BMHABB8N00cP
	ZWj28czGgf0wP2c+0ZNqk5M9aBu7IWJdCejwDyr+abm8XhTwM9kgtA+ZhwpxzR/P
	lINVwt0OdC53pjifobjCBsrnAX9RTwvDywAyf7UjNPTp5U05NQrDvOxFUnYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794111937; x=1794198337; bh=xJGFHWQDcltmIkm3CAulxrLSbcKWpsZfjXb
	OBQjQO08=; b=ETwN4TwAoRMdclT5iAdwhQeI2hdyNLHqgVtuq5bSNBOqG9t3I6t
	6/xMwMkQyBS+dytd9oyuKU0eKyFu6JXvqFSzhCIAZmDfg7FWHT0827Rp4ZpCA7Qy
	QkzbQ2FsrOstrLdBoMnjuAs315s3hYp0U3/ni/5NyZOtx1B2J9AuwjoYVv3HdmPx
	vVrt0IL5Qpzqm0w/6zkxDEhuSltvqnKBDd+7vMlIzfA5oWeQTwFaRDyTP+gbduzU
	OU+I/A6fIY1SVz0i35shj7k87sO1KHRvy0gmCD9BvYdBWW/gXPdxgOey/Bw7OU/M
	45zHHxPaY23zq3n7xbwh7DhYK80ojwkQkuw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794111937; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:f/9B4fxeHQ153eKh2k7IPCIooO1SXcacTnrXwNFOdS9Eehp
	XITCJjh0apeV5gxt64ilM2+sxwSyU8nLLMAgDSNVc4b+3snqHQKcdmmGlV9rCdpO
	RkGYHnQJnFwN4zzSHSoPxDTgzzA3JRLaWJNqxZB/BWaph5gFF01/sktMW5QOW73l
	vw24CJRtTTv6E3OtNdRESKPmBjibP/rhtUwJ7EzjNUhLvHPzKtgJ43OyQcyfHMq8
	uptWon1iA34r/QK9V3WZ2qgRGUQrwnG9cTZij3gtczKAMg+yLXsjNpuJ+xv7Qp0U
	plOgybSuLbqwJDv+njEKzse2h4Q07WJtSW8GyAw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:k52spzG0DlrbDh7vTJnSxGlurhX+C31BG1rEp9Z5jcg=:bkVs3GkXTLTNg934DbzGV5oYIPLKne9v4UnSmt49ais=;
X-ME-Sender: <xms:wfnvat2yE5eNdY7FaVmohVfCx5khSxzCYxIMMsU3v3XIgt1JuiOvRw>
    <xme:wfnvanz3QofVL5EHMwVfXPkfHRTLmnIqImlKdwXxJqTD4ZCKliTstf1hHYAf_Ek5S
    8bLGPTzKSsWWh0r6jdEx8Kj8X-SlPLXmURw-21oM73RKARC97UwNxA>
X-ME-Received: <xmr:wfnvansi8Lhp4_7vqyKbG00i74KLUr3Pfyn8SrNBKa39ld_T8yQezvdNzQ5tbC2UV_0UcsulxUKnlKSvFi7xDzAwncmFr5-W96XG>
X-ME-Proxy-Cause: dmFkZTFKzBOavxLxtp+mD/7qhlEw5BNcGZ+cChqeIRKAMcLxdo5lEmGawCYdtDJdQFXnQ2
    tYztkCKluPc2LAvP0AK2nsI1qO60TQoN+j4FB3InP5SwkPLaKPNjb9u88+cOa0JeIs8D/M
    YkY7DF5aQJ6iGjk7J/3Pjxs0IH1O7KzQBo5Ffjm/t5z3s9zBeiHdE2kdZiGY3TIkZrJE6d
    GKaVRGI0koUeUzSvQjjM/9Sg5uEMyv8Tas0FAR/IarxM4oLCRWK+wh/+Grp7EnarfjexXw
    nT3euW0r+VheduNQTbwwucZAcUREu5czWQO8OknofdytCsk99snWWccnUg0KLVkeQqR1Zb
    XKZeWOZPcqqv3a2gcO/5J/ZepgCXcC1RdgOxK6vaHxH77+edV8EyLh54ttb5m75RkFTjFM
    M5mMxwZkzczKRPQ0PSIMfKmx8bhjsC07/QMEXqrJNe/a5xBHX6PHsF4K0lMekAXULqJr4i
    ymM/+1Z3z5D6DVRU2Na5ospyJTaaIoVXc1ZSz4TlarqPAumFaOIlf7ZxSrxJj7M9XQgHtK
    knDDWuf3YqbvyQ78QTGxqXbzatiMF8dhPxTDeqS5mHRn2OFIwb+rh2Hc6qLGlx6iE48w3j
    aPzfMHkPr1wi6eDTJZUob6eHoWMoObTcKhlNTShSdqGAWEL26fExCLNvWsOg
X-ME-Proxy: <xmx:wfnvahygitTEuXtjoWwr00a80BV7lsI_eVlbKkvLY7ukDWfTR3KI0g>
    <xmx:wfnvaiAjJVMOuXV7KxwUr_K5qdAuHbM1FEQxGAYOCXEwM8nEFbmRQA>
    <xmx:wfnvanfTDnXL3PfpUSVYOiQpW12p_EeVu6WnEZ2O4sXz842JICHBYQ>
    <xmx:wfnvaklqCVvNYhffT5l2z_nejYOCHgv0KU7eBzwIL-ncD_l6u5H8IQ>
    <xmx:wfnvakbvbSUAQu6h9YPerDNeH8g5K5fKhFoZxPkPJo1m4zDCU7KOud0k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 23:25:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
	(D. Ben Knoble's message of "Sat, 7 Nov 2026 15:06:36 -0500")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
	<xmqqh5ile4h4.fsf@gitster.g>
	<CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
Date: Sat, 07 Nov 2026 20:25:35 -0800
Message-ID: <xmqq7bio6jb4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> +`HEAD` is where Git stores your current branch or commit. `HEAD` can either be:
> +
> +1. A branch, which is your current branch.
> +2. A commit ID, when you don't have a current branch.
> +   This is called "detached HEAD state".
> +
> +It can sometimes be useful for `HEAD` to be a commit ID, because
> +it lets you easily check out an old version of your project. For
> +example, a data scientist could use this to run an old version of a
> +data pipeline or a programmer could use this to figure out when a bug
> +was introduced.
> ...
> There are some quotes which use the "it's the parent of the next
> commit" mental model, though, so we could include a comment on that?

"From which your current changes started" is exactly that.  HEAD is
where you started from (and can come back to, if you get lost after
botching your working tree state).  Your next commit is built on top
of it, and then that new commit becomes your current commit.

This is why it is useful for users to realize that HEAD is simply
where you started from, regardless of where you are going.

> The second paragraphs differ a bit, with Junio's containing some bits
> about clobbering extant branches and not needing temporary branches. I
> think we could work something in there, like
> ...
>     this to figure out when a bug was introduced. By detaching
>     `HEAD`, you don't need to worry about clobbering an existing
>     branch or creating a temporary branch.
>
> ? I suppose we could also be more explicit ("build, run, and
> experiment"), if we wanted, but this is a good example to start from.

I assume you mean the last two lines?  I do appreciate that addition.

However, we should avoid saying "useful for HEAD to be a commit ID".
Being a commit ID is not the notable characteristic of a detached
HEAD; the fact that it directly refers to a commit is what gives us
these useful features.  Recording a hexadecimal commit object name
(instead of a refname of a branch) is a mere implementation detail
of that direct reference.

Since Julia's introductory paragraph already established the term
"detached HEAD" very well, there is no need to resort to a roundabout
phrasing like "useful for HEAD to be a commit ID".  I suggest
rewriting the beginning of that paragraph to start with:

    It can be useful for the HEAD to be directly refering to a
    commit (instead of indirectly referring to a commit by naming
    the current branch).

This introduces the remainder of her paragraph much better, and
makes your addition about not needing to worry about clobbering
existing branches or consuming temporary refs easier to understand.

> Otherwise, we're approaching a finish here?

I hope so.  The document overall is moving in the right direction,
and I just want to see these minor technical descriptions improved.
