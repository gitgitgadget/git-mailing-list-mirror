Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39B313AD26
	for <git@vger.kernel.org>; Tue,  5 May 2026 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939792; cv=none; b=JcDg8JA8WLTMOinVn4RpNTLbILMYEYLoJW5OdKkcYkeQKEzBpcSmv2D3TXryrWLGljY+J+b6DbvumUoAghMtCFlpVEk1KL3WGSLJ9G2u0QtXrdLj4b3FoBh/yfmrGzxpafticYvGoCFRj+nDkPDDA9CqhCF9ZCRVosgoNkX3ht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939792; c=relaxed/simple;
	bh=LQrdl2/bPcAJAFeSH/sDZl4tAcp1BJejuxaDS5RZnvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bCxfwiNsMB7UJjkomFObjmoqg9nP8caSPWQJIR45b3O+tY2znkzX2mwRQDbXt/D0faT/rqFTt00S6wWEOXqcpVhu0h9KLrOtXTYxFXQ3vsPMgHHBCMBR3CzZNZ1RZF5H/Jd78CuMZ9gTygYsNcR4/2FtMF8CfMFbrFYXojuRzRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XpS8AmNr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=omOEsnjY; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XpS8AmNr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="omOEsnjY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CA85CEC01F6;
	Mon,  4 May 2026 20:09:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 04 May 2026 20:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777939788; x=1778026188; bh=1oSDn8RijR
	XP3N1DHSjxYr6LICVJz8R0+rh4jn26Ytk=; b=XpS8AmNrYqgjL9JUxayM7C6io0
	y8AA9UshMi8rTdqW6YJsYv8OnK41FxrPJfqtWIVUsX9Iq7bH6oU+SUjymq6adDTe
	heTXMfSs+nRg1mK/B6wAWDLW3y/sSoJLRpu/F6nFWbkUTvlOJilo+A33OrpTfeBg
	s4O5UbgZbTXBp/i6cW8A+JZrVNCn5W+rb4eXZCnv3ktj0RhAYZ5juK8F+LYXnfgU
	fYlHkPIYr9i0ADK0/81S1Gpf+kABhHBhUiAo/BApLXO+cIABDmUSOguvN7ExCKkC
	5wA8lCrOlc5RPqAkNrDKtaHAFbQDEC4EP/PIKiEwfHP0NHr1aQPW/m+sZNsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777939788; x=1778026188; bh=1oSDn8RijRXP3N1DHSjxYr6LICVJz8R0+rh
	4jn26Ytk=; b=omOEsnjYdcLrOT6BCUK/ohfcD9TdPWaXrpCcz51wRC4rLdHTdc5
	3ek0E0iZTqbOOUdaBs0aFxPaFyNfhLu5ziPheMFpkQkmt/bI5TPeE37I1xNmMO1f
	C2dmPN4HYk3GLtqtpo4hYf9QPHQMnN0zaiNPzJl4Im5q1m1W3zhZFE/nYtIBq/0B
	QRcFQLR1UGSBM3AjOTGp3XYj8qN99DCAFxKaiXuaDvAl9rAZDyYLD4FwnYT02tGs
	9dN04ynCt3q1Nl6hOYyeU9GtilrrB885udDKSp9vUUF7ERQOJg07oz7z9YJMawEz
	U0hehJzuTZrhEZ6/e9FBIRHjrSpoY9F0T6g==
X-ME-Sender: <xms:TDX5aRJOXmFLurm4iDDOpHYv4k8qK8rNd4VH8DHHrr9s_Lz_2ZBtNA>
    <xme:TDX5aUIqEicACuYtK2rtD7kR77QyvPBvHpyWsOo96_JOl7rRBn_nRQl7AyK7c4ZF7
    U0_ujr7RswzQSyJdEs0ZMp2QxjkWrK1TVdjcPZ9znz5u7NsOp6qv8s>
X-ME-Received: <xmr:TDX5aetXdZN1m_dYxBZrW1HY7pjYJENDlA2_myEnoxd6kFiRNPJFhy8RDATpg7ysBQNMwwPBfMrLOh9f3xI3TPPxrPs84EL0qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesghhmrghilhdrtghomh
    dprhgtphhtthhopehsvggsrghsthhivghnrdhsthgvthhtlhgvrhesphhrohhtohhnrdhm
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TDX5aRSft-UAA09A3v-z70GSkcew_EWRpdWC68Og_L3jj7tdfnZ1pw>
    <xmx:TDX5aUPpy3NWBIh0Fu_JH2-ekN6te7ng2oKeyFo_iDMsabEBiECWhQ>
    <xmx:TDX5aWbRvvPvFArKLO4hZaQTD3ImJ6lppT1En0itjgK5jlmlxgPjXg>
    <xmx:TDX5aezfUz4e2SgB5CtwOCeS1KCjWT4k2Nj3VZnatvU1Sljdg1WpWA>
    <xmx:TDX5aXsSaEB3bTUSjs2YnRTdvSkktfpcMMphBpOnRF4y8yWjnCA0goMO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 20:09:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: "sebastien.stettler" <sebastien.stettler@proton.me>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git rename/moved status unreliable in ruby
In-Reply-To: <CAPx1Gvd_VEWHrBWtUjNeWZ+wfmsAOTamKmL6fhBSQi=MbmXRcw@mail.gmail.com>
	(Chris Torek's message of "Sat, 2 May 2026 01:06:58 -0700")
References: <OsOzcjEwvHCQSghLE8LD_wHb_jDlil9I88OUuhpiRONnVd1o9p3gStbK1mx4q7OwY3ePtbZO-BBgTNOCeJ2DMyvBsdlMhRmDrTP894KP5xo=@proton.me>
	<CAPx1Gvd_VEWHrBWtUjNeWZ+wfmsAOTamKmL6fhBSQi=MbmXRcw@mail.gmail.com>
Date: Tue, 05 May 2026 09:09:47 +0900
Message-ID: <xmqqecjqpvhw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chris Torek <chris.torek@gmail.com> writes:

> This is why -- and when -- making two separate commits, one with
> "exact same content for deleted-file-D vs added-file-A", followed by
> later changes to new file A, helps: if you compare the commit that has

"helps" -> "somtimes helps".  Only when comparison is done step-wise
(e.g., "git log -M/--follow" and "git rebase"), it may help, but in
general, when comparison between only two endpoints matter (e.g.,
"git diff" and "git merge"), such an artificial breaking of a
logically single change into two does not help.

>> If this is considered something that can be improved ...
>
> It *could* be improved. Doing so in a way that works for more than
> just some special cases -- e.g., in a way that works for ordinary
> text, or graphical images, for instance, rather than just for Ruby
> sources (or just C sources, or C++, or Swift, or Python, or whatever)
> -- seems particularly tricky. Some degree of ignoring white-space
> changes would probably help multiple cases, though.

You could tie it with the attributes system to allow logic
specialized for the nature of the contents.  The beauty of the
design decision to store "snapshots" is that these heuristics can be
improved without having to change anything in the history that are
cast in stone.
