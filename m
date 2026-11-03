Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726854;
	b=XiOXwe7rfr5nds2H1ukArH40bAbBgLFxYtdVc3T5pjeax7CRMr/T0w8TGw8ARJqeEmdD
	 5lljzEWqPYG5JSQ35wQ48s1RNdL7csS2DEFXzICQz4Y3vISrczERqj8UPeUJa97ZoAyNQ
	 SgCeVoVEV3iyKrFvqUd9km2/dlVfM4Az+0kravn9pFD1oqmsQanmj8sj44GQ9WhbUS09F
	 705UxBRwVjYjcOHzhEcHPfR0OfKDb7Z95D1XbwSXlOHMyz3Lz/mh4Nt3xHZVzTijEkc3n
	 jKTuZhknwiMsO+AAm1q3Pjyy0pLd59jZmF5jDzRy5KS9Fc5otosgJ0JOGSbxlEWEqnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726854;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=v/3w5rKdrdAK/j3FSL2+DWckR+ZJzz+auC2Eyz51+IQ=;
	b=qZEKSHBNaiki2zW/rhDJJasaypxXevbpi8w11Jmk6XnAkCofCW77zX08klfErO162xAO
	 KV5YLkdGKZCCfnEHErrk/xScXLiHgn378gg4i8BCZhqBTkthXC0C+t0YdIhWotflxTX38
	 Qj/t9CSHcFfIlxoF8aKL0KZBDvYnkXNr0cpMnGrKkgNPbNdFT8IHOoXKUcZhdQIn2G6+W
	 TWCO1/IFtF2Y3yOQrwSfJOKhmS6GeXAEhWmY/sALSX5dZ22M8pb3QhmPh8q1MzcFOCKZN
	 0giE5oP1hadV67AjvMTC6teUQVSEZVBLJZvZCVt2QwGjSNR1BPfnOLc8T/Z4cX6sbEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=g4Iy5NrQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ouLfvGEL;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F248606A336
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 17:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F248606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=g4Iy5NrQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ouLfvGEL
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 93D5314000B4
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:27:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 03 Nov 2026 12:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793726853; x=1793813253; bh=v/3w5rKdrd
	AK/j3FSL2+DWckR+ZJzz+auC2Eyz51+IQ=; b=g4Iy5NrQV39Y8KFKTcmDqG21/3
	zcCYW6uIE4DybTPsGiF/drdVT6qU+5OjkT9QZg7KyEVJs07WEgJL3FVXx7ZL+Uh3
	P5+Yu40NdhsjrkPBTWE3MLVhelBZo7FXv0DWYMgZ9iAq+86dCXbRVIGqigknOru6
	QgjGoqiNqunopai1Zv1qJRghpGcfkKN78UUbZsWzGAfpsACJ5JQkEbP/FQM0KKY4
	zuZb8WJB6tYCej1+onFN8d95l2ir6d1Jtvo8D/oQFRgQqT8hgaX8/FGSUJn2V6Tz
	qcRBII9GBsrVsbRiZiH7ecFFFWZTvYDCf8iV6frkuhsX8q+ltbYZXVSdi2Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793726853; x=1793813253; bh=v/3w5rKdrdAK/j3FSL2+DWckR+ZJzz+auC2
	Eyz51+IQ=; b=ouLfvGELew6/HpyAOytjJWsTEo2Ek12eJpRQ4cnBIMKYkvpXA+1
	fsey0O69qopNaX18uiE/9uw5ds4t7cpYvGg6J27yZ3Yd+iCupkrq2Z7k7sSn+F1E
	5WgOrBvyS3n5tr4tfc4qIqutw7UnodHV8ZidCi79gI/1tv/fjJetO6V/KkAdGTjT
	ODSCajauBwL3jdh4ijhwurlPYcUOnBhL61YTD1nvY47TJcJvD1YEzYInccfGCAx9
	6mMFKbuL+5bzVOmZimhs5z9lql4STmNQ5ziPB7ljq5lIjvfZJTMdthGFTHSEx2yx
	3pXKUXWwPrnUEOf1fr0TCRSWpjO+u96QzMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793726853; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Uk19P58Gty/PrPykKJfsm6GKo5/4dAtNNmj3pK635tho32R
	EFlEsLBK3HLsjOfHNGycGOmEigO/rLYBjLWEIKtoknsHi+m+zghel5vPnjPjSljH
	Ai26QlzuvGAQj2dqgIXoRUIzT+NYoH+IW9HI7v73WkA1tpnskpyhUitkMFxv1YL1
	3fzc0G7MeovOP2FNv9udUoCtacShoEz2sVG/mgU6qkQh+JT6syX38WuPYF/a+3e+
	c1VADiseveYcLLTdHTGoZFdBzUvPmxpSK7lnYa9376HiGw018H1LrRAX52vGiS5p
	KEtApvGfrTcM3pepX2oGaLY/PA3YKfe5v2UmEJA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:g4FURWCKNF+CzQ3n/1jGKySmLicewmGcImma7Cu0Sgw=:4nXlAc14Y6dyUX9jbN4sZQ7bQV5XM8csCXetZLsPsgE=;
X-ME-Sender: <xms:hRnqar2-bK2ulkP3SNBLVHnJJLlyGr6NGDW6nnVTmiYHI17Z8ha81A>
    <xme:hRnqag_rE2JgLmHOD9YgxsCASTm5JkLNrBYo7bKDWDqLtksgIbuECrjYgz0q0ay2T
    Ycal4ruRhtVrl436LA-pNaE-pa6dxmYACyFWB74eJV1_8W76rJp_XY>
X-ME-Received: <xmr:hRnqakMikf7ACHpqd7IqMLUSx5jrx1cf28rH0oY8tR2Czrg-qrH-okRx8IwsvuruAHYNP2K_4faEcoVjqmCsxTkWF3xoxBQ88XuK>
X-ME-Proxy-Cause: dmFkZTGqhx78fk430icmHFCcxzrKasXOWL+7GGwngHCazKDVkBi/z/7Sr0GlHg5lL62rmO
    zmcDWaaNNTE7g1cojkwNwgfbuZ/x+1mChDEWe/QuzEAEHfFCGBApRqhvWCbhJRieHusd8/
    H99NyBEciOkhlbXg60DRyBHBBmy2bvQuyNKh3/8cUbxRnGx9FaeGd/TT9nwO4Md4+cj7m4
    U3IYPOT4ZeHf95Jo4M+CieyBDaIt1s/z4g/4veSxooNY+GsH7PcPsEbLJahwyEz+Hhs78B
    dZVOgXzbXISLkpgF/kT8tUt3IvF2lW77a7OYGH0SR560TPmQCKvuq+tJ0iErxGFBuYYqTy
    k/kbhEFiJtILbPosG2KCpPIt/+5iazjdlGkcE0XbJWEQecq7/8SBfXFv3Z2Xj0bwfuahTU
    Qn1fOP4sxwrueahIQAG8qh/Pn84BD5VqSxq/+IRRmDjp7roWPa/EywsSgGrqmcC6ADOvTJ
    Q2kLN7fu00Xgs46lgA923HysXUvP2tgDQ5aCrHJpnx27YGwOMRROK0DMA2wLEu8RIH9tHT
    74n7a+XMyFdJE6ZIXfagQ70styPxolCwh+j0QleIuOxrzKGPuJ9FT6Jyskg80dr4DBLlad
    /5zQCba1t1HCTZ6wDsMiZVmXJcD/BeLhKwA7zw6dp3ERn1/RRDgr4C1knMVw
X-ME-Proxy: <xmx:hRnqasfy-P2HG_CyHGG4O5ISc9edIDGDja0zdP1uioArCCWzvn7X3g>
    <xmx:hRnqarXlp2N3TDCCtIS6fXPlZE787lef7IdYbd0ed52h8zFqTN5i5A>
    <xmx:hRnqasjFtQMCXA1nz396IovFhdq5eRnS7jhAhPbAKqfNUf8CTaIKSA>
    <xmx:hRnqai8usP6KBdux4fq0Qd9YkzxHilbzaBm5FwAjcDvLyv9CkDcjFQ>
    <xmx:hRnqarvzkLFqa5ylOdTSK-TqOM05Z1MCetzJjVaKz03dm1lRit1Wibrh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 12:27:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Okhuomon Ajayi <okhuomonajayi54@gmail.com>,
  Srujith A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH v4 0/2] [Outreachy PATCH] t4041: use submodule
 repository for commit abbreviations
In-Reply-To: <pull.2288.v4.git.1793648430.gitgitgadget@gmail.com> (Srujith
	A. Poojary via GitGitGadget's message of "Mon, 02 Nov 2026 19:40:28
	+0000")
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
	<pull.2288.v4.git.1793648430.gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 09:27:32 -0800
Message-ID: <xmqqbj85akqj.fsf@gitster.g>
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

> Srujith A Poojary (2):
>   submodule: use the submodule repository to abbreviate commits
>   t4041: test SHA-256 submodule abbreviations

If you are sending a cover letter, you are expected to summarize the
changes since the previous iteration(s) in it, so that those who are
joining the discussion in the middle can tell the history behind the
current iteration.

>  submodule.c                      |  5 +++--
>  t/t4041-diff-submodule-option.sh | 23 +++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
>
> base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2288%2Fpoojarysrujith%2Fmicroproject-git-libification-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2288/poojarysrujith/microproject-git-libification-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/2288
>
> Range-diff vs v3:
>
>  1:  a8c54b9292 = 1:  a8c54b9292 submodule: use the submodule repository to abbreviate commits
>  -:  ---------- > 2:  99a1234544 t4041: test SHA-256 submodule abbreviations
