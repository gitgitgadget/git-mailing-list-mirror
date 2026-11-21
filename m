Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795221691;
	b=m+C6Yh03ZDQnsCyKRPrpBeVEOjsDNa6Ls/aRA2lUpeaCaTpHHhP7XW9GucRSKREf1877
	 wqPXznR4QpRSAGN3vCiLusSv1aJcFP68l+8raUGgNQjCQz+otD0pGvSHH77O/uXNIMcIa
	 DGXc5yC5uAusISK86NsMex2949P70esUAFe/9+CPi1OpjRg04EFnUIRfdDS3v28tNd0MR
	 WhkY4DHOv8L9snS+OQN5ojAiWxP26idi8hpTK+B/FTaYBMib6zzy+34AXTH40SEErywvh
	 3wKz/3bjQwCPCgZ5kSSo+RJ27+nXwlCMMx6M0T6vFDdAQDxGqqCkWm9XseEz+XwqECg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795221691;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=G9dALrP2t7Olr/QGB4+l590VlmfEBJjL+/pUthXzAkc=;
	b=VQfyXY1P1bckiiIIJx3eTRRryRboMfgQfyc4rXf5tfOitGkF9RvfH0ErCDikRY68kxdS
	 XmjaymLoalrFFKJhXHEgGXwGvifrpwtVpl6JS5aVRH0xVfpfM3BnorFdVm1ZFGbizoFV9
	 1HHKPG6dmOcW2g6UFkCpv4Baurcjktz4RC7GJbyg/V0401GYZszOznfGxsr5kBr0dC20r
	 PnNVm17v1IcWQAOofYSQGRfRRNipVI/dn+1xqzXiw6xACE2NU9nsQzQnP764dPMDKxOlx
	 SJe1OL6Vas4TVj0fhn1Cyc45hOwRRfgHzJibQW1jxKJsLuqeWAMKA/4o1O8aHlvjAsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="Ldzmsn/g";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dsb8Wqzx;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFCF606A689
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 00:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCFCF606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Ldzmsn/g;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dsb8Wqzx
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id F0FA4EC08B5
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 19:41:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 20 Nov 2026 19:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795221688;
	 x=1795308088; bh=G9dALrP2t7Olr/QGB4+l590VlmfEBJjL+/pUthXzAkc=; b=
	Ldzmsn/gZBH69+GU5TRDw0zFqtVMRbhG/R1Xhccz5xYsjbZn5KLV2sb0sxXvCIDh
	h9e/lNbdJ1ujPP0Ko07vXiuTbKROzkLrEqT2SK/BhIrr1K493BdDW4DLjjxo7OTG
	7xfyU1NsdzJtIXHkPzVCxRoHgtWXhl6e7gNYsMwlaZf4WyfPaP6binokMBSrCMCQ
	xUGvRJi58MqwAeCD11OYd4lhGTN+g4iaczuiCnbjY15za4jOKULI9kBveY8DUucp
	rf+M68hG0d5md+xrWUR++Ba3wRsj5E11KpwxPW14WS27ZWdUqijYL1sVuONyoj/x
	NqWuKpY4GG8SnynIPUlcxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795221688; x=
	1795308088; bh=G9dALrP2t7Olr/QGB4+l590VlmfEBJjL+/pUthXzAkc=; b=d
	sb8WqzxoED5XpqkfRSoTn08nzlnCr0c6vo4HxwYXvfdfXryLk2ZLCqBsGUZf5jxz
	g9+fYbxvAo509Rrt3HFv/lirEwb/mTKL9naCMx0kZx/y/57dvzKAnp7U9IUrFYVt
	1MuvMvezRaV5yNN2BaZRelVxjuf5U3qIbHt5eXhSfHa3Kc1qTkAGfkTJPV4gAOuI
	aI/kNi/5zHTf0w6cMFTHW405BkEFTLjOPHLQ8Q8he05VpVFJQWsBNV+PoS96w3eT
	uhgg7B6c2YBLydaVryT309FHrCPyrPrFXq+AntM22AFKKKo0TQ2PDaRPyS8Beo7v
	SJnbSu0UKSes5uZtEg3Bw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795221688; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mqhgQBrAD/up04UNtIst7/NIIYIRmbXrgob/8amPC2hr67D
	Bvvnk4WMow+7n1ldr1fxJZ3YLprfA9kY8AkrvB/GfLdL1ncv9zz4hEJk+s4yHlQp
	tjY4fl9JhVUQbnIcvkIGHpP1/7m8p+P66aFogIGdwpNw5XQR+bksSTQ0Q+CWU4ms
	QIDhO3kvxg96jn3TPUXhPiQOzffdSUYO5H90CAxx2w1vduXgqmoGsoC30HgfViGb
	RHPvfQqN5ZvS9F3GOKJGSGS3rs+5JSREwdAX3tPFDpatWZiq2Zh8J3pdBGOp+ime
	WeI94sR6aoPrnpUMKyT8/ffuCZGVXrisVU5zkpw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:yI6tJnd6QYpDdLdr2ZG5KHH0cEiPXzbRas7EocJ0PLs=:8DlXCF0+O5LYaUsLClEMq6WhCDeeRqL9t2O1VUav6Lg=;
X-ME-Sender: <xms:uOgAa2WiM0P3ByMgb1GORN0-HWZIVQW6iZoj2T5LpjhkWxhWacaUPw>
    <xme:uOgAa5fJK2ebavopIdOQQb5JqrZ5AazMxw-1C2bgnZfVlhJpLuAtxroUiQAZh_jsk
    1MldDighGeoYbhKOonlrYHUQ_SmeWthtdNHepyNaF8OxxIDiWj7KB0>
X-ME-Received: <xmr:uOgAaysSCbFUPryvmeHE9pNhsNWiNlpoMn0s7UKeyG3mUtCvLqpa6P9YhA9bieebCoOWqOfz2Jdo5Dxz3SiCklomTxKd6OCw-LZg>
X-ME-Proxy-Cause: dmFkZTFWVmaAuQE6K5fdp0WeIVuJOkp8mYweAif/2enRXLkNAWrZNWq1SUCVjIAMHoGJeM
    KVmQ3Dg7Xb/QLmlwoxzL1A6gqAYP8gq2rpRhZfBFj1EukMvjb88Fu+x9QbMgDEAZyFvpdr
    11kuEJhtZshqlU3ibvhq0F0taw8XBJphe+Tf2OOV8YRKj0MbaVgkYZVFCONiT0tUff0xiL
    uV9hY/QHLm/YLHou1e+72H63A9ZTic7pH40QtkTVYi6ZMbhncLf3fmHiKSyzjjGzagwFf8
    L/fOCVUoBAJZoZYjCs566vREFb7KpB42KoGfBTnmoWDlNEDmuqDWdnKlg9BYfxXQ0+kIPH
    X3WstZZwHQnekyoJE841BKMQCFcwereH0XVZS/AW/AD7SDsmhFicz3wkgOrzJNrMN9uxFj
    wHUkO6vrcJ8nG4J2KKZx/2DC7YfeFuTxsVYoRGK5GQOf7EOcqhGHzLvzFI/w2/0fV3IdOC
    UVqmz+N5o+eA70yRkOT6Hmg43VkpN7eAsGz0/xVRdICQv7tB5JzloNFY6Ll8CD2TjBXkhC
    +6fWTfAh7FFPhy7dvQ+FBm/5bLONEH0AUlHo8ZxEJWfaW+GdTtDUnNMFUMtbL6xjYVHMJF
    dEsE6NaxxNlp16gAYWY9PuWYMLjzPyWlHZY6TZAlXSO5+wfpZfBfu9SBLRWA
X-ME-Proxy: <xmx:uOgAa4-IdBYxOsy2XUmrktNhR8sL7wJU1yWVsgJDbW1lATFvSbJAWA>
    <xmx:uOgAa91bOF1bDLjcYBlJCNZ1EVIR-yQ7ICxd6DiH1iKyqJe1ezSyBg>
    <xmx:uOgAa9AEQK0tApImjjKFxWdQmPY2VVgiJYaUomws043xppy-R9ayFw>
    <xmx:uOgAa5c0jm7_6Onnub1MFXTDRk94yxPV2X_QmnWbHKAISI-JIl7VVA>
    <xmx:uOgAa5MzIISv8mEb68NUvsw4L6JxujqN887Ha3vnKoSaQyZ46_aWoCAC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 19:41:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ophir Bleicher <ophirble@gmail.com>
Subject: Re: [PATCH v2] doc: fix AsciiDoc syntax
In-Reply-To: <85D05F5D-111B-4A60-A923-B45FD514CADC@gmail.com> (Ben Knoble's
	message of "Fri, 20 Nov 2026 19:18:37 -0500")
References: <pull.2496.v2.git.git.1795199746309.gitgitgadget@gmail.com>
	<85D05F5D-111B-4A60-A923-B45FD514CADC@gmail.com>
Date: Fri, 20 Nov 2026 16:41:27 -0800
Message-ID: <xmqqh5hbm2x4.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>>       The differences between using `gitgitgadget/git` and `git/git` as your base can
>>      -be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)
>>     -+be found https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror[here]
>>     ++be found https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror[on GitGitGadget's official documentation.]
>
> I’m happy with this link text, thanks.

Thanks for writing and reviewing.  Let me mark it as ready for
'next', then.
