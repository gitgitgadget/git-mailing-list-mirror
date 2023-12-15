Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D66720B
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d3xO7Q9t"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 52DA91BF17C;
	Fri, 15 Dec 2023 17:06:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tbm0vVv77Cd0jFFpAiwR5JOPRe8d07l9atl2Qz
	zmm1w=; b=d3xO7Q9te2tEaZ4BeoqserudnbEQHn6QobvYiL3o9/HRuJ/pL7azxC
	j2AGDFasTh04MigXNISlYQUe/Xa0r2jvpNSeZJ5GKOmCmNn4pyEpY2K/RlLkafIJ
	w74t4dgpNHLTSKf9pGEpUIWSGBtwlnsiX60BZnwZuEwb43gqrHGzI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B8631BF17B;
	Fri, 15 Dec 2023 17:06:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9FEB1BF17A;
	Fri, 15 Dec 2023 17:06:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/5] git.txt: HEAD is not that special
In-Reply-To: <0c93d426-17c3-434c-bbd0-866c31c23f9d@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 15 Dec 2023 21:57:11 +0000")
References: <20231215203245.3622299-1-gitster@pobox.com>
	<20231215203245.3622299-2-gitster@pobox.com>
	<0c93d426-17c3-434c-bbd0-866c31c23f9d@ramsayjones.plus.com>
Date: Fri, 15 Dec 2023 14:06:22 -0800
Message-ID: <xmqq1qbnktnl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2F5DFBAA-9B96-11EE-93F8-25B3960A682E-77302942!pb-smtp2.pobox.com

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> -may contain the SHA-1 name of an object or the name of another ref.  Refs
>> -with names beginning `ref/head/` contain the SHA-1 name of the most
>> +may contain the SHA-1 name of an object or the name of another ref (the
>> +latter is called a "symbolic ref").
>> +Refs with names beginning `ref/head/` contain the SHA-1 name of the most
>
> Hmm, s:ref/head:refs/heads: right?

Yeah, right, not a new problem with this change, but is indeed a
good thing to catch and correct.  Thanks for a careful review.
