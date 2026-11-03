Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726196;
	b=EV3/NhKARjgfjj/IG4CwxD3oLvoIutQLD40H40PG851VqN/RCOt6MRMspclZAVMXVVqW
	 ImK/3Mu+/+65Z5KhkjIu6ipz6m5+aDhcbgJUCV8gu6QjtH0huhX3G+evCS5fj21sBK28z
	 FMVABqrHf5mwfxD6oHJIBaHNPKI2sMWk+uHadA0jS3OeGk29aeBG22FxhV4atffE6OZ8H
	 5LWjHFM+UZqEw5c1nCRD2l6FY+K9JLCc2lDvjn13GZ/O53uC6R6XkYT2amSngboB3ZNX+
	 vZL0MgxBDItwiZyyNzKIuIKuy7RA1Kn2Gkyz7yuTThYQVPGkpZhFhmfaZMGtHr9uVXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726196;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=Ljrc2mTRaOUcGrjy/RLIspxSXTPE2VA782FtQLaDL0Q=;
	b=GWtNMxQQhA87bwDuNyYTaGjiLE0d1LRE32CG0Wc/gflrLf7S6fB4yQ435yyEnGAZfYbb
	 19Mfsd6dPqm/dwUXSiTVLbsuw+awKzJyx2XB1CnlQH8mLGhz2DXNhTuvNK1CRxH0wctlr
	 1B9K4KSCln/SaTkGsz1CKSTZiaMULGUUr0I6lH9RBZ/XwbT+psESzZQLncbe+M7qupCwU
	 E8egzXHnpXacX+4bT8fzzXBk21is6I3lghG9g/Nxx0Bu0QAKJh4x2F/KcBQ7jabbjva/u
	 WNn7/S4KTYtYkgcv2fCs/7sBlgyuytElo2xLhioYE+f1T6Ak9m1M2gvFQhL6HyFQdVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=M8wFiktE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2ZZU+D0H;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEBE606A328
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 17:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CEBE606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=M8wFiktE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2ZZU+D0H
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D55C1400107
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:16:34 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 03 Nov 2026 12:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793726194;
	 x=1793812594; bh=Ljrc2mTRaOUcGrjy/RLIspxSXTPE2VA782FtQLaDL0Q=; b=
	M8wFiktEPWpr8gm6aaz+DV637iefsHeGmVvDL8x94lx7BKQ51cGQXOAyGK6ZC65W
	VuIKJGdonh5QNfM41dJ0fvVX7bQqmV5Ed1//FAcoJDHZp6UGwKm6+xQ7jnncXGdL
	cE5U61BLoDm4qXqAh5ZiR9e2CmehAFnIH9GpVTDUH0oKHxE33BOW6JTfCDPZ1PCY
	DeXmY3ZRGhCCXN7A7iw0icq1DYu93fgHilSNSpObJkS8TPqvrER+i2tHiZIhCY5t
	ZyW6TYKBsRbNo4IUjX3STsiL4wCdef8nK/S364H9+z0U07RhWSgZ1+lPiF77zxQS
	NSPdme2AAfs6TxulvbObxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793726194; x=
	1793812594; bh=Ljrc2mTRaOUcGrjy/RLIspxSXTPE2VA782FtQLaDL0Q=; b=2
	ZZU+D0HhcyI85TN0g2NzKZYBOjhHWmChR+vWT6KgnI7RcEycPfJ6uv6xE65PdM6h
	d7EZQpfbddu3bLZKphakO/IzP4Dk3PUigN1m724eG8GtCC5+r5hXZRXVAbGpTvMm
	5Zzzbzg/yuHbxpa96qoBGRe+c1p4+vNFdBs3Z8FyK2fUzml4wOiRG84G6XXrspf2
	5Uf8axCyE14wKCiQzEMtOBPt4L8JeCA0+XjO0l8cxCuNQGdJoTwK+I32atGKEqIl
	oM2Y8FgWMJU4mFpF+pkmcWNjfBx3AEZM6bjmHqiDQzoBevQEx/AGvXbr6f+5w1EL
	5C0ddozoDpstJgqxwOySQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793726194; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:u/LW7FAJ37Uninz+Tbzdc5mLatGijSZyQepsHFMtPGCzt4K
	inCdZpp/IzKOsE2rD1LGYmLZv5NaIdjmybMlQjkONdEeLkdMmFdGKHEU8/G3I3AW
	CpA+/FtikIigfD1Kdj92JXjVthhgvB8d5DipJ4qPpigoUvlnZxeYrHK7J9dLwJKv
	am/6EQFK9+ZU6TN91MdlweZ2dBVojfBqsymddynuEAk2iIeFh1HctH+WvBI0Rl0b
	C3DzZLmx4V4atqpSTW9Lg8RAVeDQRvR2jEQZH93jfLNogH30ehOXyiogPbR50azH
	ajRsKqk5KEUXZjvfaJ/KDRQ3eQi1cv7K2jIpP+w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7YxbQ/pObLvuTx14hhQXcvsc3utoGMtCJNWNGGuL4y8=:MPXNVmOo1Gj3a99xPhP0CX6trrEoeNYctURAul0+lFI=;
X-ME-Sender: <xms:8hbqarQjBcQbEovAOWT8pjh-I8zvqBTdTpHc431zZbattmuOT3BzUQ>
    <xme:8hbqanm_wvHSWL9mX_RIj-prKHRzXs5tE_obHlUfigDN2pDurF9ZmWOAniCX1LiM3
    23VthKF9ur_q47w0Bui14VPq_pFxmzxLn16Smrb5OS2iGZvN194ZApI>
X-ME-Proxy-Cause: dmFkZTGr/WGknaohP8CcxDklnfHe5AMb3Huh9W5zGJKKl82hD3UAwMKrisbVQ6sOHGVnYZ
    kcbtKbHtHk7HjERFig8o7yWO7zlvGXyj0t1viGYN+J3SoQqM41pEb5H8GrSALgni9Dafpb
    tp5n5U7GBSzyVHD0IXO/qIZpL8XH75n6o739CWumzECauhv30IP8DvWkByEEhT+/3M8TGC
    6sdDOFKkPzMXzV11ereq/X/mUlzVzGG4Iw9sXHUr3pdbKGLl6vn0MHEh0wbOwRBghge/Sb
    JM2QnDb1PLFG6MC3G0i70quzrAct7YA2YRtOYnbsbk95FUS4WRuul5DwMnhUyPVeYpIZo5
    u5R5iqo3jUQ7rk6n2n9JPOjuezOhkuLBU5ADy+MfEJnGuM6D/XIbmjfW/nMR6AEHuFOc/i
    dLK4eVQI3gsyAlUEZBRpmsIAayRJEN4IgjmgQFoiQN1ikY4HIqFc73cMRCBr3CVxkBLlWR
    gi1ihJ6TOT97TmbkJmyD8vi2aYRsApZBT80x5mSz25/zZlXde2QQEPz1oLgwihY9C8JenL
    7Ire7FgLcg0sITngSg6zbS+h7FFgYKnKKUsQySNg56H7FGsaSv4+9a1C4zisaYB0iPZMmZ
    ftxL/QxWKSX3F9z+K81YDn/FOCZ91/2H7pB5mVIIwWZhOk7hj5H061MfA6PA
X-ME-Proxy: <xmx:8hbqamtA6Et3Si9lTshZ0meUBc3Km35ZrwDABd6IPJ6P1pLuUSrshA>
    <xmx:8hbqajMTMhFG1DR39Sa4oqh1YKC33X3a0eVjXehOSQdndSOMCdDuxQ>
    <xmx:8hbqak1696YQICPNLhr6MJK2HzEI-UxlH8edogtygCvg-PK82nW6qQ>
    <xmx:8hbqavPBzf64CI-YvrOW_Vsre5mhWAffEpN5w5tEmakmLuozr1Vmnw>
    <xmx:8hbqaqPXfhskTajj1QA2hBaLaj29HPAdT9lk6jkqqUptcHVkE0VFfd7a>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6FAD578273B; Tue,  3 Nov 2026 12:16:34 -0500 (EST)
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
X-ThreadId: AEuMsLfrft43
Date: Tue, 03 Nov 2026 12:16:14 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <57e9dc76-9cab-48e7-95c6-88868137202d@app.fastmail.com>
In-Reply-To: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
Subject: Re: [PATCH] doc: git-diff: rewrite EXAMPLES section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>      * I'm not 100% sure about the table format, it does make it more
>        compact which is really nice and makes it much more readable, but on
>        an 80-character terminal there is some wrapping. One potential con is
>        that it means we can't include as many details about what the command
>        does. From my point of view that's a good thing because in a "cheat
>        sheet" format it's very important to be concise, and people can
>        always read the rest of the man page for the details.

While working on something else immediately after sending this,
I learned that Asciidoc has support for horizontal definition lists
which I think would make more sense than a table here.
And they can be easily changed to a vertical definition list by
just removing the [horizontal] if there's an issue in the future.
https://docs.asciidoctor.org/asciidoc/latest/lists/horizontal/ 
