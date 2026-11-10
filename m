Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316439;
	b=sSPDF1KwC/qdAreGgoEsffgVf+DLxik2It/7FflMbsSYT3MdrerRTftX+KpTlmzwI8MH
	 9Wj0V2uSIuoj+76S/hYatFQi0XsCjuEGQhvy+BGwdMRKirTkODvsnGyzZuPAINqBsxFTq
	 SQHEyUESdzUC7aVtb0NWQZ9Ubw/PuHVS0KBPYp/fQprnAJtHA+40TpXYHgtdR0DIy41vM
	 5cwVcEDYy4EUUFhZUqWrN+ZRqTfD+guEPb/DX49aBDHDF2wqVPft20aXIB4X9KhMFH4Yc
	 oE5As/QTEH2NTHYziSG8STltTV/UB4yAWamGdExN8VvBHKBgr7hWeQiP8oHquk1xhzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316439;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=Gk7lrI07ErZLZfsig4dPHMhP5wwhEUuDeT5lPPcc0fs=;
	b=XmnYNWQC+vcuQ1lOJA9Zgmh/0BvrTQByotnxJ8myZu8sx6MIoKWOzG3LfJVLW7zkCl/c
	 FwgJZ8OuimtuVX/Obcx0JqQEJEZRjtbX17vmu+8Bqd6Aa/03m3p4HaR4x/qE6nKUW3S9w
	 w18aXdgOiC5dSbv8qySJweJtMdJM5Ur/HDdT4GKTwO8dq67ihKot6dpA9RwO47qxRtPzs
	 iopjjN2FRamI7Uk3IF0ehZJ6/MsCZlHWY977osJcXdgWBxQ9Gx5Sznv4WDB1F25FLmESX
	 buQBcj1smSXfTMY2p37f2ScuXn85RjpT12FvUze+uNYleghWzj3Jv2bNWCXi9d2NvSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=vCnwMK9I;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sEErZqT3;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F6D606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 13:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3F6D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=vCnwMK9I;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sEErZqT3
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 18E697A002C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 08:13:58 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 10 Nov 2026 08:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794316437;
	 x=1794402837; bh=Gk7lrI07ErZLZfsig4dPHMhP5wwhEUuDeT5lPPcc0fs=; b=
	vCnwMK9IUoXtTiTaSq3YaD5UAnF8thW45q8aCqdob5UvBXDYcl8fH9ze+77gMoU+
	xJ5ylBNwItEeU3GD6F1XNEAxrbtit7VgqF7KzTNE6nABnw+2pwhX2QDzdbEe2Axg
	avy9dVrPbYtTkgOr8ZYxhB4YcvpNl4KITzUxYzuIQys6eKFt2+ehngCyuYgSrr8s
	Iy/4FWc38KmIaMJzBHTd98Q1Xscby1gBbLz1f6drfAhC7VifuO715VKUkzLqsWl5
	hLQqhN25hgeaZiQ9BCt+iWRP08eB/z5koLqe0eBZudsl+knBBpnwg0UzEKr8z6kW
	LomoE3TEEqGIsq3LjZPv9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794316437; x=
	1794402837; bh=Gk7lrI07ErZLZfsig4dPHMhP5wwhEUuDeT5lPPcc0fs=; b=s
	EErZqT3CiBiS32SEGz7U1lHK7/S83rIsu6CtZOnHO3QzOUUEfaiKOzLQRFFmjt3h
	sGRINnes0TwJPGZml4zDXWJWJOViX0Wur69znqHcjmnwnK5o11AmQqyLT/RFkRmW
	Ts0GNk5GOOM3qHnl4yQb5mJp+g6Up0lwS3ICPWOVJvnFqF1ovar4hxx9VPwBTH8P
	ZYTZIF1GZwUfzTOdyCrzTmDC8XpZIuuNlRTee32Smb5c6vMtVdSlr5Wv3uYhv5eu
	1arn3BXqcUY/OMP7+qHdZAwHMxOFA9hA/g/PWs0QSciMDKIcLsd49z41CURnoOZD
	FmroTVnAkvbez8NaF1HVA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794316437; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:scMnDFcXbvLuY4Spi0LJAOzW6qfuZv2jDIWXGm66+uJc7Eo
	PEXdV2yHSM3m9tcTFnEuZ6N0NeXUvCxpELeAcia6seVWEgmBan90VtLlYIPFtzEd
	U/8ZfXBRklfottf+SRv/+Zw3hmc6r0yeoxVsCHzLERkU7y61te3bgWEYFOQsQpTM
	LmEmQwsmvlvOgDMFBYW60bgkebe3hmjCegXNrVJBiCs5poTkGefSza+nxqvdQNqm
	OSe12utS0dQ53ObI2annKRCQsiap7WGcd8dNiLz1yxGwjmZqLejxIi4k0dUhv3KB
	qAJabBPLUvhlyizYdsXpMMKO7rKSZNnaXSYdTug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:eWK25NfcriKJ086c60L/xCCndoD3LXjHRwRsVpe4CX8=:RDTxCZrCDqjpCSQ2N24Uh9BrHApDlbMnnH9Bc4j74w0=;
X-ME-Sender: <xms:lRjzasPfxPrkX_R5ENBl2ynH7WptQtqLj-pRd8oWsXrNmvmXRp1w1Q>
    <xme:lRjzatxLL-TsyduwhLntYIe7PFE7Zzu-rn3cm04ZLSDkvgVJT-V2DWOhwioDVGi57
    awV6UI0CXVMIP3QFo2nTEw0pyFoBwUcbn6-SkQiY8VqmGNZ_YAUlr5K>
X-ME-Proxy-Cause: dmFkZTF7wFK9cgnXvlee39ho6deCFs09hdy8H3Fwq98221ihlwuqlgPdDzXgh1aJeH6hd8
    e+MDriHMypTNVtt8MaMgSNfRgsL4gdL48TteeX03NEweZ6sfk/cdxJIhXDC/8XiBbkA5ZK
    RuEty2twACizIp5EFT0edUA6pJJsI7xYpu0DBJR2acWmCsCeb/WnXZ7pPVGF+Ot7Y7+x0h
    fk7IE/4wJD/jO4eXMAZfk3tzVqNd/+QEY2AM3lr6j8ayfzU7e116hD1/f6bzVfyn9Qshg/
    A+8dqBUtlAOgvRZJ7SgcACQqB117iMBSVug6L8Y2nbhK+RXNVAErLPPdVm4fiu5CklMkjc
    ZL7je7mzz96l/2ohrGPP5INP3JZLLPsMXr14pAiURqRP/HZPctFkuevlWyt/QnYYE2wCzL
    DsR61Dj7mqtlxlyUO1pBOJj00mPR7LnXYmKREH5KARF2QMQ6GHvsbtm6zQlLGBWsKRtD+k
    nnsVeOiy0zLpOrcXXGM8uo/6OUQgbUhbDXJ3D+3ChFA5t3kib/gBRW7p8obwxtA6+DqwwZ
    LIE+dF3sgTqNqoi1kHqUJJAGRLch5mWgJ4FQtRPuLmn82GZ78mzKLJT3warIcwkrmXADYo
    qHGBF1v8ccCG3efcFkn8SuSs/78+UEhPj1bxZoDiEiYhA/iN+bLFfIlC68gw
X-ME-Proxy: <xmx:lRjzasz68mPcipKSyyq-68uZYSMFx8pg1t7Mzvb6NjRQntSHVQrrwg>
    <xmx:lRjzahw7eX2WX0_NLkA17EXWkP62Ko9r8Aq-SJW9I20cnSmzYsQDag>
    <xmx:lRjzauYPn1IfLxfHOt4s6JVD4iDiF5GHG0nhMw4TM1CULwjMJ8ATdg>
    <xmx:lRjzaqXCBjZJnjQ6LlTZYKZYVzkt6mvme3xyJURKE5U7kcQKIP1XVw>
    <xmx:lRjzalFTgkROp2thM48nxymRsqO2ewXOLG--4X6YBz8TMq3i5nmi4uZh>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 09A67780070; Tue, 10 Nov 2026 08:13:57 -0500 (EST)
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
X-ThreadId: A1sfaQj8oK1o
Date: Tue, 10 Nov 2026 08:13:35 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <ce9fcde0-2181-4773-9133-f39ea1ebf7bf@app.fastmail.com>
In-Reply-To: <xmqqfqx9uqsn.fsf@gitster.g>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
 <xmqqh5ile4h4.fsf@gitster.g>
 <CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
 <xmqq7bio6jb4.fsf@gitster.g>
 <f7d4600b-909f-4dd7-94da-d525649a9546@app.fastmail.com>
 <xmqqfqx9uqsn.fsf@gitster.g>
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I'm going to reply to this email a bit out of order because I want to say
this is a great list first:

> That is why I want to see the first description of the above to
> serve as a solid base to convey these points, with later
> descriptions we build on top:

>  * `HEAD` can record either (1) a branch, or (2) a commit object
>     name.
>
>  * The purpose of HEAD doing so is to refer to a commit that is
>    currently checked out, either directly or indirectly.
>
>  * The latter (i.e., the direct reference) may be unfamiliar to
>    users.  It is called "detached HEAD" state.
>
>  * The commit referred to by the HEAD will become the parent of the
>    commit you create.  When your HEAD records a branch, its tip is
>    advanced.  Otherwise no branch is affected.  Either case, HEAD
>    now refers to the commit you newly created.

I'm not sure if we need to communicate the last point here, but
definitely the goal is to communicate the first 3 points.

> ... And HEAD records one of these kinds of things to either directly or
> indirectly refer to a commit that is currently checked out.

now back to the beginning:

> And I find that saying "HEAD is a branch" or "HEAD is a commit" is
> misleading and does not help that goal.

>> Saying "it's a commit ID" is a simple way to say that it directly refers
>> to a commit in a small number of words. I'm not sure what your goal is
>> here, do you think that statement is somehow misleading to users?
>
> Yes, I find it highly misleading, and otherwise I wouldn't be
> discussing this patch.
>
> I think the part I find it problematic the most in
>
>     HEAD is a branch vs HEAD is a commit ID
> is that HEAD *IS NOT* either of these things. 

The all caps "IS NOT" doesn't help me understand why it's misleading
but it does tell me you feel strongly about this so I assume it's important :)
It might help to give an example of something a user might believe about
HEAD that is not true as a result of reading this.
I'll try a different suggestion and see if that helps though.

Often I approach this issue by talking about Git's implementation directly,
like ".git/HEAD is a file that can contain either a branch name or commit ID".
Usually I think it's not good to talk about the implementation that way,
but I think HEAD might be an exception because in practice I've found that
users find the explanation of the implementation helpful.

Here's a version which handles the issue by talking about `.git/HEAD`.

  In Git, you can always use `HEAD` to refer to the commit you have
  checked out. But HEAD is also where Git stores the name of your current
  branch. Internally, `.git/HEAD` is a file that contains either:
  
  1. A branch name, which is your current branch.
     The commit you have checked out is the latest commit on that branch.
  2. A commit ID, when you don't have a current branch.
     This is called "detached HEAD state".
  
  It can sometimes be useful for `HEAD` to refer to a commit directly
  because it lets you easily check out an old version of your project.
  ...

But talking about the implementation in this way isn't a good idea (even though
it might have been okay 10 years ago) because immediately as soon as we make the
reftable backend the default, users will try to look at `.git/HEAD` and it won't
be there, which will cause confusion.

We could talk about `git symbolic-ref HEAD` but that introduces a whole
other can of worms of "what is a symbolic ref" and I don't know is helpful.

> HEAD may record one
> of these kinds of things but it never is a branch or an commit
> object name.

What does the verb "record" mean to you? I've seen you and other folks in the
Git project use a lot but I've never totally understood what it's intended to
mean. I haven't seen it used in this way outside of the Git project.

Like I said before in this thread, it's important to use verbs that
users themselves might use to describe a concept (references, points to, etc).
Does "records" mean the same thing as "references" or "points to" from your
perspective? My guess is no, because "references" and "points to" can also refer
to indirect references, and I think "records" may mean something more specific.
Maybe it means something like "there's an abstract key-value store in Git where
the key is 'HEAD' and the value is a branch name or commit ID"?

"Records" is not a good word to use to communicate with users about
this topic because the meaning of the verb won't be understood.
