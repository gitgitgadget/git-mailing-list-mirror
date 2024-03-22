Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEC443AAB
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118268; cv=none; b=P3Omar0detIqk969bpgvXbszMSBIpB4oVL8BryCjfb+N2atV9pHofEIpdO1QJ/or3gf7zczDI9lYed1zh8ES1IxhMsJyauj6Gu6oYhHWzroeCy94yULcENukpT0cZPD8WRTn4ZiIPp27InZCCH7U98C7Mc+znBlergtNs2gvRM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118268; c=relaxed/simple;
	bh=yqKWvJ7LqCNcTvMrbO5R00lcaqjmGwTKqCfIF0aOmW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nPeUvp0afq7iCCLoZmsQK/00+MaWmKp3b6Q9Q/ZHBttbJBcRqUfwgOA3dRCyACJFlGlEghAT/n/mSikMjAdfi0Cn79SBOzdGTHYWjBY9rlh5lbQCKDkFH9TeTM4H7FozuECaQOznqX59Y2vjTs2gaMFN5RHNx4ia8e1t+0/DrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Uc/TN3sb; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uc/TN3sb"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 56D2A1F3C45;
	Fri, 22 Mar 2024 10:37:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yqKWvJ7LqCNcTvMrbO5R00lcaqjmGwTKqCfIF0
	aOmW4=; b=Uc/TN3sbeqWaUjdEpYQpaYIEN//kXauZf68Ch/lugwh5pAQlkuYMJ3
	yC4yDQZM539Bm+BmH04E5ApQZdy82CYlcBFo5pvinTzZawlJ6QkpMGPTa3QkGl6N
	9mivmgp+q3kfzVEFW0RDOKQvBffTxScD5rWzTSv0Tc5A+rvnajNqg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C4D11F3C44;
	Fri, 22 Mar 2024 10:37:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A57011F3C43;
	Fri, 22 Mar 2024 10:37:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 0/3] t7800: fix quoting of looped test bodies
In-Reply-To: <cover.1711074118.git.ps@pks.im> (Patrick Steinhardt's message of
	"Fri, 22 Mar 2024 03:23:32 +0100")
References: <cover.1711028473.git.ps@pks.im> <cover.1711074118.git.ps@pks.im>
Date: Fri, 22 Mar 2024 07:37:43 -0700
Message-ID: <xmqqmsqq49jc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BEDCE560-E859-11EE-8E3C-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second version of my patch series that aims to address some
> issues with looping around `test_expect_success` in t7800.

Looking good.  Thanks.  Will queue.

Let's mark it for 'next' already ;-)

>
> Changes compared to v1:
>
>     - Fixed indentation of a paragraph in "t/README".
>
>     - Added a clarification why one wants to use single quotes to
>       "t/README".
>
> Thanks!
>
> Patrick
>
> Patrick Steinhardt (3):
>   t7800: improve test descriptions with empty arguments
>   t7800: use single quotes for test bodies
>   t/README: document how to loop around test cases
>
>  t/README            | 20 ++++++++++++++++++++
>  t/t7800-difftool.sh | 40 ++++++++++++++++++++--------------------
>  2 files changed, 40 insertions(+), 20 deletions(-)
>
> Range-diff against v1:
> 1:  fd37c29319 = 1:  fd37c29319 t7800: improve test descriptions with empty arguments
> 2:  a4ca974397 = 2:  a4ca974397 t7800: use single quotes for test bodies
> 3:  326fb79650 ! 3:  f83b710208 t/README: document how to loop around test cases
>     @@ t/README: The "do's:"
>      +		'
>      +	done
>      +
>     -+  Note that while the test title uses double quotes ("), the test body
>     -+  should continue to use single quotes ('). The loop variable will be
>     -+  accessible regardless of the single quotes as the test body is passed
>     -+  to `eval`.
>     ++   Note that while the test title uses double quotes ("), the test body
>     ++   should continue to use single quotes (') to avoid breakage in case the
>     ++   values contain e.g. quoting characters. The loop variable will be
>     ++   accessible regardless of the single quotes as the test body is passed
>     ++   to `eval`.
>      +
>       
>       And here are the "don'ts:"
