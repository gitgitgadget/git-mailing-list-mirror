Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559478;
	b=mpiWBBpQ76p+501nYXLOmdOuH2nWcL67Vdh+b/2sBXSWQ2ocgFCq54n/xPda5OGSo10v
	 5UwwW7s/qfBVERZE59W6vs6rQMv3sxAWds64a6HJSJWxdqklGebWcBww+m2dn4Lr+nkMR
	 LUd9yynnsqrOe99ZEuZHYR3tlZsLaSXHPzGLOKjXX38RnNdFcdbNXsjbePZEq1YEhhGaF
	 9K9vdG1A6XfEWaNo/Mh5OW0/04EFisXqWRKD9QPmwEN3HPXuGcoCH9gUFPIJUS0Lke2mD
	 Nd/1mLUTchN560XiSUCkrCK9KuaUibKwuRTZChThgiZiZLYVx8oGW2/szOyUoBLhS6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559478;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=bJWNo63kXQn5Nv0Rjlj+Yu0lzbe9Cz9Y9RR32+wh84M=;
	b=tYs0mjjfC98qAxlLxoTRIox/LBN2dDLnqET7xQx6i5yKBkRlPmE0fd8goSciGEA6kZ9r
	 vp41Gn3LywbFxGuNz6HDkrGkiUQkA0UcLYNkO+Hl19MzSalgMtt5CYXT/ejEGFF9RoL9X
	 S5Qg48Mk5hEWrGmAxZhUKkhUGSDT9GE4GBSRCwC6RtSuES+FiBME1ETlzUoWdV9g8nTDR
	 eC3MMb3RrM9ZQoDcnaNGY1WLqPP1FTn9/Vm8QRIYACNbTZPNEZi581gu/TB63KqHinWpF
	 OncNB8qZIv2J1rhv7I07tnymvxXsSmc4ldKCViZbxKGrVOp2+ib8IN4pge6S7exEvWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RVyzY5ud;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vNfF1pom;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F48606A334
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 22:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F48606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RVyzY5ud;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vNfF1pom
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 71ACFEC0AB6
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:31:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 24 Nov 2026 17:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795559477; x=1795645877; bh=bJWNo63kXQ
	n5Nv0Rjlj+Yu0lzbe9Cz9Y9RR32+wh84M=; b=RVyzY5udemkKG9v+jrLtqN9zNU
	u4aO5E2AUriLttNxMCMbOjFulNTgyQq8H+i/VSRgb0vXffVZ0HvtoUE+XAO3K5fK
	0pCvibdb8U1d8Z80WBqmJe1g07dKCuRiDU5Ye2Co1b3l4xcWLU33kpwY9F6e3a77
	5MVfd4ipzQgckNdA3e6KkrmJROn43vMMV0vTTuLhfvaEbCgaY5/mazwFiGiXgXvW
	O000PhenWa8MSseK30Pqtdp8z75QWhF7ZlmfWETwklJSaHlsKe1SRgoqFsRql4ct
	DnPLaNfi/t4ECUNubghI4bV32B/0QWe6jctOQsdlKlkysfDQZ1Z423qz+NZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795559477; x=1795645877; bh=bJWNo63kXQn5Nv0Rjlj+Yu0lzbe9Cz9Y9RR
	32+wh84M=; b=vNfF1pomja8T/MhP/wkIIfk5bLf1sYZ6UqucsavQDUY27Jf+w9q
	l7T0+jH2yYeCbRRsuMnOWaL302c8akATaxfxq8zrhtJVQYnr/owpBKma84nSKkuh
	L/8m3JY6WXitXpbcfTELL2HUC/mEvagfO/Z+Mi0ZClzvZvwxP/QTk/u1wYF4fjcH
	mdjTqaSTuqSVAjoDEHG67ISwzdj0vcH7NdszudIkfHVOU8Zi1ZEyF6hPYmZdb/+V
	OTc40f0ZXbx58eo0DDORXv3TrCQO9Z9JGwIZUh3kr07Uv5LN2w5U1eK7bjaWX/5X
	RHracoo+EoUlePEbLhdTK4Uju9j/Yz2Ce1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795559477; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MXMuLvKr1k1NBj9LmVYKoUe52/nv5reRLGn0KBAhlQ/5skP
	LpWhVM/ZUFve7sXQuTV9ohNk7cW3B0mL0cHgWMj4m/j9fxBNmcJZYal7sEdnsFrJ
	yiEt7eO+heM12/BfguVVPKhskBoeD2qSMXK0lZGNVr3rpLIQk1twx9Lha7Y82TBp
	Ym0vhwhkG8O8o6W8hJod+wFDFkDpXlsHf7aws7zwZMOD/dsnH5P2J8s+UtMACJ8b
	MEPJw6GH1F1/oe1tILUyYkEmNZeKidnha2M7+Whr6PQf1J9/RswDwDFiJSIoz3bj
	4AzhTnUIGAGk2J3KEG4pj/2Ahpaz0k6vTpGpy0w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:HfMOeWlDEaWL4ddt7utDw+drCZLAFb4BPIG6CKass6s=:jytuTmSSdmQvJHf42WDRsmFgWwJswMOw/Ok+LvpCM2M=;
X-ME-Sender: <xms:NRAGa3oS2uQ883KsAb34liCd8jGxhT9VdWZo84_tnvrQWsJUQ0z0XA>
    <xme:NRAGaz5-uTDRLz4e_kI5ZECM_4cmn7Kd6AU1hiM21MVc4ijAx8vYCQm0h__BPwNbb
    zW7lYaCaoTn_Wisnzgkbz3Mvx2sXtzfoz3WvJSjsrH9juA9aExki60>
X-ME-Received: <xmr:NRAGa2dQ0na3_KXjxgp1S4E5VnqFTExSn4EjFZuvv1PmUnDRp16TlAmutrzrLX0Fb-vS-0H4yPEct2Bjg0V5_cf3ntAKWKyetk2nQuA>
X-ME-Proxy-Cause: dmFkZTEL9p22SRmekyh63/uZgmMbJ57IZ2D8Btdl7F4NFstMjOj1DE5PMlgrbA99Ozur2E
    T22Li6sTzJ3DlFg/xoKaT5Ra4Ljw/QRikOzu7zLpo7KRCFKhkiNX9inRXWthQlNwjUJQYO
    8UcIZOkQdQU0JR+1x2rEvcG5nXjPbw6J9KTMPqBiaKO9FgfJR4SGiCw80ue/y3FyhTsT2f
    tZFacQoMYAOa9i73idh9c1OoaWx8Ep9RWyhdzGeGn4QFG37V6tS/FcdmiOC+fxWM5f1feF
    TLXBhoZi3//P+PudU6COoTWwDk0MhSU4QioSj5Ih6AZBVmKsiWSCyfxTqWMMrJ+8ZsV9G+
    gWeSBG3hbSZdLYZkqedQMJuPgYfh5gk+MMEjZNgcahSjp5V0GGJw2qejxL0Fy2qYluW9ih
    VHZde4s2DmTWWE7YmZ6TQ25kZ9DZ75yBLVB2SHQ4xTgDl1KQ+6D4L2fDdMhGyka5rUuzBU
    HwcY8IBGzXcohhGkNncXu+satn4/Ty997b0DQ+hooQXYsV8IYYTgbMjHPPzRzJShMUIkCP
    4XpabF7LGabeqc6tREHs1/3k8ugjI4hd3ZtIViMJ0q7rqmW6w3C6guKz11od8ohcS8B+kW
    PZKwWNrPZPm2DyYcDvtNDmRKVk0F3wTtvpye9U4jMl0sbH0Mita4qk6JaaeQ
X-ME-Proxy: <xmx:NRAGaw40bIsdFVWSQYFhwLsCJZEQf1FW91IVBf75HBhE18K7VG3tzw>
    <xmx:NRAGa1uSc_zsuUZ6hbj7HUBY326GXPZtLYmIRAKI5FSFfigqEEcdjA>
    <xmx:NRAGa4hy5HoIWNJikA12ryjT7QB_LyEwHfxuebGFXd56HFrI4PAjSA>
    <xmx:NRAGa4pPZYvFt5G0QzUSmADFsZ1WsUH45k6leGGL4PVTUdnfMM5tbA>
    <xmx:NRAGa67O6adVAtI87-gxDyh6B-dBSuCi12Y-stESBFfrfUlUj3S0JqrP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 17:31:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
  Patrick Steinhardt <ps@pks.im>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v4 2/5] http: add exponential backoff without Retry-After
In-Reply-To: <fc5dbf8aea6cce544e091b578b585098849d0d71.1795103883.git.gitgitgadget@gmail.com>
	(Ravi Mistry via GitGitGadget's message of "Thu, 19 Nov 2026 15:58:00
	+0000")
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v4.git.1795103883.gitgitgadget@gmail.com>
	<fc5dbf8aea6cce544e091b578b585098849d0d71.1795103883.git.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 14:31:15 -0800
Message-ID: <xmqqzeuxkgjw.fsf@gitster.g>
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

"Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/http.c b/http.c
> index 0308f973a6..b766bbf035 100644
> --- a/http.c
> +++ b/http.c
> @@ -2411,7 +2411,7 @@ static int update_url_from_redirect(struct strbuf *base,
>   * Returns a negative value if configuration is invalid (delay exceeds
>   * http.maxRetryTime), otherwise returns the delay in seconds (>= 0).
>   */
> -static long handle_rate_limit_retry(long slot_retry_after)
> +static long handle_rate_limit_retry(long slot_retry_after, size_t attempt)
>  {
>  	/* Use the slot-specific retry_after value or configured default */
>  	if (slot_retry_after >= 0) {

OK.  Now "attempt" is size_t instead of int (in v3).

> @@ -2437,7 +2439,14 @@ static long handle_rate_limit_retry(long slot_retry_after)
>  		}
>  		trace2_data_string("http", the_repository,
>  			"http/429-retry-source", "config-default");
> -		return http_retry_after;
> +		for (size_t a = 1; a < attempt && delay > 0; a++) {
> +			if (delay >= http_max_retry_time - delay) {
> +				delay = http_max_retry_time;
> +				break;
> +			}
> +			delay *= 2;
> +		}
> +		return delay;
>  	}
>  }

Nice to see a careful way to increase "delay" without causing integer
wraparound.

Looking good.
