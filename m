Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36EE264606
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542329; cv=none; b=tE3XReKW8xSuM8/GCRcFsAr0vBVYUdtdHfT+1L6TpLH+d/7TXkU1JOvQ6JU5CUkIrr/OJdBXTFtV2AuFbqRouwfbKLSSDnFWn8OaIH0bQPRI5WNUPxjxXH+jKuX6y+Z5zxOTIPblnzdVKw5ceIKeGyKeM4QqQ3rbaLKUcOlwxng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542329; c=relaxed/simple;
	bh=YtYbNQ1iRu1jWRTb57juPwMl2VRJu1+TkPL+0CbBTUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZvZAmUX5lC7ElES0K8Co+r2LHPLdlFOHTTFGG/kHGdGrg1FTEzU0AP+V57fB9mnAUbYaJwSTTPKrcog2fOssV/hZ3ZbXBOuh3Er326lUxfCbXLkfs4SGTdPraXuz3yWC7S1kRmbLjGbwncD10Ocw8wKDU/SdAiayQFV+9GV9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IN5V7kCk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jthez0in; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IN5V7kCk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jthez0in"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 48A367A0103;
	Thu,  3 Jul 2025 07:32:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 03 Jul 2025 07:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751542326; x=1751628726; bh=qwATxI/Xap
	w56PBnGtN59P2wkPyUxCJdps6rPPayVfI=; b=IN5V7kCkcAbSVFcZ/VT4ckzZVs
	9XcvFDgNBGbVvKYdS8oJbCG2udRQB36fOn2J3rKyUIuTeBJnW518j53TYwI8mNaq
	mhHg4MoDKimg4UGnAORbMr0lALIBNX7ErNSWHQY5wxWvZtvQP7TU3t4pUc9ba1hU
	luW7TTqzXkJjhFADy6AfVaudx/DGix26lpATMqocuN4WYfZDpMFAEzij9WuDjyaC
	qim5Go+UcwW9aUn1KPm8S9yWwhtIV8UQZ2NVbiXTB/eoE9KV4ba7VnUdffD7v4dz
	tB0utWM1voMjDTh2B3GSQffP16UZlYJwA1J/5Cmb6wEVs35iZOMdKI6oAA9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751542326; x=1751628726; bh=qwATxI/Xapw56PBnGtN59P2wkPyUxCJdps6
	rPPayVfI=; b=jthez0inDkVKT1/kusRhhryspl5jTvV/7vB1C3gSUM4gu1ZNncP
	gFH/ECnIga2a8LoySgNxsKCL85G7Yh5xaxHeTJLBcKn9A4tI2NzeH0y8mbwSAPEJ
	yd7QyhEx5WkI+lQZWLOXIpp306pegqDHi2iKz7Hj+D6YpNS72G7zh1EfyYUXGeyf
	6KqIxotffhjRsM7JbyYb2/HZWVHJDA7YLDho9jw7RbmonVhGbLj4ePo/wHRSI+gN
	1K1/hZ/P8vJvM5tyfTFlrS7fFhKGTnmXFYSV8Ba8qkm2ZCY5YZBwtQ9loAV36I4R
	r4+C4iqt4VjBsH60DdS/au2JeweKcd7D5Xg==
X-ME-Sender: <xms:NmpmaI3dI7CGIArOekuvgfQRZT_V0Xvsl2qIZHigah_F7PL5xlgRsg>
    <xme:NmpmaDEfRARFZyXfsBu33a6WAhjSzU5oPEkV_Ho68eOBNZxEqnng0B2bAbCFeeV-I
    aEjC3_w8LFl6n7TPQ>
X-ME-Received: <xmr:NmpmaA6mkzvM7DyGFPtfTQJFABlEGHCDxOhjhNS72ui0Lg4EZaT47MkKx9N1XqWK0J_p1DJYJEfhM4aCtvh8xdx5E9YVvJXlamEqEc_R0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NmpmaB202YJtobuXNKHvj1FSI1SVaR6repaiAon8E3DbMVZ5x4F2HQ>
    <xmx:NmpmaLGCg7sS24wAPr_VTtdK1hHMuQtdqy7ZkTi4-TvbzE6Kab-jIQ>
    <xmx:NmpmaK9HfHgTX53gl_9otuEN4at22_m964FRX7iNJwvEwrChJWq54A>
    <xmx:NmpmaAlRQz-Xjq_4dCIXMHbUvScqNTs_ZleEXnixegdGnUOXDTRVEA>
    <xmx:NmpmaCWHUkJmkz5kReBQLY4xI0j2__d-tBnPdJ2Cc3P-smc5qms_7NuI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 07:32:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c12e0d47 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 11:32:04 +0000 (UTC)
Date: Thu, 3 Jul 2025 13:32:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, ben.knoble@gmail.com,
	gitster@pobox.com
Subject: Re: [GSoC RFC PATCH v2 3/7] repo-info: add plaintext as an output
 format
Message-ID: <aGZqMZm2Ttngty8x@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-4-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619225751.99699-4-lucasseikioshiro@gmail.com>

On Thu, Jun 19, 2025 at 07:57:47PM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> index f634e1a285..998c835795 100755
> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -18,5 +18,9 @@ test_expect_success PERLJSON 'json: returns empty output with allow-empty' '
>  	git repo-info --format=json >output &&
>  	test_line_count = 2 output
>  '

Tests should be separated from one another by an empty line.

> +test_expect_success 'plaintext: returns empty output with allow-empty' '
> +	git repo-info --format=plaintext >output &&
> +	test_line_count = 0 output
> +'

Patrick
