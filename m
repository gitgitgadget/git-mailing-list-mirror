Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220042;
	b=I3G6bR4b7ZIGXWBlvVC2Why193yOiSTT/4QiTTsHuhYVadO6H581GVx80PDEl2TY87F1
	 R1n7+VEC3mhQ3w90kjHlqnfJllIYRqr65XkaKtW2PR6MzD7HFbGZxZyNWPAzEuxxLsEgs
	 Tx+vhJc8ucStmCVfY4IQcssYO5rFWYB8NMEi29l8O+kewonxO8j2/OLBOvm7s2D5XyBBK
	 MOW3WKnZW72HprVKj9s3/nR+p2yu5h/eTiN9kgs54A99+aRcpF+gXAyfl3INQAksuUjgi
	 EzYYpL79/CsLdIEc66kZ4LI3vXWnY2tZSmT5zCbKxGW5d0++dHCUcGxRfe0c/Uqutgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220042;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=4UhRiryWh3fVLUaQl758RTfK5/fITHl3psOn2X/0Vlc=;
	b=LP1Nx1AeFwXq8V+Sd1oGGok9VGQSzUqQuDkDnJFEDUf/x+7mlC+6xOZIbWR9dlCm8Tay
	 nlf++cERewYXJAvcaYXjRLOxJx/kgWFart9KFZ+wHiwT/7cm5X3SHqD8UHYMkVQ0OoOtq
	 l5l398jl3R7YosP/pSWWsB5oJJOIds7VOMB4ElhLl9pYOvHjWMPUR9LZ89JwzSpSIWO8K
	 bXPj0d1ZTzxbZ1IMzxP4q+W4vjnSJinr0wBwo2y7jXipv/m30mNSTvg0c/0d0LbFfgR6U
	 p6qq104PWVaRDXlVhDavAZJkstZmnGWLLn1O5mntU2p/H26WLmqm6x8Zd5QQNM9MZ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=fSvNx1EI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ntZ5fh5n;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8C606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 20:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1D8C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=fSvNx1EI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ntZ5fh5n
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 27610EC0678
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 16:40:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 28 Oct 2026 16:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793220041; x=1793306441; bh=4UhRiryWh3
	fVLUaQl758RTfK5/fITHl3psOn2X/0Vlc=; b=fSvNx1EISUfXNu2s4NefFcPPMO
	upqmQeevacvu4mbB81luM31gENGE98CJJyovWvlwE4Csd5zDezJS8A2PzUNt0Ja8
	yJIXUJ4nAR1dYxYCFW3c4rS8npC27oFoNwyIQa4G6pgU26R64VxaMTR/ftO3/i6d
	4eblPGI3woEGWWrhrU24H/0pGDDZo2P0oYve7knhI0kLe1p5pE2dgwM+RP0ZMNyn
	0coljw4/G7gj1wT5hPpNB1W4BuTdBk3PKJDNSrGvf3lr4btOCfiiIrZj4ixRhMfz
	GOKaHgsbHJgXXfTQfrLBLZ0f1baTZo9esuXNFH4gTZjL6KWTaR3Ov+mRwCcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793220041; x=1793306441; bh=4UhRiryWh3fVLUaQl758RTfK5/fITHl3psO
	n2X/0Vlc=; b=ntZ5fh5nD7oTmGR6lnliICgWfm4/7oGBhQrz2tNjZbqQKYHoP7/
	GT6312SuII8b343bOoZAly8jkO59PYHqq3aNGdlKe6xrR+0hSibQ5iueU7KR0dZq
	KSS53J45FS6/GIwXp7i1OmOEMarAvDookiQlFQm/DZUspOmZ39kHKa3+wlFgKdZC
	SsHAsblXIrpHD2IDVaA2oj0QucVCoQ2HNzahOq9hvrpsm+8ZSbJjsPP0PofX2aTC
	Xz7dadzCxqGBOaRbbgwaNiIjIrA01A27p6B2ihQI0IuRrsOKxkXl9Jdc5fscNO13
	t+dlLDzi1LYqUTmtOV2A8ELZ/Yi9t36db4g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793220041; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:FsFZzNb7G/hRIMCwulbRnlTneaN54sMrfFLb/E1HkIqis6x
	B3t1/XRSyxxeI4+FIDcBG8tPlk+cPrf8U89uj/00q+15ucSHpkPs5BiY0pWUF4cB
	IDwSN7lZ/Yx3mc2r9kHN4SEOwPxpY3PqcD7zJTZo1icG73WhSUmAnB3ixEe2dzU3
	yb7kSjP4q3CPn9xbGK/0rdjwsskQDVt9/P+vPygA2BxLZt75QnScibT8GYBTYm8D
	58pJQfSUWFnpAgRDV/Aab7KPDYjS+uJxHz1G+YNda6cECeqXhBhomWP43RZSvZvK
	devEG7qUPFnDZHHJEqhVmvGeSiJzZ1r4QpojW2w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:g5STG2qLi4slPe9A6IxMkyqtwFZIEcNuBEFW5coye8A=:/CHkLm8KS17hqycVfKOu3dmc8g5I357znTgxSJX1J7I=;
X-ME-Sender: <xms:yF3iarkvIZM3EOJrK_0uv32NzL0zqR_2ej3p9KEGPXiLe1Rjc9W-2g>
    <xme:yF3iamR_X5QW4lTITHbKeiggZBZlMehPPjdCrFLtz0FxWumuHQCWbhaUbthzLqOIn
    e3NXrN4fBFwzvbjQIpUDYqrAa8a-XHn9jOrU5pTvgRBWmVQlrW_KHDW>
X-ME-Received: <xmr:yF3iavAdy1Vvx1jAu254hTDtildA4o-7NPQsNFV2NbTEy1chBBnfY-5yUGMRPwBxImUI4Me4ASrH9kWpFeTszlJwhjTjCJIQ6UJh>
X-ME-Proxy-Cause: dmFkZTF/ydW3vCItEK+V5iV/w3swrHwcwIgi41EroWx7yiKaj5EujiW5YILjh5B2Y/jPvk
    W6zJfU06FQzXp20hxknXJxLchjfZH5XdNQ02y4auYX+o4+IKoNId9ccfoLv8S2Xldt8rcB
    906oeyaqUpZq/NWVrQnPiK6xDdTUswmKvEaspTIpdvhmSQaowqAP7AHUSnie894GshsowE
    8LfuJqk9JAqvK9UKYePohnPZKdfWAn9/ImzPNIsr1tLRqkh/FerwreNZKPX+uTmYZE9/zR
    6h0YBJGc+p/NQbe9O6+j7Lb7PBWqbEo+V8WPaOnDd4bGOFwYzvDVnwTv5tP+YXiieOolHZ
    kc7T2RO3my/13qDHyFW3O5K/XmciK877pyofBxgpouSRuTSvLtE8w2f2Cm7eCwqaN0Dcs9
    Izpe/DoXyy/XDPEwh6G89zpQmx/HZ9XfqJgZyYd5TUqbi80dmOBK9j87npRO/zbAUgewPg
    vNHZsOa8G2cMymPuI2BMbogl7Bsne2Rt6ewZ+7EY2lpRK+YhSvX5kDA4GEMvNI+VfZyeSv
    VDFd/JyxnNxqq5KjT7FPuNs65QVwlEL3ThpBacwkOrI32G6KRXZyXhrgT/7qRrf6Gm/hww
    WWCzDPLhW+5ihkNr6r0AfrfRycnkHeDxYQ3xbIbvQ8/4oGT+HwtHUPckIVTQ
X-ME-Proxy: <xmx:yF3iatTia6a7jRC_f_XZEQl9auDaOxD6oq29_yZNHe6eq7J9PNGXyw>
    <xmx:yF3iatqHiyeBoTVolzg-o_W6ABEAfzB4moA-87HnOTcgxTPUV-Efuw>
    <xmx:yF3iavw0AIbqrfvBA1ECaOV_VODW9YlDrbrORskZAgBSygPqssjLkQ>
    <xmx:yF3iaiIB1Atvipo5ubLZqe7Dy1QvuuoRFvII1u4ximR-1Ff6-ZBlHA>
    <xmx:yV3iamZv4rW4JEqHVSrwduclK4i9fyCERUtELihx5wZwIMRtDBVP3-J8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 16:40:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] builtin/commit-graph: some small cleanups
In-Reply-To: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
	(Patrick Steinhardt's message of "Wed, 28 Oct 2026 12:57:52 +0100")
References: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
Date: Wed, 28 Oct 2026 13:40:39 -0700
Message-ID: <xmqqv76l7e48.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> I'm working into the direction of making commit-graphs pluggable so that
> backends can fully control where exactly commit-graphs are written to
> and read from. This patch series contains a couple of small preliminary
> cleanups.
>
> Most of the patches are rather uncontroversial, I'd assume. The only
> one that might raise some eyebrows is where I "fix" git-commit-graph(1)
> to only accept "--object-directory=" for subcommands instead of both as
> a command-global and subcommand option. I feel like this is quite a weird
> outlier, and it got in my way. In any case, I'd appreciate some extra
> thoughts on this.
>
> Thanks!
>
> Patrick

I read the first 4 steps and they all looked sensible.  May come
back to the remainder later this week if nobody beats me to it.

Thanks.

>
> ---
> Patrick Steinhardt (7):
>       builtin/commit-graph: rename subcommand functions
>       builtin/commit-graph: drop declaration for `read_replace_refs`
>       builtin/commit-graph: get rid of `the_repository`
>       builtin/commit-graph: drop global "--object-dir=" switch
>       builtin/commit-graph: simplify how we wire up common options
>       builtin/commit-graph: de-globalize write options handling
>       builtin/commit-graph: de-globalize options handling
>
>  builtin/commit-graph.c | 131 +++++++++++++++++++++++++------------------------
>  1 file changed, 67 insertions(+), 64 deletions(-)
>
>
> ---
> base-commit: 37b3475fb530c14109211faca33716a173db61ed
> change-id: 20261028-pks-commit-graph-cleanups-d1dc30f3e05a
