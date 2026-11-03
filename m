Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727069;
	b=SRM57Z0lKDxAeOuei1N5f+T0dNiaJghEpSJ7M3wy/1vuryv1OcVFZkK0dNlrEtsmPkOV
	 78ZJFUDaiw2rTUjcIsdMHFb4JaxdCsWbKaPxAkHwkShLXF6UogjD7ksrM873fZD9ZG3J7
	 XLHH9A5WClZzBnkpy9pGYY8ZFMETLWtrXd4El0NFO4fw5Tij7dLw6g84QPIrmqrhEX6jv
	 1EqWjQvaWaIAYzMMAimFrzJE39zSa0/0PbzOlqsgY14r+Irym54TXxGvLFNNo5esoa0j0
	 iWgC4BECV20EdEn9hRfS4cNRSynaC9Eqwd7RVDaZi+XqdOXsrQNnW4c+OLTYWCzhG7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727069;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=0ENIHGOnjx7jReew1/PBGTBV06C9FGFAho7jI8vua78=;
	b=TaYpKSKUbko8ck1UxY+dEPJaFrzBKXToJd9p12Xmd8VFAi/Xw1ijZP6SfGUj0Cox2w0m
	 HSDrvR7MKZ2mY/AkyZiKB6+MvXjLQ8xwQiQZK1JQi50rNDIOrdPOhIBVR7sN8Fo3mMVg8
	 zl8RcuLK5l/om+5jGiDK0aVXHopI9tybMv4HUEnHMZO+PafQMH+F/7CvVHUwH3JqxmCL2
	 8HYVP1Ps051Sg+qM8iFmfX5yJOwxa20KeSUotAZVsvF7zhrTFJKzobtSm+w1f3QzJT38I
	 0V6vpS2WObgCH4O8bb5RAxIlqpI6wdlKIDkO2E6bC1TWiQBnhN1UhXoJKq5bwzsjrJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=d74oA0HE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XjUCD8dr;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5E1606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 17:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE5E1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=d74oA0HE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XjUCD8dr
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C31CB14000E2
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:31:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 03 Nov 2026 12:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793727067; x=1793813467; bh=0ENIHGOnjx
	7jReew1/PBGTBV06C9FGFAho7jI8vua78=; b=d74oA0HEzKCa9CkbKARsnY74Ur
	lJ4fWZT9ZyMEzfuO+YZbjUk/1xDsctVnhshJ2VMG88zA3shKK4NN9R1KHLZH4t+4
	qZ/+ukagJC/ZQIZZ1P1/70cezrt11GDJPAmFyw9EuLR6WpaeiEPKCz4I28VEsnUa
	FSm41dy5LywgcI6efl6DYG+ogUfwDLuv7y5XZP7ywBMTq5zOaSYrL0d/nvaXPN5/
	ORK3Mn6tYkvsLKB+Pz4K0WYrB561raOGOVRjRDxkIGJcRPLZBHFy4c4ZEJW69emu
	TRrTFXmJNouJKYgecabGUscjqJwcDMoQ956Ca8kOw5+o+vXLKQZPqfG1fyCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793727067; x=1793813467; bh=0ENIHGOnjx7jReew1/PBGTBV06C9FGFAho7
	jI8vua78=; b=XjUCD8dr2S7qUupL+o1VOTVuN831TmSqAXu4ieFn3ZHeG1bnarU
	s+rZKlcinh2QFWvaGGsxRlxK4wFAbLbEzSqHG99Jz5jVCdTRkBwDMBvGtmLhgoTt
	egY+jeECzcrnYXsrel3o+eqDsubi+Q0onV8G2Rolzb8ePnQPPEFY8LBjkQphYipP
	icxBZESamF7t5J2iaOECSdlr9w6h8eeTjHZPmqVFJYW0ZLuelbUdOsk/VttdOEv1
	LT4N4E4iAoJxQywpwAhATFeuniZycl8cABQTVzc6f71pffIt9REeW9myoBV5UIcy
	goFPh6sxdwTiC7KIQkXv9BPeX3rLSKAoqqg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793727067; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lPzTzLEStdwSE0Ney3Q89iaqTF0FaLy9fGUQJ8QvHR19eeu
	+5yiEjnDIfcX3P/3X5atos9UgKG81Wx8q/hnSTI9Wq2+tukx2Q+53FDCKa8+a5b3
	w7EK7X8sNFJB3WKKb59Sm3htCIeydlzRyRjym360ecYge+TjH82Xp6rV4oF1UDGR
	wkM7P4NipayLwlaRhAqJ8a204TeB4h5spwentoTuzT3VlaK+NEt+3cpV/PH3pmD6
	757SbrYieImzH2DVpYf3j0EE06xJpHWTQ7y2k8BEUqHsicAFFNSssN9jIy/FNoiS
	6BSzCVZNiPzxeMs3aWH0R2JEXWb/NDqMWDsvv9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:+3Trs6f19YUQ1vM5K9vqzFjjHZs54DU1oEY/hdZ2npo=:offEvYcKkY6X98aDimOsQ/IBF2t+v3/nBFqfYJ3jU8s=;
X-ME-Sender: <xms:WxrqageRcIu7875K922fpL8C_1tPSA9zZHsH3CJMvPyKhmtcNYyDhg>
    <xme:WxrqapHw2mAyJrfLjiiS9Doeiv7XSXU7O5gWP0w9ATlWOO4VI5vgIbg3MUa5T-KDj
    YMjekEZAZ7viAgEr00l0Qvh7c3EyjQqY4Dw4l4hTUNtGdTJz3sPTH4>
X-ME-Received: <xmr:Wxrqap1GGRjZWT-aRVONLhCKUnzJWkR7nDwpyRwMW7gKJGDzIU1w2iZ7s1v7JvuUdYOCILEsOOk2oOHcSlxPl_grFlqKiuycsXEc>
X-ME-Proxy-Cause: dmFkZTFUNOxqLIQOlrgqis1lxXRmULtqfxAoOTI8cDdI/o5X/AWg3Mux6sDP1CGL37XU86
    6WgpZEhd8vvHwL6PFNSUAlnWabYxvOyPIK3ZLXUZ5wtfOE0/8eEcjecIENJbd23QeJDYvD
    Q0L8cLSt1wUKCry/JEVfalFnOyiP/fTbt5jj6CvOmQBX3MLyiCcWYQO2tUwGmNZDZSUtZX
    EIuQq+n+P/ccxGLwIMvN2Os1HHQ5boTbG17gNbZPU2mTjsy3VqNmwMM6RYO65pmEGBUgtV
    xF6aDOY+ePZTdcV9AwOGxuhx3QLPl0jdfWXFIBK7OzlmtKc8IZT0XmD75sKSPtPp0h6JqX
    lDd8V/qGLFRkbAK9YN5R8TMYANdTGX96t0UMZqDoUBpKv2eFUOzM0YkEDMldSVbZXaL8M5
    07YXyRheAvVijl8PerzWXWwF72+WPzt7w0DMIxHU+gYscN9KlMkzdj9iop5HeqIK41kXci
    KKYnxJTL/XwvdtcSX9aaxk7ahTYh0mHPcmd7bfW1mxqHBOSUaxNIejs94IdG/mppZPm+7X
    xoUwNC3NPXyn4J/vJR3mGT2qSXtujcfmC8hLJnBTspQjlmn13xPLeaZRpZa9jwGO/b7dez
    GyziO3iohdwObWsFTd9DDT1eMjNofOqc++KkKVbs2ArqHUErhCZxn99ZMcKg
X-ME-Proxy: <xmx:WxrqahlJkbx_igjumKofHq5yH5UZO7BLNO9i_UlFm_52rmE7txERsA>
    <xmx:Wxrqap9SqhfAXdmJFuTjhK3p9dL2Ko6uy_MB8CzmWIsEc8eN985CAw>
    <xmx:WxrqamphUCp-0xCElYSG6coyv42azvsrbpYlQA836XAzz_4libIgQQ>
    <xmx:Wxrqain-r0v4nwnTJ0i6QmC0THzASc-c0rsGp7DYoLl6R3kGTghseQ>
    <xmx:Wxrqao2kA9TNOtLS5rN9QBvXkIK7YVakNTbAzI4kXFNyKCKlKfVcAu2h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 12:31:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Okhuomon Ajayi <okhuomonajayi54@gmail.com>,
  Srujith A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH v4 2/2] t4041: test SHA-256 submodule abbreviations
In-Reply-To: <99a1234544840e63e6f3dcf3c6beae3ba02af84b.1793648430.git.gitgitgadget@gmail.com>
	(Srujith A. Poojary via GitGitGadget's message of "Mon, 02 Nov 2026
	19:40:30 +0000")
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
	<pull.2288.v4.git.1793648430.gitgitgadget@gmail.com>
	<99a1234544840e63e6f3dcf3c6beae3ba02af84b.1793648430.git.gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 09:31:05 -0800
Message-ID: <xmqq7bitakkm.fsf@gitster.g>
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

"Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Srujith A Poojary <poojarysrujith@gmail.com>
>
> The expected abbreviation for a submodule commit depends on the
> repository's hash algorithm. Use test_oid_cache to provide the
> expected value for each algorithm and remove the SHA1 prerequisite
> so this test runs with both SHA-1 and SHA-256.
>
> Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
> ---
>  t/t4041-diff-submodule-option.sh | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

It is strange to test SHA-1 in 1/2 and add test for SHA-256 as if an
afterthought in 2/2.  Shouldn't all of these come in a single patch?

The change to add the second hash algorithm support is surprisingly
clean, primarily thanks to how test_oid* support was done long ago.

> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> index e80472af32..4539d6bba5 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -14,7 +14,11 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
>  
> -test_expect_success SHA1 'submodule commit abbreviation uses submodule object database' '
> +test_expect_success 'submodule commit abbreviation uses submodule object database' '
> +	test_oid_cache <<-EOF &&
> +	submodule_commit1_abbrev sha1:0000000000e
> +	submodule_commit1_abbrev sha256:24c81a5
> +	EOF
>  	test_when_finished "rm -rf collision-super" &&
>  	git init -q collision-super &&
>  	git init -q collision-super/sm1 &&
> @@ -27,7 +31,8 @@ test_expect_success SHA1 'submodule commit abbreviation uses submodule object da
>  	git -C collision-super update-index --add --cacheinfo 160000,"$commit1",sm1 &&
>  	git -C collision-super commit -q -m "Add submodule" &&
>  	git -C collision-super diff --submodule=log >actual &&
> -	printf "Submodule sm1 0000000000e..%s:\n  > child\n" \
> +	printf "Submodule sm1 %s..%s:\n  > child\n" \
> +		"$(test_oid submodule_commit1_abbrev)" \
>  		"$(git -C collision-super/sm1 rev-parse --short "$commit2")" >expected &&
>  	test_cmp expected actual
>  '
