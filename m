Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35381607B4
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383043; cv=none; b=Gtaz+VjzG9LeATNiROaB7CIT6KV/6QJMNEiMjtOVrGZVyKmWeoDiEpwgP7irjoQo9WjmZfXe1ytF6vhrFYQrEbl4VsMPFeKRXZQ4+wCHf+BtHD5VMUIJmxxlZFDT/tquMOd4z3urdbZapdOzHE9s8mTm3fUlYKVE4ERwUHpgx5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383043; c=relaxed/simple;
	bh=PHL9oBhexSWak4InKDc9g87gqMpOuRTCjQQno01OQYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qpog4XlV9blK2zX2JqYL/f3gG5sQy9yNdaH5U6TOPSKTXf5UafnPmUElLqorTkgcsbf4ybmGhQQdTYd4znNvPfSrb+nz+5b6Rgtes3e1YoP6rco+wBE1OoqQ3aZOl47S0NuuqyvxkWI8/FOCsTnzrDFXKoqgtLwM5bPndED9SLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e4NHPgt7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AsO53sbN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e4NHPgt7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AsO53sbN"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EFC95114020E;
	Fri, 11 Apr 2025 10:50:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 11 Apr 2025 10:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744383039; x=1744469439; bh=K+v39XjN0Z
	dcG4Z/M0rQ+jJNfkI6D1CcPjY9erK2Qv4=; b=e4NHPgt7uPbcsYMAGq009Y1Q4a
	2aD6csFxsV5LEKfr0FtMLYtOcHtPJhKRmbBMy2JC6foQAqMuuzqfSo/WzzHOGjBG
	+DNEcDhNAxxFeIpt/e1iUhqgAMra7JmFvH/lcWPSx/wi0qT/hyR2RLyoNGPTfI8A
	6Mc40O6JXWytBHY81KdGvj1oBDh3YYcPCmKTPll3Xr7x2ct3Ejof2qvCv334dZ69
	dyn89ZBx3V47KoLaBHTWPq1BZjellk0nRrkB9OdAcHjOdkX/G76WkTukud7qXisW
	Y4twTEssZzeULmczbn0LJoi/vrzKMmq5rrZI/JSNeigWQnX1iGsMLHKH43LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744383039; x=1744469439; bh=K+v39XjN0ZdcG4Z/M0rQ+jJNfkI6D1CcPjY
	9erK2Qv4=; b=AsO53sbN6LYx+s7/zlGePV1V3t3u0BclVbLkEy2EmIEiL/sIkvc
	CrizN2vqBdFYYCm+LjZH/8cElnAMKRSt5ddv8DIBccF9x4s9XQSvz+nDpBOaOFwX
	TZD2Y8wSJlML/T+1i2IfuMakPjLmpb8i8VPTiZGFgMH3XcZFPWpwkxSGcD/sNLrn
	4SuUuCHvq9rtXvXYOLarpxFHFT7xqAws43ZoyQvQdk3zS6Pkz+7F7TOF4E/HN11Y
	a3Jwo7P+nTLsFyR6GhrZGjsjKynfyOg51Wd5R6C/Xe0Sqm2TrSLNiFAJRUl23+vY
	6xFfGJPsE6L2AXlF+y4wQNPDgNk8vIwSoow==
X-ME-Sender: <xms:Pyz5Zwmye1Z5PMy9HQKp45Rapaz04AzGswmpGriHDqDPb_0p6ucIiA>
    <xme:Pyz5Z_3_4CrKbl46zzM3hQe4KVtndmLx5wEx2Qbzmd022VSnWEbSaDfkR9udLKU7u
    UrcJEPKID4REy9fzA>
X-ME-Received: <xmr:Pyz5Z-qkZsKMVgFtBQ80CyO15lH_ywVPhZ08lVwikIO9OWcoZoOol9X4LOSyQEm77F2PylOtG65ERaUULKMLntrphMFqNlt4ytbF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddvuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Pyz5Z8nfeTYF1ZNN9RnEoDILjYE3mvZniHsr6IZQooIIb0KNhJXgqg>
    <xmx:Pyz5Z-2igoiZtWwas8FbFemimg2OhqthDLM_7coI5JAUXgGxDWxgyg>
    <xmx:Pyz5ZzvpYre2F2oyPdq6K2crh4gSrEpMFpZx6ba7TwJ1IVWIaN61eQ>
    <xmx:Pyz5Z6XhqZHDbkzlZeE1l0G4z3io7S7nyE21HtdtkUPWQ-SVF6roVQ>
    <xmx:Pyz5Z6bJ9JfY29L_34X2tG5UgbSzOvUX1QEdw6tzxSqNKn_6CDFIuclW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 10:50:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] read-cache: check range before dereferencing an
 array element
In-Reply-To: <20250328054953.GA3590654@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 28 Mar 2025 01:49:53 -0400")
References: <pull.1887.git.1743010011.gitgitgadget@gmail.com>
	<pull.1887.v2.git.1743073557.gitgitgadget@gmail.com>
	<73cae30129338cf219a810c3a2a78ef48d5637d0.1743073557.git.gitgitgadget@gmail.com>
	<20250328054953.GA3590654@coredump.intra.peff.net>
Date: Fri, 11 Apr 2025 07:50:37 -0700
Message-ID: <xmqq7c3qoipu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Mar 27, 2025 at 11:05:57AM +0000, Johannes Schindelin via GitGitGadget wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> Before accessing an array element at a given index, we should make sure
>> that the index is within the desired bounds, otherwise it makes little
>> sense to access the array element in the first place.
>> 
>> In this instance, testing whether `ce->name[common]` is the trailing NUL
>> byte is technically different from testing whether `common` is within
>> the bounds of `previous_name`. It is also redundant, as the range-check
>> guarantees that `previous_name->buf[common]` cannot be NUL and therefore
>> the condition `ce->name[common] == previous_name->buf[common]` would not
>> be met if `ce->name[common]` evaluated to NUL.
>> 
>> However, in the interest of reducing the cognitive load to reason about
>> the correctness of this loop (so that I can focus on interesting
>> projects again), I'll simply move the range-check to the beginning of
>> the loop condition and keep the redundant NUL check.
>
> Thanks, I think this explanation works, and the patch looks fine. (I
> didn't dig deeply into patch 1, but I agree with Junio's analysis that
> it is also a false positive).

I think (1) working around a rare false positive to help us use an
otherwise mostly useful tool is a worthy thing to do, and (2) when
we need to make a workaround for a false positive, we should mark a
change to do so as such.  And I agree with you that this step in the
updated form, both the change in the patch and the proposed log
message do their job.

Thanks, both.  Will mark this one for 'next'.

Note that I think [1/2] needs similar updates relative to the
initial iteration, but since these two patches do not depend on each
other, I'll fast track this step without waiting updates to the
other one.

