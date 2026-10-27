Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098798;
	b=hL8SF60KjF3lBYT+rDHUVrm9kEjEKOaM+0roWXc9uVBH/es+8QeF14xA94bgcsxBkg1+
	 NyNvgxS+/JOXFZOrtMBp1CO3TCcozpSlbipWUxI5dakvehTq4n1J2Onnx3saf3JRjrTvg
	 t/O1Y9W1M+Z9N63YOpcz0sD1GXW//ixM7KqoPy4epHfoowJ8KZ4k5yOln5tp/05JwnW+2
	 USw2kGG1hvihMnUxdv5t7wmCaI+TT4rlm2Xck+uwzWQ25IqR/7PvU3a6EugA4zsmQBzYr
	 tMOEbW5ORWRB+LQIcEtALdEU5MFCEZoWUGBH3xFNdKFp/NjKQAuKwswyXCsdplC9pBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098798;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KMBWhI69Smgmd9XieB7Oi0S5mjKtc7T23ud2kKNMd64=;
	b=uufP8EXq2qSarSd07sjiTmDNcZi8GmKBB4KFhD/eOo6ezcNi+rs7dwiWnflZ7UNf59oI
	 qi2I04nFFan5fpzYLWBsbrdTfyXw3gCb9r7tse0u2JRzOQpujsOgenm2g/hjt+VSHVuCX
	 WUaOwhV0BaDcHbDrzjv9zke7KeeHvDNrBqDm9ia2/jF6NZb3fyW24S7b0VyFkKbA/6RHO
	 ZfnAVBXNz3cF/JQ2FyZDcatJoZIGVjm7MN0ePWx6fRWRZqxDJzCPZm2Zx8+KnaMLU2mW9
	 ZbqoHf5lwbGGpG75/MhLVzJf7kcXOvt2O/Q4pSY8OYU69sc5dtjpAu+/Fr8dJ10iU7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=pjHdOgTg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jAQatSWT;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A52606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36A52606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=pjHdOgTg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jAQatSWT
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 73E417A00DE
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:59:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 27 Oct 2026 06:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793098797; x=1793185197; bh=KMBWhI69Sm
	gmd9XieB7Oi0S5mjKtc7T23ud2kKNMd64=; b=pjHdOgTgOyt18DZ5WqOg61aLN5
	cb7KH9+7F0oS9E6gV5vBspGHsfJjfy3IqbHLiKbc18dT2fNvBQre81xZa6dpIAc5
	07lnggDfDh+6XWUoYR4T/EO+i/CzEW4c7SxHcJT5lWtQli3avtDC8X36bthXhDkc
	cD9bzSMgU7RSvLKeyZmQ8Q+gq8K8dEKc0wylpR46GFXK2rMCXRLI+tRZQoo5K/EI
	HmlfiEOozGvMkAmAK06tGN5TyWgcZ1KK3IiVNd4FoJRqdU4xaHyvrYu98F4aCeYb
	3+WszrdfHgD2XfXpzhq2DAsZDmV5YPb9jUZqVTwNh0SF1LqyxSsoCiplnLGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793098797; x=1793185197; bh=KMBWhI69Smgmd9XieB7Oi0S5mjKtc7T23ud
	2kKNMd64=; b=jAQatSWT8nCDXbzN/NaJciRCdHHrOk7OiU1iPxUaq/c+TsuZmfI
	Lk3TUaZOK/4h6t0oX9oFhl7NThLp9P8f5lHjQZLM3G1QoOVukjl7AIsZrZX4JLJ4
	UA3Dq373wuuWj2hFXNk0B4M+on8sCL79goSmvMuCK+6HIoyqyT8vzlYgSYmPQVUC
	UDwDBgY37fbtoKEwpE7d3NUAQSEg42spawWflknSB8VdhdYf23R36kEcpKLu2zOp
	CfWNtrV07/4Kbz413zVuvF7sj2Wz5zhv8DfwcjbrbZeXlw5uu7CmABxdHY79LmsF
	57Jf47XE81C1XlMl1KDljiQligZ0CJZJnRw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793098797; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:sxW42FQx3rrxWqnCEpFZAvzDwyHFbxSHjtYTcC8Yg3oj0BS
	emKlGvzS1k5o05vS9GSqjkv/GEY7IQRtkbdMwICcm7Q4CDP8hSbCwQijYhU4pJ/z
	bcpsuBxI6FhVLNxlRl09nIxtGGfjZ15Ph47Ca73OoT0P39i3vo7HxKqtdk3jORCf
	k0ACTAv+uTDznUDvkZCw47X+jbdU+sMFYil7XznDO6aYS9a9FtDSpiI31IZtVveO
	QHidYDfupR4Eo6DGFcmemWzsydfFMLL2EwxBVuXX3trv4Uds/ZOOS2BfUoqFQjpt
	UO6u51oBFM4zBbmIQdM25GX+uenIfjbrJcB1bTg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ORCdOruDJgbM+rVltAQc2Q57/TJ26yVkLNeEz+P7VcE=:pkGQYr/TejP40rkewycEDbhTkTrwN8Sha/hP/7o+F0s=;
X-ME-Sender: <xms:LYTgat1Gvx660ukl70SJlbThdj4UD_T5ei-KrLKWK8cYCMLdRg9xoQ>
    <xme:LYTganXCVR8AJBTRv_U8gjUC8Bs1fn-h0LEQY_ECMNuEL3crMYZypTw2nsdZhMGM0
    NkKhyLs6LBm5mOtTCvYJa19CYYDlVLfCLMrnjpiCMorfOyKEFqv3ec>
X-ME-Received: <xmr:LYTganVt3wYLaUS99qYR5Snz_hUOB2oNx5H6oF2DEgZiOa1qkbUd1A>
X-ME-Proxy-Cause: dmFkZTGe17Dia8vVvC+37aF1UymR8pxoB1RiP3jWNCgebjy+qpOmTVe7skoWdGsl0A6Ghs
    00eIJua3/MlBUXcSVn+/UArtXIowwOgoCDics4Cuoc/+kUScoEEJSzdCMnhTq94h3dwxbt
    umd0Ob8jj6n8SE18I6bgr+SLodqCoU3rLzK4qSW/17XdRl5ciKVdk6P50XEcX28GD088qp
    hUSSFm2BRlMQusT9qWnNnaHDWkF2dHr/U7Im4/jM1Ua22//H6OX0p7TvzXaHpvt6ZuTdFW
    OTL/sJ+kGQ+1VWLM8BjZPTE5XPIemMjItXdUzThBu87HlkSqlu6xVZ2I7Z/nPZT7udxHXj
    AKG6Cpgii5wjmlGAAYHDGW70E2/XVPZitCcC59vxyIUrskr17olHHJ8JplyAEAvb7bo4S3
    /s4A205SHgy0DZ1SaQ0LPnCdJAw12SiETuxlcdgTbCu8ji/1T0n5HDBNtRO/eB43eSsAUD
    BE9fuvaOQcNXfBdmUD8rC2/gZFwwNF8CuqaZpqvPlItECpr+nkmqfmhd5fiHgu+iFrBNm1
    LPsm421tY+UmV4+yvTaqMipKvp7+b1AsaNc0uxx9i6GEXRNbIdNsF2JwdX/zph1srhiRQT
    Pi6QX1hkbSJMymTFqYdDzgBvYCamNF0vY+HSdAxCMmCXd+HXEu2Ery3X+gkw
X-ME-Proxy: <xmx:LYTgamc0tnEDWrki5Dn2QFX3FxlHhTFvalZZaRh3UlM5lOctLdpqEg>
    <xmx:LYTgagVbLsnfYDicz-W8EbW0fkl3mGyGt5g_5cygKzFIdZKS-SjYDg>
    <xmx:LYTgavdI8vpbMR8VDTPxtQNQfDT4sP-G0Fdqs2gfq0QDZUdeuKmkGA>
    <xmx:LYTgasO7mV9A46YP4-iAo4vawKDPVzRobW_POci4f2ia1OviDTH2Fg>
    <xmx:LYTgavRbgY6L43PdMZDq4KuxnKy-qCdjAUuaKipDBBLUPD4TPJChLa8z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 06:59:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 730887d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 10:59:56 +0000 (UTC)
Date: Tue, 27 Oct 2026 11:59:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 0/4] Fix imap-send with reordered message headers
Message-ID: <auCEKSc60ZnLKjBE@pks.im>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
 <pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com>
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
In-Reply-To: <pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com>

On Tue, Oct 27, 2026 at 08:31:15AM +0000, Harald Nordgren via GitGitGadget wrote:
> git imap-send rejected patches sent with git send-email, such as ones
> fetched from lore with b4, because it expected Date before Subject.
> 
> Changes in v4:
> 
>  * Store the tunnel as an allocated pointer, so it is only finished when it
>    was started, and drop the local tunnel variable
>  * Add a test for lowercase from:, date: and subject: headers
>  * Explain in the commit message why dropping the From git-send-email
>    special case is fine for mboxes written by other scripts

Thanks, I'm happy with this version.

Patrick
