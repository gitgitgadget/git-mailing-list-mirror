Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9011F8723
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059793; cv=none; b=Kz2xx7mT8ocm/Vv/kc1JHfBWTNpIuHskxCW00vtwQKgo+VjHfpHA9OKO/tSSBLvo5yw9J3spIKmxFpdxEhuAwSBoFKKsw1HfPYnoV7A92BQOk7S9ltA8eA5uFs0SAqwLgrrIt1EVaaJuVp1AkKgmNuG8xBjjRRYA5u70lcyExys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059793; c=relaxed/simple;
	bh=Yj+dvHStkfFDxM0y9puk2wDxtwdfCGp0uFDr71u6uEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IFdSZhtdGT1qX7j/3S2in1xoHNlTsmm5nL9Kd8L2hUGawGPBRaJg3xsWczRN7C2GWvc9ZC741YuEJnwq/UklIU08n97Yu8XkUmqIO5JU4rZOel1ZJuKamHNhfojIQk7+eT7sC5bY/S7g3Z0j9B9LLxn/ZxoXIqNAsmQGE2hDmQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jK+iYCsF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oGFE/glY; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jK+iYCsF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oGFE/glY"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE82F140008B;
	Tue, 16 Sep 2025 17:56:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 16 Sep 2025 17:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758059790; x=1758146190; bh=ZO7PtGddo4
	A7Q7zp5I4jCkoEJgSz3gmJHMeHXdoorCo=; b=jK+iYCsFR7wCcN2HTQe20axQnR
	9qX17Y3ieH9oUFgxs88eFTDqNlmdTXOubTZepb2e+fI6/XkipU/qsHkxOtQnlqiT
	zhPaKlVPZPb88PAKac1KelMRF8PB32l946bZ5d2iI66CLyNZDJ2Gv9AtJdCiZy1d
	uTi+mGcz8SSC9mnt2E9C4ihleD2tOH7J2tXxfG/5+OJ2TPDuxa+6LWXoiqa53AWO
	LMZdeCXQfYHf+ker83DHEJOs7beNAd1B1izpVMUfYgpQLJDLG6tsQqHAgFk1gkpP
	55siLsXuKOJj+GdwVFpRSza4eM4K0ydKF7Un442oBB3x7HXW7h4l28y2f8zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758059790; x=1758146190; bh=ZO7PtGddo4A7Q7zp5I4jCkoEJgSz3gmJHMe
	HXdoorCo=; b=oGFE/glYaK/gw08ifF/zYpv0rX9l/3VpHMttcs03ktRhLEDPo74
	hTTq+T9aQ73/SZbqGUsvOM0M2bHKdfLo3d/59Vn6WFLwWT2jRmdZH3ox/1e6uUQD
	mBfkF7vZAGgRnXKKaDQd/eWZ82B+j+S0ubXg6LFX9i4mK1vXjjkSzk0h3gF8NfEz
	RyUANtPoYhFApSsLpgbwds2hfQ+l7Xx3iIgNVeuJDbnHQ1NIZqCSSLPdrNiIPxaG
	NEH3QZ6BzR+m936YN2wVpmZm8tSwybSV2PMJjbC/+dCUG14KZh+ugMZQI89IWCw4
	aGKYIYdL6VxWlbHHpyKduyEK6SIw3MEjR7w==
X-ME-Sender: <xms:Dt3JaCFjVKK--NNtC6dTPISGRelF-CjWJUMfGNdk_Rz4cupcKrcm9g>
    <xme:Dt3JaN7oU10BH9ncRJ4LhvYklJnjr-YvMn86aj9BWNrXcU3Ns0WdL-dJM4uGeus7c
    GQtG4CfoK0xiwBQig>
X-ME-Received: <xmr:Dt3JaIuouSkH4-PXqSIKQwYq3qPRQlC-2E6e-AZU4gF1n8Zloly8BZ0ZY9PhKcBvpRUUBj6N7xlaD4M0qoQQYSNavxwWQuPvIoG78OQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Dt3JaO7a3iii3ds8x5KOVuiwy1-J9nONI2StOGoHMGoWy_VPvPX9BQ>
    <xmx:Dt3JaDVZkyUl2bxC0pjXzR-o63g8b1F8Vt3ABG1PVgLhNsVmzLXmnw>
    <xmx:Dt3JaA-tqRyvidDR5Az-GD8gxQcAhdW39V2QAWMAuE7cIXZh1eZMZA>
    <xmx:Dt3JaPkPu0x7hOAk02kTaigvJ5MgRtD92X1IuSrjA-_PpJcRLQaWbw>
    <xmx:Dt3JaBXSETBzFukah803wRQXjnOshT3T7tEF3HysUxjvYufvvGTgTlDD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 17:56:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 00/17] Use rust types in xdiff.
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com> (Ezekiel
	Newren via GitGitGadget's message of "Sun, 07 Sep 2025 19:45:03
	+0000")
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
Date: Tue, 16 Sep 2025 14:56:29 -0700
Message-ID: <xmqqcy7qm582.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series has 2 parts:
>
>  * Patches 1-9: Clean up xdiff, this can be merged without part 2.
>  * Patches 10-17: Define Rust types in compat/rust_types.h and then start
>    refactoring xdiff with Rust types. This depends on part 1.
>
> The cleanup in this patch series makes the structs xrecord_t and xdfile_t
> Rust FFI friendly. My opinion is that part 1 should be merged soon, while
> part 2 can be discussed further.

I think we saw that the earlier part were read carefully by Elijah
(and others may have read without finding anything worth commenting
on), so should we split this into two parts and start merging the
early 9 down to 'next' and then to 'master'?

Thanks.
