Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792475442;
	b=C9QKIrgFO++e++0HDChzgm2Qhuc863gclhG+2EP5IxVPgIYXV7Now2lBdHC0QPIGxUqo
	 5gPQ7qI/e6okmRuvCU+LnXHWi2gNX3yz4MYq9BFKVxfZukEA7VPWmewRj8yYZo6Qzpjoc
	 BN00TgTLy8c3OfYG4TyRWiVI8+IkfSHkzwf52fg9dASfDnf67f/y5EFk8PnMcUpWGSOS2
	 C6R82GCPjUiJ+uvVo3MvK0Jy+bH4BpnHl40JO3bMj2i6N5rN4XLREYrtRFw7/8LLOdTvE
	 Z6G7lXZ4jZDn+G+jwY3mqjbX08KWZ8RD4oztpphvAzrdn9dwI6zBJnUiBldoUNqwKEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792475442;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=abmeXbfRqL+z/8Efin+PeqEonwktVw4tWn56m4uzd1k=;
	b=uy/LRju/nM4EdVoTMOpP4gCbNKEHlRhrCAvmqeVvqxYKrbmhvEs71PyTlaKZ4aeUjRTz
	 fYvdL8rdJJSmyqKRTLjG7RYWRZ0lCoBdjxbHzHm2Jqsww2FdRZ/7Cw9VRk8I53YJ/ltFW
	 RdFrYGdkU7o96D2ZaCp+z+bf1tP2iS/MTc9Lt5orO4dHA0suyuVB51IBaGpVQZdxBZZtv
	 pF/lY3yX0M0pVaOlTJkmPlXEr0bDQBfaJ8Zflnf4AdLbGfgcclMXYmjVsGlv48YwP7JVt
	 ZI1hfNiXVHl41zo7g4cEdhAJYdYFL65L9MvAuOgifSmmGnjHqipabgjTzQN6/VR6Weg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=N8lRd5gX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="MM2zY9j/";
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC84606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 05:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AC84606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=N8lRd5gX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MM2zY9j/
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A88947A0196
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 01:50:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 20 Oct 2026 01:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792475440; x=1792561840; bh=abmeXbfRqL
	+z/8Efin+PeqEonwktVw4tWn56m4uzd1k=; b=N8lRd5gXB6OyEWuAJV+j4uFST0
	4Z02FN7IVU9dH1KUfJHC107jk88SF5J2Egi0drqDuFtEPTco4xVWAtmXWZ+9MNH2
	lmSrTSFqRRr8LyeAFQuJLPfdJrMtToeE0iagE6r9h25oI9J9qYbPe383+8+Ox83b
	zDc+g35ATKt4qg7OpH4+pSNWUtorSnmrEJp/sJP9eb7JtnQMK0PRoITKqH51OcQU
	bTIBvB//mMLrZu9T2EWpcXKDFkZHDR3X3vyIDEOowGfjVsY9X9CQ/v4gV7dc3xJW
	z9XvCfhP3SbWK0uy4c1tyXT4IE5b/G9dQjxlT9e5v9iyHruoJcx9zAcyEq/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792475440; x=1792561840; bh=abmeXbfRqL+z/8Efin+PeqEonwktVw4tWn5
	6m4uzd1k=; b=MM2zY9j/AVLRSBpSEbcYt5Vu+pjpw86QT9dFtigVbDLfP0n7aye
	qIhlCqCXzWUTH6QHkCULDXSXMWTW+nhtkkJ8UzcfN4KjTyYx/8zQJr71t84vWIhv
	894a+dLh4kVh/8GiYI4vG2yXev1pXnrfwa/RnMN+OpnKpJLL0+aqT2c8c8Vjms+2
	O/K3dEAYCcSN6Lr/wGjG1XZvNByeaZNNuo8gnnmcFi36LMSadh+wuPF7z9rp1yne
	lgLDmOgQMrDXBYR4A9XVzZjjE3XpQzVF+t99gZm/MJ+Fz0ejBizx9Muubfroi6W7
	Z98FKOsRJJ9kus3d60sVV8PR6hvl7bSaG8w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792475440; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Z9EpUhL4TJdxSRW0iMSo6D4Fij7Zb9mN0YlT8Ui7EImZmvH
	NhXyNP0UmyTRlxbY3XBGGMA/7qezBiKmR50QJ5foKg338dA+npydjKhPIDu+6oqJ
	WoL5kxSCRJcfpV4g5fmH/AXNipS1JYNJ0s0MUnYTYGBNx6SpOA4zshzEu64wE1kX
	E6d6xaYwIzL3k+dQTxxQJid+bct1obZhpxMYLiVgwW6EEpuiq7LwEtPZY+3pGW0W
	wsKX94RdpGGecqcL8DvcDiKsjEIYG2MfAlZ4V9yW1zVVbQO8sbyetB7yAL4S83Xf
	DqrMdSn2P77IWs2OCblKSMjn1zQuBKfWbTXomfw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:UBYhTAiGLv6FYion5HHD7/qVly2XuRZCA2rEXXElz1Y=:y0Daq8eDSMZ/Q2Lx1aJB31VYmTgEWTZBpuLVoGvO7qU=;
X-ME-Sender: <xms:MAHXamBdyEq6cmyq8z3qgvdTb2-woTHW-gAf2-4qQGWvdW4Dk49gUA>
    <xme:MAHXan_5heH-q5ThfXQ4hioVNHYOiDc19hxlco4QkmRRnByCO8DQldTunbIv2MTN1
    j6gxmi1BT0QQ7MlcietbgTJMP3smifNbFiXiyqsaARfN_SebJe68fJ4>
X-ME-Received: <xmr:MAHXam9dxbtUfhrrXC_72UQCLt5Bg7ISBc8GWFzZuTzi7UWj9-39vBq_1WJLYuSuwf3EhQ>
X-ME-Proxy-Cause: dmFkZTEGd69NnjLAVpOv84uzqLFTSlNx17Q8AXqGabPtaamQFBbaYn/Z0VD/pJNf+EGjyo
    Rlzcww81VR5PJd+t+FYbkbnafKG8SpLwKwzOSbwdr1dBO6TeO8d3PGPHWd14tA+nHg+vVk
    vopfxr+Wxhhb4WK8y5I/wf0pux2EHXKeZVjDX5MiDS3u4RFDvUfLqdZP+YuOQ9OgQq5o5W
    L+9+hPgyklg4nGnu1b1FH0P/aZh79t5Ev0Qw9E76T/bMQe4stutvP2MB8PF/4IvErNbOCZ
    v1Ibm+2jjxxqZwOjm223fpK9nFAkxCY7/f35jYOSl12YOBOm6heU6c4mmjMXhpSkEjwDOW
    I/0w3xmX4k4xX7BqitcK0YTSjToK1B7zIvrmnxTAuGTgIRSlgmMww3M9M7cPd+xm6OaDQS
    fnOUKVMTawjECMIyh6kqJOz++/UrEUxdrusePNz3ZcOl8vQx4p3ZRPauAA7Wt6fWMmarq+
    e0wJy7HR7vSykH3s/y5IRZKdFJrzYiu4FZsjUNJQAjkPqv8zu7CmaXulqq8D6472+ciQb/
    NCfeRE6T4Xr3pORfYWsQOtu1Vy4JZXewzffIJjqDDsJj2CRwI9RtrslnhrPiIvEQVeNNr2
    jTqknoOrUoMHVdAYV5xFFHyzFpcf3EZ4pCfy8Ge2VJf/Vzj0Zh8zlDtyLRWg
X-ME-Proxy: <xmx:MAHXaucFGZIgtMlLzvpJ625eNkycgX6ZFEUwzBitU5XTB4HwVvANcw>
    <xmx:MAHXavGISt1Kms-X95_bfLqRqFh__NV6w-DOYMMes3QUfeajmwK0Qw>
    <xmx:MAHXasdVgnbG4Duj3baPj28I1wQN5MnHLSlHesdCbwhK0LZIPnemBA>
    <xmx:MAHXapFZ1qEqCaXP1j_tEbiTuuIzyAo07hGYOEl2vYAJ9xB3yZAk9g>
    <xmx:MAHXagETz_AjQBmNM8nqCV88M6CMs8JiLcJMB1FBCduwfI-bsorOfb67>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 01:50:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f5c1e32a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 05:50:36 +0000 (UTC)
Date: Tue, 20 Oct 2026 07:50:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] github-ci: update macos jobs to macos-15
Message-ID: <atcBKeaaEAfCez9q@pks.im>
References: <xmqqfqy5clgz.fsf@gitster.g>
 <20261019194152.907881-1-gitster@pobox.com>
 <20261019234724.H0mV3jqQ@teonanacatl.net>
 <xmqqpkx5yxz4.fsf@gitster.g>
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
In-Reply-To: <xmqqpkx5yxz4.fsf@gitster.g>

On Mon, Oct 19, 2026 at 06:14:39PM -0700, Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
> > Is it worth using `macos-latest` instead of `macos-26` and
> > letting those jobs move along with the current macOS runner
> > as it changes?
> 
> I am somewhat torn.  Being explicit on both ends would make it
> consistent between .gitlab-ci.yml and .github/workflows/main.yml so
> that we can more easily compare similar execution between the CI
> services offered at two sites.  If we could set to a symbolic name
> like "latest" and "oldest-still-supported" on both sites, I would
> probably choose that in an instant, though.

Yeah, unfortunately we don't have "latest" tags on the GitLab side. And
even if we had that it still wouldn't quite help us to keep both sides
comparable as it's very unlikely that GitLab and GitHub have the exact
same schedule for updating the tag.

Comparability to me is an important property as I want to know that a
passing pipeline on the GitLab side will very likely result in a passing
pipeline on the GitHub side. The GitLab pipeline is what my team uses in
day-to-day business, but most of the others in this project typically
use the GitHub pipeline.

So personally I'd keep it at the explicit versions for now so that both
are in sync. We have to bump versions for one of them anyway, so we
should make sure to just bump them both at the same time going forward.

Patrick
