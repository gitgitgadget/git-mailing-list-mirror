Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121F1FCC51
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702235; cv=none; b=s2f1JF+r1yxhNFTQlBs9BN2c4KjWT/+0NQGkiEfa6GFgMO4gPaNv6EdaAFjtNe2afC3g7PQaR8QYNteXoAbpNG2yyAnJ7IJORNwzIM2LGrgnlUcUVA7ymZ3UgQfGDNHPHaNW5ez3JN+fJz1iod1Le5vxnIBiBxv5Ihrbh1iy9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702235; c=relaxed/simple;
	bh=KMHhrC/Y1C1UtO4sQ3EgTKs2ZIqeApv9yXFXwGGcrUo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tyVkzHn9mu1OZ0cZM1XlD2ffltvZCS/nKgFjxSsT+HNKQGRfGFJx5WXirtD84/lbFif+fg9KdntTY8TXU6KBciOngYm6puAX+PB+bGcmsYxy/49J10/eNy4VIvPSI/eNRJu8YbTWMXT+yg8go20BNaFaTV6eYpm8VrzaVquWdf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Zcx0XrD6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pw5JdbvN; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Zcx0XrD6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pw5JdbvN"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 839C81380280;
	Wed, 23 Oct 2024 12:50:32 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 23 Oct 2024 12:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729702232;
	 x=1729788632; bh=TLO6kqHEYRfv1KSr5i2kBWoY/+4/GO8f4Sb08c3S2FI=; b=
	Zcx0XrD6vmfk0Cami0sCAos5174OgvT1rjL+QYrBEiE/mXtlXhVMSwtqwPm6Qu/Q
	p7t15iKZ3QQOJp61SBIZC9jZaDFjfswJRYKV13pxm2BxRS8/KA06wfBvtDx73N6Q
	JEn0UccjcSpbQxMZ3thXs7g0EDY+g2U0Cb8l37Rc1zLRwdk66cJEZvSKxkwnR9If
	PzJ/fznsL5sQik0iC8Qc1LWMzI1dOGtdXng1eZJe0pTLGTCh3id6uuUsDMgYvnNJ
	AEaqRCULpE4GdZ/aXSj+HcHGG+Cd6c6atBfX+Rdt2hWTN+KKOqF70ZNOzYEBIF2Z
	DvgnNaGdBimcTZDXKOWoZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729702232; x=
	1729788632; bh=TLO6kqHEYRfv1KSr5i2kBWoY/+4/GO8f4Sb08c3S2FI=; b=P
	w5JdbvNklh1h2BJ+NkPpkDkgs1YbZcjejSGs4FG4zh9ZpVVHjwkMBO5BXbJuZSF2
	bMQNxz6J9FoYx2GYoeGso+CMEerUHexr5g5bWtttII8uNOK4SJhvEhYMUa/G7TJm
	TZ2f4f3iV+ap7n/XW3/PmLWdoJYSF463yoGc0V9RqLnKV+NbPptmm77JxTNiplRu
	hGCwd4i/sOAPJ9ARHxEMiZ4VOY68xo1K4Zhk/8BJIs36ObSaeC1Wwy+khei71Bs7
	omK7YMZlegnWt9k0ys+0StPGsZyqwDFQyJpEw1rFmkv7RbnukAEEAouRyCemb76t
	ggnZBtei94oyFKuCiTITw==
X-ME-Sender: <xms:VykZZzgO1f43QTYlK5kjmz-lHDF3OpQkSxMkddl4qTr48Vw6vS8yX8U>
    <xme:VykZZwB6E9-tlTN8uCNjaaTvfdHdRdVJ8D4bmES7VkQ4XbDSwnq92bfAgIQ030k2V
    SoEGBZ5vnhbJCHSPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpeegtdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeeluefgle
    etffejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepsggvnhgtvg
    esfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehfvghrughinh
    grnhguhidrsggvnhgtvgesthhtkhdrvghlthgvrdhhuhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:VykZZzFKR-qrFWPYgz_-EMVQljn8z25ytav1wUAaYg19yOeqokBq3A>
    <xmx:VykZZwQJEvWmo_cWFDMnHCbhsz6bqE9qRHAfymsgTfn2oySXR38AtQ>
    <xmx:VykZZwwzu5Ck4YOJ6MElHp_gQ9W7oCwcyTbjsRlPN4yq2upVjWYZpA>
    <xmx:VykZZ24giMfeH5p0XB71LaLrZcxi_3lmvi4jqWc3v5EozY7bWRK-4w>
    <xmx:WCkZZ_kgkUC_TT7BdqEA_dzfhF3G5ab9NEft1qeL0r16WZ62zsSZ2uey>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A2909780068; Wed, 23 Oct 2024 12:50:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 18:50:02 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>, git@vger.kernel.org
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Karthik Nayak" <karthik.188@gmail.com>, "Taylor Blau" <me@ttaylorr.com>,
 ferdinandy.bence@ttk.elte.hu
Message-Id: <d715d76b-1dd2-46e7-a16b-b2cf30940470@app.fastmail.com>
In-Reply-To: <20241023153736.257733-8-bence@ferdinandy.com>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
 <20241023153736.257733-8-bence@ferdinandy.com>
Subject: Re: [PATCH v12 7/8] fetch: set remote/HEAD if it does not exist
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 23, 2024, at 17:36, Bence Ferdinandy wrote:
> If the user has remote/HEAD set already and it looks like it has changed
> on the server, then print a message, otherwise set it if we can.
> Silently pass if the user already has the same remote/HEAD set as
> reported by the server or if we encounter any errors along the way.
>
> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
> ---
>
> Notes:
>     v3: - does not rely on remote set-head anymore so it only authenticates
>         once
>         - uses the new REF_CREATE_ONLY to atomically check if the ref exists
>           and only write it if it doesn't
>         - in all other cases the maximum it does is print a warning
>
>     v4: - instead of the discarded REF_CREATE_ONLY, it uses the existing,
>           but updated transaction api to request a silent create only
>         - it now uses the atomic before_target to determine reporting
>         - refactored for legibility
>
>     v5: - instead of printing a not too useful message, it now fails
>           silently, this in line with the objective to only set up
>           remote/HEAD automatically if the right thing is trivial, for
>           everything else there is remote set-head
>         - fixed all failing tests
>         - added two new tests, one for checking if remote/HEAD is set to the
>           correct one, and one to test that we do not override remote/HEAD
>           if it has changed on the server from what we have locally
>
>     v6: - fixed style issues and unintended extra empty line
>         - updated function call with bool to int from previous patch's
>           change
>         - removed calls to error(...) inherited from builtin/remote.c so we
>           actually fail silently
>         - set the test for remote set-head --auto to the correct value here,
>           which was previously erronously set in the remote set-head patch
>
>     v7: - no change
>
>     v8: - changed logmsg in call to refs_update_symref from "remote
>           set-head" to "fetch"
>
>     v9: - follow through with refs_update_symref_extended
>         - fix test errors uncovered by the new patch
>
>     v10: no change
>
>     v11: fixed some memory leaks
>
>     v12: no change

I think it would be better to reverse-order these patch changelog
comments so that the newest is on top/first.  (for next time)

Thanks for the careful versioning here.

-- 
Kristoffer Haugsbakk
