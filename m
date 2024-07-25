Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0161D225CE
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721914172; cv=none; b=NOKRpViN8YqCdMzkr90X94iU3ULfmn3gqmJhmoliLuR42DCSrznqXmOS1YzDRE1nawrhTR2ftNe6Lr0j383Wgqo1JvsDCkuNIAQ7xchHDjFiXUC1YFH1+wGe4qxBT1tv3Kkvgc+QV2lEHOJof5uu/+tzDYIlSAs4ySdwIQhzFfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721914172; c=relaxed/simple;
	bh=amebA5ZiRuUPpnez0m13zaDFnBGblEuc3fcHZAvTW34=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Orrkjj8drWpaEKrQ6gi6sm27Fh3CZf+2PgFhmOGY+Ui7TPqDfxCifMfK3+wmngsHOB1Wx+nHdHAeQNTxzPTrYb43R4zGInq8WAA2bcOUHiiqPfWxbXXzkK++0rq3Ker2NBBJXzVa/shodnGrWBBWFHF4dC4Dyg24vVC3vCWM4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=I27xmTLP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S5dUO31c; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="I27xmTLP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S5dUO31c"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 04F1F1140136;
	Thu, 25 Jul 2024 09:29:29 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute4.internal (MEProxy); Thu, 25 Jul 2024 09:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1721914169; x=1722000569; bh=amebA5ZiRuUPpnez0m13zaDFnBGblEuc
	3fcHZAvTW34=; b=I27xmTLPQWw+e1GWBZ8Yrg1KfOHjp3/12COJP5h5J4q/wW3w
	8CVY9mZ11rIWfTmA4X1X0yjYLdEAT5aoxPFQFiOK4aMvsiRYkxrpLb/qMpd7jFc1
	oDPWiNiaIoI6/fRVKe+XM+9X92/2uv03uHKXBSfALBS+WLbbUJq82a/Tis6TBj+G
	fPVXS4szHINnIVemA80oAJDxysifjiOI0ud/HznJolQwqz2mFvR4/4tFU+Lvk9gh
	LnESKY5DTlNLXzX77jNVfgITwmSahyFVq9NyOTWrvi15GUuSpIyLihn86jrAhoLb
	P/ylOa10mW7m4gbgr4SJ5hpDO800v463MtCXTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721914169; x=
	1722000569; bh=amebA5ZiRuUPpnez0m13zaDFnBGblEuc3fcHZAvTW34=; b=S
	5dUO31c1Iz1KGxt16d17MgxnsLKuo/BI87EoCKNmkCivGDXl/T3S5K5kVgEFZBM3
	Xr1XK6gEr5PAa5EXGafrJbtWkrItj1DM+I7wluKl2TAyynMa28TSvGkbUvInR00J
	dob35L6kjzSKRJ1nvBZuBh12KNZJeGG0Cx2xck1zR1N1wueePVWOfXIqFdU278Nq
	awRkFbva5pW2ZlNlRQ6lbiFOwhISZtw2pzcrO4XCVAbpPixCJw90Ft72khCv0KaM
	XNfDYJrHgwfPciR3fXakKwPY0Qg18gZ+c4X9OVwNKuPn36urszFe3XFTeebLhpGx
	ki8cz4ucrqrjkRGMncq3A==
X-ME-Sender: <xms:OFOiZmxnsE284hXj8QmO3-qn5N_Xv1722zEcd4fXfJ976vbGcz9WDKM>
    <xme:OFOiZiQtjdjKJT6ZVPUSZf431f0YUfGnjz8_MAfoQU1suWdzjW6w15rzts45T-bSU
    p9XklMSYzbZlqJJ6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieefgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhn
    sggprhgtphhtthhopedt
X-ME-Proxy: <xmx:OFOiZoXoOteaMen4LvaT6Xd_ptArnr_U0eLFCpQFm7sMSMTWr37S3A>
    <xmx:OFOiZsjqe4Yt9prtSXPMkKkCdZ-KLBn7qadBco3Iir2HYCGy6JN06g>
    <xmx:OFOiZoBrVrTTPn4xhJRyx5oA0NbEz62RopYSxvdRPLsM5zdgqHtQ7Q>
    <xmx:OFOiZtJhRwityHjQtJ2sD5wNv2WZTwrUeLSci6-vG0gMOiOQ1TYXQw>
    <xmx:OFOiZrNv991RmJFt-ly2r3ZFv26wIK8yzuDFCrLzhU8fTG_UacM-23Xk>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B13F415A0092; Thu, 25 Jul 2024 09:29:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e222c920-731c-4b8d-9d84-c9d6b56c4d27@app.fastmail.com>
In-Reply-To: <20240725093855.4201-2-chandrapratap3519@gmail.com>
References: <20240723143032.4261-1-chandrapratap3519@gmail.com>
 <20240725093855.4201-1-chandrapratap3519@gmail.com>
 <20240725093855.4201-2-chandrapratap3519@gmail.com>
Date: Thu, 25 Jul 2024 15:29:08 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Chandra Pratap" <chandrapratap3519@gmail.com>
Cc: "Patrick Steinhardt" <ps@pks.im>,
 "Christian Couder" <chriscool@tuxfamily.org>, git@vger.kernel.org
Subject: Re: [PATCH v6 1/7] reftable: remove unncessary curly braces in reftable/pq.c
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024, at 11:25, Chandra Pratap wrote:
> [=E2=80=A6]

s/unncessary/unnecessary/

(the subject line)

--=20
Kristoffer Haugsbakk

