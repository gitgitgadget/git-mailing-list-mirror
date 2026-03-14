Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0F42F6160
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773506366; cv=none; b=N7Xy3PTBoFBSEsYHNjAjnyil8s9N5ih597s2Q9bDsJTQjlM3LSNR+NB5dR5FHOiIQ/96iagMCUhiG0ZS0NOWNj5UbyHyIb61GxCJp+IxdzWNukC2rAq5YsJyUYF+RiwBXoAQ/aByK3lKaFd1qjyiaasUbXfn26u6hdK2W7GUquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773506366; c=relaxed/simple;
	bh=M8Hz+n8qmchwyCH8mOFAJy7mLIZm6J/qRgaFAJgKlwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gkfbHfQoUKhqM8fu1rQjtBuDi0gzNxE8kInKRW6Z1tPSd0RUsTesPppmNhSStIK4i5wXreIStM+bta/nzZZAEB/AUXADBl9QzAfT49ejZEx6HttG3xjAJ4SvdIvgMvbD43bFJ3OmbELUAQvDo8IvsJW3soXCBbtxb2Z/Sh+4ftY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OjCw6T7d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fyJssqbj; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OjCw6T7d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fyJssqbj"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D36B1D000D3;
	Sat, 14 Mar 2026 12:39:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 14 Mar 2026 12:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773506363; x=1773592763; bh=TjKGt47G2U
	Jasid5+d2TUN8DG11qsLtV67FHTBcr6+c=; b=OjCw6T7dVG5NJreB+1YRPkzXvW
	jG4y26OKwGUumYPVMiwTWUXNsh8yj8YU4jsy1NAL95z8F9y1IbUkqhzz6A1IQU+A
	2BU4o78KLD3GKC5TW9A9r2GGqLVuOAuF3eKN65Nj4fTrMiDpvPZgx1PEemc5qyqr
	fXs8ZUPgIiCs1x16SGXJbLGToFbjgZslpazosvjW6uJ5ckyxVKhZbHkDhmfpFbEz
	hP4inRk6f/kEVS8/iokvbuBopU0zBSAV8xhGkKAnIWtZj1J0ft7Ae801LqOrySQp
	CRvl2+/+N8VyajVtF5vtdw0F2dg+d9RhX9x6008SSavRv6oMuGFoU0EXSfFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773506363; x=1773592763; bh=TjKGt47G2UJasid5+d2TUN8DG11qsLtV67F
	HTBcr6+c=; b=fyJssqbjcpoQOrVbCkilifFbA6CxWYUdqir//lIMd6so0LB5SDy
	na8/nNtN95xaMq+kYEhPIQHKUXEmtG1msXP1sYyBtnz6OcZRiBWcM+OzDPDzphT3
	cmz987tnofPRY/eJkQ66Zvhit40sd71X0wHIcJ+/fqmpbM8xhuNts6Htvh+97v5F
	kwWP6I1F+Xcjq9egquIEkxxs3ud+iintsMBd0w7StvKk5kVjnD3kgWTONJGEQv/t
	LOMWahr259GDvsftl7nfhfpac9vucudDEZKYG05CINtIylf6Y46z3zTf+Mrfr2sF
	PSRMJxRC57DH5pbX3QLbRshof0HIq6AkhxQ==
X-ME-Sender: <xms:O4-1afr0UJI1aIQ4-PCYJNJcKusDpwntiXbMyCK6yhwbZn3rp5kXxw>
    <xme:O4-1aRHi2lzEO4pPk6GSAzbEZzK8JcRadCuTvZ1cdtoheumAIXtVWrI9ASRXd-5Zh
    4IcU5YsV8-MO_0zmsP4Shb4gvwa5MBUWbPFopBlXWdFO-IbNWs_NQ>
X-ME-Received: <xmr:O4-1aZmPd4onwQkrejVeQDuCosuw-0ZTGyUmLCWo1OVLjc08FDpAjnwgZV6QsQAN6q82humCMqYE6KE6NzUmHDMA8rumuvUwNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleeftdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrihhtvghs
    hhhjugejheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:O4-1ackdwlcGOaX2tNyDYRJisXaU9RyTVbYi1Z2Tm7dKVO5QnjXd9w>
    <xmx:O4-1aSvAFvKR2nGLZVyRd3Xdvan4US1sZJKyxVKjcPaml0tDR8GUuA>
    <xmx:O4-1aXn1iwA4L_yClg-cDihl1AqJFKPLRUqdgTQFX6_LnVfrdWCF-g>
    <xmx:O4-1aVtEgaEfHvONjQnsrhBhyzlOzvfrq7FQFfV3cK9keBQCeBX7vg>
    <xmx:O4-1aZFrAAplakbOPfpYItpc0-sxlS-Q6zbjyP276c6RtnujTd7Oe-lQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Mar 2026 12:39:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ritesh Singh Jadoun <riteshjd75@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] t/pack-refs-tests: use test_path_is_missing
In-Reply-To: <20260314060550.1277-1-riteshjd75@gmail.com> (Ritesh Singh
	Jadoun's message of "Sat, 14 Mar 2026 11:35:50 +0530")
References: <20260314060550.1277-1-riteshjd75@gmail.com>
Date: Sat, 14 Mar 2026 09:39:21 -0700
Message-ID: <xmqq5x6yxt52.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ritesh Singh Jadoun <riteshjd75@gmail.com> writes:

> The pack-refs tests currently use raw 'test -f' checks with negation.
> Update them to use Git's standard helper function test_path_is_missing
> for consistency and clearer failure reporting. This aligns with
> CodingGuidelines and makes test failures more obvious.
>
> Signed-off-by: Ritesh Singh Jadoun <riteshjd75@gmail.com>
> ---
>  t/pack-refs-tests.sh | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
> index 2fdaccb6c7..3cc4906f05 100644
> --- a/t/pack-refs-tests.sh
> +++ b/t/pack-refs-tests.sh
> @@ -61,13 +61,13 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
>  test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
>  	git branch f &&
>  	git ${pack_refs} --all --prune &&
> -	! test -f .git/refs/heads/f
> +	test_path_is_missing .git/refs/heads/f
>  '

Good.

>  test_expect_success 'see if git ${pack_refs} --prune removes empty dirs' '
>  	git branch r/s/t &&
>  	git ${pack_refs} --all --prune &&
> -	! test -e .git/refs/heads/r
> +	! test_path_exists .git/refs/heads/r
>  '

Questionable.  When do we want to loudly tell the human about an
unsatisfied expectation?  We expect .git/refs/heads/r not to exist,
so we want to use "test_path_is_missing", no?

Please do double check the remainder of the patch, although from a
cursory look I think you got them all correctly.

THanks.


>  test_expect_success 'git branch g should work when git branch g/h has been deleted' '
> @@ -111,43 +111,43 @@ test_expect_success 'test excluded refs are not packed' '
>  	git branch dont_pack2 &&
>  	git branch pack_this &&
>  	git ${pack_refs} --all --exclude "refs/heads/dont_pack*" &&
> -	test -f .git/refs/heads/dont_pack1 &&
> -	test -f .git/refs/heads/dont_pack2 &&
> -	! test -f .git/refs/heads/pack_this'
> +	test_path_is_file .git/refs/heads/dont_pack1 &&
> +	test_path_is_file .git/refs/heads/dont_pack2 &&
> +	test_path_is_missing .git/refs/heads/pack_this'
>  
>  test_expect_success 'test --no-exclude refs clears excluded refs' '
>  	git branch dont_pack3 &&
>  	git branch dont_pack4 &&
>  	git ${pack_refs} --all --exclude "refs/heads/dont_pack*" --no-exclude &&
> -	! test -f .git/refs/heads/dont_pack3 &&
> -	! test -f .git/refs/heads/dont_pack4'
> +	test_path_is_missing .git/refs/heads/dont_pack3 &&
> +	test_path_is_missing .git/refs/heads/dont_pack4'
>  
>  test_expect_success 'test only included refs are packed' '
>  	git branch pack_this1 &&
>  	git branch pack_this2 &&
>  	git tag dont_pack5 &&
>  	git ${pack_refs} --include "refs/heads/pack_this*" &&
> -	test -f .git/refs/tags/dont_pack5 &&
> -	! test -f .git/refs/heads/pack_this1 &&
> -	! test -f .git/refs/heads/pack_this2'
> +	test_path_is_file .git/refs/tags/dont_pack5 &&
> +	test_path_is_missing .git/refs/heads/pack_this1 &&
> +	test_path_is_missing .git/refs/heads/pack_this2'
>  
>  test_expect_success 'test --no-include refs clears included refs' '
>  	git branch pack1 &&
>  	git branch pack2 &&
>  	git ${pack_refs} --include "refs/heads/pack*" --no-include &&
> -	test -f .git/refs/heads/pack1 &&
> -	test -f .git/refs/heads/pack2'
> +	test_path_is_file .git/refs/heads/pack1 &&
> +	test_path_is_file .git/refs/heads/pack2'
>  
>  test_expect_success 'test --exclude takes precedence over --include' '
>  	git branch dont_pack5 &&
>  	git ${pack_refs} --include "refs/heads/pack*" --exclude "refs/heads/pack*" &&
> -	test -f .git/refs/heads/dont_pack5'
> +	test_path_is_file .git/refs/heads/dont_pack5'
>  
>  test_expect_success 'see if up-to-date packed refs are preserved' '
>  	git branch q &&
>  	git ${pack_refs} --all --prune &&
>  	git update-ref refs/heads/q refs/heads/q &&
> -	! test -f .git/refs/heads/q
> +	test_path_is_missing .git/refs/heads/q
>  '
>  
>  test_expect_success 'pack, prune and repack' '
