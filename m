Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4966E1DEFDB
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729337854; cv=none; b=NyaNhlz+WgSvNPNBzpa/AxuJDsLk8Yx45epr4ihNIIRWisBKWWg4UB38Cz9LI63H3YK0vY6o0Wty//vqrs6diW7DK2x9f1Rg5YRd+faPbG97SdOqSk4qQwaiHu4qfZjb+13mi/RYHsl5uGLAlHvnYQ25ybr9MGJLbfOUwvv4Zy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729337854; c=relaxed/simple;
	bh=1fjzWSG+xp9YCEHG1PIVSPqI5GRW631kpuQhH89JlFc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=adVjnzyLLSwTLw305P/ewH9ktnxNCIQTTFgpCx6MlBjGP8E1cJrE8NHR3+lVuC5lyyGHqiHBVFMxpkiDnlP2RDCsMTmaKKkCzoCGt2ezLWHPXnq+YrPPoa3Jj+vF6fcfX5lsy6JpNXf2ILJS1TA2Pi7nSsgsL53rDY7wTaTdbDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FkCyZy1p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GMqU/BCp; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FkCyZy1p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GMqU/BCp"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 50EBA11400D5;
	Sat, 19 Oct 2024 07:37:31 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 19 Oct 2024 07:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729337851;
	 x=1729424251; bh=7qw0p9wRMdKBBRu8fFQoxKiJWuEr0WIcOf1IqZ6XwQ0=; b=
	FkCyZy1pKzhAO5Y5xHmDC9YTxlCDvD+Ozjxtb/cyV/kIgIU9kjk2FeL1ADDBWwcN
	VbADeEKPzKJS8c5nBiN3j7ntvIFA5O4GBKBhomXrCeNASKZhz1fuwdB9fs8VTgJu
	mh2Gnq9+vqLMM406LgroVvDm1uZnOs9/J7D43Tpp07QyqnPq1C5qPt2FTqwPs/b+
	TyQb3vWxutdNKTQrwSHe/IJiZ6zzcO1S7dtDWj6HayUFAx0tftbNcJ9/iH+betYm
	J/goNg7//j3f2/8YJp8XW3HHQotZ3HN/WeSFWfw1OTxanH5Hs8FieJhxSrOJqBeS
	5YjaHYrnYELN/KeDa+fP8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729337851; x=
	1729424251; bh=7qw0p9wRMdKBBRu8fFQoxKiJWuEr0WIcOf1IqZ6XwQ0=; b=G
	MqU/BCpTvzGbaVj0Aqa2ORrPYj9ZqsifpdzKpcIknYF45ueXAx2lXmCwDc3zEuzl
	4cLjdX6VdmT0UCnWLiKOD7QPi8VkNva5zdmNm214E3YoaY4suB68+ZYkBqMbeGH6
	HUXP3d1ibvCkVY0a34pqHWd4kr57G4Z5hinTrH2zn0Ccd23S988FStJP9UDrqUKC
	NtfenVxyLrIxUlvFSTEdEwUE2//nwK3o2eQAS2hFx9M8cToXCNYtTy7Ai0tUEmru
	/raht5D5708hNZeSSu/hlq8qgX/DwAxFf1jSwOLnnBjzL8f+ShfFB4HkUVO0Eg9f
	RwSP48NVbOFpqVZWEWgSA==
X-ME-Sender: <xms:-5kTZ06x8NVwtXHud9bMwaD4zGNY0-9sWZBf56xrLxegzLbMXN8Kp54>
    <xme:-5kTZ16upbZnrySRFsLp4GUzZC268p7bjXD3voXtwjdKJJX3Tx936HHbvo1Oty_IY
    H5k3-5HTdIhpyjEdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeugfelte
    ffjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrsghrrghh
    rghmrgguvghkuhhnlhgvhedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgih
    htghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-5kTZzcKPNkz3SD-cw_IraM83HIveEbba3qK_BCc0eKNjKZZT6_xcA>
    <xmx:-5kTZ5IvVdFTumL5j-Rc9dCzkVBpiItfHayMK9FRTlBTsUMXsO3myA>
    <xmx:-5kTZ4Ix3lwmStW6vpcDcUtoVXcKBUUaR7VRqG6XGiaypZiix7uxpg>
    <xmx:-5kTZ6x81At8VUndR1OHWxQTbNv1j644NF3Ev8T8wUb61jxOWQvQbA>
    <xmx:-5kTZ_Us-ZsyIw5P2N994BUFuvgZwgenTnJzQsZGkZtaQvqrku5UvWfC>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 16257780069; Sat, 19 Oct 2024 07:37:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 19 Oct 2024 13:36:32 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Samuel Adekunle Abraham" <abrahamadekunle50@gmail.com>
Message-Id: <0e393f0e-aa4b-479f-bedf-f4dad2256d02@app.fastmail.com>
In-Reply-To: <pull.1817.git.1729296853800.gitgitgadget@gmail.com>
References: <pull.1817.git.1729296853800.gitgitgadget@gmail.com>
Subject: Re: [PATCH] notes: teach the -e option to edit messages in editor
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Oct 19, 2024, at 02:14, Samuel Adekunle Abraham via GitGitGadget wrote:
>  builtin/notes.c  |  4 ++++
>  t/t3301-notes.sh | 29 +++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)

The documentation should be updated:

    Documentation/git-notes.txt

> diff --git a/builtin/notes.c b/builtin/notes.c
> index 8c26e455269..02cdfdf1c9d 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -489,6 +489,8 @@ static int add(int argc, const char **argv, const
> char *prefix)
>  		OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
>  			N_("reuse and edit specified note object"), PARSE_OPT_NONEG,
>  			parse_reedit_arg),
> +		OPT_BOOL('e', "edit", &d.use_editor,
> +			N_("edit note message in editor")),

The `add` subcommand does what I expect it to after some testing.

>  		OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
>  			N_("reuse specified note object"), PARSE_OPT_NONEG,
>  			parse_reuse_arg),
> @@ -667,6 +669,8 @@ static int append_edit(int argc, const char **argv,
> const char *prefix)
>  		OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
>  			N_("reuse specified note object"), PARSE_OPT_NONEG,
>  			parse_reuse_arg),
> +		OPT_BOOL('e', "edit", &d.use_editor,
> +			N_("edit note message in editor")),
>  		OPT_BOOL(0, "allow-empty", &allow_empty,
>  			N_("allow storing empty note")),
>  		OPT_CALLBACK_F(0, "separator", &separator,

Likewise for the `append` subcommand.

-- 
Kristoffer Haugsbakk

