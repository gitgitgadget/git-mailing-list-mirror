Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793556504;
	b=hlRgrKUreUTumOkMBc6fv2vofTzmKwxw1e55/aC9pkBVMPpPavsrOSROya7qjHIeIHR1
	 G0H5uOak03vwE5RG/zSNC5EV6SoEIfWivWFjbMZB3F3UkxpQE9H8cbXDbEAOa2Aws3eR1
	 nuKvo8ZDIbPJBpW+zbtW5CNz3LxBQfrqsCXdzgWM7Sl4gmDQBUZ/5vI4DNGswNa2XQvHF
	 BF3B9NcV/6/x6cpjjhTRYoIjuekeu4l6fhEz0zEzXrx4juGUKCcMkTxkyUF89zY4m1PXU
	 jcP1oV0EFi3DI4d55tc0/fqDzH30azOAcE4P6LyxlPREc+sex0DC8XzefS9Bw30hgQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793556504;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ms0KeLEJZzDeJClnLD0h67EL2O82chfepySR80XQ+hc=;
	b=wXZMbGrdtg8ViWyaaTDlBwk3w288+EEpgolzvgx/qRu7hNWNrinpyVAcbN9MVog9Z82P
	 pBPgAn4LS9w7ub5T7UcVaZBNtGa7AuGjGNJgOrg0vXRW/i7eNUNIMIPruPEZeAZNRcW4x
	 JiNKDlZQqBAd+P1gsYlhZ5dM5Zj6VOz1HuSC3H6I673s3mVAbS4dVhyJC8lXVkHm+ovS8
	 vgQpCpLrKAPS9PV3pzeoRONgloAdbSh/xGoyCMTePkoVg+Dfl71jXY0qFqDVEC/HweAs6
	 Nx4YpTmsoi2ePSKVNHlXvfxHrGVmnVruLabZbhwmJuRsVw5cQmqfzGCNU1XcXPZ9/cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Qa0hgBxr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RPT8Ihc8;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BD8606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 18:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47BD8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Qa0hgBxr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RPT8Ihc8
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7460E1400180
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 13:08:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 01 Nov 2026 13:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793556502; x=1793642902; bh=ms0KeLEJZz
	DeJClnLD0h67EL2O82chfepySR80XQ+hc=; b=Qa0hgBxr3QMKEFqBEhR8GMhM8p
	9CryXFSoEp6VTjhqFusukYZXvd/1nwT5M6mQESHXQWfnFs3PToh4ULXP234AHd+S
	XAG2VOyjAlXXH3P8VuKRxDTqZQJcpails/oQQeCKwmk3wf6ev9bk/rBuLBo1TpIv
	e+8RJWXmTtQNWFz0Xqbz5oBW86UlRErIRtuKsoeFdDQzoJBSL3NzAKPuu4rqDm8j
	X2HURdB4kebpd9dRLXT2u7e5WPAB+GlyPTSF7niuX3WVwi83fUmkIW2nkfafC0Jh
	UUh6CWM6nSiyZrmBQ/TtUUzn78XEy2Pn3GLiAv8feHsdAjD1RLvp9Ajt6huA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793556502; x=1793642902; bh=ms0KeLEJZzDeJClnLD0h67EL2O82chfepyS
	R80XQ+hc=; b=RPT8Ihc8Z7gkrYKOaPOh2a5G3Cklyl0KieDXcQcgP7be94k4bMu
	ugyKCoSNBthuirMQIYs3swaxN6YLs0UDcJwCF8EJYC/YSSn6Q1EEGQeWqtuMyKG2
	uiPiIieZnkF42ROIdmar6sesUvpP/0cm3pYMBDRUrUlFMPfmbmi6j/Tqogqex2/E
	YhhtNnYzCHNt5Nl7NWBgmZaEh1E+Nwkv6Avkv6ZGQSeubNsNl0Ruw78dwn8fc+8i
	c23JzQJ2LtssVnYpqNBwXujNyHm3/yjgbQwEWwr87o3FJQwXlNBmEELk8plp7kYH
	tg/aVWMB83PoDn0G5ur+78dipFokzDk6cIA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793556502; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:YLF4dT8xQxBKIWF/bEUJr/bEaY97AuSzoy6zy0VstkZ2Ste
	NJB+mp/v6+5kJPPl6tcMx2GcbqdIoDvHaTFbPxxAzfVVbLRGUiEjhQXMwlcxwkE5
	1iky7i22adS2ioTRZzT8RmJ+mxeLVUNjFhhTtCon3/Np0fUUl5kFc+kVR+tHcutj
	mei9pgx3AZ7+xf0bmbf7I60X1vtuY6LYc7eadqKyNwrH1MYxVl0w7FqZ1uJ4C94H
	OqbsgsaU2n4X4FKNOXDxOdGuOusTI7RO0bJORhdxYM8wqPGhpxppRGb9eNCU/7qp
	bjFDmV5CEnk12mF5zH/axq/LTwfXqzvg1l2rmeg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jZNbWFMBMz4rnvh8Y8pVwTMgipH72w9Tste/qNZwM90=:m1vKKJMeUWMbTU74cSoh1N8Qld0ENHmTWmyrMcL+VDU=;
X-ME-Sender: <xms:FoDnaqWyFwjVZidHEm9Kd7b1u1VGE2rGN64bQ_PS8bLBbR1JxD_rwg>
    <xme:FoDnaqSPJHqbldy0Zbm0rEzIBGIl2tnPKnnPTgmj2LHCJkN7R5yVXXG5Nq-ptelsP
    WkJObZDk-K_5rbAA6WBJdpo9pugXe5uZ_bzv8jp2uLm6bVshEvYCs0>
X-ME-Received: <xmr:FoDnaoPbkcZhkrRAYWyizL1h5NQYoENG1Ok4LWOZxBZV-lI-Hvvs01-TkEtcDmKEBNS7bvGnlv_0prD6WzhhfRMEQpkZxFR_q8Em>
X-ME-Proxy-Cause: dmFkZTFaSiYtxCHp0tJAyG+xgtWfqH/lCP4LiBGnBaTu1TxB32mE6RzmS2tNh1hCjDkfH/
    wxsbGSgnVatZcXMd8h2zqKuy7cbq6Hl/qmSW2gXbwuQqarv+lbOMG8DLwHhHctlFklnFvH
    SQxqBN/emEWvwNPcuBKqL5n6YmJPVtqnN2spAP1IwSCOzoQzLiJhtnIZpEgnb0h4s4b9np
    7EndyWxoyFb/5eTWT3iMNbWbeEHyAWcuiNc+w+N2I05iXEi0tVzjJhg5UajWtjefSQ5yIC
    S6bRzCal/FoYEFg33U/pMDjtaGK82CNgQ4+kLAyaWLPfoBQG4GyyfoKanP+dXqytRM6KkS
    4SrfVITxMtim+2H393NlklDFAUuhnFR2SZ6HwrTpHs63rFWeabc7EAsJnx2c8TYdCNSaNk
    7CYn0E2Zp6Y6OSFcfbPFblOc/pl19lh7KereErfC1x5/s5mTY8IBfg6LeBgOl1Lj/ngRw6
    Q50Hvi41VScE0z47+3hhTaFdmZ3hTPxfJomVnpeoEzvSdDpEH3+rlrysCzl4vqCDLJ4aeJ
    tTEazDrcEHND7UFpl7Xooer9qMEGUmZoAvRHdqmwZS4GRwNQ9zJIBfNBiStKYcp54F4Mlf
    efR0q83fl1O2W9XLZUqn98cLd7FqoHal8EeHPc42D21eVI25lWzYtW0eveSA
X-ME-Proxy: <xmx:FoDnaoSYA3Iy-lewYYJbVW6TznrBIizhfWcoLLjl2Sr5AdRjef4F9g>
    <xmx:FoDnamhXtD7NzSUNZT54UJewksIvp3rPxdhxQ4NrcYdIU2mFl9rXEw>
    <xmx:FoDnah_GYAyssfNxXfaQesyW1QxS3puSisyvcnFr7z8AYBs4GZNRcQ>
    <xmx:FoDnatGr0MuYv8vdK-mLFAZ5EcryIXf6c6fmXjStEF5eIi1zdryc-A>
    <xmx:FoDnao5NJve0HrqrUsRJXQW7EKiRx8vl5a569HqPKVx8BGi-S1WOwGhS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 13:08:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Nakul V S via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Nakul V S <vsnakul@gmail.com>
Subject: Re: [PATCH v2] sequencer: refuse to pick or revert shallow boundary
 commits
In-Reply-To: <pull.2273.v2.git.1793455522168.gitgitgadget@gmail.com> (Nakul
	V. S. via GitGitGadget's message of "Sat, 31 Oct 2026 14:05:22 +0000")
References: <pull.2273.git.1792577381142.gitgitgadget@gmail.com>
	<pull.2273.v2.git.1793455522168.gitgitgadget@gmail.com>
Date: Sun, 01 Nov 2026 10:08:20 -0800
Message-ID: <xmqqbj881l2j.fsf@gitster.g>
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

"Nakul V S via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nakul V S <vsnakul@gmail.com>
>
> In a shallow repository, the commits at the edge of the downloaded
> history are recorded in $GIT_DIR/shallow and have their parents hidden
> from the revision machinery.  Such a "shallow boundary" commit looks
> like a root commit that added every file in its tree at once.
>
> Reverting it therefore removes every tracked file, and cherry-picking
> or rebasing it adds all of them again.  In a "git clone --depth=1" this
> is the only commit there is, so "git revert HEAD" empties the working
> tree, which is almost never what the user meant.
>
> Refuse to do so by default for "revert", "cherry-pick" and "rebase".
> For "revert" and "cherry-pick" only, add --allow-shallow-boundary to
> override the check; it is remembered across --continue.  "rebase"
> always refuses, and the error message suggests "git fetch --unshallow"
> instead.
>
> The check is made when the list of commits to replay is built, not when
> each commit is picked, so a command that is going to be refused does so
> before it has done anything: no commit is created, HEAD and the working
> tree are untouched, and no sequencer or rebase state is left behind for
> the user to clean up.
>
> The "apply" backend of "rebase" does not go through the sequencer, so
> it checks the commits "git format-patch" is about to turn into patches
> before it rewinds HEAD.  This is skipped altogether in a repository
> that is not shallow.
>
> A "pick" or "revert" line for a shallow boundary commit that the user
> types into the todo list by hand is not checked, as the check is not
> made again after the todo list has been edited.  "git commit --amend"
> is also left alone for now.
>
> Signed-off-by: Nakul V S <vsnakul@gmail.com>
> ---
>     sequencer: refuse to pick or revert shallow boundary commits by default
>     
>     Changes since v1:
>     
>      * Also refuse cherry-pick and rebase (merge, interactive and --apply
>        backends), as suggested by Phillip.
>      * Check when the list of commits is built rather than in
>        do_pick_commit(), so a refused command leaves no state behind. Uses a
>        single shared helper.
>      * --allow-shallow-boundary is now accepted by cherry-pick as well, and
>        is saved across --continue.
>      * Dropped the option from the revert synopsis.
>      * rebase --autostash restores the user's changes if the rebase is
>        refused.
>      * Rebased onto current master.
>     
>     Not covered here: git commit --amend, and pick/revert lines typed into
>     the rebase todo by hand.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2273%2Fvsnakul%2Fsequencer-shallow-boundary-check-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2273/vsnakul/sequencer-shallow-boundary-check-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/2273
>
> Range-diff vs v1:

For a single-patch series a large range-diff like this before the
patch makes it very distracting.  Isn't there a way to tell
GitGitGadget not to do this (or perhaps add it after the patch)?

> diff --git a/shallow.c b/shallow.c
> index 8e244a5669..bc31ff5232 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -92,6 +92,15 @@ int is_repository_shallow(struct repository *r)
>  	return r->parsed_objects->is_shallow;
>  }
>  
> +int is_shallow_boundary_commit(struct repository *r, const struct object_id *oid)
> +{
> +	struct commit_graft *graft;
> +	if (!is_repository_shallow(r))
> +		return 0;
> +	graft = lookup_commit_graft(r, oid);
> +	return graft && graft->nr_parent < 0;
> +}
> +

Please check how badly your change conflicts with at least 'next'
and 'seen' before sending any non-trivial patch.  Doing so would
have shown you that you do not need to write this function, and
should instead discuss the best course to resolve the conflict with
Harald, who wrote f8bc48ea42 (object-name: explain why <rev>~N fails
in a shallow clone, 2026-09-23).

That other topic is currently stagnant.  You can see how topics are
doing by visiting the mailing list archive.  For example, a trial
merge of your patch into 'seen' would have shown that Harald's
f8bc48ea42 is highly relevant.  Using its Message-ID, you can find
it on the lore archive:

  https://lore.kernel.org/git/pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com/

The archive shows that v3 was posted without replying to reviews on
v2, and no new reviewers have shown interest since then, leaving the
topic stuck.

The best path forward is for someone with a stake in getting this
topic unstuck, such as yourself, to provide a fresh review.  This
can help push it to the finish line, or help us realize that it is
not viable so the topic can be dropped.  In the former case, you can
reuse the function introduced by that topic in your patch.  In the
latter case, we no longer need to worry about the two topics
conflicting.

Thanks.
