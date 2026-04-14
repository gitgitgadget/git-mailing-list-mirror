Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4BF3EDAD1
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188494; cv=none; b=QBT/gL0lYEAjHoIXrO/GhVzPJcSF0nvvxgRTWl7K2Jy0VW2c0HOa+s8Akn4ZBnHYPG3GfUpA1/j+VaA5fpVdA6l0l4UbSE1iszjmId932dkIHhU9EyTV+DEHiL9FywclIo9TzGB7TsDZEbiSsdPDSgPnNvu974U7FJfINjkZ2ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188494; c=relaxed/simple;
	bh=9GiZiaSNkWgaI3ZEsvvqtAKUGRDIoD4TZL/KdulSLhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MGZL6CBcawcs8Xf/MRDan6vEi3MD3zHY00wsEZUk9GxuhrVV90H/uLXrCcg4lqRKybzDiIa37/+pM1qNKgXTSKeoe+GaMr5T9z0aqosn5cqTmLqhnDcurSN6poH57UKIoayxuxIkWXpR3mrZgXrvkWlPs+HOOvduxhfPf9opTuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cAi3Tx1+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BRUwFdIm; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cAi3Tx1+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BRUwFdIm"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id CDE301D00140;
	Tue, 14 Apr 2026 13:41:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 14 Apr 2026 13:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776188491; x=1776274891; bh=xB+xfuj8Ew
	iKrOTs7A+LfMlE1YNZ6nW53/czVQl8MZY=; b=cAi3Tx1+daeeoCkNfVgUDKNo/H
	vEQBLwfu4gl7DRMU6Pmq6WaN4osFUG3qbAPZQVQC8wrd9Z81Fao1px0KkLxdFTm1
	RAZeBaHirnzqXdZDsRsho3vcrpV8HbZtR7heYlmH0Jza0F+ZP9xezf7zk9MODSd+
	akrVq0mhrBu5Wctl+LbmuA0ljX+qRVQQknBblGZC4OGJLMIE3swkG/PF60B27K5r
	bxe9xBIu01n3TtLDO33vHj9hcKSfHgh3wD49GLR5A80DmjXGYfnKcw2EgTq5eVyA
	yiNGJ+HlbGWqoACkrzw77gQKMHHuZ6Uf66kd+ZXC3J3vbWzo0mr8x+xn4xlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776188491; x=1776274891; bh=xB+xfuj8EwiKrOTs7A+LfMlE1YNZ6nW53/c
	zVQl8MZY=; b=BRUwFdIm1PBpBNd9YPLFsObY3PNgcM16yris6c9wKtl1FNhXOkl
	ntqkniOk2/nlOD3hJYhhLyG642BIV2jp3iG8/81nbPyCIcm1p8lVJB3Q25r9w8yt
	kCQ+2Fvne3XCrh6ElFg6/YQWGktQPieFFU2LqlvhaKIN7MZIzbwCFed3OamvjiOx
	k3g6SET/HwwIcLyGctmrc66AhcqEBtcVYEwZ9nCcnl5I9SrwSMOejQLxE8/XmnTp
	Xi08wQXuhFhIvdPJqbxKReQtkOxbVQgHOXmTUJczOiMlDOG+yZv3+Xg7emqvJhCL
	iCHYw5uqGuDSgUgInipX6tBkl7hKvFxCFig==
X-ME-Sender: <xms:S3zeaQJlVnZOVCXye0OyCFK9BhslKoKSSCZYcGRP-cevbebPwXmWwA>
    <xme:S3zeaXKOjz56LzYkmqL3eazOnvXHUPavViY2kDBwfSDvzAPuM2Jf5x9jFzk2vIQdt
    VDLXy9tatQY3k1r3YU15RDg-DdEUx385gw1GwypQuBY3RIe-NeTNA>
X-ME-Received: <xmr:S3zeaVsgHDjoh_LgCnoxAKJs016V4496Y2WSVxBW6MXJ5ANyBdePZaUZf5NkkL6k7xBNuRssmNjjvy9W8TxTi5la2ATCCKMI_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeetgffgvedvheehuedthfeljeevteefleelkeetueefgfekjedvgeefheehvdeg
    udenucffohhmrghinhepohhpvghnghhrohhuphdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:S3zeacSWD8BNP8LcZ_KuZVWMSKmvxiDjHLAGN5t2-PMI7TEWpnDVwA>
    <xmx:S3zeaTN_CGqQB9efsqptLvsS4zUVjA9WWKFV7Fz1gqNFe3Hi1mduzA>
    <xmx:S3zeaZZIgJOxFnhfHI2YmF4vkw_HZFUbnAFeTQj3EN8rnhEKIHzm4Q>
    <xmx:S3zeaVy_CJV-vPXMpr_yVQTOdAAnBkxyuazz9zwWGnSI4gMeL8AncA>
    <xmx:S3zeaYqMgKtVbrZ33HSzqetr7fIQteohHb9Dc2Z-zdpn3vcwhEh1UvUU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 13:41:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 02/12] t: prepare `test_must_fail ()` for `set -e`
In-Reply-To: <20260414062345.GA2902286@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 14 Apr 2026 02:23:45 -0400")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-2-5b83763a0e84@pks.im>
	<20260414062345.GA2902286@coredump.intra.peff.net>
Date: Tue, 14 Apr 2026 10:41:29 -0700
Message-ID: <xmqq5x5tbfsm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Apr 13, 2026 at 11:49:23AM +0200, Patrick Steinhardt wrote:
>
>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> index f3af10fb7e..f8bc77619b 100644
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -1195,8 +1195,12 @@ test_must_fail () {
>>  		echo >&7 "test_must_fail: only 'git' is allowed: $*"
>>  		return 1
>>  	fi
>> -	"$@" 2>&7
>> -	exit_code=$?
>> +	if "$@" 2>&7
>> +	then
>> +		exit_code=0
>> +	else
>> +		exit_code=$?
>> +	fi
>
> One subtle interaction here is that the command in "$@" will be run with
> "set -e" suppressed if it's a shell function (even if the body
> explicitly says "set -e").
>
> I think it's mostly academic since we don't tend to use "set -e" in the
> tests at all, but it may be an eventual gotcha.

Yeah, ugly, but this is tricky that they felt the need to explain it
with an example in the informative section X-<.

"set" is described in

  https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html#tag_19_26

and the description for "-e" does not even talk about any function.
The application usage notes associated with the "set" gives this

    Application writers should avoid relying on set -e within
    functions. For example, in the following script:

    set -e
    start() {
        some_server
        echo some_server started successfully
    }
    start || echo >&2 some_server failed

    the -e setting is ignored within the function body (because the
    function is a command in an AND-OR list other than the
    last). Therefore, if some_server fails, the function carries on to
    echo "some_server started successfully", and the exit status of the
    function is zero (which means "some_server failed" is not output).

which greatly helps.
