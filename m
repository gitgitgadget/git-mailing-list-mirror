Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6DA3A16AC
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681316; cv=none; b=UiSNRMO0t/OkrcPm/9lKKrTqKCSsEJEAyc93UzYVZCMwqJYZ4h3piW8j9Bp6/dSc45vfhtzyPUrzvwz0kfXXTFlVMrv5ZHc53QH8pFQARTjkZyLNK0BKjt9JIAkxrUB53aA9nDX2thQvE174VeOw8QEAA21r2rkwN9By41je5sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681316; c=relaxed/simple;
	bh=xhYzevHfIypXfSd7zC/IYwjy80Fxjxt7yPjwONVyKI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bj8vGhJzordAlfiwUs+NOn3L/ixwBGMw650qDv+U+ez8okEgfj9IP8lnv6alkJT6Iv1ANJ6q8U6VZPkK+r7K5OG8qGHVoq9AyBxCE+fn7iXrTh8YOy5gBrNef6qq8IMMhnslcvtFhoKJ4X5MS1Oa4T6ds+SLI8ST1xM6wW3qhNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U/J7RHIh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZLGUvvkM; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U/J7RHIh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZLGUvvkM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D46417A0105;
	Wed, 17 Jun 2026 03:28:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 17 Jun 2026 03:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781681314; x=1781767714; bh=fCdfxpoPx8
	5+xeb7WluC6Q+MSr9vbbxKVwyzvAdzZuM=; b=U/J7RHIh3L9ehlHSPtWn3ODVPX
	QgDiBF3j96b33CFH1RfVwg4rHAKFnQQLcfl8MvPaFQsWGapEqCk6uYMl/IjNKi9/
	sd5UX++QUiGjWmBX4OjA99vFRv+LLsrRqJSL4tJo9mASysW0dmijZ9wHPfxfBQpG
	4F3PWql2odjKgsU2iC7qjlqjQLgHydYSnJSGuxhnf/hDM6A28UDUvrAU+NFFpHhu
	6RR6LzvaqD88Nrfq6rLvsjwuTwvVcLKkY3o792Y/QBvv9GxiTS504Zw1/X4Ps0xg
	ykiGcOrXjI7qzP3hJ0DduqOmqnR7xb0zq3RA212k5CrUyznWz1B7ufZLrW7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781681314; x=1781767714; bh=fCdfxpoPx85+xeb7WluC6Q+MSr9vbbxKVwy
	zvAdzZuM=; b=ZLGUvvkMIil4uaZOBuYtR6JEtz2sRDe6vhplbVL8rF1iKqg5glm
	AhmL7fc7h2z8f16N84xmonNYlLhkobq/OlwX7qY1fdwx3LLNazub3sdy270JNftg
	rJ/kZOuPBm/IP1GHClgHBApgTkZw/m5mZVceBEb/KToM47qd5cQkBB4El05gIrPB
	m6wM8GaXyEg7fkN3houDZ8pTbWmQuVuTxRiPynutkhHekC4J01E7p5ez6aFH1rIu
	CXJ8HVMsSbKRFloROgfFxavYOlKV5glIhU6XaqkkuLtNmESV6ffvMGNUg3qNHwkm
	UFZrVpSQ7o8QXTzdFLGqUxYVqwENyHQePXQ==
X-ME-Sender: <xms:okwyas-yxke29AXSlXFYbbx5EromveU1k0swfb-GHs9U3KjD8Rf6bg>
    <xme:okwyaqu7p0VrYXkHmkUcqF6l1Ja4v2MK9msnESdVQb1M6wH3Q_3fZ3S7VMhFuDhiX
    hAR0-iwhJEpWNjL2TZJ5ODf-3Z0BEYU1ZqnMLrxY3oV_kdzS7HIDQ>
X-ME-Received: <xmr:okwyavp_89pOTR_YbVoy-__VvcHAtxS5SCPntbHYmaf4qHRvS3j-3zJ9UD4FyhUouTMWjbmbK55oEoEgiVzO0LzFgYljuOoUNFlkv9M>
X-ME-Proxy-Cause: dmFkZTGrNpjC6tOGvNreyzZ4OH2Jsb+VJPOC5AG3yK6E24nT1xr0mqt+gWII1b9Qe30Mdj
    UPA5KlAVXZLmXBnWYiE9ZeT5Gori8MBYHfqASycTxfAo/nsHc0+dPvtHc6aWw0MNSvKB+M
    X+lAxZYjsDIC41OGR63Y5phXpb88ASmXNJxuaIoLtGLSRtoT5OR1ZOgG5wyFGtVaanllaF
    /+8hL0GzJj06SkyP7jT2JK0VslxrG4pFL7PuMID9ghYz2IZnme0xM2iBErZWiPt32K6Yk6
    KcGg6ybsbz3n4AERkNhosk6fwZ3LeFXCRAqEcka+W52LnevK3DLWJ4kBpR58Hxpm/Wm7tu
    13m1TYCl9bGdduxHWQRIgodb+krIxUn5+qi7ZtPFGBBTGR1rkMDFtsEF2mtjsqnbSnLwEQ
    yE7nu7kpuToAr4Hu7KXCXUXQJ3AckNctewkZW6DIeFGQ5D4u+f/USzGZh0tUN/aAYLtGo7
    KrBT6lc0KQPKCK4f2vdw1OntrA/rdLPpwU6zZcD0Q0rs3uo3VfUDFRuq2N8yYn+QNZhi/X
    MQP9M+XkBl3sczr17dw7hGv6p/f0zQ5G9g1GEZQKbER7RR+LKr1tsiR8f7M7QOVTOdR/Bk
    6OA2R2X9GxNHietL8/gq9kbybdAuQtNZx3JAP87g1AvmoiA8JGttTZyn8Bcg
X-ME-Proxy: <xmx:okwyanli-ux5_kYiKml6-DDTAzEYSLE6-qsFTN90GBBaMeEEmJOWcQ>
    <xmx:okwyajwhZ3pgohkhk4cFxmuUMUdMs9D5QlmMzRADqwZoBx2hryDt4g>
    <xmx:okwyavn5rA4GaDwiamgdwvWiUqo_hDJ3DM6Ypad8LIXxMEHl7DBCpQ>
    <xmx:okwyasfXXOP9yQD6WKqPyDLr4_0_OnwpHpza_KjEGVA6VF_hRVUwOg>
    <xmx:okwyaoVUEDdc-F_foKq15JVlrnREKJ8-rOk1YeGRJDlKSjzOnxNav9oD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 03:28:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3eea9388 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 07:28:32 +0000 (UTC)
Date: Wed, 17 Jun 2026 09:28:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] builtin/refs: add "update" subcommand
Message-ID: <ajJMnZchqdpiuKTg@pks.im>
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
 <20260616-pks-refs-writing-subcommands-v1-3-9f5219b6109d@pks.im>
 <xmqqeci6bupk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeci6bupk.fsf@gitster.g>

On Tue, Jun 16, 2026 at 04:17:27AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Add a new "update" subcommand which mirrors `git update-ref <refname>
> > <oldoid> <newoid>`. This follows the same reasoning as the preceding
> > commit.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  Documentation/git-refs.adoc |   7 ++
> >  builtin/refs.c              |  50 +++++++++++++
> >  t/meson.build               |   1 +
> >  t/t1465-refs-update.sh      | 179 ++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 237 insertions(+)
> 
> I do not offhand know (and I am still away by 2 hours from the time
> I wake up and start functioning) if update-ref shares the same
> issue, but with "delete, update, rename" combo, lack of "create"
> feels a bit annoying.  Wouldn't we want to offer an option to users
> who want to ensure that the refs they create are truly new and they
> are not overwriting a ref somebody has created?  Either (1) drop
> "delete" and take a special value (e.g. "") as <newvalue> to signal
> deletion and make the same special value used as <oldvalue> signals
> creation, or (2) add "create" and insist that "update" takes only an
> existing ref, would make the annoyance go away, I guess.

In theory "update" can handle both updating existing references,
deleting them and creating them race-free by providing NUL object IDs
for either old or new value. But I agree that this is cumbersome, and
adding another "create" subcommand as an easy-to-understand shortcut
feels sensible.

> > +test_expect_success 'update creates a new reference' '
> > +	test_when_finished "rm -rf repo" &&
> > +	setup_repo repo &&
> > +	(
> > +		cd repo &&
> > +		A=$(git rev-parse A) &&
> > +		git refs update refs/heads/foo $A &&
> > +		test_ref_matches refs/heads/foo "$A"
> > +	)
> > +'
> 
> Here we cannot test (and I strongly suspect that "git refs update"
> and "git update-ref" lack ability to do so) a case where a creation
> is attempted on an existing ref and fails.

We can:

    $ git update-ref $NEW_OID $NULL_OID
    $ git refs update $NEW_OID $NULL_OID

This will verify that the reference doesn't exist before actually
writing it. Will add a test.

Patrick
