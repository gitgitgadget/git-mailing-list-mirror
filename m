Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149F23372C
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 05:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776059286; cv=none; b=njSmpbRUrxCYg5rWTndfJVZC3cuku0pMPkPayMaS17HkMoaMLB1PtRC3dJ3sLZAreTLt2GEShdjbZFgpv8uGcE27p+qVp2ClaKzuVjSJaJ1Mzt9bzMiCia3FbU49bAMtpMUpBnL66oIX0tWod5d3en6kSm8bLwnnuM8KwesNhtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776059286; c=relaxed/simple;
	bh=SloxuybH2O2qgvl3484AUgUhi0j5LHLzDAXhyeGEhbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfpIesr+lM90tiC+vYl3AtTEzsZUDZ2SbojfG5QyJDRmEfzr1XGr0qZaNDgJZJnTK25QviJZStuUexdgbAKjq3sWnW+HOwe4P8fu3QJErz35R+ru7eBN3ypfYp2i9OMlFymZWKelMK0F6rYMzToUKKZatSwhisj21RbS7sBoX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=0PwI9DvU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KqV/Cbe0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="0PwI9DvU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KqV/Cbe0"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3A531400054;
	Mon, 13 Apr 2026 01:48:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 01:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776059281; x=1776145681; bh=LZFaT8x0Wz
	Vr7kZe8pbrlX/qV8oyK/HR9egDM6YmwH8=; b=0PwI9DvULXnCSqIupsLsWbt5KY
	p7grh7sPXZt5CJZw8tTu0zM8EYSEwTrXVIg903ZJcgM6klJcHJEJ5jSxJOUkwR12
	wAENOG1rH9SCo9vf9Z3adkqxqbC9d0Iv8MM+YPcRz28eYGdPCDL8iRYn3k3bkW5D
	44oQCngRORyfvpXT9ACTXpGtOD4WcR2ZcPVaZBfVE2JKWVxBQMB27Yi9kziRKOOO
	OncNbxLGK52t4EOxzKGaWm7duf9s1UgNa23/NfoSzmV724nj0nDUB7K/4mHR3PSA
	oks2eRsHaVKx5IeeuLcKIG/pq7bYLbyGtNhPyU5/OWzPGab/sArRd1BCLlEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776059281; x=1776145681; bh=LZFaT8x0WzVr7kZe8pbrlX/qV8oyK/HR9eg
	DM6YmwH8=; b=KqV/Cbe0pyoXC9yJcBQQrw1vYazzVcxPCnjiLaRtbIL/tezmS7m
	Fi+RfT2NfL8OjW6b9qINgdnqFOY4NuXUxqQ6VV7mHrac4PxRfqdbNZ5ta7QHj5sk
	zi+D72Ti2Xpy+URGu/EBvbkGfi5iqr1rJMNchGns7qZKvd8bkG6S/t5+IZVYLcWs
	xZVZHC+FDunuxAsTL4RkiK9O7AOUZugD5RrPHWKGHk2+R9ia5N88/+S/lm847cDR
	XKrGUEdqnUMcPCs1ldjFd3MzkMGZfPUIAEeImX52qe5M2K1Q1HLFPhB0TYZknOIR
	FjfNGKxxGRQYfi9BBV1CHn99FLm96/WwTLQ==
X-ME-Sender: <xms:kYPcacy0GxmJrkAotEN6sFeLjV-eZhV3miB1ZhFJrEA7-QXAC0qeCw>
    <xme:kYPcaWTi3gEJof61xM__it8eHvLgCwrQszBzAwRixY87Fn65s32a9COU6e8yl_Cwq
    3i-ZdIfYwPwVXZMGV3ylkdmbmsHzdeM4lx3Kjt8NZPsSywzLSqyFQ>
X-ME-Received: <xmr:kYPcab8yxauvgyPn3Pb6xqpqX11ebnRNH4gstS2G4H3U2_hgSyC2ETPcsS-Qc8J-sqFogLB3LNonY3uL3xS5_HOFhOtcJO8R07MKbyw6yOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kYPcaVp-fOAXBlVnDxdS8a4UsLav9QwWu8fjBLX9E3Og_iJdFIAFgQ>
    <xmx:kYPcaQkmRd-eKn7siWPDVPmtX6AgOYFQ7AkMbDluhxcsrXVW3ealKA>
    <xmx:kYPcaUIzgayJiZ4HHTbVDbqXLLBOzQFhVftXVcDFdq8NMNK0bk6d0w>
    <xmx:kYPcadzRfN-WlEyJXiUYnF7dgHfWkUAAzKTSt-AgKv4dFCjz84s2sw>
    <xmx:kYPcaYgcdEgW9QFzFHoHRn746TN3uhZ9dxM04vFH6Jbo70LiNGTeJHZq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 01:48:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8c58fff8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Apr 2026 05:47:59 +0000 (UTC)
Date: Mon, 13 Apr 2026 07:47:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/18] setup: stop using `the_repository` in
 `is_inside_git_dir()`
Message-ID: <adyDiEW0-wRlgp6E@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
 <20260330-pks-setup-wo-the-repository-v1-3-0d2e822837aa@pks.im>
 <CAOLa=ZS-bHiG0wyjwfzSbX4TgC_Jfpk2NXHAf=dUm6CvVxx80Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS-bHiG0wyjwfzSbX4TgC_Jfpk2NXHAf=dUm6CvVxx80Q@mail.gmail.com>

On Thu, Apr 09, 2026 at 08:58:03AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Similar as with the preceding commit, `is_inside_git_dir()` determines
> > whether the current working directory is located inside the gitdir of
> > `the_repository`. Perform the same refactoring by dropping the caching
> > mechanism and injecting the repository that shall be checked.
> >
> 
> The patch looks good. I do wonder if these functions need a new home,
> 'setup.c' is fine, but it is also bloated.

I agree that they don't really make a ton of sense in "setup.c". In
general, I would love to split up that file into two pieces:

  - The pieces required to detect a repository and discover its exact
    configuration. So scanning the current working directory and its
    parent directories, paying attention to environment variables, and
    detecting the repository format.

  - The pieces required to configure the repository based on the
    findings.

I would really like to completely detangle these two things from one
another so that the detection logic will basically just give us a
structure that contains all relevant information. And that info can then
be passed into "repository.c" to create a new repository for us based on
the info.

This would unlock a couple of benefits:

  - Creating a repository will become "pure", as we only depend on
    passed-in info and not on the environment anymore.

  - We can unify the creation of a repository into, instead of having
    roughly the same logic in both "setup.c" and "repository.c".

  - We can remove some logic that essentially re-configures a repo
    multiple times as we currently do in "setup.c", which should lead to
    a much cleaner design.

This is already thinking ahead quite a bit though. The next step would
be to de-globalize some other functionality in "setup.c" first in the
next patch series. But afterwards I'd indeed like to tackle this problem
in the subsequent step.

Thanks!

Patrick
