Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5CE5258
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971035; cv=none; b=OeQyO3shkmnGgmU+QwYRxG/ydj/SnPHdjIc4QfOtZBUKforeUEzft2M3r2f4UJERMJV6KGNsiZsxqXMTdimvqdSsVY0F+5tueKRP+UBwnDml4OirRZUWRS2ty/ZI7TeYaTWqs06Aku+i2hy0qFVLZWiaujf+EYwa74rVT4WIu3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971035; c=relaxed/simple;
	bh=1p3N5He/Iin6kduEjQca7xuXLHqiERc/ngRJootMZDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGgY4dwuykuZohVL0yUWSlpD55wTiAfoufl8Z2s4w2J+ahOJyWcSFmm4XLlBfU5rJKpYaT1bFhXqSpfLkm/yfvxWWCyPO0vJM9gkj6Pbyyrk4DbR6hZC1XEG0ffSXVprfziAK6Rcx1hLp+PdUXhBwJBiFa0SJgvOsEYnIT+VcEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LAbmekVe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cRQbmsEa; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LAbmekVe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cRQbmsEa"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D8A61140090;
	Wed, 19 Feb 2025 08:17:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 19 Feb 2025 08:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739971031; x=1740057431; bh=e6Ci4RR1rR
	bRaQoLX2FIkAHkbUd5qqhjBVW5WmZfHX4=; b=LAbmekVe4DzXBAZtn+rWtf5z+C
	e9zMu1ZsEj/eZ1f1dee0LTtbOd90YlNNI798IiZvic3lKWiTMBw09dBHuh5C2ioj
	mD5pD1VikS+XtZKUHbcfBOsHZxMxtghZ56XBEv3TGiMO3xB9xJrHQGz9Uzu6AYEI
	M8KuHRupUQG9SwK2yjSQ1+tHG8XR22EEKXsV2AD+chrtElE6fCda8XtCAne3/CxR
	DG7GFLVG2Vlsk4WzTf745U9hqCrhKAvK1MFrX1gtGRXtzugbjV2mJSRNYltz6yOC
	+9UdDio4anvFE09MKuLlogEUbSyR91JUNkILv8hVnOvobymuTXE8xyBewcGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739971031; x=1740057431; bh=e6Ci4RR1rRbRaQoLX2FIkAHkbUd5qqhjBVW
	5WmZfHX4=; b=cRQbmsEaO/vjPEoQPs0OOnkq8Z3zrFUxoOU8ptxEZTBAwh0/7Rl
	2G0GTbRCt+ZDGsUn92/rtqMqFR5uhAh2zQnbFnPCSWxEgeww9ksDN33ffY1+5k1L
	1TZIhy3U4CkQD+vTqfcBohlTxts9hU1r0huedpY6WhA4QlMrM1Pn2tFmWhQP7EyW
	73vhVLWCUrGs3Gvs0IzgCOQPpdmZjxwiqIjYkoMkBQm2gXXtTtu8AEzDq9NdbUwu
	z7/Lb4XRYTtAur2NIm3qApvp7/TGKLX0ORsGhsjBcz/JXsH3SZL/OmtuicC42ULH
	gut7NTi/IA3eDvHAtnE3MrAaqbSGg75CbFA==
X-ME-Sender: <xms:19m1Z0YV3a0Vhpe2qYtzx-Ux6-ylQCIKir2SCYmHkdJLLEIdEzYVzQ>
    <xme:19m1Z_YOvUCKCJQDPs5WrbYs4tmLc8dK09BksQ1Cj2a3zyp1-DdC54-T5dfbFj7EI
    bZucfTy1imjfI9pAw>
X-ME-Received: <xmr:19m1Z--6GILNt5jbv8fhGeNdM83XbWtdo6gnwNdSgx2im7k4xK4opj8vkS9ZjC_ip9KvyIys3xnk2FvhoED56tuIbVcVky4VX0Rng1obXfVv6ms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vghtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:19m1Z-q9sXfTQ22L7tlPMlE-dZY-fT2PrDV7Hlh-xF4j8pwBrOZSdg>
    <xmx:19m1Z_rcSePhPhDwVMCAlfXsz5L41mOV3MLpoZmQ-RKJzQaNgYGLBg>
    <xmx:19m1Z8ROWibRbsa_RhZFMNZI_TygVHgq2aup8gwEjxfC7q5wekzYkQ>
    <xmx:19m1Z_oyhX6XnvWMW18TTca_q4-nvkljeeo5WeO5NcxVd60iejmDfA>
    <xmx:19m1Z7JCAOQkBs8uDIY8xLrZFbO4ch_Basi7eseGWXFNdA_F3epADORL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:17:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 809350b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:17:08 +0000 (UTC)
Date: Wed, 19 Feb 2025 14:17:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 07/14] refs/iterator: separate lifecycle from iteration
Message-ID: <Z7XZ02obxTyj1tGO@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
 <20250217-pks-update-ref-optimization-v1-7-a2b6d87a24af@pks.im>
 <Z7S6xzmPb3lK-SdT@ArchLinux>
 <Z7XF5pGsa42jrIcN@pks.im>
 <Z7XRX1gfo942QdNR@ArchLinux>
 <Z7XVoeNMjXJnlrmX@pks.im>
 <Z7XXcp9o0fb7FloS@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7XXcp9o0fb7FloS@ArchLinux>

On Wed, Feb 19, 2025 at 09:06:58PM +0800, shejialuo wrote:
> On Wed, Feb 19, 2025 at 01:59:13PM +0100, Patrick Steinhardt wrote:
> > Regarding the question why to even rename `ref_iterator_abort()` itself:
> > this is done to avoid confusion going forward. Previously it really only
> > had to be called when you actually wanted to abort an ongoing iteration
> > over its yielded references. This is not the case anymore, and now you
> > have to call it unconditionally after you're done with the iterator. So
> > while the naming previously made sense, now it doesn't anymore.
> > 
> 
> Good point, I didn't realise this part. Thanks for the detailed
> explanation. I will continue to review the later patches. However, I
> won't touch the oid part, because I am not familiar with this. By the
> way, I think we miss out one thing in this patch:
> 
> We forget to free the dir iterator defined in the
> "files-backend.c::files_fsck_refs_dir". I have just remembered that I
> use dir iterator when checking the ref consistency.

Hm, good point. Why doesn't CI complain about this leak...? I'll
investigate, thanks for the hint!

Patrick
