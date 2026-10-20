Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792533272;
	b=wGbY+/NDArk5zIYs86DRiRXyoSLvHawoetP7CNssLiVwb3PYXZGJd7+UTKKxey3QN/6H
	 +c+If0GCrE0mzCuF8FLwiKV/ii0Lxt6y0gp0fXWPqW0SBXYh36fvQEUNuZMfFrCkVCqvo
	 xiwkA5Y7wofOJPHIbD787FSLP0rGui1fABn1pAWEVTCANPyBXMEgYE3yWGBBuxReTpNIg
	 aLtRSVl5HEfCjZ2PcJDPoK4fIT7zBdPeP9h3uZLpSks06dhUD7/iMle7H50DR1YHZRw3J
	 WY6Ko+a51DdTkTk5r7HvKHPI0ckNXvKvwpnNtVx6ZO4iF3Eg7Y6nEarZEKuGrAKDp8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533272;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=zRAJTosSC2Vwkes/6eBcIlhU0pgu8xxK7Ei1Ma/vteo=;
	b=koopg1zOqeJrG7nv3FYwnpme8Rd7lCy1hJDIshQbCLjiPo/TIqPW4mNvjJcaRVOUR5IO
	 ltDxXYEHJhSH1+II8YYleW57yDFP/Y5itqx93+IyJ754PzxPgRUzcqjoJhUQUloUmrTxe
	 f9Sd0Vd81ey3JM928GQavZ8WCKQRreXGNAPmQdpzhIU88p3iS/saLcX6LGlsZj6MnFhMY
	 TQx5guc0YM+faa6hFMRMmcDrfoceo43hoRravNxO9DJ+643AvTzAmS7g2GVygXjYQJuat
	 hWdeYnynKYHcvN5WUgD6F0GWddlah//ykniruw2LtPeMNxOn6mVhIggJr4bTdHp1DOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=InDZwNFZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=m3x65dfE;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93496606A31D
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 21:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93496606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=InDZwNFZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=m3x65dfE
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id C65A0EC0508
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 17:54:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 20 Oct 2026 17:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792533270; x=1792619670; bh=zRAJTosSC2
	Vwkes/6eBcIlhU0pgu8xxK7Ei1Ma/vteo=; b=InDZwNFZE2HrbOtG+c2K+ip42A
	m2ARj5KIaiPUyBhnqP8I+2sqy5bTczS9As4v8FyrdDDkYeKXSyfE7uX5fXVbTjNY
	TLwprGeQgcIO2RsnAuNVPEbOgHK9TAUpr+IbZ/+MvBmakGyiVXa61/JA35p8Ymx2
	fh0CBPwFZ6K7BUiT3u/YoqVX+XWhkBGuT+RAh3cfdEvb9QFdtTub/kTkqC1YQQ1+
	kR3q+1lOFd/3L1lyTFnmIZfo6+6H7OOAbzy0vrM8mQVyQPo/DS4ajlchHSf8QdtX
	ufLXLQLWSR2X2iVCf4I0APVu6PpZz8vl+pcnocz/18/VI1ZfjsZ5zQbzp4BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792533270; x=1792619670; bh=zRAJTosSC2Vwkes/6eBcIlhU0pgu8xxK7Ei
	1Ma/vteo=; b=m3x65dfE8dvqgqx01qAEjgqvLhyy7gC3RPVqM8OcfKv9pLQke7s
	X7vAm1ehLAOfRDLCADZqWKyECmCsgPA1c0jwfMnckKkFpFU//4aFYJkGhtwF9Ynm
	lBNT1f12jM955c8P7CNGLWChwsWatYzQND+yF0axzTY7dpIF48v2gZi+ypFQp7tf
	qRxjTg8VshXFsS+QU/zF2VCpN4qgtPnBhA+ynrpiGvkDGOE8ySJzLpRFSBeyyGeC
	uIjAd6Wnu4yuVoJhoYKVUEgaXizZOJaZ6tLzVvC97Eqhv2LFiFaAMxQDuKJu3mOs
	5sgkrrU1zooZmgXEkBkVNZmxDkPCnpxueug==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792533270; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:aZlsCP+SFRxpFY+pO1GXkdTgsScGXVheEe67YGiC7VMBcQB
	7elzEaaVM/jEgI7Zc+gHcjLha7IqCabfZH6/v3qY0t20ovmE3jHH416oN9pYbK/U
	R0Di8yLYWlGn5bp9k3Z/fp76WFyTLEW6P4l/pfRVf12VsYOPAv3GT2fvVihcaUHK
	Yc9SrFRiYV2qWqx2jKuz9OaBJop1DTEkgGXbW+GIlBF8CBVv5A0Ia5EOQZ+y1e4t
	xCiarXMCd+AbyPVRCGhdzia8k3z2oW6Jln7Ovk1sqrnWgyVGf9Hb/NtViBpr8Kgv
	OMil/k8iLlIOMIcRMRYZp+rTdBps4a7tC9tdrhQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Esk3CuGtHHSjhR949ZI5JvTFMLbdHTTNPyPXAVYxkJE=:hPAy+B4y1N8Yk3vduWhzgz1MxllYJcfu7KqxBcCqqfw=;
X-ME-Sender: <xms:FuPXaiwYDcQcI-STbLbXprBx0MWTAHTnzFSfO1sljX5KzEzQJ7ZcqA>
    <xme:FuPXagjXqKzlEaIU_PT0Lyr2HUAQxgV2ByhDPmfw9grUCVNqoABn449F538KQnX7K
    EuvArgLI1kDWpf5GCD0UGOWsS3TUMf206rhavGkDJLVQrqWVWpLABk>
X-ME-Received: <xmr:FuPXammauEtdf5rxyZBGSsE8X-mEJyk-60XXuRsCRyGxWUtO3qwXua69brC9zUtlt-kIPkozVaVz68dLkewHU-105FVSNPPQ0HSF>
X-ME-Proxy-Cause: dmFkZTEUy43sdOw37GjvbaeFSX3IAqLnb7l4zUrKZ0zlE6f8+9iJ3MleSoFhh/jCPhhscI
    V4Hz7eYEWM3RwXDsSSVPPc+fSXNHQ6dgjgPbb/u/66FK1XY9q8OeTXiQ9PctH6MMs9Q1aa
    L4Etl5F4RB+3ktf1SywNzYYngWTzmygiMaxx3FidZ4iMRiIFJwohRkgpumjNv0oXbCOlMT
    tPe+25vXsQysfxDOHTPjarg29ZOITNWdtu8IXs0TOVv24Pd7V904WlqtqtpMFOMP5hwMRg
    EAoKAWdG/KmbKx4U7yh1Ic2qbIQmKYB1s3WeqkDoaCAj+4OpxfNl8Oj4/imlLH6uNeF3Tp
    00HOY5PQMOp86h5k+qdTYxoGI/pXP8ghTwO6YGOLcPxrMD0sVMq7BNKc1N3uw1axoK3mmM
    FiFG07NMP27zao9dGu6w9LnklhNZF8JnFQ/CtEd9vX3ONvzuRQWH2e8f8YrxkXokmT3Wwo
    phXDLuehXZuJQ5OJapD18RDIK5NduHAtEq8aFPuCBbp9VYQ00Bkqfu8zZuwA8lG3Idejyy
    xNgM+VHQRoXxZUa2M+YAfZosJ5jRp5ja2vUrte/bX10VarsK8YTxLlFCUxgyn4tHnZ5FVQ
    MWiGiGCvCKasWzGZnwE57E9wYA3rYJkADfC+XdsZR4MDhAsIDlwSdyfdyAxQ
X-ME-Proxy: <xmx:FuPXauiCzw23UZjbZMH6OPudnnnrj2U57kHuhEbc29iF76vojN988Q>
    <xmx:FuPXai0BjHYSopLV2kG-XFhdUPJbGQLebc6IqGlAT3SN_wgl_pVEBg>
    <xmx:FuPXavJNdLCiFqDuyRqYxiQlk2GmrHiUCDRoLPb9x14kWf3FVPt3tQ>
    <xmx:FuPXaqz3fsod2yukYuNE_5_4cimlE1CDZ0zkOxNlQwzKP5dbZ0r0RA>
    <xmx:FuPXarUkv6JVXpZuZAjv7xScWQ1za2SxazbCRUqnHSWJqfhfyQFtGu9V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 17:54:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] merge-blobs: stop using the_repository
In-Reply-To: <CAPSxiM-OyrVEzYgja0nwa8PikfU1WpsCYbiNiXpcxb4TM4=mOA@mail.gmail.com>
	(Usman Akinyemi's message of "Tue, 20 Oct 2026 17:53:02 +0100")
References: <20261017105244.90295-1-okhuomonajayi54@gmail.com>
	<CAPSxiM-OyrVEzYgja0nwa8PikfU1WpsCYbiNiXpcxb4TM4=mOA@mail.gmail.com>
Date: Tue, 20 Oct 2026 14:54:28 -0700
Message-ID: <xmqqwlrcrqaz.fsf@gitster.g>
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

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

>> +static int fill_mmfile_blob(struct repository *r, mmfile_t *f,
>> +                           struct blob *obj)
>
> Is there a reason why the repo variable is named "r" instead of repo ?
>
> "repo" seems more "descriptive" than "r". if there is no reason, let's change
> it to "repo" from "r"

Is that really needed?

I thought that we already use short-and-sweet "r" elsewhere, and it
is expected we will have many more functions that take "struct
repository *" as the first parameter as the libification stuff goes
further, so if we consistently say "r", that would be just familiar
and descriptive as "repository" to our developers, without risking
to make readers wonder what "repo" stands for, things other than
"repository", like "reposses" ;-).
