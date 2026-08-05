Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F633E0088
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921798; cv=none; b=FIj0DCId+MPCf8oIpX8GBwEPs/IWFfCf4k/4+Ip5cnMcLpU3NUQU55tvnEuRa9UygpyCasyfGRiU92WNs6UZTE+DVNX/x783aA9XFr9GJmzZ/DCpwYQ3WympwBmbyylluj11ueZys/JUGmepW3RH+1Nqgli1VelHQZOb0Xz+IUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921798; c=relaxed/simple;
	bh=gTOZOxa9o5wp/vXpx7kSOrD+3LRT8PxA3CS0CkZL1G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihrJ6Yb2xwwbY/50kvnt47E2hunKS0Oj1MI7J/blzBPkIGaaIP2N+DPJ8NBUFDQRiMeY2UvnqH2iya4gnZg2yT7lYMTrOXSHRfVAK0IlcDqbEh3s2M06DSWy6TXO5vkMdYjrLUwZEJ7+XWeQKCLDpMeeqaF8bptDnHfF/pOW3h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UCoGQXrN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EoSh4DUW; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UCoGQXrN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EoSh4DUW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id CF12CEC0184;
	Wed,  5 Aug 2026 05:23:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 05 Aug 2026 05:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785921796; x=1786008196; bh=gTOZOxa9o5
	wp/vXpx7kSOrD+3LRT8PxA3CS0CkZL1G4=; b=UCoGQXrN0GMof7DnBJ/DTg/WzK
	rVdX5H5q0PzUl75SH9XrFD/+jWVL8K3vaNoCvrmYZKMkN/KefdY/H+qkvD19UEVS
	MHux/UTEr2KmmrWRO7/Q65SM5WSFzweNcdi+NhrNHX8w0jWhAHE6arnpzT6P5sRe
	3609KK9QDZhwrhi3FYvH6IP1bl42AyIggZa3XzfIq7MlT4Z3kqvSc/Qdacq5cQV6
	7lAnvvAYl5t/8B8UbyYkTngvd7BGWYiCsIFCzyuo0mAwQ5p7GqEjz7bK2A8CSE8b
	bTQ90WH/DAbmOMEoO1/D76HbCFnQNLNtk3JLoaJ2GbCvhC7fWftCTvBX+ZBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785921796; x=1786008196; bh=gTOZOxa9o5wp/vXpx7kSOrD+3LRT8PxA3CS
	0CkZL1G4=; b=EoSh4DUW/dwtroTiPZ4a3vo8ZtfBD13UqfQwV307t5JlyioPHVl
	3+HOI3IfZcqr55TIQf5W3U9y2pAYxlDKlY1CgZUAIFGa9fHklbDRyPHP2c0mNt1P
	tRl90SUL0faTXp26zYO8HjqpJTZcHBxNaQEitd+FzxfYDUj+08DV0Zf6U0qYkV8S
	P1R5EJ+F1RnmhHyz8FyifPfNCcGcbWLKX2WELmPbyJkkKOOqofyX1tikvZC43+fg
	fYAuHEu0Bg2t2ks/IwrikmpS9PpRbOyydxuGz03PaQ83w1ix2aUP1S3Zuj2HPZgA
	J3cIV+mKcOXW88rZ1YcmemS6KBj2UniBxWw==
X-ME-Sender: <xms:BAFzapYA2AJHy3txPl_BrqZ2U9Nqka21oinmSS757wI-xElXFc3lPg>
    <xme:BAFzan37mJYK8MQ6JWYbk0GXsVSg7TFrqV9xi-PGBTLITZv7yXgGNSK-DaaMkVWOq
    CXzWrVb_lVIfooQgGxX8Bu4ppqzzjk1_ddJQmgtP6xiTMx6FVRsJg>
X-ME-Received: <xmr:BAFzapVqzwIjCSEIueON6UqO82tckbvnitkI4Dd0kjZ8BjOSDYoahGdx3Y-iIZ0OVnKv3KBph7tmcMNyKgfbBf__zMJ7NCT9SahKxf2W9Q>
X-ME-Proxy-Cause: dmFkZTGBpZQysTzqwV1OOTBxRKnKzG9qj3qrnRTh3fGnnnnXoilMXVaXocxqPoeU1pZ88f
    8A0XnxYunKUt4g4NtA+AeR4kW28+cAMazPkXfS7ATtOr3zZdNDyDYNSy5Mx6B/pAuJ9pfU
    2IB3PkXhTsDOBH6LyqwS6X05JZAmYkeMtB9pHU0pd3HahVEH25/t2KRR5gu5ODqea37Sd+
    F85HeQ1miHq7QR9JXShqxirsi3kqIqopYqK98n+HyaemR8cgrazGHYfKhPTULTRUVxyomK
    YCNPBMP0Zwy0bmIApCvHEx2OGFsYIzPqzyRp0AYBuH78nZT6epmeTbzJXHgn3LFA/IVDNc
    Aa9ysNxPjtncD6s5k0Xpk39+MKU+kmGxIPlgAyQoNonhFtkPqwpwYvDIAn4azSADygmEQT
    rX6m2P3fpV04T/NrWYQkJ/uuf13l/8n6rAiZ5aepTPkZsYSTUpPGQy6oBBab+RBYMqFK7Z
    ueQQdSXfMTduHGCtaE1V+wXnXpibCRmK+/E+IhdweWyIY8e4ogjTcGVNkM4FdmBlVKGd80
    glf0iQYVF98Jo/1h9ZGg+f0ivXzvu3F5H9q8y27NR90PWndw+b3Ff46NQgW7nnZ4qtI/AU
    gGc/Axwbpcil6WmqaMxnHRP/i7Z9NhLcO0rxNaGuxX1+kTOr2qlpn/ChRy1w
X-ME-Proxy: <xmx:BAFzahXDOOx0jVrGIDfKJm_3eol0N8oPuaBLGzJ5SS8TqM-XhbujLw>
    <xmx:BAFzaodpLQuxglhkM_sIPj44D8xBf41cMDj1pgPPcnTEGRerQOThpg>
    <xmx:BAFzaqW5KvSTdoEfREEde0dQstXTAkzQ_DdqSNIuP1k_uFEhmjF8Pw>
    <xmx:BAFzahdT6gCNfij1oxLWpAXjIqcYJ70YxpcX0Zkzs1R9jp7vnURMiw>
    <xmx:BAFzaqXUDkgFR9rk4jO9pkczBSey3yXtnBIQdLJCL5QcZaXvTi3_uGyw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:23:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7a5afbf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 09:23:15 +0000 (UTC)
Date: Wed, 5 Aug 2026 11:23:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 06/12] delta: widen `create_delta()` and `diff_delta()`
 to `size_t`
Message-ID: <anMBAGnkc7dOFsuc@pks.im>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
 <e1ae83ba0378ad5d4278e220584a3fbc37a1dc4e.1783615780.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1ae83ba0378ad5d4278e220584a3fbc37a1dc4e.1783615780.git.gitgitgadget@gmail.com>

On Thu, Jul 09, 2026 at 04:49:33PM +0000, Johannes Schindelin via GitGitGadget wrote:
[snip]
> Note that GCC struggles a bit to figure out that `deltalen` is always
> initialized before it is used; To help it along, we initialize it to 0.
> This work-around will go away in a later patch series when `deltalen`
> can be widened to `size_t`.

Thanks for putting this note here, I was wondering about that part.

Patrick
