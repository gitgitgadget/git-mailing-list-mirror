Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F241C8606
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753731140; cv=none; b=itBcYZ2ePYi3GEmtx358MM5NfsD3fhoKoyc8CH3yabrBU+qnN+lbJz16JHgxnEknZmnj2j4gg+B65xDJjYYlhQuro7Ljiik6pA/1GKpWgSx7sLZjNTtgm6xAbjozFRivM43Qj+9SDN58yazEGN7p2IgYD0QfmoI3bCg9ysNt8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753731140; c=relaxed/simple;
	bh=mUYgvjwznL2A0p1XPHzZ6SeuTrJIOiWxfmJmC4MiZXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YwOy5+Oy7/A6cZlXcokcKXTQu6FyTB0lPf97x8MUKrJ02OVttF86jrp42mPfM5OoZxLInIZm2xd2WJqW9itX5GWTGveZV3GOz1Hx6KfIM/3YD+KuYk7cYPnB1BtncAOaS3Ecto7u/H0FwRpmCklpz3pGGWoKiepWghKQN0KYXYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ub8nABsZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j62pwS8z; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ub8nABsZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j62pwS8z"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C8F901D000D9;
	Mon, 28 Jul 2025 15:32:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 28 Jul 2025 15:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753731133; x=1753817533; bh=tJAyX50Rco
	ZvmzS+V0L3TDG6uCfVvbbd12Z0LNrGiIk=; b=Ub8nABsZkGUdN7WxMz9a/BfdiS
	NT+BYCxQShNBxSocbinI2SjEJ6DB5qvv27x3LgMgm+EIdUQIFpE62sqJVGjc6Mc7
	nETylnePss4U9Z4RDJDIdPE2RHUIrUX/wI1yr/5WxXfZ9ZeqOK18G1+9t0g1Kw6V
	dElm8o6tuVU3USB4KU8CABjhjntNTqd8Cr8AQA3+MqdCc1eswr+PCISG1FjufEqd
	ouCMvlYLZUMEpCEb4nrskZRYc8sb6vlaub9jKtNAfCIHK5lsu5+EHYtBDzV1pyRe
	LKeUrxyKciRplsLcVmcUFGC53s9PCaypHryeVybyeNalfNYwYcdTfm/3iQsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753731133; x=1753817533; bh=tJAyX50RcoZvmzS+V0L3TDG6uCfVvbbd12Z
	0LNrGiIk=; b=j62pwS8zML9kgIZ5lIle6rYlVgkUwYCReaB4/9RNPwiU+k71vOW
	6VLs6VjxXvRamJWTrgq8T4PG55AHcCV90A0YMAXJZC6DVcTHiUBZ6HSLFNwzl9Ar
	6eCZtCCl8SWUCZ8Ahz/9t/eonfONWoajFPeYQBZxM+gxxEZ5B8DW8c98T8XMm7gz
	GUxmNXqwx0MJixBP5zdGKkeyJAy1dg0V6P/l/iGUc6Qp05xryPGpDjirA7gU9F8X
	EyYrovF3343V9YU1FSR8/iNGOvKLKe2uWOInFY29fIiCz/TkWQFbRs+EdwhAJDFr
	PBPaMsme4t4icmXOznW81yryu7g1nWpDCqA==
X-ME-Sender: <xms:PdCHaAQh49Cei2WvIx47ZDpbu7STqlmtBJLpCJFsGSXXCgclEKkG4Q>
    <xme:PdCHaHPcT5WtL5YxdrMfj0UcaB3s-ITMWeIN_Wiw9n_T2yp-6aBZ60l-c7cvvnmw3
    RKtVMVtBOqmrYdblA>
X-ME-Received: <xmr:PdCHaNZ8qpVvEbgPiTNsb0XDUlFfAT6Rge4rqdacZDgtMv1ZAn8tmBCmkLkCSMs90U4TVjyvNBpZ5WXOExgG6T7xSn6mZZqghtLeXZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelfedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrmhhonhgrkhhovhesihhsphhrrghsrdhruhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PdCHaJx-8halBAh0J-0XZNEgSoHdnDkKTiH2mXuzcTVVN8fCMHmqEg>
    <xmx:PdCHaAL3_L1MbXmeUFsUyCUwgKqGwADLic0aa58x9NLRza2EjqHHAw>
    <xmx:PdCHaLqKiz_l7w2n83GCtPqBZnmSmcMdU-iPAGcPt2PnLu9-3NNvpw>
    <xmx:PdCHaHJXJiISrjovS2aH57c8cx02g3G8Q4w_lUZuFKHP2lzlAwZ1_w>
    <xmx:PdCHaGcaPl0xuEcVuGBp0-Rk6RhtTDiBZVzUQkjSamwmsKbP2u9x3hbH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 15:32:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/2] optimize string hashing in xdiff
In-Reply-To: <20250728190520.10962-1-amonakov@ispras.ru> (Alexander Monakov's
	message of "Mon, 28 Jul 2025 22:05:18 +0300")
References: <20250728190520.10962-1-amonakov@ispras.ru>
Date: Mon, 28 Jul 2025 12:32:11 -0700
Message-ID: <xmqqa54oun5w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Monakov <amonakov@ispras.ru> writes:

> I've noticed the work by Phillip Wood regarding hash optimization for xdiff.
> I want to point out that it is possible to speed up the existing hash by 1.5x
> matching the peformance of xxhash (but without introducing a dependendency).

Using xxhash() was merely a sample code path for technology
demonstration, so the Rust adoption topic may want to pick a
different code path to do its thing.

> The additive variant of the djb2 hash is used in ELF symbol lookup, and
> Noah Goldstein contributed a well-optimized implementation to Glibc.

What is the licensing terms for that code you are proposing us to
borrow?  If it is anything recent in GNU, I'd expect that it would
be GPLv3, which would be incompatible with our code base?

> I'm taking the refactoring patch from Phillip and building on top of it.

It is an obviously good approach to do this.

