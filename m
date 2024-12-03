Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B722617C68
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 04:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733201698; cv=none; b=F62tmbC02PKWOYhBMO74fKJ23Sjs/Q0/CbVR8CaOccKJB2kFUAv2x52t/qgfJTTR5rsePgTc55r46kiNAR+PiP1DH7Dr3+1hRNsEe/zmBghue/UxxmB8dVBuag1TI+Fpeqbu8UzLsnCMQlRy6oF4qajwBcci+q2GG+SdPFHrqKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733201698; c=relaxed/simple;
	bh=XRF6NrrL/BpJW8xzxDl48kCUM+bDUJ9C/HfNb1CA85A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W+zPs04GITPfPR5CUnc9A5hVQDzR5CmwhpRBpiEzASp2ILPQ+QPw0EN+EMXQFN6h3WMGtd2DK+cfxql4vAIGKbAlVgMEv21hWZc8NwnsOtaR3/CwlYPKEqbZ0viraZvxgqiU6YS9aHsbLdcOb7WZ6F9jI9L7rQ1dqlBhyg9khMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YjdxLYxX; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YjdxLYxX"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB52B25401DD;
	Mon,  2 Dec 2024 23:54:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 02 Dec 2024 23:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733201695; x=1733288095; bh=XRF6NrrL/BpJW8xzxDl48kCUM+bDUJ9C/Hf
	Nb1CA85A=; b=YjdxLYxXOeGp2zhhgN0PZ0RIyvemAsvrXZfwxIcO5pQFyeQRkSl
	vZT309XuaSv/azYcpoEKl1Owd6LDKObKpVGpJYFzxnhfLWu07Yhpdb4BMmqM0qPN
	hFEeqfoarrOSF0ng8Ey3IzDLfyHehVX27TzVXpe080KCRTQ/iWd7wogBBcFUhzHB
	ZZ7Uwz2mAxLBkId3U/QOz41Upb/rBD3e2pkoqwFencu2rBhoVbgeC2b8exddSTrh
	SGcm1rdTvjmbjeYOk85XcAW61wH8+Ld2vjXHxuGD2Yjp6Ia7mpznBcduZxhnwC8H
	bIAVREFuB7VEcuDcik7gEu1/au+mfWSYULw==
X-ME-Sender: <xms:H49OZ8z2Ph__yCYoXB6bTSllvv3W_D06OvMTvs_Z9eeNwFUHXnxBEA>
    <xme:H49OZwR5kJPjof-8Sesc8KfnWRZgt5AHUrpVmu4uL67WbmE8IbLirdD3PohYL_qe_
    VfsZvSRcJPhqUMyuA>
X-ME-Received: <xmr:H49OZ-V2TaAC7ixkhM4HH1UL8DIGL4AwQrnVHqmJ6ZbPkICNslx9wMNkbhO-NFXr6yuG1Rxioaw2SV61MqtXQQ4LpP_1qlpoo8Xa_os>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeevteev
    veeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopegtugifhhhithgvfeesphhmrdhmvgdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:H49OZ6jJzE_IJQWL6eEOvTwmAEBdl4NnLjQQpqb0T5Zzonbc0I-EUA>
    <xmx:H49OZ-CQgsq6UZiUw1mwsVRCmu1od_qAr1YHMrbIIgpEimsFpJVnNg>
    <xmx:H49OZ7KLJ9dGW2KPQI9ToNdOt234bf_HYfzDaazBSgN53Tk2zw1mGg>
    <xmx:H49OZ1D4DboreNCZRnCcAjgCnixTxgqi1ieKDsYq7IYalORyUjIeJw>
    <xmx:H49OZw2nx2ywNJQqAjItbwcHFErU0SIUqHf8VNgl4llLSp9mtuf9lToA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 23:54:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Caleb White <cdwhite3@pm.me>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 0/8] Allow relative worktree linking to be configured
 by the user
In-Reply-To: <103c7a4d-a74b-4381-a9c7-33a89d5db192@gmail.com> (Phillip Wood's
	message of "Mon, 2 Dec 2024 14:57:38 +0000")
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
	<20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
	<20241129-wt_relative_options-v6-0-44e4e0bec8c3@pm.me>
	<103c7a4d-a74b-4381-a9c7-33a89d5db192@gmail.com>
Date: Tue, 03 Dec 2024 13:54:53 +0900
Message-ID: <xmqq4j3le57m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Caleb
>
> On 29/11/2024 22:22, Caleb White wrote:
>> Changes in v6:
>> - Re-add test for extensions.relativeworktrees config setting
>> - Link to v5: https://lore.kernel.org/r/20241125-wt_relative_options-v5-0-356d122ff3db@pm.me
>
> The range-diff below looks good, thanks for working on this
> I think it's ready for next
>
> Best Wishes
>
> Phillip

Thanks, both.

Let me mark the topic for 'next'.
