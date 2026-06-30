Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A899A11CBA
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808293; cv=none; b=MLYxvdOxxKVEm2z/7RKyiATTY0llsaR20En2HoYu1DGccysmxM/uygfn6wWTPzFKp7LMkXgITDfBQyi3H6JCxZ43LizLfe/KCd5j+1ZM+ZWGl/Q25hkTaYVtvGhEkpEa79v6jizUPqRzuHS3L8TODa9BYX4bb1fMIvaprx7+628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808293; c=relaxed/simple;
	bh=+r0sefFBhfxcCZ9CtQu9dr3p8Rispv4ilZ0y2WpkwLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JejllihyI2kLNLD8s9jjPrZ5+89q0AaU/1/MHsCAjI65IDKJ2AdnY9CpLmrKAi3UbJSuJgaxP1GO5MA5vmab613bwNitYh44TVYUzLsSWM4S/WOwYSlAktGxrl6vTXbfvdvZW8s8ltK9IGY6AlrV8i4JqQS2fLMu/bl83NBqkBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AtIUK0ig; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ACD4LVw6; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AtIUK0ig";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ACD4LVw6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 9652F1D0008B;
	Tue, 30 Jun 2026 04:31:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 30 Jun 2026 04:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782808290; x=1782894690; bh=fBQ/gMA7Ic
	I9mS0c5TAU9EhkkL/HEIl720Qrz37k/mg=; b=AtIUK0igiUPA4NO2pJDG5ZMaEj
	uKuxrWvMX2Os4Ugd3igJd2AfH1lcrCYlXnj6d2yJC1Jvt1q96SZtiY1UkKI8Di8k
	t/bQvvFD9QAd3Vk44ilAcc4/NodpMlXgbDqPZspiUeBqR8ygShRRVsIobZRuavOr
	P40WpfFpgCQEg0GAhjXOpbg3WyYs7Aa54XtMtr8T+x+rkp/PuXdQ83alPluiImou
	Brei+EZ+dKRVS713XRxNvHbg1lNKCL1aQTN7CKRKZjC2aa2zvFxuBcWsgmmn4ofX
	Wy074RPh7v2nTsl3GobQEVW+wvmF/UPPgqndarULlcmaOp/y16HJzfIIy7ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782808290; x=1782894690; bh=fBQ/gMA7IcI9mS0c5TAU9EhkkL/HEIl720Q
	rz37k/mg=; b=ACD4LVw6OmZc4jQhw9/qSBg2yakUQYXnfijCYf8rBGzNyPLova1
	/obBOeLfHFYT6P9VFUCbvssNHXaooyRTU+0szQdFJlWye5IJ8yWh8XA5XrNC6KDj
	u24c20x5RMx1+yEvcc1X2SAtovVC8pJH5qosvLoU1wk+34s3mjkFCMybKen7PsdS
	VoatEAezr1/xY5QvqFPFAyTjJjPoDxXWkHOKDJT3uUw+zEGVAk+aKVj9pK231Y4S
	u7JSVHqb1z1iXiTdGZdUqtS2CP43wR2plE+M/SrKy6pZmN78q5IWRXhH1vRoRgsw
	tqKZFmiE4gFv85C1J3eZBOelqxQ0ke8rdYw==
X-ME-Sender: <xms:4n5Dag0WVpqCnAzA-GjglMuWx-wmTNnttPLlxD0-PXUfW0G5-swh4Q>
    <xme:4n5DaigJRVrZaQRQhIaQgOXGtdjyg5-IuJRkOA9MmVGZq4Lm4qJTpbqVOjoqUAi39
    HAJsaqnlgHrDQLI-DFedZnyJeQ4Z955znxkFjJF-GfHKAvgbtUM>
X-ME-Received: <xmr:4n5DamTe_Mog8GM3mZX2_4fE5cptaCcRLeGtj09zBvFsj98cBweaGTTkZPXvVJn_v7JPnMmU4kOfvpCsTkv0WTvd_Qn6eDoNHaPc4jTxSoGu0g>
X-ME-Proxy-Cause: dmFkZTEuqFZIq5wxlrjS+Sxzp222PMk/EgCQiXhFXTCsIzvWMIFXSoe5C4i6OnLU4cGPJW
    NOMZsURq+KjPhuQ7A1svHlmpdphcsNkgWyOYGQx/Cer+TnHs/nwil+Gve7R6o3fH+JMYcT
    qnjTXk70FYDmfWc5E7A/ibBO/dKVb9gIlYbpUdEJUMP+if36k+2CG39AgMnWQo6hzH59mq
    5ykB4q8SFD0NeAe56E8BLAyaYvkMJtOMpabJD4BBEBAUGyoJWEuJnDkBATP62fU7BuF7bi
    MNX96YvX2eJ19r+6lg5ylb9dwifG5i/3ApPEepX3GVP1oFz7ef37GBADly9neREVgF/+NU
    U28nHJG4plOIndtCBps+13Y4kCKfGPCG2ODtLjDfPKIRfvCKd5YHa6cCGiTNZFYEARwj31
    GAab1u+uaRqWvfwlZGtNoA70wBeXEfOjEV0Q7/1QtfLCiVB3oeLg6jsAAbF7KjPrq1L0lY
    HHlyq8R12pjjGmVDrMxkfCi3bTk3UuAw5LrFRJphoxN9Ik8VtMrf+HyPvwi6FC5Y7OavMY
    0sci5M5B71YEVWiDcrW/fShXSSWPUOm56Sf81BOhkCauH5bjgqQyMiI+wYZENbr5JJ8JOO
    bvZV00L+vz/8vq470vtYePhIpymaapLwe57qaU9ayVKj3htbJf/k5nUmwbyw
X-ME-Proxy: <xmx:4n5DajgMc0IuKPSYV7dY476GLcEJqW7616jBs_He9zsEgPg3aRGKKQ>
    <xmx:4n5Dam7_9-WnLFjTUpHwKd8H3qExsRNa0z-H8WpXAjmfy7S1cq-O8Q>
    <xmx:4n5DagAXDqIZ5KKkaJ-6lGo9MYx9SF1x-xzKklnTI1cIoKtlsfMdFQ>
    <xmx:4n5DatbUfEqMiHmWbLjEUOgzyFf7KypFtUx814JhFp9TBwNKErfIwA>
    <xmx:4n5DaoIaqixdU5rEY_Juv4HJltBg3CQmtz5qb1D5P1k8T9uwjeswoChD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 04:31:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ec1f819 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 08:31:27 +0000 (UTC)
Date: Tue, 30 Jun 2026 10:31:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] odb: introduce `odb_prepare()`
Message-ID: <akN-3GYpI7OmkBuO@pks.im>
References: <20260622-b4-pks-odb-generalize-prepare-v1-0-d2a5c5d13144@pks.im>
 <20260622-b4-pks-odb-generalize-prepare-v1-2-d2a5c5d13144@pks.im>
 <87o6gx4i5w.fsf@emacs.iotcl.com>
 <akIN0CxVxhaHnvJ0@pks.im>
 <xmqqa4sdt3e6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4sdt3e6.fsf@gitster.g>

On Mon, Jun 29, 2026 at 02:58:41PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> According to my grep results are there 17 callsites for odb_reprepare(),
> >> then I agree it makes sense to create this wrapper.
> >
> > Yeah, I was a bit torn myself whether or not to keep the wrapper. I
> > eventually decided to just keep it because it reduces churn, and it's a
> > trivial wrapper anyway.
> 
> That sounds OK.  Are we all happy with the current shape of the
> topic?  I myself did not find anything iffy in these two patches.

Based on Toon's reply [1] it seems like this series is ready to go.
Thanks!

Patrick

[1]: <87ik704f1j.fsf@emacs.iotcl.com>
