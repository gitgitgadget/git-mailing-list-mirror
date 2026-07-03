Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FD35B125
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111521; cv=none; b=F0GvZ66kEnsw/v2OB4DmAJ7Wc80eamTgwVDIN8HqC8KjFJ+wylBBbZ0Pj0bnxCzB5v2xLSW7EaWkjl5Vg8t+btNLdX1XP9rThAVRQHT226KDfWA+z7FTDZU1N2jTHrFFDesSnXifO5ZUEUJf1Nybyek8wTufLLGtqV6kyBcUi2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111521; c=relaxed/simple;
	bh=hJy4mWEU7UjfZodQjABoDzbDfwKUjjKPYADMNohgw9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eEW0YVYp4p8IGbcpSNbEbPkZjmvAj9LsnLM5TnctpwUEWB2HWx5PC5TSlgyxvL5eWOAREd+Di1Ac5l8Ba8rMhgPsdjTMzsMO6wiyXPVS+46kb7nxhkaiUAmF/vYwIREO+zXitIPtpMyPfO9u5WUZ9BiCvnK6EfrrZt4O+waCLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rzGjy4RC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N88CsDr6; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rzGjy4RC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N88CsDr6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 063D47A00C2;
	Fri,  3 Jul 2026 16:45:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 03 Jul 2026 16:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783111516; x=1783197916; bh=Gf9ZpY+p70
	QNnW+zLaTEiSoyrYFjeatSpFt7Ru8qZKw=; b=rzGjy4RClrh1M8/m/Av810W1vE
	92WU9dnIMaUlcsJCdKVnuZIIsT6NQBw8Nso7Isodo+Apj7iNvJmK9zxuCN+IpQuK
	AOqC69E7xP2bpoJS+r7xiLc6sxQ4P+Ib7u3yJg5zY54gfC7IhsBkeYRc8xyRM5W9
	gnxd2tpWZ/8iTGqtvvz0RPUpP8E9/AyJ53f7RxUbOJLPsLm68vg63xs8Un0Bdk/m
	7QEdlJ+eT/fo3EmUrCmTEYw5Ykr1eH+kXqntKG6Utr1z5ekMcRhn8depTXVnFFUI
	WR9/t/ldyggg0++57AMRLdSnR3bAP72oAT8m0ISwIi0w4Ga3y+FULLx4Hpug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783111516; x=1783197916; bh=Gf9ZpY+p70QNnW+zLaTEiSoyrYFjeatSpFt
	7Ru8qZKw=; b=N88CsDr6l8H6VK17DhVt5lh1myM8p33H3kiE8in7sWEq2V8DC37
	u1wAllq89/elm+kjOT5l0RL4rXftmHBvBjY5B+gvNDHNf3XcHdv19IBiXpRKgN8I
	Aj7Y+LFB19kA/H2mKZzBgV5o9lBbgwHN9nyR94Lm7396i/6m/YvyhkyslmiPRn89
	v2wwK39pTtYx41QBjrguRoIfccrlLctcClrhc36zvdwCv1cTSm6DGVqJ/G8VfrKY
	7Dg/h1q7rA5LrA0qPm5nZAIjxQ9Qc8Ca5o+fSrmuXACHUtdc9FuCkC+9ZUwH7HBT
	Ko3+Y8xTpL/Q6G2kifWahtQycYeNmCHLiwg==
X-ME-Sender: <xms:XB9IailrAqACDlBO-Q1-146gkjr4Ct2QYtmmfBdSo9EXbhqO9Ad3RQ>
    <xme:XB9IagtdR8Ax6rBgxHen8bB9GqW0ONlluxV8B6sTQWpBGCizBoUsrWyMunCU3eW0_
    K5bSAOm54yP79n5pwjWbS5povhnfSfUZiD-_Mv3SiAvMtzJ30-y>
X-ME-Received: <xmr:XB9Iao8SMe_vpHmV55UbDSSqD7Md5g8SqIredczrai7WbgOffZUWvmWUtubSQjXwHAR4Kufaroh0EIuM7ZCIbcYmoa1tUPbrhnGSkio>
X-ME-Proxy-Cause: dmFkZTEYyqbFZgRnvw6donyQixoicP2C7ktRHCggA3CUykS1dSItsz1jNpOz/N/Ds+UGxE
    Ra3Dm5L3ROdYulDNYfr7Px+D4iZlHFBlBwqbXBWBzQRmXVK5eM4iHqrSATEiipUbtwb8gp
    Y+JTWTVfV3czz3yurh6lHeCTayqRLG1TS0J2JqgDTahvRYKXoVNLYA1JsGvMUF6iFZk7+o
    7q7v9JL2kdTU4DYYb6Gf+yUuKdmZKzwItr9FwWYy1TEAO/xW8tJwFHRPXLbdXfblaahE0t
    T7RNFeZ1DiZ1WeXT/6I1KuotCJ9WI18kGOkGefyuFN+1EOiOqn7fCKQfEZnsX3rgbFCMkB
    hxP5Ddv74CU4FGmqaANc4G/wT759+hzm4KNpF5AR3FRMfJR/QpBoggUkPTfY/qEyo35cCd
    yqNdCDIUtEUs0KO7QHEsy1uwjDi6ch+y6XUz7BHB3Aecxyzv2K7tEZgvzBt0UOUjEte5u6
    BMQOUAR8esBA1wE7T6KKP0MoZzXZSgrF03GES3Q26OIPCgJMQv82OoclZvKyyIV7NCPwd3
    6akqCBENKYkhy2cmq6F5hnwKYRH/BneluLObYEeAkdjU9UbQhhv7rgWsCpR/TKYdw2TLX4
    8105LJAv74eRZnUlH+LkxfeLozIVqrg+nmf4q4wE6t3a2uf4YHSqLjkF646A
X-ME-Proxy: <xmx:XB9IaiOLBpK0CiLuMx-c0QdVZFpnwW8vAwYQ4VZLtK6hQuujtbrDhA>
    <xmx:XB9IauFsJOEh51ZODLFsUH5xD5zgUCuZoMM_TDeTRx-Rde_K58QExg>
    <xmx:XB9IaoTbvBemJGBlCTPSOm_uvRGeahRzAIHlAZst1U96x7-jU9YLbQ>
    <xmx:XB9IajtXi_R9L_88GV-T8vjoemRZbxr04GDMqod3n4YxdB0CefphBA>
    <xmx:XB9IakuIWisSwutMeTJLR45I-0A81AqeVOy0FrauXlL5MineVOJUocAk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 16:45:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: fix leak of rev_info in prepare_bases()
In-Reply-To: <akY4u02vdBkVqs7m@pks.im> (Patrick Steinhardt's message of "Thu,
	2 Jul 2026 12:08:59 +0200")
References: <20260630063944.GA3733670@coredump.intra.peff.net>
	<20260630064301.GB3733961@coredump.intra.peff.net>
	<akOZy-BygZS8fqPM@pks.im>
	<20260701081358.GB813310@coredump.intra.peff.net>
	<akTS_rPV7JaGHKRq@pks.im>
	<20260701084733.GA814472@coredump.intra.peff.net>
	<akTXYoY7mSQUM33P@pks.im>
	<20260702085821.GC481298@coredump.intra.peff.net>
	<akY4u02vdBkVqs7m@pks.im>
Date: Fri, 03 Jul 2026 13:45:15 -0700
Message-ID: <xmqqjyrbhkf8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Likewise I find the dual clang/gcc jobs to be overkill. Compiling with
>> both is useful, as they have different warnings. But have we ever seen a
>> case where running the tests showed a different result with different
>> compilers?
>
> Not that I'd know of. As you say, I think it makes sense to use
> different compilers in general. But I don't really think we need to have
> this as a full "compiler x tests" matrix.

Very true.  Different configurations with TEST-vars are great
combination to test, but we are not in the business of hunting bugs
in clang/gcc so we long as they compile (instead of warning "hey,
that construct gives you undefined behaviour"), we shouldn't have to
run the test suite with the same configuration for both.

> I'm certainly on board with reducing the test matrix a bit. I'm sure
> that we can have a cleverer selection of jobs where we both have the
> same test coverage as we have right now while running less jobs overall.

Yeah, and if we can spend the saved cycles for better coverage, that
would be grat.

