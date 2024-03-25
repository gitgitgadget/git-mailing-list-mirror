Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226375D744
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401938; cv=none; b=XxHl+pDa47ElmvTlLGj/I0JGZndZt/J37qVZgMkSIuS54xeXpkc0nqgG7fiRLG1PnL5EVX8uXzHlNDmOgijmKMVU8gXcMw9MvLSOWvX2QyWoSqHlrsgftIfE7L1MjxOYSg7C39VUYqCcbxwy/KgbJGVhVt38GuxZed7b+DRUOJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401938; c=relaxed/simple;
	bh=MeFeMeTYxco2Imzz5Kt0XyUJdzWy6ghnBYoUmSLERq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IorybYI7sQ55GU0tUp9T0L5rT0z4rmsuepBIqoANolhtnH5qpQu+yqEH1cJ8DQeGS7grq30p3wOSHQO6r/ofyrK5/Tv8xjNXpWB0VkzOOtmsacyCMG/Mumtnv4DkpmQeQevSnyEBR3B7UNKwbI8Iti2nfCKeSNIsuRe3LWIIsVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WaHTuwyH; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WaHTuwyH"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B392C27AC8;
	Mon, 25 Mar 2024 17:25:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MeFeMeTYxco2Imzz5Kt0XyUJdzWy6ghnBYoUmS
	LERq8=; b=WaHTuwyHtCoVakXho+O3t4IcbuR+wuQ56CJv3QFMnwmqLCZFjM6RRN
	nHYYFBplG3eA3QvIsjOPhWiRt0EHP2YXuAaZwW3zyhYQLRhxUy4OU1x7TIhZ/3xy
	YXj8Ai8OPEl1B/bz9k88CQZ4jw4GtvpzusjvqtFtpxqA89M+JYvHo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ACEFE27AC7;
	Mon, 25 Mar 2024 17:25:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2160127AC6;
	Mon, 25 Mar 2024 17:25:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Kyle
 Lippincott <spectral@google.com>
Subject: Re: [PATCH v3 4/5] MyFirstObjectWalk: fix description for counting
 omitted objects
In-Reply-To: <ghplvikrdk.fsf@gouders.net> (Dirk Gouders's message of "Mon, 25
	Mar 2024 21:07:03 +0100")
References: <cover.1710840596.git.dirk@gouders.net>
	<cover.1711368498.git.dirk@gouders.net>
	<cfa4b9ce503e98035d3ce09b0c9e00bcfb6ff70a.1711368499.git.dirk@gouders.net>
	<xmqq34semden.fsf@gitster.g> <ghplvikrdk.fsf@gouders.net>
Date: Mon, 25 Mar 2024 14:25:31 -0700
Message-ID: <xmqqwmpqgg1g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3670AE5E-EAEE-11EE-831F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dirk Gouders <dirk@gouders.net> writes:

>> "this means that" could be rephrased in a way a bit more helpful and
>> to readers with clarity, perhaps:
>>
>> 	Note that our object walk will not perform any better than
>> 	an unfiltered walk with this function, because all reachable
>> 	objects need to be walked in order to ...
>
> Would it be OK to rearrange it even more?

Sure.  We are in the business of clarifying this document, so making
it easier to read is very much welcomed.

