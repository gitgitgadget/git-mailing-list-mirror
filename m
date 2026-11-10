Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327079;
	b=Hv5ZqRIGM8DX+VMxMYuNQ3iR0UvGo+Mc5yhwCBd/6go1iTEOwyCiC4VfbWLiPDup+++r
	 ieblIM3r8SXSfPiyceVjgXIexGquTHFxGWJ1FRond6LsVD4h4tRAmhC/eVWMZcI7xzCWs
	 PFaFYGpDOXyn6Tsmu/0qTkKS8KdGK4x0mfPpBCuJiH8nhvEyRepVARkgCc84SVssdD/Io
	 aebQpqjZllSPfRq+r3bNc+ZPXTiIlAqCwf1uzXEUt4He+4J+MtEStVHOtY6sz/IiMgmi6
	 5gAp104u1eDDFPxNwaxV/MpT1PdCQj70ojlGVgTLkdWSMBgsVz7VHwLQYv7gXitRbEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327079;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=T+b8i2YqQ6f+lWIBdHSN67meS5dgRLZJXCh+Zk01xhU=;
	b=wxHh652JAYdvS5tiXkEGfqw5NHIQkiZDXKuyU7SpdEWgGhyyDvqcpDmeFwPImDWudk8B
	 zcLaCJHb9tHc8nM71cRizqYRXNNt6LDnUh8DF2F46h/1IEM58ZpuDxeIElCOIAecLmEEH
	 UIfJhbzoHRi1XQ2sSFf+ECIWlq1NfyT9UpiCKyxieAmvQfrEai5UPTQT0DSoLbyJPE1hk
	 nU7uU7v2lg2Gt8WVky6yaq2QiKmAZG8YWQfGIeefHqb9fBIhyM6KtopwkWyH+OUTOWyn3
	 YmbfZydtUbvMQCTbciVESa5g5JDtSsVDIJmiRmg97JBG7SJVOfnTDeDMHSxDFkXltqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZcRtLLtm;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4AI+RP06;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42616606D7BB
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42616606D7BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZcRtLLtm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4AI+RP06
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5AC817A0278
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:11:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 10 Nov 2026 11:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794327078; x=1794413478; bh=T+b8i2YqQ6
	f+lWIBdHSN67meS5dgRLZJXCh+Zk01xhU=; b=ZcRtLLtmpCfv5/SmzTN3ydFN/8
	E13RcWLW9E5DDaz1NDNyXg4ofNOFW2oKEdgZJXycKGZ5xhux9sT4zsPNy2q0u4aw
	IYQVeMHpVIX9vfLZwMEC75V0zhHAXVVngTIlKSU96N+3+nVds4IK/e28h2Wgamtl
	ATu1kusaknAR6H8rt/I7GGaoct9ZQy2goSVE78f6HTUvp9LVYd+Zs7nbV8fG81Q2
	Xi8kF8dTYSH2niewvD3Qclao1Gqf6C4anXIbcpiall9EJdQfaUN3Vntxx4aQj4kA
	mUwLYn7W5DcZ6aOx4iyWwhZOP4rJroqLzZuowbyrOkHmHH6IIyDzG5l+7f2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794327078; x=1794413478; bh=T+b8i2YqQ6f+lWIBdHSN67meS5dgRLZJXCh
	+Zk01xhU=; b=4AI+RP06hx9qfUV10xtk6Yt10Sq4KXMAzLkfAuQaxNAiOKFuFU/
	CjSUrTH1p+bKFj3OmLWBr+SJIlqQ9ODS1ahzIddnges4Dk8Ui+vSWycN8c9Qq9NB
	/LgkAZ+3UvW8fOARHc4Asquop6CdaOymU6p6D7Bvk/YpHMvasH5U+wtCD6xdycb1
	0lI6BzZmJYKM1kmXEFYwYLSvepu8Z3rkENCwFN7xlTxqhzVt9rVJKBnWumSikOd6
	87LWWVwZ1+q1eQa3H9mb8VpCdY9tvpO8aK/x4JGfnnAcuIW1F0ZfZ+7UCrD9+bZY
	46r+jqCUbGGO0Y1XxCdm1xu/YkAqNupOp6w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794327078; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Ry95WDkEmZ4xLqWwMJMW1HFm0d32aR+P/rl3me7npTBboKw
	DXrr5TSrZvlaCdQ+AbCoxOeWNVEEYy/e0KxvkXuBWDcj4cJiTKngDDUjFY1uMn12
	S6GSLany6cRtKX7xKOdX8xDWxbRgcocRB9rflPLyLQAgApRpIi5FEYe9oUOSqz6L
	R528iiImkSXRhqhS6f/2GNjSY4FcXPVo/gFJPrZB2VKhEgyNrKoB63We1DljsexU
	AvaZko76eUAk06a2uL/CJ2XstFXnXPbVPlMSxaZ2ncWSNLDv/eAYoRaZKcGtUitl
	bI1HZ5oCNBUBLBS9j8bWjklsAjkZl3XsSNS4LYw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Qj1b15U6bxmFEJ0g43YN+Jn8hf5v0GWYgZTqyhjUL84=:4IToc+gH5tlmj4K+wjAzjtQ1LNaxAV/JT9Tt6+Bb7X8=;
X-ME-Sender: <xms:JULzag5tLhiRs48-t5Vz_S40QBv_PE-tTa4gQaoZ-9Q4aZb0ZW4ALw>
    <xme:JULzaozp08nTtY6vlcwCXqpfLX9jaWp0Wra9TmdJklnjdZsr0z3N4uofw73NR3PdF
    a-Oyr9V1jsvpKn75olsx2Hhu5ICslhfPDqR83sv1hrn0587OiZFe8o>
X-ME-Received: <xmr:JULzanzLMKtV99rL8APRfdhQXb9QF7lYjGqsK-_SziajZef0TqKRWbX4aaDoY3xKzHgwfssjJYKdOJFF0uh0RNawZ-vIoc0rBrVH>
X-ME-Proxy-Cause: dmFkZTE3Du6ew5Jr6/QIJCWLKZxsgw1X/P4Q87i8wYiAxMrzHAS2dJcseJe6I9Kdb76SSc
    w7GmibHbQLuhxhymlAX87vle8dSTdjQjYbLQEjP/g1xhpK53HnjHD4Qk1nIv/LM2P0qZnu
    yhC3ZpMgiz3PhLwA7Ra8dQ8k0q4z8tenetGt7lD9zyrJkDOr41EwpzIcEz7idqT662jhVs
    IhuLmproftGXxF1jxECJspXo6EWI+BdAs3GlCJUBDPE3x4KSBL5+ZCKI/m1SHLbGnaq382
    kGiqxKYS3xPWGMMgj8SHI8GSm610WfLbzZSZgkBfBZvU9WLxF7V56kFUL3vsctOCTCEGKF
    AK22XJxjYNiRXTQv/L+EH3c6zTr4HBJ8wVb5WxZNPdkq4VFrqywvXDQZXtZuBuQYsR9XC5
    BKrUJ0A8x6vUshd5FFPy+/MelsIVEW1AwfD5IOPEVR9E8dhXCCTLkStwUaC92GZ8hQhagr
    uoO6DRMuN+TZBJAAPr5NkUb7gBZxlO7/MFJn2uKni5RZhm0mzvoP5lnMGy06IHE6LcHwwx
    EBRYK6S1dgpQqyrEd0cXZNlUbrR6zmzG5IL0UfFniGRJ8AQhmVasVcVAdAX/zfFQyDKzuZ
    muFCQMXDw+OL6NLbrzhyvCK5rDqaiX05ou+qjV3AfvSQLHvpCRpMGuJW1PoA
X-ME-Proxy: <xmx:JULzagw2iV73S_68xHl_mPc0h0NtWPZJOHx9dPz0yzWFLoMPpFPCjg>
    <xmx:JULzahaIIPdO7TVxuBk9dkSJ37jiHfqXll52typ7tf8dUMzzsgF_vA>
    <xmx:JULzahUPYv8JEpOZ2GZ7Ahr2hysiC8Z6pf4kAg3vr00Ci99GSJwuWw>
    <xmx:JULzaviR4kntmmFFuI1-qAqxMRUt8761BJTySW1DotrG2PTzAdw5mQ>
    <xmx:JkLzamEtNsfvN08n1ucJSNFc_JUw2JR3Mtlt5Vd8jhCESYhdIrxsOoBS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 11:11:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/7] gitlab-ci: speed up installation of Git for
 Windows SDK
In-Reply-To: <avK_Q_QDmdkl9r5s@pks.im> (Patrick Steinhardt's message of "Tue,
	10 Nov 2026 07:53:04 +0100")
References: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
	<20261109-pks-gitlab-ci-speedups-v2-1-508832602d0b@pks.im>
	<xmqq8q320wv2.fsf@gitster.g> <avK_Q_QDmdkl9r5s@pks.im>
Date: Tue, 10 Nov 2026 08:11:16 -0800
Message-ID: <xmqqwlqku0nv.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Nov 09, 2026 at 08:53:53AM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > +tar -xf git-sdk.zip -C $directory
>> 
>> Wow.  You learn new things every day.
>
> Yeah, it's fun. Windows uses bsdtar, which is in turn based on
> libarchive, and hence it also supports ZIP and 7zip files [1].
>
>> This is in ci/install-sdk.ps1 file.  Right now that script is
>> referred to only from .gitlab-ci.yml so as long as GitLab CI
>> environment has tar that works this way we would be fine, but I
>> thought that ci/* was designed to be portable across CI and other
>> environments.  At least we would want a comment next to it that says
>> we assume BSD derived tar that can grok zip archives here, probably?
>
> Well, bsdtar is nowadays distributed with Windows by default, so this
> should be portable to other CI environments, too. So I don't think it
> really warrants a comment as it should just work everwhere. That's
> certainly something to point out in the commit message though.

Yeah, this installer is about Windows, so any current or future CI
that uses this script would end up running BSD tar, which means we
can assume readers know what the script is doing and why it works.

> But now that we have found a way to remove the slowness we could unify
> both systems again. I intentionally left that out of this patch series
> though, as we can still do that as a subsequent step if we want to. In
> any case, I want Johannes' opinion on this topic before doing such a
> change.

Yes, indeed.  Thanks for these patches.
