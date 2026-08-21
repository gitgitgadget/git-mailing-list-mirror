Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7A2ECD1D
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787314971; cv=none; b=GMNsBsi0Mk4vnLsMSRPeTKaSLOyM4RlewzutgiSrJRFY7DhsXgHzYObhLptCh2vMyaJCKYnkCLJLYHS0lT6eeFoZZlUKZAr0feUuqE1dXaKcwfWMj1XFv/urgfqZVNZMW2s5HmOdZRmtcRyTJuxeYZyVqaBhIV+A7RJMWgEyzmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787314971; c=relaxed/simple;
	bh=GOq9l+BqMLuEywR+q/CJ/Jz+L51uBukNIK6mCW9JOkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJmsaSXzT6AFx3xj2siyzgVAQT1EMcRb37lb0z9qIPhj+kk35aZyvmcKfwuFRRolSzYChWg5fEyaMvXWFS1Ej3Snut/UUetia1hW7XJEM7kGZe8sMZwtmiUmQGszeo+av4DcVveKmyX5s0XkSjZWNx/bpOBeHJwvupyG+YvvcXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P+mS2U/G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P0Bi2u9S; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P+mS2U/G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P0Bi2u9S"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E98D91D000C8;
	Fri, 21 Aug 2026 08:22:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 21 Aug 2026 08:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787314965;
	 x=1787401365; bh=kccXq+K78rFxA/CdgU3VxI7WF9YVHqS0YqklEhQQVPU=; b=
	P+mS2U/GxPtRZGAI1tdI2Mg7wA7MFuccrbmgsv6EZ+6nUTUHmMwV0S0RcVQfMCsf
	2zmjA5wND/lbBDPjexz6NiPkwJjL1ctlTHxRW8BNr9osU98TF7rTDTu8RoJ7D26W
	wdSlj5GqEAfkLXGd7rFMHneNXR3w3mkh2rLZdz04DBpa20FN+MELROdL60IZLhGo
	69ZwBZcnF/v3QITWLBCDDLA9yAWH1Y1c/TcT7jYDKKh3ipDtdoWlD+bgHklji32l
	PC2vDhp2mVfjG49Fuo/WbcE/XxdsynQBRINKInU7cdomuj7cgPV7lJnVKxo/+0G3
	hZ5BiuMtYxI3Y3+hxZsVLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787314965; x=
	1787401365; bh=kccXq+K78rFxA/CdgU3VxI7WF9YVHqS0YqklEhQQVPU=; b=P
	0Bi2u9SknGq4hWkNLLscWIweMsBaeOv5uUK3wWDdaOMQButAN9z3sz7Zi4WKr1Dy
	XpLaVuWHBswSRyEQ5zh2fgAs3sKdw4PlvUIKFOKBJoK2KiCoca9VCsSeSXHX6XKN
	rUiFUQKDeOs7Fm1yx2dTQeDCt/8ivMdnn3xlGhAfFABcxcDs0tSFsptDn+FJEWIY
	mTl4XoVO0ZJXTCwAG2Bs8q6DODTOGEg+Xlig8PTKB/qzvSn1nMhSggTGs0YCDFKg
	xWCEEGzp+j3eu8q8FHgiYMRhKkz3Ty07UkZSnwioBGyqmpXz/Xuy3lKuaZP8qKPz
	yxbYSUbbFtBrXSrwDWlIg==
X-ME-Sender: <xms:FUOIahephpRHBEep9R2_es6amP8gd11kbWlgNIYNTAXyQbhmaRHJ7w>
    <xme:FUOIamNpo2-kkYdvkT_5bqCf61kS3k2l3PsdZKPJkHbHhqG3eSqkF5pVVyABBRKyp
    y2eWJbxPGKLlyt1rHllrI5ooXfWW5P4jFETbpH-hyksf0IFsdUEn_Q>
X-ME-Received: <xmr:FUOIavjecMj9NfS9tPgmsHutV1dn4RlD3aSmS1gJaz1Yb50c45vj6lOTp8gpMjWtwKsUHCQ3dzFuvEg91FEJXdpG6IYBhscecHcpP9i_7SCv>
X-ME-Proxy-Cause: dmFkZTE9l2cM1M2igRlYAPqsNpQv37hFK8qRLHaKZnKBjvzIXEuAR1EpdjpAtyJC/IcOLR
    0TEvOvOvMouO+gx1wr3sGQvRsNZo2MBrf8QgD7ai2WnLLZKo+4YZCieYWrDSRW7fOB3/xf
    mOAGOS9BuvO00OjThh4sg6z87i/VD6zckQl+FpdRwqtk/51GCf8GsMUuN/KferpoAN9DaZ
    ZHV0KxTYuFFq6ALDSgwhzoA5rGzgVpEcdJo+u/6Z6WZTEcoXd8Vnl09w/nYT7XGGGr4raH
    3orTeUL6zyTatgg3c3o8709W0cfFW913yY+oCaalp53+Jz75gfTNJAopDOtMOi2o4fZRlt
    l4VIsBQIuNfWaI9E+Vep4qrpQw6hso2ain1q5F9nSSWn/loPhWfE2lhB4KrtCxR8pA694w
    C5TVI1zt8YAsrKA+m/UPaJVr35vHKEiCeUbJ/PiIpKi2kr3NsqWDGLSlak0N5VNMuOu2qJ
    KGkkMApQhtoEpZTg2z74nkwY5d/KAt7yo35fQYbfVpZdO6c+Gq0P0oNLFUvsNZ4JNjN8ta
    sLhgagPPYdn777ounbR5uAacN7Rh9n8y7PybGF7vQkZw0uUr7h6gaekwO5afcaG/gCiOKJ
    w3Ynjkm8yfWMXCoBhFr2DCLPTzR0G+14/pSzOP+2TxR4tW6CvSf8IAQdHrjA
X-ME-Proxy: <xmx:FUOIap3NITYs8MI_8USVxtBqdxCLGEmSH5UZZHwrcP-BO_Dhev_hZQ>
    <xmx:FUOIapjPHMtIDI9m1kITidq-zxYSZFOYbv3HGL9-3P2caPYJotlTzg>
    <xmx:FUOIapdBfdzRPirwzJkJWGzxNG2thODd1Z7TYAJCPbMuNPZn6VTFTQ>
    <xmx:FUOIasmqYVuwNhe-BjXqg1E7hd9cSI4y9Sg21hxyW9tc1HcGCAldAg>
    <xmx:FUOIamIvwYvVNow1vQwTERNQVsE2BtFnSXQZpShybX1HSLKzHVjDS6WQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 08:22:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 95e0f060 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 12:22:42 +0000 (UTC)
Date: Fri, 21 Aug 2026 14:22:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 1/4] doc: git: list gitdatamodel(7) as a concept guide
Message-ID: <aohDEKEs82MaWECV@pks.im>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz>
 <git_help_--guide_datam.beb@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <git_help_--guide_datam.beb@msgid.xyz>

On Thu, Aug 20, 2026 at 08:55:21PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> dee80940 (doc: add an explanation of Git's data model, 2025-11-12) added
> gitdatamodel(7), documenting Git’s data model. But it is not mentioned
> everywhere.

Nit: s/everywhere/anywhere?

> diff --git a/command-list.txt b/command-list.txt
> index 21b802c4202..63ae2a67c94 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -217,6 +217,7 @@ gitcli                                  userinterfaces
>  gitcore-tutorial                        guide
>  gitcredentials                          guide
>  gitcvs-migration                        guide
> +gitdatamodel                            guide
>  gitdiffcore                             guide
>  giteveryday                             guide
>  gitfaq                                  guide

Makes sense.

Patrick
