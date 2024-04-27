Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E68F848E
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714238603; cv=none; b=IK4afy7ShBYkJWEeTlc5A9uBiJXJ33F81ttK2gmi1S8fxtw4V2yl5cPimh4P00+3eDKDCppitBhe0Dp6RmOq+ao51BeoUPRh9/DaIU4BTOPpERH1RPFwO/q1/kHYDWKcox9sZJltaYiJTuzVjk7wWXGn6iVgkPBpeSPPqUjFcgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714238603; c=relaxed/simple;
	bh=JpbxiAQi8ZQKLTQoMMKK+tnH9kZV0Uw9H7rRw2v2UJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P7y3n+lNRFUVl0IRpi0OW7f6K5AFMTnWO9SllSfyHmu/KOHIVX68Azjh3cmS2T/nciH2clR5UNmfrOR/91i1ODiAIirSjuaAJIB45Kf+Vpk1AvRv//Pg1DNWKE/yGkzDiyRfZhq3VnctvFLKy8t9TRf8Dx7njYzG0pSm+mmf9H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kh6gj8gP; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kh6gj8gP"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D4E933AC4;
	Sat, 27 Apr 2024 13:23:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JpbxiAQi8ZQKLTQoMMKK+tnH9kZV0Uw9H7rRw2
	v2UJM=; b=kh6gj8gPpFF9MtbqfXBqdspqHTkZ+d8V01IpmKgpWfqR9Hd/k7clG6
	YO1l5r0pXt60419OXSZkjWtUcUGOJjH3JEWFSE/QpHakyGHXYNsbkzdtEEmQAP5P
	FEXS3XVh8k/Q6S00qmF2NRWiLlaQsX7nqMErX8C2B9lihReMZu3Hk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 04BEF33AC3;
	Sat, 27 Apr 2024 13:23:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 69C3E33AC2;
	Sat, 27 Apr 2024 13:23:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Test fixes when running with zsh in sh mode
In-Reply-To: <20240426221154.2194139-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 26 Apr 2024 22:11:52 +0000")
References: <20240426221154.2194139-1-sandals@crustytoothpaste.net>
Date: Sat, 27 Apr 2024 10:23:19 -0700
Message-ID: <xmqqil0267p4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D7E7DC9A-04BA-11EF-9CB9-25B3960A682E-77302942!pb-smtp2.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This series fixes two test failures with zsh when run in sh mode; that
> is, the mode that occurs when the shell is invoked as "sh".  sh mode
> provides the most POSIX-compliant behavior and avoids a lot of
> incompatibilities that the default zsh mode provides.

Thanks, will queue.
