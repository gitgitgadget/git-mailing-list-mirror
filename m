Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA2208A4
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650074; cv=none; b=ELw0tc+zrfpst40Yl5LgUCLirTiS5XKXUjK7ZXHY59oD4gmlE6SNvPmYGZkOHPDGdjsVLNSKD9Og1F1TqbwQCmblPq3+LDfKUhHwnRuVIVk0rzvxa7jzBteWQTzlVCvMFTYUHKY4R+GNNrfEO3kqrNBEBOY8xigIPehIiqqOM9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650074; c=relaxed/simple;
	bh=/Q5DPEUH70hTVsY4KyccvkJm2Ok0Qxz+JsTivBoCTxo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=huLcT9bigN1ZeT8I6OKsB/iKLr5WghYoZyD7GgP4zsELCQDDbxWJ9QveY13JCrm2p5d1zXh+j3FhlEzibIblrjycTy7pZCvrGFb0KISAtj80gV7GcM81cqIgjhYKaP4WdttZ73KYOaHNNY2hvQIwdA4+QqKzKAb/xoTrnZUdlNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=WgnbjQiG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dZcGZzrA; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="WgnbjQiG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dZcGZzrA"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 9ECE25C008F;
	Fri, 19 Jan 2024 02:41:11 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 19 Jan 2024 02:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705650071; x=1705736471; bh=/Q5DPEUH70hTVsY4KyccvkJm2Ok0Qxz+
	JsTivBoCTxo=; b=WgnbjQiGP2UbDUUOXBPqf2vpE+L8YU/dCPFZ0432V5zO06Z1
	DHH3LYjf0VxCCsspPtcJrYRl1F2Fd9eEDrveXGjOgwsxq41PmqUs39bWwdTd6ofS
	Qm+KrLosTmv+4e6UhFHUbI3HD8Jjyl2VX9SPdoRLZszyXK3YysXtP57v29kwXt8T
	q7xqefeQZusINVYfJnRsAVwg74+a/j8sBBqCmdC1+khLZ6ZXehufpBg/WweNrhbU
	SJzIATWbHDdHFWNhvJr+8LbDwFPuBYQ6jXJj/YcO5sXdjKiYKBwn117+nZqrSS+/
	U0HbXLeLKKFIv4P2Lq9Jp0xvaV1qtDzQ321b4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705650071; x=
	1705736471; bh=/Q5DPEUH70hTVsY4KyccvkJm2Ok0Qxz+JsTivBoCTxo=; b=d
	ZcGZzrAInXSMra7t50dH23mjv8gNBGU43VRzoUh8rkiUaBtn/P13XfzY6h2gXuTB
	NFBfHLlK2YZRG5PST1+E+nLa/A/kP6x/YBXbD5lwwOCD+kiM1//3IshggkhbwkTu
	Jpk581OV0L4649i4Sol0QvX5riqpazTGwWV93OYEaomz7PgWC3nyTNG2lmlFdMwS
	7834G3A/dr5mOyfv/8tTjTcskuT2bmpEz7FD5ZmNWHb3wmmFW54vL1QCXL912KzA
	nOWD0iLDtcRElpJQtSJMOktX0NzIJ4kCqipmyD6vMsGybmi7Ot1WVb+GmaYUCB7k
	Qq19nFSczXAI7PLVCKKcw==
X-ME-Sender: <xms:lyeqZQzSd6sLf3DsjdTbpEx-9MWCtdiHNiDEyjJMp2JlgKJ4bT2BatI>
    <xme:lyeqZURTwfuHZZpEE-ij4RFSkrJS4yeVa0_q6xe6XnEWpe9RwLcI-dlHdWM6tHl2F
    d3FZJcn6ltBpurreQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeeh
    hfeliefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:lyeqZSXkL5S3PSIH-ZUX2XVOl3yq03EM9Ad-m4FimLnzj3tOLngBwQ>
    <xmx:lyeqZejNXMx2xSX7B-mmwp7K0Kyt2h4SNGQeIfYQm31n4PWJXEKX_w>
    <xmx:lyeqZSDgpaK7yHCDCw2nJwvsc799Nw7QngoT3c1J41PXenm1bBmR8w>
    <xmx:lyeqZdO77FAI2e1QRG2HgyJ9I7BtMWLJ1ZDsynYKde2B2FxtzJsw1Q>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 56C0F15A0092; Fri, 19 Jan 2024 02:41:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7f0864ad-c846-42a6-8ddc-85d6be58a4ee@app.fastmail.com>
In-Reply-To: <ZaoUOPsze7rhtT2M@tanuki>
References: <cover.1697660181.git.code@khaugsbakk.name>
 <cover.1705267839.git.code@khaugsbakk.name>
 <32e5ec7d866ff8fd26554b325812c6e19cb65126.1705267839.git.code@khaugsbakk.name>
 <ZaoUOPsze7rhtT2M@tanuki>
Date: Fri, 19 Jan 2024 08:40:51 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, stolee@gmail.com,
 "Eric Sunshine" <sunshine@sunshineco.com>, "Taylor Blau" <me@ttaylorr.com>,
 "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] config: factor out global config file retrieval
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024, at 07:18, Patrick Steinhardt wrote:
> But second, I think that the new function you introduce here has the
> same issue as the old function that you refactored in the preceding
> patch: `git_config_global()` isn't very descriptive, and it is also
> inconsistent the new `git_config_global_paths()`. I'd propose to name
> the new function something like `git_config_global_preferred_path()` or
> `git_config_global_path()`.

The choice of `git_config_global` is mostly motivated by it working the
same way as `git_config_system`:

```
given_config_source.file =3D git_system_config();
[=E2=80=A6]
given_config_source.file =3D git_global_config();
```

(The extra logic imposed by XDG for =E2=80=9Cglobal=E2=80=9D is implied =
by `man git
config`. I don=E2=80=99t know what the guidelines are for spelling that =
out or not
in the internal functions.)

Your suggestion makes sense. But should `git_system_config` be renamed as
well?

--=20
Kristoffer Haugsbakk
