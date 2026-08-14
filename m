Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5F355057
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727824; cv=none; b=PcdCb3pjYz/F5TB63HehgXds7wBXAc5GMgECGUMNSdnRuu51NzXoDuII2ojxOM8NF7yacW42s7WVEEiEHGIvFmx5Dmk+Six+EHIe1npqSWw7WqiHTq3W2+G0OofXup1AmEJvWFGgQ1wFaQmzsYsOZOQwYGZTghkjherJVav+htA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727824; c=relaxed/simple;
	bh=Na4bFdYS+jwPHfPZZAQpCYP2/l6VTz3agv4wyk2carQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vcf/Cw46j63QOGkhJbkpT5Db1rliZTMx6ba/So/0z05dr0kTwXrHbmULSV6V2fgqaHsdPUAZb6gD8JsD+C1SF4jkRl9ypgb+OxQvIjJJL+aiez5BHgbnaEA7O7fRZnbw8rRA7gCurATt8xsJD4K98LwrGj2ZGbFllXDrSLemAxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RbMg9HTn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FICntjpx; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RbMg9HTn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FICntjpx"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 91EA714000B4;
	Fri, 14 Aug 2026 13:17:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 14 Aug 2026 13:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786727822;
	 x=1786814222; bh=UPmLsu7roBZDPGuUlsC6iKFBmthbAQCX7IOtW1HAwa4=; b=
	RbMg9HTn6OUGdPEO5/FICyZE47Hsu+VRdZirz/E3Qzw09JcgavIVwDEdtJTUJCTN
	vzHKbcC9eb0+r0GFpZGhxL9SfY/MedCemjlsf82ok9a+6wphVG9g7XbIFt6jtKTy
	XSG6tYhXGptbmJmtCNaTpcAqCGaBdxxytCH6ppwY0PT8Gz4fMRdZrmpqMVLk42JB
	10r1SFoyG+fu6HxYyTvutQ7MU+XNraQeomOwWUa7Rq7R0djgVW0v1ppRaZNpwqeC
	6G+HSQ1KM2dqFT7Yx4aUKHlhLzOLEmtSRqhLPsYMJPYW3yW/mQlU7wVaIY3aZWrb
	H5B6qRbQ0qIklyaxlMsdAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786727822; x=
	1786814222; bh=UPmLsu7roBZDPGuUlsC6iKFBmthbAQCX7IOtW1HAwa4=; b=F
	ICntjpxyCLXum1KYSYi/DYW5Pnf+ygiuYyLJhL9gsANz4T7xrmTfTHFqDER7yQ0/
	ugpsM2qkF+gGZvHZM2aL7Y/471AhwZVE1h5dKNeMcTjzIuPp11qNK/SN8Mixp5bW
	qbgDAM1v/UiMgJ9zXvoZpum+S7T4jXw1KxsjKKHdiqrfF6bbbafC9kbwO1IQpvmF
	L/rDzRHDIVn7Gmwu3pyc04jnKR+0OiXtnJIy71joj3/se1UF6WN5qy0Z/4UYMkL1
	xI34qZ4u6kdN7Q+RRZ/1zjKoChiaiuM52mU3zurWNCvKkmT8ZtxIckG6j9mq8wJp
	551bBDU+PQU4XulEd9kLg==
X-ME-Sender: <xms:jk1_aoBmUUBECA2GRbu8qqP7scrcS1yZZE9Tf6FPPS-zlsNapDin6Q>
    <xme:jk1_atGEczUAHeE4f6b1c4tw9oATym3YLaRpf5jHQjaUvfBgV44GgEJ6qIw3C9nqf
    MkoMU_aEODmqsiH6m2D_NFgNkQKs9bcU2Nvcxz1Uihe2QvjBw>
X-ME-Received: <xmr:jk1_avMnTcGkEivIjOYJGTaSk29zippjbAwgQWUM23_uyaASe8C7Mo8hNd0bkHieZ0qEGzcFQXhUQxqItz6bGFy3M56XFBtoQw>
X-ME-Proxy-Cause: dmFkZTEjfLt1AmVDGrLRZW5ybjBvVDYnfPBILTqB39922a+l7wHurF01p3OJp+WbtA6tRg
    /HBsCg5YiCFRwnNkEn19P5Bd8HjUWKicAvtx4D8q+tTZtHeUIPqvzTqH7i+JI9EVE+Je7C
    R7cVngFOWspU3pc5ZMmxA6JCAb5+ALOvg0/MPqONeISk7n/M/VRo6BGeBlC37xsVPKM71K
    j7FVM4GDRRM7q4n8xA45Y3ULygOx0FXXT3a3DsU1tr58SeZS66SH9dWsNWPj7p4V6OWDEX
    Fgi5YqZP9EVoNBZ3tU02plr+behNW/fLQQXua4PDrEdk6UGdHwDAt1r+hclCwWSxbNclrI
    Ge5VhgmtepFWSm0NkxlNoM3CGaqGMw+73UhnpyrunoT8BYqWjNYYN1thtWQm4HUM/x6OGz
    /ZIlPdQqVj9ku5wUaV+d0BUW45vFRre6BHJEby0YggzSeWpGcp6Ks+iRpa6gWUnP2jys8p
    FZwuzfiY+Gj979S8KsltIcZ+FaWZvxbuipCMmbUaOSQAk/zLwR2RARq8zI9ZKx2H9KNSBQ
    Mp5qF85TggDhYrLDKItkD7cLhl1cEPpyN3barFpzE/uFgSwj3TMkU4ObVmdubF1SiGvbZC
    ohPkatZ3kkqjWbGVojM18r/7ml8ZG2vehdrAbYu0pFjFTC7InlqMxKKeVtiw
X-ME-Proxy: <xmx:jk1_au4JTzuO9ggBzWN4pMshKWA_RSkS49h0Qd3o_2B0GVB9x8mzBA>
    <xmx:jk1_aig-e1CucxckcHLQIGGo9ov9deGCtRZWr5M3pmMl5Re81MTczw>
    <xmx:jk1_ajcd0wxbtNl16u0WBobD7fGffmziXSTd-R9KlwOoRQYsVXafww>
    <xmx:jk1_aqzW3Ys4d0TcFy29iy-9hKFH6tNS124yNweC8Zbh5LT6ELU3wQ>
    <xmx:jk1_as6swhPoKpXydX0RKTkf3bPZpW1A3ELXeuvlggb-c-DCxGJE9ZvV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 13:17:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>,
  git@vger.kernel.org,  siddharthasthana31@gmail.com,  ttaylorr@openai.com,
  ps@pks.im,  johannes.schindelin@gmx.de,  l.s.r@web.de
Subject: Re: [GSoC PATCH v5 0/6] repack: add --drop-filtered to reclaim
 space in partial clones
In-Reply-To: <CAP8UFD1esJ0fk3xPXvAmQhMK_5wrpGKZJg9YaFV0-qUAC7bf5g@mail.gmail.com>
	(Christian Couder's message of "Fri, 14 Aug 2026 19:12:39 +0200")
References: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
	<20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
	<CAP8UFD1esJ0fk3xPXvAmQhMK_5wrpGKZJg9YaFV0-qUAC7bf5g@mail.gmail.com>
Date: Fri, 14 Aug 2026 10:17:00 -0700
Message-ID: <xmqqqzk0oc4z.fsf@gitster.g>
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

> On Thu, Aug 13, 2026 at 10:08 PM Siddharth Shrimali
> <r.siddharth.shrimali@gmail.com> wrote:
>
>> Changes since v4:
>>   * list-objects-filter: fixed the object-size local from "unsigned
>>     long" to "size_t" to match object_info.sizep - caught by Junio
>>   * list-objects-filter: made the filter options parameter const and
>>     dropped the now-unnecessary cast at the call site - caught by Christian
>>   * repack-filtered: comment fixes
>>   * squashed the documentation into the patches it describes: the option
>>     description now lands with "actually drop filtered promisor blobs"
>>     and the guards paragraph with "add guards for --drop-filtered",
>>     dropping the separate documentation patch, so the series is now 6
>>     patches - Suggested by Christian
>>   * improved the "operation in progress" error message to name the
>>     operations (merge, rebase, am, cherry-pick, revert, or bisect)
>>   * swept test comments to be proper sentences and fixed tab or space
>>     indentation
>
> Thanks. This version looks good to me.

Thanks, both.  Shall I mark the topic for 'next', then?
