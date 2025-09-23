Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913372D838E
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758652463; cv=none; b=PjlIfKSdl5IiwXYB5S4eCDO55SwRS41bJWdjLcE7wYN5kZoMr2wzE52KUIy0rlp5ZMj2tBz0MLE7+MtFaGGpG2QE4dtue0gdzkkn/0v/TQ3kyFJ8d9Fpm5NsWPf2iQld0zVvBc/rDZL4Ihtr7iEWf9fhMSlVipSVDlmTSaHZU3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758652463; c=relaxed/simple;
	bh=eaxSYAd+nFuFTt8ucGn7wiOA/P3Tm7SrTo9II8nA4FU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=mkWGlkCwRUBMkYhUqtR4w9Dp4Y4xMCUjCPVua+2UqFW//+spgS3oy1uYVpIMo0wYI6kf1phEXdF1H6Xj+JrFob9IUVGYBgfqvDVYe98Pd7njSkkKE83nQ/dcIqc9ycyqxJBJXsP9GXwUL6Ds4LyX+DA4hurjQvoG1MZy/ClkHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=azlsBJNu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l5xEcwN9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="azlsBJNu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l5xEcwN9"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A673E1400161;
	Tue, 23 Sep 2025 14:34:20 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 23 Sep 2025 14:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1758652460; x=
	1758738860; bh=CakqqS2BVLLv2xcxzCWDwGX7aTWNcXuuChVD7LUIpGI=; b=a
	zlsBJNukDjgNLuqSplhfyaXgU9wbW8wJZlDOW2Olss+q0g2psR1LTYi2SCiQNQbC
	BhEwO1A5VgZy1hvvivN/HuKGrVOHBaw9ENUFTyHAeIf5XTs9wT7DXcfbh58bF1mq
	OtCKlHrfc0B2pkKDB2Bg4Vhpu5F0EAAnYjRvHj1GRN87kFFNZqQ1KBQEM4mGeBu8
	M0WpZJYNVlvHQqyHtg9l8+jFaUwnHyfkrf9p0CAYJO8eWkSlK+dWvFiBcO5ZP8dA
	yBTlXNDadm23Ft7QlGiOzqcbfu1GrOsnSNeq57fRFJ6+VJe0fYNiFmTfCmdnBDi3
	EmSvy/B5rge46XOI6kU3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1758652460; x=1758738860; bh=CakqqS2BVLLv2xcxzCWDwGX7aTWN
	cXuuChVD7LUIpGI=; b=l5xEcwN9bcQDnxGHbhPBG+dRjrP3uzET+gJ2kS3XdkTO
	dEtBWkiRyyNJuRhVOmBn6mLu4LZ/iEjIUlSOx2RPvs+H6bRumNFq8AD+cTY+N6AV
	wAI2kHsgFmmLbhtoSNUM4IHOdGkvqc7WLF9HKvvc54UdtP9Oic+VM0Irjur8Yl+B
	/VCwdSuZBMoWzIDdQlmXB3RwKod8AF7YWSfPjG6PR1YutgxqSFSB/84zT62hq8te
	zVb3/Zoj8ecDjf+a+ivv5oUlk0DVNQESEWJyce5eug7BW9JSOenb4EXqhRIgGjU3
	02PbF/qHxXG799gZPiNb3bA8Gp4mLe24DMB7Q4bfVg==
X-ME-Sender: <xms:LOjSaNrEW0-m5Dy9VYeDV3KDyX76f96vw4dmtorlvPZHjdANX29iINo>
    <xme:LOjSaKeAdZ13lJP9yb3sq3oxPtYmJWXPsbTycXfZPY95VcEAZIMO9U_ZEGQl3mAst
    6DHOGX2yIq8PK2LfDEBEXREf0bWNNtCTtvG8R2GtBxC49JZzSOv8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhf
    fhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvqeenucggtffrrghtthgvrhhnpeffkefgleevjefhieetieekieejuefgleduueevueel
    ieeuiedukeeihfdvtdffueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrse
    hfrhgvvgdrfhhrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LOjSaIUW6cu8ws-YSPEhzUtMlNfYlpxBprfOY9TzWxnxd9tzQXTfpA>
    <xmx:LOjSaKhd8HyCqN6jX1TGhuehi7WfIN-LuuoWuGHr6H2T3RArH00sVg>
    <xmx:LOjSaD9OIxfSXg4vAjp6qyzCB8vjKu32zYmCOoTtrJgQUluXvjs2dA>
    <xmx:LOjSaEDWAPSUSP0LmH6q-UlQDg97c4kr7_K27Mnls7-uT27PWqEPWg>
    <xmx:LOjSaNOZoahy-EZ5iXrO_n3B1PFZr8pWbgMlWyIe992cAHreboIUBGpb>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 51CFB1EA006B; Tue, 23 Sep 2025 14:34:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Sep 2025 20:34:00 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <a6e4e995-fc19-465d-bd7a-c002bc0db31f@app.fastmail.com>
Subject: doc: config/extensions.adoc: line continuation syntax error
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

See the HTML output on e.g. latest `master` (ca2559c1 (The tenth batch,
2025-09-18)) for `git-config.adoc`:

    + For historical reasons, this extension is respected regardless of =
the core.repositoryFormatVersion setting.

The context is a definition item `worktreeConfig` where this is the
second paragraph following a bullet list.  So I thought maybe you can
use:

    --
    <bullets>
    --

Here.  But we=E2=80=99re already inside a `--` block.  So apparently we =
can=E2=80=99t do
that.  I also tried a fair amount of permutations of using or not using
line continuation in this context.

This particular level of nesting seems tricky to resolve with Asciidoc.
Maybe someone can figure it out.  So before I forget...

Thanks

(The Cc is because he is one of the Asciidoc experts as a FYI only)

--=20
Kristoffer
