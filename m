Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702603;
	b=azRgbiIZ0tOdXiw8+DdFA64g9gndQvSfEXPDtklufOD1oZmC77d6bngxpewVaiPySHKn
	 sLsSNAzKpchTVpQnlPdEdFySJJxPwPm5fdbcCV+95d/nBxRvHiLCyBK5uMCymL8QAwrL6
	 YAegSlwz6YLhUi6uYVI+JNWGu4LmhYyTyQkk4D5K2vYyXDNOsf6q8L99/fUwwZg2pjNQE
	 fjVAS3g4HAqDloXI0wMjI5UPX0Rh233KE1mRVGafPwxMORv6gsjE5ibiVC06LlgfNTORc
	 czqXFXJYVtBRCSjXwvUz9t4wSoil6qu5AgDdfKi+mUTOQfPLwT57EUKftwjgddTX6Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702603;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=x3oqRdSIKCcs62I2liwWOxmkb1uKamJkPnZDX1gAvek=;
	b=fAg0hKK3e6Hamz8xkAGuoez3KDpHPqAnKCnsM36Ej7ixVmEvNqS3Xx1h0hauWvZBdO3i
	 ZavVt5Xh5FVHG/jZ8/Q/bjaZ1RtX/beRTtLhsPdS48njg8Ci/W5xLEDz77Mxv75SadKww
	 HQA8eoK3j1UGzdKF+b+F9GG6msm6xdA+FJGZeWZuDAfy/7utuxE35TRcu/dk1rHGuRB+K
	 W65tmt9AmG2ZCN/Jkc/VlJnGqAUPfBFElcdE/9us+fBmZvM3iOBM+aX2iXlO4ON2M4f7W
	 4+x93MFV4+vaxaDxou3gUR6s8cd0fbAxymiSWEkUo7uTFeySUo0foYBS7ZRMEmXub3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=temperror header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZHWCi7Bb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yiGornVA;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25112606A324
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 20:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25112606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZHWCi7Bb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yiGornVA
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 44F311D001DC
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 16:56:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 22 Oct 2026 16:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792702600; x=1792789000; bh=x3oqRdSIKC
	cs62I2liwWOxmkb1uKamJkPnZDX1gAvek=; b=ZHWCi7BbboUa0k0VhyZ9sMrrrW
	+xPX5VQlXLBtvv6WnLXpzmgQRH/vpccYtJvgo7TNwY/DN26Q58Js5a8A5xOqnbf7
	MYFaAYAquCKGiJGvV3ngz+aiU4etYOIQcM/sQRLM2M0Zuwwq1PaZbGWybSruAjt/
	+myciRiCAHUDKb5yobzTOAzOAdgx16rueZJefQ3pJgzPR5vrUzi57aopkQsfcuiE
	FD0uVwJprbR4xJKEIy9wVx8Tt8Y/m7I+bgERokllElQ7n+8HGEPkNz3ugl3Wp8FG
	e5N2SbsyRFu6dBg0eI8iLDvbNHrQyvJaZzZ4HNXvCmgNbd9oYqDM6KBRkNVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792702600; x=1792789000; bh=x3oqRdSIKCcs62I2liwWOxmkb1uKamJkPnZ
	DX1gAvek=; b=yiGornVAHc+xpb5Quw8m0g34QF6Ed+2usyrVPywy9XfNVjxJqHR
	bf2e++5E05pQVQ58moBt7cvrhLsavkbNYNmjv28B0q/e0jsr0chkh2o5GbxM1iOo
	+5HY7Ql1mfOg8EqKCY60Ff1njO95wDq/id9wtd/P1ima4x+N87A95H3dyBqOjaz1
	YV3RxPAGG9e2FnBuBfkDARQwfjWGY0lagoXRB/0Nc7D+xp61zgyNv+JLZNBESjyt
	0HY8jnvG+grVTNKBmiHl+SOo/gFsJRzU2WwFlm1m6eKfjkv9BkBDt/CSFSCKXBMA
	CQf+lCRn9cV8WCqdxyyU94HZOBPLC8Bqh1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792702600; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:mTQLYlPQn0NziE7HGmbTiB3kCDb3h2HcomOuB41ySNUlyUx
	oHkd1TcSDNhQ8KKP1wDusu4RNYfWlQuLoM4g3pWUCMZ9byd7L5wzKPB9c2HeYtej
	Ohmgt6eaED4midWdMjLoHJ2Geb91rKAmS1yrRiC7n6rKJ4QI9CJF98JoGPUEikJj
	OqbiaCj3wJTI6jecKyCvHEbLZoUBIJR5BJQ/4UQM0QfeCYrrxnaniSDeTAAFvYNv
	WvK8mL8YkyB30TmGGtm9C8LtBcLN9jwsGBps59T/4DuBBV+/WTmqR5Wx5p0mjgtT
	Osohq/Vt7hK8QgWOU74SZMnqsEbyCC6pjWiz6mA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:eq5CiM53s13ZVxMmOFXGDjg0Wv+0am6o9gJ9hpuPcmo=:9txcPe9sXn74FJ8YnL4IDh5nEl330o0H1YdXH9T1EZA=;
X-ME-Sender: <xms:iHjaajeL6vijz3g3ertjY6YLV0TV4UoaDhZ9yWDM9cwlRxuh8okF3A>
    <xme:iHjaas7xFbWYbHLnAWTgG3TblqrQxrtBT6_bbROAldsEq9JH_HCB-U-OBcEHltaJL
    AYdEgFSunlzxG5gQ1gGzJkaO6T9utdslo_4sHJH6ZFQ4iUHzvVyM1A>
X-ME-Received: <xmr:iHjaamVjQqgDPxSp70maaLR573LucccV0BPrA2LrOilwYtIuVRx8hTnC9hVwBJ1cnWlBv8ktbA-_oXfeT_Z9uP72yQ2bHr7XN5gS>
X-ME-Proxy-Cause: dmFkZTFLSJiD+6J+jQGPqe11rVVazDUn217RAUJrWkbg9dbGPuwQKD1GYVcvBKI2Jh6Hk6
    5SxuUzshSp2y84tWpHwsFBg8EnUzCdqCFIbizup25e2fTvaMcApI90/HlA+Wk/KSf3VMod
    glVmrxHrHxKjqhh/h4ItOc8fU84PDhUKcMw3l8gFlO6n/s7Nk3ceK+XQqG1cCZLpPSTClS
    RFfwJs4zu4jao31JCHOCSH9skThwfd2OLX/MUXvKsJTR+5XCTFN3EKIKuewuCvmJgCB8Fj
    /g/eR4yzecknqZBTnNvtiZ9MX2Rzc5nivXc0P/XyRIoryCkkd3mvqpPxYSX9IHsYNQEraW
    F7jHwBdf4hnTW2GQsqfZ6o8EKndDLP/7na8oSMfY0bBUuo+sD6dck22NYrysth8r4Kdchb
    Ew/MFTOsRqFfk65WcQhvnvUiznELS/rhMD6g3UANOuU7j+XBR9UN8BPrnZMvwz+tEar3lo
    oxnY4bJHVF8mAq6t4yFtdfu5MC32DgK27RwRYM1/35m4WphlAxFykpD3w8C5QCyFYdO6M6
    zxNKHjMZXl1PZm/77RBvY9+5mBiz67T0AqYUvwgx04yV13vKUzC21IWwS4Q14dvRAx8wTS
    qQaMS0xWl5hJMpvur6r+dxwpUpYtELq7zk/DnLb2DFOgDWaBLNjpIxQwXk6w
X-ME-Proxy: <xmx:iHjaar5_mmTqqFHtAYrtNQpoLuR1M9Ltg76BMnJhnJI9bSbbbQxgQw>
    <xmx:iHjaahrnKpITB3baXYbs9S5-etMLnMz6F5uVSzHxaLJnWbSEHc57ng>
    <xmx:iHjaaungDe93U2inW0qcvRX19Vwm8KRwSJ40aDwBpU5xSdzs8dNmSA>
    <xmx:iHjaatOPzrMhcxu7Kw-E22FSod1_s2g553pDna4a62V_uv-OxBOEwQ>
    <xmx:iHjaasZ0-GucTnJNTKqeYXHnXKkAXD_6ERfYLu80ysqNPKFdjq7XZb5T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 16:56:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>,  ben.knoble@gmail.com,
  git@vger.kernel.org,  gitster@pobox.net
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
In-Reply-To: <20260917132540.GA101514@peff.net> (Jeff King's message of "Thu,
	17 Sep 2026 09:25:40 -0400")
References: <xmqq33vb4hma.fsf@gitster.g>
	<20260917140350.44760-1-ub4nal@mail.ru>
	<20260917132540.GA101514@peff.net>
Date: Thu, 22 Oct 2026 13:56:38 -0700
Message-ID: <xmqqtsmde9o9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Sep 17, 2026 at 05:03:50PM +0300, Vsevolod Myalitsin wrote:
>
>> Junio C Hamano writes:
>> > So to conclude the topic, we would only need this?
>> 
>> Yes, I think this is indeed where we were heading.
>
> Likewise, and the patch looks good to me from a quick read.
>
>> However, during the discussion I really liked the idea of passing a
>> pointer to the "advice_setting" to "vadvise()" instead of passing its
>> individual fields. It seems like a cleaner interface, even though it
>> is not directly related to this fix.
>> 
>> Would it make sense to submit that change as a separate patch?
>
> I think so. I probably would not have looked into it as a cleanup on its
> own, but since we already spent time thinking about it, let's not waste
> those brain cycles.

So I should mark jc/advice-config-set-global for 'next' and Vsevolod
can look into cleaning up the API as an independent effort?

