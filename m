Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDDB23BD17
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786427765; cv=none; b=D+bb3ifahmftwtWcAXJkmseRlT9qlKCVlupa4imAwZ54FpgXiQgY8kQ3dsta37ycauJoLyWEe0mq9FOYQIDVMDsHn8RDJFIa9/g5/WquO68059fgghUyHgKCvCQ4kwuPHfyMLBRZ9QLoS1KlAGbgTHh0CkCGY+Hfih1mRjLXJ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786427765; c=relaxed/simple;
	bh=BkI48t/+9kGUhXq/JOTi0cP+TiFjcF3ZTjCQiMtXbIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IX8e499PBpYnyS/pkn44PSdIVd1HMr+gyniCsE8z5d5lqHpbAR4pgcwZ77y3ZU8MbZ2UcuEwbJiHU4xQakMZZdsmjpX/KZAjX7ZziZEn5SmfVegQL6acE1XXLD+9ZnugzzAPm8X3iRnFucZ7VjmQZeUX5yn0XtpL3XTTo4fbyIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KIWxCMCT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hyh/2WxD; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KIWxCMCT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hyh/2WxD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 22669EC01E0;
	Tue, 11 Aug 2026 01:56:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 11 Aug 2026 01:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786427762;
	 x=1786514162; bh=tii56UMyLnjBu1FE0DCfhnFC21ky88iTejFLWmkPlAQ=; b=
	KIWxCMCTG463rv4jZzsmP6j1MDPIc55rq0paw8s8UBOIUJR5gEH1aGapNoIhTZH+
	n1o7661noRB1G2cq8B2MHorxFHzFvXGu45pCLYnZZ/ecv/GLxgzaHMD0Ck4g7Z8a
	SMe4PUfgVDDKxJRQ1j3S1Mza4uzoqfuxVzaGzhfEb7DN3hC1VegfgAI+mlwxVN/R
	WFPSryDHoEbH5KvVFb6zwTCdAC9YCs/wC4BHOeQhgwmeiA3MaNyVGBc6gHetEKxu
	lHmIXumqN0+Du6J5KJoMQlolT5QHfsudAKrIseEepCs4cntX7xJhFUvKDsFig5Mx
	NfXmOkKMtVx38rYrY1whEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786427762; x=
	1786514162; bh=tii56UMyLnjBu1FE0DCfhnFC21ky88iTejFLWmkPlAQ=; b=h
	yh/2WxD//1moAz6In/8HwaxKqZr3zhRh43EaQLxiZLp4tCLY34WWE0jHugWpPmz5
	ykYNWHazzEamATE1ied0JJShVR7/2KwHfKiPugdQfTOQIBPSz8t+DumgKdx/uOer
	A06+UymSaHPDF5Zrm21HrO6gCjQjQVuzNuy5jxop0sgEswGWWARTStr0I4HOFkkB
	8stnCHtBJimLfK8zb7GPf4S/qqFodTsGOW3UcIIS22yo5Wb81h5zJMSL+CnMIv4X
	I2nYzY3K1w0fS7Oj6SpvaGXmXY4dEzF9nxUEIFbaTWF/cYkwOu+uzH3XeeA+e3eq
	W1zKtHwEZnjV5y+ZvbYrg==
X-ME-Sender: <xms:cbl6atSumzh9_ZtIlX4kB1SYMi1JB_zu3wjJO47a4RQ24n6n3lLpGg>
    <xme:cbl6al3jNIu03Fz7ABm9TAsFMv5L7S5gX0JYsG1dW9sVhQx37veRAUtHhyXw25iLv
    qKAdNARUTYtvqcCfZIySzG7s5fHLYIpORKWIdLutQ_uO0g5TaiP>
X-ME-Received: <xmr:cbl6apAaE52T4U2x7irIBnzlq7okwR7LwNQkrCLB3_UnLlz9J03TBRtqAPfa8QB34RKZwEQ8ZnETXvpmR1NerFGWpD7J6oQzeQ>
X-ME-Proxy-Cause: dmFkZTFbykZGf50AKw5mdKhNrIvmxL8sj53JpBiaLTdqQtcoQZvK7ipXFuIX1Eww32jnmv
    ogAt0cQDGwUa3J0Wo1NUvToq4Iyv5nt7afx3LK9fPEd+TXdMXQtXZYQJD2n+6Z5BiHyl+M
    ysJtrMJGpIBMkD0GWy28TMgwlHNAKxIJIvJ0czZMn+mhfYN0cUzjdBgr4c/5lJw9I5ZvIR
    lzbqibiUs8Elr2Svef5pctfB79alsz2khlweqiYb9/1wQLSPrxwgyvA95Ty/5KHZwWvfFW
    +21jJtylZRpGWgpaGr2LWNvpHcOUkCwJFyRfrREoRxQToE/u9Y95RjyfTC+Kde0AS7FeMH
    Wgtoms2lWPYJvwFe8DPRd3STSOxJVitTOUQUVchrSExBy5w0fD6DDdW3maewN5tUr37jBH
    mhxPmhu7vzhQ+d7cy/gphRbK+8XR2i98uuamsIzdRk2YLR8FnR+pyXVZ5FUkYxDLTD/2Zd
    UB3aCSfGLg+JBPX7qcY6Z0L1q2LHZK7r1sKD9n/uj9mskEwlVhT3kLyHtXhQA6Apb5pSoc
    Ra0oCYVWrrSlQPteD3l5zs85w6Im/sSuKrUOEeWtJhNGAuWEhvIbZbpLgpWWQ//BqFnW4M
    Bg2gr/gDQCjlLxuk2+4L//TwGw8RKcrhMCrSzVJTmCZbCPuVfS6bdRVjzVDQ
X-ME-Proxy: <xmx:crl6ahjNqNykqT6fQ-NYOvRSQQiYoHfBoC_a5orMxwPhODfQICBfAg>
    <xmx:crl6arNxgaY8shi9vvgETCLURLcfUCA0aBwW6e4pDE_4eMZI3JhCbw>
    <xmx:crl6ah85AB3aoZzoj1lqsU6YE9fXzYG8lVluBYAWnhbCcuBRBkZERQ>
    <xmx:crl6asd8wZkZMTdPqqTuJ0LqL9SpUkTNG8mm5Qw1jWITBwXAgA6p-A>
    <xmx:crl6alUt3-CVX2vXCbW8Y6LIknaNFGYAnyCvTdSSyr33ntBqkApgJ_Ih>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 01:56:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 0/5] Introduce 'uploadpack.lazyFetchTrusted'
In-Reply-To: <CAP8UFD1LxM1s-MJuffhVks6JfBXoMzKii4YU4iQRNzXJZCQkfQ@mail.gmail.com>
	(Christian Couder's message of "Mon, 10 Aug 2026 10:06:21 +0200")
References: <20260710085137.4171240-1-christian.couder@gmail.com>
	<20260807135511.1818458-1-christian.couder@gmail.com>
	<xmqqjyq1eqah.fsf@gitster.g>
	<CAP8UFD1LxM1s-MJuffhVks6JfBXoMzKii4YU4iQRNzXJZCQkfQ@mail.gmail.com>
Date: Mon, 10 Aug 2026 22:55:58 -0700
Message-ID: <xmqq33wl42vl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

>> It turns out the reason has nothing to do with your choice of
>> base.  It is because the series structure is not understood by 'b4'.
>>
>> The cover letter I am responding to is a reply to another series,
>> but the patches in this round are not marked as 'v2'.  This seems
>> to cause 'b4' to grab patches from both series and smash them
>> together, resulting in an inapplicable mess.  It seems you cannot
>> have your cake and eat it, too 😠.
>
> I guess b4 should have, or grow, an option for that, because it's not
> uncommon that someone would post an alternative patch or patch series
> in reply to some patch(es).

There is an option that tells it not to crawl up the parent article
to find siblings, and it would have worked fine in this case, but
then it would prevent us from noticing that a newer iteration
exists.

But it should not be the norm.
