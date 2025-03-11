Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E2A262D10
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712849; cv=none; b=n4hvnLE8fGyyFn36Ad4Bi5KLXpGeY32B2lvCoqXrn1LhEiMckxs6gwnvftqlmKJUP9t0JqPM+ILd0rzqB/wsiGrr+N64XymqYSJjV6uC/+thMWeG8mk3ItVnw42dVJoanK34dGKvGUvRdTruIcU1+ILkh5y9js6ZsZiszFICMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712849; c=relaxed/simple;
	bh=Z5y/XJjxXOG7zf8Y+d/yVL/UAdHAaFYViCVK7fXCEyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YO6yh2tKZUn+sNouT7lZq3g7sM3tXIwTmhNAeeBAI6ZPFi9lGWGJmCNcpLweGFj5NudJZN3AX4OGfIcX8Lq1uZeZPJQp4aFXpBqqhz1nxFLS6RM109ZW/F/o9tzV0ZBiR79d/ic9NVNxcEDSXuVQM51JxNF+GEi+dJkcpjUkdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wpPkWe9j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gUFVrYxC; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wpPkWe9j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gUFVrYxC"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5AD8D254017E;
	Tue, 11 Mar 2025 13:07:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 11 Mar 2025 13:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741712847; x=1741799247; bh=F2Rd0mXlgi
	3zGjoUtd20R8jhHRJA0iM8sweCNRAaMy4=; b=wpPkWe9jc58SAYl3oZWGXxOB9E
	QTvNQKDachUSaIi87yfuFhIOFQ2LehWUdVQ9hKXqeGHWP8jRORiAXyldYd8VTowC
	EDuIKTGBA1Tv4W/dmLXUct+pMkOXk4YfWd7TBkmNLufkMwFvc1RIVz945BgLcWJy
	WolGAZOL0I2ieZ10mxtTzKFn8yAhkXkXgEKRJmRC/5BxeSxxkZ/cd1wMzsf6J0u5
	hVbB1f0vist51uZFoiZ1fr4RwCyDchyTQqnyazhdg4uRIsfsYn6zAbCigxaF8xcG
	0QE8Xz13YODXaxBFwE/PcWg64wyk8BzY1zRLvJSAUYYbp2mfRewPnkcLQMjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741712847; x=1741799247; bh=F2Rd0mXlgi3zGjoUtd20R8jhHRJA0iM8swe
	CNRAaMy4=; b=gUFVrYxCCDa8iiXK4mFN9LYh0CD5T0rKWrvvy9yAHWa3TtGdtT0
	7As0UXGAj/zNuyupA1NZblD+fRd3U/4vWgpuWalQqkaEJTVNqUPE0VsidZIqxSfp
	Bv1eqGLbla9avNtEUtz86PQGalwQk83xxjoHGcd/YBDoGdXtaYXB1H2QEPhEzLM/
	cllp3k0mLDg+39hlwGrTOkOY5+e9gWYDCta4oANJbcwFaK1wItN8JU19qVlRQL6H
	qgqf5/odkKXJQ5goGJxY7gRS6I7hKcjLGel7hvPnc3ZLmfK2m9/GghgantcJJieY
	0CWmwEuavh0e0NuXmjZbILeRzJqw4E7XLgQ==
X-ME-Sender: <xms:zm3QZ5g7nbnbom0mxCCraaA35dtzlP5xvKc9Hvr5Roob9B7vp8NuBA>
    <xme:zm3QZ-ALk1Np7_EjX4Ic_nTUVTWe1FXVBzYd4dCTe3npqfjwMViPGGT2HM5fTn-uV
    OSd31vay96qKDr-SQ>
X-ME-Received: <xmr:zm3QZ5GmJ9ymA-W_upHmTPJtHZEObsIz4_WVCDRURVWUUEyndr2Mu2rzwHsoN7-rjvsCpo92I06dRWNCrQK0B8W4qJpnyAiz6vzK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:z23QZ-SdF-1J_Hjv3sa3_s_km-0kqumnRegVGZlPjwb9SGNkNHO0_Q>
    <xmx:z23QZ2zWXK0YBHZqTvbbai_DG1nZ1lT3mBVWS5RwY7d-tgaCUGZBsw>
    <xmx:z23QZ07wog3fhHcuEoWI1tpulGD2rlkofkryF2TciFh4UMzd_DtG1g>
    <xmx:z23QZ7z2y9AWd9zAL0-o4E6d0BkekPitd60Bc2xINjW3rJrjODUNjA>
    <xmx:z23QZ6_RLwhECUJP5ICS2YiY71yj8JIK0WVBX5uPW6n4I1voapLxP68Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 13:07:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v1 1/4] t: introduce WITH_BREAKING_CHANGES prerequisite
In-Reply-To: <Z9AzKoWLeOJ63j_E@pks.im> (Patrick Steinhardt's message of "Tue,
	11 Mar 2025 13:57:14 +0100")
References: <20250310231652.3742490-1-gitster@pobox.com>
	<20250310231652.3742490-2-gitster@pobox.com> <Z9AzKoWLeOJ63j_E@pks.im>
Date: Tue, 11 Mar 2025 10:07:25 -0700
Message-ID: <xmqq4izz4hte.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Mar 10, 2025 at 04:16:49PM -0700, Junio C Hamano wrote:
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 9001ed3a64..12fe82f660 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -1862,6 +1862,11 @@ test_lazy_prereq CURL '
>>  	curl --version
>>  '
>>  
>> +test_lazy_prereq WITH_BREAKING_CHANGES '
>> +	test -n "$WITH_BREAKING_CHANGES"
>> +'
>> +
>> +# DEPRECATED; DO NOT USE THIS IN NEW TESTS
>>  test_lazy_prereq WITHOUT_BREAKING_CHANGES '
>>  	test -z "$WITH_BREAKING_CHANGES"
>>  '
>
> Do we maybe want to state that this can be removed once the next release
> cycle is over?

Perhaps.  As 'seen' is pretty-much closed at this point and there is
nothing in flight that uses WITHOUT_ variant in there, v2 of this
series can just do without it, which may be simpler.

> I find it to be a bit more actionable when stating hard
> dates after which something can be dropped 

True, that is a good strategy for a transition that takes longer
time.
