Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D7C8FE
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731890133; cv=none; b=De1IBbbIWqOdBEmCnCfzq4Oumis4axTpgWALNEBeuOyw2SYFGz2vsD3fhWZ5Fnvf62zNm+sGFrBMX+AJe1H9AGYULpPC1XEi+YGul9JKrd9kHovjKo4q65P2i10XCoOxioRB/Ksb53fqthhPGApzpwurv7ZEO63iZEXbW9HXlL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731890133; c=relaxed/simple;
	bh=lh48zb2uffkODq8Az3DpHR/ro4NnMy+B4CPqyWUik2c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NDC6p7kbT37qSrzDtqQf4fpQVtVJgWkAIQuFJIt8/PjEc8vO/OsNW4ZUHcpBupszsRQNAIoy8ny2dgpdjOrHfEDnvNy3WMJXgKHecHRjiKnibkviQFh9lVfhtuIg/nRG0GajeviKZxnU0clm90nzgHchpVh3dKMSar2jC8pcs+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mmdEzPMB; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mmdEzPMB"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 53FBA1140114;
	Sun, 17 Nov 2024 19:35:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sun, 17 Nov 2024 19:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731890130; x=
	1731976530; bh=Oza40L2XhJpigElpKLLnREjzay6tL9HIC7NbcSfG8lY=; b=m
	mdEzPMBHccGAq4oK6m0E8I6Bekx3f/TyiYDHVccYxnDcOky5//uvpMnF6rjqvpaM
	1VYTxOD4wqBuNl3opkR5vUsa1ItdE10+/VR457h3zgNHTF/skU+diP+qi97U+oj7
	cTHJdZhtil2UGwE/0OSDSx2pDlcxKtfH1//K88TG/NsY7DSn69MnLh7djI7BV4jx
	MlzhBQweFAdosshkTfq1LtEklVbwnSh101IJVsUxrsq9xb3q6L4elk1EoMDfp+r4
	Hv84C/OoUBcdsgBPEIam4CBFyfulbIvg6JGyrwNk7Bg9iowRjG9Qyk648pQVN589
	ndTCphUAcAF1iNSPLhT0Q==
X-ME-Sender: <xms:0Ys6Z1K9bsnJG4Sl0nip4Um_TBeu38_tzARYDDcAIwHc3P9LJ9PKCQ>
    <xme:0Ys6ZxJkzC14ioYyR1ULA5i8HyxbmlGxckZ7Smggp7c94cKQuGMss-fUYS5kveJJB
    -6rhjNCc1-5hZ1Uig>
X-ME-Received: <xmr:0Ys6Z9sf5_UxRb8gaTEWmKpU_RTzr3cKvTJq8QFSN6wy-DB71EAsjJIwI3pZdLk6aaMDLMDLsbejiuGphgfIiFJ1xEPMC3dPR3g8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffg
    kefhhfetieffteehleehtdfghedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrse
    hfrhgvvgdrfhhrpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0Ys6Z2a-zuaMTgngZDH_H9-cOonXCuyoXmfFWEv2lmcCNHmtavSMFQ>
    <xmx:0Ys6Z8Z5Yjt9zjFibjU1bs4Kh597m1AXbkuJbh2ld4q3nMPXvtqN8Q>
    <xmx:0Ys6Z6BZxDmqI5p5zvVsYMwAmdQosBFvJCUoRWPViydDeZp5TjAanw>
    <xmx:0Ys6Z6Z6PdOPlI_ALuTO9hD66XlVyksyGkzv2TQrOfd7tQtXvX9PZQ>
    <xmx:0os6ZxMbLjf4OsxSrr-GvusWKda9ul0EArQz1ABXSKmb1wzGv59ydKxJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Nov 2024 19:35:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: Johannes Sixt <j6t@kdbg.org>,  Patrick Steinhardt <ps@pks.im>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v3 1/5] doc: git-diff: apply new documentation guidelines
In-Reply-To: <2365334.irdbgypaU6@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Sun, 17 Nov 2024 17:44:10 +0100")
References: <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
	<6841bd5825be8e7b17c2f9c3a997de29ffa3a540.1731785769.git.gitgitgadget@gmail.com>
	<7f24a030-bae2-4712-8593-61a9d4089cfb@kdbg.org>
	<2365334.irdbgypaU6@cayenne>
Date: Mon, 18 Nov 2024 09:35:28 +0900
Message-ID: <xmqqldxhxttb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

> OK, I'm not fond of my solution either, but I strongly dislike mixing synonyms 
> (which is the usual meaning of putting several options in the same 
> description) with incompatible behavioral alternatives. But, for this one, 
> let's consider that the alternatives are just like `--[no-]bla` option 
> descriptions, for the sake of ending this PR.

Makes sense.  In this case, not like "--[no-]blah" whose description
has to discuss two options with opposite meaning, we need to
describe three choices.

> I would still rephrase the description to make it clear, how the alternatives 
> are  working:

Absolutely.

>
> `-1`::
> `--base`::
> `-2`::
> `--ours`::
> `-3`::
> `--theirs`::
> 	Compare the working tree with
> +
> --
>  * the "base" version (stage #1) when using `-1` or `--base`,
>  * "our branch" (stage #2) when using `-2` or `--ours`, or
>  * "their branch" (stage #3) when using `-3` or `--theirs`.
> --
> +
> The index contains these stages only for unmerged entries i.e.
> while resolving conflicts.  See linkgit:git-read-tree[1]
> section "3-Way Merge" for detailed information.

OK.

Thanks.
