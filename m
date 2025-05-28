Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220781DF26B
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415763; cv=none; b=uUvXdPbFhgUU8al/FlPjCUOwdO0EjnpMNB5ITfEg3sJz7w9J+9F3rGoqOCCEpyMxYFVJKbx2NgaEp1ZKSm1+3gJJp24euZAokAqbdX+78nk8OStmHxBYefy7hdNLI5w9tp3rvijbi/vTr0DbjZT8Li4MbXDgOAjCKyZHo4PRLrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415763; c=relaxed/simple;
	bh=V06IGgxS8dTI5slzMza3IJPTUOiSmJYEij1ZI9MNeLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJER7NZPHJRK5S5YXo/Y9cEOVnzMCNrSe8ZJBkk10LQmu5ZoWF8/WILrHlMi6h5CUfD4Ovd7LaYKTDE0pAPmh7JDKwx5hOwD8wyWox2fl98asHUHKBYM7ggM1+FfW3PuR8vaTM3Qwo9Jq3rt1/48KCZibFFf6fK0uordBtcw6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QsusaA+S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J15cd6WH; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QsusaA+S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J15cd6WH"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F205A2540129;
	Wed, 28 May 2025 03:02:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 28 May 2025 03:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748415760; x=1748502160; bh=dSnm1Ctero
	zOJGEaOskKydTNADT/S6ZEFs1d+SGGBdA=; b=QsusaA+SIKN0WiFd0lL/djvsRb
	hSobzY0dnYscoVLmNSv0qjCOXpAaCn6AHg4HIaSnAUoWdcK6mLJBKi6I2gjY5wjn
	yCa4x6nA5kvPp603ShGDdBwXH/tHHiZnllDeVWuLTSd1JRCXkgDrhNDLWRKEKg00
	1CcQKVvNP5Yuek009XATUKkawGESCTIv2HZxGF1wH5+7ckAAqCPhPsjsg6QgST/N
	sZOcCOcdrbanRrGRhecHKQZ3LBmbfEDaf5r9KZIQa1zFfLDsPYffxk1ENChLlTiE
	LIsnP2m3jVhceahfNmJDdVw47j15bSAVnWIifuwIxaNeFZdm9KbYj4lzK+/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748415760; x=1748502160; bh=dSnm1CterozOJGEaOskKydTNADT/S6ZEFs1
	d+SGGBdA=; b=J15cd6WHZOboo+GCJmf+m7xLn2EoR9hWQ3N97JBYWr1wqDC6eOG
	XLd+dbHIaru+wAP4lv5oBTi+jlkc+6/iMgP5HnCulIWYdkE/FSlTTDtOprLfzE70
	qWeL0JeNQsOJh1AfiTlfp0DN98tqoGryXFkmhidZQn+GiPHAetPhrlAeM/jMQ1Ja
	L29lpjLtNDOPkXNsPwrKJSFsGvI4PGoISLYCzLFUVueUiTrsgoybI18lI8QhsZm0
	rj7sdDs/eJ2D1rbMnvrOdhVwAPp0p9iXDUmJUo13rVc8++Zj3WwIlpK4V3MmBpP4
	igfDG30/E8h3TVQDpDGCKMY96xDQoGvfz+Q==
X-ME-Sender: <xms:ELU2aNbfDT0NVHwxQAaL5am6emr30-cjV1X_pBODBpckS13HAaCwkg>
    <xme:ELU2aEauQKuEI7rIAYmoTNmgeftnZ16Ao620o3qs-HlbtZ_3bEZXUzFikr8bX1wYo
    NSt-dcaYhHgHAr5vg>
X-ME-Received: <xmr:ELU2aP9vBVsv4eUzaUn7VzAAp8uMGlI-3O4NkXzZDD0GcET102TSoWxZF0LJhyxQl8S9uVk4a3AxpgPbHfZTpVhXS19UslVdtywuuBhe1g8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvvdeiudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghsrhgrfhelse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghs
    rdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkhhsrdgtohhm
X-ME-Proxy: <xmx:ELU2aLo150mTdGp0LMdn5snMS13N5kZ6kNnm-9abA1z_j_qh5kOHOg>
    <xmx:ELU2aIrAckGtUMTXkoIWmU4hT0oVGMkT-DVt5YcVug_GG1TRCHUmpA>
    <xmx:ELU2aBST9qKRpCXcbPaq-fNU9-r3bH9wCIQON14hDM99SE8bjoyh5g>
    <xmx:ELU2aAopLkzWM8XktrJC5uoSrROEloSSqBpV0JLtzeGL3x9bZPJyNQ>
    <xmx:ELU2aFvZCRjHNAO7b12ctuqJs849M3v43zDsA5Xb-zSlJ0yRNcI8C6NZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 03:02:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6c864c8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 28 May 2025 07:02:37 +0000 (UTC)
Date: Wed, 28 May 2025 09:02:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org, Yonatan Roth <yroth@paloaltonetworks.com>,
	david asraf <dasraf9@gmail.com>
Subject: Re: [PATCH 08/11] builtin/maintenance: let tasks do maintenance
 before and after detach
Message-ID: <aDa1BYwzhMdqmp4S@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
 <20250527-b4-pks-maintenance-ref-lock-race-v1-8-e1ceb2dea66e@pks.im>
 <5c9f9bc1-da0d-4952-a424-1d2c99fce0d3@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c9f9bc1-da0d-4952-a424-1d2c99fce0d3@ramsayjones.plus.com>

On Tue, May 27, 2025 at 06:01:21PM +0100, Ramsay Jones wrote:
> On 27/05/2025 15:04, Patrick Steinhardt wrote:
> > Both git-gc(1) and git-maintenance(1) have logic to daemonize so that
> > the maintenance tasks are performed in the background. git-gc(1) has
> > some special logic though to not perform _all_ housekeeping tasks in the
> > background: both references and reflogs are still handled synchronously
> > ni the foreground.
> 
> s/ni/in/
> 
> > 
> > This split exists because otherwise it may easily happen that git-gc(1)
> > keeps for the "packed-refs" file locked for an extended amount of time,
> 
> s/keeps for the/keeps the/

And these I've got fixed now, as well. I'll wait a bit for more feedback
though before sending out these fixes.

Thanks!

Patrick
