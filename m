Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5A83CFF56
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781263553; cv=none; b=c1B/KrC2Q9rOFipUO9KS9dOCo+UOBkDbZ61RBE/vD5tq6j/Yyw4AJ/Pqt9v8/Iv0ligM+BPPeWBE3HlUH81dkawnpGAtJCU4uMYHCo0qwS/+ImQSnFTP8dtN+WtdTMO/QXY3KyXeBFDwV0gB8FyCDf+iPKO+uuWihWITTBlWwAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781263553; c=relaxed/simple;
	bh=+BKUFm03Cx+/rgvh3OszThUGnUmCyF1JNpLkLGNEIMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5qv1zX3hFVk+7Qb4S8KEIFEfFFZPpj3d95HhvZzkFXWm6f1rLP/JKKhODX24LowwfmiXC7miuHT4Jq9/F0nZaA1sbrQaJx2v47EV/kzn3B/dkaOaaTYSw4BBqJhuOb44CnKVD5DQ2QmLWs+iagfYyXmlmfdmhNgUQRRx+XQCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BaPeAUH5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S4SZfqaZ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BaPeAUH5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S4SZfqaZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D582140003A;
	Fri, 12 Jun 2026 07:25:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 12 Jun 2026 07:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781263547; x=1781349947; bh=X5KmuxLWO/
	RXlSchUp6g5PRYA0j3neLGsGIatR+fHMk=; b=BaPeAUH5c8LTj4zR1OUTuhfmPx
	yjMwOSmwgm82pP1PyDFIidcz9O2NaGsAJa1oIWJEQo/xrSUhMFN7TUtKr2WUPwDU
	TfzlMvwUoSwVGKJCUY0SNjBt/hmOQfve92bJqdN+HVE8ctPd/mKHl13qFnb2fawW
	XG7iJq+6pxISwHVpo6q6ghtjOH2GTb/H/W13okdb98+CfIYxVZbgEjwNy3b2wQG1
	UCw3Ch+rSwJXxfXZKdVOL1aLR3PYo7a/+ZxgPZwn5l6YE+dLvF3DaBFDarD3ksp0
	QMTuoaZ+laYWy5DJ1BPxd7cC5X6a7hBqozHg/x2Fn4tbxJ2064SJ3ZkDzHFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781263547; x=1781349947; bh=X5KmuxLWO/RXlSchUp6g5PRYA0j3neLGsGI
	atR+fHMk=; b=S4SZfqaZP9l/QwUm86RyRc6C+/8xHVZL+GoSIf2npecR6OIDIpJ
	g6PZMLlYVOfJVO2C35Yg1WJnxQPJBpnv/Ow0SsSXPCAmtYtCrJqXaDrixaoWTKf9
	c2v9CLVA7j7gIu5vV5AAQDaJA1sVBx1sJ9iV8wuUM860Tf7zju0tvGmE9n/Najqa
	1JU2MtGBJweDN1EJF1WDFxuq6P9HJnGzPq7djq1IdPxveD9rIRfA2SRtBKWWJ+UL
	Gd/xh6asRolT0wzPZxvK2Gx/MeVzpNS+HffmPKe6hkLjJDdMFoGxj2eRYsmx/NKN
	SVOZZAyXVD8q7WSjzxcsXBEe1TqWromyl9A==
X-ME-Sender: <xms:u-wrarP8uAf6qWpICejSOXkaYsbYZoHz91SspTrQuiJqqMRW1DlOMQ>
    <xme:u-wratZhol3bP2JCiIJwbw9PEZs6VFuAt95qLBmxxIk9H7RP6T5Y1nUH4Rutr71zo
    ELwha59lNfik-ZJLz4ktJ61H_NfRu32HASg9-dMLEdl6ZIz_AMloA>
X-ME-Received: <xmr:u-wranr0z7uL5VaWACe7AVAj7yaBm-fbMkrNmygOPh-qatqrouBjuWcnc_A8O0ii4YSqtWoqBxWKDcRIoxKr-2Zn81ZisfZFKVRHeySkVc0>
X-ME-Proxy-Cause: dmFkZTF48TXsJSDjSzNsOJo/GpS7NMZ1aZJUYSyXFtFKpGENzLsHAOjH/U7wwvbkQH4Arz
    itMBD75i093uBW5XaWUk46GopEZh1brVI1Oc0pZlNlV+r7bR80erQvyGMkox3UblWkEEub
    rQbjZdF1FQtBsfJ7PI11UvK4AO4FvM+xYy3JuqsoGgCmc8JlJHqN5erj2Q9F6pyzkRpMEM
    Ys+AwDxdgajFJJKJsfmSED8Yi/E6zuCeo3zv2/OmXAFwbDb/M/HUzNGYrotWg46q8lrfQT
    RH/98gOKGaQTr6jgdTWDUHuRLNWzKe+Xw37BDJUguy0GkMPDfh/fAE2z7gzFKY9YcbD5HJ
    OaIP5NHHrcJ6WjYJ4BRZh/aVRsXIXEHuWFFoLaWXlh4j1XYSa6BPyJTrIizFzpuiOn2Mf9
    XKsmD34BMmm9viS57jc91QZ3Cio1hC2wgpBWPZGtXqwQJ+pQtYMBw0k+/wjmukYS8FTKKj
    wHHxVrImxdMV6vmRnE+QNm4VIo2N+SsADDvtb+xofG1WknUzKZAio6BT1fs8LGxsGOuMVT
    6LlcCzlAmHoHc5w0ay4dU7AN9Q1WF28hTcfTb1Ijou3pjZNcjkXkom1BYlWQvlqf8mS1pl
    /YsMhX8TxCFIgKadKI6EAVt6anaMuvRWXmg1gm090Bj3hQRQFBlDSZo8Xhqw
X-ME-Proxy: <xmx:u-wrapY3c-L0nO1lyfJZmIlyXyZ0u0Y-5KAWauhLJ49JoO8WI1kE4Q>
    <xmx:u-wranTqqKu1ZoqAo7Lo6shaJXqFBBPhHlLQ0DiEKbko_rhtNGR6cg>
    <xmx:u-wrao6MEZ9qV53X8qQGJPzNtEh2zJGTxJ_1-DwIrW72yQ9XKhNRPA>
    <xmx:u-wrakx2e6MDE12zcqETB6MiF4czcCOTfn1wgZcJ3ARVzaa6cAmDig>
    <xmx:u-wrapZzVjokhjriMyRLYjk_SoYvHPVd8t3O2sAfGKUQB3SM7-_zF24g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 07:25:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83af6673 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Jun 2026 11:25:44 +0000 (UTC)
Date: Fri, 12 Jun 2026 13:25:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] setup: drop global state
Message-ID: <aivsoM9Qwv0m_P1c@pks.im>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
 <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
 <airVOrTboNDDGBak@denethor>
 <87ldckyygk.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldckyygk.fsf@emacs.iotcl.com>

On Fri, Jun 12, 2026 at 10:06:35AM +0200, Toon Claes wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > I find the additional explaination here quite helpful. Thanks.
> 
> Yeah, hard to follow series looking at the code only, but commit
> messages make more bearable.
> 
> > The changes in this version of the series looks good to me.
> 
> I've only reviewed v2 and I agree this version looks good.

There's only a single change to a commit message I've queued, so I'll
for now not send another iteration.

Thanks for your review!

Patrick
