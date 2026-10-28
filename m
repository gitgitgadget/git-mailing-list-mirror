Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187178;
	b=RLHR1/YJRMDLGmF9lM3nnr2EsIdRL1ex0k9PUb10bEGtkdHicjwd0984VFTbjutB2BRh
	 bXOWDo8IO+yLhyaA5U7v/5YkKJJdsFRIdP+4TIXdod+ISpBHBQJGmDu5cd8L5deOMjLMb
	 Nw78nY0McA0G77V8k2zJ8mpoevBS6oaB00TJHiLbq42Bibs2JHcv5zxEHjjJz00Z3XVl0
	 fVNFX12VjQzKj0aP1K6ZsziOq7y8hHOIYk2TYkwt58D09GnkaZyFknhXeDcp0nRpQ0OXV
	 bxbN4z+9zgA1q8SIxUapfKHrMof9HjCeGMM5kbZZf8vWmdwo7yqtbim81FX/IpEE7Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187178;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=CD7G1dq0qDjBX9aIA3gpFHxmNL8jzMrKolwIIKdJg0U=;
	b=2Fx74nU0ZxEmVfPMLdVXEeImnmO+TrTyb4CpMpilQ7Jypnjep/GpaiBEdnM0LVnfXZ5o
	 m/3/L4xB2Ffya8oLtqnAvEpnelOJSZwpjNQx68+H7Lzx2ME7H1cY6KJTT7/oXlyiVZaue
	 QE3XCPMuRqLP+WV78f7cpvmHDg3NsxO64UF3WniszqRDAABSYrWlRb/51WMRywA1cpBKL
	 i20aNiVtOCIgip4iFtilU3upjbDPfML79wBrLz2QEdHvnt2Df2X5LxzOmpBziUeNc4VME
	 HQ8YXzDZ2sPcTo/cpXI8by1IPaN3Sn2XdR0AeypJpNVoEuzZhFWsn/vvvlaYnxwKQQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=p4ocq9gS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LyDVZ3fr;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCFD606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBCFD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=p4ocq9gS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LyDVZ3fr
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 219A21D0018C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:32:57 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 28 Oct 2026 07:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793187173;
	 x=1793273573; bh=CD7G1dq0qDjBX9aIA3gpFHxmNL8jzMrKolwIIKdJg0U=; b=
	p4ocq9gSiYE/QQzEe4EodJXiBinJ6Fvzmtfx0xGs/KD25XPt5jYehYum5jSUX1Rc
	BQ6UaqeszgZDzTAKRFcAkp9HodcnEEhJ5OXqn7fOtHBvJNhFbBVLwI/vA+l4/Wku
	KVzMe3J6fsAhmpiA0Tf1eGt619L+vMYgJ7ARnNzCXz2mEElQID8jbNnFIDauwyS4
	nfVdgvI3rQo7ZxF2j0kGu43+k8AzYVPJYJ8J3YlGAXHHoIO/Ydgmi8TOjR7B0ltU
	ZUDLk38S+KZJrtSiQe5rN17RGafCr0DklIYDI/jMXkyQBMeFopMhp87x1ia1BDLa
	7BiUNQjyB8h4ncrJzgzGnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793187173; x=
	1793273573; bh=CD7G1dq0qDjBX9aIA3gpFHxmNL8jzMrKolwIIKdJg0U=; b=L
	yDVZ3frfs4Ok0zrc/LtS6/Uvrc1uQz4C+I0rePcgVfUxNo+iVP7l7lFW4AckDit4
	cqNsA+YPiyxh2ofJxz2dLcWCLYyueON0sKuSF4d2WnOwmLSr0rMBIqdjNoYdxMfi
	x6P8G6zMGDw77rvnS3Kw5RnVW1Y6brCAuWjWPQbyqjXc/2ybCXSO//m8p6J3wWL6
	ynaoO3vksBTHGr022FHopOKTdP4SHP537KpqcosBoSQcD4xVWFe6kmE0RwD9agyz
	yEI5UXYDE/cx0z3fMZ28JkHk5DlCY2FEtrRye2veAw2Kz7rBK4F0VsPZpIE5Kpok
	7BAvBr+gUUaSAN2uuikXQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793187173; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jNOzw6ZEtai2xmdtpHkSobBUyWe98FIP0bg1sRe7GcNhVlV
	E9Mn4cBJ2lzvESahgX/kqe5OjeSy7NYSUHS0IRaKjYUopaZwsTPpbfQ+gwcvOSHt
	thXPzDu+WfUrKxMpWzGsykmcHqrHclPmZqPzfaDIade85Jn3HoD6Dqi0wnMsCUqx
	OCn5y7xA+/o8JTjFtNMe9ivzj12j2MuMIbbKgtYHQtl+ORPC1qeiGBRL2EwO47XD
	ymOeFYHI0xK5L8Y980tH6wW0w69yTl3LNT2dVwU2yrWbgXuxSueBsHBTGziw4Bpv
	S7ucSsj7JVU+xvo4z0HiocZk101HOv8dD6Kh9jg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6do23c2Sm/4QQDZ+DVWgbrzfWTg4IplwY29R81JLecg=:GMIDgXHcaiQu8OhtiA8PgVm4tj/1k6hcdmL5OrPfB+E=;
X-ME-Sender: <xms:Yt3hauK09de8mIqQ2O3NCUklMbD2koniBwkyyxqWrI6n3KVPPZe9Rs0>
    <xme:Yt3hag_kB0wMxvfStn_5D8xTXbHKzF9q9goiGAgetQfBYgvQAvTMulmxxU0t0iFt2
    kbnfYHnIjgbC_VwAamOGcjlVmdBn4S4fcPUyv_Qpe4O_jsMDTLk3oog>
X-ME-Proxy-Cause: dmFkZTFXYfnMJYT3NdPV+pPyB4M7xn256V8kgguKZq5Ol7gvbxD7uUKUrgODLviwczrDe+
    Fi6K4Skj6LbcSWLvN0o3IprriOTw0AW2E+lBjWu2VBYOzLlVc3cPWPFJS3iNUojVmfT2T9
    PFHDZblvTMlQ8TNYfMK/+qyCiERnNngPiPwa3nLRjGdrBQDtELZfgcwYtdF+2byE3fmSsf
    dUTPUJyWH+yH7XaswAhzt8pusqnTM4UfA6p198EJk6NwkWkVm9sv8gjaM4nlY7O5vALZ02
    3ksQfxVBopbQxLvqGyysp3x/sDWyC6C0WMMJSTzG4K2j+5UoG6RBTT021Rn97wUOYziSWs
    vAxMr+ivAbGWZC1EdvKFN7BwSH2GQl1wjUSn7rhgQCtRlRqun7gubnlCFCk0ugy0VSUo15
    /ZaWNp3EkAW+OUiUVXS8JOCDCnbEJdt+wlQ+Ib9icLJENh5FTZK92sdJGJqadLHKjq7wvv
    RQ2VeI969Ya/jYM0RXvHlU0ca3In0qoV/F1V/l1GW2B6Q9VUwfXlJoMyMr/xVjvNuFSl2n
    qgAhFyp2at4/XPDF4AKb3CdlXOrAPD59MsWOUCooW2NQIV6qFhOg9dlscpyzFJwyeTFizX
    OPCzolPH/ZG/cNEmrjnnADV3TB7CfMjrNyT0jLexPZ36ncCfp4VQ8c6s3BSA
X-ME-Proxy: <xmx:Y93hat2MShi4biZVTptqOtOOi1Gt0WJnRKVQtaWw-E6IVeVfq04p0Q>
    <xmx:Y93hatb39beyTeedQL8jc-AOLaDD6zoYwThTVLHNfDFyN89Jl9bF0Q>
    <xmx:Y93halKZIsRn4v3eG8RQa-oXtMZKhxvP0AGLXN8_TqaYtmkasUlSeQ>
    <xmx:Y93hasESQ5vKmwKdnIHMsNFo9lWFpZzz5DFOqBUubsFtUqzxRDh0mQ>
    <xmx:Zd3havGGv_W5QplLJtaDQUvJ9J5ZnYL7zdrzwvF-fINKEzehCbx2heg2>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5AD2422C009D; Wed, 28 Oct 2026 07:32:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A1Ji3gCVC1JJ
Date: Wed, 28 Oct 2026 12:32:30 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jasper Mayone" <me@jaspermayone.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>,
 "Harald Nordgren" <haraldnordgren@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <ad504925-cdda-4de6-8791-97a51a9d90a3@app.fastmail.com>
In-Reply-To: <20261024165311.57387-1-me@jaspermayone.com>
References: 
 <CAPig+cTZEcn_5TG0iMVJJym8Zhu1KYP+y9Oc1J=JJgDYSzNSdg@mail.gmail.com>
 <20261024165311.57387-1-me@jaspermayone.com>
Subject: Re: [PATCH v2] worktree list: add --branch to select worktrees by branch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Oct 24, 2026, at 18:53, Jasper Mayone wrote:
> There is no direct way to ask which worktree has a given branch
> checked out. "git worktree list --porcelain" prints the branch of
> every worktree, so a script has to parse the whole list and match the
> "branch" lines itself.

git-for-each-ref(1) (and git-branch(1) etc.) have `worktreepath`.

    git worktree add ../test-branch
    git worktree remove $(git for-each-ref \
        --format='%(worktreepath)' refs/heads/test-branch)
    git branch -d test-branch

It will not list the worktree path if that branch is being rebased.

>
> Teach "git worktree list" a "--branch=<branch>" option that lists
> only the worktrees that have <branch> checked out. It can be given
> more than once. A worktree that is rebasing or bisecting a branch
> counts as having it checked out, as it does for "git branch -d" and
> "git worktree add". <branch> is a branch name, or a full name under
> refs/heads/.
>
> This keeps the choice of branches in "git branch", which already has
> --merged, --contains, --points-at and patterns. For example, to list
> the worktrees whose branch is merged into origin/main:
>
>     git worktree list \
> 	$(git branch --format='--branch=%(refname)' --merged origin/main)
>
> The --format is needed because the default output of "git branch"
> marks the current branch with "*" and the branches checked out in
> other worktrees with "+". It uses the full name because
> %(refname:short) gives "heads/topic" when a tag is also called
> "topic".
>
> Each worktree's branch is found once and looked up in a set of the
> requested branches, so feeding it every branch of a large repository
> stays cheap.
>
> A detached worktree has no branch, so it is never listed.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jasper Mayone <me@jaspermayone.com>
> ---
>[snip]
