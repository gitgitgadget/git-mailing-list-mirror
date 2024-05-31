Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D71134BC
	for <git@vger.kernel.org>; Fri, 31 May 2024 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198558; cv=none; b=m7UIW6bQYu1CU4XGQ/f0KjCZzrQlo75FJTKqyQtJ3EU/4oUqUT59vwEhOr5EgYlAIn9ZNYcmKpI9N6juo2z3abZhLVN9EhUX6I5LM6TmbJg6xzmK9dSOFKo2bvzTvWy9wB+jtVhPSk4r+li9NtaCZhilj4wu+jXu9pv8HtSO8r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198558; c=relaxed/simple;
	bh=XTKhwrgTkAExOlxEyBCb8N80M6JaDA6Q9zbzf7gCmx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cX25+GoAu9P4x8fSdZHTE5gtS2pFIRuW3jsAeafqL0KqadM3EQRHorx38s8uRvafxI6XuY1gJ6j1auunk2M+0FCv0Zj+GeFE0g2WZ7qLC8YF/i2Z5jJB2nOiGe7ddnQc5wF9k6A0x2I+yUxwkLG9PqonKVM6qCWfu7dAKOcJJ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pKsFZ5g4; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pKsFZ5g4"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FA381E28C;
	Fri, 31 May 2024 19:35:50 -0400 (EDT)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=XTKhwrgTkAExOlxEyBCb8N80M6JaDA6Q9zbzf7g
	Cmx4=; b=pKsFZ5g4p9vFbnlqlklJVWwwOZH38LrVv+QUfoOcbQIQd8LS14Mfu2y
	6vJIDZ47vpXUgmU9XjQ19+jLcZP7jzh5ygCGafN1kuosIf7SMbiU6+V8duhuqRXP
	pE2fevs//lAR+mKyMPysnmMtIU/GCkdb8/NdsatEKpM9Ct1jHgro=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF19F1E28A;
	Fri, 31 May 2024 19:35:49 -0400 (EDT)
	(envelope-from tmz@pobox.com)
Received: from teonanacatl.net (unknown [71.254.194.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A5A91E289;
	Fri, 31 May 2024 19:35:49 -0400 (EDT)
	(envelope-from tmz@pobox.com)
Date: Fri, 31 May 2024 19:35:46 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 4/4] BreakingChanges: document that we do not plan to
 deprecate git-checkout
Message-ID: <Zlpe0lOjR45gXYXI@teonanacatl.net>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717141598.git.ps@pks.im>
 <40594bda5c8050c2a863df8c9f6f92cd98ea8484.1717141598.git.ps@pks.im>
 <xmqqcyp1gbej.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcyp1gbej.fsf@gitster.g>
X-Pobox-Relay-ID:
 82F6418E-1FA6-11EF-B42D-B84BEB2EC81B-09356542!pb-smtp1.pobox.com

Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> The git-checkout(1) command is seen by many as hard to understand
>> because it connects two somewhat unrelated features: switching between
>> branches and restoring worktree files from arbitrary revisions. In 2019,
>> we thus implemented two new commands git-switch(1) and git-restore(1) to
>> split out these separate concerns into standalone functions.
>>
>> This "replacement" of git-checkout(1) has repeatedly triggered concerns
>> for our userbase that git-checkout(1) will eventually go away. This is
>> not the case though: the use of that command is still widespread, and it
>> is not expected that this will change anytime soon.
>>
>> Document that neither of these commands will not go away anytime soon.
> 
> "neither" -> "none"?  It is accepted to use neither to pick among
> three things these days, but the latter is clearer.

I think 'will not' should lose the 'not' as well:

    Document that neither|none of these commands will go
    away anytime soon.

Alternately, the neither/none question could be resolved by
dropping it entirely:

    Document that these commands will not go away anytime
    soon.

I'm not sure that's better; it leaves ambiguity about what
"these commands" includes.

Maybe:

    Document that all three commands will remain for the
    foreseeable future.

But after writing all that, I only just noticed this is in
the commit message.  And while that's important, the more
important content of the change itself uses clear language
to say all three commands will stay. :)

-- 
Todd
