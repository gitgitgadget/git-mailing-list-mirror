Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D69710E4
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 01:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730078209; cv=none; b=Ygqq1O5YD2SHc9D9BBVA2MFxxMGPxZCwz+wQqmK0uq/pXUF0fj+wTH+PguoMUn6Gyj/OfabDtE9GVZyE+eo4QhSDLxLda7a6Went4bHQqfk+xcZUpXLKO2wD+9Yn9q5SxhP94T1oRkDqU1eY8fxwBD9vbIVotOCRVS/PxsFTL3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730078209; c=relaxed/simple;
	bh=fc8+r0QkxKq1xqQL+8sx31HZa4m3cTbG9Hd8ZFM+qp0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNfYDEdsuUJDlBCZTxU1Tgc+vRDGmirjJPJ3Vu++ym4Xqw20buMEEickbFOXLNMeFOCJcxuNQKWvtWNwLg84RcKlWTeqsFdMGSovqB9JMQjqxgnNpOvRNywXSkxlXJpKmiJcsOvrQF/zc+TCrtlIr7KLavphq11j/zu1AMDhZQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=aK4i1Kvc; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="aK4i1Kvc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730078205; x=1730337405;
	bh=fc8+r0QkxKq1xqQL+8sx31HZa4m3cTbG9Hd8ZFM+qp0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aK4i1KvcLFYjuS939KkOm6847sK1AIaFga4RpoXMGlshZO8oGtELvCudr4iWQSaTx
	 ga+b9p1u8ThI4DgZHfyTeOninsc5dR39A4sFN8JNOWRX5Nbvqs03iBWxJpsJceJj2i
	 BDyljf1AbLhQnTP02aCOwl25pJVcZO+PSLGlxqfdWGfA8qGgpJMRBF2DfusPRT5yTW
	 MfBr6YqHFnOJ7aKZfa8t3lzokaGxC+6e3pIJGrW8tifUbImIqs4B9MIQmvJOS3hN9Q
	 6AvP4jBtGPxAfv6nPELHI2/xdW5A+SoA7zg5ftP9+2EAKvK6RAXyeOE2j0PcVJYCtr
	 M9/wRkceOrhLA==
Date: Mon, 28 Oct 2024 01:16:38 +0000
To: Taylor Blau <me@ttaylorr.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, shejialuo <shejialuo@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 1/2] worktree: add CLI/config options for relative path linking
Message-ID: <D571JAIAQYRE.2KDSYJ5EXL31C@pm.me>
In-Reply-To: <Zx7YFPE5tjr/bn2s@nand.local>
References: <20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me> <20241025-wt_relative_options-v1-1-c3005df76bf9@pm.me> <Zx7YFPE5tjr/bn2s@nand.local>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 4bd7221221fe05605b629cb515c4f47784b68be5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Oct 27, 2024 at 7:17 PM CDT, Taylor Blau wrote:
> Looking at the patch below, it is quite large, and I wonder if it would
> benefit from being split into smaller pieces. Perhaps factoring out
> write_worktree_linking_files() in a separate patch would be a good start
> here?

I can try to break it up into smaller patches. I'll start with the one
you suggested and can likely split the tests into their own patch as
well.

Best,
Caleb

