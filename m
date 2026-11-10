Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293211;
	b=0DGtszB94Kv6sqgE0VC0NP6BohIG4G2Mtc0Q2qYmMe4UTLmsOjf3YyzetGn6aR4ZiA3b
	 sJaTc/+5AARhZ/IBdt0mbeigr1Kl3IGr9kKD5a4OBd5JYUqzpBd8Vz6/IB4qAoO14QFD3
	 rqYph0RfnMs7NkEjuAVG/qNqNDz6mhgnVyXLXYdErY5uZ7ypgRVNfmnRr8HJPi45C0cZe
	 DD4Mwhj2fCP4SqdJWA1trZJbX1ZFP5kTi7XOyNGQyeAVFTYVTXCQUXKRk3FX8ehkxK8ot
	 Cke7+cOu9TXFvuDYAYeMgM36726JEQozf0QKF+bntDFxaTCzW6Og+TgTq14cGN9Au7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293211;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=B++Xs0mnPwPFErNOh/xuCgtCbddsSgBGpNGYg4/tkk0=;
	b=hnAjCe5dHQ/Y71jJt2cHcYZqp1WHIIgxCR4EwK1l9ps7qwKqvUeXux9tb+vPEyFZBg7I
	 hyvs9LLg/tuMICdwm2MXrlFL0fbbcBkSPiDTARpJopY+uOEOX8y3A4URUOOahLBYwSSBY
	 xYeCPWGmdRUyQzC6xMO4EmtOUy/2LuQxIGeTPRm8y4w5w2JhNKbzQ0h2cLi4d39U0c06C
	 GAhqBkpq7v+9HFGmmGSbFTrOHqtRFTr6i6pRV4s5YqdB64ONQQ3CaiWMfY8ySsKoFp5Hs
	 VnpcXOmHBmSu+BforMF4V/XrAwyj8bBBO2v7xTAjzomj/HtAWjqvRniYQT9OM2YZevA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hT+SPtJf;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JJ6cpGCL;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4BA606A32A
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 06:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF4BA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hT+SPtJf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JJ6cpGCL
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 607501D0010D
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 01:46:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 10 Nov 2026 01:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794293209; x=1794379609; bh=B++Xs0mnPw
	PFErNOh/xuCgtCbddsSgBGpNGYg4/tkk0=; b=hT+SPtJffNYLl8ewsdq1WevPtm
	iZzBbN0S6Kmj/6If58vIzUJsaZ/rQrWTwWAHvY0sU6JirJlXekEWcfAWmNbe9M5E
	axyuPN0XOGh2QOw4ek0hNK1e8NAikXTJnKDElwm4JxArzCO3JPP4DLkakK8gzQFt
	NdwIeBIiXymm37tWuQXKjH5HcapbWXuiEbyIr19d22W+AznIvajZ+a3Zcz67Aln+
	YTwtWDSy0fB7MFt/vUViC+HOA29kUfH6EdD1gxiJc2tA0jSN3CJv3HM/P8t39qHi
	kjoBH+S+N/FedEOOZk7qFoocOHTAXE5MazXoJcHNWLB9npHMtHaHr+1nGglQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794293209; x=1794379609; bh=B++Xs0mnPwPFErNOh/xuCgtCbddsSgBGpNG
	Yg4/tkk0=; b=JJ6cpGCLVuwWLcskj3+cZHPoARUbT1iG6JeAAgikYvU1rO4f//N
	caBmsKZOs2rS0zZlBR0yPq5/eDroOAocmEn5AfnQq1q0N6DJLhe9lC/SVQ3S8gH3
	Hd9s7LSw6lNHzmO7Gsb6N1c3x7rnwzRtBsq8hgCP2OClmdxwS8iYYHZuWYvq3jJQ
	BluGO5taKcE0N2PCufpqvnUbUAa9EyUTXcuQ8c3vrrE7eKo2Ppu0pyN2ZlT2/QmS
	8W26yHMcgrDeAS0NPV8i2Z6aTaqMla92sqgMxToO5wXBohhpTWCgFsv7k5EISRRn
	m4SpUyr0uHFPlVNMZgSYnQVOPgEqdxgBfBg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794293209; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RTt9Ab/F9NPrkrFlQzNQJxponHoefIhnRmi6O3Co7sc6evs
	yhixMlqKFYq2JcTKivkgJnbD1MaqTpxnSIUFeKIM49UjfwDfgiDEP7DxGfIRMleH
	u4bnxAHnJF24GuN/sPwmfPjIHL/pFYM8qO7xWUIK0sqzw7F0slg11jrsoS1pGEcl
	Huy6Mbv7b0E1oRhG5811fH+y7PqXzfJwc4WsroxshPIssXCYgjWISYhYG6GdYwBq
	NqeFZGP0gl88u+J2X1b3dVuzb8mJcdQyq3o6lOQplSLAduwwVvuXh6VsxvMTBCNf
	/pX1JsAnp9WwWH2WCfcHJ74oeKBZm+QOmFqboeg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:BItSZYXPLbfR8AuioUA/qgasGfTwSOdnAoqYrShQ67M=:OFCnDxnMpShAiIV5ZuG3oYsl4dQxp6gL1b7yJrbCons=;
X-ME-Sender: <xms:2b3yahcAfQCg9x_13EI9tgeffWtpIjjDB5ukKTmbk3aeVM4ku2IVEg>
    <xme:2b3yai718oGUNbiM32xkYyK3hdPd8y40vUZWz8dj1OdGomkr4VKu_KLkf3CLnLmHA
    NdtBp3F2Tn5ULpBJGw6JRh-ff-eysUDwZ8vT9pqcbaPpwr0AtE09A>
X-ME-Received: <xmr:2b3yakUT5c8R9r1EgE8cDgg4uNpzZKVqtFDelO8SNWAACKUEcvc6tBeNUqxaXMoFufHom8MFn-gsbm1AE1lM86hRE_RxBwrg_d8J>
X-ME-Proxy-Cause: dmFkZTGw6ax9qWVfIZLHRfUiqFSmebVx9PS/K9esHYAtsxr3ikgtSUoN0uZJ6cLRUniivG
    HgCYQ6VvSbLkIePelxJ/+4KvACOJR2+RJmOAtGYIzNXnSUj/AkiicSXWP4vHQtnkYBKMNB
    lwd4vcbc7TuQrDj+P1OiyZJ2mbRAHro0BAdVptbbC8VlMBpLT2xFixYs3kiVF+EMHlAx2o
    yBF7+tc/1f/6sbxc4DIDLH1XVhWiQQf5bZOP1Hl9Ap0SlJ5ApOnB1mQjvb52OvR+h/F7pJ
    vk3rf9+CFUFs2YbZNIj5UowyZ/ZqaJcexmEuHDyvCsJCxSYeVXSwYmXfUa4dwZgV3tIWcb
    Pm0cHcMmbQO9k/4sRRB+zYwtQpBQGkI4VFpB5I5rm75B/aBeGMovuQ8ABTZHsx+Kq9WVZF
    P8Rvsy+pjn+wWfXokPGFHKBDyy/ax9/C02nZBe9MJr1EODD7sVf4cnMg19g9Fue+HaC7yN
    pmOoTRX05z+IIsMfvJgIGT8uRTeCzpUhMrIDeJOS2zseR1dng1S3yk2soxp+xZ4Y7TJm4I
    vmCSrXvezC8bdDMpfw4edc6e+LrG0YjT8tcS+e4kGd2vMMVieWI25Z5X2qX3/C9/X8IQJ2
    YKeNDKS73322/igZeqrHlOXrkQprJtWQ5BcIXztHFTomJLThMtA6boPwfBNw
X-ME-Proxy: <xmx:2b3yah6iYtELceO9UylF6W7sTXM7Gd3R3J5fA6m_dKj1sU05YN18qQ>
    <xmx:2b3yavrJw6KDbM0yex_vIhYeX2izl5PdHWz131z8T4Ptd3drwAsFxw>
    <xmx:2b3yakm6e8KFu84cs3XMBtvqm-ZN7SjGci4MlVBi_KF5ZCJoPmKe-g>
    <xmx:2b3yarNdYA87if6AIPtX6sk7eAssbJLSACkJHp75qK8xBLuN7qksAw>
    <xmx:2b3yaqDqNUyu4V6w6LfuPzUbrZjhnnVEtHc8vwi9nC-N_41oGqesZgE1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 01:46:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <f7d4600b-909f-4dd7-94da-d525649a9546@app.fastmail.com> (Julia
	Evans's message of "Mon, 09 Nov 2026 16:48:36 -0500")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
	<xmqqh5ile4h4.fsf@gitster.g>
	<CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
	<xmqq7bio6jb4.fsf@gitster.g>
	<f7d4600b-909f-4dd7-94da-d525649a9546@app.fastmail.com>
Date: Mon, 09 Nov 2026 22:46:48 -0800
Message-ID: <xmqqfqx9uqsn.fsf@gitster.g>
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

"Julia Evans" <julia@jvns.ca> writes:

> On Sat, Nov 7, 2026, at 11:25 PM, Junio C Hamano wrote:
>> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>>
>>> +`HEAD` is where Git stores your current branch or commit. `HEAD` can either be:
>>> +
>>> +1. A branch, which is your current branch.
>>> +2. A commit ID, when you don't have a current branch.
>>> +   This is called "detached HEAD state".
> ...
> Saying "it's a commit ID" is a simple way to say that it directly refers
> to a commit in a small number of words. I'm not sure what your goal is
> here, do you think that statement is somehow misleading to users?

Yes, I find it highly misleading, and otherwise I wouldn't be
discussing this patch.

I think the part I find it problematic the most in

    HEAD is a branch vs HEAD is a commit ID

is that HEAD *IS NOT* either of these things.  HEAD may record one
of these kinds of things but it never is a branch or an commit
object name.

And HEAD records one of these kinds of things to either directly or
indirectly refer to a commit that is currently checked out.

That is why I want to see the first description of the above to
serve as a solid base to convey these points, with later
descriptions we build on top:

 * `HEAD` can record either (1) a branch, or (2) a commit object
    name.

 * The purpose of HEAD doing so is to refer to a commit that is
   currently checked out, either directly or indirectly.

 * The latter (i.e., the direct reference) may be unfamiliar to
   users.  It is called "detached HEAD" state.

 * The commit referred to by the HEAD will become the parent of the
   commit you create.  When your HEAD records a branch, its tip is
   advanced.  Otherwise no branch is affected.  Either case, HEAD
   now refers to the commit you newly created.

And I find that saying "HEAD is a branch" or "HEAD is a commit" is
misleading and does not help that goal.

HTH.
