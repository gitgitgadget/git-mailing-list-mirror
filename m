Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5145EE86
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706972612; cv=none; b=SozLZtZmZ7zXdxbEY2J+jPVHTNRVJjqM/1EWMf8j2yEuj3yOjFTd5vS4QTmQxP6niKtS5LncDCgwv1lV/BiZNH3SyL6r0bTiJf9Q//1uzb/S9J8ioNmawo02UbkPBqLDo1bmM9WFRy3KmMsxM75ktIxo7iUjuvNHrP+VmlgW6qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706972612; c=relaxed/simple;
	bh=ievX2Urjslzh80pUw6iDTc2nw4OkJFOIZirByEHJHbQ=;
	h=MIME-Version:Message-Id:Date:From:To:Subject:Content-Type; b=tqCP0VdWlIkKuCqVm9cgdXyxBYXreZ8LCAgVIKu8VdUb08qTFKEu6n8JcEIjRrP4OiDTYl2ruFO6igXTwnKDv1fMTmhhX8zPQHVzQ/yUzDuS/2hSxgW0CBz/4K13zsfE9R/GHS/+uKWM72mFllQUEkg2PaX0wPUzhfVqMXIMNms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=j+00U37v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zBFIOYkL; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="j+00U37v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zBFIOYkL"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 3E5101C0005B
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 10:03:29 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sat, 03 Feb 2024 10:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1706972608; x=1707059008; bh=ie
	vX2Urjslzh80pUw6iDTc2nw4OkJFOIZirByEHJHbQ=; b=j+00U37vLGIzy8F86N
	0S2kmXuThC0u4PSRE8/BcCI26hc5MiwHa1TmycNG7m9oLl3erHkA/x7HTG6QGUpC
	CVXkrrVwc7c3Z2558ZF/m64Z+umeXA1drewiUHRSIP9ovp9CBnSrO+WdvvYAO2Zv
	pz7lcHj8gkcW03gU8j+btwFlB33eVumC0VDImEBgU3muw8jPWVGJFoNUHCOZYNcq
	6QDe0K/P01IUZcicggrHPHsWvOt8ZIfMkucPkvARQ1aawnvDxdub7Xf/Miao743E
	Kl1mFsLRlDBGu0okgkl6K6ODFaxz9FldoYyoHKy2Fj4ZDENpayP9FM8jT6jlwoAt
	oIWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706972608; x=1707059008; bh=ievX2Urjslzh80pUw6iDTc2nw4Ok
	JFOIZirByEHJHbQ=; b=zBFIOYkLggl6Erai/Y7lZFktpuwv7FB277wLMjyVCMZz
	TK5YSyIMxzWJIKYy2xuMm9EV0hduQpQNNpvM5Gr6KDnP/munlMV/5jMLOahhDLxB
	zWKvM4lqe1xM30Hy2hwMWSxcHomhOVYQRTzemltHl0QF6Kz5PVqMKLvUl8lsCh6G
	E1LupcPRrDSAOwUH4sfeGcVOp91udQyTjVCxpL4ic1qX0xTJDpkWlwh6J4+iv1if
	VGNbXH/ySH+3Bg4a5SpnahTSzKFmJGClFxUwGRyYkp+R11Tp6hsH0MVrZHoxEpRJ
	6RJHJUiH/Rm0jJE8oMNAccaF3p6gZ8jvlqvfmCtPcg==
X-ME-Sender: <xms:wFW-ZVbflVu-QSxRdy0l-_Gl5ITiGCjpZwUhq8yaTxN4chBot-QlvpA>
    <xme:wFW-ZcZ3tWRIN5O88PxyIQlyhHujyyz4BdXi8PrTvv1qDfxMnqLgPhbgrBH-Wq0EH
    yS9rO2VAiXf6LwhTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduiedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    cujfgurhepofgfggfkfffhvffutgfgsehtqhertderreejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepuefhvdfgleeuledtgeehuefguedthefgtefg
    teeutefhledvleejffdvvdekfedunecuffhomhgrihhnpehgihhthhhusgdrtghomhdpgh
    hithdqshgtmhdrtghomhdpghhoohhglhgvrdgtohhmpdhmrghilhdqrghrtghhihhvvgdr
    tghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:wFW-ZX87yAAHPi9HQYho2pREvFkm1J7xKQgTJOwwbeaYttGCbQ7bPQ>
    <xmx:wFW-ZTrbrHorjgVlZXT6rgdp0hQiAvWhp2YGuJv8YnfCQmpxS-vLzQ>
    <xmx:wFW-ZQo4SyqZjR4A-qaLZdfEsg9aoOlAVm7Q0vf_sReC5I3xqibwLw>
    <xmx:wFW-ZXSpaxkMCo78ey8MNh4Noj1Ze1DqNW47Dfo9_6VqTzrlotXghpUEvjk>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9675F15A0092; Sat,  3 Feb 2024 10:03:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <339f17e1-c6a0-4859-aa5b-481dd6e0e91b@app.fastmail.com>
Date: Sat, 03 Feb 2024 16:02:49 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: git@vger.kernel.org
Subject: git-users: email list has become spam-drowned
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello

I know that this list has got nothing to do with git-scm (per se). But I
was recommended by Dscho to raise the issue here.[1]

Maybe someone who happens to be affiliated with git-users happens to
read this.

=E2=80=A0 1: from https://github.com/git/git-scm.com/issues/1828

=E2=80=94

According to https://git-scm.com/community

> There is also [Git user mailing
> list](https://groups.google.com/forum/?fromgroups#!forum/git-users) on
> Google Groups which is a nice place for beginners to ask about
> anything.

I am not allowed to access it. Just as well because this is apparently
what it looks like:
https://www.mail-archive.com/git-users@googlegroups.com/

The last legitimate thread (except for an email saying =E2=80=9Cbye, thi=
s list
is too spammy=E2=80=9D) was 2023-12-29.

--=20
Kristoffer Haugsbakk
