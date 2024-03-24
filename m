Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB1E81E
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 02:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711246836; cv=none; b=u1F20EPASrzEYo89ax9bp6ab7dMvPGwvc24bxvNVQneAA2Kx3EdQNw4RGS/Q7LdFYeRADmML2Ff2lHDMerhWzy6wEKQDMWLwKxnVHLkUJiYh28nIkgeoV6vMfdq99zeKtyGQsjgAqFvQvoBUWDsNleWQnWp4GT8tysrTs6RjkoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711246836; c=relaxed/simple;
	bh=KQmiXjZjajfflplBcX0JaCloWHDQ11lTzldchVCOJFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qXzlXvGENqRlgsKMx3IEvutB1L6Z1nAOMXxY+0A6FeJLjD2ufCwOpbMyRkc3xWZHRBDoMQzgRsK0e6U3xufgeMye6Ve9+2xefJSTEzpNTKepO7fqclfbp052oM/lIUuq0CoPMboFUbvNf84exJ5VejgN8rDhSKZQ2A8USoUdG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ua7tQ+OR; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ua7tQ+OR"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1DA84190BA;
	Sat, 23 Mar 2024 22:20:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KQmiXjZjajfflplBcX0JaCloWHDQ11lTzldchV
	COJFg=; b=ua7tQ+ORCYuGup/wfPnpx4fiyuWniqyqqj9kRxuqfo+b9qTGwqwalH
	z6pZ3LIP6LQJIDBz9mpbFh7VjB/8GOLC654PsWfiFxjdoQBx0FfnluVBsWE59dQJ
	TH+ZKeTme2EJkWf0U/R8oxhlJ7cq6kRaSkgeQmNnt+i5+iSq+ozXU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 16989190B9;
	Sat, 23 Mar 2024 22:20:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9A134190B8;
	Sat, 23 Mar 2024 22:20:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: Kyle Lippincott <spectral@google.com>,  git@vger.kernel.org,  Emily
 Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/5] Fixes for Documentation/MyFirstObjectWalk.txt
In-Reply-To: <gh4jcwzgxz.fsf@gouders.net> (Dirk Gouders's message of "Sun, 24
	Mar 2024 00:06:32 +0100")
References: <cover.1710192973.git.dirk@gouders.net>
	<cover.1710840596.git.dirk@gouders.net>
	<p5fii3tmfb6l7dgc2p35euwv4cp6ag64qqhb63wfu75iphqknu@tdo5ru6modr3>
	<gh4jcwzgxz.fsf@gouders.net>
Date: Sat, 23 Mar 2024 19:20:29 -0700
Message-ID: <xmqqil1cv09e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 16245BF6-E985-11EE-9987-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dirk Gouders <dirk@gouders.net> writes:

> Kyle Lippincott <spectral@google.com> writes:
>
>> On Tue, Mar 19, 2024 at 12:23:10PM +0100, Dirk Gouders wrote:
>>> The second spin for this series.
>>> ---
>>> Changes since v1:
>>> * Added Emily to Cc in the hope for a review
>>> * Remove superfluous tags from [1/5] and [3/5]
>>> * Replace bashism `|&` by `2>&1 |` in [5/5]
>>> ---
>>> Dirk Gouders (5):
>>>   MyFirstObjectWalk: use additional arg in config_fn_t
>>>   MyFirstObjectWalk: fix misspelled "builtins/"
>>>   MyFirstObjectWalk: fix filtered object walk
>>>   MyFirstObjectWalk: fix description for counting omitted objects
>>>   MyFirstObjectWalk: add stderr to pipe processing
>>> 
>>>  Documentation/MyFirstObjectWalk.txt | 36 ++++++++++++++++-------------
>>>  1 file changed, 20 insertions(+), 16 deletions(-)
>>
>> Aside from the small comments on 4 and 5, series looks good to me, thanks for
>> working on this.
>
> Thanks for the review -- especially for the detailed explanation and
> suggestions on 4.

Yeah, I too liked the comments on [4/5].  Thanks for working well
together.
