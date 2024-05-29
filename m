Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4387C15991E
	for <git@vger.kernel.org>; Wed, 29 May 2024 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994992; cv=none; b=OGlK/wnHyUh4zjpExnsLIOglFDnSjAUEnr36qM9d4vw+eCXZa8DthqrykbdOjNRdSw33/kSxFwfPYO0rLOwNcByQUs4gYxCALvFd6wTby0730schv1XlbnunN6BgCD8ppY45Ux1GQOU//W2U6vtKgJfOT29ZJv1+DCAmQFHcPeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994992; c=relaxed/simple;
	bh=z4ZXT05IfzxrTgpXPxmIGB/FmcCLklm2LXQ821iObMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cXrlFz/8qj1/UkhHGWtDpC/A4sdTlRmMo0WgQzzstVLn6Q8WcWE5X175mxjQqCVKYz8evTlOHJlTGqzl/P9FX0F5KlzqWbRtv5CviedEgnQS63DXKTqQc56HuICJivlF9qO2NocCEwQlwTyAukS9e55Fd9cjMsMOK/l+hyHnrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Asp9CPKu; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Asp9CPKu"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 214F72296A;
	Wed, 29 May 2024 11:03:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=z4ZXT05IfzxrTgpXPxmIGB/FmcCLklm2LXQ821
	iObMc=; b=Asp9CPKusnY7VeSDB+iDpVEesBX5P94bd2QjT8YHkW89LSsnogzgX/
	8iM72kNaM1PJbYcohT1U2gb+MqIgqanugn0uuysElXhH6FdS/LhKXU53AtCj7dX9
	Owg+V9xaGjrto/22OZ8LaOM45Uqv201xILrh2tWcvOlXfALDb/I/A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 192BB22969;
	Wed, 29 May 2024 11:03:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 64F8322968;
	Wed, 29 May 2024 11:03:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #12; Tue, 28)
In-Reply-To: <twbev5csmtfuwzqqj5otzjs7jgkzewoq2o2cyncqvj522fkoji@5znglrfbw7yw>
	(Ghanshyam Thakkar's message of "Wed, 29 May 2024 14:21:14 +0530")
References: <xmqqle3t36a6.fsf@gitster.g>
	<twbev5csmtfuwzqqj5otzjs7jgkzewoq2o2cyncqvj522fkoji@5znglrfbw7yw>
Date: Wed, 29 May 2024 08:03:06 -0700
Message-ID: <xmqqa5k81x05.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8F2E0012-1DCC-11EF-83D1-25B3960A682E-77302942!pb-smtp2.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> On Tue, 28 May 2024, Junio C Hamano <gitster@pobox.com> wrote:
>> [Cooking]
>> 
>> * gt/t-hash-unit-test (2024-05-27) 2 commits
>>  - t/: migrate helper/test-{sha1, sha256} to unit-tests/t-hash
>>  - strbuf: introduce strbuf_addstrings() to repeatedly add a string
>> 
>>  A pair of test helpers that essentially are unit tests on hash
>>  algorithms have been rewritten using the unit-tests framework.
>> 
>>  Will merge to 'next'?
>>  source: <20240526084345.24138-1-shyamthakkar001@gmail.com>
>
> I've posted a new version to address Patrick's review.
> Link:https://lore.kernel.org/git/20240529080030.64410-1-shyamthakkar001@gmail.com/

It always happens that two people work independently and messages
cross.  It is very much appreciated to explicitly stop me like you
just did.

Thanks.
