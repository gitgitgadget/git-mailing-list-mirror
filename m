Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119173D0907
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512553; cv=none; b=T0wTOrq3za91WI455FN+HoMrbbwpwp6+foIQiUoAe76z9aVRBm90WFuz9yYukCehuJfOoZ5qTYByVLQEIISxIDgMB/iqMJVD5JhmQR4+Cwn0YTIPF/pyo7QnvbqSV4FLz1gpiOwXTVq7EqlUgrrx6WSfBWE0gLMNPfVXaReSROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512553; c=relaxed/simple;
	bh=K0p6CNny74mROYdAbb33zc6ggv3LYv35riJMqPQAIHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRJ8t+TupS+/Y2ezqaeUL2KeLBu+HFW4fIjRqpT+RqaNPmMTOgfu8HN2iTaa6zrA71S8GQY7nCx48/oQJ63nokBjLNzn5ylkHD8iOkqXuwl9BxmPx+JNNYpBRRcMoFgLw9Q9asWsbYywTiTLvjtnddU7tpa2Ls0sPMin5Rdm3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zv1BpSS3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I3ADBBlN; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zv1BpSS3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I3ADBBlN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 37B1F7A016E;
	Mon, 15 Jun 2026 04:35:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 15 Jun 2026 04:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781512550; x=1781598950; bh=4d64BKeRpn
	/x0Ro5aEy/u0MFG6ZSiHIhDXEu8WuQZ/o=; b=Zv1BpSS3WytelWM3E79YxvKD9Q
	TgWaIWocCw5777A4vs01L+xMawK4aior1jUdoIlaAdkJnqZlTRzd9cpSYbfRPRFI
	W+FOT3KVZ73Sk2T9+ytgOo5Yd227RJhKjpXkBNzpipgizWcTwqj2hxNTXHizmvLb
	W06PZ30rn2aC8dRaUaalMmIfWJpki90PxE155m8XtdoZohX7tC/cUWZJaIGeZXfQ
	ZsH9cYeZsjchbDYCsMj2bnrcC72jROopYdpM6uwriW0rX+Cknuw5DMq8M3LdiAYr
	jkhjG7YimM20dCr65w0cg5ZhT3mPX16hJD2gNtCcDRhc+Qs6gDKWU/YYlGmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781512550; x=1781598950; bh=4d64BKeRpn/x0Ro5aEy/u0MFG6ZSiHIhDXE
	u8WuQZ/o=; b=I3ADBBlNVgMJw2+NkUI33GPBU0cN9WRFzjFJtNHOBS7PGfRu0Mo
	OBdIlEQqFfJU+Hn1sVUUYrWIqEwe12ADWlFVGTXJzQegy5gP7Lt5FE0/aDtySv12
	MEteCld5s1Y8pC/2VW+syriWmxe+IhQlDLlIJ1Qm5KcqV8sGd+A06dLVs5lCPFq9
	fVBUx11x8kkxQxvxKYFs964LgUwzI+q3I7zI0oqIVPkyQr+4HrVaVGo9039LdCUd
	gHNTjUs92ISsVkykXeovWmWCsGwEXCGAXsAs65kXAmOLmGMBSAhguiMYAnI876CJ
	Sh6tfWF1Pte1mVAZtZSMqXS5dKUDHU/TW0w==
X-ME-Sender: <xms:ZbkvapB72UDa3rhwK3693QXMdd0C18Es1eyTB7B4kFIUGiF_b_CtYw>
    <xme:Zbkvaui8iy0VtL_DUKVTX1wgp_uZIyt_ZM82w54i-FxHi9iU5lK_JmJ-nYrXfNYdU
    94JS7qfb8sRdyDlvShjWB6FR23VWJVJiD0JJF2bUAfH3UXAp7Aj>
X-ME-Received: <xmr:ZbkvapnsAbTj-LQ26FqulTRd4jgjb_UjLYfJbwukVxxJQK3Dg8SFsYjUkvs8afXHw-ruBVG7Rz_LuDfCa-m3zJdmt0hs2b7I2wQKWRbV8Q>
X-ME-Proxy-Cause: dmFkZTEdTDFmUVd5nxqOwIS2isw5rik562Vw+tM3mlXlZeBQJftiVRk9yM5D1MpjZyjQ0b
    9NsxVLWu94dmCdrmiAebiFDtc9BDO9iPsnrHHUWKj0NEKhzUaUuUwbK1DHPADf/18Hgdci
    de28YDHJBVmD+Ewhn0vT/9x4TukNAIAu43KS9X9kX6bNZkgeHfHtxOkbcDF5LpCeMurmxY
    0mD9N9mK2nTfjIzHP3x6Dz+QlAz/DgUUtn3e0N4z+4RAYMN2etxbaa0OH+U49qwPIDevr6
    YO9A08917HPoAA3JziChJ/0NQ3B0n9ifqpKfVGrRlwwfKYdpMhva95md8osZBe+whsQqYL
    dokJYcG/htXpcTDppaHmL+k099n0VOWoNs+xRXCI+az2TluCgg98CaTOlc0heRorQwSKWJ
    s1TnUN13OzLRk0J+wcB5sM4rz+ilGmZ+6YzO9QtxsWVs3qZjokMrhbKQOAd4KYoH8AQpmp
    PqCnQIgdf76pSuOkq+RIHjWxDKgOIrjANY9JFZR8c7mY04v7kDbQZb7FzZliWzI0vXpPUr
    84QH9VgKSokxCuBu3eH/licHrzRuU/sZqtEMkUtCNNyAJkv5585p/zkshjHgssaUi07hVD
    ijpW0qzyVo/uIDd2NgpZYg1fK39k93pQ+lxzMBBnuqitNTMUxKcSvCj5vYgg
X-ME-Proxy: <xmx:ZbkvaipBjwO0zyzRxu0z1xlPdD0SnEoqL6Sr0YJZr7aJ0pKnZoCNiw>
    <xmx:ZbkvaqGwg2TsTet6Q94asWuWcqn91CBCPJOYtw7_HDE_IjaoCIDtvw>
    <xmx:Zbkvamwoxd1iHahdNgPi9bInG8VsX6OOS2py3s34ypjfu7QJmfQWiw>
    <xmx:ZbkvanpRvgLfiojR2CHUMTdu02tGUWnkdSdJ-d-E_FZXNvU1l--gXA>
    <xmx:ZrkvanfcLjXLcmhfmhaYWkjOTuXFDTjRE-mw3Gjy9Eh12cRyykJnjUbx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 04:35:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d83c234b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 08:35:48 +0000 (UTC)
Date: Mon, 15 Jun 2026 10:35:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
	Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 4/6] hash-object --stdin: verify that it works with
 >4GB/LLP64
Message-ID: <ai-5Ycb9K8waAldY@pks.im>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
 <ba629a3f03d59b6d20f1199ec86c140b0db63308.1780593313.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba629a3f03d59b6d20f1199ec86c140b0db63308.1780593313.git.gitgitgadget@gmail.com>

On Thu, Jun 04, 2026 at 05:15:10PM +0000, Philip Oakley via GitGitGadget wrote:
> diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
> index 10382a815e..59efee3aff 100755
> --- a/t/t1007-hash-object.sh
> +++ b/t/t1007-hash-object.sh
> @@ -269,4 +269,12 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
>  	test_cmp expect actual
>  '
>  
> +test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
> +		'files over 4GB hash correctly via --stdin' '
> +	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
> +	test_oid large5GB >expect &&
> +	git hash-object --stdin <big >actual &&
> +	test_cmp expect actual
> +'

Same comment here: can we drop the `!LONG_IS_64BIT` prereq?

Patrick
