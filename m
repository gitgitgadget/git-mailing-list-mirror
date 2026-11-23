Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464847;
	b=k9vh5cvLUInYz9NGznWw759HxuQVsJeGKLmi8Z8TM0B0SdENj0Yi55pR385anD/lNPH0
	 Y4D9mAC55nXhwVa0SIVXv79cZQZMboUBD5JdNVIJPxGR9b88rWGivYkP6mg9/yFksjz2J
	 mEnAbRmPI4Nd39i3mY14PS9NYIqBq9Xt+ZBmHeLd/djiLv+QfeKFmKBXh98HkVGjneDJz
	 PbN63X0mXowq4TS8zBw4VMd0owlJh2MmfSnl8qBn1ZzYDCuyKaQNsEFrifHSBb8PvjROr
	 SOPWIPpuIHKmOVtV8voDH7i/i0E7FzqFhEIwJipWou/FbnS2pUioWiRnAeZKyYwCbbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464847;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=/VIUiSa0vpsDtGDhMo6gqz/OK+zPymsx/hhZNiif5IQ=;
	b=UwD031YL9I7BAQ54bDbZ16KG32hQ/2kCZk8xc+3UDlEiFimCvGi+r1HrMBr3kbDTs6mB
	 IrlXjvB32k7Xvbs31jevCVt2Fb86L5yeCQY/+uPMD/6dGZYqUi46GchcC2DhW4MYSIjYw
	 UUZZzPobpsoSlWQxrpNnpV0Cm5n+2rifEFazoop1RIjNuG7nsCLvZeeqi4x1qgZ51/CT+
	 Ex/MIkw413Fpmlm3NAMk3U80GHzo0Pm+ooWY8LyT8Da0EyjwBUXTiP8lc99+KyzrxT9Uy
	 GEwechrtQmYALKFWTXbyUvv68rE+h1zzQw/NIYPhaE42Mc0rumXyhu9OIGYCa8+T81A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Kgu8m6ps;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="d/NkTIhz";
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D8606A327
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 20:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 175D8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Kgu8m6ps;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=d/NkTIhz
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2FFD51D0065E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 15:14:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 23 Nov 2026 15:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795464845; x=1795551245; bh=/VIUiSa0vp
	sDtGDhMo6gqz/OK+zPymsx/hhZNiif5IQ=; b=Kgu8m6psELyGaOWNtSuSh8tMOj
	/RhPqADTHi045qOiWUATlf3fOmlpa2nZ0GB3W3/kf6dNzXFloJiffQuRFXVs+JLI
	2HruZ7aUIS/6DdBOUbxZvNMsTrvBY8miQRusBISv2oThOpUwh4KHZ4jCW0mSkIsf
	42JOHlCFe974R95kku4tIxlABtdwvX5glPkaolm9hbZ1ugCRjHHhfG1/nJxr7iqT
	jg1DfLcszBRpHL1wzLil6x6059JH+1lU6AXNAk3VvDmUbHXqakcekoLKa+Ylh+bW
	i2t7l44WOeP2AVJOK0Vl0ROLUzH/BW5E3E+UuXP3/drr+SE5AACFMnJjZQXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795464845; x=1795551245; bh=/VIUiSa0vpsDtGDhMo6gqz/OK+zPymsx/hh
	ZNiif5IQ=; b=d/NkTIhzpq34FjLElRXF81UpMdogfpy9+v5WRgVqaR8/d0UzJpA
	o/EHTWozq2U3iGSln/vknLs8pPJWACINBv7SSFkF5QhoGl9kIGnZXslcJLU6Y5D6
	FT403bBQLOddVIiTsaT/xIb5r626cxckzr78Fl64Ug4yqE5rrb1cR0xvM4APaheM
	1bbBRtPljpx6ylv2TROi1VeCRCc4A6OVPZ7/+SQw6valz7F+aNdL2KrwFhOWrAE2
	OtHooZKfcN8ZONZwOdgzbtMzZJZRudPnqAzLumB2z2pfSA2Ei+/udiwaA0/5VRtI
	3/2oMvkOjWIya73lzbuN16VbPOZcLnzM+Fw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795464845; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Denn0FqHWjfolgCXxeU9TXkulkOW27zS3HdQ69kPShZ+sA5
	n0rGkcSQmFv0H2vZVmOK2CXuY3PVbaexldz6cmcclRqb7YYbV0FEDuhZtTSjNean
	57w/GkgQ+TiaGZWfZVIWk0Jmd85FLtYyKylLpPYtU8XFrC3CZYOVnQOa5USAHHUC
	hk3QvPZci/51QxcZFHKhSZcV1CjNDKD/D9fyD15D9sE37lx4GEIpUr2ZNAfj05Wi
	Wjwb0SFbo7IbNuVT0B12AID2exMeM6HbqTqoZFilI/mfwdD5VUlMFF/6C0IL2iXP
	tTnViBqKUe4/orwM56b/QeRDR9mMPPMc5mA09IA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ILf6UeK13Od4TB3syBhzjLQSJvZPsvxSqj5ybgP0pdI=:IfX8iUyCNceMaS4OEzZJGPwIqBmau9WxrDOPfwSL5HU=;
X-ME-Sender: <xms:jJ4Ea9R64x9b69EkA9UROeP1Y88FYr2QUSTYnVj7Q8fHKbO-_6AOgw>
    <xme:jJ4Ea3cyVZYHn85SBZSv01kllNqX4hojQZnoFF_ZZuu87LD6X9X9mxPB5CbBxFYia
    JSve1_6yxgjYsFx_U73gUqHSwrc6kVmV0ElqYg_8zk1NOpwvD4JLFc>
X-ME-Received: <xmr:jJ4EaxA7Bo3YYHtMi7T7jq2h6ShMDSt-zJSxgr9M3hfDuskvGiT0T-KsqRl1WC-oOxI_NVP4v0muzmI00GCCDLte6_DTXtssYC_6PE4>
X-ME-Proxy-Cause: dmFkZTGwtRdLksH9XLR26g5MKyxdJNskFHPZwWupZ/jPIUHMS9f9ws2zvuG1PAccZeUHBK
    AfdnQZ6l7xY4II+3MPzkJgBcUQdVYOL4PxbvNaL9UhTKq/hNn0ZhaNviIVn86t4hRYGYg/
    xO98VDF6MfMP9B0Skg7gYC630G1yDQzKDQl+IPsb+PNAN37Hdy7uvEaYgRuxdU5to3TqKc
    2tRHaqwcuYs6WMmCs3pWFZ3++DI5AUFYON7rZA0sXr3ILohihnL00dXJZtwnu2FdJt8EAL
    snxcQUXeWCBR3vfZxbaPAD7MrnZFd0Re0n2pRHoTZMQWA5wXXE0Kh31fv1XNlwY5OYHVtM
    N8zEmg62s9oXQu+cUw8dhxvF/K5gWNGsZ+gwJn/gb8TVSkkC6uNd6cmiMxhSHo/CMgWlxi
    OYJF8HQwRtRkDdC8YW3WA5dBN1fsSY+X2ssRMh10Obrpm5upR4+kt6b/6BDGGBO2ctudWv
    ENSuGl+eoM2nUbqqNmYeClSwMY8IBtgZuScpPQf395ctpXk5UuG8sOwPHPnqg0beukcJwr
    xjy9RWyewcTPVET1U7/ij/19yNgd550fxGhCCMBxv2aQvn8ZpyKWY/2qioD7trDo/ftg4M
    +cQ6Tsz7Cw7iIVU5QqNf/kjf9odgW5UX/MuxHKi17xumMoZtY/cTPOYhaCbQ
X-ME-Proxy: <xmx:jJ4Ea5nlxEkgkj-PQHTqlvYd0YqJ5hdu-p-L8WBPQVvoj0zutE-vGQ>
    <xmx:jJ4Ea8eTAxpw5Oqg1qQ4QEQBhZWb0TsWzvJN2DUp3ej-yYWAIYY5xQ>
    <xmx:jJ4Ea9SwJ6YgRft_bG5Fq2wFivWCXKwCKIqjP6OhaUX0opGgaArZPw>
    <xmx:jJ4EazuAwdb55jA34xHMAIf-HP1Aq3JbI9b_VddODBDJrRoo92fqgQ>
    <xmx:jZ4Eayv5YRd-CeMlf3Nhr8uzOKJOWrr04jON-YfghYUaXTlrdXs6D2QW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 15:14:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Toon Claes
 <toon@iotcl.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Nikita
 Bobko <nikita@nbobko.com>
Subject: Re: [PATCH] history: refuse to rewrite branches used by other
 worktrees
In-Reply-To: <20261123103911.98860-1-aniketgupta3001@gmail.com> (Aniket
	Gupta's message of "Mon, 23 Nov 2026 16:09:11 +0530")
References: <20261123103911.98860-1-aniketgupta3001@gmail.com>
Date: Mon, 23 Nov 2026 12:14:03 -0800
Message-ID: <xmqqa4mz5mr8.fsf@gitster.g>
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

Aniket Gupta <aniketgupta3001@gmail.com> writes:

> +/*
> + * Rewriting a branch that is used by another worktree moves the branch
> + * without updating the index and working tree of that worktree. The same
> + * goes for the branch that the current worktree is rebasing. Refuse to
> + * rewrite such branches, but not the branch that the current worktree has
> + * checked out, as we update that one ourselves.
> + */

The intent is good.

> +static int reject_checked_out_branches(struct repository *repo,
> +				       struct commit *original)
> +{
> +	struct ref_filter filter = REF_FILTER_INIT;
> +	struct ref_array refs = { 0 };
> +	char *head_target;
> +	int ret = 0;
> +
> +	head_target = refs_resolve_refdup(get_main_ref_store(repo), "HEAD",
> +					  RESOLVE_REF_NO_RECURSE, NULL, NULL);
> +
> +	commit_list_insert(original, &filter.with_commit);
> +	filter.kind = FILTER_REFS_BRANCHES;
> +	if (filter_refs(&refs, &filter, filter.kind)) {
> +		ret = error(_("could not filter refs"));
> +		goto out;
> +	}
> +
> +	for (int i = 0; i < refs.nr; i++) {
> +		const char *refname = refs.items[i]->refname;
> +		const char *branch, *path;
> +
> +		if (head_target && !strcmp(refname, head_target))
> +			continue;

Imagine we have a bare repository repo.git whose primary branch is
'main'.  Its HEAD records refs/heads/main (which is a common state
after you run "git clone --bare" from a modern project whose primary
branch is 'main').  Then you can add a worktree ../wt to check out the
'main' branch, because branch_checked_out() will say "no" when you
create and check out 'main' in that new worktree.

In that setup, what would running "git history" in the bare repository
to, say, drop a commit, do?  The 'main' branch is checked out
elsewhere in the worktree at ../wt; we run "git history" in the bare
repository, and head_target above is resolved to "refs/heads/main".
This 'continue' triggers for the 'main' branch, so we return ret == 0.

> +		path = branch_checked_out(refname);
> +		if (!path)
> +			continue;
> +
> +		if (!skip_prefix(refname, "refs/heads/", &branch))
> +			BUG("branch filter returned '%s'", refname);
> +		error(_("cannot rewrite branch '%s' used by worktree at '%s'"),
> +		      branch, path);
> +		ret = -1;
> +	}
> +
> +	if (ret)
> +		advise_if_enabled(ADVICE_HISTORY_UPDATE_REFS,
> +				  _("Use --update-refs=head to rewrite only "
> +				    "the current branch and leave such branches "
> +				    "untouched."));
> +
> +out:
> +	free(head_target);
> +	ref_filter_clear(&filter);
> +	ref_array_clear(&refs);
> +	return ret;
> +}

Now, the following is all outside the context of this patch, but
looking at cmd_history_drop(), it calls setup_revwalk() which in turn
calls the above function, which does not complain in this case.

And is_bare_repository() is true.  We skip update_worktree() and
update the 'main' branch via its HEAD, making the index and the
worktree of the worktree at ../wt out of sync, no?

Perhaps head_target should be initialized to NULL and assigned the
resolution result of HEAD only in a non-bare repository, or something?
I didn't trace all other callers, so there may be other glitches I did
not notice.

The proposed log message claims to "Skip the branch that the current
worktree has checked out, since the command already takes care of the
index and working tree of that worktree", but as we saw above, it is
inaccurate for bare repositories.  It probably is also worth noting in
the log message that 'drop' updates the worktree while 'reword',
'split', and 'squash' preserve the tip tree and 'fixup' incorporates
staged changes from the index.

Thanks, I think this patch still needs some work.

