Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887052;
	b=1yTsJf+OxIYomG14EZF+3UwLQl4AvvfVCPoXSApFZZPLqioquqcX77NU+7x8OEFmoitR
	 pPmAsOwTCAEeDfvhsL9C7yhprAhek1IfyFbwKO4bZ5rnZVSbZ1XuV205ijRBlwUw7qVU8
	 0uOXAQTsJLqgQtzDQ8aAIARwnBBp0o7TftvY3Uj0JlCgVmPmPJYPHlhPjKr+WEGz5mNyz
	 cji5NuuCG/wWz0vtIW886wztyjzf9fV28LbAk71ifJfJLZ1xxCB0EHXEIt5T4OhAbA6DM
	 2F3GrRM378YdFDjWCuzyMUmMMCHnbJp74JBu6NO+ezcLBkIJ7mqZyOleQfYNo/ZKXaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887052;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PC1sM3t1WPM028gYnHNIIJ9b5YhA9YCnnn3JO1QdzCw=;
	b=MFLmyDi1Lrmu9ysLQLf7vxGtJBOk05Rqd6Lb3AkqJvrbSyJNGPy/E6YTKUzQ2dDZ8Tt1
	 I6GRA3MbTx8BUGDKeGUU0SWHMSFVGl3/kXkOi6dpUTnViXSF1LOTYCqwQeg49b8iJp2AM
	 qceXd6zYypjUX06I4AarDzukECOBO/pafeWxefaStBlPk8o/SDs1PHGSJGS08RoiL14MD
	 p2oIAkvB0pEmDTd2dM6byx6g3HW+0GyGG0dwrUexMhhg9dJJaGzi24NtF8ArcW8yelqGs
	 J+RBS3LyFtajmlowtYRsnDgXChLw7nz+MIuuPXmhEhVQW88b+bD++a+sZCuga2z5JWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=i7dsOaQl;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5LbarVaS;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCE56082BE4
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 13:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACCE56082BE4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=i7dsOaQl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5LbarVaS
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E3C98EC00CA
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 08:57:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 05 Nov 2026 08:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793887050; x=1793973450; bh=PC1sM3t1WP
	M028gYnHNIIJ9b5YhA9YCnnn3JO1QdzCw=; b=i7dsOaQlNTkty3SGOvp0llwoeO
	mD7EUwKd1zEASRHu2SofbnN3wS8t0yxkXRERbUCK4fPTN84QrTucSiMCdc4C5I/O
	jEvgOEGlzPbk6GZi+gvyxNPDZVC0RtQTXII2wQg/tmVJquDxA/J7AMiuFlmm/itF
	ZtmTl42YEJaZc+kRDqh9/7eZZ9zcFPJ4wPOJAmmps34a++DCKYDasW0vcD2BZk5r
	cbriVEQSeG7lMhLT/RiGl+NmWOynhV1VGvzLZ+OYeMSo+pFZX4PK66+yQ69lZiwe
	VnQaeXTavoU/xySCyfVS/JWQEVY+9vVL+R12GFPuUvNj9kU6mREl8jLuIbaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793887050; x=1793973450; bh=PC1sM3t1WPM028gYnHNIIJ9b5YhA9YCnnn3
	JO1QdzCw=; b=5LbarVaSGOZXLOUJu5DmWUD/OfxhWNW+w5iseYmhjm5NuR5Q+Fe
	N+ZU1Ird/StjQ5JDfli4ICTpVEJsrOuZaMQ/Nk1NwlRX11wcO307MhvKXF6Q7wQZ
	ISkrZEWb4TqVdpfIFU9iWCegwsvdHTmbn8jfpzl/raLmU1E61Wd9tE0sN0K80cWf
	teTxxdrbdDZWx5YLEK3JkA2qD+8oR9epKXRzycZCOthVm805Vr90WCbUszalIqFT
	MRj3BvqhjOXF78u1of5PVf7tQgXPFXffrhMnu0eIUq9wfXbZ5dJEol5YB+7qUWt6
	5YO4PJciMxYDbtaqoX4tTwAL+vlaTeFzZCQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793887050; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:V8bzXzAohYyEI+hp4Zt9y68ByQoKgRDFdEk7oaEtcw7NaeG
	wHVEIfanOsjBm4TKuBHFkX5BqGeJq5MS0Fcjr6leBHcWpulyMuVSFOVOURVhAHFc
	lrlFuDHiAEsGdzr3LgiUixSud4s0PNMxvJYYOsqRrdSOzSLZa/rPGl3pIw9S8G6S
	NbV1F1q96kYh/99/IXDxPUENhYi7LFPMZNLYEhgy5YdqyPAdiK32wqq5Gkn1qAkI
	G2rxM0J/OcI+ppADXGC404GYIyg7eDtocTL9Do11AYiRg6G3FhNdZnUaetrP3Bge
	eBlZlyoTn5B0Fo/T1RHO5cTjFCx+AoHU4Vet0Mw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:SqnPU9/mOacQCA8p4GH/jZr44Eowha2L7jIvy2gvZ6w=:gju8by2HwosuXAYotiiEmyrv2PAtPvCM1DPW5URfAXs=;
X-ME-Sender: <xms:Sovsaoa3lr0JFeIEGie_dsQPAjNzDO66lmijYOiZWW1X0M_PT6SnfA>
    <xme:SovsapYnKl5Lk3_zVDPChwgDyxEZjmaCskcRGlZR3j9f69cUcAa1wTEHDf8vFFLYd
    HwiLSkMDK3-jeDPmmdtafQhka9R5PnNg7beiwOfqAsL7LEFkSxkBg>
X-ME-Received: <xmr:SovsagmVFL4OYJ7ngMQ59PKDEVmb_nCeKKhumJp3rndwcP0BKsqqhA>
X-ME-Proxy-Cause: dmFkZTF/5u05dS3OZIK4owA5/IO2++n0/fubvYmUtt6gWOknluPdzugDHboNJmWMcaIyCY
    WaaW4wFXHv6f2rx2n9HDO6mscIun5H03OafSD3WL28FVqn+9T107OBFpNin34iBavlpQRq
    7Nwc9Yiesat19fHZ1mcanyJDQ28a7BCjMqWUEteF8+tVYvjcrQ8v1weSOMwJ7Fod8C33Z4
    JWMOuSAHte0n3Pa2HyZ2emftKbyt+u3pw9pBB/YHhcjTsA7aZSlWP3AZULt6nRbOdqZaha
    snbTO6HrB+XIpqizt4/lbbJ7BvCuFww/p1M8RPVBLNcryinyj6UJ936+OUPo5lzx9hsocN
    SYlIJHXpJR3zMiDZdNczLlzOVJm2G3cJ16P78XsbLAKvKzrsbmjCJ6H7FD8W7M2wLN3xHI
    Rik7F0K0bE/v7/B5hGO4fJUL2sd+aQgFYLnG0/R8ptQL8tunft0b6iE3rDtU3tfuq5JOkx
    UyFRlKXuoXWzGlrLdk/IdbQ9qg1BK3/ZqYPpgjOxxYLjaAUFO3Nb+ZXXUNRJXP53fwhRBt
    Fsw6Wi+L6zidv57h4IXmqNXpLvNEkoDozcS/7tpPnSBvroJlM/BB3ZS9DP6pjwQzUYHE5q
    sPnHwBr8b4OgDNVDia5AJGFHmpk9NZzEiOtBMQP1V6D5XxlNCGbBTeFsRoLw
X-ME-Proxy: <xmx:SovsatzTz8arSJ9A4lUh8QiirXYqKMEUTfusgNNIMAq0h9eoVAp2qQ>
    <xmx:SovsamNaa1971DrfzQ6haTflxOQlAo13DI02V3U7Kxyky8Czs24E3Q>
    <xmx:SovsapRZxt5Zuv86PIX5mXVn_dX7FX133pbW3myakkQuxxQL-bbtaw>
    <xmx:SovsasbO89bGEHJjiXzYi9SJ6T2V4UNwCFLOi_eSYiTcLJ0Z9rqKIA>
    <xmx:SovsauI6X3C_iIk-J6_9N_QV6_4CGgmigVbf3_bgJ_rsH1ih6JgBzEls>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 08:57:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74ec09c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Nov 2026 13:57:28 +0000 (UTC)
Date: Thu, 5 Nov 2026 14:57:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/10] commit-graph: several refactorings for writing
 commit graphs
Message-ID: <auyLRZ8TWeqdIaRm@pks.im>
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
 <0e74f6c3-2f43-4829-a071-27e96ab5e87b@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e74f6c3-2f43-4829-a071-27e96ab5e87b@gmail.com>

On Wed, Nov 04, 2026 at 11:37:11AM -0500, Derrick Stolee wrote:
> On 11/4/2026 10:57 AM, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this patch series includes several small cleanups for the interfaces for
> > writing commit graphs. Most importantly, the series refactors options so
> > that they all get passed via `struct commit_graph_write_options`. These
> > cleanups are split out of a bigger change to make reading and writing
> > commit-graphs pluggable via the object database bakcend.
> These cleanups look great. They are carefully constructed to be as
> simple as possible at each step. It's good to bring some of these
> conventions into a more modern style and to simplify things in the
> process.

Ah, by the way, one thing I forgot: I noticed this recently already, but
you don't reply-to-all and thus lose the Cc's on your replies. That made
me miss a couple of your replies already, so I'd appreciate it if you
could keep them.

Thanks!

Patrick
