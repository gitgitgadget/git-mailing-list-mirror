Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915757;
	b=S3zrOIXVjDv7iMdh02bCiTJDLXfMZG319p8CDHtv8ZQIdk/M/jqXtTSpne7QGgOaAsUs
	 Khu6+geDbI32hcBFx6nenfW6G6XktL4cssqiqybiwEHPSL1i7l3ONsIuQQ1gLJ7+385eV
	 MzS+exDxo5D09qso/nNRpMgaGYogYmrfluzRVVVTXTePI734qqVoUqb7F/T2++hh9L3x5
	 ymnnChHQ98Ne043GKB9kjKanWICeuF8iBpmzUNQWyo+suNFV6tAMOd0zsgmI5pfbqwEWr
	 RVU8AcTl/icHTznY0fKSeYXoyYTx/OM3BNa2FXkTCoJYPaPf9nr29vPRtQiYTl6n7ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915757;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=gWDBxdp7v3HeofEzGc9vuks/GHsWM2wvpOu0YkVHyM0=;
	b=yxdCy6EIpX23cfUsZhjMOR0Df5YnD14NeTSGy01unm3+94x0x1yTV6b0559QK4spsup6
	 VNRuBE7j9gQdiY2tUxi8zHBPXbQ6ch42281wCRSLPhwCX2C2dikeFcdj3rxuAWujfA0VR
	 EaP876LzC0u7GAkH6LL703LxFMBagAunK0YF411cKXUYPKS9epRT1fBsIBApsk2XhWACD
	 Ev1imEgTl1y1H+T4AGrejl23ojJp8iu0qBaxpEeP96MufgtxurK4IRxdpvEqBgdnrr/jy
	 t3yg4ac6EzaZPKJvtvxb3KLhpctRGZZYSb0blAZSR8m73Z7DGI0MVQmYPDI9imCu2Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=a+p5Nh+Y;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=va0pGdiL;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D25606A328
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 21:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21D25606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=a+p5Nh+Y;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=va0pGdiL
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 578B31400135
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 16:55:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 05 Nov 2026 16:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793915756; x=1794002156; bh=gWDBxdp7v3
	HeofEzGc9vuks/GHsWM2wvpOu0YkVHyM0=; b=a+p5Nh+YvCct+/0Mw4GSUVGAlh
	meDHZoSGjJuSWKn1Np2jcv98x1zQQ6WZltu+QVuo7qDWhuOlK5R+d+5jRsC7OFVr
	3hfBOLylH32joEuJDHVnvmanwCS1wByRZQtQJW/DtJvOsIIMkeT/g1ehNXPxE/4D
	Au05gT/W6thv7/GcjdjEMxbOIaR5X3npbVeOGMENUAwGPhJdMaITuVpLBgYF5CIz
	K/akdYoaqMACeunQ5LXs5YfvG9t/BJ6aKXKIp8RmmVn9XCy8FCZYXQmPFDtsps4r
	Dvv4eHpg53Py3ONyp1RzJ6nNH6VGlnKUAqiHULjAJg5KKeI8YQlbUfwBLATw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793915756; x=1794002156; bh=gWDBxdp7v3HeofEzGc9vuks/GHsWM2wvpOu
	0YkVHyM0=; b=va0pGdiL+N7Jnb3SwLi5eBIzU4K7mR9jWmc/pPVsMg3xdufUe1b
	GZ6mEBwEzqttoDLAG7SULBvfabUCSqfRVBY2bJRk/H4qmA8MkwJxkFbQwJaRBRhF
	PvCFOigUU5u3IhfdcYbICE4EIo9VymVrzQklg/RFUdNlwOa01/CE311LxlzuBS8f
	byfRphZs74hCdjD3Mr6AN1CI73BMd1rSGpMMQnmSPaueQVloLBeacAlf/XAkjMHA
	yqk7LzbwqocFIaryS0Mvd77FPqaXY0x9tatECxf1GTPWcC3/5vkPAL6dg/VvEigx
	4jZpsg403MmkcwB0gXmmdQ41x6EHy05vDeA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793915756; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kFkrzv67BNHppavNIP3Ng5nSPmvPLeeFEdSaxZWkLUomGPy
	AOsOEnMgCRUaqx8+ZjKKP88Sch/1/vCqLVKgKJZstzQAPNe2/cQz2yun9S3JAYiy
	9YLdf5fwBq5b9aN6mi7N3ygbfY+E3w8IwJ2PSwX+kK5FlZlOew/cCkGT/YesyBWp
	jBlCjF/0QJ8YJ5e9nfAHegeF0Y30nqRmDm+jRcAaC7xu9+GF+Z4T7KPoXuqIf/I5
	M0cAvUpbYxO2uXcc161UkKQuRi9oBIlg4HJ2+M1hXrS2F3D3vRQ4TpMqH+vudB9d
	Mr0VOzPucHHWycBUJUMeLCUY6Mmjc1Pl6l6YNXg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:3xl8nZe+u6CctHeuTpOW+4QTdYRAFipJAHwHiS6tr9M=:c1G+S1rV1COijgfHPXcZq9fGElGmmUto8gIzctJH0as=;
X-ME-Sender: <xms:bPvsat8FavKw-559NhZ1OnQdyilYXj2YVl6QKjnqnCYhWXwaD1q9Hw>
    <xme:bPvsaouaLaexZLAjZK1sGtWtYs7vgNCdUmv2CHnqxrwT5-LOlCdWZO7HMrdPOOxoS
    fE72LB8-CLM1JEpTI0IxMvui2C95IlEFDJGdKhZJp6PaQudCOw7rMY>
X-ME-Received: <xmr:bPvsagC9UZcwJGye3EKCsn0kFnA0oAnZJ32PM09OTqjDyL9HTSFcscbasPan0zc91DjGuaDb5K9e4GDpGbglwiCPPKfpJDZL4D3Y>
X-ME-Proxy-Cause: dmFkZTFZ8Ao7nvbEwqKU8lSiyzQAZ2WRSDIvvJhU4a3L4mxmV2EdTkV43Q/YQRTX08R1aR
    ZDPfH9hk+uV4X6GPnv4ce/XTxb0HKmKTk/TyWJgE4TqrYPUIEyC1MS25jLCgHS9IWyfJPI
    0mrNsGViSOnarCIq60pscegxoCjQ/x4Oi1rxBXIekgAG0uxeRgQmJkH7diIELsfwHJfyqT
    ECTUO31dOaoKuMMvgl4jCX1jucw4vnVHaHfWKbjNJJCcYbTuQ00fw0U0hMPu6FmyTyw31E
    hfePryM9xAPF8zBmRgFPudoKx8MuGoSgi4a8ReZC24OdCTAP+ZV7AJ80h4r2e9CUFGljIm
    Ez9p0A21zP8pPyVer3rsqlJpaHJxXyMVjFeFLAOr+1mnbUG/rfheJ9TRkvVDQLdijDJIw9
    b60O15zNAR9qT2g198R2/4FVYbdTeMZn+IjTqRvJW54qa8wrt/mUoB/MuuFMmaya7CHluR
    ovKZul51JULtSy5j5ilNgqDYKC5j7FUXAEo0DKW8tlLtaY91I1LdvVl1lcktY8GMGtZA/R
    tWxevkZEkvlpcXbWh7PNR12w85cmDUcLwVAqtUtpu50eis1ZlciIBpTkHXenu50ZHhKN6w
    cUo5EttSTmQoq2SR2okp/e4wRbukTZTBfrrMDwnFb8J9PGAq0RBa3tRBXjzw
X-ME-Proxy: <xmx:bPvsagWHu_J1sG7kr7M5XpI1o1vWy4kEkX4V41lluplXcyannFPlsw>
    <xmx:bPvsauAwBFEI3VkGnAAjoNOb509BTzlkiuU_LxIfMX8rjpGRzPYhng>
    <xmx:bPvsaj9dyN_FcI4xaC9vM1UoF5Kn-wj5QRbI5u7TMxZfZOWzgefueQ>
    <xmx:bPvsalFhFWx070NeeTVNvz1StfedPv_GOZQy5rbfUwUy4vaklLot3w>
    <xmx:bPvsaqi_dd20kiepQ97EqZK5XH7t01sO9khS5MV-1LFpMa-oKz44S6-4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 16:55:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
Subject: Re: [PATCH v4 5/7] stash create: rework temporary index creation
In-Reply-To: <b62d3d080a8ff0d9e14741a886aa45d70019bd64.1792767795.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Fri, 23 Oct 2026 16:03:33 +0100")
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
	<cover.1792767794.git.phillip.wood@dunelm.org.uk>
	<b62d3d080a8ff0d9e14741a886aa45d70019bd64.1792767795.git.phillip.wood@dunelm.org.uk>
Date: Thu, 05 Nov 2026 13:55:54 -0800
Message-ID: <xmqqmrrnq6xh.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> Use create_index_from_tree() instead of reset_tree() so that we
> can create temporary index file without overwriting the in-memory
> index or relying on set_alternate_index_output().

This is very nice simplification.

> As create_index_from_tree() does not
> modify the in-memory index it is clearly safe to remove the call to
> repo_read_index_preload() which saves one lstat() call per changed
> path.

;-)

> It would probably be safe to remove that call without moving away
> from reset_tree() but it is much easier to reason about now that the
> in-memory index is not modified when we create the temporary index file.

Indeed.

> @@ -1458,22 +1458,15 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
>  	repo_init_revisions(the_repository, &rev, NULL);
>  	copy_pathspec(&rev.prune_data, ps);
>  
> -	set_alternate_index_output(stash_index_path.buf);
> -	if (reset_tree(&info->i_tree, 0, 0)) {
> +	if (create_index_from_tree(&info->i_tree, stash_index_path.buf, false)) {
>  		ret = -1;
>  		goto done;
>  	}
> -	set_alternate_index_output(NULL);
>  
>  	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>  	rev.diffopt.format_callback = add_diff_to_buf;
>  	rev.diffopt.format_callback_data = &diff_output;
>  
> -	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
> -		ret = -1;
> -		goto done;
> -	}
> -

Yup, removal of these is indeed very nice.

>  	add_pending_object(&rev, parse_object(the_repository, &info->b_commit),
>  			   "");
>  	run_diff_index(&rev, 0);
