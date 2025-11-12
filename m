Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A82630C347
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946780; cv=none; b=Fs2Guia3ixV91FqFht7k+nTr0IoQder8GPb32V1OhOyqxQP8AVnatEYKomGjYwE1AI9jUQuFQKzEdJ5E9gI5CYEATBwjgJYDFQtiDnEXZtdmsqodMk+IGmJf82LtlTpuTZMANHWQDhFISTQv/u8wsby2jxD/KZiQF2Cx5t45PZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946780; c=relaxed/simple;
	bh=/YA9j8n39XDdjyjrfEXlXUcxb+x2IVi5RTWSI+dczsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfj9aCoJhnQU0H/Jbedf0iHbRkBdakHbohNZka4wVzbj0mqpB4tun+Itp12I2aE95WCWBdVmt3Bt7MAxy2DsQvG0qKWCLDFfVkeyiX95aff3keXhD/pe8ar72JV14TNk8geiiGJMJpANg2OKf2/WiEHnjCOJb1ofW3qdFXYJywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kH47XvHL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UubK0Dn7; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kH47XvHL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UubK0Dn7"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 14A1B1D000CF;
	Wed, 12 Nov 2025 06:26:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 12 Nov 2025 06:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762946777; x=1763033177; bh=rQPNkvMhZj
	gjYd5McPIciSfH7/CJoAx/hHUyUj9FScY=; b=kH47XvHL4s8p7FUhUNRffJUva7
	HC9z2/PhpE877lqYE3r/dYCMU2HX9zaOw6xpWQc1Es1Wa0/FXTFgKFfyEnHVv1w9
	uqeGHAPjcrK9zedqSc9KmyfvuVW8cVzBnoNR5UOsJjdxtklOYu0i/vTAAYAzYcvj
	Lw8yO8eUZtcfMyfSjUDRjr4sp9BQcumbIeJRldgEg7daWkvl0Bf+wGwfWanEbtCW
	yBsnGdxNFaIr/rOmob7w662KQe26TMSg/N1CGHc4APCICKgUxdZbB2o096zN5c5G
	Cm9GI04SkGu6AnmZa4L+/D/2g+hyHqjfKxlkc1gTX7/rGCRLTYewg7cuAVVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762946777; x=1763033177; bh=rQPNkvMhZjgjYd5McPIciSfH7/CJoAx/hHU
	yUj9FScY=; b=UubK0Dn7fHMAbE/jwo066lK/rWRvihP29GZ+Ik+1fdPWhLD7uEZ
	iLZyjYIxVnHwusEOARxTFSA7tNi3IyPU3z97O2NT6qcG57chXWszXqOHcuRAk/wO
	uuZhI8grLZyQtrGYP749DVvplh8vpZdgaTw91grexUspfxuvwc7tEULV0GrfNRH1
	tOfv2r6KfMR2Yjcqm1bM8ZoTuV2j5EazUJ+++DgRN0rUBzX3fhl0W3lGrJL1KdWZ
	hwJi0XONr9N1YXQXX6ozT4/R3FlXCybS0VQvnIg4KJRyRfZOb2i6sQ4HPEVloDyU
	1YbuV+BltyiHkkUOtimFcUkmftOdOU55Qag==
X-ME-Sender: <xms:2W4UaT3Wz7wrX-T1z3P5XLr06rXAxJFWBG7xRDA3PKqrmHc4COi9Og>
    <xme:2W4UaZHGY-ipTlx6MZJKYEueILYowsFOJVLryK-HD9riwDOoj5XNYnf1Ru3VWHZvy
    o6L1aOe1ctUQ_BGCSv3TD_9p0_L6PHpeFqZGgN5jYCUc7AnnxEy>
X-ME-Received: <xmr:2W4UaY7fd9CRbbaL7a9FJhmRUMT4Pvx9aVqqkZek7t2k8ZdqQBxgMTnSWvckTvnyug9Hl20bnBTjAqhbC7D19MMEwWY49q16xDyNoZ3EOEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptghmlhhishhtshesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:2W4UaXvR64mP47WzrfY7nUS-iinggGQod9pXdQCHgEhybFIiQidruA>
    <xmx:2W4UaR7pQQx-BHNXJiPXAxvpuwu-O3GFG80deVXe6mKnIgD4A0aGhA>
    <xmx:2W4UaaWDv6lrJETMlGyuuRlqbVsijrb-oTmlck0isaOaIqTreVc5TQ>
    <xmx:2W4Uab9e2FBSc790CguvFZqreQjSIMXVCP6dl14mrs4HhF93-39Wmw>
    <xmx:2W4UaUbDioeN7y2DWWL8-dFn4hDqVwPxNdtEmok_m4a2TN30n2E3-tgB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 06:26:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d773e1e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 12 Nov 2025 11:26:16 +0000 (UTC)
Date: Wed, 12 Nov 2025 12:26:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/9] Makefile: turn on NO_MMAP when building with ASan
Message-ID: <aRRu1cxpIzd60AoU@pks.im>
References: <20251112075522.GA978866@coredump.intra.peff.net>
 <20251112080215.GC979063@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112080215.GC979063@coredump.intra.peff.net>

On Wed, Nov 12, 2025 at 03:02:15AM -0500, Jeff King wrote:
> diff --git a/Makefile b/Makefile
> index 7e0f77e298..0f44268405 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1587,6 +1587,7 @@ SANITIZE_LEAK = YesCompiledWithIt
>  endif
>  ifneq ($(filter address,$(SANITIZERS)),)
>  NO_REGEX = NeededForASAN
> +NO_MMAP = NeededForASAN
>  SANITIZE_ADDRESS = YesCompiledWithIt
>  endif
>  endif

Let's also apply this to Meson. Thanks!

Patrick

diff --git a/meson.build b/meson.build
index ad4eb2c4fa..668f8769d2 100644
--- a/meson.build
+++ b/meson.build
@@ -1408,12 +1408,18 @@ if host_machine.system() == 'windows'
   libgit_c_args += '-DUSE_WIN32_MMAP'
 else
   checkfuncs += {
-    'mmap' : ['mmap.c'],
     # provided by compat/mingw.c.
     'unsetenv' : ['unsetenv.c'],
     # provided by compat/mingw.c.
     'getpagesize' : [],
   }
+
+  if get_option('b_sanitize').contains('address')
+    libgit_c_args += '-DNO_MMAP'
+    libgit_sources += 'compat/mmap.c'
+  else
+    checkfuncs += { 'mmap': ['mmap.c'] }
+  endif
 endif
 
 foreach func, impls : checkfuncs
