Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBED1E877
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204152; cv=none; b=fyp+4tpOMwt4cgpjLXmWJ+D4ePMezMar8r2IJbjeY88PyatrtJN5vXN/YJjYi8jKun93rGX7lPAKWHUlw4kjWP27MZKsP6GuXt8VyklOSd3nkimiW1FxFm/hrbGTAUbXKUkowty7qpZHdIWBc4WbtQ+r/2IRJg6X41rzJ3Z1MW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204152; c=relaxed/simple;
	bh=A6cfGQv9NGaVEv511NDxwSPIvs7vUa+q5umbq6Nbl0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B9Aajp0JsGIuPIu3ge0qy4Oq10feSJIifZJG9PULx9r4x0bTFVp5qbknQ1vgfdycnvf+dyC92lxn6f/6o7IGIxPbXYxs8+w8PhknxAaT8XpHtc39PSmT7AETIS99WdJK8lma/WXKsauGadybb1Cj/rC6bplZQECMhNc03aZSfZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jj3qV6iK; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jj3qV6iK"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 92A592904C;
	Mon, 15 Apr 2024 14:02:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=A6cfGQv9NGaVEv511NDxwSPIvs7vUa+q5umbq6
	Nbl0w=; b=jj3qV6iK/7+nj6QvpW3JCN9sjOSQutsasolV+vHSUP51Bq14vXq2nq
	+1VEenbSRNGL8QfFb97sphi7bbJ9HU+LixFhKOojmUEswkbD4tvas0drQ7WS1Cp2
	T3aFFUnraSxJuuYKftotWF9cbGd6dNPdBtTAIaMTsOmiB2TMOiCMU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A2D62904B;
	Mon, 15 Apr 2024 14:02:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9A0272904A;
	Mon, 15 Apr 2024 14:02:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Yehezkel Bernat via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Yehezkel Bernat <yehezkelshb@gmail.com>
Subject: Re: [PATCH] Documentation: fix linkgit reference
In-Reply-To: <ZhzVnnoBFt2nau4x@tanuki> (Patrick Steinhardt's message of "Mon,
	15 Apr 2024 09:22:06 +0200")
References: <pull.1706.git.git.1713132482976.gitgitgadget@gmail.com>
	<ZhzVnnoBFt2nau4x@tanuki>
Date: Mon, 15 Apr 2024 11:02:26 -0700
Message-ID: <xmqq4jc2o66l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 51FCADB6-FB52-11EE-BCA9-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Apr 14, 2024 at 10:08:02PM +0000, Yehezkel Bernat via GitGitGadget wrote:
>> From: Yehezkel Bernat <yehezkelshb@gmail.com>
>> 
>> In git-replay documentation, linkgit to git-rev-parse is missing the man
>> section which breaks its rendering
>> 
>> Add section number as done in other references to this command
>
> Nit: sentences should end with a dot.
>
>> Signed-off-by: Yehezkel Bernat <YehezkelShB@gmail.com>
>
> Other than that this patch looks good to me, thanks!
>
> Patrick

Thanks, both.  Will just tweak the proposed log message while
queuing.


>> ---
>>     Documentation: fix linkgit reference
>> 
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1706%2FYehezkelShB%2Fyb%2Ffix-linkgit-reference-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1706/YehezkelShB/yb/fix-linkgit-reference-v1
>> Pull-Request: https://github.com/git/git/pull/1706
>> 
>>  Documentation/git-replay.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
>> index f6c269c62d5..8f3300c683a 100644
>> --- a/Documentation/git-replay.txt
>> +++ b/Documentation/git-replay.txt
>> @@ -46,7 +46,7 @@ the new commits (in other words, this mimics a cherry-pick operation).
>>  	Range of commits to replay. More than one <revision-range> can
>>  	be passed, but in `--advance <branch>` mode, they should have
>>  	a single tip, so that it's clear where <branch> should point
>> -	to. See "Specifying Ranges" in linkgit:git-rev-parse and the
>> +	to. See "Specifying Ranges" in linkgit:git-rev-parse[1] and the
>>  	"Commit Limiting" options below.
>>  
>>  include::rev-list-options.txt[]
>> 
>> base-commit: 8f7582d995682f785e80e344197cc715e6bc7d8e
>> -- 
>> gitgitgadget
>> 
