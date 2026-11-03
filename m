Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709814;
	b=5mtYrFsJmElm46RzaE8QcsxMYPO91n1kP9VFknctqjJ/pGEF94kCzGNnt2zR2ZKgdC+4
	 d3vNcnyCx0mXSs2G3Jlur2ZMu6rzRsht5X6tJ3VycfR48xv4l7l16sfqYecDsXD/78smb
	 dnTC3MA+VmUdLT764CpFvAlGF4YlXvY0CLjllkFnDGpp8F0AZVRyOv4sgyenWPuF+rnQl
	 GPFwyTAWNVjEv9tME0SX3ivUQLOAPgac9b4fA6mJxC2PGK2806OISxRx9NKwgeNYDVCsQ
	 WFSuoXXumb11cvGJo4SEX/K71i/xW5RK3WliHAkM77N4FoUU5oTmTBq1Ah2YXERSdHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709814;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer;
	bh=kDo9XP4iHtmaS3AKOUtJitTTZAO5dHqnwYPSk8IhaOk=;
	b=x+5eEVIDmED0PBIV2LQUEs4lfNQJl87SbL04j4TQJoSCc41Idjh3e9Dx1Tjx1y7NBihs
	 +He9tv70ZYcChGkfClZ699h+jSGCew2++BgKGJb62QLodFBwW0rv2hahHO1SIDUPf8UcQ
	 PD1U3TlIDdLN4zQjObkS7nx3Dk0Pv6jcGWwJrgRBkGEhkvyAb9aqrNsmyuGWZYg6eP7a8
	 zveUX8haDqxtH6sGY8VM7FHe8GsK3hDWyhlIkzqWvC67C80PXBmgnwi1J4pRKzs4FRckf
	 CERXUWOzuJdUpSFZWIedkrszierW03P74aLTTStCb2wz94Uk+pL05f5Ew6ktOaXPkbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=otL6iJK8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="A9mO/njl";
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892A606A33C
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5892A606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=otL6iJK8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=A9mO/njl
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 72A801D001AF
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 07:43:33 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 03 Nov 2026 07:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793709813;
	 x=1793796213; bh=kDo9XP4iHtmaS3AKOUtJitTTZAO5dHqnwYPSk8IhaOk=; b=
	otL6iJK8nXb2n6E7X6JBrHScJvRkXhA8uyMEWIar6iOPt6tAysnPBJ3F7lj44lpW
	ibzt0iR0QMN8x36zG3qFP4LIOGjeqtlqmHpwuTUT9yle0dwYxqSXOXd6rEoWgV4u
	XxUKJGziEAUZqU70ZDjbRhPryTmLLx1+EYp0jgxEQG4I5E+g2lwT5v8XLGwKG+L5
	qg4Plb9eOI6kTaysFhOGePv8kxvz9mSqLYUJyKmYM0aZkgBdLJ3UERoBqBumXnm5
	6m9L3O9GwqVQPZ2goFps3/xxaHf5DnaNtK5Ab1ELgEk5eqIubtKAo1+Ye/rraa3Q
	saCw+/VpoWe1D6lwijRaAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793709813; x=
	1793796213; bh=kDo9XP4iHtmaS3AKOUtJitTTZAO5dHqnwYPSk8IhaOk=; b=A
	9mO/njlLwdoSrxCoZu5hchAuLj9QQzOPmUbBh7JSwppfu70c2/yNSg1fK2cgVoKQ
	EHN8dlmP+X9p4uk4MkakD6/Ynw1otwUoOWWfdpxxajY6xcvpiPk1BTqZqe7tgxwZ
	CA3RNRyTXlsrcmtN2i+rIjafA0D264JTBXSTYiEykMCUg6FIrUL+Uy+NgX8UHPSp
	YL1F42CN7euj42Ye3mTvauXDb38gMwd9TFwe4wlECQy7pzY75zdidIb/Dn8+0BM8
	mQoSPlvP0wQc/E8yF2/tVQZG3KY4DAqn1K3cTszH0lc9m2R7dND7LOFUkJqqS6VJ
	hHPIKtdzrnrS+As1spfHQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793709813; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:rTuKL/0OFj7wzoKg1aEnJrfTDM5/XLiMb1KHdXddPcvPxsD
	I2VRLi3lhKjTsLWehmK4NlroCwE9vr+VKyCGIzD64Aw8xyLw0d5CDdvijBmynZgI
	PSlMZRvI/zP0bhrqCgIrBe9AQOssDVWCTkbyCWQu/8SrRwUcnEhD0DoPSesCz+XT
	7g7G2c9vY3jN6rfWNp/a3wRFlavGUSGByt55N4tpKUUJUIy0DyjxqzG8Ru//UnPy
	PN92+gJO13MwK/M9D8a2e9vCJo2w61acGXmIT02C8ypqvIOQhSUnR60Zb7kZ2nvv
	IF9b4eEqqFIoWYu4A7J3ESjotXRObGu7h/sShzg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:R7c4bT4L/J2kfPA/MzXXO0yzZ09zCYjbFJflby6YDNI=:pYJKfqQSnuVzJrEmvNl2RHh5kvvnC5SnBuh/yryGORg=;
X-ME-Sender: <xms:9dbparaio_2RPbWuOGPWZJaMdpAbNmikFyDruhXPH9vP_Aofl_RnrA>
    <xme:9dbpah3DdYiBMCNkJokL8JNC9e4niVvlw9CK7mKAidCPwcXG_jwm3lbbbpXpoHWA3
    cPK-SUbKRTlfV9nXUvcM6m_nZiRnCBaram44g2luNMmlbVIQY_eKmc>
X-ME-Received: <xmr:9dbparUpqiCQRruvoBVA2ByPRlobsyf8oKeXc-DMmaAm5B690qgUcQ>
X-ME-Proxy-Cause: dmFkZTEkvssONOL3UdGQTa+2QEBwikzzpH85sNo03RExgc53HSjRpS4n4YWyE2VOMFwceX
    bGrJH7sX9TjCRjf1HoQF5ASgaNnRAF6tFR4mr613x2QLEgFQQM0fcC/UUwVmvLV6pWy5ol
    uyCCutInvJ6ydfsecxwui/22Ss2eStwSBflUEwet6shcuA/rMDZeGofpmLHeCs+xn6Y3rS
    q/J07BAc/AG/ycrOyGYW32qkzTmZ1kSX65EIPhjnB9HHSOtENk2FRM0SA99hswSy+rBTOC
    PkLpU6D/nsieZiZmpdQ3sj9PqfdqNp1ts9oJcuWuM5FmB8iPApmAGB0trw78lRFe0zIaZm
    0tQtagpgJ3AL1HTCPJ0wqyJ9C8sa6A0CRBdNzAjBOimDcYFqo/i3/isBuLhedMv/BlSG87
    wq2mqxLbA8fM4PbO3TZy9ZcDwco1oePzuE7bZA/fWYoUZEHaakkVVeXTxMMeiQe7kVIHTb
    czlyADU0DfTfCeHUq2puKXF1Z+nHEOP8nFfKxsqdvMMfl0JhWszDRZinaYnj89qJs+O/qO
    dXYCFibcqjpYEl8pARgrwJYnGyAHecrONglNuXpkHLixJRElp3/Tmf6Mu15gchjrbZmfhb
    kujwijGS91BybbDaeI/ke79PMO+AkU2C7Xsoim3C5hGjr/YI8BwlHDcPb0eA
X-ME-Proxy: <xmx:9dbparXjkhvyWXx7gA6enIWlPD_VGCi89LPK66bplk9kc6tMcnmrlA>
    <xmx:9dbpaqcNXQFnh7cQUWIt-k2kiAZqtbgkzAFmxwt33igij5ry0M0fFQ>
    <xmx:9dbpakVbaKGbc0Z58tOw0A-DQa3WPWzvPXB2KHY_CNJcKL0nX6tldg>
    <xmx:9dbpajfk3eK_HAu90PvfcxFNWrI2J9mVWcul3cg6L_cnTgg_5D_OMQ>
    <xmx:9dbpap2TDo_g3PIvP0qcGdgQEpTuMDMDTtdjqP7qtvtEI8Beo17UEOKG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 07:43:32 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 98ce3b4d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 12:43:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/3] builtin/grep: fix reading objects from wrong
 repository
Date: Tue, 03 Nov 2026 13:43:19 +0100
Message-Id: <20261103-pks-grep-recurse-submodule-v2-0-b00e3b3dc865@pks.im>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NSw6CMBBAr0K6dkxb0aIr72FYyHSAUflkCkRDu
 LsFL+DyJS/vzSqQMAV1SWYlNHHgro1gd4nC+t5WBOwjK6vtyeiDhv4ZoBLqQQhHCQRhLJrOjy8
 Cq41ziM6dU1Qx0AuV/N7it/zHUX4QDmtxNWoOQyef7T6Z1ftrNBnQ4FMqjpg5n5XFNcp7blS+L
 MsXEaurf9MAAAA=
X-Change-ID: 20261030-pks-grep-recurse-submodule-20177cc7794c
In-Reply-To: <20261030-pks-grep-recurse-submodule-v1-0-d4eb5c87d8fb@pks.im>
References: <20261030-pks-grep-recurse-submodule-v1-0-d4eb5c87d8fb@pks.im>
To: git@vger.kernel.org
Cc: Root <rootminus0x1@gmail.com>, Toon Claes <toon@iotcl.com>
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

Changes in v2:
  - Mention that this was released as part of Git 2.56.0.
  - Link to v1: https://patch.msgid.link/20261030-pks-grep-recurse-submodule-v1-0-d4eb5c87d8fb@pks.im

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

Range-diff versus v1:

1:  e9ffa0cdee5 ! 1:  46d165815b5 builtin/grep: read submodule trees via their repository
    @@ Commit message
         In the latter case we continue grepping in the submodule repository's
         object graph. Historically this used to work by linking that submodule's
         object directory into the main object database. But in 93cd344e34f
    -    (builtin/grep: stop registering submodule ODB as source, 2026-09-11) we
    -    stopped doing that and instead expect to read submodule objects via the
    -    submodule repository.
    +    (builtin/grep: stop registering submodule ODB as source, 2026-09-11),
    +    which was released as part of Git 2.56, we stopped doing that and
    +    instead expect to read submodule objects via the submodule repository.
     
         This logic is broken though: while we indeed know to read blobs via the
         submodule's object database, we didn't adapt trees in the same way. The
2:  dfe45977b15 = 2:  f7516e29f68 builtin/grep: read sparse directory trees via passed-in repository
3:  4b914d9d07d = 3:  dc19e6589d4 builtin/grep: read ".gitmodules" via passed-in repository

---
base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
change-id: 20261030-pks-grep-recurse-submodule-20177cc7794c

