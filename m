Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215921;
	b=Z6KzfUXOh1R4aEx1UQtxQYIfa/buHh2SfkXPGQNGttrGOIjqvEjtYSHyeJftY1aRrmTU
	 VniQe58U0F4MBj2B+x9a6QzHiZOf+tH019X8635O5Wt+rKW4pzCLloHHc7kKmaBwCcT/p
	 TtKhEGPMtKXsLsO08Rf1DceEs7qTxJxrD739i5bItWih/D42hpJZF/Gdf/ue1APNG/O1H
	 PRZ7P6r2vL6hD2JRQ/MyzUUd5aAro0bXcXPUn0kBPdRyN5egkS65Jv7i47SxVmU4/cSQ6
	 fGLZn1NhAfH0WMaHkaWT+wKjNccxOGPhIrEEQunRvfbmhriCoqVEYCu1dWR+i/rw/2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215921;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eik2EjhAWMlt52G/PNSZDh8Nv2NGQNGsRjVlZrfsJ+k=;
	b=RZafxlIk2+XXG8bhJf878GdbeZxN3khF7T6hsmNtuAr47DS5MVNcfXdqIiQaRViSbMii
	 bOvnaRN3EkVTgAAr1aKf+WrK9loNCki9shqEL+HOGV6rhY251cNC1/L4MATYsorlhtJoz
	 xVkpCRxlA5XXUosvKQTar8qlr4lupFMCpLKQCVu74rNuWWxm0ystRHCv3kJiA1AJO3jQE
	 wjviV27DVwcvjKR6qukCKI1qz7uUTWmRRKHPy7jRjIurOcsdSqKA9Vq+thdWc7Mg8+rwA
	 qaAUxlhxRVfiEsPyeO5pTxIWV9VSB8y1u9Sw38fwu6OVNrRBnVPfF+jttNWjVtyvpdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=synmgBCU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=s2xHpqL9;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16EB606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 09:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C16EB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=synmgBCU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=s2xHpqL9
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CFDA31D00139
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 04:18:39 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 09 Nov 2026 04:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794215919; x=1794302319; bh=eik2EjhAWM
	lt52G/PNSZDh8Nv2NGQNGsRjVlZrfsJ+k=; b=synmgBCUocJr3kuIHBspBmUX/J
	rRlWSh37eAIzBpm0vLKCXwR2KnU1YawdTANnlOvmb53PDT9CrFQMo9PgL8w/e5Bd
	YFFlMWuypmeKeV7W3h5NBT0rLESHX/HL3hzYCJXeUGoArF9hzlPZMqve4LgGQTWq
	sUMQ0JuiZkQ0qLbNTGkrRPD/A6cDqN8Fd96pa++RMyn7GOwxTAmaFvP/d3kHpO6q
	6v/eRGr+rSxDAvTgGwnghcTo8LYfaAm6hdkRVFS8pRtZWjyLF2Mbq+9Ze2a+wyTe
	PlY2IxH1ncVOXgmh1M8PLuURFrtpx7jQtvyfpu4QHMyjJhYlc6YxhhjLV5Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794215919; x=1794302319; bh=eik2EjhAWMlt52G/PNSZDh8Nv2NGQNGsRjV
	lZrfsJ+k=; b=s2xHpqL9470L9D8/xIFOAQk6j3rDJc+0CFXrzlZCdHOHZGiGWhV
	hW6vnTvXz9Fuk0MDlqM5RzPI6Ko6pv0jqJL87Gkdj53+4U/r6Y+lo55k9AAqKoWi
	7/dZs3O0NRVfrvGE3MyC6N4I7S3vXDAPhiemnpSvFI1rlZmA+6M+vOXkC99dhqLE
	wnGfyhRFhtrfNn2yw70TvXW+6Xm+AGalQA/D/xq8W+tZvwkD02hhAeEdJJ2Q5Mey
	/k5V54p00n0QUFqIuFCO/ezYnZiz88xNfnNSWBk0PjLUIxsm4ml5ipFd79z6XyKC
	EHqhmckuZ/9Q316qftnlaS8z0UdU1aC1o4A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794215919; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ZYkcf5/pgEF7s9BFuL1oIC0I2tcy+vT2Mmuohe2kEu2GOr1
	wFMosL6t8/V8QuRiaL0Zu0x4pAscs77uKX8u3QQvOaMgLXgLbukABOB9bibcX+CB
	ceC1eMcuE2DGimMOC072bCBRTWvSa8CMgvgf61OuEhRp4imXTahYaq5v8/3vVUjR
	F4HUT3AXjPyUV2mMnrIUGV4Tr6Dng/QmZCph+RhQHkj+XFUEP8sAdwri363GTzIK
	OgTbYMHtHmQyxs7YaToHyP1otr+5/xFz6qxZTI5T2N42KNQqWWCl/Cmdsa100hUo
	3SCQx8xhK7HLVQeD/dW5/zUuO08MedGI1c3+N0Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:flVPkvkhiXxUuCbZjC8cc3zaqV7secOjy8+0h+8KoQI=:mgO6nikuneF5bM3stUV3fcqWodW5ZwUlGHHhcuTcEQA=;
X-ME-Sender: <xms:74_xarcE9GJAWy3OMoKNFX8s9mH6gf-upgyT_Em98KnqVmSyRAAMJA>
    <xme:74_xagRnP_d85d75Drco6ey8Oj6JSkF2unnUExCigqJpML-0lTRqLigOfOcHXHOuk
    Vo_sfznhjAi6qCdyoz0YEvEOFwB54UK8Oe_QIJv8AcUakHwubWu7g>
X-ME-Received: <xmr:74_xaqsyyT9YLg56_jWi4pj0xb7FW_JpQRh4sfR5T7-W9qUFunFzmgWaEzCl8NTrB0-oEwc>
X-ME-Proxy-Cause: dmFkZTFjAySho9RC0zUpSK2+F/qBmDqVoYUvU6jXkTblU0w5MJWD73wPE0bYc5UW0oUUN5
    a21GX97BoZFYroio3hEkrAM+dqC3hayLcIJ6OTxmEUuA1NHL0GMHZ5gpVEozUoNzLO7UTL
    Vs4ErhGttzxsBx5qruNZLGJ39mQlgYe2fMgox3V/Kwbb2QxpJhn9JuPZxSdRmL7N3q8M6h
    cXPbbXDvj2RubA5lpc/7/en1NpZPqO6wouMBeialipm9DymAGlYdW4YVf+qZwjvvAlIJXj
    cblgTArkxqPumjVqzdwJn6pPYOEZHGJJrod2SRnxxuWKk/LXKHVxxp4PE307+h546L3Yd9
    DlrTaOKS+033XXlrlbeGJiEzAlenvmb715TEEg3aagyzRUXmXLCqky8955brQsTmaNsIWK
    8e4nB0UeERXR59VEYqJzBl+fiFtKBjIduYPsESCdmorqxZYodW4IoSkdYdZlMHBNXDLMFv
    7P6M/CeosdatbMmSzmerC5yVxiroaul2FOUOEpv4kveeVkIHpYqPGNyKdLQb/b1yBd7tJG
    Rw8EvUih1aZH1gSO5LU6iG3dtDL/CBxVHzzCq8AINzEhzxlEqFG4+7OlT9MeqczQP0RDXQ
    Fte7gkbFHMnRCciYWShD8X1iKSYwbLkNfOoBWbEd0Wlnhjlx0P3QJkTIA+ig
X-ME-Proxy: <xmx:74_xapdSvWBbVUp71dZVNLYUKA357KI0L5hFmvvo4so8lHBrieu7hA>
    <xmx:74_xasZiQoZArvOCfTGhmQ6gWH3KamZyFjPWb_b2Yib88i-Zp2Fs7Q>
    <xmx:74_xajbwQXIKjir0TFNvhMiB9cGc0PtueIax5cUlKBqC47FZP6QSAQ>
    <xmx:74_xapIbb6x6xfz8HwN3c5g3mTQW4CKCxkG7oaWoOoNWEwEPwzDngw>
    <xmx:74_xao9s9EbFAdEGQYvH844WN-ON8LmtTYrC9fgHratlm6cuwQYgoRYP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 04:18:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id afdd99d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 09:18:37 +0000 (UTC)
Date: Mon, 9 Nov 2026 10:18:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com, gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [Outreachy PATCH 5/6] notes: pass the repository to the
 combine_notes callbacks
Message-ID: <avGP6txIm0tK377H@pks.im>
References: <xmqq1p8zw49g.fsf@gitster.g>
 <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261105203344.48513-6-okhuomonajayi54@gmail.com>
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
In-Reply-To: <20261105203344.48513-6-okhuomonajayi54@gmail.com>

On Thu, Nov 05, 2026 at 09:33:43PM +0100, Okhuomon Ajayi wrote:
> combine_notes_concatenate() and combine_notes_cat_sort_uniq() read
> and write note blobs in the_repository, even when the notes tree
> belongs to another repository. The callbacks are only called from
> note_tree_insert(), which has the tree.
> 
> Pass the tree's repository to all combine_notes callbacks. Also make
> copy_note() use the tree's hash algorithm for its null object ID.

Hmm. I was hoping that at the end of this series we'd also get rid of
`USE_THE_REPOSITORY_VARIABLE` in "notes.c". Any reason why you decided
to not go all the way?

Patrick
