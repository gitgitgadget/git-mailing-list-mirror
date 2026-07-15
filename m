Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C963128D7
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098719; cv=none; b=KrRLcEPvQ9Sjf/JL0xOeLKFXWLq+dVrcPauv2AOiU5Xn4nC2VqR8m+hgTAU8a5q24IpR3gwklQtJqVlthBsZrI2oJ+fXdPZQwd5pSLI4/T3h/AB8pEb+l0kW+A0BNFL3bD4syoxYhRohpZTiKD+fdHA03otBE+BPyb0/KF+goyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098719; c=relaxed/simple;
	bh=fjATS+Zmh8pGuhv6jkoyrGyUctvPdCofCf3/jz4YXKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5uA6pfpLH/aUsrSkZDM+O3FrRkXi/S9ry1+1nFktyJ+8oOZoqXAbMq/VDA/VkcC4Tx9MyZtXnJT7t2/hd72UvII0hEoLlfOw2eKiPEppdD9SOvSvC675oguKrvaor+OrsXPZuQUP5qdKhTLLJdSs4mNOK+wKzCeHBwRWvnxV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TLB05+8h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gaYazdhI; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TLB05+8h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gaYazdhI"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DAA517A014B;
	Wed, 15 Jul 2026 02:58:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 15 Jul 2026 02:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784098717; x=1784185117; bh=PYQVKg3H0E
	Zx5nrOV7oHyBle/w4xSmcbq5kUUkGCQ54=; b=TLB05+8hBJ6ll2HID6klnqLf0h
	oz5SeODOv2dWUTGjUbD037WSOMsTrp1ySBF9iFqv67Wgi8+VE3PpFCGQ3dp8UOS2
	wjoStSm5ZAHN89ZFRAxNWgvqDv0qodwcaOyXtuOEmi8YGdLDCB7xE7C+J4NAGCIz
	dDzRNUTbW19qui4KDaL+PAb/MygUthkLqXCjsvUtBe9OZzNZHb0+/2UUu824Eo5T
	ZyhfdfqMUE6wJPqX3IKuPv2aQ853jR0fTYIw3Fc8n7YwfhkU1ZxQ3PFsgvoYEVmC
	GHRITwsIqPQYl6MicqhsoDTrj4udjvG/ArwPKj++QnKW380ugmQ8OIHE8Xcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784098717; x=1784185117; bh=PYQVKg3H0EZx5nrOV7oHyBle/w4xSmcbq5k
	UUkGCQ54=; b=gaYazdhIbd/8kl53W3/W/544SRzf6qAPlpKv+ACnbrFc/mFeRVo
	Uh4P+bpPurGLA5ZrewfHoyOMk+bJjQz9Lxfte1ZNoCJCKyAb7hVhguIe+BHNaUR1
	RKbfXZc5g/Rmvqyg/7fTztvQS/l+9ERrXWxXj+zKyquBk8H+eXftkJymJs6Wrv1j
	l1uZba1anbJMdyC+GXwvkH+OfyhfiTLuz20BNVDZ5zfK+McueVD8fFwX0ZD1wAoK
	s10aQ9krkYL3vucL2vxqGo/Gbfc2kTeFv8OVptsRTKm5XAAU6DCvB+s8vjooe0QG
	jjiizwX38kvBbXNem8n1xAN/umivW0ekZ7w==
X-ME-Sender: <xms:nS9XavnK-akJ8AEvXm04BtTDat-GGm_LspOmx-RtJQVgGi860TT9bg>
    <xme:nS9XaqQZFYmFWszWZ1nL1blWUI8KKpCExDG0ASHDRmeUGivbEhmgryrOr1RHIkG8e
    v8CYR_zlqtX1xOrH1hAMOrBVi1hNzNRfDnEj-2_x0AkLowlHX5b>
X-ME-Received: <xmr:nS9XajBLs2JQCzzGDmvl8AcgJpO7ecsswILyMfn6VgM0QvlcvOam03omUFsoAks-PxsFKw7PWOr3SaYw05B_ERIcho8iAeWxjueC-vOS8Ms>
X-ME-Proxy-Cause: dmFkZTG1WWLcByQmmxMSO/Is/1htfmCFwhWIbKc8tIyFwIy51tFCJGhWeULuMmLOXCSBLQ
    MFx1NYf4CviGlxGqPgq43w2i6MMCPtAwKkpA08/2Yta0HdXwCFPrSj0n6YWWjj4yYRMvdj
    m0qyDTj6SufVs3QizVkbE3H4edg3c3M2MnQPEQDOyz5AjnzUcvuGvK++Z5CbADHe0XZePf
    Q6jFCZT8ntJHMp4+oFMZl5p845ZNgpHlDOSm3eoZSpB2FtBvTnTwkfeVjeecBnDY75Aqfh
    XZnCuuGXJnvxOWBdYCMGi+rojKUK1izkSXYOhntYw2Z1/dz+wA/Hwfa0SczX5RCrgIR7WX
    NyZQw1eJ6e8XzK8sTOiMbTo+O/9LrunFugAAOBinwdyI2ebXI1HcBlhiV6YPzox5ohzxIY
    rfYecL1pIb6kpwmHzIvXLOgkSkvz2g9TABQvaqfJnbEeENWREE8+ON+i78tKHOvnaJ6zWT
    sIEVAxFqc6lptbUjNcmYGPifmb2/uypfhFlf0oqusG6K2O0z8ZYDpwXmPvwRNJzE/XPeX2
    OFpXl1Kfta/UZUQLGKfGMzB9aG7tQWJDSqDuJ20AXHvQd0WobeZUbr/hD16QvNz0iVvqkv
    MX6YSzOpvQW/ILidAtFutLm+iqq4qWmW/uQuBtLkv0yJFkXvmXkwq50eyvEA
X-ME-Proxy: <xmx:nS9XahSn7vQvit2w7FiA7vxocgUX5-Ot598lC7BucK5GMK1r3_KprA>
    <xmx:nS9XahqXinxB9fxwzUdJfhC51RHnVnBhtnu86Gm4nuFYcOsi4nEcSQ>
    <xmx:nS9XajwzTW0kBpdHNgS6klAwxQT0EXqG5g1fzWvKTBtvKDE6gk2DCg>
    <xmx:nS9XamLCCZd8sN5wAU0VSeWytmGvSZxJ88YLeuN6j6zBfbbARLGv4w>
    <xmx:nS9XavyQeVGgyKQlAqxRrfW1L_tMeyLdqT7MKvBeNQab-GDX2oc-7shK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:58:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9b2ee93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:58:36 +0000 (UTC)
Date: Wed, 15 Jul 2026 08:58:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 10/11] bisect: check get_terms return at all call sites
Message-ID: <alcvmX3b6y92KE4y@pks.im>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
 <c0827a79476d02f2b09ded919b44860e3743fbe0.1784069325.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0827a79476d02f2b09ded919b44860e3743fbe0.1784069325.git.gitgitgadget@gmail.com>

On Tue, Jul 14, 2026 at 10:48:43PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Six callers of get_terms() silently discard its return value. When
> get_terms fails (missing or truncated BISECT_TERMS file), the term
> strings remain NULL or empty, causing confusing downstream
> behavior: commands like "bisect next" or "bisect run" proceed with
> empty term strings, producing nonsensical ref names (refs/bisect/
> with no suffix) and misleading error messages.
> 
> Add checks at each call site so that a failed get_terms produces a
> clear "no terms defined" error, matching the pattern already used
> in bisect_terms() at line 512. The check tests the term pointers
> rather than the return value because some callers (bisect skip,
> legacy bad/good) call set_terms before get_terms, and the
> set_terms values should survive a get_terms failure.

Hm. Are there any callers that accept the case where either `term->bad`
or `term->good` are `NULL`? If not, should we maybe adapt the function
itself to return an error if so and then have all callers only ever
check for the return value of `get_term()` instead of also having to
check the result? That might also allow us to deduplicate the error
messages.

Patrick
