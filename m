Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903046;
	b=UY2mA0k4MGxc6r9WZ9qaoOUNGHuAvhHpknMFqV8Np/FOebyOgsNxIMR0UnV9uJt96DvU
	 TU3dPfiNSmL+rnIYIBvyG7FUjkO6IbGQYp/EWvOsTpKcW8Xga+4HqJSFrRhR2iSA8Edkj
	 xQuSOZB32WDlCE0cnq2hJhXJh8E9WNLvWOyDdE9MlP25L0V87SHMyI8z/rqSwI0OpKuSf
	 Mg9aQubkfUQpMaO9120Y2Wn1tZqrMbGL13NcvXMLiuC0dVsG+SNdo2CwxIte14r7QxYJt
	 bvF08u9MtKnMixs3g/G4cVBj8w4IW6eOTr97ZpBAPI3ir8qHVDnfSurldaAmllRcBBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903046;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=XPrpzR4e9wyjExaWjWzuPChqiQw1vIFOVEAZhOEe/J4=;
	b=pyES4uiOnihtf84vRUIJb+cGhwNUBSeT68lO0cFTrgH2RcnwTd19Gs+TmBOrEHuT2ZqR
	 Op0vOwxNzSpQbcKLVnpYfBw2IK4ISs0xiUm6fMafwrHNQOJ8BG7h3dlEeMjjnYYdGjbZ8
	 YLfClU7IUlul8hnWkfrcBP4g9LYboHFL7Dqa7mIz1ABzgfCqbk6NwEh6aEpw7/3mCdace
	 bhYlJH4dlHL8tZejlLsjvIKRANkR2Y4h7mwydocy9a4bF5lYCbPPWgHNfk12MvH/KXUGa
	 Ijz9AHxH180D83pzZ5aNPf8khAQboqJv0I264QC6Xme1oXFgav/GzXWE8oUhXcCso9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=b+9jCAvT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QJtRwZRB;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47578606A32F
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 18:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47578606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=b+9jCAvT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QJtRwZRB
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E0A0EC0202
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 13:24:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 05 Nov 2026 13:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793903045; x=1793989445; bh=XPrpzR4e9w
	yjExaWjWzuPChqiQw1vIFOVEAZhOEe/J4=; b=b+9jCAvTRYwaqVJDkPfL2wvgCQ
	jwBQCy+zUTx9x2XEWkb3pW+h4qWMh5EKOVeBOwQrzv/oo+YlkSLQisYtCjJDx118
	MPOcln6DQICxnqAyHBLu3depsSDeAdAzM6Mw7AARFYTzW9FTmdywONJFrSqGkYJv
	WeQLUQjK9sGz9HMMeMrbdJET5LP7vxhAJPai6nfzhB9jqxT9Q5lYAHTkSIDNK6gO
	TXxmXjCiiO0Zb7k0ppX1+lzB4Ycz9tgfQBe/ZdqOzlRyxTFyHKQk8IhmP195AvL/
	bLhFojc2HRIjSRlxcx0WKpv/7gQ23rcl579HZ8ZZmCh20gI2c1RS4aBr01ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793903045; x=1793989445; bh=XPrpzR4e9wyjExaWjWzuPChqiQw1vIFOVEA
	ZhOEe/J4=; b=QJtRwZRBe44rTXWlQMo9TFeMSr1WXT4jj5Ka8D+zpdlZNz/BRRF
	76hyStLC8aWRfDYm1/a3X/8Z+JOyY0uw1EvQvOEgwAViL8gKgID8up3+O//g1t6W
	7tXvUOu4yEuLOJS44+nx/DDwMouA7sA+RgigJ2+PeEG3QAD3aA4pOREtEUjigNFD
	K7EAqvDWbyfbvVj3KzfuEq7fa0s/071h89sTj8uZ639Nqy9+ObhelQvd72cMYl0g
	xGXhPXkuyZv+Njk9iQtnOnVT/PyKGt8MkLMLsHwQNp6xWUZjuKO7uD0ci0BvCit9
	6eBKSLPEkE1jQrCryTRuJrLc3ZbtG3MFd9Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793903045; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kZc5ZTa4SHHsUFpZrL39YBpfxbJNN7ByUXa1wZ/KuuzXdmk
	iB17+1g+hI6mq6XtSPmL37kCBux57LmGrrDb0dwN8PETFwwJlX3Ysw73QzWy8JY5
	8uIuaXa4Pz5VAfZiQiU5vFiX2+5TOqpo1crfNItlajuUL1pAnqyOcepBtS670NY5
	Eovw4oUXeG8p4I5JwMpSVbU5sqW1mWm4jxJKGvSMHDxECHbguMOIRLciEnX7T4vt
	REgOOZ2iy2MLBOrLuIvPmNsgAGjpdifYOAjme/Ff/XBcq9YIPgrll/xfdBSJ2KDP
	ewIxnRUTJkNss7LLF7bsPQ89DiIj14DSIFMCJYg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jvaS+vbD05Gp80D/coqcRW8Uc9AIAUgWuzUEExdUtZ0=:2M5Yrq+4fVw2+7SQ3GiOLPvCwbvYkxdjC+TLY5AA994=;
X-ME-Sender: <xms:xcnsao9hcSGAj9HyooyX3EeGUv1s_h1Ytd3WZ5BOIfykgYYTEuBq4A>
    <xme:xcnsannq7Sf2TIJsaaowr6_mDJwDZBYNliNUfasBMsoDm50jSmIYbDkCvwaCdHG5C
    pW0x9qyk2YLDbqdzupwVOKmKIahrmvw0llh6Ko11GlzCa9uJiTIJg>
X-ME-Received: <xmr:xcnsamUelHkEw844PqyMTT7xFjxEGm2sGFY6vD350d5RbNol9NaXSrQiTJoLNX20O1YuB5Xa5GHDkHnsVUIsMBHzsld_xD_wDGmz>
X-ME-Proxy-Cause: dmFkZTGOXhElmp+tY+7btIDwi/d/AnFcWJ+gm19gd8yBB8SHL+TGiDILY5cMPy8JXPX9bE
    WIDudIHrghEJbFlODZGOV0bxic4oZsdqnhCCLjAszSREDdb5snbSl/0ponLzFQFZ4omWIX
    XBuVmPO/HjdNbe4udF9PBU91cq3OEUNV02MQZT+lisGtTPKhdloehXzFA8vzHVCq8Zao2O
    eonA1RD3kcFZx0TpmQWhZwaVGztRp15RaofjUVQG87bute4mArUcRa+FFzUY0qdTB1xW/O
    hgfW7cOLlKIVJA8+u8q6nx+GoJk6c8ThaqBCEHFtmmETtuGALDzAWN1t3OUiGU6kUHVHZq
    zhuTzcLLdzWkH7bH98c6JN6taIVOgCt7DCRJgFjCZPrpO7YjuimlIjvd187r9eXKkncaxA
    uB1tFOhlfFOQheLfdIyEqjcymEdw0Bqz4JTlumF3cHqiWI7ZFcyv/RsRM9NR+05nyQGPZN
    JafdghMdz2B+whZ1dnq7GH86w3jrWshYr5VBWhc60NBQzOkTyo0IA/BJsaqGKj6hN4L7Uw
    iZUuq4xhJIkjZmDB/Z5wpJebE3WSZlvmF865itrNb/hKSDJtU8doF1v1KvfdnydB+ICKHb
    U6QdgAyMSfTFfOfbjeH2s5u1L7IdNbQl8rb5JWEuPueYoEKxofCfjDV4DbyA
X-ME-Proxy: <xmx:xcnsakHZHPhh2OwDJUo3A5guXtfJK80S89AgQGk1n2AvA953HiqZgQ>
    <xmx:xcnsaqejemq8WgOt-VU1yMUC-wUrSuNe_-5nXUm6KYB7yKZ_70Stzw>
    <xmx:xcnsatIRMDl7PMUL7dPIY98gvAS35AqZzqz6gCW-yZQ5OPi4Cyv5fw>
    <xmx:xcnsanGKS2mvNjk6AhIr2qTTJEJcHZblDPPflUUNyqNWIXBg_XGHZw>
    <xmx:xcnsarX2baIGAucUbHQEQJa3K6S6c1ahlz43xWc4eHWl79FDOrbZFdOt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 13:24:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Ilia via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  Ilia <ki.stfu@gmail.com>
Subject: Re: [PATCH] fsmonitor: check the untracked cache after a trivial
 response
In-Reply-To: <c724ab00-dfb8-4e81-8bd7-89702bea51b4@gmail.com> (Derrick
	Stolee's message of "Thu, 5 Nov 2026 10:01:52 -0500")
References: <pull.2247.git.1791127155614.gitgitgadget@gmail.com>
	<c724ab00-dfb8-4e81-8bd7-89702bea51b4@gmail.com>
Date: Thu, 05 Nov 2026 10:24:03 -0800
Message-ID: <xmqqld77uofw.fsf@gitster.g>
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

Derrick Stolee <stolee@gmail.com> writes:

>> +	for (i = 0; i < ucd->dirs_nr; i++) {
>> +		/* not written to the index, see write_one_dir() */
>> +		if (!ucd->dirs[i]->recurse)
>> +			continue;
>> +		strbuf_addch(path, '/');
>> +		strbuf_addstr(path, ucd->dirs[i]->name);
>> +		nr_invalidated += invalidate_stale_dirs(uc, ucd->dirs[i],
>> +							istate, path);
>
> I'm conditioned to worry about recursive calls without depth limits, but
> I suppose that we are limited by the untracked cache data structure itself,
> which was presumably created recursively without hitting stack limits.
>
> We could make this iterative using a stack-based data structure, but that
> would be more complicated than this is worth, probably. These are not used
> in server environments and the .git/index file shouldn't be considered
> "unsafe" or else we have bigger safety problems.

Good reasoning.  Thanks for spelling it out.

>> +	/*
>> +	 * The index is also read and written by commands that do not
>> +	 * run in the top-level directory of the worktree.
>> +	 */
>> +	worktree = repo_get_work_tree(istate->repo);
>> +	if (!worktree)
>> +		return 0;
>
> I wonder if this is the right response if we fail to get a worktree. Maybe
> we should invalidate the entire untracked cache in this case, along with a
> warning that we couldn't evaluate the worktree? Or should we return -1 to
> signal an error?

It probably is safer to invalidate and continue.  If there is truly
not a worktree, untracked cache entries do not matter ;-)

Thanks for a review.
