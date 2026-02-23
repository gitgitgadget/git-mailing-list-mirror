Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE243191BD
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868803; cv=none; b=uHtsU+uDOyT5faJBgHIhFGKO9k6M4/drKOp0LapX05NjFqRAkWtpRNTVtKd01z3h7h8mYnRoTTwmuzmk0LYYnepP+hkLyObRTSPx/K59aTucSWHt9CmS7P3RvEN71c5IKHlZU7YD6PruZP3pbDxj7P90XUvXgJNUGGZh+W9jDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868803; c=relaxed/simple;
	bh=ggfCOEzqgiM4roqhnWVej6rhrAXm5CSdKlhuD0kAJ0c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=i5sPA/FPgtsu41xR0RazM3I4smJ+3H5YEnpUd/amCZhdAKsCxEj/JgzAMV92xzuoxXXv6+N9rDtA3qXtZ9w4pklrMKrsmxrVX+ljdRiqlBnRcOCSodhp4pukI7V3jRSI7BQrgHNcGRsx26xctkoC2jLiEkysk3XyPknOKDK/yJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RmSqrYo7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eRT0Gto1; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RmSqrYo7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eRT0Gto1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E322E14001B4;
	Mon, 23 Feb 2026 12:46:40 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 12:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771868800;
	 x=1771955200; bh=kM6r1mmLRzmCdBfaP+IA3mnZbqvPLm2G9gJWxyhBzV0=; b=
	RmSqrYo7/ycC3ye/tnPM5Y0SO9MFp1pHvRLqYis58F+S4Ry7q8Y+GUG3jCIExpI4
	U0g4ZBCneOTYOBSvV6OV80HL/2V4wHHhAlfHyxIjMC8qdNfu3YU1wAGRaBGqExbQ
	5vNtbbJc7fiE8mSOPiMoYoqCAazbhuGqPqBktFeJUZNmqvkzcCY+I/hVHTM9VM32
	7UP1JAbPitrOnA7xZgsQUuWhqQNblcxEg1d7WJ1uMcgK80n/i48M7pxbagi0izhX
	RQIuvFuB8YSYyGGKNnzgnMJOCJEgL0fg4GiHDBLCCzReG3WYgPV3I/1ywH3hoi6f
	AszHwb9uG9iVyfMjjdDXGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771868800; x=
	1771955200; bh=kM6r1mmLRzmCdBfaP+IA3mnZbqvPLm2G9gJWxyhBzV0=; b=e
	RT0Gto1KAgu81TlmcrLFYI2bRUDSigkTt3XRkhtpw9yvSXsSKJIy8lJrosjXfrIw
	1Q0XeylQUheglfZ2GWtHOp8fTR1cKtlkOBWA8GJnOWyOuCdZdHAkcHFDUGyfH6yu
	Tf30vRz91idi5fYbD/pvY0Xvxre4Bid0tROIdCMyygzoJ5jkZjq9KnBDVud8twAw
	wld9Z33kWAwACqkGWcOa/NFqVYHvYshM2o5yNQ3a5vepel7NN6nrv4P56q5uO9nO
	O+YHFCENnCbyeIGTgWUdDW8zGFuACSxjf8sm8+PUWTqo1d68XlrAcaFATc0wU6//
	3OwK3EuIeC686+N/OkjXw==
X-ME-Sender: <xms:gJKcaf5UNtcj25XRczkuy2DouArYOwTHZA809j3xYh_XNAPJ-tigw-U>
    <xme:gJKcafs3NewivzxlDALGpSjVcizhxrjpvIDiz2fwS8SEvXacyLXF3sqZCP-5STHLC
    CN0_mu9NqI7wcZX6DabQ_EMU_KoR4JCaGSya5FhCHX5Fv5JCCG01A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gJKcaX_z2C1k9vYT-RNd9lcnA_kcFz5tqdGVVLNmGZeEjo2CRMCWKg>
    <xmx:gJKcaVPx2JDb6qpDMDfCk5zSUFH1amvvEtCvsUNE6E21AMYK2_w8MQ>
    <xmx:gJKcaVEPyTzkrtblLgLIEUKHSPemnVg0JzMda8znHk_bfBo9fgjNYg>
    <xmx:gJKcaTSlBuZ6CZQQCYJ9fwxOBHEBRo-CfsJU8n96dDqCbC26zyq3fw>
    <xmx:gJKcaTTVjtYqMGNYr5a7SwxrQwtM6CoTY3rAJCdVjfWvmW67C5yvOKOK>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 26AA21EA006B; Mon, 23 Feb 2026 12:46:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AA44t9WoDwMk
Date: Mon, 23 Feb 2026 18:43:29 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Toon Claes" <toon@iotcl.com>
Message-Id: <3af8a2ba-dfe4-4e43-8f86-b03a0cbc3698@app.fastmail.com>
In-Reply-To: <20260223-kn-alternate-ref-dir-v8-5-0509c132a203@gmail.com>
References: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
 <20260223-kn-alternate-ref-dir-v8-5-0509c132a203@gmail.com>
Subject: Re: [PATCH v8 5/6] refs: allow reference location in refstorage config
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026, at 09:01, Karthik Nayak wrote:
>[snip]
>
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/config/extensions.adoc |  16 +++-
>  builtin/worktree.c                   |  34 ++++++++
>  refs.c                               |   6 +-
>  repository.c                         |   9 +-
>  repository.h                         |   8 +-
>  setup.c                              |  34 +++++++-
>  setup.h                              |   1 +
>  t/meson.build                        |   1 +
>  t/t1423-ref-backend.sh               | 159 ++++++++++++++++++++++++++=
+++++++++
>  9 files changed, 259 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/config/extensions.adoc
> b/Documentation/config/extensions.adoc
> index 532456644b..3e51da36d3 100644
> --- a/Documentation/config/extensions.adoc
> +++ b/Documentation/config/extensions.adoc
> @@ -57,10 +57,24 @@ For historical reasons, this extension is respected
> regardless of the
>  `core.repositoryFormatVersion` setting.
>
>  refStorage:::
> -	Specify the ref storage format to use. The acceptable values are:
> +	Specify the ref storage format and a corresponding payload. The value
> +	can be either a format name or a URI:
>  +
>  --
> +* A format name alone (e.g., `reftable` or `files`).
> +
> +* A URI format `<format>://<payload>` explicitly specifies both the
> +  format and payload (e.g., `reftable:///foo/bar`).
> +
> +Supported format names are:
> ++
>  include::../ref-storage-format.adoc[]

It looks like this causes list continuation (+) and the `;;` syntax to
appear in the HTML output of git-config(1).

    + files;; for loose files with packed-refs. ...

    + The payload is passed ...

According to `Documentation/doc-diff master seen`.

It looks like dropping the list continuations fixes it.

    Supported format names are:

    include::../ref-storage-format.adoc[]

    The payload is passed directly to the reference backend. For the fil=
es and
    [...]

Maybe because you are inside an open block? I don=E2=80=99t know.

> ++
> +The payload is passed directly to the reference backend. For the files
>[snip]
