Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077139732C
	for <git@vger.kernel.org>; Tue, 26 May 2026 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830179; cv=none; b=Tjj11d95Z77zVtX3yY7XKFwZ4SqfCVG7N5pvuW335R03/gjlv4tf6mJqFesI9ZqMdx0KWzX56PC4Bzqc3RNYQcq1prykwAVUeZlpy7k5Q06/dLSJ3/V2/86QcP67TiDZhd2WfdLOXawGhGstnmB+6qSKTcxu6j/MXJrs6Z6nXc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830179; c=relaxed/simple;
	bh=xTn0aL8yNlEi8ik6z+n+PhyyZ56q0tNOceJJmPqWm7k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=o3RqBA5gLkUul6L7bATE7lDlTj0BsKkJUWOUjOl9nWAwaWtmaj/hT1MGqM3lexQbHUizBkSnM6k/tm9Uo9aZ06TwlzEMG2OSy4WdnBts6ceX8C6ZkvLBWVTQa3vq6OKZ4mWBpDmfmJVdakQFr7097UydOdlwX3vwZwYWgmFD1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Hxxz3FVk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JCMpLi0p; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Hxxz3FVk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JCMpLi0p"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 194F8EC0201;
	Tue, 26 May 2026 17:16:17 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 26 May 2026 17:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779830177;
	 x=1779916577; bh=A4AWJLUUsmK5zsVhUWOMpNVO4YDglgLDhBhITRdTjD0=; b=
	Hxxz3FVk03u2piIAwAhBfkDFnGvRXv02HY7+Bd50yNd7FU9wBKCtuSjptluaPdPs
	I4Nd8JcMkulekCv7OTLM7bgs1e96F4SqJ3zsyJwwGmwZMrJaVsIhlKFthX4ns2XF
	Kg5WWBN5BZt/C1HZ813FXIH2rXDXLa177DT+YOUl+1hOiEq7tayoP5qmtNs1qVuK
	OC9ruzmXV03tqJ5S8ESz4e+FCgeV7E/oAwUgTFHwsd9EGw+cthDo3feCFwen1lj8
	wOCvE5uGlmes5/3/DiXEkvpd5AuGqQl7kERrrSZO3Inr08jHRjmXJMi7dF6AChqk
	rAXsF0I/hUqW76i2Z4b+gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779830177; x=
	1779916577; bh=A4AWJLUUsmK5zsVhUWOMpNVO4YDglgLDhBhITRdTjD0=; b=J
	CMpLi0pbPZcpGhfDOfGjFXHkPiOarvSbbfUzzADF6TYFMpmuoHO1En535B2BxsMD
	kFFUsCFywEaQ3HSbFmZBN3pb4WpIpVn+uFbPO+cXPtMsz1zYXZB6kIIsCkVrxMgP
	a/219rymR25u0suueSoUAtIapohv8MnADtIdl3HODhFCRyGpz8V4B2BLYj6O4Osy
	zHGGc3HqAUc2BE28wDnR/lgPY+63txyI4J+FQ5UprdLo9FImbnwpDGoGytfX9ehM
	+UgPH8/PYsIbxQ2n0CdoVU6hNL5sSScosMyAsuu76NEQFETmkSYzbfmHSs/RcrA6
	JLpKZ9g97MLyhy04+Ka9Q==
X-ME-Sender: <xms:oA0WajTlVLQL6kRaOE2naXjSGVfRoSRkIqYxAc-zXaPUhIWaiB3dC5E>
    <xme:oA0WavkikU361hMKrb6orpOcDFsQUS_fkdo5Ms99Du5fCEZj8l2xvPAmWGfKbKlQI
    4s4zQ1EfA6IL7SipJ5QZVURlnoqCYyZthKju_9WPH8Ivy-hLLIqEA>
X-ME-Proxy-Cause: dmFkZTFRm34+dfkwYdYeCjOMlDMpG3Q5OHvEWOyPXrOLuxb4TdEhwa1shquhNTX7/spDTw
    NlLqzg8NciO0qxgqU0qMifMrnit+6D4TwOp9xJvNaBCpALMonnzORAqB/5QtjP2GY7HA56
    bsPQuGHJlXiKB89gDUytyyonAB3GZxgo9/xz+2Q8LftLauy5pPP3VJHfaBgngGUvKdHiHP
    bAr2bD5aSmVK1hOfRka0H5ybAMRwuOPVm7uXP59naL2VkPOsC0B/RFooMuI29+mrkHrERL
    /Q/VSDIQBdOamYKtAllm/1sp5X2g+pweJXV+nsg4TWfyQ5lpIX4kg8Dow3sWwt08nlDTTz
    cPbwBuSFVY9t2c6CeTYYp1tYts+gfZ8brNsPo3Sv/BS+IBonX0s3ZR7gb/4cwrNtpC4MNZ
    gMvvaON+6tgGh9yhsCGk+d9fKVE4fOoTCNMpjM5ORoIsGUhTcXBzXtHIY+jJ1fvdkOVjUV
    ECB7dA/XycPmCzqnhhkvVDk2JGsxCava02U6/4/knl9O5CDS/dw//AehRBwn1e6EQEjyH5
    nRskcjiT27H+QCDPrHZ4LO0J2Rfk4jH+BhAvNgkMhEAU/PiCbxMJDPtvlflgbfbU9bzzRx
    eTSYsLUlje/vonuRMm046ITuxye6U/qEw/P1lDz9T1bonoRuCryFOdbpXqmQ
X-ME-Proxy: <xmx:oA0WaqVAPm3DN3MH4LFUlD0a49IfBy1NvKyk_dU45S355GTtxMMw3A>
    <xmx:oQ0WaoHuUqULMWMTVZe4x1BfDZBfnlorcIGEGTM50-fQM7UnHMkd4g>
    <xmx:oQ0WaucvmdiF4DONxMJLHpVTWnP8mYR4mN3__0SryOblRgVp2nbCuw>
    <xmx:oQ0WahJJM1k-KhnZafrP0S5ALcTQZl0kaoBfXQiep7CLGHfOW2ixFg>
    <xmx:oQ0Wah2aHHG_EOjuLiMFS4rvD5-iXnh3ehp2ZNPljvowqEqzNugoGP3v>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E141D3020073; Tue, 26 May 2026 17:16:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdiVojqNARfV
Date: Tue, 26 May 2026 23:15:52 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Koji Nakamaru" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Elijah Newren" <newren@gmail.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>
Message-Id: <920cc022-8b63-4dbb-a41d-957ee01a5efd@app.fastmail.com>
In-Reply-To: 
 <034ab0f83822e6db67baa423d9fcb753b12b5ac8.1778107405.git.gitgitgadget@gmail.com>
References: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
 <034ab0f83822e6db67baa423d9fcb753b12b5ac8.1778107405.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH/RFC 1/5] replay: support replaying 2-parent merges
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, May 7, 2026, at 00:43, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>[snip]
> diff --git a/replay.c b/replay.c
>[snip]
> +out:
> +	free(ancestor_name);
> +	free_commit_list(parent_bases);
> +	free_commit_list(replayed_bases);

`free_commit_list` is deprecated in favor of `commit_list_free` since
52882024 (Merge branch 'ps/commit-list-functions-renamed', 2026-02-13).

> +	merge_finalize(&remerge_opt, &remerge_res);
> +	merge_finalize(&new_merge_opt, &new_merge_res);
> +	return picked;
>  }
>[snip]
