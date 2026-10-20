Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523626;
	b=GLBddWGgzB3KHkW1kxGSlrIE7ezI7UMyog5Oc0nYZ92pdGYtH5Lx65+7SAnNXqt6s3SI
	 TgTh4VtLyBB5K9hE9NFaAL8nsY+eF2E6fWE0cPxWuUzMteKKzqhT4kHCUzYkEdAq8Yrt4
	 WgRZZKSkpsTL+jI+EsM7BKTygD7tRvzTrbhVhqXcsC4cqlcMRPt3n3fPkktOiAPuvqhvi
	 SGe7SOP6wzvepF0+Qw/edH1DDARM7DqqliY1nbd9Olw5RAO+hiBToyhBElrq58U2dlTbh
	 c88ZDvK8+TGc8fotBKR5XGo4Jw9yfXPPUp30pkekPWZkHYJTZEL0XIN3ufMxNm3+VcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523626;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=A5iUXavLBN3pR42L2a5l4YnpDfuOaCZkaNQPdAkJBYk=;
	b=GX4PrFparjMJfP0S3Ftxxf4HVhbf1YoH6rDyuDtOr9okTQ0xKH1ddaqTxo9XAVlcbop1
	 SJsmt15GUfoE2EigFnIl7StBc0luyEewYyIAOjuAAhPVHQKGCsy3VUnJ4Nl82UMrHxLUv
	 u4yY5EjIHnSJS2m2nOk0qU0XO8Mqh37KB8OD+17rSODdNDTVfV/3+QSRMjf3Dv5fEEHiW
	 yrtPJfjTPHje5pa/Uc8rH8hFmNEuXnJ5p5OCChhZIJ3XW+62HnWHcl7GgTw+MHmcYHb1W
	 jptNfzCjY3aBufivAaeROYCwEXEaC9PHwGlDI18L8o5WuP9UeAsQVJSzbgMnDxmoHCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=j+MYhpm8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RJsAD6dx;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1574D606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 19:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1574D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=j+MYhpm8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RJsAD6dx
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 537AC1400135
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:13:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 20 Oct 2026 15:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792523625; x=1792610025; bh=A5iUXavLBN
	3pR42L2a5l4YnpDfuOaCZkaNQPdAkJBYk=; b=j+MYhpm8QePE4IAU96y+anI2MZ
	au+0MKErCu9/xkN8WDQw326CcTHqCcI8xqhZ+ls0vndLkhQpYD8sSOCLzkX1dFDU
	OVkXrN4TUwA7eZ4JaecoignDkOQJvsK1ogr5DBrbyFaXNQpgquO+ymzH8rTX9WFF
	ypzMc8/OhChRSpZOTpkRJicxnEjeXcsIGbGBVOllDshSmZMjS3krtwGm0g2lmDuV
	Rc052bFZDwZzFeZXujTvwmchhZsHt64R5FlsKomxmdCvUTA+31fIoA69GtbaKapG
	vPhGC1ZCIfrfbGk86i7hWi7wVY2EQpRMN50mhUZzHe9W1coUV+DHx/G/Sv1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792523625; x=1792610025; bh=A5iUXavLBN3pR42L2a5l4YnpDfuOaCZkaNQ
	PdAkJBYk=; b=RJsAD6dx8/cuYx9ZaTc8Nvd+g1t4CZ8sGHlM7GKm8X9tZH5aoCr
	YthBJgmYkjorJFY8Z4Q9iVnCDq25deeuwE3b/SrZH5UFxSj38xyXzNIW6J4IituY
	voxm+6Cs3RuLhjqjSmRqTr0fP4bdDh1HpebdDG9UxyrM95x1aU7EUZ1O4Rci9HEH
	ewlJzLXCzs59w8Ms+QzsH+mqD19vudOW8kCJeTbQw1YFGgvMrv/e+kFks5HciLZB
	E7iKoU4VH2fnUIPAAG3jVwGnxQLASeg1ypuhZvuA/Ds6onEl/y/ckeNtDtrqFPtb
	gpIuQPYP1uXw7nhm8dbwMmyRZG5qE6u43Iw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792523625; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:fnGvtUMKJ3GChLFFBmLIdtRMPeAFI7QYsP+OAg7V6ciTHaC
	SRPozHTjNWj+vYmz7PtXs+gls3sQMumZ1zutW/QEX7VesgvQkGxeYyc747jXHhqh
	Fd7OBWbEepGRwdJO/OG0IyR3oS8+OOaQaadgqzs3132hE+M66DaWL6ssIbCeNfUV
	qP0/2682FTdoMXSxI7Jo8c28jK3w8cpjO9Ybpd4KrLIVcFbJuk1K6fVB788wsR6a
	yX8VQxpK3q3p8ErtxHIuQpnpka7szgb4xtQPG5oFhu+9sVPkG45QQJV/caoeCT4U
	M3chFyCSuYtBY0DrJjqqguxiudEJEeu+qzNQl1g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ze3hQP/vDKdn4/KxIk5a7WYX38MRNRBKvI7EjVoyNpI=:jp0h0MII1xhr8HSPK2QIzYNZvKM7Tzegs4tvI/Zhn9g=;
X-ME-Sender: <xms:ab3XagwMwn7QMoObbc-e9sA4CFOo1KleieCrj9SwkHKWj1et3qSUrA>
    <xme:ab3XarLPru3vi0572C19VkYTm_MZ1dK1cIff4RNrhLh_fme_h45nzVan5RDyXGK0k
    zGp4nkkkv8A62SSgDCkhZ-Zilg-I2cfuu9cZFHMO_UiHdcdUzTwx4TE>
X-ME-Received: <xmr:ab3XaqrtMrl770szbWS_hj2sw_Dif8g0dgw3Tt0B_0uJhkgocPMM-q4LPSOtebiyXxh07Haq3KQRJ58OZzXfa7WUQFIqBCo-NFTH>
X-ME-Proxy-Cause: dmFkZTE+qmJ7nQtyRoO+u8uiOpTZ+kXnuI1aCFheKKNOL53Z8iAfyz5GQT28hti06ziln0
    1BDQVhClSmyoYbMqG2obhCtbxVF4oLwfg8mgzKhodmpbcT2J1wjSWEcEoxGHuyIbmok8Ub
    aK32vpCGkIj+UvYQepdX546P48i9rJN0s4KujEU4YN/ctOj91iceKeEj6tQmG64MUhI2/5
    Luep8eAuXprjk8tjkeg7YjAitEINYmBIj8jDlwQvjkK5dMX4j/Csfe7+eF4+nOPnkQ0t+p
    2zD1eZCZXLHIwp4TtTWWC22iYWG3CTh20t0gHkrG0BsOS8KNT0000DKIRkb3o0EjgSw+Vj
    IRafOTmxlVTiJoE+BI33cWdiceP97C0eW3FcjykXsWelVvtfeX9cBRgxu1eblvw0ilv7rC
    +ivTnZMKCrPihhkK8tBGt+82nDhmmx2t51QZMZm57mCvxnI/QDPbF1ktWYtjX/u3D8GQzb
    GrbgK/1Ox7Df7Z8QbCa8RBVuH3jY/pEb6QsvfZVmpGXPumqTqcv10Qdty7w7N+gX1Ze6Qs
    t7Jxwt0tmQEbF6bsm4VUslXzcfhmBVWmNbvKkN/na28GqG9hl/zIxxJnJK/z39CVgjzXOl
    ILP6lxElq8/nkI3L8o/NyaUmlo24YQuS35PZF8yEJPkvs4JD2q0zRaYokR1g
X-ME-Proxy: <xmx:ab3XaqIXj6Y2WZj5gvyDapKv5HnhlA1NBsVMGVzWqK1uXiICXsbMWw>
    <xmx:ab3XavRYlvRwlZexwgPtUBz8LTnNGhubWDvew0rWombaBam4-AyNoQ>
    <xmx:ab3Xaptx29Tqcv5p_H-X0F8AOu4kW8AgYVHIaqzTsZr6a39wQlOCOg>
    <xmx:ab3XagbpnUR5Jq9cM_QocccT8uoM_cZXF-6fg-Xee6lWuA5iHlGB1Q>
    <xmx:ab3XalaYuKHCFfWN9HsDJ1s1j2F2ee3kHeiEoWEATfIjjkgq62JJe4u0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 15:13:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 0/2] doc: add new git tutorial
In-Reply-To: <xmqqld7tyxi0.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	19 Oct 2026 18:24:55 -0700")
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
	<pull.2248.v2.git.1792421748.gitgitgadget@gmail.com>
	<xmqqld7tyxi0.fsf@gitster.g>
Date: Tue, 20 Oct 2026 12:13:43 -0700
Message-ID: <xmqqik2wuqvs.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> So far we've gotten 112 comments from 30ish beta testers who have tried to
>> learn Git for the first using this tutorial....
>
> And we waited for 10 hours after seeing this cover letter in
> anticipation, but the patches haven't appeared on the list archive.
> Does GGG need to be given a gentle nudge somehow?

Now I see them.  Perhaps the list archive, or its nntp interface, or
both were constipated?  I dunno.

