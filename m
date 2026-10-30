Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355714;
	b=YrvnoULasingEJR8Dq74cHAxTYv/vy0DC0KAkNYAY3Zbgl0YgauFMVeeS5jTUB1sNw0B
	 KbB0WJnhaPLxiOqHH50LNGsBJ6rmvFy68TsqJtg96Bfn3/eNmemhuMv2lDFo3Yiu/EJWy
	 yzoAgcW1ql2NFQlCWr7O7yRu7z+qpvcyZR/B6D397hbVqQbi4ehi+8xGEJe87gy3AKvJl
	 xuCnEf85T0x5mJuvThbDmZZBjZ04UY+9lV9QDKQ57GklBvM7O8YSRrgRWIiBgvjtk++q5
	 dyGM8SzJSe56NLjQbYxfLuSz+EdAwlvp/9eOrgyk8Q+dPw7hFslk43hlwXSWTiaAHcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355714;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=xqERdDXqiDdaprDRfs+cwZBkB7/5PhkO+XlLFWaLWSs=;
	b=CMQCeWBm1tAXPOHx4KWTwmaUvLO9MpRIBDf9T54ayxfIEP7tkg6LA6wMCGEDvay+LC/8
	 VeluB131+k1Mgfg/R2oP1goK7EhQVlV5IHMpJoDBNvhgaIqLv0VjPOn9S9ppjHNIP9Ucg
	 phQV59FMaYDE+nvG0QMga8ym+9zTrymuBIKIgYpcGPl9T4kpWhBWoD/Onbx20ldgzVare
	 yNU0qfIoulB/6FEbeM/ipRiaHlv1PyMvqRFwYVgeaKDxQwQDTiNOVk0sPRTKGEQNTGLCF
	 FFtaAmyO8PN3DGunHBuQPVjjVsVKDUOxUeD1FmQZSKtqY3HFSyU+q93GyT3Ns2jW0Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=SP8oLQcK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WAKtQYXW;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B0C606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09B0C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=SP8oLQcK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WAKtQYXW
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 61BFC1D000A7
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 06:21:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 30 Oct 2026 06:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1793355713; x=1793442113; bh=xqERdDXqiD
	daprDRfs+cwZBkB7/5PhkO+XlLFWaLWSs=; b=SP8oLQcK4FlrKV1iHLwSYpx1LH
	RRDAKwd9KNFa9RO2Xc4/umYZOjIT0Sjrzhfo0S67uCNf52w9XSxq2YfQYWgXUH4w
	xPmvKGGtvAJiR85zBYQd5Q5tBzdPY/qy/VpeG1/BfBWo/167+CvYTJaLHKMR6wo+
	hYXmNZH1N7WQYF3GoUYr32Bt7flhgYUHCzN4DX4dsD4jA7ynVnf1DGOXLz6kddW9
	um35ntFFUcbbyC46O/MAJrVtwlqy+ZwZMUg0atrgJ9G5peHRMNSLOa75fbarzgqR
	5UjCX1UJFEeaP58XLG08CfAnzVf/lNQbdlHn/aQEUz7T5lNnyOdbD9MwDfMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1793355713; x=1793442113; bh=xqERdDXqiDdaprDRfs+cwZBkB7/5
	PhkO+XlLFWaLWSs=; b=WAKtQYXW6sciFWbIVaQWTaFaFO5E6p5OBGMKOlPKl5gY
	dcyBmtn4Afb6ZgPfGMTLziLIG08nS5e0OCATHnXvGSlUo/+79k7myc30NHN7z6h/
	j+DeO0zx9mTpEpZgbb5Hj76NGmNNPaqY1gkoaR5dED0zNqiaawCsN7uRsvnlbIYz
	EpB4vY4OsLyb/2caK9Iqrv7Y/SDKaP1fgTpq+TR0AgGg+Aihf6z/+xT4CULkGwVA
	RP1+w660JY0yFUie4+dhHBseXCxxnQyOAj5v6Rj5ROSDwKI0OVrYTfC6Pa+bWy0v
	dGMSoTL5AbGZmMH4UoHh8rZFcBUxu1+4kQk4IiKTTw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793355713; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CwxYwigTsh+XNa37MJw9oq8qHGKdJu/OCo6BNaKxChFneg8
	mv5ioz76/ls5We3/X9lPkBVsHPDmELlXTQRFC3CUmWdltJMuob2gC+XKzyr4gF8X
	zqCl1oUOB4jh9lG0wk3avvi8Uofi2TAJbDB2yEZ430ou+ygQXtJ2sZW23ZyWl9hn
	Z/oXACYPqUgDqtMsXzZfKEoWFAaxdBk1IigamMes69xbLxDV7+nrDwu4qKqM2uTU
	t8rqV8w9WojZ4uSJxoFPovEe0Lk1VPLbWmF3RES2JFavmLy3JIU4onwrzKy2C7Dg
	G2TkvyrbmJSKqe7XzHNobEIQ3o+4RHKEt4JcF4w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:WqF6i4SjosS11Y5nnRxpP/tAM+v0C/X6NydBTxWl9c4=:cjb0AIKOYjhOXlXyHdn6lk0N/Ro2A3SIW891rInfGl8=;
X-ME-Sender: <xms:wW_kaosOB8FBp8i7D-IJsSx740OEcCanUiryzpPkZzGAIIRBnj5GRA>
    <xme:wW_kareyyVHRfSvvN86hboGaZe-O3hxdIGSffbJSj1OoKxZE4Qo7dcfkRrdtzkmy1
    x_XGat7FVOB2CrF7UV7IZYdMkGm2nWLfei04G6E7ri9xfYx1YE7sw>
X-ME-Received: <xmr:wW_kahZ4brChfaIVLK5x627A2gA9kyyrtI_0LkdHwXrH9Wh9NVdftMDdhxZecYtLvRvKDQ>
X-ME-Proxy-Cause: dmFkZTEC73ZefkKUjYYbijwiAxgo6QVAVe9TPb07Cmt35nI0YT11bIrnqnwjmBRTSMCnNG
    Ek9ur9/sIBlJiO1raRuqxkR5YYynP7kKOJkOlclUO3YsHwIk+Dkkam6HubvOR9AW/IquKr
    MagUtqWALp9rKd7jzF4858CMsRbEp25e1z636YGaPoQBOduFfU7VIjwLM+sEA2UrSHVp7v
    hskSV9hFttv4y75Uny+ftEq+lbqTFEEU/qJEFV30xRGwR1q7Hs8XtyVmvVx2LvONE1dHGM
    mx/uDXzeT9A/Kuw/8LLIG7oBjEdzo+cXEcF5UYPB/Sqy6q3hvXAAjzLghrPzK7biTvr3OX
    jl9osVVUpgwLR8dKPc0XP6bLBm5vvSder7r4FnJ+xTfdRxqFyym2iK0WMCnOmoHbhLmPcw
    fdVUYVDcPGCQrHhQzy562zXxIe6gbWYbfmOp+40DjtyJe4fH+6ueEscboPYmsI3E2bBnZe
    RbaOH/HO5DpJ9DZCi/1ORgvPOANiSoPRyHcNVKaCgN/lt6ALvgsPeB5R6vepgo8O92DBh9
    Qx6TJiTY6CDOXuz4ALC8qzs8eM3T3YFs0oKyUvieAuXvXlJHEf2vgM7OlsRMhuuIlD0Kcu
    /mnDVjlbQg+EAylhTk6Y5SvR+1KJPodd73EbVjKycfKHmy2NosVVWdQhLSYw
X-ME-Proxy: <xmx:wW_kamUuD08JlU7TT7g6_DBenYt56u7Zg0uufUjTsCAhvp9yNYykFg>
    <xmx:wW_karj8B5ImYMSWQMWKQTn2bWRM6YiMSD0L0358OsHEktYCIe6SaA>
    <xmx:wW_kasXVq4FTzRMzC7Q2oJaIRusUCH7Hd6P5LDyab_oy3bkmx6CswA>
    <xmx:wW_kaqO1aVu0X8fc-TMgEI5ENdYGB13Gn3WCX7SUqEclHNb_34vpMA>
    <xmx:wW_kaje6ZkNA-3Fqi6UlO8RMiX77rNPWeJKD8rflnDyw8pPUBVZFUiUA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 06:21:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 002180d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Oct 2026 10:21:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] builtin/grep: fix reading objects from wrong
 repository
Date: Fri, 30 Oct 2026 11:21:46 +0100
Message-Id: <20261030-pks-grep-recurse-submodule-v1-0-d4eb5c87d8fb@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMWwrCMBBG4a2UeXYgicWgWxEf6vS3xksbZowUS
 vdu1McPDmchgyYYHZqFFO9kaRor/KYhuXbjAE59NQUXdt5tHee78aDIrJCiBrZyfk59eYCD8zG
 KxLhvheogKy5p/s2Pp79rfIO8vkda1w87sK4gfgAAAA==
X-Change-ID: 20261030-pks-grep-recurse-submodule-20177cc7794c
To: git@vger.kernel.org
Cc: Root <rootminus0x1@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this small patch series fixes the bug reported in [1], where doing `git
grep --recurse-submodules` with nested submodule trees fails to read the
trees. The only patch needed here is the first one, the other patches
are only belt-and-suspenders as I've been checking whether we use the
wrong repository anywhere else.

At the end of this patch series we only use `the_repository` in
`cmd_grep()` itself. Ideally we'd adapt "builtin/grep.c" to get rid of
`the_repository` altogether, but unfortunately it's a bit on the
involved side as we also have to worry about the case where git-grep(1)
is executed outside of a repository with "--no-index". So I skipped that
refactoring for now.

The patch is based on v2.56.0 so that it can be easily backported.

Thanks!

Patrick

[1]: <CAMtVYEjWd2XwJpXdk3PV2jbNdoOaqS3x+08EMu5byy55RxfRmA@mail.gmail.com>

---
Patrick Steinhardt (3):
      builtin/grep: read submodule trees via their repository
      builtin/grep: read sparse directory trees via passed-in repository
      builtin/grep: read ".gitmodules" via passed-in repository

 builtin/grep.c                     |  6 +++---
 t/t7814-grep-recurse-submodules.sh | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)


---
base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
change-id: 20261030-pks-grep-recurse-submodule-20177cc7794c

