Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4524F2E3374
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 01:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741914386; cv=none; b=j4GnsD/8awo9PS29srrZDzZz8EJlKjKnKmylP9+ennL+S7OTB+uH8jXh4W+L+UQYcAQU+R/YrsDjHYJKN2P87sISXtPLQj3EHlFKl1GEjUHqjtDA8MiiM3UKNW87q0pH6YHsn1waTSOi9YewBpus1gz4zqYZ6EQXlKe8S0pZD84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741914386; c=relaxed/simple;
	bh=YSJIGA/pDw8qX/bmB2V2LhZYQkzbif2qtyzbIp3NffA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qSTX+WcnhVP2Id/HQy+m8DievRN6fPsXkr8FCGeEYyiJh3aMWgWQwrjYKU5A1cWMJfR/RgSP7MmYQRxNWSwA05CNrjkY9dH/1XdNbS7F0MpcWXZhlxpf3kWLZFn5lSGu2WKGXYmr6vwxZj/HGn29yU9/MZv/zYLzo/BKYPVdGgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V9nYa8/s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WniMoTJP; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V9nYa8/s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WniMoTJP"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 506D3114012F;
	Thu, 13 Mar 2025 21:06:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 13 Mar 2025 21:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741914383; x=1742000783; bh=XNEmoSLs1c
	Xh79v1v2L+qMHh4CnKg9P8MubRupEKwYM=; b=V9nYa8/sU4ACbuYJ2hEGanqzt+
	l7O7m8ZOHG3ldfkSN9rRjcYQC7DuHLfLCe3GjoaWWR/ZlJjVitewEXFxFxTQZ+ml
	Ps8T0Kb9KrASeJtoAcjbpe/5Wp81PL6nG422QHKwkCsTRrL28oEX1Bau/VFBVxaO
	ouMDfO8MoqK2tglNUvx8/04Y76HTO+1cedC0DuepWGL0sqSllmgG2Hr7RKYtQQ2H
	ElBfmOuPpQmZ8WnDhYx8W8Ft0lpmkUdRxy7c0/2baIpdIsloek+hERttfgKzvR9b
	fSPF4OSG8mhAZRZkAOdNyMxSHAyYLxQWTy3hgTDJBimSTvWofWztl157edGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741914383; x=1742000783; bh=XNEmoSLs1cXh79v1v2L+qMHh4CnKg9P8Mub
	RupEKwYM=; b=WniMoTJP2SiwFyiGL3Ka0cpa/CicV6mol5oFusWrslm8E5S/PG/
	HbZwur2A3FUHPzytgKT1lTzsn0CYbumsSprP9S4GXHTKAd+sIrIcar9II8AeIvw3
	oiy37wZxZk3mhFlaNIZjdOAKTaeDXtxK30Cwk09AJ1R7Ylu6SkV0erv/aDo66LME
	ShBvCqquaYF3sdviAb8X/NLld68Rom0OF7LLOCbsEORFQtaJvodPv9S8nU6A7wcB
	XMw0M20/f9DC8vCabSaKsOwgEstIwn0/ea1Afr638E9ZQQkTr27MtAF8rR7CASkD
	+XOVKD/ZSl0te9Tq8HVXUROHvWgNogAzBZA==
X-ME-Sender: <xms:D4HTZ_UqF0Qoq4O0EdyQlR-Ee-Jg2LYfhP6g6TpkrsuHOygA1O-CRA>
    <xme:D4HTZ3mERya3eYApYXU_6E63Mvsri8eO-Ip9h3Vb6NkIDS42bM1s6kgQhf2mBXEMX
    tu-hCaFVFONTvgHsQ>
X-ME-Received: <xmr:D4HTZ7Z1ZJI5x3UahZQ0imug06K62ou7jzs2vfHJWv6gle4BW5a6IQoTDbjevuJjHUKqaYK5uV78LGlQ9tyomMJJr4gbG29i73HqCc0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdelgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieegtdffvdeileevueevhfekgefgveeh
    leeggfegveeuvedtuedtudfgffejudeunecuffhomhgrihhnpehrvghfvghrvghntggvrd
    htohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:D4HTZ6UOMzMQU9ALam8oqV8e4_uHV7I-vSL17vQgMp_ffUSEq5ToyA>
    <xmx:D4HTZ5k-RX6VkfGQBezwdjYJbXAwlBrG_Q2e-6jdlrBREwZqle9voA>
    <xmx:D4HTZ3e5q92hwtR-bwhRhsBMVjHK1fVVh_Kmj52_k6Ravi0ge5pp2A>
    <xmx:D4HTZzFzEEk7IGfzSea_RWjU7B91h4cYyT7pw2GdAMhH12E0c9ZG0g>
    <xmx:D4HTZyDXsAzKJoVgKoXsSYcYRuXaPdIqfvmmr7TDGakj_0wtrApt8naJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 21:06:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/3] ci: add build checking for side-effects in assert()
 calls
In-Reply-To: <80dcc2ba3aa0ef72abe18f8525d571ea39ac6382.1741911652.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Fri, 14 Mar 2025
	00:20:51 +0000")
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
	<80dcc2ba3aa0ef72abe18f8525d571ea39ac6382.1741911652.git.gitgitgadget@gmail.com>
Date: Thu, 13 Mar 2025 18:06:21 -0700
Message-ID: <xmqqy0x8l8tu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +make CHECK_ASSERTION_SIDE_EFFECTS=1 >compiler_output 2>compiler_error
> +if test $? != 0
> +then
> +    echo "ERROR: The compiler could not verify the following assert()" >&2
> +    echo "       calls are free of side-effects.  Please replace with" >&2
> +    echo "       BUG_IF_NOT() calls." >&2
> +    grep undefined.reference.to..not_supposed_to_survive compiler_error \
> +      | sed -e s/:[^:]*$// | sort | uniq | tr ':' ' ' \
> +      | while read f l

A few style guides:

 - doing multiple echo into the same descriptor is easier to read if
   you have redirection near the beginning, i.e.

	echo >&2 "message one"
	echo >&2 "message two that may way be longer than the previous"
        ehco >&2 "message three"

 - multi-line pipelines are easier to follow without backslash by
   ending the previous line with a '|', i.e.

	grep ... file |
	sed -e ... |
	while read file line
	do
		...

 - I thought our "one indent one tab" standard extends to shell
   scripts as well?

> diff --git a/git-compat-util.h b/git-compat-util.h
> index c3415ad7e0a..0aefd763751 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1584,4 +1584,10 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
>  	((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
>  #endif /* !__GNUC__ */
>  
> +#ifdef CHECK_ASSERTION_SIDE_EFFECTS
> +#undef assert
> +extern int not_supposed_to_survive;
> +#define assert(expr) ((void)(not_supposed_to_survive || (expr)))
> +#endif /* CHECK_ASSERTION_SIDE_EFFECTS */

Cute.  As this checking assert is in void context, the optimizing
compiler knows that the entire thing can be optimized away ONLY IF
it can somehow prove that (expr) has no side effect.  And if it does
not optimize it away, you will hit an error from the linker, saying
that the undefined variable is being used.

This requires a fairly good optimizing compiler that can peek into
(as in "inline") what is in expr to notice, so it cannot be free of
false positive, but at least when the optimization works as expected,
it is provably (modulo optimizer bugs) side-effect free.

Is this something we can use in our project?  I am just double
checking.

Thanks.

