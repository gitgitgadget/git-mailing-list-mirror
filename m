Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793345055;
	b=CcbBEWfbie8d4AYBDuZhSXVq0Hnhgs4Hd5H6oKAeILtkt5jKw88UdXxXwyfcgZ4NnSKr
	 wMsMaYMaRb2R6QRPAr3UJU++G06CPDgov/V4coObPsCHegvN7akvkDvviaOp+okWIClPG
	 oSCKcXYTZPT7OlZ6ZmoFMuVvhQqvaStmBAM50ilMdtzNT55SJqkcMY+0hDBHWsHUi6XKk
	 JEQn8xw08JLmnRh96Kp1XdTlI7/0neUzLz6Ml6C9QGCrL9pWPargs2nG8pzm0Vo38L1eb
	 hkeRvNOmQKTuS6GJdZbe9dllf+PyFP+0bpRsrXcft8jjzmOMhES0/p3pvQ91mDBP0xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793345055;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Pl0VHUCWK5VjQfI9hlEhfyjv4zBsTZ7lHXA1OhTjFNQ=;
	b=SXc/CWOD5lH/wjcTe5KE19dSIrvfNnvnc00Tjg/oXXsAdWfqyjwi+IwMHzcJOHGV1q0V
	 ekT0i1fJS6lQ6Dm3mCVeAYBK0d7rXclSdIeQb34i6GHtoO+ASa4V7eV6eJS/C016bgwC8
	 MVXPfzmc/o8kzvWmRzSQ+lbB/G0BZJsa3ELV0Wx3nflJr+r3nn94HPLo2L3vR2HFibOfI
	 SVLMQYBxQCZ9DBvFfEpSepARUwkkstBM91Qs30yPOQXVqvaFALZuPL1JAw7NbLbRwJ7jY
	 1lJtZCFT0wuVPcBpFlMTVNVF++TBacCYENwp8c/pGz8CbNEeDKy+FozcYf4PuJ45/5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=gw0mi+U0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="Yk8a/2ai";
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ED2606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 07:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28ED2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=gw0mi+U0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Yk8a/2ai
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 52B331D00151
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:24:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 30 Oct 2026 03:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793345053; x=1793431453; bh=Pl0VHUCWK5
	VjQfI9hlEhfyjv4zBsTZ7lHXA1OhTjFNQ=; b=gw0mi+U029hVgMRlqQqt6nsoDV
	ueaYATUqBgHSme5TewWMC5PenarWgMZ8GlOqx9VKyFVzILAfXsEfqI9AmcRUVMjW
	ATC4VAVy4yKh3JHHTGL7awfbQLgP3jPCkuEJZBKgtEutscpxsY1gKU+8Gc911Yjf
	ZRfxqqnC/V7dETZxoC3U2iTnOY2UZIIpMvB7IzBv97i8MjZcBEqE9ppkwKjZFYJ9
	7uyo2tVPSjWBS/z3YK47NHzO3kHYclPsKYhGXfwh/nzHONDSdlK95qsrMrl9Qq4B
	JB+QBVff6/gbCfkPTwI4pUZt7LgNlzHF+0CHhLMatbsziSqHUedRL4+dLEAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793345053; x=1793431453; bh=Pl0VHUCWK5VjQfI9hlEhfyjv4zBsTZ7lHXA
	1OhTjFNQ=; b=Yk8a/2aiX0vpbCGm5os/lgzZXwc1iFjAUexz/cxZsmdn2n05t6B
	guW0go4/UVlENIQHSrplaBLvEq7g0/XmDOYDHQQaZpzD7ylTZmARTbf81L7Bj+5+
	HnVM+UfZWPEo/f+mbzMB0l4yD9N91Nae2E3TnLAtP1L2/Vn7EbrP1+fmzJ7vzFob
	ckoZj+6NlTRFCSpxrdZtrfpCc3GrVuL3YRhxbwN2Nesx1+OYuGtTx6TN+NHTH3Dm
	jMX2f1VxHGlfz94df64F/5pL7bAbQs3sYyE/DUzdJKPV5u8bLTyPU62oC75UKnXW
	izWxTQPGLUkrXNgDc3Zvo8xHgRBZjavRKDA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793345053; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IJ8Hjn9FCyBjeXu+N41blX3WqEGtoPe+5S/E6LZajTJH1Cx
	nrnxez1nCTosgait3tZvix6+sFSv2FsVJY+MQzR2zCRNNjEr1gqhWsdxeufSAg9R
	HDARq1mWsmocaStAgXUz3N+Nie8WcKaI+nklMDcFBdd+DtUuoayzPKHK214bgTIE
	ZXjRxQnqg+Hs8+TCaablxv0bXAEvjNpICM/aC/l6ocXRWH6cD4H8qMfqi4sYEJGL
	gGVRBg3O0QH9YZ8fMglDKCbxTLL+s6zC27NBPvkCWxb0rCNa4k6H06YXnXWyjgfQ
	rVEAKMwESiXmp/PvHZidQmVkP1wmrSKc2uB5tRw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:472YDk8A1udlGkzDayhhwHQqDgJN9F8BwrVMLrOu4rw=:MPcc+PkZLscDkM8rUqmBwS+Ymns0srsn7AWhcnDQoOg=;
X-ME-Sender: <xms:HEbkajEV600uRf29pG7qFmQHzJ0B2_IIcJYlGBPvUPufknypdNdzVQ>
    <xme:HEbkanXMfMxsC1oBMJ9XpsYK45jLqvJ3oSeQEFpr7-9auDlyg2ANJki23HxpE-9f3
    J0eRLQ818vhpmARoK__zR9Lk8ruY--mbY514n0u7ktn8MBYxKGqaw>
X-ME-Received: <xmr:HEbkaqI5mpBqjFiyv_-FD0cXjNlp4k00HsCXpTQRmW4TzRlHmmKw_x1194hSgImLPuA2Yw>
X-ME-Proxy-Cause: dmFkZTFEfWcn6rXYShZJbPO4PZUFYDJpdn/igaIp1MVd7ZaApI0Z8593kzpZBPATOZi8X9
    mPRIUqu0rfqzHIPESdoNxSYWZoMVKoqNHj67tm4tW2BhBwITUtEN6OuE31QnfNUezt94kd
    oaiFnAjneTfviQalUpT65lEIWav6ZDoq57Y3G5AA0sWWxraveEc2/bqbH+L/uB5ohn1XfG
    F0dFRJVslRVcFT/E8YJOEBIfaVoC/atT82zzB5+DrbfgG/DK9ADJ/w7iJ8AzLRwX5obVlB
    Sh393n+WKMlSQrWaI4g6xoqTxdu/kC1VgAYo7B83AV2Xqm/W+yeVnbn4ZGSb26rNPgeotr
    l9croi3neWiM0svGBWtfxNRUTVIQCDMo/jcsEMSwJdHMW8WbZpNq000a6kZKnthFb/apkE
    yoHf0PlwHIaQ4Sj6W4fd2+/N4LfJiDAwWYZl7P9bL3GtmS2EANQohZtchaHeHlGtnENJs+
    sLVlXvIpjPc/lP8ugQFt1/x/R9k751E7Ou0FTpRXrchHsY7H/mnkF7jAfsQFPePUM1sYlQ
    toYDZkPlhKwqkjaTZh06MjuJ1gQh+S+c+XubjEVBwYGGFWQmnEXkQ3YSK4R/fbH5J/Ea69
    66RhGin1ljsZTXXKgb0Z+ly3WqKga62URIL/rzx+U/egoblHAVoO2Vwu8zJg
X-ME-Proxy: <xmx:HEbkav8j6pcJHVwXQ1nX7arHREhhbvzlueAUsqMrQ5Wy5p8tGxbkFQ>
    <xmx:HEbkalKjXQnBHrI6N5_dJ0T-xWRviqAqwk7fj9QgqPoe5etAhN0pjw>
    <xmx:HEbkasmDyBfh9G34d7kYwxFmneJOdvTgk3Fq-SFQZX3Mv25rpZf1mg>
    <xmx:HEbkahPG_ZkQaCurOAadE4qFwJwPgY__W6eT4Ko6oe9Ju_ZuLMnQAg>
    <xmx:HUbkajd-0ThGTF-Mpw35RNQbwEfzMDTizLhdEcLH0R2gHw6_-w4GxcDh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 03:24:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e81ff74b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Oct 2026 07:24:10 +0000 (UTC)
Date: Fri, 30 Oct 2026 08:24:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Srujith A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH v4] [Outreachy PATCH] t0001: avoid pipes in test scripts
Message-ID: <auRGDmW0R-Ipn-gT@pks.im>
References: <pull.2260.git.1792299301663.gitgitgadget@gmail.com>
 <pull.2260.v4.git.1793284463139.gitgitgadget@gmail.com>
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
In-Reply-To: <pull.2260.v4.git.1793284463139.gitgitgadget@gmail.com>

On Thu, Oct 29, 2026 at 02:34:23PM +0000, Srujith A Poojary via GitGitGadget wrote:
> Range-diff vs v3:
> 
>  1:  a70ccdf49e ! 1:  4373eef413 [Outreachy PATCH] t0001: avoid pipes in test scripts
>      @@ Commit message
>           [Outreachy PATCH] t0001: avoid pipes in test scripts
>       
>           Avoid piping output from git version directly into sed to ensure
>      -
>           that any command failure is properly caught by test scripts.
>       
>           Signed-off-by: Srujith Poojary <poojarysrujith@gmail.com>

Thanks, this version looks good to me.

Patrick
