Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611882;
	b=hGGoNgwx+pcG+G4BklZAyB7gQsK0OKJpbxNoy6bWxmY0abJfUudvSdewB8AwTnvKqJgM
	 wYxsM7SSCUqIwXwUrnyIAag1rPZ45rKpYm5Rev1jjt7X+cnj1/ZNQM0MOCW5thJgO6ulK
	 f2e7ggU5ZhJfUmeUzIKWIr54IY3ZUDLsFjlGlfBXs6jSpq32Un23zs8dyjX/V4HCP4LWf
	 AgFLI9wPe2AiMcwVJAp3vDlxZzqQYmyFBaGu/s1ZUy9c+gXxFAQg4o+/2UtB/jPND6/Sa
	 2oF1Fqym+4jrzOE915ZupP9Rbb+Osqze6fOJF9bkF2xN+IPK3F4rGIusqIvtExGh6Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611882;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:
	 Message-ID:MIME-Version:Content-Type;
	bh=eGk/2mMfnkGeuf78mNWiJcJ29A1wU2ePi8GiCcYOANU=;
	b=R1/A6tuxQvzTsjqxU3derSieD4n7Z2B75ELc6G5fvwnNXuh6zWX5K3mflA6ftsgZDbA3
	 bApz7iVr2esEDpCn0UYB5TO5wlQwxDj7m+7Ou6uhiAA9q1vR9qJM6wEZiel2H+1oaEl8d
	 L2+EMtiaNM0/ZMm0iYeG59aqYdvgo3gTakaaGDtCxBIb58fFAG3M38exUIx8ZDITbtyTq
	 G5d9ttkXWdxKA3cvya5sBSkkN3eyKLsPmfax+/HQT8iA4pHeV2RyS/oa3K1EG8lQJ9kSg
	 gmWr3CtWtxlqJW113Mw8TvY3lLxj3hajtA/7L+4JpgembRpJcQd2P6w/ZFuQ6FyW7Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ExkwDERJ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HAv5JFbQ;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DEE606A332
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60DEE606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ExkwDERJ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HAv5JFbQ
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ABA3E7A00E7
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:31:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 02 Nov 2026 04:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793611881; x=1793698281; bh=eGk/2mMfnk
	Geuf78mNWiJcJ29A1wU2ePi8GiCcYOANU=; b=ExkwDERJi3brKD72Jz2Yb9y0xT
	vWQcYfuFDGa3gW7J9409SSYiXEGq+o+i/imFwBJc1h79SxdUXpYi6FOgJn/inlqS
	VIYKFvGKBY6jQBIJlJejtQ2+Qc5Jzk6lK398UtPEqnz52kDHiU6T57gY0fkfDOL0
	cycGuz3WyrgPnMXE4PrikuGhvzZWJTyvLEJqTWFGDmIb5zCPqRgmreOtFI2rhc5h
	c4Wiw02hweXcf40hpcPnitYNVdpI9QZoQaJfNc7u+Fox6YrA5PrIiQsk+cng0se0
	lEf8k2bHpMSZc6yUGTkk5w0DwQ+Lll80dK3Jy+xmH/0Lw1DVv/cfu1P+aIcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793611881; x=1793698281; bh=eGk/2mMfnkGeuf78mNWiJcJ29A1wU2ePi8G
	iCcYOANU=; b=HAv5JFbQrrj+wn46SJ6hYvoJQtTEi+cO61kS2zvO6EW/75D6uKC
	mOxKC1SyTYrugkxHITf1K/x6ofqTnN7y5Ns4qKEoRYNPEd5T37MYT8xsBmNol07E
	4rG2DNh6F/UjKQNu/UIgiXqCFvvukj+hgC4kc3fGohW6QYbeU783AoVvf4yzc3ie
	hGAjbL2vjd5UYXFOZU3UNCwU2hyc1m7T7UCBF/iECSmmS9Srm3PVqCUgyljp21AL
	3B/N/YCUk5xF8DXo4eZ8XT6+Mzq78n0/c8669NKec65UDBXPhtywx+fqvIXc6rVm
	3E1VdeGKaOJ17k44CW20+aSDjbQFR4y+YsA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793611881; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:kBt5sMUwBhoSjGeQb2cSk1VhZjxPxS50cldFrL5JQ2sGohv
	orqEipCWa0akvbankPc+7/wvn3Ju/rpsU79P4DGc7u+Wn19WNvEtKHGHcdHF3/y6
	s+0lJ6VWcrgE4JKFLnTPZ2MvyNANOuiuViAu4fi8Okqfu3qpOXbF3Zn7vqGoVR9j
	x04e7ICKBOYP9iOS2rHdqVfmTsbhV5itDOvjM2a5Wtdp0w/cerhCcMsH6w4YJ/DC
	MqgrHEkFI9ggSWbEcfLWbo81zAQOv3BfeU0Or4SpZ13iSfaHh+uKJWK/9Zilw3WX
	ouNKdk2xDxEJuvPlrEbWW6P3kyRVuhCTiYxc4Og==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:nASud3Piu+IK6uF71/4qV2owuB/dbml4zc0Eo39/EO4=:jtfxOAoSwZuYIWHmzdRlY/NzsMekQtq6ljwbrIPKrW4=;
X-ME-Sender: <xms:aVjoah5ele91KkbW-Lxkfu2V4ecrfhaYdiXoNTebMyMTI9t1DRYPVg>
    <xme:aVjoalzt_Bc3kU3zp5WmUvG-Xb2Xfw-4ZlaXz9ALKLJisLuJuy04y-NfzmLKglDzB
    5SpMO1F8W8zVuSYQGaKaqDGK135vLHsvwRxQNGcj4FD67iZMJuA-Pg>
X-ME-Received: <xmr:aVjoagxL1K8Cp_Q-Rc9OWkvqjQ38bnNyc1ZfsAscNM_2RP8equR29UU2TsnGFnS7G3siquZMeGKASMPSTyb4pkdV7isPS33W3J3l>
X-ME-Proxy-Cause: dmFkZTEQRYFiqPNxpKkzj5AH12t02cxSjCY+okDenV/49zcJNFmNPih83yuiai9aUTQPPF
    vgvDHk+12dh/OMbMA0JLkzygPt/y3Oz2T901pEZmPRk1oWIVCKEeX2nv22dkWZ1F9UUOLJ
    LuvQtYojlNQoOFtWeB6KGUaXSKYnNPFHdiY45JGqU5u6n9bCK7vYCsR15w7IK/W38P+XOX
    pQUg8W0ZWHvyY/akY8kiSrubSInVCe+LmYsaq2t4VuAI6JRuPOBau2aS5FFPNn4ONvcpHX
    efaDuPNvdLDjdgWQxbOq1ePh0D+STM6Ef7x3PpfT9FBmQKPmxdT1gB7Sqphl7mWUQFB2Zs
    hzdoTG9L4+5xdnGWUyQYJqAGy1Bdq0nmAbdtSGqImJJfvr52kWxNqOR642/IyyTjsTY+KG
    h4qBY1JtgA6FhOO6g5vcZLOfr7u8EsFi6xVKvDW8Uf3bWyEr99DBmBXZ7QTbgXnboOC1Aj
    6FYpsFnITxGPKSz7qbBbxqsvRbNzOrUBaHB22wwn7S/s9cX6xngjIxpiQvfXgNmfk9c3FW
    6XKQRdoeShv4d8w7RF6IawkDLwxOAKjcV1ZAn0P2XQb2MxwlczOZC1Mt4zVky6FJR3EPk4
    dd+MHHjYriAmhjOSE1gCsqaCLxfiFVMyhZx5M+bH5RlWun1oHDzK5pQiDMAg
X-ME-Proxy: <xmx:aVjoalzmgbXmm4e_ytnYaoMzRBipSSWMewzj5QY4KoLjxmUWYGKy_w>
    <xmx:aVjoaiZ6K1fxdY4KiFlIMCLGWNwGjR_kCivT_KgiJOyHveac5pfICQ>
    <xmx:aVjoauV_RcC-sIJEZ4lYm9-ZhU1Zgt2BcW0pPGrAym16snfwn_aynA>
    <xmx:aVjoaoh61CGpAexq9rcpS84B5mgBS8fqLResO6mmUHwPuRGSQ5aPAw>
    <xmx:aVjoapBTwZdivaRAEc_n2hlQcr9W1YoVxuOdvmjSjER_baTOxP-YR4wL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:31:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,  lucasseikioshiro@gmail.com,  K Jayatheerth
 <jayatheerthkulkarni2005@gmail.com>
Subject: Re: [GSoC Patch v7 0/8] add more path keys to git repo info
In-Reply-To: <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sun, 27 Sep 2026 17:14:12 +0530")
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
	<20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 02 Nov 2026 01:31:20 -0800
Message-ID: <xmqqh5hzlguv.fsf@gitster.g>
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

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Series adds keys to git repo info.
>
> Keys output paths of repository components:
> * path.toplevel: repository tree.
> * path.superproject-root: superproject tree from submodules.
> * path.hooks: repository hooks.
> * path.index: repository index.
> * path.grafts: repository grafts.
> * path.git-prefix: prefix offset.
> * path.cdup: relative path to top level from subdirectory.
>
> Keys support suffixes for format.
> Commits contain documentation and tests.
>
> fix a superproject bug where it now takes repo parameter
> instead of just depending on cwd.
>
> changes since v6:
> * The superproject bug fix is now a commit of its own.
> * The dead code in index is removed, we simply rely on the helper itself
>   and not write any new conditions.
> * cdup now works even when the worktree is outside the current working directory.

This unfortunately has seen no interest and no review since it was
posted for a full month.

Unless we see some volunteers to give it a review in a few weeks, I
will discard the topic out of my tree, as 'seen' has been crowded
with topics that have been collecting dust without getting many
reviews.

