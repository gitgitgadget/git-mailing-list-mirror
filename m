Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C08613F
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654568; cv=none; b=rBwOFsmdA1XCRkhoSNst5hGx0ciRzmViEgMACepqSKS6UOR00CGLmUkMeBvfofuWQMU2j6lM8qJRYOBNTpmU40HiaNnNl5Qqm447JO1qZXEAso81RB0q7i1GLuQNLv2/kAKyYfISvFpIqX8hLset+7gvChtjbktRfrrUhe0iEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654568; c=relaxed/simple;
	bh=g4qw1e+i9E74a6Y5v3bUNu3FGGybuML+3z2nIWF7uis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vg8hGybBOCx5BtFwzagPy1W5yV+X17+ApMlH/ButUpheD1lh3EPlmxylT8iP88zXGuf/FiuDjp+XntX9pE0y03NEn5QSD5xCYG8Idw1wTpdOa+A1auBZXnASAgFUQFM40/992gTDO5FDpWPr8CwvOf2XGadi+xTlRdI1Me+WA9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SDbGyRKP; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SDbGyRKP"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EB7EF1CCB0B;
	Tue,  5 Mar 2024 11:02:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=g4qw1e+i9E74a6Y5v3bUNu3FGGybuML+3z2nIW
	F7uis=; b=SDbGyRKPdaQG3zPQegmtokeFbEl6WH5MAa+Nq5SD9TJaLotI3rmCb0
	oTFdZ3dN5qZ34gbZaQ1u4pWHCQnwWAqxdptit5sfLn2tTYxfkt+sMzDktLpwKsVN
	mErbzhzC1k9YqkjbmkSTs7CLSvz3KqHHwgbgAq/yKgjSpMTL+4ckU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E21521CCB0A;
	Tue,  5 Mar 2024 11:02:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C4781CCB07;
	Tue,  5 Mar 2024 11:02:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/5] t3200: improve test style
In-Reply-To: <166d2baa-933c-44f8-b6fb-94c8bce63a86@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 05 Mar 2024 11:27:48 +0100")
References: <4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name>
	<cover.1709590037.git.code@khaugsbakk.name>
	<e6a2628ce57668aa17101e73edaead0ef34d8a8c.1709590037.git.code@khaugsbakk.name>
	<xmqqplw9lbav.fsf@gitster.g>
	<166d2baa-933c-44f8-b6fb-94c8bce63a86@app.fastmail.com>
Date: Tue, 05 Mar 2024 08:02:43 -0800
Message-ID: <xmqqfrx4650c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CD6B84C2-DB09-11EE-BF77-25B3960A682E-77302942!pb-smtp2.pobox.com

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

>>> -mv .git/config .git/config-saved
>>> -
>>>  test_expect_success DEFAULT_REPO_FORMAT 'git branch -m q q2 without config should succeed' '
>>> +	test_when_finished mv .git/config-saved .git/config &&
>>> +	mv .git/config .git/config-saved &&
>>>  	git branch -m q q2 &&
>>>  	git branch -m q2 q
>>>  '
>>>
>>> -mv .git/config-saved .git/config
>>
>> The above is a truly valuable clean-up.
>>
>> But I am not really sure if the paritcular condition is worth
>> testing in the first place these days.  No configuration file means
>> we cannot even read the repository format version, and working under
>> such a condition is quite a bad promise that we would rather not to
>> having to keep.  But that is an entirely different topic from what
>> this patch is doing.
>
> Okay. I could undo this change and remove the test in its own commit?

No, please keep it.

I think removing it is totally outside the scope of this series.  We
do preliminary clean-up in various areas, so that the last step can
do the advise thing for "git branch".  In the context of the series,
removing this test does not fit anywhere.  It is not a clean-up like
any other preliminary steps.

Thanks.
