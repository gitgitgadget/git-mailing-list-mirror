Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007754;
	b=o0idEpOuYdxS+FjR04aE5zRCW4LjQK9QcrOqAMFsn1RemUkgYFZSe6KID0F4gZTXGHhZ
	 zoUfl6vOy7mJb7b4O2pUnjvoCgxbHhwNk4J4t/M0fw82vNQKgl+9rnEKDIXsdE//H78oZ
	 1oSzjPGttvpn9jkoCZHGwTYkIdATLqREhJpKeA2FkIc9TstzOAg2bAy444QAYT5vqW9yW
	 he/mqW7e2BDR/BinpG6JN+n5UPzfRXN+vEQ0cfVqSIGminWDB4dve3aRr5Yoq0aYgTFXa
	 Re3F+9MpBAXjUSFXTnunnVw1iaKdRafMTOBzZR3q2oBzTGpnjiW+7BdLRdNA2nb8TLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007754;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pAgIxekT54YgBN9RMVnWp79dxv3Rvrx6r7GLT44xQPI=;
	b=FiWzYcvG/IUb/TsYNSqjsJV3vtvkhTQz5wA/+xtAuAwimERUIW5G+Yt1hibHvdof5Nfe
	 hy8NzIuaBh18oUH/m5HYaEl7zn5ZZFDXy+1OZZD4rss6eSfmmR1kaxp0vBPGYWgYNbzql
	 Z0LXLIK1eNrR+Dh7s/ubLe9v5FHOsbNVuhi/ep3R1F5Vxz8ETHjdfG5LavtMOvF+vkDEV
	 WGw7WEPVnjgl/Rpa004roQhM/rA23cT05rO92DBOVsozgp703VNOXOYHeqp2TdBz/tIpL
	 yd6Od6HZCgjQM77W7HMAA9y5SIznBY8eo8jov86yLc5PEOkCuFTTyy7weQvdbbC974g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="tCrN/by7";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="s7+J/tw/";
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9760A380B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9D9760A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=tCrN/by7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=s7+J/tw/
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E8B71D001DD
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 05:42:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 05:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793007752; x=1793094152; bh=pAgIxekT54
	YgBN9RMVnWp79dxv3Rvrx6r7GLT44xQPI=; b=tCrN/by7m716wlLQqP9aX/nm0q
	BvFKn5OwhXMMhVI9BByUUqSSutx5Zpk6Nbpo2BCA6Sfu6oElXEcQ9E86HrxZS/b0
	vL1nTgXP/iMOkZkHhcIipMJynI+I9OQFYt8W/qM1wJE+coanbbRfg9lm7ewf/op8
	TaZR2VnKAuB6NvzHnrpnZmMntesWlBJXAf3kSSRSASpTcqD4UGyUGT9yY9LKMGLh
	Giq/ZpuXakW7gwBgUCyYuxYeKbpWVKEoR33tzbdOmXA/PPLx6u49Tw+EBFeVpmGP
	fS/YlimMB2MRyj1rF/b7sZgfPHN+Tpudv2pIiABfvcWCn/Fz1+RnP2LiXIzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793007752; x=1793094152; bh=pAgIxekT54YgBN9RMVnWp79dxv3Rvrx6r7G
	LT44xQPI=; b=s7+J/tw/etexvuuUzf9xeRRhA0juyEcUrdE4lvWBYUMbZetV3k2
	8cZS61IKpI8xZ4oruem7eLOnY0E+gp/hAuRJ7mFmxHy5vMDy45tfz+9+rcmrZEP7
	clA/VcumYgGcFN4GZ4T4lT8bHOmmrJduXy+af4Z6pJqFGyZ2V+g6I4ern+Zanwgy
	k9xUa4BGV24iprtKQNvEoKzV8qC5yzdiB8WfzdeNmehJSnQyTYw/fDc2+Qf5jMao
	t1x20m4YWV472wuOgICFiSEVJBmwGYtyGPWvjwoocdFFoCOhjxViq6oh2UMUrTaS
	enzfMp50SISJG8aTa4diFDXuKvqWH3GOdYg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793007752; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SQaRLJRL4NFtfw0YY7iEnxY2t+rOLxejgbruU3aNoQo7rgJ
	QtecNK3fTPYAXXdg8gxnJoS61cMU/yE+QMfX7XFPNyCXeL064Is1Tm9j6Akyd2vc
	06YUvoFYCNFPamaBaWbZjqEMlTi8HeNRwGprL9DcryCN0iZKQHL4SeBeDqeKwGL5
	9dEXaRsXcMSt9svWHCPs22CygB9oJnzj9hL6u4B8yUZK0FLleSIWij7fRc/+SSTk
	mOhEQ5Fi8lhEbZ7MHIRp9iWNzlXb4S26qHZPzOZbwAHXWugGctkBUMA38md1ND6Z
	NyV8LBU7AN4a0WznU1r+d241BkMTS3gB+PoASKQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Wfa4K9HqMGgN/uwdXvwn7ifHh8e3f3/PL+S2vdw3PdM=:e2YbIWHvJsf6ReJyHdnTKRDtPY1lLFB9A2+Z1QnIOoU=;
X-ME-Sender: <xms:iCDfannW8xd09n8TUdjP0djjDPdZZ7skMkNEIiLqjRWoL4ujEbXxpw>
    <xme:iCDfaiT_4JxVecololzqsjoguJx7Nc9GNGpTd5Dws2ohp_M4ESKncGgi05F8Jvgim
    b_BwFKCPpZ6aFiVsunSNyJ4U3eudrrOTGWI7mMgZqo2yLWszm6IDiE>
X-ME-Received: <xmr:iCDfarACtZJTHFrOHRg6-rMYfljbfK93PT-AuIm2X0dKdnnuuCKdeQ>
X-ME-Proxy-Cause: dmFkZTGsRqgBGaY4hENaiUAPdTdYcSsXORGT6NOM89J+PajhEv/jqs8jX0nmAtDryksltA
    bl0SP/YIIViCeWKeT924HiXk6GrEnef+oCmRaa/RmzRK88mbdwDcGUxP6oGZFEuChcs6o6
    TefptBTK31JJ0NkUgRJ6WeuPr7YW8PNXhigGlwSV2skINIWSgP43FRT9kMrQtxZOCuZMGe
    2bx5rUzTPJ+4jbAj6eXPEqraElVMVzuSGwHJg6SqJG0KPze/BWL3/tlpBoYFqDIh87muKP
    6E3RwOke7dX0EUI/MyPiO8lddlWOIF9BMrpuKXvuisXl2CoV/w5wpCjXQvFcKEPlm3wdXH
    C3P1tP5jdLeU0ujSNX4IIew4ZDtQqzy7lMC0QYpwjw6AP+dMcODalWPXuWyALSfqjcZ6Bc
    7KTXdeSJX3UmHFYlZonfAArGU/MszPRPXF6VzTenvwInkeJfj9HLprbCG/kYkArnVUn/JG
    cNIajMd884aS+ns78v4+KVp5ql2VmQes6Xsq4xsAJp6pe4MqTg4qIxaFn1f01UXfRK0e53
    0agazLovFHyxeWdLJ0jobn8GJih8+3u4yYPmzoiQ3P8//b1qk1/Tq/1uGfoMTfoy4DZ1IQ
    fxRRilLewX5Qv7pOvvQK5ovInMEp4Qh1LaboyljhobSbuoGSSRrXJhC4aPwQ
X-ME-Proxy: <xmx:iCDfapTIhhovib6vsQjroDaCONgsoZpHPNmE8JnzD6bzRVM23HuKpA>
    <xmx:iCDfapraaQ7PK3qL0DrDFmbYROLles6Y6gEWHnZA98zBJu6iD94k2A>
    <xmx:iCDfarzwAVqDvjKXK_9LMOwItVPSpBDP4CyVJwEJXlzFKt5GxKFkQw>
    <xmx:iCDfauJxP3QDQNmb20OX8fehB4mDINPAdlgANj0mJ0_6PQd9JB36Ow>
    <xmx:iCDfaqsp1bQBv5q_lGN4aEfVgmv1np-12hRVjmlaNLAU-ewvp58uJwYK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 05:42:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 378aab68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 09:42:31 +0000 (UTC)
Date: Mon, 26 Oct 2026 10:42:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 4/4] imap-send: match header names case insensitively
Message-ID: <at8ghTkzSQE7KWVg@pks.im>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
 <pull.2456.v3.git.git.1792652185.gitgitgadget@gmail.com>
 <01add80af28d6a23e44a1d3149e2c2a875c00c84.1792652185.git.gitgitgadget@gmail.com>
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
In-Reply-To: <01add80af28d6a23e44a1d3149e2c2a875c00c84.1792652185.git.gitgitgadget@gmail.com>

On Thu, Oct 22, 2026 at 06:56:25AM +0000, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> imap-send says "no messages found to send" for a message whose headers
> are spelled "from:", "date:" or "subject:", although RFC 5322 treats
> header field names as case insensitive. Match the three names in any
> case.

Should we have a test for this, as well?

Patrick
