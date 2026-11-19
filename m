Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092654;
	b=wgo0fBDxJlmXQIg4h4teoOUU/426jo5SsyBzwuiEqozww4KJ5xTWXramRaDZxvqr6Sqk
	 kEhTuhKAAyTb0VgU6/k/UGAPcBmKnJV7xMwYySx7ABwqDhlGZmXSSAAinr8EH2iB4gBgz
	 92Fj5wUrvOLw2hDfk+TIbS88qZ5O1M+s6PYzxx/oIyzzxF2ipq/tC1eWCT88RJmA00qKv
	 uZOdwi1oaTLCcT/gumgihDvCvi1ZHngT7BrSWO1KqoFfbxlueoYx9D8263vNezNo0jkgJ
	 g2DFDF4L/MpIxSBx5tK8oI1RpQCLAq3Osmp7zpgu5M+BAKmYTDb0rgD+Sc6ruGmrQrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092654;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=c9d+3Ti4RoB1Z1Zyrzpsk/mEzCulqxk4zxU0OSQZJEU=;
	b=FN2hqmQFRWd6GdQwrU3u5TfL1ght4e7tqjzheN0sssopvXrVtzY2bFNYUoPL0MpRWTpJ
	 y4GoywDwhQPKsPJhVFIJLDrCrsj0OZbSDFNT8xbJ2WCG6Ehxl9UUuZCy1o978Y6ZO98XO
	 hVfMj6kdSX6lZ2CFp/34B5lt4aB57/2N8DV51oPv3E60l3/7K8/Z0T6xVoXUe0yiDP7Y5
	 MbUo2DORuSQEgFoCZCf6p1s+sDlJECYGmEU4PA+jLV/cGKcjbLbyK/bwamAkqVlsUVTEW
	 NpzdSqx51XrflcfLZwe4joISCMNhn5Jgs+nbC7JsfH0cUVtdtlrVmt1QJiS7/SioxPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=I9kLzJff;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ku2xl0Z5;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C36606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 12:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C36606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=I9kLzJff;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ku2xl0Z5
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0983DEC090B
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 07:50:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 07:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795092653; x=1795179053; bh=c9d+3Ti4Ro
	B1Z1Zyrzpsk/mEzCulqxk4zxU0OSQZJEU=; b=I9kLzJffOmuqD2pY3GE/gJhX+D
	yDeOmF9Pap5obF80wgrQZ6lsK1OxXmV6yNocHmn+gEyvll5pOFUgMP4FrNZOeLw2
	WNFefzYFBJjaHhK89AKlFyqzGZz2bfdGQhpHMD/7UYa+6HZ8uzk6vp8TzTZ8EjpT
	2gtx3FSD8jHFg6/Oe3vuxnIaHu4mpVEaw7ubRf3f/A2HbdLMsxVs3hdbogMNyYHk
	Yxcu4r5InOwwBbNponD7w7ftFgNw2SE9wpi5T2w930cHJiwWU0bGjgPgioQtYLLQ
	DSs3xn2CVxEGWyqeWiajoWn8lCfaZh08VF7Iw684h7aTonE3sBhlaRC7P54A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795092653; x=1795179053; bh=c9d+3Ti4RoB1Z1Zyrzpsk/mEzCulqxk4zxU
	0OSQZJEU=; b=Ku2xl0Z5zKnEquAPdynPdmGY0gtdMjsJs77EOgbLesuagGCgyzZ
	KHW+zVFWjfuln+WNg60qUTPp8id7+sTCtyFiswHbWPI05w6VNn34OebCjLmfZMHO
	rUHdkY2lELxJrThEZgYU95M32M+1n53wCvYwLhHrwUHkkI8fWzv9wwX3ce4yyGaW
	vpqEI9PcKwxc+LMl/8Ao36/eIDoqgFzNE/xPAwvsUt4dM7VrBBdBHDbpH/pGqaGE
	2/LeUOp4NacntURA44Kr5wM6t1Rpr4Vp0H//LB9jvoXJqLvOYRzsRQziWjgePTT4
	50qLBrXDVa6BF+lR0CoN2/4HuI3rJe7Kdkw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795092653; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Xy0bBGxTrMZXgl4ZsCIHVJEQcR9kQlp1xUAuXWzCuWxYbpY
	EAYExBdrgn51VWFP3GiZDFk3ey0ottvCpjxg+A1SU1LhhTMe/E/WRD+PAz1t/sWk
	ekb0jSjH3l3luWmZMJ0hECK209YMj1Kk90B4GwtaqOEDOkXqz/0Ma6+cghw8Icrx
	dcDgP085cW2jLvT5w4ZRnZaZui1VY0ypGaqw/i6f8DZrjqAUjyjX5FeaTwlVQjvT
	Twn7cnCiYvYyb1B6dnVjIYJ0q8lImFlElv7ldbiw9plMWkBQRkGVSzwz60Cec0jA
	nV3YTGG3pti+xQVOY0BQO8poaSAs6So1hWLabAg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZySXPs/uhnxdYTxM0ogyT1TqYivRJ2nI8QcyIvdN1iY=:xpn6w5nvPe8zAYADSkJSVfmrRCWa7fboFUYN8V9b4YA=;
X-ME-Sender: <xms:rPD-ah6Ednvz8gpz87cTsw9iT72YDk46HAXs7w0xYdKRa10qAujS7g>
    <xme:rPD-ak7UZLSee-cY8UIMaz8rukHYZRcZK0kcYC_0mTiCzKJOgrwjuNyoFKfnVDooK
    b1TG4-oGmn5czwNxggQE-1W3SaeoqHGwlZybe5ph7PYJQNedJy_P_M>
X-ME-Received: <xmr:rPD-amFv3fXUHYzl9mdBynfdG76FNJB6eVDxIKTVAPhP9VvoFztr44zeF6K3xYZ4SpqVzuc>
X-ME-Proxy-Cause: dmFkZTFYA47s/0YWA4U8lV7HvF1Odhii7JsM2CQ96qUxAqp9AcM7zHMvHs+cw4n9Om4Rue
    XwYSog0zhpaMNm4GHvdJLRdsdEK4aThn1ZuhBz6SDzCNnwkUECnP3ixT9/oFU3Kv1QiST1
    ZJKsSSXquO3zyvpOYSwj3EcRdMWTMDqN61nBOWFZeExm/KFrPFJyjG/50xk5TSZ/Cy3rGp
    YIYCp4uWToJsblHZI91eE+7IO6KpVSfJAQa1KBwMiQt6PKoqF0CCay3KTjR+jw3K2AuiqD
    OJ155y/iAoSYp92Auge8Z0M/mORKAXu6QpVNFhqzEmkwayAAb2GHk72DCrUAxhGoqzwUXV
    faCRiYfH+Mww2y2ucKCF6xqzrnKLor9vO2cwj7P/uyvSYMv89YHbL9r1vcxfnOLxUxzzkE
    FsVYXvkSK/p2+16CeNXu3Lx2OwleqzAfNWia98jCfaR+YUmQi2Z1WQTRtV3h6f1HnJwboz
    9zcf6kh8PE3e93rMoXoBZGrnA1oMpFQ2GgDsx4Q1jdu2+u1kLh3ZQsheAm5H1bHIhr+94/
    oYncxYPdM2RAiKvqEP0i4xzM9DFwheBkHdV0HNoTwzjDws42sBnOv4GqBjtUSS+UuhSAO6
    5nK23By5CZuijA+l4Vw4bFwdXh5VrMo30LT4UaD5tRv/nXFXAOLBo/4egvQA
X-ME-Proxy: <xmx:rPD-alTbn5TpUfJrMBHF7YxnBX04Qu2zGqKm00rh83WGa8v5iRNv0Q>
    <xmx:rPD-antYVNr-yrWV-Ja1SAP6CSiY7TOYQEfdMbiwqSyi7IOjowf_Gg>
    <xmx:rPD-aswZZJY7_zV3jM-hmLoW1rh0LFhUUSG8pd5RJaywpIHJpDjx0A>
    <xmx:rPD-ap72cIPCRzUr657nDn9Qt-SiAkcVkL0d2e9J0__0kXfDtPApIA>
    <xmx:rfD-asZtH8vLXMHTAHn9ysmt2_fLeG4wC28HOeLSHvUNLw5R5BnUwIFY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 07:50:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1c525ae2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 12:50:49 +0000 (UTC)
Date: Thu, 19 Nov 2026 13:50:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christoph Weiss <weiss@wsoptics.de>
Cc: git@vger.kernel.org
Subject: Re: [BUG] Geometric maintenance prunes commits without updating
 commit-graph
Message-ID: <av7wkQXxYrzAJInT@pks.im>
References: <ba964c70-60ab-4b7a-a0fa-6e028e401a09@wsoptics.de>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba964c70-60ab-4b7a-a0fa-6e028e401a09@wsoptics.de>

Hi,

On Thu, Nov 05, 2026 at 07:41:26AM +0100, Christoph Weiss wrote:
> Hi,
> 
> After updating our internal Forgejo instance from 16 to 17, many of our
> repositories' health checks started failing.  This appears to be due to the
> update entailing a switch in Git from 2.52 to 2.54, which in turn changed
> the default maintenance strategy from `gc` to `geometric`.

thanks for the report, makes sense.

I think the way to fix this is to move generation of commit graphs into
`odb_optimize()`, which would give us a lot more control over when
exactly we generate them. And that would allow us to figure out whether
we have discarded any objects in the first place, in which case we'd
rewrite the commit graph.

That also aligns with my other in-flight patch series that makes commit
graphs pluggable in the first place. Once they're an implementation
deatil of the object database backend, it's only natural to also write
them as part of `odb_optimize()`.

That means thought that I can only fix this once [1] has landed, as any
changes I'd make to fix the reported issue would conflict. But once it
did I'll send such a patch series.

Thanks!

Patrick
