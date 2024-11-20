Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33EB1798F
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732064956; cv=none; b=DBcZb+RW+0Fk1lgLy/3Q8YmehpwKYBdVSXWgGl8VI9ZgqUbHL16suwyJURfOtFnPmZeVSlwfiQS3H+FcmXKblanh2GL69ar2KbAvlNV0jilIF79tyGIdhJ4SvUs4zKAaWOXjLZiVL1OvM2RxhSVEZ88IzXDecpesLvCdfCBNCnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732064956; c=relaxed/simple;
	bh=mUPWkXuYgTMTY+Ebp5vbeStFEPd6TIaQ8O4v2QPd/cA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CUgD25Q0wdQkJNXFzrU82qqC3kwfGy9CsBht674hLI8iDGbR+muYIqJ8B92ZNRWiGrG7TS+5YEiIj7RYjoWUIazw3d3Y5BijQJDBUGpvZx0ekJpyDzLZ7Xraj6rlbcSOIg9+BTEMJvKPFHQXGhBzt+dNLOcQuCEsCyJXRES5Ag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P2HKAtwy; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P2HKAtwy"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 825DE2540203;
	Tue, 19 Nov 2024 20:09:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 19 Nov 2024 20:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1732064952; x=1732151352; bh=V6PQTVMAwQVG9sfDIrMN3hcZ2N1eDv1zMJo
	i1s+X7jI=; b=P2HKAtwyjWQfptWGUrTrP0iIZdPOLPjjozqRkhbpkg2a+eK552D
	wvL36AJpl2koQymbAuMlq0xL4+T9Yqo7QmJ5GhPffvowD6iRmzP8W2qUD17eCR7i
	8D63gSDmtOUlX039zOIOw5WdUgmsvVc0filJDuDoV/+anJPqR+EV1Y22BDX8ha7g
	blz1jiXuDDgdprHL+BKLqA1qmMXQnYJKv42xTqzvj9mZveQ+E20EE/T934uHTrQa
	hNgP3km8THIeGqkf5qj5rtRa6BRA2Jx337qpDpURN0xlygD/VB26aoDlrjN20FLp
	wbY2UUfRp13hDfEjEg1Al5LMOy00FRC8ZgA==
X-ME-Sender: <xms:uDY9Z6_HjbG6K7MVfD65VGOX1CIj4pT9aAKIKvJ1PYKMLmc51A3OUw>
    <xme:uDY9Z6tbDxp5lT7BWJevSPyaTvheKvJ3oPBgr8F06wYFN_uGgFk_s0_5kxzx_xQ6k
    7iKibTP8zQ4A6hlEw>
X-ME-Received: <xmr:uDY9ZwAC6qdKFDAd4TVlmCX7fRwdv09mCghBToCjpTrcH5dBEa0DXisMz3ap7LMIQ_35dmqYgzHm5_XHbcD7Cx5sP5uDUDAl37J3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhhomhhsoh
    hnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgv
    sehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uDY9ZydGUtlk2gjLxrP54lVAVeRQlbTiOJ3Dy2heoniOx_b_d1eyGQ>
    <xmx:uDY9Z_OsRi3LQwnmoeQi7_bQLdufqZ40tQJZr75MosnSRTbPyqOzCg>
    <xmx:uDY9Z8mRZHEBrESL7hVeQLhtTNkZ135GL-yZRvTKRosMrMGsacXYaQ>
    <xmx:uDY9Zxs6tsi1nwSl0VbqGmvZxfeY_0e-N_k9_Anj9lc0btsRkvOY0Q>
    <xmx:uDY9Z6cmg1jO3HHPIquOMxpRlFpxxUCxG8c7mj6HPbjHl0CpXR2n1gZE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 20:09:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Edward Thomson
 <ethomson@edwardthomson.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 0/7] reftable: stop using Git subsystems
In-Reply-To: <CAOLa=ZSbj966S+kXtyr-1iJ3eqnDvDt=vN1kfPsSAFaAENmOJw@mail.gmail.com>
	(karthik nayak's message of "Tue, 19 Nov 2024 14:23:56 +0000")
References: <cover.1729677003.git.ps@pks.im> <cover.1731943954.git.ps@pks.im>
	<CAOLa=ZSbj966S+kXtyr-1iJ3eqnDvDt=vN1kfPsSAFaAENmOJw@mail.gmail.com>
Date: Wed, 20 Nov 2024 10:09:10 +0900
Message-ID: <xmqq5xoibtjd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

karthik nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
> [snip]
>
>> Range-diff against v2:
>> 1:  2b7d4e28529 = 1:  2b7d4e28529 reftable/system: move "dir.h" to its only user
>> 2:  38cfe85bf5b = 2:  38cfe85bf5b reftable: explicitly handle hash format IDs
>> 3:  745c1a070dd = 3:  745c1a070dd reftable/system: stop depending on "hash.h"
>> 4:  7782652b975 = 4:  7782652b975 reftable/stack: stop using `fsync_component()` directly
>> 5:  b15daefbc83 ! 5:  430be1045d6 reftable/system: provide thin wrapper for tempfile subsystem
>>     @@ reftable/system.h: license that can be found in the LICENSE file or at
>>      +
>>      +/*
>>      + * Rename the temporary file to the provided path. The temporary file must be
>>     -+ * active. Return 0 on success, a reftable error code on error.
>>     ++ * active. Return 0 on success, a reftable error code on error. Deactivates the
>>     ++ * temporary file.
>>      + */
>>      +int tmpfile_rename(struct reftable_tmpfile *t, const char *path);
>>
>> 6:  83949837a29 = 6:  b9ffdc605b9 reftable/stack: drop only use of `get_locked_file_path()`
>> 7:  80fe5bc5e10 = 7:  e1ac1cc2e67 reftable/system: provide thin wrapper for lockfile subsystem
>
> Post my previous review, this range diff looks good. Thanks

Thanks, both.  Queued.
