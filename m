Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB13112BD
	for <git@vger.kernel.org>; Mon, 11 May 2026 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484162; cv=none; b=hsuyP9+4mpwgON2fW0j3d++Gh6CdUI6vlJX9bPIoVfGORsURf67h3h7c3QjdHQGNxcVCTSomibG8xQ3iNE87AU6elyEEqTi9FiuzVjX7SADjxxn9iAAbsGC7CgS+HT85RwhHUi3lhXF+Ah/yjQb+1p33veJzqCqnNyyyc0cFi7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484162; c=relaxed/simple;
	bh=UXCqG95gMec3KVNahgC2ZcFqJglFYzDuOCztDyDLWNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWyW2FkTIEQjd4SUfgS+t/9Sdt7N18ugZllI7XCLnqJa5thptbz/pZq6RcmPoEPQ29s4xZF2M45DxI9gtS2y2L0bcF34n1fxAo1Xt43UDLzhl5mokvvSZUZdXRzVcTptpkk2MD2+NRw1dy+js3/iYkBgpEyfruAKIf70RxXPc14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ax1dWz3G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yl8YHbld; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ax1dWz3G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yl8YHbld"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D389EC0095;
	Mon, 11 May 2026 03:22:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 11 May 2026 03:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778484160; x=1778570560; bh=lFzAxOaouW
	usNn+w0RZIOyCHq1JoIOkF7rEM0aI2l4Q=; b=ax1dWz3GMUCdRHO1v9OUfBq8NX
	3RGgk/9mcJ+11G2zdeQRJO63J1dUZlUWOd5cserww2Z98zlMAtf7I0iXCWjISLkQ
	eTre/XF3+BmNmYrNVLQx035r/25UIKvKTRLKwXzI27vnPR+k55y0hcz1A60XfD4A
	S6Vrb5UHfdXO+AmvLs/y9UCfoRDTyspkwSqoNgzlfSdtnaDielJ/bMgY/aVzJtMN
	XjzoPf+QeKyvhQiOL6dp/147hofFQdp6AYTSW3fw9pQ+Rd7aOWJMWNt/oNmTFD/2
	VP0T85e3Ykw/HeNB1NaCoPy+yMapPNWAGX0zQs4O1bxFvu19w37KSTCbdPnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778484160; x=1778570560; bh=lFzAxOaouWusNn+w0RZIOyCHq1JoIOkF7rE
	M0aI2l4Q=; b=Yl8YHbld1tji1LlL+52LUDlJPj65yk0Z02GVk7q0Vlh5TnXTcmK
	8K12EF5vx2xTi0a8Xx3SeA0NQklwn9jZ9+kYUKkQWLj8XRzC1+tnLK/vlNwQjw3g
	TG70ue3WYphNDz0LYCQBvhAHIIBfayUyEPg95CaxJaZBg1INolkFrfZBA0jm+4tP
	DfuSgEG9ftvuE15ijPwbo3yr6qI6w8IeX8JSycbu0hW2Bde31bD/lniyU5ZzD6eg
	cpLNI9heGbGFy5iNxQGINZpyeYxVNeBkGa5o/XPI+c+JSDGNT5/e1gcXCL6PuFph
	tREHTTkOj0mfmn2uMUjbb27yRSKRRmTYt7g==
X-ME-Sender: <xms:wIMBapH8_Q0Ww_MaxZgI6C7EpUMBpIMswJ5UupFbQex7vnf9_L30Rw>
    <xme:wIMBalzHjGvC68DxtWIj_XDV3wN4_eOwtZRuSO6Ck2c2u1WX-l-SliEHV65AJYkvn
    HUvDsVAqchte3nRNBjt_MVcAZ4fo3X43EmYlZsu8Ys3_0PD8ogpQA>
X-ME-Received: <xmr:wIMBaoiSWwuS7UCZ_Fo-rL2X_KyKDkYmYISLkexGXiytSUWRBCxz1GeFjFrabFIZmPZLwSLzAhOQuiu4-UXvDlTW7zA2f7c19S_L_jc3aQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrkhgrsehsphhothhifhihrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:wIMBaowXzgm3m4R1O2gcGsv9vcR-ab6R1ITARXMnFTPTc9bUK9-fYg>
    <xmx:wIMBajJKWd0_N3aojcCe1TSDRHoDoVmy1bsPZXKrw6GAkraHuqfpaQ>
    <xmx:wIMBanQEV0RKPMjdTyvq8_C4bn0vtDfVQbhN-M4Hv1jsRd_mA7rRZg>
    <xmx:wIMBajon0Gc1nUE2jMqjQrGmq6UTBHoIzg98TgZmq68rIWBD93xB7A>
    <xmx:wIMBarCkg5s6vlt1N1WHBIPFsmYBq4CrSRO4PLMnmKL2rwizzRrJcSIx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 03:22:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 33b8dcf9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 07:22:37 +0000 (UTC)
Date: Mon, 11 May 2026 09:22:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v2] commit-reach: early exit paint_down_to_common for
 single merge-base
Message-ID: <agGDu4Nc5sBjpf_B@pks.im>
References: <pull.2109.git.1778252837132.gitgitgadget@gmail.com>
 <pull.2109.v2.git.1778480348118.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2109.v2.git.1778480348118.gitgitgadget@gmail.com>

On Mon, May 11, 2026 at 06:19:08AM +0000, Kristofer Karlsson via GitGitGadget wrote:
> diff --git a/commit-reach.c b/commit-reach.c
> index d3a9b3ed6f..b4ca00bb7e 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -165,7 +175,7 @@ static int merge_bases_many(struct repository *r,
>  				     oid_to_hex(&twos[i]->object.oid));
>  	}
>  
> -	if (paint_down_to_common(r, one, n, twos, 0, 0, &list)) {
> +	if (paint_down_to_common(r, one, n, twos, 0, 0, find_all, &list)) {
>  		commit_list_free(list);
>  		return -1;
>  	}

Callsites like this are quite hard to read now with these boolean flags.
Would it be preferable to instead use flags?

    enum paint_down_to_common_flags {
        PAINT_DOWN_TO_COMMON_IGNORE_MISSING_COMMITS = (1 << 0),
        PAINT_DOWN_TO_COMMON_FIND_ALL = (1 << 1),
    };

It's more verbose of course, but that's kind of the point.

Only weirdness is that we don't only accept these flags in
`paint_down_to_common()`, but also in other functions that pass those
flags down.

Patrick
