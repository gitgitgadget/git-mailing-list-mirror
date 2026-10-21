Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598462;
	b=cEFMF/2qiAUrTN+o59BB13VVH/H/2zcfRXpojrMGMn0OSI7eMwv4B5+nhZnqisiK7lxc
	 QFWJUpIJOD+IhSzbouTDfxQAU6r9/poQSwtGLNUVPFgPl5T2tAw54F8f9HZt8MBE5OgIK
	 wuONNDMsOmjaXV5PcD5SL4oVY1IkecKKhFd5Vd3tXs8lu8ca8urGXXPPOOoi9oPQl3LRz
	 7gK7kezcOzVfliwLALNQERUnnSC7FUi3elkPVlPOunTzh9M2euw9hUx9TsIKxEBRQf+NI
	 T3Tyqd5DG4ovWo09DaWCM2KoUYmBGh5AIgR2LCFR796aZbJz0xJgHQg10y+Rkz5FYNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598462;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=bX8rFm92zNszo8Q3+QmqlQ3PySfYGbmXfA7nvOyR6Wg=;
	b=oRlqhJP0+XTiAOP6FGj360X7BrPrsV81mDv2UxBai6I0UPk6h/4tpdROmqobSQxn46VN
	 tZ48wHOyX9bpm3EpR/NdjZx/euV5gLH/SRYkwDD0apz3Aj9arsgM2QqJ+iaz9nkcvbAO3
	 zpUWr11dE4oNHPdXw1ECqxc24w5NGi2l7JJKulHTCShlUE6NQEhfUZQBaY2zzshwg41i6
	 kHoPimjdW+MOxCi+OdoJ8LQ/4COryCUh8PbptKFhos/PrjUcJoOu/7jIoHNPuj7KpDYkY
	 b2NIQn8ua1SFlR9g0928hB++8UnDGbNrKp6Sb+k+54o77LkdWjqm6ENUhR7AtVk17eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mwSOhqdL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="oFxNL/1+";
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D4D606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 16:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2D4D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mwSOhqdL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=oFxNL/1+
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 24C541D00154
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 12:01:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 21 Oct 2026 12:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792598460; x=1792684860; bh=bX8rFm92zN
	szo8Q3+QmqlQ3PySfYGbmXfA7nvOyR6Wg=; b=mwSOhqdL8D0TpPCZRMTC3RglZ9
	6PW57ymX80ZZRRTMNM5SpKZf+wp1zv4cwwe+EM1N+YRitZz7FynjqLIkxIOHT8xo
	bsI5j4nE9Jj6/wFBMr8QhFhKML4JBkDvkAIafV790Tc8aYkZdbqsMbZsivjXIGPJ
	coDk+GzNwKo3xZ1TBc+PPgq9RHdE+N6zesShUi3SVsdnLgkclkYBxO6BVC0wzC5C
	xiWngyNbTpReguzsxjXt9lhadP0sUKYUY0yaqPaFVai8JVtRT1OzGovMO5x0IrsQ
	8rOwp3YwvPAkxZwdUzkUVjxVAdiSYyFVT0SIUTNTGr5fRHzFS/TZDZcaBf/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792598460; x=1792684860; bh=bX8rFm92zNszo8Q3+QmqlQ3PySfYGbmXfA7
	nvOyR6Wg=; b=oFxNL/1+QMFvv5X6hmCQJVHuyq4cDZwB2VUghpAu/80iYClQF/X
	v5SWzDPf7PRon68WGmvEZEMdVfFCsT/Erak8taPPZ//fIBDOaRzs36fIuv5KNj95
	hOwl08zQtAK/eH/10n4hxZst/4wKH4Uq7QotW4JtI66EWyg/Iz+xMNigbeudHE4b
	3mmE/fHAz9WMX60+CQf8BvvwxUkC+lPLYTRLb2LFXa7jQbUl4Hf9jA/b7H8KDO51
	tZVbMe+AcT2KyoD8kx4YKa9umSlh2QSFf54EYuEC+zOAk0eJMtZXbtEPZrCVaNgw
	MIBYucQzXX8mSmHElE/28oBN/x9g2G1F7bw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792598460; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KPaV7jWFpyAOSZN4x3iNb2kkB3dCYVauRpW0GSMkSuRK17i
	Envub8vHrweo8hqlZn0UsTK6HhqQXktLclaAuwFYA+zePmsduYyNPwssxT5LJAYj
	O5+b2BARyb70gRlJla/DOeBVgS8H1NCostMh6REdifkrpN0RP61Xtmpbf7jrws+3
	yeNud+k13pj2Z2eDT3KrOnHl10xMxl8ZWSkrBonJ48ncq1ijMSbKiuucH5/Iz5PA
	IMaReCblymd6FU2ITjxtbnN95WEbyRsYz40x1+G0ll57Zt5ztHQ+j3cSTeD6bo1Z
	+YvelG/Dx2AJa82lItFj0+9YKZSv6IhAsugriHA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:21NC6y6Zi+IfqPOHt/i8hyNj7zJ9k+uY7b7onGaQgKQ=:K6ju/sCwL0u7Ev+bZgSrPAN166/sPtcGY+MJ5AVhrM8=;
X-ME-Sender: <xms:vOHYapi5-tRMvQXW8yqq9pDh8-Y0g0my4iV7zdFExm5me481XQo5fg>
    <xme:vOHYatGQCGjW_v9fVHOvzQhFY05lJVP1016lS9dEOtOWBrUdlDwgnSSAF-jDB5GJS
    dVit3qPdbBMiuJQ7Ef_rZhXSxsQSgF9xq-jVCkrdp_npwMy2yzmXA>
X-ME-Received: <xmr:vOHYavQs-k-RNWav3LlMZP_yDmFfqrw4tDYXmONTlZjtFXjiPUdeVUOLhdRrhOwOs3dLZuDS3uGZDj01QvaGuirhEym9cpflvKBq>
X-ME-Proxy-Cause: dmFkZTFtICdopUXCWpelnkPYdreV2kAAy1byeo/CBg2cn91K1hYRcRZesqV/S6SgXw/j/E
    R22Th8gPXmjkEFoeGXtJSULYxgZu7YD3MKEXOEWjymW6mPlXDMhV4IMQroB+5XzhjRHRDg
    w81QVM4idaEDDq7RIWWmcsBFEWrlb+BNMULkU77SuwMrJW7A2VDV7VRQITguzsDYsiKRXM
    BATp6zjACkbYhiEYPFwbh8T6ue3fcmhNc72uPyzGA89+KsTVRzXXsMTHePIC3L6abMBJ0Z
    kIhYtUHu8RPrhcUXyGaDBdQIVJkpKa0sLmImDtn8ELp8m0rk85cg753FttCqWkNqYsgSFo
    /83NOZXvDk6CIdgzmx4nxeWMlI79786RtTW+oPlDnto+X6sKwrPJ+wpQh9oUUfGCsjt0s0
    H+jflM/0Ef9R0+VypcxWlt38v1NZEaB+qhc9AzmUKRCainCEAeEvnrKBE98vOXNEiGa+wx
    YP1/DZ99TeQMpsCuQFZb2p1INWV2EZFN07tV3FQBO5BNYsuBSpWor47zcovRW6fvQh3jBu
    8MefEj0ZhG+ljBU69RLh2VPj0uH3Rjj1guDjWk2C2AVkuujY6qTOXUxLFM1ZpF7cm3pL2e
    lWT5l2ilhMG95kKf08iWtg1leZih4YH0p7ZrlsDptfSxeTl41sr7NSd4eAlg
X-ME-Proxy: <xmx:vOHYaqx5wU_EVIHFF8hCfNDpwSiaY-INXEvWqS85MoXMGvL_GwxrUw>
    <xmx:vOHYarfkf0MgF2bKNschrLzoFJ2eLsghJoXv60XoTiBa8W4w0aOPjw>
    <xmx:vOHYatPJXBB8UHUkYDc_mEHG-9uIc3mISVx3QQR7ojpjZpTxC52D_w>
    <xmx:vOHYamvRHOChsocAOIDJ9r_T_LUZ0H0aFm9icd8gpEVHApV1aRx89A>
    <xmx:vOHYaqiLNUkz1kpbUkmS1LFdm8FUj9tpaXmv0wEoiAfv9qTwJVuMbagc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 12:01:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Roger Koranteng via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>,  Roger Koranteng <rogerkorantenng@gmail.com>
Subject: Re: [PATCH] t5301: use test_path_is_file instead of test -f
In-Reply-To: <pull.2269.git.1792488388022.gitgitgadget@gmail.com> (Roger
	Koranteng via GitGitGadget's message of "Tue, 20 Oct 2026 09:26:27
	+0000")
References: <pull.2269.git.1792488388022.gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 09:00:58 -0700
Message-ID: <xmqqse1zqc05.fsf@gitster.g>
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

"Roger Koranteng via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Roger Koranteng <rogerkorantenng@gmail.com>
>
> Replace raw 'test -f' assertions with the 'test_path_is_file' helper,
> which gives diagnostic output when the assertion fails.
>
> Signed-off-by: Roger Koranteng <rogerkorantenng@gmail.com>
> ---
>     t5301: use test_path_is_file instead of test -f
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2269%2Frogerkorantenng%2Ft5301-modernize-path-checks-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2269/rogerkorantenng/t5301-modernize-path-checks-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2269
>
>  t/t5301-sliding-window.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
> index 3c3666b278..b6868229bf 100755
> --- a/t/t5301-sliding-window.sh
> +++ b/t/t5301-sliding-window.sh
> @@ -22,7 +22,7 @@ test_expect_success 'setup' '
>  	git repack -a -d &&
>  	test "$(git count-objects)" = "0 objects, 0 kilobytes" &&
>  	pack1=$(ls .git/objects/pack/*.pack) &&
> -	test -f "$pack1"
> +	test_path_is_file "$pack1"
>  '

OK.

>  test_expect_success 'verify-pack -v, defaults' '
> @@ -48,7 +48,7 @@ test_expect_success 'repack -a -d, packedGit{WindowSize,Limit} == 1 page' '
>  	git repack -a -d &&
>  	test "$(git count-objects)" = "0 objects, 0 kilobytes" &&
>  	pack2=$(ls .git/objects/pack/*.pack) &&
> -	test -f "$pack2" &&
> +	test_path_is_file "$pack2" &&

OK.

>  	test "$pack1" \!= "$pack2"
>  '

This is an existing wart but we shouldn't quote letters that we do
not have to quote like this.  It gives a wrong hint to readers that
something fishy might be going on and distracts them.  We may want
to have a separate job to find warts in tests similar to this one
and eradicate them all, but that is totally outside the scope of
this patch.

Looking good to me.


