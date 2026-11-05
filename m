Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888546;
	b=VgVHtXB7pCFTuJ6xc5eHpyXt7UZriooT1shL9uwcmnNF1MoZo8zDIqB+LRsIr9ixhWLw
	 1OKeQP1I8HJL5pFMmXPlDEHKOYc0EHM2M5LnjxJiI5t986QbmLHaWwKjc2un3/FoZH1Z+
	 3GFJsQREcdmUrY73FF7h246yCthJN4qPFTGR+JBoX5xOF+CQ7kPITfT60w9TOUPIHcXdq
	 5JCQnT33MUc0sxfOWo84x1qAkIUDKTPYGeajCjlE3aY9jOCqC+gg/QrYWGUPPLUdsT8sJ
	 wvaaC0ZN4RwC5PG/cAgZ/TYmB+CBA5eKn4SnvF8AjxkQoi7Ju3RtxmfJ1vaH5MTTGwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888546;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2Z0ZmUngT5iIdRMQT6b+VfrlZ+KKN3trMWzCsXTvEu8=;
	b=ffylIjA+Om6FzYYW3pHHZgcMzsx1Ucv709CPrXg3OO41eoXJKMrgls8TUvmsz0pA+q9/
	 wZjLv2c4S4w0Gv4t4pNZ/keaqOyTqWjYlpivfNyohRzIsIONhwptjQDHfyuk9f9IpARqT
	 HYlGPKnGehbT5GRUd2I5AdLpgEanvbH696DICVWtvIl5kwL5Ly3LUQMETLE11BU4OdAoF
	 KPqCTEJdx/wLTuXbm4EdomyqtvORvEub0+Kq8nS3XlpoOzpfvJ5zhgvU5Om4sH0r8nxkV
	 iuMRoWzcbth8KQ3K6mTK/qKQHuxGXXPFPoQzh2JH5SR8I/MZqJ5DyABxoMfV9ydwfnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=h0fMJb3z;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="lu/ZpIVv";
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A34606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27A34606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=h0fMJb3z;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lu/ZpIVv
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4DBC81400126
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 09:22:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 05 Nov 2026 09:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793888545; x=1793974945; bh=2Z0ZmUngT5
	iIdRMQT6b+VfrlZ+KKN3trMWzCsXTvEu8=; b=h0fMJb3zb661IsppnSWEYGEemg
	cuObGdV1/xLPNOJP14ek5IASRGtQO9ePPoT00FYCBGBJWHR5QvNvn7avVae7mtuH
	1YIZclaDJfwRbMAruCilCmuMo/IHZUTyHGpkBelw8Zeh37Ji8sqtaBbJ1/CKs+DM
	biPhc7U1DOqYWLkIS2PSiveWgZuvmA0oQmivc1V1Ri+DZT9pgqfCn5kMUe8LIYpc
	p1NoAkWFoJoaM1youMBwaHYmgw1A7fMA/3CQ84MIVZQ/zpVTgNoZ0QzliTUHSKJn
	v8BRvCBiMRjL+HXYIkOoKoqLpt59sBpFbEG0gjmM5JHG1CP6G3Riho+mIHnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793888545; x=1793974945; bh=2Z0ZmUngT5iIdRMQT6b+VfrlZ+KKN3trMWz
	CsXTvEu8=; b=lu/ZpIVvw90Iw18VtwONVCNFTwSLQZbP2PUHUaEL1WgE3jn/w+l
	fJuNQ+vypzRyFy3uVBhuLB0VCy2nfZNYck6YgJ7hTIryMaAvLGWGs9eVQ1ZvtsP4
	4b1PTlkRKkQvFKFizH3SDisJBvkqk+wriyoqlKRYUOPFU4wUqsbeA/9Z2twmuAfB
	xUGzWB8yDNeNjzf+/xnf+X2gl9NlrDoisfPWCn5Uf1s5hxUXLFjqmfb/NhuVah1t
	dfTgkVk+Z1M2TnZCoo3wKatRDKp7xMIHFu7MRrUEyQ/4jpl21BEvwL6uUFi80bY6
	DYG+z2zm09xK3bnVNWY4m+F5oos1vE0pq2g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793888545; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:az5hQNf2ewlgTXgkqNLHhnkYiwrXtp4Q1gIJDA2usI5vtT/
	a4AjWJy2MTrb2ywMqNtNqaEexfvuBqAHJUlzJ7no5L0Q0iGuQDtNU7PZXEO9H9GJ
	5mmnASOzCMIcW+g1a+WUFk0jBaAfa4fL9xxrDS1Ndcntiv4hxr0h4uJrkkNQ5A4r
	LzMyndy1BkJP5iuSisGAAVSV+KuqBh6XngNX2mkuH/PEFXm9B9jcjsAk0Xr+lItl
	Npz5Nd56iqVM7SKV4YOfBKU17d3Sfn40tpETnb3ADd0arOtto9M/3mAPfdye29Gt
	Ij4vDASKrR2CBYdCW9PvlYpWYJ9yWNq2WliEcbw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:gtt/TDxH/kjvYMYxYjvcimpQe37fbuUpoTjD1lXd1b0=:XE6O5zYPKJrqZhnrA+uds1PszOHDkBksipYrMZEUneI=;
X-ME-Sender: <xms:IZHsai1kC6eoRCKAkwhExlOAOpJ6yxLcbff76qpuuCw4G_N8eH28-A>
    <xme:IZHsakIQv0mDsGGOtXEQMq7RbAz5hHBA1F_zniT4u281FXMRDxKjrhDCGtEGm5cXE
    NS8QJedta12fZeecXZSUw0r3cNWhCsKyKZ4VUeuSORS-d9O1U4chw>
X-ME-Received: <xmr:IZHsahH2WdvUc5jE1jysslUQ5WnicRrSnbNQIO8iQ9wIUyguQhC6iA>
X-ME-Proxy-Cause: dmFkZTGyx3PRk0ruKkD704WaM4BAaq6rLF13Df2Y4VRxnSbmnK6mS4JysAP/WJQg9kxSmD
    uS2R2XRkst2pLpGYdxZDDjMcnkpJGA+UIjX+Nb4D3ub/PLrb92Yz8EZfdHrb3SbqcTfTkJ
    /WmtekMNwypfLKIl5fcWwZTrzGoBBhVBcK2zB1NWQGeUDxpI3uvK6PzfbOEsn3gAwka393
    FffOODCny0m/Yh75dJoz9m+Tahk1P9kgWVkCEFaHjANNNi/RsjAvjpV9X3SQyboyKfArI+
    NcxseeTP4YVqB2CM29GMqStUuoKjI81/HhoCUqmx6BVS7ZnkAqmljsSw6+5MZWTly4m1SC
    x+Xj+nHy5gKYY16ZFqcBggU1eu/BN8dXsq/RXI5j86Rk0h8hmxFZqZcj56bcjmvxPdaN1v
    bYmT/9aD91x0V3OqGQhUIl1kASXZ8SJjvrpbcCrnJz9CDHwk6azpZkNPVyjtdT+feacNFV
    kiCJoAKaLL5WJGuvFLySyzv+Q4qdxgY86FDGbkz3iN1hkSLmET2YMqUo8j5Rikkc7dRtUs
    wJkQeRJqRTwE7NGg1Ii4fTG+EwqZLhB+vikna4L/MiQRrGtzE1RPxtFZuuvHCLBlnn6yox
    athgg7HOXkEGOtdjDHbhTHctfLI9/tcPL2lKSuGfZQF2rvGSA73fJUDRaabw
X-ME-Proxy: <xmx:IZHsagUp9kJ8WKBbQfrGirJguh_KFu4TKP-L7zJu3sP_7nR93k2N9A>
    <xmx:IZHsapyDhPqsY9mMI3u5tw82X6JC_PqpPGeVHBrDIyt4bVCBECdoqg>
    <xmx:IZHsalQvMjUcY_cTS9dhQXUO5dY5HhUW9dCnZr5PLoNEt5h4lcQu_w>
    <xmx:IZHsaljvFrldQRfcZgKAn1aRyXXffNX1IkoussW_82LOxd4LnGwXWw>
    <xmx:IZHsatVzusgnOfgS0rcW0niaewFzMOa5W2ywrKBajcpIj4hb1lhLq-N5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 09:22:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 076dd093 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Nov 2026 14:22:21 +0000 (UTC)
Date: Thu, 5 Nov 2026 15:22:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com, karthik.188@gmail.com,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [Outreachy PATCH] notes-utils: hide functions that still need
 the_repository
Message-ID: <auyRGpaHb5rdVP0d@pks.im>
References: <xmqqjymt94l3.fsf@gitster.g>
 <20261105074333.16756-1-okhuomonajayi54@gmail.com>
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
In-Reply-To: <20261105074333.16756-1-okhuomonajayi54@gmail.com>

On Thu, Nov 05, 2026 at 08:43:33AM +0100, Okhuomon Ajayi wrote:
> The helpers declared in notes-utils.h call into notes.c, which
> still only works on the_repository. write_notes_tree() writes
> its tree into the_repository->objects.
> 
> Passing a repository argument does not make these helpers work
> on another repository yet. Guard them with
> USE_THE_REPOSITORY_VARIABLE, as environment.h and repository.h
> do, so code that has dropped the global cannot call them by
> mistake.
> 
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
> This replaces my notes-utils series [1], which I'm dropping after
> Junio pointed out that the functions underneath, in notes.c, still
> only work on the_repository.
> 
> The guard also hides the enum and struct that notes-merge.h uses.
> All current users define USE_THE_REPOSITORY_VARIABLE, so nothing
> breaks today.

Hmm. Wouldn't the better course of actions be to instead fix "notes.c"?
It feels a bit weird to me to just make the whole header a pointless
include, and we don't do that for other headers, either. We have tons of
subsystems that still depend on `the_repository`, so what makes
"notes-utils.h" so special that we need to drop all of its functions?

What we indeed do sometimes is to mark some very small subset of
functions in a header as depending on `the_repository` in case the blast
radius of fixing all users is simply too big to do it in a single patch
series.

So I'm not sure whether this patch goes into a sensible direction.

Patrick
