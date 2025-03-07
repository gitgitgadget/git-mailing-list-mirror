Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C2B21C166
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356938; cv=none; b=t+BW5x/1zBcZ8LYv6Q7F7g8ico4uUJY+kdpMPB0NUNVGa7Ze8ql/Cs+HbUMzjXRka+VaoYvxfLnPV+Ans9IYtSSiQhj3OXMvSIO6CqjUqzy4meJUOl8E/02XlNMarHiFB/xEeyUavWIU8UvXzLuA/AKr9mwoKhxl1C5pYVEh0ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356938; c=relaxed/simple;
	bh=Qk28Pbs8szpRTKVtUPf/8JBqLuJFVzWpcYIFSFkm33g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oafg7O8ecW9/6RSukifitjD8jSXrj0sr/xJfiV99sRxV3FS9b958qc4zrRGKfV4hQyefllt44dM48LI8rVVldDKyou+ZtZ4E53o3mN1maPZr+PWUNGYCtfKQuLsKNwodz+3ei/TEu8O02+VxS9SL3gJss9/YkgrnatY4d2/dAjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rhVkd/WB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WnGawgx4; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rhVkd/WB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WnGawgx4"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E6BE13826E3;
	Fri,  7 Mar 2025 09:15:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 07 Mar 2025 09:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741356934; x=1741443334; bh=+Tj+t4d0X6
	vf1ihV8pDSYdAESRIO3nh71BFimi+ftqU=; b=rhVkd/WBttJE8jaLBv6B6J4hq+
	cYheDtSlLFjxnAWiIOPVvFwJlr7QaaE4yUEGoibm+u3JDpqyybed5HfAmZQs9Jf4
	ChG6YxgaKPiYYxrV1dm3EkshfEZzZMA95hYsvCSOOdPOmwrN6NwZHE/AHw2KmdOk
	9CqhO9uAXMoWRFwpArGVD0V7KEkvT9goFT9OhQySaCwwbj9DVWHx+o5mGnwVb3XT
	7//TFzzLTvQnE6FBRSyt7Pf6da3sX1exEv+bCOJavOQN1daxxpBiYdXlu9cVgoFT
	xFqyg/4i/wrkcN6hdKEss9W85GrbpxVbzx3+0/JuEjvLgc2WWB+yTKiECKkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741356934; x=1741443334; bh=+Tj+t4d0X6vf1ihV8pDSYdAESRIO3nh71BF
	imi+ftqU=; b=WnGawgx4GV3rMlPIIn9xU/fgxIUpz8s9TsNNUwyxQ26T0LCj8R+
	hC2p04KiNllWA32Y4dXFwyH6uIR39PbMmL4cRtTzN3rrcMZwovc/oTMN/svYa2jj
	CrTGWLHb086x1DkFq8tTQ85FfYGZEGm7/b4fvPIwFhwv+N2R6Ndw599RNiFvlJ/C
	8zJedIjpEzAdz1N84eWY/n/gKGX7edgSF5V2i/YL2Xx9bjb2fQW0gDqBehBrN2rj
	+VYsIoLgpWEd1MXyaitlem9FS22nqp0bZIVkXMKvtrNW+VaCPsQeDawWuZ5PEzq9
	vYJMWHTgHhfu0O63KzuJd1nioYINc4eGeBg==
X-ME-Sender: <xms:hf_KZ7kKYEUqqFNRyLLe8CDUqJ_XJQNgc0vqXkkQnXSq1RMtDNllfw>
    <xme:hf_KZ-3iCGzoYqMXatz4NGMmAliCd9GaWM2tZZZBOcdio68SN76HxNsxbNovVKs_L
    _aYJ3yjyzbA_T44GQ>
X-ME-Received: <xmr:hf_KZxrlhav0gXsadRPjLLrbzEVzJloHIcqHlmc4Ej-bTq-zyUmdyTDB4Rx8bwFClXcsueEQT6qxGMZsGVJtQ_5RdWygYoRJUdcf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdp
    rhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hv_KZzlUs1j9YcAVzzW3mggLe-U3UdGO76I53Z9ldpMItc9QTJ43Og>
    <xmx:hv_KZ53W1TB1DAsCEQBtN2qNZT21fKm2LZlg-VIlZwZd9dMvX2xOvQ>
    <xmx:hv_KZysLgGnB7nNRZxH3zTDJS9JurqX7if8skZDsVbX99gqC1NuLRg>
    <xmx:hv_KZ9X0zv0o9sd1Zs02TAjB90mgfhuI0BE7kFv3X5fdPULUVz-DXg>
    <xmx:hv_KZzz1GZOJe2bNexSW2zIUtGZNA6G9c6q8QRKogeyt-6MFwa0Uianj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 09:15:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  johncai86@gmail.com,
  me@ttaylorr.com,  ps@pks.im,  shejialuo@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 8/8] builtin/checkout-index: stop using `the_repository`
In-Reply-To: <CAPSxiM_fLNUvg86TtCHZTbsE_VnhKdMiDa3pfLPsLa3ThZfxmw@mail.gmail.com>
	(Usman Akinyemi's message of "Fri, 7 Mar 2025 06:45:29 +0530")
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
	<20250306143629.1267358-1-usmanakinyemi202@gmail.com>
	<20250306143629.1267358-9-usmanakinyemi202@gmail.com>
	<xmqqzfhyggzb.fsf@gitster.g>
	<CAPSxiM_fLNUvg86TtCHZTbsE_VnhKdMiDa3pfLPsLa3ThZfxmw@mail.gmail.com>
Date: Fri, 07 Mar 2025 06:15:31 -0800
Message-ID: <xmqqfrjpexks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

>> Hmph, if we are passing anything down to these code paths, I would
>> have expected that it would be an instance of "struct index_state".
>>
>> Do these two helper functions need anything other than that from the
>> repository instance?
> No, they do not. They could possibly do in the future and is there any
> reason why we might want to pass the "struct index_state" instead of
> the whole "struct repository" ?

You are asking a wrong question.

When there are two things, A and B, where B is a piece of data with
a smaller scope that is contained within A, unless your function
needs to access parts of A that is impossible to access if you fed
it only B, limiting the interface to the smallest piece necessary
(in this case, B) is always the better design.  A potential caller
that only has B and not A can still call your function that takes B
if you designed the API that way.  If you insist that the caller
pass A (and infer which B to use as part of A), a potential caller
that only has B cannot call your function.

So, with that understanding of a general principle in mind, you need
a stronger justification to pass the larger object A that goes
against the best practice, saying "Even though we do not have to
pass A because only B is necessary, we pass A because ...".  And you
just said there is no such reason why you need a repository and for
these functions an index_state is sufficient.

There are many functions that only need "struct index_state"
instance and obtains one from their callers.  They do not have a
repository object, other than the one that is referred to from the
index_state (to keep track of which repository it originated from).

But this pointer is not designed to round-trip.  There can be, and
there indeed are, code paths that use multiple index_state instances
associated with one repository.  But a repository instance has only
one ".index" member.  It means if you pass a repository, you are
making it impossible for your potential callers that has secondary
index_state instances.

