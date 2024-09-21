Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C74A74BF8
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 06:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726899595; cv=none; b=jtl6lDZO0klwBE+N0avu7ruLTuWnkTjCqkmzy97oHx3MJv+4TghArvaAqjyWuMxY6N1t13iFLe8xB0NN9j9PuKVHXdtACSqYWkvMbuAO4XwxWDZ9YDxV0s6222vh3/1X+JdCHVpXSP5vEjQ37XKFUcW+m9KRDOQkYpkis0yh8VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726899595; c=relaxed/simple;
	bh=elOiOnpKo/XvxOJ2QYY1Wiy6tOp063qidvFTpOUp0Ws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tcw7llDUrZoF8B8dEmJTRFkvQ1+8sjCvjSXWtD05WCDBv9KaCczW+K0sFjpURpBYRTRVTXLfLQDqHEfHhbdX6IX7Zv3Ol81hbWswM9vSkZ/svXCiVFklePLo/qbFSiQCI8/gv1+q+QzolIQqvsyBmztdO4lSWihiJYBzUzpJLGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cJTMP0xR; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cJTMP0xR"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2985C2040E;
	Sat, 21 Sep 2024 02:19:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=elOiOnpKo/XvxOJ2QYY1Wiy6tOp063qidvFTpO
	Up0Ws=; b=cJTMP0xRaqSGB/xdDtWBwNy9HQOJrUkJ6b2VeFYtDYvhX/NVOmDkfq
	FOXGSQFihXp15BZhoHHocaquo3Xey3smVJnyn6QMcSKSyAQt8zhXtN9qizBbdVIP
	SL4VKqAz0wSFjTe2zuunGJc/dzOGbdd/iAuhMDVKq8LpCiPCIu+zo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1253A2040D;
	Sat, 21 Sep 2024 02:19:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A3502040C;
	Sat, 21 Sep 2024 02:19:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,
  =?utf-8?Q?Jean-No=C3=ABl?=
 Avila <jn.avila@free.fr>
Subject: Re: [PATCH v4 0/3] doc: introducing synopsis para
In-Reply-To: <4ww5v253vz2g4i3z2x3dmgkrot7mcn2qm6ckjcxbyky6yvrozy@mr5hnrsfj6sn>
	(Josh Steadmon's message of "Fri, 20 Sep 2024 16:14:26 -0700")
References: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
	<pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
	<xmqqo74rxvw0.fsf@gitster.g>
	<4ww5v253vz2g4i3z2x3dmgkrot7mcn2qm6ckjcxbyky6yvrozy@mr5hnrsfj6sn>
Date: Fri, 20 Sep 2024 23:19:50 -0700
Message-ID: <xmqq34ltbkah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 829E685E-77E1-11EF-AA45-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> This still breaks on MacOS, as `sed` doesn't understand the '-E' option
> there.

Can you try to see t6030 also breaks due to lack of ERE in the same
environment?  It seems it uses "sed -E", so it should fail to find
what it is trying to.

Thanks.
