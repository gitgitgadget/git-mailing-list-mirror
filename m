Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC01D26B
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="X55LMiXl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQ8dWKQk"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60FE9EDA
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 00:29:15 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id E633F3200AC7;
	Fri, 10 Nov 2023 03:29:14 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 10 Nov 2023 03:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1699604954; x=1699691354; bh=Yvt+7IbT0q334VnnCUKUC+zH7
	bNb/BTUUFiP63OgM70=; b=X55LMiXl3w1xO284ppqgfHy2p5vXchGzYf4OdjXfq
	Eny6KnpVLlBWvmmolIQW2G0lJ+z9hptkITrhTbArOHBus2b8eomCHjYM/DZJKKcN
	MufbaN4nuWRahl7wVjPXO7zKmqLKtpCYjsO+2pyji05ITV+CMrPyqUZpPdZeYCuE
	/jAwaZ+kQxeOTB+EMUdlsrDNcV6SzwIltOPgYxbOSAx9pCdlAk/PufgyOVVR0FWQ
	p5naGNDsLqVDmWrPRhIA1T2eATTemztL6mlwImt1XHOkZVcNDGK7Ls6YT3+/cDnR
	4qeVxeTVK5W2dO0VlbBi3951T1x/Go9aVrFUIk+YDclOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1699604954; x=1699691354; bh=Yvt+7IbT0q334VnnCUKUC+zH7bNb/BTUUFi
	P63OgM70=; b=lQ8dWKQk7BIZ5FBGSnmXZ1dsclnbDku7e0ZOKWxphGDimsDniLK
	purPr5jL6D6abj4dybnsdIaCvtfFv9lmA0Oryo5zqszTuYseZw1eLWua6bwmkx7U
	u8475+6ydJIjFz1AYH4l4l9Nb6JkBP5bDjUtt9JhTJMRpj3xxYnPrGDOzrF3Xaes
	uGwRd/Pt/FUOGfQineFAMt3tQpQm56LiHN7WGXg4pTjC4mhe3wmUbJ7+c0d0RqHy
	YzE0wjPIJtuf6fiaJ0FDs3UwcOeYSqsaRimk1Alw9QyF26YbXq09Su4GS6UQeqhT
	lxwdxtM1JrjAcAwtv/TQBCGYEjJSpe0ntfg==
X-ME-Sender: <xms:2ulNZdeYjj4_kMnz6YBU4WQ3awokzRXyNVdj4XEe7PjAbykIMg9Bf9U>
    <xme:2ulNZbNZMmD_Ke3ebm_MgAzy-OOQCUDerzE5q_vtEADXP-Z3ZnA4g3Xei9MfJAAD0
    aRy8nvTFwmCGZy6Jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvvddguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeeh
    hfeliefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:2ulNZWhbaxRh9fnh5j4z-49gFF-nWHPifqXOevfAYZHUM2xhdUg-Pg>
    <xmx:2ulNZW_HmN52jGgSz25e_D5nWkcT_fJk3XeWk27gb7ZiVB4l56hu8Q>
    <xmx:2ulNZZto0mI-Y9-9pM2-40GRtV2dXm2hbGj5vErUbNLKc_MrhSgQTQ>
    <xmx:2ulNZaWx8XRYGrMbb03cdCji2FRCWXnaSoObtGP5GIDWcNWDAxqmSQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 26D0715A0091; Fri, 10 Nov 2023 03:29:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <39db75f3-1496-49fc-a346-010ff8ef093c@app.fastmail.com>
In-Reply-To: <pull.1610.git.1699574277143.gitgitgadget@gmail.com>
References: <pull.1610.git.1699574277143.gitgitgadget@gmail.com>
Date: Fri, 10 Nov 2023 09:28:53 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Josh Soref" <gitgitgadget@gmail.com>
Cc: "Patrick Steinhardt" <ps@pks.im>, "Victoria Dye" <vdye@github.com>,
 git@vger.kernel.org
Subject: Re: [PATCH] glossary: add definitions for dereference & peel
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023, at 00:57, Victoria Dye via GitGitGadget wrote:
> +[[def_peel]]peel::
> +	Synonym for object <<def_dereference,dereference>>. Most commonly us=
ed
> +	in the context of tags, where it refers to the process of recursively
> +	dereferencing a <<def_tag_object,tag object>> until the result objec=
t's
> +	<<def_object_type,type>> is something other than "tag".

As a user I like that this is classified as a synonym. Because if I want=
ed
to ask StackOverflow about how to get to the commit that a tag points to
then I would use the term =E2=80=9Cdereference a tag=E2=80=9D.

--=20
Kristoffer Haugsbakk
