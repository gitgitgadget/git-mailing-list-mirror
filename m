Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076D639EF1F
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 06:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405554; cv=none; b=JdAMSCsB0ibcUNJqFwZUPUla0O1KTRRiM2vZJO2KyMB3IHi46PaCy/k6wqLwkvs7NqBcqM1wj1OvcEbpcYyH1kpV56V+mHOxh6JV+QRlVbFaiRE+7jQtsSlfxLjuIC6PU3EzIfbhexczLqm4H1bjnIohcNbUhOR6IKbP848h5ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405554; c=relaxed/simple;
	bh=AtJzDHIfaneQlrx+15ZRW9A6ybwLe2nStsPa/WGEJuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdvoKtyGA3AuBgBya/v2NUImO7LvkJ4QNg71GlBZkwQeU+f5UXkArvBe8w0MQuveXQSIF2dgQoRl9zu84d7Yl7jLW9CzBYu2pZ2MdDPC0ZqCK01hHaAsM8bN5jXhboSlYlwqGTeKoCliFVtCEVaOGzjy8scYuL9/1BlMD+PM1go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=in1pjsLA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F8x0k6A7; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="in1pjsLA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F8x0k6A7"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 4EE521D00192;
	Tue,  7 Jul 2026 02:25:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 07 Jul 2026 02:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783405552; x=1783491952; bh=6c0C0ajNk/
	M5xiJWy7H8zni57teH9iJ8hWWk0IUMq7k=; b=in1pjsLAtBQav8ZYzri7ChM+nZ
	f+6h2SrEqC3I/OZGlMFa9NAW8SP/5GhuHG7outm1qsycQGLpWQRga2JB8W4+M0HF
	DWuhblZdEJU/KzLKnb2hsofytXCjaV6LwT7YRAeWPCA7kmbMHAzobjPV3at/BHaE
	b4Cj9hHXN/MK8vBQY0cI/HXuhN4bTJEJ4PU+83sSSXLeEcAwy5VETILyecyt4z8B
	ycIKUGt5cI9BfW5M724arpJ9q9rwsGkbqab2MrNPhgowMJ3S/4CjAyrP1I+2MD6c
	B4SJ8pDytHRAkEr8le2mtMufHfBQOxz9la+0gllbLmwf27XRY7kOKWQCwrKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783405552; x=1783491952; bh=6c0C0ajNk/M5xiJWy7H8zni57teH9iJ8hWW
	k0IUMq7k=; b=F8x0k6A7uCjnoP7fpFAjkNQP8dfNuFsFZcYV1xy8jr3GL0vN3rx
	Fl57KaG60H57ORvpWEbyH4jUvSd6wrhaCtUhydvb9/94/ZxtExRhZY2GF3cHdnN9
	vyvgBgNc/2WUTz9TnGc8z9CcAW3W8O8Vje15J03L9ggVArJ1x73P+vTCWYmW7opb
	wq4CrAiI4JNt+Hqou27M3wOd3FiZqvoEnBARDTK8dCLOTi0qszASXK6fQ141bnKW
	ICLL1kdzkzMQTBmFjAtDHIdGf39NQymI92K/V3UNn10VLqDJXexoE2WzhV/56LlJ
	yE0dxOlIGz2MbNmzS6keB7QggYt0u77TMHw==
X-ME-Sender: <xms:8JtMakQTSvZqS943aX4ZnfW3qbf8A72V2SN7NcpLZbxAbn-fEn4btA>
    <xme:8JtManzrHP4tSw9urYnipOHmPc-X4EMpeQmlCLZv35rAOoqpQLcM-yOEnb0pv0pGY
    zt4wQwFz5j-9jS_rnq4wmi-vNsddFXL4o5k0QA4PxSKVzoAwgLlPA>
X-ME-Received: <xmr:8JtMavehegDh5L-cysLCf2oK6jxt5hHDM3st5e3OQUWrKEUyW4OKDDd-YYkFBrLBJgshVgTKK9EMpPWYgrAZxPG0SNoJGly2FopWfDI6Pw>
X-ME-Proxy-Cause: dmFkZTEcuLUxjVB6/I8QqLeDtOhGrUpWknuVFHyPoEKMSbN3GFBGAUCxtPepf76xhB5ntk
    c9PS0Jn8ukJGArmiL9mZmHIobS/qsceOHvnqCXr8MdITIiShjPfcXYZyTDm2frm25zPjkj
    sXPKuteVVWRdJbQI3SuwNJl+MTMZ1pLbTaMjtguRZj8UcUNZ4t2Wu2xXM4kYPQ7ys2XWGt
    4AqBR4kPCH/c0bSCLClar/28or26ZUTLzVIAMISSQG6QyZVTw7Zg+zAGL4cDBDAQfELO1g
    5rt6DXpM0tXEQfQ5k1+x2BeglnWX22MaBuRwgfmjbRtdsQt/ZSR6xxGAyw2UvhPlQIIkmY
    vh3Yv2H+FE9P6Uk3ZltHolvnWJHipkGX6WyEjSrklyB9rQodp6d5SqgDzxhS+OWJOPDhHL
    3U5d7nEqXbFoFCgXP7BckaSAksXwpLlwg59SU/rqCwHXAPQU7zQ2pl1AVO3zdVt6WIF8a5
    UwtmImV3yBqT9pZ/q2OLvrL+fOIAdiDfpkFey/AuWHA5XsDCzMYDs+Sqp32CwSOyUi00rA
    b/2xziWsQKYlO9Kx//7pdgO2w2pkU7x1ZGzyO5gig0UW9kBCI6NvYxNZhV80grNPls+5Z+
    C1Wrte2Zs19VfBR8LO9q9+3FbHdWUchY4z1bkDE+WI3vqv18ww+BUumgUIuw
X-ME-Proxy: <xmx:8JtMajIpSQuam3hNeenOj2MVL3BG5ioWQGThmnUiCDzoZz_6WuzuJg>
    <xmx:8JtMagH0B8nFSiTU_ZznhuSND7JhFAb6Kf_yLQw120WEcMNE37HBQQ>
    <xmx:8JtMatq1HyqPEla11vR1pkCPfvHQV9DpfEbZHWY6M5VCRgYvT6zovA>
    <xmx:8JtMapT8bvkuwgglvdxK1EOn3LiJTUmptrngMD24KI60YgYwcpTb0g>
    <xmx:8JtMaoCiwRgWQ7oXpuLpGVPnFmMSTtOgWwFCrQZpRZD-qSjX3a1-clBs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 02:25:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 82696b7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 06:25:50 +0000 (UTC)
Date: Tue, 7 Jul 2026 08:25:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/13] setup: introduce explicit repository discovery
Message-ID: <akyb6yOvhKS3qq3h@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
 <20260630-pks-setup-split-discovery-and-setup-v1-5-13864eb5a032@pks.im>
 <akwocdrzeu0xBLQZ@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akwocdrzeu0xBLQZ@denethor>

On Mon, Jul 06, 2026 at 05:19:59PM -0500, Justin Tobler wrote:
> On 26/06/30 01:47PM, Patrick Steinhardt wrote:
> > Like this, we'll never end up with a partially-configured repository and
> > can eventually extend `repo_init()` to handle the full initialization
> > for us.
> 
> So IIUC the expectation here would be for all configuration of the
> repository to happen prior to it being applied? Would it be a bug to
> attempt to apply configuration to a repository more than once? 

I'd say that it should be treated as a bug, yes. I basically want us to
ensure that every repository is created once and exactly once via a
constructor that takes all required parameters as input. That's still
future music though.

Patrick
