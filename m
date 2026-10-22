Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708468;
	b=ekaq6AQHL0lv11HxWKIU2Grdn18wyg6wF30lWMe+WL2CaekIrC60IDRO5vXwCxeNdHDn
	 ArQG5p5bXJ8Kh86aCn5PrBq+WzN7+dmHNE0C2lYuLMx42MOuv9+kI6sGFZEXwikBLtX2q
	 OmHyin9NlbCGeNW7D8qf9Lrr77NqDeZCz8lDPYhympG3dDEBVCEfxS9jihSvzmStEAXP/
	 r1miNAJlQtRYiHHPdasK/TtGk674F9EipLuBPrGrDMI2XlOVRyQDzliMc9A+w+RBGmYtL
	 hFudFS/Hi/s0oohZRZy6xPFOVhjT17HP9m985AcTXZDqbG+fOALnlFV6lsX7Ln8INmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708468;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=/BCctqpevE9cVtKY+Qie+XTQ88fLiAKmoEKWF2T2bUY=;
	b=yQlebQPpe0/qwBNhFMXI44D7Tn40aBzLwFibB+EhBD8axyOfFQRN9J+XsmfI26vf51z4
	 qVBqzeyPvziD/XAmCB3IyAhNCtlAljnDAC6x7Eo7MFCkCOAYwGdlloOogWcpG4J2tg9KN
	 FdT7iz8w8lifbreRZhmI1WZhrsRXINMdnZjEKxNXIrbIv88i9pCLivt6s4zv7y/9ovd4y
	 69DkVCRtHKbPq15frRj54r/XSOR34LJUJlS78OFURlf9ERdpaotb/nC/FsOWgfgm/ThWZ
	 3743Y7pmmPVn4C5fEoHgCBWlw133Bma+bQggEZdBdfsYLVoc8BiQq9XfOew0nXrU9sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kidsdRG9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Fey8N7G8;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47743606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 22:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47743606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kidsdRG9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Fey8N7G8
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9E50F1D0017A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 18:34:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 22 Oct 2026 18:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792708467; x=1792794867; bh=/BCctqpevE
	9cVtKY+Qie+XTQ88fLiAKmoEKWF2T2bUY=; b=kidsdRG9778grzgzv+smpcRmFI
	Ud1qBvkhdZHc8fJoYclrFNszBwzGqa7jXeEBc7tqcHPdgkrf2GNLlI0p1dJileYs
	LKLUB0EpVCIzfoEUmImh2vwgTpJjandhLT3+VxkhS+vLR5jnNhEY/oE+Nc5kvo+b
	8oj4y497SeMACjl+3d8naxYVggUS1D4ccNWMyLnkZiHJxi7OQ1imQYDN2MOQCT0V
	EQM2uHJvcQ6aWJ09qN5pe/LFCB1WKx2r30/WV8veqoBOmpL2UWTQHPAgp/xgjr+H
	jY1Zbl5VkYhMiVniFn5SN77M2PWlioKOJ6aWMBluL0amGOirHFDpfMAKyQaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792708467; x=1792794867; bh=/BCctqpevE9cVtKY+Qie+XTQ88fLiAKmoEK
	WF2T2bUY=; b=Fey8N7G8VO37nX17IbAY1OoLvLPMfaVQEWNWBAWZHYhuBoO61CD
	Jilw6VENbVlbEAb24he0OA54KLqUEh851dWLO4cjqb/u59JxKWIOEXezdLK4kKmF
	37IYxi7p3FHyVtzCCADCnvKKHIDzqWod147nrFnoTOXWqTDqtIBDe0CVVgfXTISe
	E/PtR1qcLOsUsN+mEk6hPIGlpLHT7poR3fOrblQLc1j6UckzmzTqD4oWHsG4hM3h
	+OM74B/z9Psr1dLqdxOU/aGtRIwpChEk1xPhx6dj6UNPWteP275yabcGV4T8nvdV
	QZE0DdD/x48MJMRllTSg3Z2m2A6f0pWr9xA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792708467; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:gPzG5PGb9nYE4xmPoEQN9mRrxA5gHgAlINxRMoqBZN9ag5J
	Y4RQnsojUDLhpEyyVJpt6kHlVasP0lcmMFMfjvtmnd4+ALI0rOfY8klsyQx4xuIv
	FRysW0v/k7M96YGZzvSWzC8FMuFQu397msQpPYYZDwHt1WsojyH1YHc84KOS1Xxt
	WXOwlhK3TAiJ5Ai94ZXKgYmMYFGLCD/vUs9ue+WXRfB46flLEA6kDl64TEJEN8eH
	DP4ctrRQlD9v8MdUEvvenpZqZdxrUVcLDWwOTGWo3Ig1CaUKPzuLrgbXNIqDC1Uv
	sYjIADdEvtizo06D1hn2HuHpBmsTMZLYFueCiAw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:SlweK2hgB0E2YidbQt0/VgZi2A+v5RGHahT9Ds5ZVkc=:LBrH2VwPWRO5MC0KM8wsyJvy798rtnGtG4PZA295dt8=;
X-ME-Sender: <xms:c4_aan2SBTikPGeFiaX9dRPZSteX6ii5adG6NCWzdPWW-YeeE2umaA>
    <xme:c4_aah4YaQqEJReEA6IQuHwpGb3L6lqPGBkw6gxC2c_X1EPAA0J8POMe6hkqPr7FD
    e7IGT5BKSgaPC_8uFnDOB6fpCJFZM1S7XdKohIqdIgFomQq0tTijXw>
X-ME-Received: <xmr:c4_aajRyY-J1mvWxOIZiQ7H-SJV9PBlaKjoiGyO4Y1ZTB_5H62M3epYSn8Qfy_9Rcgaj4_m2oeozaf1WUxOI2QPXw5a2zL5YJGGF>
X-ME-Proxy-Cause: dmFkZTF/054Xto4L04G/SqEPC1irRPQlkweQ0fCoq0AV8x+XU3doe4zZD8r2ZvA/sCqxhL
    JPCmrnI0mGwOfH12Ajh3sRqdnnMNMrq6Eg7/vUV5XvJdXlqkUL5+wa4Jy63pmpU3tjeXT4
    JpolG6legSI7JBLmdqYpu9rDjQUUe+iyVS6hNIp9YIb4akhk6+DW+PXCN7F5lpq8PFih4/
    zY3N29g3P2wfyI4/eSVTMmRMVh+3Cn9uQ2UukOqH+t7Nq9GNjbzWpQcbbxI6KLnYy+icIV
    owNv9I/7vCBxj57K3Dy+gkIAsMGPhZjuri2eFBEiD9InHV3YeidOu2bvZzkxTPjyiNYwdf
    fxH6Zl7G/3q0PmXC5Z/10xfrIrevYxnghR5nweOVExHuzc9QKYanz8AFhB6PIWglgFEltD
    2mUcB7l7SIncHtt3+rvryRw1D+4FoeiNMVceDd/SXA6bepEq5JBMMhHeyvbRGAzzUnAZIJ
    og35/K/+X8yY6qFbLjBWB9Mmf2Pa3HigJwr4Xbgv9dgPK0WF6KihzKYPutnIyXSkf6QeZN
    x/1J1ojMszOJ2QFHtF5qDC6jcsbE1s2eJPlcJqKtcbBdd6x4s+NBjK651UBur6R1Jp/7QX
    uLUaPklK1CJ/nKq+XoojcIWPp0mXNG3irN3AZdTTbu1ec2yXaVfOmRTubKeQ
X-ME-Proxy: <xmx:c4_aamWVkE9VAYz_HCd99C3RoWx8gUJcFKPhuIrmzmLkrZVF6iPJWA>
    <xmx:c4_aaoHwblx_g1GY-b461uMvtzJnwcZ97YdEXJBxUPP1ld6jkx5c9Q>
    <xmx:c4_aapceO8cdoaeYap6lOhgQE3uXwfV3TTFjin_G9Aq9amQqjXWSRw>
    <xmx:c4_aahq-dOApkfEnPLSDLErTy8oCp7z77DBGlC4t2DBz_occwDL4lA>
    <xmx:c4_aauoMo_ZTEhfs_AfXJ35ytDq2DMkt1WDya4V0-EmR5esrSzRjMUxu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 18:34:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Elijah Newren <newren@gmail.com>,  Jonathan Tan
 <jonathantanmy@fastmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Derrick
 Stolee <stolee@gmail.com>,  Ted Nyman <tnyman@openai.com>,  Daniel Reynaud
 <dreynaud@openai.com>,  Aaron Friel <friel@openai.com>
Subject: Re: [PATCH v2] negotiator/skipping.c: parse parents before queueing
In-Reply-To: <9e9ae442333b5e2ccc0905c44c2c3e16c49481a7.1792704069.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 22 Oct 2026 16:21:13 -0500")
References: <dc3dfa3647c42da9170bf3289f4e8a4a8a55c8e2.1792441003.git.me@ttaylorr.com>
	<9e9ae442333b5e2ccc0905c44c2c3e16c49481a7.1792704069.git.me@ttaylorr.com>
Date: Thu, 22 Oct 2026 15:34:25 -0700
Message-ID: <xmqqld7pcqku.fsf@gitster.g>
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

Taylor Blau <ttaylorr@openai.com> writes:

> From: Taylor Blau <ttaylorr@openai.com>
>
> The skipping negotiator sorts its queue by commit date, but callers
> which push commits onto that queue, such as `push_parent()`, can add a
> parent before parsing it. When an unparsed commit enters the queue, its
> date is still zero, so old ref tips may sort ahead of it.
>
> For example, suppose a topic branch is one commit ahead of master.
> Skipping offers the topic tip and skips master's tip. Master's parent
> then waits behind old ref tips. With enough old refs, negotiation can
> end before we offer that recent common ancestor.
>
> Parse each unseen parent before adding it to the queue, so the queue
> uses its actual date. If parsing fails, leave the parent out of the
> queue.
>
> Since the sole caller of `prio_queue_put()` ensures that commits are
> fully parsed before pushing them onto the queue, we can avoid a noop
> call to `repo_parse_commit()` within `get_rev()`.
>
> Note that unlike the default negotiator, the skipping negotiator's
> version of `rev_list_push()` returns a pointer to an 'entry' struct. As
> a consequence, callers must be prepared to handle a NULL return value.
> The caller in `push_parent()` gains a NULL-ness check, and the remaining
> two callers continue to ignore the return value from `rev_list_push()`.
>
> Signed-off-by: Taylor Blau <ttaylorr@openai.com>
> ---
>  negotiator/skipping.c                |  8 +++++--
>  t/t5552-skipping-fetch-negotiator.sh | 32 ++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/negotiator/skipping.c b/negotiator/skipping.c
> index db90fa77b53..0ae5f28d353 100644
> --- a/negotiator/skipping.c
> +++ b/negotiator/skipping.c
> @@ -66,6 +66,9 @@ static struct entry *rev_list_push(struct data *data, struct commit *commit, int
>  	struct entry *entry;
>  	commit->object.flags |= mark | SEEN;
>  
> +	if (repo_parse_commit(the_repository, commit))
> +		return NULL;
> +
>  	CALLOC_ARRAY(entry, 1);
>  	entry->commit = commit;
>  	prio_queue_put(&data->rev_list, entry);
> @@ -125,7 +128,7 @@ static void mark_common(struct data *data, struct commit *seen_commit)
>   * entry has the correct flags and ttl.
>   *
>   * This function returns 1 if an entry was found or created, and 0 otherwise
> - * (because the entry for this commit had already been popped).
> + * (because the commit could not be parsed or its entry had already been popped).
>   */
>  static int push_parent(struct data *data, struct entry *entry,
>  		       struct commit *to_push)
> @@ -152,6 +155,8 @@ static int push_parent(struct data *data, struct entry *entry,
>  		;
>  	} else {
>  		parent_entry = rev_list_push(data, to_push, 0);
> +		if (!parent_entry)
> +			return 0;
>  	}
>  
>  	if (entry->commit->object.flags & (COMMON | ADVERTISED)) {
> @@ -194,7 +199,6 @@ static const struct object_id *get_rev(struct data *data)
>  		if (!(commit->object.flags & COMMON) && !entry->ttl)
>  			to_send = commit;
>  
> -		repo_parse_commit(the_repository, commit);
>  		for (p = commit->parents; p; p = p->next)
>  			parent_pushed |= push_parent(data, entry, p->item);

Moving the parsing to rev_list_push() means that when a commit
cannot be parsed, it is marked as 'SEEN' and NULL is returned.  The
caller, push_parent(), notices this NULL return and naturally
returns without pushing the parent.  However, when the same
unparsable commit is encountered again (perhaps as a parent of
another commit), push_parent() sees that it is already 'SEEN' and
looks for it in the priority queue.  It will fail to find it and
trigger BUG("missing parent in priority queue").

Perhaps rev_list_push() should mark the commit as 'SEEN' only after
repo_parse_commit() succeeds?

While this issue only arises with a corrupt repository or when a
promisor remote goes offline, a failure to parse should not trigger
a BUG(), which should be reserved for programming errors.

Thanks.
