Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795229963;
	b=MXAdA7wUMDK6Ao/cnwfRpRdbQBoZHyIexqZ7SujzRhSlABRjzw7OsTik27C2llIbFk9i
	 cU904Fch5yUCduUyCUxS7usUlphdlnKS3ViiD/e5KK4f87N03cP45T+un+he7ZilbvEhg
	 BtTnFgvu3y+dRwlHuNiPFaYFiNwygmaesrvO8PW1Sc3cHwdIOznD0F4vezL0UovxipZYJ
	 SVWFFQx6cg6GgflJlWq3++8QJ2rVAFNjbAaxLtg3APhoTZwQBBk1TFger4LTWuMVycQC+
	 sXpV4WKIbnj5zmELQXY5Ew7aFB2yy0NoBktJAjpaOjr30hiujGpMVwKDKRPeEn7Izfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795229963;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=PR/viL4EPCjhjITiWPDJm4BLKV/++rh5bOq+4IJ2ZYU=;
	b=sm4W5ycrmjqt2rxniw23LCl0PRFRYGmF/ygBLeCOapurTm0GvZzqh/NHnP6ukIVwwa/n
	 30o1eFkxKRHvCUT1Bybwa7NKR0QjueYdvluaJSA3LdT3qM8yUF5AaHGTIVZplfYHVVbar
	 x4QUkH/rp9qnMd0maYrdEpdRfB2j25JbgHORQqisIukgxbUA14Tk9Fuw2G6povu4ExeZu
	 Wc7akaJOVVRGHAvCW5GxLwgi5tlNMCLarGSzZMhASmw7vEi840ShcgCxxKrW7QbuuSTW0
	 9YUS/UusZZ1pQAdkF+AhI+b9OKFeiZbwfeJj6/asY8iqCrqXbfVX9bbQCwwWi4JWixw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PuSweJmP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IrSnoawE;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EFF606A68E
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 02:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17EFF606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PuSweJmP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IrSnoawE
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C4E9DEC0AE5
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 21:59:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 20 Nov 2026 21:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795229961; x=1795316361; bh=PR/viL4EPC
	jhjITiWPDJm4BLKV/++rh5bOq+4IJ2ZYU=; b=PuSweJmPSPCE5m0d1shDybZVEG
	8Q8k9M1rYFPPlhrUQtfYnX9CzFeFdH39Z59RBJek2enK28Qw3oPBMPqryNr990rx
	397EMvfjypx4pRj3dXFVgYJcglgOpkdkvSxpjQiFOe+Gk7uM3ymPkB8RKtyHFyiZ
	gEPkOxCSaEWim1lOhpMnfZ4kSeTuLELFroHatGxu+dhSKXF6XbshBrFosRL6ZKu1
	goZxbnEKK/TB2CiDDnErOm8B9Q1akdADrfhlr+J4QqFZRyethuUvdD9d652c5FSq
	+qoHeqDT75xoBtbCBwWVLwT/KZX3994EAWUqcheeXjsMLokGQXlSmEVNDZOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795229961; x=1795316361; bh=PR/viL4EPCjhjITiWPDJm4BLKV/++rh5bOq
	+4IJ2ZYU=; b=IrSnoawExF+IO5JDyjkR3hLjIG8zRFkMDyQnT3W5KW55yUmcNkI
	qHt9wSppWcDTfslwy6nbMU/SYEqgAqB+SNBK3o5EoM8VuQV8EAfhjabHKrH2YE9m
	oGX4zMVnPNlwW0gEUs7yzYKMop6EWFbZIA//70a3GzOIkimsng0Pq1vMC13FYQfo
	d3UCyCfqak4BA969pyxxhFCZ2LPvRdOOh5VtoP+0iTpxxN4T3Nu4s1KmJcv20lYx
	ekzdwr2Eyzakf75/6iqEx5PUo7L0+n9bFX7B6ryQBEixwtXg1GvL0D/vFleNYk1V
	YWNse4h76ejpYW9dpk261V0mv4sXAPhhErQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795229961; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:FUuEv62ekCtIL0ozJDTX35GB4bmvAlQSiTsLijLLrDUOglU
	LSRdOW7pWfxs0w8v+HDeB/hlkLk/C1mbhq/lJncLHOJrb6HM0K+FZy9Om1DaFBOh
	nmMK4ouORmuRJtLOBOUohPKQk+7WVrFgGuzDBYHi+F3KLsdbEart4snH0vXHFxnw
	jyvimt1R7wU6hWQ0iSl8HOROfTJCp/r+TDKuRRp0OChpVIExkJZ39P6Vxbzomvx5
	h9QpyKCoprvwfXhd+TcvopIeVoF/2DjTp1b+wDkZ7aqQ8wAvOEyJFbn604ueK972
	K7bVR8PO7V/rFRvGXyI3XOq5got0n8MiZ1FWwZA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:bB34R/KaK1CXL1+rAcbJ7q9hUkK2fpZqg7XN6Xzsb7c=:vR69pcArTARiAUT9jOCCg1d508ZmTMnRpsSa0o7xSRc=;
X-ME-Sender: <xms:CQkBa0MRJ2UEue04k3LQCbVsV0kYroj6BRpEN0jkipmzTKVH7FWWiA>
    <xme:CQkBa-rMWSZ86WZjgey6--202VWZt-PNiluDMl_6y-Drm-wtO9jfvXR1_asLxT19M
    Y7_qQYxXJeFEScIi04cr0LI8De7JOVtVMkqR2xpBWoVz5MQYUYSpgw>
X-ME-Received: <xmr:CQkBa1HW0R7fBYbRvc4GY5WAPPCAm37Ew7CeX-rlG6Z1oej49V75l3JiUsYPYr71fzzF0WMLXNFFwEbFsBmBMISwh8TxnQMiSrnE>
X-ME-Proxy-Cause: dmFkZTEh44G9FI7FAReRjKPJYgc8Ut7BJ24E65+o3v2uxGpzEIPVB95FTeg89R9r0qjVrZ
    NfIkA/2v0aDlZxT90DOI0gtC41Ya7qKrXlQWr28k0X/Mxj2nabA1quEZWzNSTkuMKVGthj
    hPIh3iCOPJKCfNgu0wDtn8Vi2hvkj39+Ps7X7szWn2KScEMCtbKKScn6DBRGK7Px6vvqNB
    4pyaXuNQd/yekMPq41JQ6nXlAP52+h9VA1rtuRMMje933hZSqBW94NHSJL3VZVtjNsnbR0
    SMVJrGo+CK0rVQkBgZmAnnFg79xynrr31qWICHise8DpGxbE0ChRDJ0YMbyq6ZqLhvxYRR
    fOITu0zms9+te4lMKnS2PG4o/exNEw7Dd7yf7Dqo2AW7SoWvi/nA1EP+RBmsE3HWIRpHLu
    h1m9uH0vZegup+Cw7Xpj68bu0zYDKRmui6apqMQOZLfA7q3QpUwnPdhj896iB0qpofscdB
    cDPEY7t/Kyvhdin0ZkMCIoCVTy2QK/tab7ae+W0kgUkMdShHubD5rOMqrDoIRRGhAKeRdH
    0VY500BYH8N4XAOtMBoDHfl0KuAMtDLibzaLlDfP4otbafLIYcJrAO4gOlYveczgDfr4Yc
    vnrEgL8PG0oAYYT5lWZyUz8uCJF+FCJtXw6r5n8u6Y1m50jvLJahaKaXYy9Q
X-ME-Proxy: <xmx:CQkBazp2floYJTtSly2zslSZjTYGrrwoS8t0teVwKd5YmBLZ76HlWQ>
    <xmx:CQkBa-ZB_tVTMLynFEqoHGbs8x0ZdlMasEQ45MhuNEdtARGJdR3XsQ>
    <xmx:CQkBa8XRrk84ZvxC6taEpT7NErMLTrmDfTTiYggFZ2sRa8YWOxe55w>
    <xmx:CQkBa3_FikNS8qBOHs0ZWwIKDiMsf5_OTSUEACDMrMNxp-lg52MyGg>
    <xmx:CQkBa3HPY08quHTQcGYJbUnggEJsIXTj_j8d9vwkbYfgWlqJwmzp4Kj8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 21:59:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "Eric W .
 Biederman" <ebiederm@xmission.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/3] compatObjectFormat: fix a BUG(), wrong ID and
 unknown headers
In-Reply-To: <cover.1794932695.git.adrian.ratiu@collabora.com> (Adrian Ratiu's
	message of "Thu, 19 Nov 2026 16:18:19 +0200")
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
	<cover.1794932695.git.adrian.ratiu@collabora.com>
Date: Fri, 20 Nov 2026 18:59:19 -0800
Message-ID: <xmqqcxrynb3s.fsf@gitster.g>
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

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> This is v2 of the compatObjectFormat fixes found while testing sha1-sha256
> interop between Git, Gitoxide and Jujutsu.
>
> Because patch 3 drops a check that 08a45903cb (object-file-convert: convert
> commits that embed signed tags, 2023-10-01) added on purpose, I'd still welcome
> a look from Eric or Brian.
>
> Changes in v2:
>  * Check repo_oid_to_algop() for "< 0" and reword the note on which
>    rev-parse forms are covered. The test now writes the object before
>    enabling compat instead of copying it into the object directory by
>    hand. (Patrick)
>  * Match the "tree ", "parent " and "mergetag " headers by their key,
>    like read_commit_extra_header_lines() does. (Patrick)
>  * Minor casing, spacing, doc and commit msg fixes (Patrick)

I am neither of these people, but the changes looked reasonable to me.
Thanks.
