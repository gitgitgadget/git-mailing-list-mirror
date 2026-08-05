Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7975C1DDC33
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921788; cv=none; b=Uo5fhOqnustH2XDyWZyb5/7fT4mVozTEIBw8BkB/LenxlVbl0si4LB93wMSZaAWho1d4mmjgP3XGSQfuC/IuO5fwDQX20ZG9COKHwftbIM1YH2DmWpmk5U0f7+8+IehOy1pKOJypAGlzNPAEMQcBPv2zcw7Y/IBYdLz3QzjFOgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921788; c=relaxed/simple;
	bh=Z+Vkckw2oDgIl/OcCCUkQPTWSUHu/VHCsV4TpF1weyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPk+PZ3SRXmIIiL8Bs1ZnPO7Ux0CVoZGn8EJ7PvkaItza3mIjXzSpgPhjd8MDvLo8Q5zMI8tJQxudgmZLoAH6XH5RGHsmP/5Y2Ry+QewyY4Wavf4bHdDDBKuOr9eP48Zk0i5OOYAUXfFOxGnhVjmg8SQJSwCQvzqIAXHH5B6E7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XS2XZ8gs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UK145AUe; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XS2XZ8gs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UK145AUe"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9CEE61400135;
	Wed,  5 Aug 2026 05:23:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 05 Aug 2026 05:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785921786; x=1786008186; bh=Nrr7EZxm4y
	27ykpUmtHGFUFhvK+F5YiV9Lp9vwHYB8k=; b=XS2XZ8gsu9vWBDbSG0POxDwzDB
	RlZ+rKHafwQxeij8ZI8XZ1xXMwiQyFhYaO6aU/Abxs1F8pM5RpkSc8wtDpGYIsbM
	EmtRnWMACrFKiY2wAKIBWdAbo+qgZ7fqnX9dUYzpWNfKh+coXfRbnS92sqwEAZJ8
	UTW1c1435Wc4hC2v26jSwoKgKgsbpozHrfZcGHxWfKCMGn/5jkgffy4FQod8A0zi
	RCiP7h0oO/ECWUDcsxpI4jTMhEkScBQgxfvkMkwBt5m5d/qZmhX94gwIvIy5rh27
	8JI/2ECQF559NgiWOydRQFx5Gr8JoZD97/RoesVHQWsJuzM/F2NTEtinTMdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785921786; x=1786008186; bh=Nrr7EZxm4y27ykpUmtHGFUFhvK+F5YiV9Lp
	9vwHYB8k=; b=UK145AUev4GlZ2+c2UGCw0PTzIuqgLq6cnkOsWaZo1EWwsjNA/n
	gSfGxUsILD2sPWNo9/4kOpIO3hjte0OUsBeuflFV4mHsLO+/rCJYdgCxYhqUTT6Z
	k0oEEbB7DMSC+j4FYUU1npE863eGuG4PBoBvujRBxRXoVfUyre2XMaJj93v1nJQ7
	+DwFgwuICysi0HNoc71QYtkK5HcYD4EtjjWxkChNjfDB4youWyuYDCJScrUaHcfp
	L39sDu02GOmvLhyhfr15G0VBtNSr4xNgTU+EqjQuQEG+FFHi2xa8eoaqLaqfolnP
	ospPkENNlrAkADoj1N3F93x6XNk4vKy7rpw==
X-ME-Sender: <xms:-gBzam0BIa5lcIIMqp-vimP3eZx1kWV9mNE5IpUro_6shKM3GLu2WQ>
    <xme:-gBzagiBo1OES1Ft_7YJ9L0lysyvp1kWIU9lRmcg91SP3n_DjHVCWUH8pEOYlrSJJ
    GxRt9F_UOebUtIN6bAhT_8XwCF5GfxRBTcXnjpgQIMoQEI5B6hbCQ>
X-ME-Received: <xmr:-gBzasQoaZpoBWhehtWrYsSsPCKouhqYD65A0HAIRwgywHgFEY_hURev4NPSb4e91m3HD5gfdjOmj-qVHsS4jffMBlo9AdbPEQ_8tYjJTg>
X-ME-Proxy-Cause: dmFkZTFyIzAgb92UmTVzDwCNq439D/cqIDozpQV4mDedqx7VxzQEB9Ko4wtEijOsBFLQOF
    hnQCskqRSDxf2ESyNopWXpGt8rVYkJ80U1kxCvrCp7uVknXGSoQhoAzXJPd2s/YzlQrf3V
    hCQtYf+0iszNeFSCD2NDhhk4tB4GiNMrTwvChNLZ+0JOEf0Q0rxpEglC1vHNBMeglJneFO
    /lYFThYgOq4GoAfN7KYoLDWXVsDhY25IOuZqjaMqlIlA/3AWZvzDKpVPFekn/tsgebeM6F
    4VgMWAJcGZlgoxBY36BfBL06TkRS65PhpDeNZyqPFC8vS+oZr9HU30vJQRVSxTYh9XzLaq
    wsX18cbBmPSDdVEpu6JysiYQxwrWkRYLfADmgcJZ0YiebeD/zVwQZDCkpiZsGXK6ZoM0LB
    6nTvH/918G+j9h46cgk0x9J+vcesQGsaKSGlk4IH+N2Ou+3Lnhx7m1PH/+BNGfPrQRxO/S
    VsBvESFo4EAa6I/WiRuJbOgrd93tTohpcCLNoUpX2UHVnhMQda/IhCp/PA+GzJwF6/yqBs
    aWlNJwQnCZIObMXqcY7xZ8T066kgFLf88zpac+f7ve/OsifCg3rqbH49GnthciVYRrwBFI
    FxeRCvlcLnPOBwOS3yMF4g31oAJq1jOeZsN3s3G070ibyi7sCZjO3PkzEcCg
X-ME-Proxy: <xmx:-gBzahj34K5O1qHRitaIuWQwdBmBNNig9GiPffjXEH8lyth_SzmyNQ>
    <xmx:-gBzas5ASphUWFiSRmRCPAITJt4OTfOfG84yWg4bKHrMKjej-woXTA>
    <xmx:-gBzauAsUPpXvvUfcJV9IsV_gR2cXdblzDDjkxlyxj6zKdKM_SKJNw>
    <xmx:-gBzajZlx6j7_tl9lbX97UaLfgTxulRpvZmpG7vAg9lIFN2vNVJSJA>
    <xmx:-gBzaqB_M1q9I-nfP7Qd1AzqhjxphhouI4Yre0Pv2NjmMxWcqlHQuKz1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:23:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 009e39d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 09:23:05 +0000 (UTC)
Date: Wed, 5 Aug 2026 11:23:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 03/12] pack-objects: widen delta-cache accounting to
 `size_t`
Message-ID: <anMA9t5w4386Rm3k@pks.im>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
 <4ef28865498b33cebc954fccf18a3368f3d114b4.1783615780.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef28865498b33cebc954fccf18a3368f3d114b4.1783615780.git.gitgitgadget@gmail.com>

On Thu, Jul 09, 2026 at 04:49:30PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index e3760b3492..f89628a760 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -260,8 +260,8 @@ static int exclude_promisor_objects_best_effort;
>  
>  static int use_delta_islands;
>  
> -static unsigned long delta_cache_size = 0;
> -static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
> +static size_t delta_cache_size = 0;
> +static size_t max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;

The only other site that assigns `max_delta_cache_size` does so via
`git_config_int()`, so we happily accept negative values for
"pack.deltacachesize". This will cause a change in behaviour here, even
though arguably the behaviour both before and after this patch is broken
in the same way.

Ideally we'd have something like `git_config_size_t()`, or at least use
`git_config_uint()` here. But that could potentially break the case
where somebody mistakenly configured a negative value and took it as
"infinite", which was mostly true before.

In any case, our docs only mention positive values. So maybe this is
something we could fix while at it.

Patrick
