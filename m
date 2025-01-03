Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26471F9ED5
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735905959; cv=none; b=o/Rv8jpn1YXtjLcPxWcdv9GtMGAAi06BOAU+Wyl2eq7pqHMO2Q1n0LsRl0Byji5jRSCXAnNtROVMJYO7N5WkbiHiJmNG4qGQf5bRXEmtKoikTTD1GPIvKdphCHbgJWyfQmaM2/fYc2t/q0FTkUr9Qo+sFv+LHGIlr0Mi1bWYrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735905959; c=relaxed/simple;
	bh=h7JklC2+k2Bxhl003gV5gbUlkLwtkMkLqVOVM/0fQ/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7Ncm0V6Aobgev18zIWzeloAstv7TR1v0zHM+dTlJy5/GEb2c3HIA6RQ/bOtJPTclPE5d0J42rjvM0oBJP/tMDko9XOekvOBrDyXvvaJi/JmKsYkh3CngldcOGafBIFMTPUrfDP6JhgG8ctdx6dbFezkod1oHuF8PAIsSL9r2L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WALClODg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=onSIgmlk; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WALClODg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="onSIgmlk"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DDAC01140252;
	Fri,  3 Jan 2025 07:05:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jan 2025 07:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735905955; x=1735992355; bh=9eF4OKO5qt
	JOdHULFVLxI5DGnw7OW0IN8YLb+Rg5kkc=; b=WALClODgKHnGFt42wmbfHKAp+A
	Ii0hZgF8kxRCM5hozegOve1bvLyIJDp/ikaVYgm3wNq7l8xrJzc3b/R+B3WCFiIE
	UCaliGEWbdOoXDebBfDc2NcVxsRFrPRfdXexSeS7cItQnWTu+JLe1LfxDvZ3SiUf
	5Wc/iqEpBUaVwvz7p+JuIopK+4HrO8kNP4sKLVvQE0+iEeM8zvLsYZGpjp6/NAf+
	8Z0gT+9+/vt20wWmjtmFoiTAS1aOlKRrcVJI8hoSY2ev0DrVlXAqsKlJEaIrhNha
	XxizSr6GZr0cHnbx++D4GoIiKzDz84pHErpoBSR/mLUMPeZjEPKbTEmqWACQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735905955; x=1735992355; bh=9eF4OKO5qtJOdHULFVLxI5DGnw7OW0IN8YL
	b+Rg5kkc=; b=onSIgmlkOMNtX2imHulekTkovBj2+Eqos+3rjBCMPvMzyiv+WLE
	uqx+Y1z00mfizKURJf32ms0KaI9PrziqE4GmYgw0GmbLbOyVujMsPaHn91F0E5nk
	Eln/2UNPeNSWDOgtd5ZG0odGeu6AGlk9ZHCGLIZ5Kg3ToDGnwLTxQTXTgN7LPcUt
	yD8JQRXavI5z/mGkyJZfcW9E/69xMy1hP0vwY1TsMCc7ExM8LMbB3I/rJhyW0RUM
	X8vY2wrx4CT86OkJLnkLev2Z4ub+HKh11QxgTIc9ftjS8+5nTj5n8t8nPM2pW/xW
	BGOi3nPh3ickKTiCZN830XJ26KdwqCUjw5A==
X-ME-Sender: <xms:o9J3ZwB8XTb5utu8b-WpThgXaW-9cDnofk2MLGOlB05I7RAcHD_kAQ>
    <xme:o9J3ZyjoK7tICDYl4uo9aQjOzHi4ux-saxVTs1TYjWrwC3XZT9eU-dJQIwa3SC6bb
    yPVhnDB70XilduokQ>
X-ME-Received: <xmr:o9J3ZzkhhtALJDkr6vJJlpv6f3E7lMINp6ng4aq-YdLggN1JxCWO8HCfEHMod7f0ImuxtO22VR1tChTQShjIEMCRAlOiDbNQYROWRlt2idrpgtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:o9J3Z2zHZJ7ItHQJbxKXjVITSgKVKvJb05oewmnns5XDx4bdXtg1_A>
    <xmx:o9J3Z1S157erwe8K0G_QS7syjf3dfpZJ5Xi6GbSjFScsIZ0rhwK2MQ>
    <xmx:o9J3ZxZJ6Pw_Lg-1ZLQwtqJBMsTxORyPcUtADsDy8eLbs-jfU_NegA>
    <xmx:o9J3Z-RzdkcIK7TYPQqASPZjrEdrgMn-9kah5kM-h-90QQhcOltLAg>
    <xmx:o9J3Z3d7LP_SFkU2HR3fqTW1O9hDTuZC2JnIYR2j5GplGcbz5cc_Nbv_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 07:05:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6aa8438f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 12:05:46 +0000 (UTC)
Date: Fri, 3 Jan 2025 13:05:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/6] test-lib: simplify leak-log checking
Message-ID: <Z3fSmSYoWs-a6afW@pks.im>
References: <20250101201226.GA3304465@coredump.intra.peff.net>
 <20250101201721.GD3305462@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250101201721.GD3305462@coredump.intra.peff.net>

On Wed, Jan 01, 2025 at 03:17:21PM -0500, Jeff King wrote:
> @@ -1181,8 +1170,14 @@ test_atexit_handler () {
>  }
>  
>  check_test_results_san_file_empty_ () {
> -	test -z "$TEST_RESULTS_SAN_FILE" ||
> -	test "$(nr_san_dir_leaks_)" = 0
> +	test -z "$TEST_RESULTS_SAN_FILE" && return 0
> +
> +	# stderr piped to /dev/null because the directory may have
> +	# been "rmdir"'d already.
> +	! find "$TEST_RESULTS_SAN_DIR" \
> +		-type f \
> +		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
> +	xargs grep -qv "Unable to get registers from thread"

Can't we use `-exec grep -qv "Unable to get registers from thread" {}
\+` instead of using xargs? Or is that unportable? Might make it a bit
easier to reason about the `!` in the presence of a pipe.

Patrick
