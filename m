Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3320B33
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721278226; cv=none; b=JgoWFWb5m1pCQ4vtNL7pDPM/mGflx04RdmIxJ51bEKq1B0YgjiZSM4NRvNVebjNLBqJZQLjodENfvapVKUq6PfQEpkQGMl6YF7uYY/eArdIpllzUj/A10I2YXnZqm6DkgTEeDziF0kg4Ksl9pDjMJfGIR6k4V+PRs5fBVkBv3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721278226; c=relaxed/simple;
	bh=XSXpJomcuf1dz1NDZkFFU1Ng5XFTTXEe+bbQkDtWYfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ATDRh3c9dXbSwKPyZSrbV2HSp8mWDpmHio97Jo92Mn+B7W7oCuOx04DqH/Lv5Vpaghr886iQB8vHEg3ZNReOsRf2E05klQhrKyjUqjBlTIQ5iHoZkMYuHMWHPvcpP3E9Z6ofloTDIgoK2iMzyJSnFKkFFvA9F91qYqinfvwtB4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qOD4LZ8A; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qOD4LZ8A"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BCCD26815;
	Thu, 18 Jul 2024 00:50:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XSXpJomcuf1dz1NDZkFFU1Ng5XFTTXEe+bbQkD
	tWYfE=; b=qOD4LZ8A/oxLXWSUwm0ix93TERV6gHzxJu+cs1Gpm9V/w4PGpH1xbV
	JkmNkiJnAcD0mHGf8a4Pdu0qaWK37S/0Nv7U5jqVTWtLUEvD9Yxn1BvJpwhp8yP4
	lXWr+G3ucaEOeAC9umE7cb+HZ3zW5e0r5PYcPCLaU/wlHjNek0BlA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 23D5C26814;
	Thu, 18 Jul 2024 00:50:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 90D1326813;
	Thu, 18 Jul 2024 00:50:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Subject: [PATCH 0/2] misc Makefile patches
In-Reply-To: <7a38d869-8d8a-4922-894c-59ac7fc20449@ramsayjones.plus.com>
	(Ramsay Jones's message of "Thu, 18 Jul 2024 02:10:48 +0100")
References: <7a38d869-8d8a-4922-894c-59ac7fc20449@ramsayjones.plus.com>
Date: Wed, 17 Jul 2024 21:50:22 -0700
Message-ID: <xmqqle1z1ey9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3E488BA6-44C1-11EF-8E7A-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> These patches have been hanging around for _years_, so I rebased them
> onto the current master branch @ 04f5a52757 ("Post 2.46-rc0 batch #2",
> 2024-07-16). This was prompted by the sparse discussion tonight.

I do not see any immediate downside, but lack of immediate upside
matters a lot more at this phase in the cycle.  I may queue them but
neither looks worth disrupting the upcoming release.  So it would
have to wait before the 2.46 final before it hits the 'master'
track.

Thanks.
