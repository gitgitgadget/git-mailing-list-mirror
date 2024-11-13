Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45065C2FB
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 01:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460723; cv=none; b=D+SmH1UA8MPr/8oBdtNz8I63rqHZX1QtzYgHnKTEPPtKBlFhI7O1R4rl1klc7fCj7RNqk2E5vohcudv5d/QEE52CvxE6x2mF+N6ZKTWXDj98c5W4Z8mYgHp3n1HTIi18HRmZgsrDVQluX4h9+MKcU4cspMKQ+VIksGr0IhepMyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460723; c=relaxed/simple;
	bh=HEJtatFI6Zqz8vNgN+LzaExOJOHTugZc6ylJJkbnkHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=keq+5kRM8F7XCGWoFFh7SIXwZRCDOZMdlHiitutLGT0KltPP0Bv8SEpIBx7I3u9owIFLJmutl2WRJkBFaWJLHv4AAJoKBzwhqgwXqTvL64TnOHxS5g6zBFPPGtkb+NzaGQHtwDEhDaWC7srtpFskL2CsW6rOR8SnB9bhD37LB+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gx2AVY5U; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gx2AVY5U"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4CBD211400A1;
	Tue, 12 Nov 2024 20:18:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 12 Nov 2024 20:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731460719; x=1731547119; bh=bnu9O9zLikFLnEcJ3nZ8ITLhZ+mTCeDxkTm
	xevCbiQM=; b=gx2AVY5UdBgIFewVEqpN4MJWd8TJhVPZy3Hs7ODLFWSAc9xE9ue
	Y+8CFn59n/mSGH5ILnbF31kEXEMsyeu2IRcVdBQYC6hczDUKaHDaZt6f9MouFeep
	rzvjNlWY9n3/KF9kWZptU2d8s7N7mjRUwjXlflYXRvMuxMb5K+zLICqwXHN5hJIR
	aYH6TSUxjlTLzVyOEqlvWDjPUy7CrTZAn8glSORGkfc3FWORtoUEPjgbYjOqIUJT
	2wVNr1Cfy6ACsXBHROz3IMPAXFskYJJfcHU18BPYJ/bNM84LKbMsoz1f343f9vil
	1Y69+1sfkiPg0R4KX+Hj/9fMLmhUx+G5wnQ==
X-ME-Sender: <xms:bv4zZ0iSyQpg46UtXxgYe1s8hO0UyXgyB2Xveo20AptHkO5mmDsw7Q>
    <xme:bv4zZ9AUlkMgpsVnhz6qRMqkiMuvsA6fHeCN2K39JBL2Kv4HCUvgy90qhVujcCpdi
    1sX3U8uyHy9wQlfOA>
X-ME-Received: <xmr:bv4zZ8EUuiRCpry6mkJHNiPlyaN3Mg5tXaKuUMmk8Q7pWctKRVhCnSIip3J_tp-jN0OD8sEo067r6xhGtRqI1vy5ZLo8QJdPBZy4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehsthholh
    gvvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:b_4zZ1Sor5aAkUYWOygWOVdlR7BU1osvPC022nNUFV1noYQ57yoKqg>
    <xmx:b_4zZxzouTsn9P0lRv77cf_B2tC3fPaaWr-I4JPoKvya51FkmoPGbQ>
    <xmx:b_4zZz6YZzcOkvw_sbfcVm-Jie8clH8wqleSyLqt7Ofkty74PlrvDw>
    <xmx:b_4zZ-wXqTl_UzM0ak-VJpcN-o7qaCrdxBcZpBE9l9WyJj6rKxcnVQ>
    <xmx:b_4zZwxz7rVvDSbCW0BtqJ-fM_xZ7MjJtFz384WL7MGauyezp2dyZ4fe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 20:18:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  stolee@gmail.com,  phillip.wood123@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v2 1/3] sequencer: comment checked-out branch properly
In-Reply-To: <xmqqikss2b7l.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	13 Nov 2024 10:07:10 +0900")
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
	<cover.1731406513.git.code@khaugsbakk.name>
	<fc3b4438845e9fafd03fb608128099ce37ecd1b9.1731406513.git.code@khaugsbakk.name>
	<xmqqikss2b7l.fsf@gitster.g>
Date: Wed, 13 Nov 2024 10:18:37 +0900
Message-ID: <xmqq7c982aoi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> kristofferhaugsbakk@fastmail.com writes:
>
>> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
>> index 09f230eefb2..f61a717b190 100755
>> --- a/t/t3400-rebase.sh
>> +++ b/t/t3400-rebase.sh
>> @@ -456,4 +456,20 @@ test_expect_success 'rebase when inside worktree subdirectory' '
>>  	)
>>  '
>>  
>> +test_expect_success 'git rebase --update-ref with core.commentChar and branch on worktree' '
>> +	test_when_finished git branch -D base topic2 &&
>> +	test_when_finished git checkout main &&
>> +	test_when_finished git branch -D wt-topic &&
>> +	test_when_finished git worktree remove wt-topic &&
>> +	git checkout main &&
>> +	git checkout -b base &&
>> +	git checkout -b topic2 &&
>> +	test_commit msg2 &&
>> +	git worktree add wt-topic &&
>> +	git checkout base &&
>> +	test_commit msg3 &&
>> +	git checkout topic2 &&
>> +	git -c core.commentChar=% rebase --update-refs base
>> +'
>
> Can we improve this test a bit to give it more visibility into the
> breakage?
>
> I am sure that the internal machinery gets confused because it wants
> to skip commented out lines assuming '%' is used for comments, and
> fails to skip lines that are commented with '#', but it is a bit too
> opaque how this would break without the fix.  Perhaps add a line or
> two of a comment to the test to describe what the expected mode of
> failure is?

Something like "a line commented-out with '#' in the list of
instructions used internally by "rebase" is not recognised as a
comment and you'd get an error that says '#' is not a valid
instruction", perhaps.

