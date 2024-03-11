Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE98C52F72
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178159; cv=none; b=Hcmqa/FNGikN95pLleK8mhofCx4WVDdU6xRh/QWNY4FHTDiO2u/9wwwM7ymprySciSnGH/jhEjbH/m3xYoA/emvewaRKh8Mr3KmgT43ZbnLk1QhWzCHhVa9K9gjmzXSggvR4UqERGhSZLRmjGfDHUt5Rs0naI2Y5Fo6HXkT8uNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178159; c=relaxed/simple;
	bh=jQ/JGgHjvfJqaEIKJppUZRbzl/yXsFM7rf+qS09Tmfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DWWD93y17L0U0aUfTg3SJVFdnFZazqcG2cdQqNnGsoaRSWYE71Qxh7AllqPpBohMB9WlhoK9NKk0nk5m9c3bmEbBrJ7DqrycQQgaXux2GOAoYINkKunl9TBJe8Wppdz3G6hX7v6JLOSvos4yO9wq4fHcQ1+r0Ayd6lPUYn8NiHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qVXJIFdS; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qVXJIFdS"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FE2025F90;
	Mon, 11 Mar 2024 13:29:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jQ/JGgHjvfJqaEIKJppUZRbzl/yXsFM7rf+qS0
	9Tmfg=; b=qVXJIFdSZuv2BlHCMgvUfMWQBsUy/eU8nVdsLd67e7Jmn2drmZyj0S
	JdKpmbeOt/EYYvr73TaPFzQG40xBT83NQZZrgbZAGZwf036JobJZZwkYGm+BGDb4
	yuaCCuhwCcL70IoKIj+Mtheetol55RYTMpqn3kXQ5nMERDiIJpU/U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 08EA125F8F;
	Mon, 11 Mar 2024 13:29:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A2EBF25F8D;
	Mon, 11 Mar 2024 13:29:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  rsbecker@nexbridge.com,  Ralph Seichter
 <github@seichter.de>
Subject: Re: [PATCH v2] config: add --comment option to add a comment
In-Reply-To: <5eff951e815e2fdab3834c4aa4160ed8@manjaro.org> (Dragan Simic's
	message of "Mon, 11 Mar 2024 17:17:13 +0100")
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
	<pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
	<xmqqy1apudvv.fsf@gitster.g>
	<5eff951e815e2fdab3834c4aa4160ed8@manjaro.org>
Date: Mon, 11 Mar 2024 10:29:11 -0700
Message-ID: <xmqqr0ggsmmw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E108F272-DFCC-11EE-BCFB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> On 2024-03-11 13:55, Junio C Hamano wrote:
>> "Ralph Seichter via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> From: Ralph Seichter <github@seichter.de>
>>> Introduce the ability to append comments to modifications
>>> made using git-config. Example usage:
>>>   git config --comment "changed via script" \
>>>     --add safe.directory /home/alice/repo.git
>>> based on the proposed patch, the output produced is:
>>>   [safe]
>>>     directory = /home/alice/repo.git #changed via script
>> For readability, you probably would want to have a SP before the
>> given string, i.e.,
>> 	variable = "value" # message comes here
>
> Let me interject...  Perhaps also a tab character before the "#
> comment",
> instead of a space character.  That would result in even better
> readability.

Depends on your screen width ;-)

If you were trying to tell me that SP or no SP is merely a personal
preference with the comment, I think you succeeded in doing so.

Thanks.
