Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7526818E37E
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 20:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724186503; cv=none; b=Pw8QFZdCLe2dAdHuLjmZ3Ri44NPZG1CnytsTkbGXhVkf0n6jaUKYzkjngdYuFgZaLqquCR0fY/0dbcdzbYMY8pDUKk5mVlq3qgFvd7OQTuo3540D4S0Q7biDaNoshrPGUIvnCk3g14Ls+FqL3l+/Hb7dFDvSov9b5q9g0YFiEqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724186503; c=relaxed/simple;
	bh=W3b86rP7NicAh6CRJSfWLS4qzbXi+RS8Cbh+rfqsBLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZQ5shSbv5CEORGDELGK9tzZfIaUTdJdBSSETxTqMYoENrpG/RMvQqZYDpmFuuQe12xYleJyZQJxgjqq9+37z3VEx7+z6QFH474XxdrLUyes6Ra97Tefgb2dPrUx6rrxZH8OMzfWDBuWUDOyHKkyjH4WPixjfPsMvMh4ETsli7HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XIFGONm9; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XIFGONm9"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E50C2F618;
	Tue, 20 Aug 2024 16:41:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=W3b86rP7NicAh6CRJSfWLS4qzbXi+RS8Cbh+rf
	qsBLM=; b=XIFGONm9b4avtft+WvYrPv4vcZQCM74y4z2Q50A8phTwxNh5PuTGmR
	55MJHh8ziasdRGaW54WrAQJ63dZWByeiEKZmGqoC8/xvDRy4TYEEB8WLyvhW3uQO
	ZMEUaebcQK9k6ciPPcMH0onh0qgpEOZdaI4iuVX4r04oYya0f+qiw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 96BD42F617;
	Tue, 20 Aug 2024 16:41:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 29D102F616;
	Tue, 20 Aug 2024 16:41:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: v2.46.1? was Re: What's cooking in git.git (Aug 2024, #06; Fri,
 16)
In-Reply-To: <7fcc8d92-d60b-2249-233d-7ce99ba96565@gmx.de> (Johannes
	Schindelin's message of "Tue, 20 Aug 2024 22:15:15 +0200 (CEST)")
References: <xmqqwmkgjomp.fsf@gitster.g>
	<b6e3763d-945f-fdf7-e620-cd26b8c72419@gmx.de>
	<xmqqplq4e31c.fsf@gitster.g>
	<7fcc8d92-d60b-2249-233d-7ce99ba96565@gmx.de>
Date: Tue, 20 Aug 2024 13:41:30 -0700
Message-ID: <xmqqy14r53lx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 956FD3F2-5F34-11EF-A4E5-BF444491E1BC-77302942!pb-smtp20.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> There is no immediate need for it and 2.46.1 does not even have to
>> happen.  Just a grab bag of topics that are safe and are already on
>> track for 2.47 are kept in case we accumulate enough of them.
>
> Thank you for the clarification. I am a fan of getting things into the
> `maint` branch early, so I like what I am reading here.

Merging early, often, and in small batches will in theory make the
process safer by giving us more chance to see things unexpectedly
break, and that is why I too prefer it, but that is only true if
enough people are paying attention to the branch.  I however have a
feeling that nobody uses 'maint' UNTIL the tip of it is tagged,
though..


