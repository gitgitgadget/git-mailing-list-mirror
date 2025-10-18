Received: from mail-24425.protonmail.ch (mail-24425.protonmail.ch [109.224.244.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8749128816
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760767281; cv=none; b=L/IhxGWQW5svy9jY1coXdgq6VlPNnLUv/qZZk5bFZNN7u1q0724vdaG4vJujNFP4HEeM9Y2fSIzPVE1Q6gTaKJlCLA1mDaWHmW6PuZqC8m/iD3EZl/vTVm87Gvb81IKHY8uWQnZvQYFhchhLDxKz75R3Q9v1lxqrJihjQCaHqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760767281; c=relaxed/simple;
	bh=ICEuqA4ADsAncneKqXJPhVzFMTQvvxgGHA3XM9N0ixw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0GaFTvRV4S0WP9hJmUNmELfIaLnyDkquF8bOVlx/qbHCuvIcmFNDlYVvTAt9evwNZ7FoHrtBPxkDFyQvTJ0GDelPZaqfYp+jDaFMQjY+erRAZLNsNFz/VPIcpgiGhLRftJhUrqcMjh8/tsgGkDMBqZmyZTD3ZPVVADda95mZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=AwB8jl1m; arc=none smtp.client-ip=109.224.244.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="AwB8jl1m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1760767270; x=1761026470;
	bh=ICEuqA4ADsAncneKqXJPhVzFMTQvvxgGHA3XM9N0ixw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AwB8jl1mGL2HZRvkvO+U7lJQ61yblfJFFbIhJOGpQ7ko24i6jAes1wTEFTvA0nfbQ
	 RsVj/fHGMnjyhcnb4jD5jmmOUctWHnNK7kEg/CKU8zhIsSuCBQfmjfBAqSrwP3RXQX
	 xjteYt1zFoqBkAkU14JoZqZlbgXS/awGrgAwWduU5/D8cxJ7fQPexMlDgmcxZdWTEJ
	 6BxxT+FvlQBOmIwaoSAui1O9F+JZacERaQAMB3VYuNSTGRGvVblu08xQc+cSaaniIP
	 9n3zsLEKJx0vXDSb0QWEOaR3jRySdiowBkDh6ygX6OaqSUqR3PXFEKtQzeNMdB48Q6
	 krueC1B8dcjUA==
Date: Sat, 18 Oct 2025 06:01:07 +0000
To: Jeff King <peff@peff.net>
From: Langbart <Langbart@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH resend] status: make coloring of "-z --short" consistent
Message-ID: <5y1mZIuIa13McbaoEhdBCm8CNMyjkJ6UE39s0kB-rYSmAmuPFnAof5fNVatncDUXIRoMvlpdbId3nFn2dnwU8NwNk78XArUYCf3RncWHu6c=@protonmail.com>
In-Reply-To: <20251017084455.GA4096702@coredump.intra.peff.net>
References: <XCDlwEkTlgoZIyIf_8BfOGl1C3C63Ioxeib4BRNJ9Jm_CtYWKT3qu-pDaeXVtS1Ifq6E4pT9G0yDbIS_nSwN-uiBuBNAlMyrOv0R1RyM7oc=@protonmail.com> <20251007082920.GA3349249@coredump.intra.peff.net> <20251007203406.GA4028057@coredump.intra.peff.net> <20251017084455.GA4096702@coredump.intra.peff.net>
Feedback-ID: 20607877:user:proton
X-Pm-Message-ID: e1c687e1c0bd203afe525cfef382b6d75093105e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the patch. Agreed, Retaining the colors is very useful,=20
allowing me to pipe the colored output to other tools.

git -c color.status=3Dalways status --short -z | fzf --read0
