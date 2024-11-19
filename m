Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23764139E
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 00:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976599; cv=none; b=W0RUfPNy4NPeHAMbrj2eYo6Je2l3zY5Z2MIuaTvkg3v2C4ylRGDgJiqAmEsV7wZjZr1A4s3BnLq8PuAKb1T87fmajhB7Xy81vhrRefG6mwruytyojE3f9fyRX4CzBAdRy3pauddTGcDJXF+O0TER2mXnD8SLsx01BNCUyDVBfsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976599; c=relaxed/simple;
	bh=lT9qkd+TWs6wVY/3CpKxPzeL4e8vaDK4QnByRUF/R5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rdtbxr9Kf6L6v2G8cuqzxw/rprJ7021XBMfaQXU4S3q12+1HLDrbKgI8IPjb0YenL/LLtO0tXbKy1jeLIK0+CGVTVg+VZ9D6SPFCcbJw2b2j+ZA+wfcuadrX4TmW2wugJ0CDw0TtpeXkSp9DAY5LGQy8uiqjA/a/tNwO5Ynaiv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fp6JhEWX; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fp6JhEWX"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 4023B1140165;
	Mon, 18 Nov 2024 19:36:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 18 Nov 2024 19:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731976596; x=
	1732062996; bh=7acbKo2BE7IJlF31F6xT6PDEK0eQTW1pwKOujmTyGvs=; b=F
	p6JhEWXHiPzfeXoY6/doM6VMsqRvPyvTkryXxNLHpk19iZb3OUUVvQQd5Nm52bg0
	S0q4Ox8qM97ku9Dj/2GNV6JJql+MR9DPs2sHiY2nshnMr76iXbdlTJuQCjHpAXpd
	cQnl9LN6E27dZeBpIpO92v8qMYJIaH68ImrC6pIfUuKx5OkW8FF5XdXNiy/6WHVP
	y9Ut1VbD91+qmsKv5CVjwHPsaZqHzDhz4L7btJvez83ecIxn2lvc5mYk2zjnKQWq
	TtewYS4hr3ZUhSRrcdbnKm6ucO25hv2uSbm6Rrr6QO487QDD523qStFFoLW5Wmdv
	ZVszy9EFxqoaXEYMst9IQ==
X-ME-Sender: <xms:k907Z3Wv9L01MQ5sUp1uHzR7i0GYqXuQr-LMamJgmtEz76at-c-85w>
    <xme:k907Z_nuozTVuQz28BvK5UezcwFnqqjuMbwaGixn3WLrLRU3jkQkQ-3m9mZtS69hU
    r6XipicjCTa9PbWAw>
X-ME-Received: <xmr:k907ZzbObOVhWpOI3YQlhi-ZL-8ao_yMHQ-zqloq7D1Y7LbYBPGeTFQQAoI0DJ74AcWcmXuJ3RjUc9ZEnfaqNKm9NjZnKQF_B2Mc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinh
    ihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:k907ZyW9Q6Oc63uaGVI0rgHLmMRBhlZYWKU-T42Y3-DG_syShhvHyw>
    <xmx:k907ZxmLJhD_daZacTQ8_KerrdRb0jxdWJMFjU7UzQBvSsomBSb0ug>
    <xmx:k907Z_dLVOs7ObVs29ChyEbyH4xf0temeh5T5HtzzXAue_6TsQCVSw>
    <xmx:k907Z7HTdZvtIMmmnXOCsHW068G_nt2y5XplUoQ503lNMedAbuTkcw>
    <xmx:lN07Z0u1VLsTTXKOe8rjytreXd5uRs64G-n-VL2JcCcDefRWOqvkIOss>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 19:36:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Usman Akinyemi via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] diff: update conflict handling for whitespace to
 issue a warning
In-Reply-To: <CAPSxiM-H378tKrnLqiTYaWbGb9fPitRzqVpBf+7+Tu03Th3UPg@mail.gmail.com>
	(Usman Akinyemi's message of "Mon, 18 Nov 2024 21:03:52 +0000")
References: <pull.1828.git.git.1731347396097.gitgitgadget@gmail.com>
	<pull.1828.v2.git.git.1731524467045.gitgitgadget@gmail.com>
	<xmqq4j4a8srw.fsf@gitster.g>
	<29c81cbc-3678-4b70-9e0e-c500186d159f@gmail.com>
	<xmqqbjyh5pa5.fsf@gitster.g>
	<CAPSxiM-H378tKrnLqiTYaWbGb9fPitRzqVpBf+7+Tu03Th3UPg@mail.gmail.com>
Date: Tue, 19 Nov 2024 09:36:34 +0900
Message-ID: <xmqqcyishxf1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> On Fri, Nov 15, 2024 at 12:11 AM Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> If we were to fix anything, it is to make sure that we die() before
>> producing a single line of output.  If you have a change to a path
>> whose "type" is without such a misconfigured attribute, that sorts
>> lexicographically earlier than another path with a change, with a
>> conflicting whitespace attribute, I suspect that with the way the
>> code is structured currently, we show the diff for the first path,
>> before realizing that the second path has an issue and then die.
>>
>> If we fix it, and then make sure that the die() message shows
>> clearly what attribute setting we did not like, that would be
>> sufficient to help users to locate the problem, fix it, and quickly
>> move on, no?
>
> Thanks for the review. From what I understand from your comment,
> we should leave it the way it was which was die right ?

Correct.  I do not think replacing die() with warning() without
doing anything else makes sense.  Making sure that we detect the
breakage before going half-way while producing a patch that touches
many paths may improve the end-user experience, though.

Thanks.
