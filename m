Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDB2393DE2
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512548; cv=none; b=OsRx3OYhz5vA9JlS/0XKKoCAeUjHIceZSfUghmnO33TX8u1kZhTnN+Vp7HLnX51eKdzUviSMbH5uCkzPPBxYhH1qu8WH2hlb3Vy8ZhjOJyNlZ8zP+s7njumvQ/+nSs8L6NSebDLJQg3eOkdj2mizN+TSiLjsuJvpI0BJjJBU8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512548; c=relaxed/simple;
	bh=/2Fo1NoRU8X2OJQjEOE1PLt9VPm0cf8GsVSqSCNFptU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5jZDIf72NMv9jn7fQyKaouHunGGuG6FpxRg6Y1S980BwMjNoW8R6ZaeWsn7lHe+q0uTH4/v3moRsRJYPrI1RComgWF7sVEziedanEzu4t7YwURyUL/KVcUgO68pTNmL76UmrUiU5S+tVP324R6NDOmuxy+OyK0ivDrxODP8Rcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=esCT499d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cGcafLxY; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="esCT499d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cGcafLxY"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B6B6C7A00E2;
	Mon, 15 Jun 2026 04:35:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 15 Jun 2026 04:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781512544; x=1781598944; bh=Mkbhv+t1NN
	lJ901CM5oNZuzMqu1euABI9W+HG482gxk=; b=esCT499dyXirGlb4D3e/BB3vEV
	Xt6iGRRkcluiXeJ/6Du604KEZeklOew7XjqqdEWbLHNLFnaNfZbFpRZ40zs7eRFr
	MxNypdSYSezUUDCdlok4q4fZ/MO5sMUak7QdhkTb85XPIfz8d4VzXkjfmCdbCG5P
	TL8lHNLWQADoAmClowSOTbXt9ZpiLeZO/TaKmq9SAEaHcefDeZ4CoplCkC3jM9dP
	JpAAz1slJoiMQ7MiZClls3p1IdP2UHKH9MAsrC/TpeZUkG8poU7lX4Xw4jYByxtv
	Yroube4N3fkER8ICpSbgSZUgApEfJibNEZG8lGZACB/KqPwzrx/UrMb1JifQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781512544; x=1781598944; bh=Mkbhv+t1NNlJ901CM5oNZuzMqu1euABI9W+
	HG482gxk=; b=cGcafLxYtv7vuDZHlW0EarreegNdlVyj336zaOoFwilPZ7e+4Q4
	0fZfH7NYsKXaKwWJofDdsiCeuLd6Qoy9dL/TzpWKxEDvncsRbOkf/Io2wgAHkukV
	A2o6lBzk6gCCUg8gOhIO9+VdnkCNDj1Fa9U5Y+wjktQn0LkCoW/fPN/1RP45yKT+
	wiFj9a6p+q3Tkvy+BYZ+i8+27Glpx2crW5lrrF0RCaors1RH1NlGpXjJxaCnJFmi
	0jEeND+1QCl0S+CfecufsrSIHsIFUXSqlG6p0RUhCSlK+2ZGE3i0tDtBAtKYhGS4
	KgokqruO/NJdzQ60o4Xchc4kNE1XJ2txLeA==
X-ME-Sender: <xms:YLkvavklXcXxeKNBEcmWuLC-Iiqdj5PprnJvDGI8rDiYeQgW-xNI9Q>
    <xme:YLkvap2hgQtZNRSEisQPSJCTBKbVACMX1WXVe9H1OQh19rCwBRD5_vlf0lV8n5QHU
    nfqi9zaYuWi3qZRVnsrzSDiPENgfOszpwOR3sIta018vnwcOSCtVA>
X-ME-Received: <xmr:YLkvaqrrCu5LsrUyK3oBMHXWkgrn0NhygjpQ7Y5nx0raXF5k5vrJT8ocqNmuQ00NKmyruDhrxuU03dZY5yqxLf6Zp5Sq-NspEI8EBAEOaA>
X-ME-Proxy-Cause: dmFkZTFqRGv5BEiS0BniXxYlelXhPhhcdY0WUQePTpB8XnRm3qvarROREyDeyxzVd2oMaJ
    LrOloOjDmJp059w6ohduOAwwB+IAXjfeIrafXRBUYqw3vBa7YHdkDLUCQ1eHU5lNu+TTJB
    19Dfv6e0xXfBsxLhyFk8XTlqLUf6+mwZDbVW0ZdP3OfJbgGRdHcnYSd2atEJd8D3kLdJDS
    hGe+9fb0gLseJOFV22FMmgz9b8MkuShluRa6ttGixDGXXInfSgF0YuiJ7hcmZrYshkKfkO
    3Ay2NswXAxUPAGz1idyBg2/1qbKrJBBBAbCBK4jVusSC4H72P93ovi45wsqYCqTJVYpTBN
    kTNdR1zRoZKSp+kdfvpBzB2IX15fk/I43GLOxUCTeKNtRx3ZA+qYQqgPMx8jyDp6bLdZ4T
    i7obQmQev2oN4ilg8fcLRluTDSW5ooTCGBrDj1XvIyG6pWl46uaJbVX9zUjuwYpniFh33g
    koT0HnZHPmytyarSiFVA3An1fiMuTf9lFKaTsmi6scmnXefd0ElvJrAIiKiKzcD8FtizMs
    aM+mVhTTDTxr1h7GbLPrUQy87FOGcXFrucc14fE7EUC2cfTtEaoQBs/IdAlcmM6PO1BCwD
    eUEsUSDABE96AUcW5Goc6aNuCpclr0YQ72tQJ8OJTP18IGH5bmvCkmGcZTlg
X-ME-Proxy: <xmx:YLkvamchObCNHfARmdaSFZYkc-6yIpx9oLk-mjBUavqnEzX2bnNYZg>
    <xmx:YLkvapr4iiYLHySEUgSqIJJwIrewkr1T6BnEg3uFOq4MWLJnqWmMXg>
    <xmx:YLkvanGDFE0q0U7f7xzW8AqVXlqHBmwBGE8fjNMKA9H1Cv5qlvufmg>
    <xmx:YLkvapuQ6vEuxOlkTX1rPA-XfLEhaiAda9JO2cvTf3LFxnrvoIPDKw>
    <xmx:YLkvah7-KoWb0_u63YYdK-wDOYtmdUxhg6r9AdHGUno9thn5r7ILw-Pk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 04:35:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e0a6eb1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 08:35:42 +0000 (UTC)
Date: Mon, 15 Jun 2026 10:35:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
	Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 2/6] object-file.c: use size_t for header lengths
Message-ID: <ai-5XO9gsc_HdMFX@pks.im>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
 <809d83e46fb46baeb5d0dfcd12eb7fc63580eec4.1780593313.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <809d83e46fb46baeb5d0dfcd12eb7fc63580eec4.1780593313.git.gitgitgadget@gmail.com>

On Thu, Jun 04, 2026 at 05:15:08PM +0000, Philip Oakley via GitGitGadget wrote:
> From: Philip Oakley <philipoakley@iee.email>
> 
> Continue walking the code path for the >4GB `hash-object --literally`
> test. The `hash_object_file_literally()` function internally uses both
> `hash_object_file()` and `write_object_file_prepare()`. Both function
> signatures use `unsigned long` rather than `size_t` for the mem buffer
> sizes. Use `size_t` instead, for LLP64 compatibility.
> 
> While at it, convert those function's object's header buffer length to
> `size_t` for consistency. The value is already upcast to `uintmax_t` for
> print format compatibility.

One thing I was wondering is whether we should rather migrate to a size
that is consistent across different platforms. We could e.g. `typedef
uint64_t objsize_t` and then use that going forward.

I guess the question though is whether that'd buy us anything. In other
words, are there any platforms that we care about where `size_t` is only
32 bit wide? And would such platforms even be able to handle such large
objects?

Patrick
